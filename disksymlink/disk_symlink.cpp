/*
 * ---------------------------------------------------------------------------
 * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 * SPDX-License-Identifier: BSD-3-Clause-Clear.
 * ---------------------------------------------------------------------------
 *
 */
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <sys/types.h>
#include <unistd.h>
#include "vm_config.h"
#include "disk_symlink.h"


#define SLOT_SUFFIX_STRLEN   (sizeof("androidboot.slot_suffix=_") - sizeof(char))
#define KERNEL_CMDLINE       ("/proc/cmdline")
#define CMDLINE_LEN          (4096)

typedef struct disk_symlink_message {
  char misc_partname[MAX_PART_NAME_LEN];
  char part_prefix[MAX_PART_NAME_LEN];
  char symlnk_path[MAX_PART_NAME_LEN];
} disk_symlink_t;

static disk_symlink_t g_disk_symlink[] = {
   {"",           "dsp_",              "/dev/disk/by-partlabel/dsp"          },
   {"",           "modem_",            "/dev/disk/by-partlabel/modem"        },
   {"",           "bluetooth_",        "/dev/disk/by-partlabel/bluetooth"    },
   {"",           "keymaster_",        "/dev/disk/by-partlabel/keymaster"    },
   {"lv_misc",    "lv_bootloader_",    "/dev/disk/by-partlabel/lv_bootloader"},
   {"la_misc",    "la_bootloader_",    "/dev/disk/by-partlabel/la_bootloader"},
   {"",           "la_init_boot_",     "/dev/disk/by-partlabel/la_init_boot" },
   {"",           "la_vendor_boot_",   "/dev/disk/by-partlabel/la_vendor_boot"},
   {"",           "la_dtbo_",          "/dev/disk/by-partlabel/la_dtbo"      },
   {"",           "la_boot_",          "/dev/disk/by-partlabel/la_boot"      },
   {"",           "la_vbmeta_",        "/dev/disk/by-partlabel/la_vbmeta"    },
   {"",           "la_v_boot_",        "/dev/disk/by-partlabel/la_v_boot"    },
   {"",           "la_vb_sys_",        "/dev/disk/by-partlabel/la_vb_sys"    },
   {"",           "lv_dtbo_",          "/dev/disk/by-partlabel/lv_dtbo"      },
   {"",           "lv_boot_",          "/dev/disk/by-partlabel/lv_boot"      },
   {"",           "lv_vbmeta_",        "/dev/disk/by-partlabel/lv_vbmeta"    },
   {"",           "lv_system_",        "/dev/disk/by-partlabel/lv_system"    },
};

typedef struct disk_symlink_no_slot_message {
  char part_label[MAX_PART_NAME_LEN];
  char symlnk_path[MAX_PART_NAME_LEN];
} disk_symlink_no_slot_t;

static disk_symlink_no_slot_t g_disk_symlink_no_slot[] = {
   {"lv_bootloader_a",    "/dev/disk/by-partlabel/lv_bootloader_a"},
   {"la_bootloader_a",    "/dev/disk/by-partlabel/la_bootloader_a"},
   {"la_init_boot_a",     "/dev/disk/by-partlabel/la_init_boot_a" },
   {"la_vendor_boot_a",   "/dev/disk/by-partlabel/la_vendor_boot_a"},
   {"la_dtbo_a",          "/dev/disk/by-partlabel/la_dtbo_a"      },
   {"la_boot_a",          "/dev/disk/by-partlabel/la_boot_a"      },
   {"la_vbmeta_a",        "/dev/disk/by-partlabel/la_vbmeta_a"    },
   {"la_v_boot_a",        "/dev/disk/by-partlabel/la_v_boot_a"    },
   {"la_vb_sys_a",        "/dev/disk/by-partlabel/la_vb_sys_a"    },
   {"lv_dtbo_a",          "/dev/disk/by-partlabel/lv_dtbo_a"      },
   {"lv_boot_a",          "/dev/disk/by-partlabel/lv_boot_a"      },
   {"lv_vbmeta_a",        "/dev/disk/by-partlabel/lv_vbmeta_a"    },
   {"lv_system_a",        "/dev/disk/by-partlabel/lv_system_a"    },
   {"bluetooth_a",        "/dev/disk/by-partlabel/bluetooth_a"    },
   {"modem_a",            "/dev/disk/by-partlabel/modem_a"        },
   {"dsp_a",              "/dev/disk/by-partlabel/dsp_a"          },

   {"lv_bootloader_b",    "/dev/disk/by-partlabel/lv_bootloader_b"},
   {"la_bootloader_b",    "/dev/disk/by-partlabel/la_bootloader_b"},
   {"la_init_boot_b",     "/dev/disk/by-partlabel/la_init_boot_b" },
   {"la_vendor_boot_b",   "/dev/disk/by-partlabel/la_vendor_boot_b"},
   {"la_dtbo_b",          "/dev/disk/by-partlabel/la_dtbo_b"      },
   {"la_boot_b",          "/dev/disk/by-partlabel/la_boot_b"      },
   {"la_vbmeta_b",        "/dev/disk/by-partlabel/la_vbmeta_b"    },
   {"la_v_boot_b",        "/dev/disk/by-partlabel/la_v_boot_b"    },
   {"la_vb_sys_b",        "/dev/disk/by-partlabel/la_vb_sys_b"    },
   {"lv_dtbo_b",          "/dev/disk/by-partlabel/lv_dtbo_b"      },
   {"lv_boot_b",          "/dev/disk/by-partlabel/lv_boot_b"      },
   {"lv_vbmeta_b",        "/dev/disk/by-partlabel/lv_vbmeta_b"    },
   {"lv_system_b",        "/dev/disk/by-partlabel/lv_system_b"    },
   {"bluetooth_b",        "/dev/disk/by-partlabel/bluetooth_b"    },
   {"modem_b",            "/dev/disk/by-partlabel/modem_b"        },
   {"dsp_b",              "/dev/disk/by-partlabel/dsp_b"          },

   {"la_devinfo",         "/dev/disk/by-partlabel/la_devinfo"   },
   {"la_metadata",        "/dev/disk/by-partlabel/la_metadata"  },
   {"la_misc",            "/dev/disk/by-partlabel/la_misc"      },
   {"la_persist",         "/dev/disk/by-partlabel/la_persist"   },
   {"la_super",           "/dev/disk/by-partlabel/la_super"     },
   {"la_userdata",        "/dev/disk/by-partlabel/la_userdata"  },
   {"lv_devinfo",         "/dev/disk/by-partlabel/lv_devinfo"   },
   {"lv_firmware",        "/dev/disk/by-partlabel/lv_firmware"  },
   {"lv_misc",            "/dev/disk/by-partlabel/lv_misc"      },
   {"lv_persist",         "/dev/disk/by-partlabel/lv_persist"   },
   {"lv_userdata",        "/dev/disk/by-partlabel/lv_userdata"  },
};

