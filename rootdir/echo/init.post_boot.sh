#! /bin/sh

# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. 
# SPDX-License-Identifier: BSD-3-Clause-Clear

if [ -f /sys/devices/soc0/soc_id ]; then
    platformid=`cat /sys/devices/soc0/soc_id`
fi

ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
ddr_type4="07"
ddr_type5="08"

# Reset the RT boost, which is 1024 (max) by default.
echo 0 > /proc/sys/kernel/sched_util_clamp_min_rt_default

# configure governor settings for silver cluster
echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo 691200 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

# configure bus-dcvs
bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

for device in $bus_dcvs/*
do
	cat $device/hw_min_freq > $device/boost_freq
done

for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
do
    if [ ${ddr_type:4:2} == $ddr_type4 ]; then
       echo "762 1720 2086 2597 3879 5931 6515 7980 8136" > $ddrbw/mbps_zones
    elif [ ${ddr_type:4:2} == $ddr_type5 ]; then
       echo "1720 2086 2929 3879 5931 6515 7980 12191" > $ddrbw/mbps_zones
    fi
    echo 4 > $ddrbw/sample_ms
    echo 68 > $ddrbw/io_percent
    echo 20 > $ddrbw/hist_memory
    echo 80 > $ddrbw/down_thres
    echo 0 > $ddrbw/guard_band_mbps
    echo 250 > $ddrbw/up_scale
    echo 1600 > $ddrbw/idle_mbps
    echo 48 > $ddrbw/window_ms
done

echo "++++ $0 -> done sched settings" > /dev/kmsg

# Disabling proactive compaction since there is no benefit of higher order
# pages here hence proactive compaction activity would be wasteful.
echo 0 > /proc/sys/vm/compaction_proactiveness

# set the io-scheduler default to bfq on all mq support devices
echo "bfq" > /sys/class/block/mmcblk0/queue/scheduler
echo "bfq" > /sys/class/block/mmcblk1/queue/scheduler

# update io-scheduler tunables
echo 0 > /sys/class/block/mmcblk0/queue/iosched/slice_idle
echo 0 > /sys/class/block/mmcblk1/queue/iosched/slice_idle

# enable CPUidle and auto suspend
echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
echo mem > /sys/power/autosleep
