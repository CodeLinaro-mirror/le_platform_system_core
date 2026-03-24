#! /bin/sh
# Copyright (c) 2009-2021, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# Changes from Qualcomm Technologies, Inc. are provided under the following license:
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear

echo "4 4 1 4" > /proc/sys/kernel/printk
sleep 6
echo mem > /sys/power/autosleep
echo 500 > /proc/sys/kernel/threads-max
if [ -f /etc/init.qti.debug.sh ]; then
    /etc/init.qti.debug.sh
fi

echo -n "Started post boot settings " > /dev/kmsg

#disable watermark boost
echo 0 > /proc/sys/vm/watermark_boost_factor
echo -n "Watermark boost is disabled" > /dev/kmsg

# Throttle prefetching of block devices to avoid excessive memory consumption
function throttle_block_device {
    echo -n "throttling /sys/block/$1" > /dev/kmsg
    if [ -e "/sys/block/$1" ]; then
        echo 0 > "/sys/block/$1/queue/rotational"
        echo 128 > "/sys/block/$1/queue/read_ahead_kb"
        if [ -e "/sys/block/$1/queue/nr_requests" ]; then
            # dm-# blocks do not have this file
            echo 31 > "/sys/block/$1/queue/nr_requests"
        fi
    else
        echo -n "/sys/block/$1 does not exist on bootup" > /dev/kmsg
    fi
}
throttle_block_device "vda"
throttle_block_device "vdb"
# throttle the dm-verity driver too if it exists
system_blk="$(dmsetup info system -c --noheadings -o blkdevname)"
if [ $? -eq 0 ]; then
    throttle_block_device "$system_blk"
    echo 0 > /sys/module/dm_verity/parameters/prefetch_cluster
fi

#ftrace
tracefs=/sys/kernel/debug/tracing

#SPI
mkdir $tracefs/instances/spi_qup
echo 2 > $tracefs/instances/spi_qup/buffer_size_kb
echo 1 > $tracefs/instances/spi_qup/events/qup_spi_trace/enable
echo 1 > $tracefs/instances/spi_qup/tracing_on

#I2C
mkdir $tracefs/instances/i2c_qup
echo 2 > $tracefs/instances/i2c_qup/buffer_size_kb
echo 1 > $tracefs/instances/i2c_qup/events/qup_i2c_trace/enable
echo 1 > $tracefs/instances/i2c_qup/tracing_on

#GENI_COMMON
#mkdir $tracefs/instances/qupv3_common
#echo 2 > $tracefs/instances/qupv3_common/buffer_size_kb
#echo 1 > $tracefs/instances/qupv3_common/events/qup_common_trace/enable
#echo 1 > $tracefs/instances/qupv3_common/tracing_on