blkid_cache g_blkid_cache = NULL;
static int g_slot_switch_config = -1;
static char g_slot_suffix = '\0';

static int get_slot_suffix_from_cmdline(void)
{
   char *key_val_pair = NULL;
   ssize_t read_bytes = 0;
   char *cmdline = NULL;
   char *saveptr = NULL;
   int ret = -1;
   int fd = -1;

   fd = open(KERNEL_CMDLINE, O_RDONLY, 0);
   if ( fd == -1) {
      DISK_SYMLINK_LOG_ERR("open %s fail,err: %s\n", KERNEL_CMDLINE, strerror(errno));
      return ret;
   }

   cmdline = (char *)malloc(CMDLINE_LEN + 1);
   if (!cmdline) {
      DISK_SYMLINK_LOG_ERR("malloc fail\n");
      goto out;
   }

   read_bytes = read(fd, cmdline, CMDLINE_LEN);
   if ( read_bytes == -1) {
      DISK_SYMLINK_LOG_ERR("read %s fail, err: \n", KERNEL_CMDLINE);
      goto out1;
   }

   // Ensure cmdline is null-terminated
   if (read_bytes >= CMDLINE_LEN) {
      read_bytes = CMDLINE_LEN - 1;
   }
   cmdline[read_bytes] = '\0';

   key_val_pair = strtok_r(cmdline, " ", &saveptr);

   while (key_val_pair != NULL) {
      if (!(strncmp(key_val_pair, "androidboot.slot_suffix=_", SLOT_SUFFIX_STRLEN))) {
         if ((key_val_pair[SLOT_SUFFIX_STRLEN] != 'a') && (key_val_pair[SLOT_SUFFIX_STRLEN] != 'b')) {
            DISK_SYMLINK_LOG_ERR("slot %c from %s error\n", key_val_pair[SLOT_SUFFIX_STRLEN], KERNEL_CMDLINE);
            break;
         } else {
            g_slot_suffix = key_val_pair[SLOT_SUFFIX_STRLEN];
            ret = 0;
            break;
         }
      }

      key_val_pair = strtok_r(NULL, " ", &saveptr);
   }

out1:
   if(cmdline) {
      free(cmdline);
   }
out:
   close(fd);
   return ret;
}

static int get_slot_switch_config (void)
{
   int slot_switch_config;
   int vm_index = 0;
   uint32_t vmid;

   if (vm_config_init()) {
      DISK_SYMLINK_LOG_ERR("Vmm config init fail\n");
      return -1;
   }

   if (vm_config_get_vmid(vm_index, &vmid)) {
      DISK_SYMLINK_LOG_ERR("Get vmid from vm_config file fail\n");
      return -1;
   }

   slot_switch_config = vm_config_get_slot_switch_config(vmid);
   if ((1 != slot_switch_config) && (2 != slot_switch_config)) {
      DISK_SYMLINK_LOG_ERR("Get slot switch config %d from vm_config file fail\n", slot_switch_config);
      return -1;
   }

   return slot_switch_config;
}

