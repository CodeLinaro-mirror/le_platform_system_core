/*
 * ---------------------------------------------------------------------------
 * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
 * SPDX-License-Identifier: BSD-3-Clause-Clear.
 * ---------------------------------------------------------------------------
 *
 */

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <blkid/blkid.h>
#include "disk_symlink.h"

int get_dev_by_partname(char *part_name, char *disk_path, int disk_path_len)
{
    char *devname;
    int ret = 0;

    blkid_cache cache = NULL;
    if (blkid_get_cache(&cache, NULL) < 0) {
        DISK_SYMLINK_LOG_ERR("blkid get cache fail,err:%s\n", strerror(errno));
        ret = -1;
        goto out;
    }

    devname = blkid_get_devname(cache, "PART_ENTRY_NAME", part_name);
    if (!devname) {
        /*with PARTLABEL try again*/
        devname = blkid_get_devname(cache, "PARTLABEL", part_name);
    }

    if (!devname) {
        DISK_SYMLINK_LOG_ERR("blkid get devname by PARTLABEL for partname %s fail,err: %s\n", part_name, strerror(errno));
        ret = -1;
        goto out;
    }

    snprintf(disk_path, disk_path_len-1, "%s", devname);
    free(devname);

out:
    if (cache)
        blkid_put_cache(cache);
    return ret;
}

int read_part_by_name(char *part_name, void *buf, size_t read_size)
{
    char devname[MAX_PATH_NAME_LEN] = {0};
    ssize_t read_bytes;
    int fd;

    if (-1 == get_dev_by_partname(part_name, devname, MAX_PATH_NAME_LEN)) {
        DISK_SYMLINK_LOG_ERR("get dev by partname %s fail\n", part_name);
        return -1;
    }

    fd = open(devname, O_RDONLY | O_LARGEFILE);
    if (fd < 0) {
        DISK_SYMLINK_LOG_ERR("open devname %s fail,err: %s\n", devname, strerror(errno));
        return -1;
    }

    read_bytes = read(fd, buf, read_size);
    if ((read_bytes < 0) || ((size_t)read_bytes < read_size)) {
        DISK_SYMLINK_LOG_ERR("read from part %s fail,err: %s\n", part_name, strerror(errno));
        close(fd);
        return -1;
    }

    close(fd);
    return 0;
}
