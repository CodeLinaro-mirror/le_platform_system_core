/*
 * Copyright (C) 2014 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define TRACE_TAG TRACE_ADB

#include "sysdeps.h"

#include <fcntl.h>
#include <inttypes.h>
#include <stdarg.h>
#include <stdio.h>
#include <sys/stat.h>

#include "cutils/properties.h"

#include "bootimg.h"
#include "adb.h"
#include "adb_io.h"
#include "ext4_sb.h"
#include "fs_mgr.h"
#include "remount_service.h"

#include <stddef.h>
#define FSTAB_PREFIX "/fstab."
#define VERITY_METADATA_SIZE 32768
#define MAX_CMDLINE_LEN 512

#define VBMETA_A_DEVICE_PATH "/dev/disk/by-partlabel/vbmeta_a"
#define VBMETA_B_DEVICE_PATH "/dev/disk/by-partlabel/vbmeta_b"
#define VBMETA_DEVICE_PATH "/dev/disk/by-partlabel/vbmeta"
#define KERNEL_CMDLINE "/proc/cmdline"
#define CMDLINE_SIZE 2048

struct fstab *fstab;

#ifdef ALLOW_ADBD_DISABLE_VERITY
static const bool kAllowDisableVerity = true;
#else
static const bool kAllowDisableVerity = false;
#endif

static int get_target_device_size(int fd, const char *blk_device,
                                  uint64_t *device_size)
{
    int data_device;
    struct ext4_super_block sb;
    struct fs_info info;

    info.len = 0;  /* Only len is set to 0 to ask the device for real size. */

    data_device = adb_open(blk_device, O_RDONLY | O_CLOEXEC);
    if (data_device < 0) {
        WriteFdFmt(fd, "Error opening block device (%s)\n", strerror(errno));
        return -1;
    }

    if (lseek64(data_device, 1024, SEEK_SET) < 0) {
        WriteFdFmt(fd, "Error seeking to superblock\n");
        adb_close(data_device);
        return -1;
    }

    if (adb_read(data_device, &sb, sizeof(sb)) != sizeof(sb)) {
        WriteFdFmt(fd, "Error reading superblock\n");
        adb_close(data_device);
        return -1;
    }

    ext4_parse_sb(&sb, &info);

    /* SYSTEM_SIZE : system partition size; FEC_SIZE:fec image size; VERITY_METADATA_SIZE : index to the metadata magic number */
    *device_size =  SYSTEM_SIZE - FEC_SIZE - VERITY_METADATA_SIZE ;

    adb_close(data_device);
    return 0;
}

static int modify_string(char *str, char *orig, char *newstr)
{
    char *p = NULL;
    unsigned int i;
    if(!(p = strstr(str, orig)))  // Is 'orig' even in 'str'?
        return -1;

    for (i=0; i < strlen(newstr); i++) {
        *p++ = newstr[i];
    }
    return 0;
}
/* Turn verity on/off */
static int set_verity_enabled_state(int fd, const char *block_device,
                                    const char* mount_point, bool enable)
{
    int device = -1;
    int retval = -1;
    char cmdline[MAX_CMDLINE_LEN]= {};
    char old_verity[] = "verity=";
    char new_verity[] = "noveri=";
    unsigned int offset = 0;
    int result = 0;
    boot_img_hdr hdr;

    if (!make_block_device_writable(block_device)) {
        WriteFdFmt(fd, "Could not make block device %s writable (%s).\n",
                   block_device, strerror(errno));
        goto errout;
    }

    device = adb_open(block_device, O_RDWR | O_CLOEXEC);
    if (device == -1) {
        WriteFdFmt(fd, "Could not open block device %s (%s).\n", block_device, strerror(errno));
        WriteFdFmt(fd, "Maybe run adb remount?\n");
        goto errout;
    }

    if (adb_read(device, &hdr, sizeof(hdr)) != sizeof(hdr)) {
        WriteFdFmt(fd, "Couldn't read device!\n");
        goto errout;
    }

    strlcpy(cmdline, hdr.cmdline, sizeof(cmdline));
    /*overwrite "verity=" to "noveri" */
    result = modify_string(cmdline, old_verity, new_verity);
    if (result == -1) {
        WriteFdFmt(fd, "Verity args are not present.\n");
        goto errout;
    }
    /*Find the offset of cmdline member in boot_img_hdr structure */
    offset = offsetof(struct boot_img_hdr, cmdline);
    if (lseek64(device, offset, SEEK_SET) < 0) {
        WriteFdFmt(fd, "Could not seek to start of verity metadata block.\n");
        goto errout;
    }

    if (adb_write(device, &cmdline, sizeof(cmdline)) != sizeof(cmdline)) {
        WriteFdFmt(fd, "Could not set verity %s flag on device %s with error %s\n",
                   enable ? "enabled" : "disabled",
                   block_device, strerror(errno));
        goto errout;
    }
    WriteFdFmt(fd, "Verity %s on %s\n", enable ? "enabled" : "disabled", mount_point);
    retval = 0;
errout:
    if (device != -1)
        adb_close(device);
    return retval;
}