static int get_from_miscpart (char *misc_partname, char *part_prefix, char *partname_slot, size_t buf_size)
{
   misc_partition_t misc_partition;
   memset(&misc_partition, 0, sizeof(misc_partition));

   if (-1 == read_part_by_name(misc_partname, (void *)&misc_partition, sizeof(misc_partition))) {
      DISK_SYMLINK_LOG_ERR("Failed to read the %s partition\n", misc_partname);
      return -1;
   }

   if ((misc_partition.reserved[0] != 'a') && (misc_partition.reserved[0] != 'b')) {
      DISK_SYMLINK_LOG_ERR("Current slot %c of %s partition error\n", misc_partition.reserved[0], misc_partname);
      return -1;
   }

   snprintf(partname_slot, buf_size-1, "%s%c", part_prefix, misc_partition.reserved[0]);
   return 0;
}

static int get_partname_with_slot (char *misc_partname, char *part_prefix, char *partname_slot, size_t buf_size)
{
   int ret = 0;

   if (0 == strlen(misc_partname)) {
      snprintf(partname_slot, buf_size-1, "%s%c", part_prefix, g_slot_suffix);
   } else {
      if (2 == g_slot_switch_config) {
         ret = get_from_miscpart (misc_partname, part_prefix, partname_slot, buf_size);
      } else {
         snprintf(partname_slot, buf_size-1, "%s%c", part_prefix, g_slot_suffix);
      }
   }

   return ret;
}

static int create_partlabel_symlink (char *misc_partname, char *part_prefix, char *symlnk_path)
{
   char partname_slot[MAX_PART_NAME_LEN] = {0};
   char dev_name[MAX_PATH_NAME_LEN] = {0};

   if (get_partname_with_slot (misc_partname, part_prefix, partname_slot, MAX_PART_NAME_LEN) == -1) {
      DISK_SYMLINK_LOG_ERR("Failed to get the part name with slot,part_prefix %s\n", part_prefix);
      return -1;
   }

   if (-1 == get_dev_by_partname(partname_slot, dev_name, MAX_PATH_NAME_LEN)) {
      DISK_SYMLINK_LOG_ERR("Failed to get device for %s, part_prefix %s\n", partname_slot, part_prefix);
      return -1;
   }

   //DISK_SYMLINK_LOG_ERR("Create symlink(partname_slot %s) %s to %s \n", partname_slot, symlnk_path, dev_name);

   if (symlink (dev_name, symlnk_path) < 0) {
      DISK_SYMLINK_LOG_ERR("Create symlink %s to %s fail: %s\n", symlnk_path, dev_name, strerror(errno));
      return -1;
   }

   return 0;
}

static int create_symlink_no_slot_suffix (char *part_label, char *symlnk_path)
{
   char dev_name[MAX_PATH_NAME_LEN] = {0};

   if (-1 == get_dev_by_partname(part_label, dev_name, MAX_PATH_NAME_LEN)) {
      DISK_SYMLINK_LOG_ERR("Failed to get device for part_label %s\n", part_label);
      return -1;
   }

   DISK_SYMLINK_LOG_ERR("Create symlink %s to %s \n", symlnk_path, dev_name);

   if (symlink (dev_name, symlnk_path) < 0) {
      DISK_SYMLINK_LOG_ERR("Create symlink %s to %s fail: %s\n", symlnk_path, dev_name, strerror(errno));
      return -1;
   }

   return 0;
}

int main(int argc, char *argv[])
{
   int count_no_slot = sizeof(g_disk_symlink_no_slot) / sizeof(g_disk_symlink_no_slot[0]);
   int count = sizeof(g_disk_symlink) / sizeof(g_disk_symlink[0]);
   int i = 0;
   int j = 0;

   mkdir ("/dev/disk", 0755);
   mkdir ("/dev/disk/by-partlabel", 0755);

   if (blkid_get_cache(&g_blkid_cache, NULL) < 0) {
      DISK_SYMLINK_LOG_ERR("Blkid get cache fail,err:%s\n", strerror(errno));
      return 0;
   }

   for (j = 0; j < count_no_slot; j++) {
      if (-1 == create_symlink_no_slot_suffix (g_disk_symlink_no_slot[j].part_label, g_disk_symlink_no_slot[j].symlnk_path))
      {
         DISK_SYMLINK_LOG_ERR("Create partlabel symlink for path %s fail\n", g_disk_symlink_no_slot[j].symlnk_path);
      }
   }

   g_slot_switch_config = get_slot_switch_config();

   if (get_slot_suffix_from_cmdline() < 0){
      DISK_SYMLINK_LOG_ERR("Get slot suffix fail\n");
      return 0;
   }

   for (i = 0; i < count; i++) {
      if (-1 == create_partlabel_symlink (g_disk_symlink[i].misc_partname, g_disk_symlink[i].part_prefix, g_disk_symlink[i].symlnk_path))
      {
         DISK_SYMLINK_LOG_ERR("Create partlabel symlink for path %s fail\n", g_disk_symlink[i].symlnk_path);
      }
   }

   if (g_blkid_cache)
      blkid_put_cache(g_blkid_cache);
   g_slot_switch_config = -1;
   return 0;
}
