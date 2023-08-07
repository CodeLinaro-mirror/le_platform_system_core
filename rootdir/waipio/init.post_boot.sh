#! /bin/sh
#
# Copyright (c) 2012-2013, 2016-2021, The Linux Foundation. All rights reserved.
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
#Changes from Qualcomm Innovation Center are provided under the following license:
#Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
#SPDX-License-Identifier: BSD-3-Clause-Clear

echo -n "Starting init_post_boot: "

if [ -f /sys/devices/soc0/machine ]; then
    target=`cat /sys/devices/soc0/machine | tr [:upper:] [:lower:]`
else
    target=`getprop ro.board.platform`
fi

if [ -f /etc/init.qti.debug.sh ]; then
    /etc/init.qti.debug.sh
fi

function configure_read_ahead_kb_values() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    # Set 128 for <= 3GB &
    # set 512 for >= 4GB targets.
    if [ $MemTotal -le 3145728 ]; then
        echo 128 > /sys/block/sda/queue/read_ahead_kb
    else
        echo 512 > /sys/block/sda/queue/read_ahead_kb
    fi
}

function disable_core_ctl() {
    if [ -f /sys/devices/system/cpu/cpu0/core_ctl/enable ]; then
        echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
    else
        echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/disable
    fi
}

function enable_swap() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    SWAP_ENABLE_THRESHOLD=1048576
    swap_enable=`getprop ro.vendor.qti.config.swap`

    # Enable swap initially only for 1 GB targets
    if [ "$MemTotal" -le "$SWAP_ENABLE_THRESHOLD" ] && [ "$swap_enable" == "true" ]; then
        # Static swiftness
        echo 1 > /proc/sys/vm/swap_ratio_enable
        echo 70 > /proc/sys/vm/swap_ratio

        # Swap disk - 200MB size
        if [ ! -f /data/vendor/swap/swapfile ]; then
            dd if=/dev/zero of=/data/vendor/swap/swapfile bs=1m count=200
        fi
        mkswap /data/vendor/swap/swapfile
        swapon /data/vendor/swap/swapfile -p 32758
    fi
}

function configure_memory_parameters() {
    # Set Memory parameters.
    #
    # Set per_process_reclaim tuning parameters
    # All targets will use vmpressure range 50-70,
    # All targets will use 512 pages swap size.
    #
    # Set Low memory killer minfree parameters
    # 32 bit Non-Go, all memory configurations will use 15K series
    # 32 bit Go, all memory configurations will use uLMK + Memcg
    # 64 bit will use Google default LMK series.
    #
    # Set ALMK parameters (usually above the highest minfree values)
    # vmpressure_file_min threshold is always set slightly higher
    # than LMK minfree's last bin value for all targets. It is calculated as
    # vmpressure_file_min = (last bin - second last bin ) + last bin
    #
    # Set allocstall_threshold to 0 for all targets.
    #

if [ "$target" == "waipio" ] ; then
    configure_read_ahead_kb_values
    echo 0 > /proc/sys/vm/page-cluster
    echo 100 > /proc/sys/vm/swappiness
    # Disable periodic kcompactd wakeups. We do not use THP, so having many
    # huge pages is not as necessary.
    #disable proactive compaction
    echo 0 > /proc/sys/vm/compaction_proactiveness
fi
}

