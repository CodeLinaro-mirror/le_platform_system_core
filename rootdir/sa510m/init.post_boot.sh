#! /bin/sh
# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
ddr_type2="02"
ddr_type4="07"


# configure governor settings for silver cluster
echo "ondemand" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo 288000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

# configure bus-dcvs
bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

for device in $bus_dcvs/*
do
	cat $device/hw_min_freq > $device/boost_freq
done

for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
do
    if [ ${ddr_type:1:2} == $ddr_type2 ]; then
       echo "762 1720 2086 2597 3879 5931 6515 7980 8136" > $ddrbw/mbps_zones
    elif [ ${ddr_type:1:2} == $ddr_type4 ]; then
       echo "762 1720 2086 2597 3879 5931 6515 7980 8136" > $ddrbw/mbps_zones
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

#set deep as default suspend mode
echo mem > /sys/power/autosleep

#Enable LPM
echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled

echo "++++ $0 -> done sched settings" > /dev/kmsg

