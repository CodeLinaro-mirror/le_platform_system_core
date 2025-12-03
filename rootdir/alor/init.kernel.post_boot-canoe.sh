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
#
# Changes from Qualcomm Technologies, Inc. are provided under the following license:
#
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#=============================================================================

rev=`cat /sys/devices/soc0/revision`

# Configure RT parameters:
# Long running RT task detection is confined to consolidated builds.
# Set RT throttle runtime to 50ms more than long running RT
# task detection time.
# Set RT throttle period to 100ms more than RT throttle runtime.
long_running_rt_task_ms=1200
sched_rt_runtime_ms=`expr $long_running_rt_task_ms + 50`
sched_rt_runtime_us=`expr $sched_rt_runtime_ms \* 1000`
sched_rt_period_ms=`expr $sched_rt_runtime_ms + 100`
sched_rt_period_us=`expr $sched_rt_period_ms \* 1000`
echo $sched_rt_period_us > /proc/sys/kernel/sched_rt_period_us
echo $sched_rt_runtime_us > /proc/sys/kernel/sched_rt_runtime_us

if [ -d /proc/sys/walt ]; then

        # Core control parameters for silver
	echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
	echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
	echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
        echo 60 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
        echo 30 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
        echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
        echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/task_thres
        echo 0 1 1 1 > /sys/devices/system/cpu/cpu0/core_ctl/not_preferred

        # Core control parameters for gold+
	echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/enable
        echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
        echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
        echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
        echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
        echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres
        echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/not_preferred

        echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/enable
        echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/enable

        # Configure Single Boost Thread
        echo 0 > /proc/sys/walt/sched_sbt_delay_windows
        echo 0x00 > /proc/sys/walt/sched_sbt_pause_cpus

        # Setting b.L scheduler parameters
        echo 95 85 > /proc/sys/walt/cluster0/sched_background_updownmigrate
        echo 95 85 > /proc/sys/walt/cluster0/sched_foreground_updownmigrate
        echo 95 85 > /proc/sys/walt/cluster0/sched_other_cgroup_updownmigrate
        echo 95 85 > /proc/sys/walt/cluster0/sched_topapp_updownmigrate

        # By setting group upmigrate/downmigrate to 0, colocation is disabled.
        echo 0 > /proc/sys/walt/sched_group_downmigrate
        echo 0 > /proc/sys/walt/sched_group_upmigrate
        echo 1 > /proc/sys/walt/sched_walt_rotate_big_tasks
        echo 400000000 > /proc/sys/walt/sched_coloc_downmigrate_ns
        echo 8500000 2000000 2000000 2000000 2000000 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_ns
        echo 255 > /proc/sys/walt/sched_coloc_busy_hysteresis_enable_cpus
        echo 10 95 95 95 95 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_busy_pct
        echo 8500000 2000000 2000000 2000000 2000000 > /proc/sys/walt/sched_util_busy_hyst_cpu_ns
        echo 255 > /proc/sys/walt/sched_util_busy_hysteresis_enable_cpus
        echo 30 15 15 15 15 > /proc/sys/walt/sched_util_busy_hyst_cpu_util
        echo 40 > /proc/sys/walt/sched_cluster_util_thres_pct
        echo 30 > /proc/sys/walt/sched_idle_enough
        echo 10 > /proc/sys/walt/sched_ed_boost

 #Set early upmigrate tunables
        sched_upmigrate=`cat /proc/sys/walt/sched_upmigrate`
        sched_downmigrate=`cat /proc/sys/walt/sched_downmigrate`
        sched_upmigrate=${sched_upmigrate:0:2}
        sched_downmigrate=${sched_downmigrate:0:2}
        gold_early_upmigrate=`expr \( 1024 \* 100 \) \/ $sched_upmigrate`
        gold_early_downmigrate=`expr \( 1024 \* 100 \) \/ $sched_downmigrate`
        echo $gold_early_downmigrate > /proc/sys/walt/sched_early_downmigrate
        echo $gold_early_upmigrate > /proc/sys/walt/sched_early_upmigrate

        # Enable Gold CPUs for pipeline
        echo 56 > /proc/sys/walt/sched_pipeline_cpus

        # set the threshold for low latency task boost feature which prioritize
        # binder activity tasks
        echo 325 > /proc/sys/walt/walt_low_latency_task_threshold


        # Turn off scheduler boost at the end
        echo 0 > /proc/sys/walt/sched_boost

        # configure input boost settings
        if [ $rev == "1.0" ] || [ $rev == "1.1" ]; then
                echo 960000 0 0 0 0 > /proc/sys/walt/input_boost/input_boost_freq
        else
                echo 960000 0 0 0 0 > /proc/sys/walt/input_boost/input_boost_freq
        fi
        echo 100 > /proc/sys/walt/input_boost/input_boost_ms

        echo "walt" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
        echo "walt" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor

        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/down_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/up_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/down_rate_limit_us
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/up_rate_limit_us

        echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/pl
        echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/pl

        if [ $rev == "1.0" ] || [ $rev == "1.1" ]; then
                echo 249600 > /sys/devices/system/cpu/cpufreq/policy0/walt/rtg_boost_freq
                echo 960000 > /sys/devices/system/cpu/cpufreq/policy4/walt/rtg_boost_freq
                echo 1036800 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
                echo 1440000 > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_freq
                echo 8500000 8500000 8500000 8500000 8500000 > /proc/sys/walt/sched_util_busy_hyst_cpu_ns
                echo 0 0 0 0 0 > /proc/sys/walt/sched_util_busy_hyst_cpu_util
        else
                echo 249600 > /sys/devices/system/cpu/cpufreq/policy0/walt/rtg_boost_freq
                echo 960000 > /sys/devices/system/cpu/cpufreq/policy4/walt/rtg_boost_freq
                echo 1036800 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
                echo 1440000 > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_freq
        fi
