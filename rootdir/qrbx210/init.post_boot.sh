#! /bin/sh
# Copyright (c) 2021, The Linux Foundation. All rights reserved.
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
#
#=============================================================================

# Empty file
if [ -f /sys/module/drm/parameters/vblankoffdelay ]; then
    echo 0 > /sys/module/drm/parameters/vblankoffdelay
fi

# Disable Core control on silver
echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

# Core control parameters for gold
if [ -d "/sys/devices/system/cpu/cpu4/" ]; then
echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
echo 40 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
echo 4 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres
if [ -d "/sys/devices/system/cpu/cpu7/" ]; then
echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
echo 1 0 0 0 > /sys/devices/system/cpu/cpu4/core_ctl/not_preferred
else
echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
echo 1 0 > /sys/devices/system/cpu/cpu4/core_ctl/not_preferred
fi

elif [ -d "/sys/devices/system/cpu/cpu5/" ]; then
echo 1 > /sys/devices/system/cpu/cpu5/core_ctl/min_cpus
echo 60 > /sys/devices/system/cpu/cpu5/core_ctl/busy_up_thres
echo 40 > /sys/devices/system/cpu/cpu5/core_ctl/busy_down_thres
echo 100 > /sys/devices/system/cpu/cpu5/core_ctl/offline_delay_ms
echo 4 > /sys/devices/system/cpu/cpu5/core_ctl/task_thres
echo 1 0 > /sys/devices/system/cpu/cpu5/core_ctl/not_preferred

elif [ -d "/sys/devices/system/cpu/cpu6/" ]; then
echo 1 > /sys/devices/system/cpu/cpu6/core_ctl/min_cpus
echo 60 > /sys/devices/system/cpu/cpu6/core_ctl/busy_up_thres
echo 40 > /sys/devices/system/cpu/cpu6/core_ctl/busy_down_thres
echo 100 > /sys/devices/system/cpu/cpu6/core_ctl/offline_delay_ms
echo 4 > /sys/devices/system/cpu/cpu6/core_ctl/task_thres
echo 1 0 > /sys/devices/system/cpu/cpu6/core_ctl/not_preferred
fi

# Controls how many more tasks should be eligible to run on gold CPUs
# w.r.t number of gold CPUs available to trigger assist (max number of
# tasks eligible to run on previous cluster minus number of CPUs in
# the previous cluster).
#
# Setting to 1 by default which means there should be at least
# 5 tasks eligible to run on gold cluster (tasks running on gold cores
# plus misfit tasks on silver cores) to trigger assitance from gold+.
#echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh

# Setting b.L scheduler parameters
echo 65 > /proc/sys/walt/sched_downmigrate
echo 71 > /proc/sys/walt/sched_upmigrate
echo 100 > /proc/sys/walt/sched_group_upmigrate
echo 85 > /proc/sys/walt/sched_group_downmigrate
echo 1 > /proc/sys/walt/sched_walt_rotate_big_tasks
echo 400000000 > /proc/sys/walt/sched_coloc_downmigrate_ns
echo 39000000 39000000 39000000 39000000 39000000 39000000 39000000 39000000 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_ns
echo 248 > /proc/sys/walt/sched_coloc_busy_hysteresis_enable_cpus
echo 10 10 10 10 10 10 10 10 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_busy_pct
echo 8500000 8500000 8500000 8500000 8500000 8500000 8500000 8500000 > /proc/sys/walt/sched_util_busy_hyst_cpu_ns
echo 255 > /proc/sys/walt/sched_util_busy_hysteresis_enable_cpus
echo 1 1 1 1 1 1 1 1 > /proc/sys/walt/sched_util_busy_hyst_cpu_util
echo 40 > /proc/sys/walt/sched_cluster_util_thres_pct
echo 0 > /proc/sys/walt/sched_idle_enough

#Set early upmigrate tunables
nr_cpus=`grep -c processor /proc/cpuinfo`
if [ $nr_cpus -gt 4 ]; then
freq_to_migrate=1228800
silver_fmax=`cat /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq`
silver_early_upmigrate="$((1024 * $silver_fmax / $freq_to_migrate))"
silver_early_downmigrate="$((((1024 * $silver_fmax) / (((10*$freq_to_migrate) - $silver_fmax) / 10))))"
sched_upmigrate=`cat /proc/sys/walt/sched_upmigrate`
sched_downmigrate=`cat /proc/sys/walt/sched_downmigrate`
sched_upmigrate=${sched_upmigrate:0:2}
sched_downmigrate=${sched_downmigrate:0:2}
gold_early_upmigrate="$((1024 * 100 / $sched_upmigrate))"
gold_early_downmigrate="$((1024 * 100 / $sched_downmigrate))"
echo $silver_early_downmigrate $gold_early_downmigrate > /proc/sys/walt/sched_early_downmigrate
echo $silver_early_upmigrate $gold_early_upmigrate > /proc/sys/walt/sched_early_upmigrate
fi

# set the threshold for low latency task boost feature which prioritize
# binder activity tasks
echo 325 > /proc/sys/walt/walt_low_latency_task_threshold

# cpuset parameters
echo 0-3 > /dev/cpuset/background/cpus
echo 0-3 > /dev/cpuset/system-background/cpus

# Turn off scheduler boost at the end
echo 0 > /proc/sys/walt/sched_boost

# Reset the RT boost, which is 1024 (max) by default.
echo 0 > /proc/sys/kernel/sched_util_clamp_min_rt_default

# configure governor settings for silver cluster
echo "walt" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/down_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/up_rate_limit_us
echo 1516800 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
echo 691200 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpufreq/policy0/walt/pl
echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/rtg_boost_freq

# configure input boost settings
echo 1190000 0 0 0 0 0 0 0 > /proc/sys/walt/input_boost/input_boost_freq
echo 80 > /proc/sys/walt/input_boost/input_boost_ms

# configure governor settings for gold cluster
echo "walt" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/down_rate_limit_us
echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/up_rate_limit_us
echo 1344000 > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_freq
echo 1056000 > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
echo 1 > /sys/devices/system/cpu/cpufreq/policy4/walt/pl
echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/rtg_boost_freq

# configure bus-dcvs
bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

for device in $bus_dcvs/*
do
	cat $device/hw_min_freq > $device/boost_freq
done

for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
do
	echo "762 2086 2929 3879 5931 6881 7980" > $ddrbw/mbps_zones
	echo 4 > $ddrbw/sample_ms
	echo 85 > $ddrbw/io_percent
	echo 20 > $ddrbw/hist_memory
	echo 0 > $ddrbw/hyst_length
	echo 80 > $ddrbw/down_thres
	echo 0 > $ddrbw/guard_band_mbps
	echo 250 > $ddrbw/up_scale
	echo 1600 > $ddrbw/idle_mbps
	echo 2092000 > $ddrbw/max_freq
done

echo s2idle > /sys/power/mem_sleep
echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