void set_verity_enabled_state_service_le(int fd, void* cookie)
{
    FILE *fp;
    char slot[3]= {};
    bool enable = (cookie != NULL);
    if (kAllowDisableVerity) {
	bool any_changed = false;
        fp = popen("getslotsuffix", "r");
        if (fp == NULL) {
            WriteFdFmt(fd, "failed to get slot\n");
            exit(1);
        }
        if (fgets(slot, sizeof(slot), fp) != NULL) {
            WriteFdFmt(fd, "slot is %s\n", slot);
        }
        if (strcmp(slot, "_a") == 0) {
            if (!set_verity_enabled_state(fd, "/dev/block/bootdevice/by-name/boot_a", "/",
                                              enable)) {
                    any_changed = true;
            }
        }
        else if (strcmp(slot, "_b") == 0) {
            if (!set_verity_enabled_state(fd, "/dev/block/bootdevice/by-name/boot_b", "/",
                                              enable)) {
                    any_changed = true;
            }
        }
        else {
            if (!set_verity_enabled_state(fd, "/dev/block/bootdevice/by-name/boot", "/",
                                              enable)) {
                    any_changed = true;
            }
        }
        if (any_changed) {
            WriteFdFmt(fd, "Now reboot your device for settings to take effect\n");
        }
    }
    else {
        WriteFdFmt(fd, "%s-verity only works for userdebug builds\n",
                   enable ? "enable" : "disable");
    }
}

/* Converts unsigned integer from big-endian to host byte order. */
static uint32_t _be32toh(uint32_t in) {
  uint8_t* b = (uint8_t*)&in;
  uint32_t out;
  out = ((uint32_t)b[0]) << 24;
  out |= ((uint32_t)b[1]) << 16;
  out |= ((uint32_t)b[2]) << 8;
  out |= ((uint32_t)b[3]);
  return out;
}

/* Converts unsigned integer from host to big-endian byte order. */
static uint32_t _htobe32(uint32_t in) {
  union {
    uint32_t i;
    uint8_t b[4];
  } out;
  out.b[0] = (in >> 24) & 0xff;
  out.b[1] = (in >> 16) & 0xff;
  out.b[2] = (in >> 8) & 0xff;
  out.b[3] = in & 0xff;
  return out.i;
}