else
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
        echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
        echo 1 > /proc/sys/kernel/sched_pelt_multiplier
fi

if [ $rev == "1.0" ] || [ $rev == "1.1" ]; then
        echo 249600 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
        echo 268800 > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
else
        echo 249600 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
        echo 268800 > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
fi

# Reset the RT boost, which is 1024 (max) by default.
echo 0 > /proc/sys/kernel/sched_util_clamp_min_rt_default

# configure bus-dcvs
bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

for device in $bus_dcvs/*
do
        cat $device/hw_min_freq > $device/boost_freq
done

for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
do
        echo "762 1721 2087 5163 5932 6518 7983 10437 12158 14062 16133" > $ddrbw/mbps_zones
        echo 4 > $ddrbw/sample_ms
        echo 120 > $ddrbw/io_percent
        echo 20 > $ddrbw/hist_memory
        echo 5 > $ddrbw/hyst_length
        echo 1 > $ddrbw/idle_length
        echo 30 > $ddrbw/down_thres
        echo 0 > $ddrbw/guard_band_mbps
        echo 250 > $ddrbw/up_scale
        echo 1600 > $ddrbw/idle_mbps
        echo 4224000 > $ddrbw/max_freq
        echo 70 > $ddrbw/ab_scale
        echo 40 > $ddrbw/window_ms
done

for latfloor in $bus_dcvs/*/*latfloor
do
        echo 25000 > $latfloor/ipm_ceil
done

for qosgold in $bus_dcvs/DDRQOS/*gold
do
        echo 50 > $qosgold/ipm_ceil
done

echo s2idle > /sys/power/mem_sleep

echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled

echo 4 > /proc/sys/kernel/printk

# Change console log level as per console config property
console_config=`getprop persist.vendor.console.silent.config`
case "$console_config" in
	"1")
		echo "Enable console config to $console_config"
		echo 0 > /proc/sys/kernel/printk
	;;
	*)
		echo "Enable console config to $console_config"
	;;
esac

setprop vendor.post_boot.parsed 1