case "$target" in
    "waipio")
    rev=`cat /sys/devices/soc0/revision`

    # Core control parameters for gold
    echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
    echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
    echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
    echo 3 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

    # Core control parameters for gold+
    echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/min_cpus
    echo 60 > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
    echo 30 > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
    echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/task_thres

    # Controls how many more tasks should be eligible to run on gold CPUs
    # w.r.t number of gold CPUs available to trigger assist (max number of
    # tasks eligible to run on previous cluster minus number of CPUs in
    # the previous cluster).
    #
    # Setting to 1 by default which means there should be at least
    # 4 tasks eligible to run on gold cluster (tasks running on gold cores
    # plus misfit tasks on silver cores) to trigger assitance from gold+.
    echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh

    # Disable Core control on silver
    echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

    # Setting b.L scheduler parameters
    echo 95 95 > /proc/sys/walt/sched_upmigrate
    echo 85 85 > /proc/sys/walt/sched_downmigrate
    echo 100 > /proc/sys/walt/sched_group_upmigrate
    echo 85 > /proc/sys/walt/sched_group_downmigrate
    echo 1 > /proc/sys/walt/sched_walt_rotate_big_tasks
    echo 400000000 > /proc/sys/walt/sched_coloc_downmigrate_ns
    echo 39000000 39000000 39000000 39000000 39000000 39000000 39000000 5000000 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_ns
    echo 240 > /proc/sys/walt/sched_coloc_busy_hysteresis_enable_cpus
    echo 10 10 10 10 10 10 10 95 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_busy_pct
    echo 5000000 5000000 5000000 5000000 5000000 5000000 5000000 2000000 > /proc/sys/walt/sched_util_busy_hyst_cpu_ns
    echo 255 > /proc/sys/walt/sched_util_busy_hysteresis_enable_cpus
    echo 15 15 15 15 15 15 15 15 > /proc/sys/walt/sched_util_busy_hyst_cpu_util

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
    if [ $rev == "1.0" ]; then
	    echo 1190400 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    else
	    echo 1267200 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    fi
    echo 614400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy0/walt/pl

    # configure input boost settings
    if [ $rev == "1.0" ]; then
	    echo 1382800 0 0 0 0 0 0 0 > /proc/sys/walt/input_boost/input_boost_freq
    else
	    echo 1171200 0 0 0 0 0 0 0 > /proc/sys/walt/input_boost/input_boost_freq
    fi
    echo 120 > /proc/sys/walt/input_boost/input_boost_ms

    # configure governor settings for gold cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/up_rate_limit_us
    if [ $rev == "1.0" ]; then
	    echo 1497600 > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_freq
    else
	    echo 1555200 > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_freq
    fi
    echo 1 > /sys/devices/system/cpu/cpufreq/policy4/walt/pl

    # configure governor settings for gold+ cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy7/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy7/walt/up_rate_limit_us
    if [ $rev == "1.0" ]; then
	echo 1536000 > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_freq
    else
	echo 1728000 > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_freq
    fi
    echo 1 > /sys/devices/system/cpu/cpufreq/policy7/walt/pl

    # configure bus-dcvs
    bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

    for device in $bus_dcvs/*
    do
        cat $device/hw_min_freq > $device/boost_freq
    done

    for llccbw in $bus_dcvs/LLCC/*bwmon-llcc
    do
        echo "4577 7110 9155 12298 14236 15258" > $llccbw/mbps_zones
        echo 4 > $llccbw/sample_ms
        echo 68 > $llccbw/io_percent
        echo 20 > $llccbw/hist_memory
        echo 10 > $llccbw/hyst_length
        echo 30 > $llccbw/down_thres
        echo 0 > $llccbw/guard_band_mbps
        echo 250 > $llccbw/up_scale
        echo 1600 > $llccbw/idle_mbps
        echo 806000 > $llccbw/max_freq
	echo 40 > $llccbw/window_ms
    done

    for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
    do
        echo "1720 2086 2929 3879 6515 7980 12191" > $ddrbw/mbps_zones
        echo 4 > $ddrbw/sample_ms
        echo 80 > $ddrbw/io_percent
        echo 20 > $ddrbw/hist_memory
        echo 10 > $ddrbw/hyst_length
        echo 30 > $ddrbw/down_thres
        echo 0 > $ddrbw/guard_band_mbps
        echo 250 > $ddrbw/up_scale
        echo 1600 > $ddrbw/idle_mbps
	echo 2092000 > $ddrbw/max_freq
        echo 40 > $ddrbw/window_ms
    done

    for latfloor in $bus_dcvs/*/*latfloor
    do
	    echo 25000 > $latfloor/ipm_ceil
    done

    for l3gold in $bus_dcvs/L3/*gold
    do
	    echo 4000 > $l3gold/ipm_ceil
    done

    for l3prime in $bus_dcvs/L3/*prime
    do
	    echo 20000 > $l3prime/ipm_ceil
    done

    for ddrprime in $bus_dcvs/DDR/*prime
    do
	    echo 25 > $ddrprime/freq_scale_pct
	    echo 1881 > $ddrprime/freq_scale_limit_mhz
    done

    for qosgold in $bus_dcvs/DDRQOS/*gold
    do
	    echo 50 > $qosgold/ipm_ceil
    done

    if [ "$rev" == "1.0" ]; then
	    echo Y > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
	    echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state1/disable
	    echo 1 > /sys/devices/system/cpu/cpu1/cpuidle/state1/disable
	    echo 1 > /sys/devices/system/cpu/cpu2/cpuidle/state1/disable
	    echo 1 > /sys/devices/system/cpu/cpu3/cpuidle/state1/disable
	    echo 1 > /sys/devices/system/cpu/cpu4/cpuidle/state1/disable
	    echo 1 > /sys/devices/system/cpu/cpu5/cpuidle/state1/disable
	    echo 1 > /sys/devices/system/cpu/cpu6/cpuidle/state1/disable
	    echo 1 > /sys/devices/system/cpu/cpu7/cpuidle/state1/disable
	    echo 0 > "/sys/devices/platform/hypervisor/hypervisor:qcom,gh-watchdog/wakeup_enable"
    else
	    echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
    fi

    # enable autosleep
    echo mem > /sys/power/autosleep

    configure_memory_parameters
    ;;
esac


if [ -f /sys/devices/system/cpu/cpufreq/ondemand/ ]; then
    chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
    chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
    chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
fi

emmc_boot=`getprop vendor.boot.emmc`
case "$emmc_boot"
    in "true")
        chown -h system /sys/devices/platform/rs300000a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown -h system /sys/devices/platform/rs300100a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac

# Let kernel know our image version/variant/crm_version
if [ -f /sys/devices/soc0/select_image ]; then
    image_version="10:"
    image_version+=`getprop ro.build.id`
    image_version+=":"
    image_version+=`getprop ro.build.version.incremental`
    image_variant=`getprop ro.product.name`
    image_variant+="-"
    image_variant+=`getprop ro.build.type`
    oem_version=`getprop ro.build.version.codename`
    echo 10 > /sys/devices/soc0/select_image
    echo $image_version > /sys/devices/soc0/image_version
    echo $image_variant > /sys/devices/soc0/image_variant
    echo $oem_version > /sys/devices/soc0/image_crm_version
fi

# Change console log level as per console config property
console_config=`getprop persist.console.silent.config`
case "$console_config" in
    "1")
        echo "Enable console config to $console_config"
        echo 0 > /proc/sys/kernel/printk
        ;;
esac

# Parse misc partition path and set property
if [ -f /dev/block/bootdevice/by-name/misc ]; then
    misc_link=$(ls -l /dev/block/bootdevice/by-name/misc)
    real_path=${misc_link##*>}
    setprop persist.vendor.mmi.misc_dev_path $real_path
fi

# Setting perf prop to signal postboot completion
setprop vendor.post_boot.parsed 1
echo "init_post_boot completed"