void set_verity_enabled_state_service_avb20(int fd, void* cookie)
{
    FILE *fp;
    bool enable = (cookie != NULL);
    int device = -1;
    const int vbmeta_hdr_size = 256;
    const int vbmeta_hdr_flags_offset = 120;
    uint32_t vbmeta_hashtree_disable_mask = 0x1;
    uint32_t flags, new_flags = 0;
    bool hashtree_disable_flag;
    char vbmeta_hdr[vbmeta_hdr_size];
    char propbuf[PROPERTY_VALUE_MAX];
    bool any_changed = false;
    char *cmdline = NULL;

    if (kAllowDisableVerity) {
#ifndef ADB_VERITY
        property_get("vbmeta.device", propbuf, "");
        if (!strcmp(propbuf, "")) {
            WriteFdFmt(fd, "vbmeta.device property not available.\n");
            goto errout;
        }

        device = adb_open(propbuf, O_RDWR | O_CLOEXEC);
        if (device == -1) {
            WriteFdFmt(fd, "Could not open block device %s (%s).\n", propbuf, strerror(errno));
            goto errout;
        }
#else
        char *slot = NULL;
        char *match = NULL;
        char *save_ptr = NULL;
        device = adb_open(KERNEL_CMDLINE, O_RDONLY | O_CLOEXEC);
        if (device < 0) {
            WriteFdFmt(fd, "Couldn't open kernel cmdline!\n");
            goto errout;
        }
        cmdline = (char *)malloc(CMDLINE_SIZE + 1);
        if (!cmdline) {
            WriteFdFmt(fd, "Failed to allocate memory!\n");
            goto errout;
        }
        memset(cmdline, '\0', CMDLINE_SIZE + 1);
        device = adb_read(device, cmdline, CMDLINE_SIZE);
        if (device < 0) {
             WriteFdFmt(fd, "Couldn't read kernel cmdline!\n");
             goto errout;
        }
        match = (char *)strstr(cmdline, "androidboot.slot_suffix=");
        if (!match) {
             WriteFdFmt(fd, "Couldn't find slot_suffix!\n");
             goto errout;
        }
        match = match + strlen("androidboot.slot_suffix=");
        slot = strtok_r(match, " \t\n\r", &save_ptr);

        if (slot == NULL)  goto errout;

        if (strcmp(slot, "_a") == 0) {
            device = adb_open(VBMETA_A_DEVICE_PATH, O_RDWR | O_CLOEXEC);
            if (device < 0) {
                WriteFdFmt(fd, "Couldn't open vbmeta device!\n");
                WriteFdFmt(fd, "Maybe run adb root?\n");
                goto errout;
            }
        }
        else if (strcmp(slot, "_b") == 0) {
            device = adb_open(VBMETA_B_DEVICE_PATH, O_RDWR | O_CLOEXEC);
            if (device < 0) {
                WriteFdFmt(fd, "Couldn't open vbmeta device!\n");
                WriteFdFmt(fd, "Maybe run adb root?\n");
                goto errout;
            }
        }
        else {
            device = adb_open(VBMETA_DEVICE_PATH, O_RDWR | O_CLOEXEC);
            if (device < 0) {
                WriteFdFmt(fd, "Couldn't open vbmeta device!\n");
                WriteFdFmt(fd, "Maybe run adb root?\n");
                goto errout;
            }
        }
#endif
        if (adb_read(device, &vbmeta_hdr[0], sizeof(vbmeta_hdr)) != sizeof(vbmeta_hdr)) {
            WriteFdFmt(fd, "Couldn't read device!\n");
            goto errout;
        }

        flags = _be32toh(*(uint32_t*)&vbmeta_hdr[vbmeta_hdr_flags_offset]);
        hashtree_disable_flag = (bool)(flags & vbmeta_hashtree_disable_mask);

        if (hashtree_disable_flag & enable || !hashtree_disable_flag & !enable) {
            any_changed = true;
        }

        if (any_changed) {
            if (enable) {
                // Enable verity by clearing HASHTREE_DISABLE_FLAG
                new_flags = flags & ~vbmeta_hashtree_disable_mask;
            }
            else {
                // Disable verity by setting HASHTREE_DISABLE_FLAG
                new_flags = flags | vbmeta_hashtree_disable_mask;
            }
            new_flags = _htobe32(new_flags);

            if (lseek64(device, vbmeta_hdr_flags_offset, SEEK_SET) < 0) {
                WriteFdFmt(fd, "Could not seek to flags offset in vbmeta.\n");
                goto errout;
            }

            if (adb_write(device, &new_flags, sizeof(new_flags)) != sizeof(new_flags)) {
                WriteFdFmt(fd, "Could not set verity %s flag on device %s with error %s\n",
                           enable ? "enabled" : "disabled",
                           propbuf, strerror(errno));
                goto errout;
            }

            WriteFdFmt(fd, "Verity %s \n", enable ? "enabled" : "disabled");
            WriteFdFmt(fd, "Now reboot your device for settings to take effect\n");
        } else {
            WriteFdFmt(fd, "Verity is already %s \n", enable ? "enabled" : "disabled");
        }

    } else {
        WriteFdFmt(fd, "%s-verity only works for userdebug builds\n",
                   enable ? "enable" : "disable");
    }

errout:
    if (device != -1) {
        fsync(device);
        adb_close(device);
        adb_close(fd);
        if (cmdline)
            free(cmdline);
    }
}

void set_verity_enabled_state_service(int fd, void* cookie)
{
    bool enable = (cookie != NULL);
    if (kAllowDisableVerity) {
        char fstab_filename[PROPERTY_VALUE_MAX + sizeof(FSTAB_PREFIX)];
        char propbuf[PROPERTY_VALUE_MAX];
        int i;
        bool any_changed = false;

        property_get("ro.secure", propbuf, "0");
        if (strcmp(propbuf, "1")) {
            WriteFdFmt(fd, "verity not enabled - ENG build\n");
            goto errout;
        }

        property_get("ro.debuggable", propbuf, "0");
        if (strcmp(propbuf, "1")) {
            WriteFdFmt(fd, "verity cannot be disabled/enabled - USER build\n");
            goto errout;
        }

        property_get("ro.hardware", propbuf, "");
        snprintf(fstab_filename, sizeof(fstab_filename), FSTAB_PREFIX"%s",
                 propbuf);

        fstab = fs_mgr_read_fstab(fstab_filename);
        if (!fstab) {
            WriteFdFmt(fd, "Failed to open %s\nMaybe run adb root?\n", fstab_filename);
            goto errout;
        }

        /* Loop through entries looking for ones that vold manages */
        for (i = 0; i < fstab->num_entries; i++) {
            if(fs_mgr_is_verified(&fstab->recs[i])) {
                if (!set_verity_enabled_state(fd, fstab->recs[i].blk_device,
                                              fstab->recs[i].mount_point,
                                              enable)) {
                    any_changed = true;
                }
           }
        }

        if (any_changed) {
            WriteFdFmt(fd, "Now reboot your device for settings to take effect\n");
        }
    } else {
        WriteFdFmt(fd, "%s-verity only works for userdebug builds\n",
                   enable ? "enable" : "disable");
    }

errout:
    adb_close(fd);
}
