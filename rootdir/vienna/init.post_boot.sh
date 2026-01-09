#!/bin/sh
#=============================================================================
# Copyright (c) 2009-2012, 2014-2019, The Linux Foundation. All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# Changes from Qualcomm Technologies, Inc. are provided under the following license:
#
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#=============================================================================

function configure_read_ahead_kb_values() {
        MemTotalStr=`cat /proc/meminfo | grep MemTotal`
        MemTotal=${MemTotalStr:16:8}

        dmpts=$(ls /sys/block/*/queue/read_ahead_kb | grep -e dm -e mmc -e sd)
        # dmpts holds below read_ahead_kb nodes if exists:
        # /sys/block/dm-0/queue/read_ahead_kb to /sys/block/dm-10/queue/read_ahead_kb
        # /sys/block/sda/queue/read_ahead_kb to /sys/block/sdh/queue/read_ahead_kb

        # Set 128 for <= 4GB &
        # set 512 for >= 5GB targets.
        if [ $MemTotal -le 4194304 ]; then
                ra_kb=128
        else
                ra_kb=512
        fi
        if [ -f /sys/block/mmcblk0/bdi/read_ahead_kb ]; then
                echo $ra_kb > /sys/block/mmcblk0/bdi/read_ahead_kb
        fi
        if [ -f /sys/block/mmcblk0rpmb/bdi/read_ahead_kb ]; then
                echo $ra_kb > /sys/block/mmcblk0rpmb/bdi/read_ahead_kb
        fi
        for dm in $dmpts; do
                if [ `cat $(dirname $dm)/../removable` -eq 0 ]; then
                        echo $ra_kb > $dm
                fi
        done
}

function configure_min_free_kbytes()
{
        MemTotalStr=`cat /proc/meminfo | grep MemTotal`
        MemTotal=${MemTotalStr:16:8}
        let RamSizeGB="( $MemTotal / 1048576 ) + 1"

        # Set the min_free_kbytes to standard kernel value
        if [ $RamSizeGB -ge 8 ]; then
                MinFreeKbytes=11584
        elif [ $RamSizeGB -ge 4 ]; then
                MinFreeKbytes=8192
        elif [ $RamSizeGB -ge 2 ]; then
                MinFreeKbytes=5792
        else
                MinFreeKbytes=4096
        fi

        # We store min_free_kbytes into a vendor property so that the PASR
        # HAL can read and set the value for it.
        echo $MinFreeKbytes > /proc/sys/vm/min_free_kbytes
        setprop vendor.memory.min_free_kbytes $MinFreeKbytes
}

function configure_memory_parameters() {
        configure_read_ahead_kb_values
        # Enabling or disabling thp will reset the value of min_free_kbytes
        # Call configure_min_free_kbytes after
        configure_min_free_kbytes

        echo 100 > /proc/sys/vm/swappiness

        # Disable periodic kcompactd wakeups. We do not use THP, so having many
        # huge pages is not as necessary.
        echo 0 > /proc/sys/vm/compaction_proactiveness

        #Set per-app max kgsl reclaim limit and per shrinker call limit
        if [ -f /sys/class/kgsl/kgsl/page_reclaim_per_call ]; then
                echo 38400 > /sys/class/kgsl/kgsl/page_reclaim_per_call
        fi
        if [ -f /sys/class/kgsl/kgsl/max_reclaim_limit ]; then
                echo 51200 > /sys/class/kgsl/kgsl/max_reclaim_limit
        fi
}
configure_memory_parameters

if [ -f /sys/devices/soc0/soc_id ]; then
	platformid=`cat /sys/devices/soc0/soc_id`
fi

case "$platformid" in
	"669"|"670")
		/bin/sh /etc/init.qti.kernel.debug-vienna.sh
		/bin/sh /etc/init.kernel.post_boot-vienna.sh
		;;
	*)
		echo "***WARNING***: Invalid SoC ID\n\t No postboot settings applied!!\n"
		;;
esac
