#! /bin/sh

# Copyright (c) 2012-2013, 2016-2020, The Linux Foundation. All rights reserved.
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
echo -n "Starting init_post_boot: "

if [ -f /sys/devices/soc0/soc_id ]; then
        platformid=`cat /sys/devices/soc0/soc_id`
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
    # Enable ZRAM
      configure_zram_parameters
      configure_read_ahead_kb_values
      echo 0 > /proc/sys/vm/page-cluster
      echo 100 > /proc/sys/vm/swappiness
}

#QCS8250 QRB5165 QRB5165N
case "$platformid" in
    "481"|"455"|"496")

    ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
    ddr_type4="07"
    ddr_type5="08"

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
    if [ -d /sys/module/sched_walt_debug ]; then
        echo $long_running_rt_task_ms > /proc/sys/walt/sched_long_running_rt_task_ms
    fi
    echo $sched_rt_period_us > /proc/sys/kernel/sched_rt_period_us
    echo $sched_rt_runtime_us > /proc/sys/kernel/sched_rt_runtime_us

    # Make unbound workqueue not run on cpu0, since all irqs are
    # handled by cpu0 as default, it will preempt the workqueue if
    # the workqueue also run on cpu0, and the latency is out of control.
    echo fe > /sys/devices/virtual/workqueue/cpumask

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
    echo 0 > /sys/devices/system/cpu/cpu4/core_ctl/enable
    echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/enable


    # Setting b.L scheduler parameters
    echo 85 85 > /proc/sys/walt/sched_upmigrate
    echo 75 75 > /proc/sys/walt/sched_downmigrate
    echo 90 > /proc/sys/walt/sched_group_upmigrate
    echo 75 > /proc/sys/walt/sched_group_downmigrate
    echo 1 > /proc/sys/walt/sched_walt_rotate_big_tasks
    echo 400000000 > /proc/sys/walt/sched_coloc_downmigrate_ns

    # cpuset parameters
    echo 0-3 > /dev/cpuset/background/cpus
    echo 0-3 > /dev/cpuset/system-background/cpus

    # Turn off scheduler boost at the end
    echo 0 > /proc/sys/walt/sched_boost

    # configure governor settings for silver cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/up_rate_limit_us
        if [ `cat /sys/devices/soc0/revision` == "2.0" ]; then
        echo 1248000 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    else
        echo 1228800 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    fi
    echo 518400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy0/walt/pl

    # configure input boost settings
    echo "1324800 0 0 0 0 0 0 0" > /proc/sys/walt/input_boost/input_boost_freq
    echo 120 > /proc/sys/walt/input_boost/input_boost_ms

    # configure governor settings for gold cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy4/walt/up_rate_limit_us
    echo 1574400 > /sys/devices/system/cpu/cpufreq/policy4/walt/hispeed_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy4/walt/pl


    # configure governor settings for gold+ cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy7/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy7/walt/up_rate_limit_us
    if [ $rev == "2.0" ] || [ $rev == "2.1" ]; then
        echo 1632000 > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_freq
    else
        echo 1612800 > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_freq
    fi
    echo 1 > /sys/devices/system/cpu/cpufreq/policy7/walt/pl

    # Enable bus-dcvs
    bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

    for device in $bus_dcvs/*
    do
        cat $device/hw_min_freq > $device/boost_freq
    done

    for llccbw in $bus_dcvs/LLCC/*bwmon-llcc
    do
        echo "4577 7110 9155 12298 14236 15258" > $llccbw/mbps_zones
        echo 4 > $llccbw/sample_ms
        echo 50 > $llccbw/io_percent
        echo 20 > $llccbw/hist_memory
        echo 10 > $llccbw/hyst_length
        echo 30 > $llccbw/down_thres
        echo 0 > $llccbw/guard_band_mbps
        echo 250 > $llccbw/up_scale
        echo 1600 > $llccbw/idle_mbps
        echo 933000 > $llccbw/max_freq
    done

    for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
    do
        echo 40 > $ddrbw/window_ms
        if [ ${ddr_type:4:2} == $ddr_type4 ]; then
            echo "1720 2086 2929 3879 5161 5931 6881 7980" > $ddrbw/mbps_zones
        elif [ ${ddr_type:4:2} == $ddr_type5 ]; then
            echo "1720 2086 2929 3879 5931 6881 7980 10437" > $ddrbw/mbps_zones
        fi
        echo 4 > $ddrbw/sample_ms
        echo 80 > $ddrbw/io_percent
        echo 20 > $ddrbw/hist_memory
        echo 10 > $ddrbw/hyst_length
        echo 30 > $ddrbw/down_thres
        echo 0 > $ddrbw/guard_band_mbps
        echo 250 > $ddrbw/up_scale
        echo 1600 > $ddrbw/idle_mbps
        echo 1804000 > $ddrbw/max_freq
    done

    for l3gold in $bus_dcvs/L3/*gold
    do
        echo 4000 > $l3gold/ipm_ceil
    done

    for l3prime in $bus_dcvs/L3/*prime
    do
        echo 20000 > $l3prime/ipm_ceil
    done

    for qosgold in $bus_dcvs/DDRQOS/*gold
    do
        echo 50 > $qosgold/ipm_ceil
    done

    echo s2idle > /sys/power/mem_sleep
    echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
    configure_memory_parameters
    ;;
esac

#QCS7230
case "$platformid" in
    "548")

    ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
    ddr_type4="07"
    ddr_type5="08"

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
    if [ -d /sys/module/sched_walt_debug ]; then
        echo $long_running_rt_task_ms > /proc/sys/walt/sched_long_running_rt_task_ms
    fi
    echo $sched_rt_period_us > /proc/sys/kernel/sched_rt_period_us
    echo $sched_rt_runtime_us > /proc/sys/kernel/sched_rt_runtime_us

    # Make unbound workqueue not run on cpu0, since all irqs are
    # handled by cpu0 as default, it will preempt the workqueue if
    # the workqueue also run on cpu0, and the latency is out of control.
    echo fe > /sys/devices/virtual/workqueue/cpumask

    # Core control parameters for gold
    echo 2 > /sys/devices/system/cpu/cpu2/core_ctl/min_cpus
    echo 60 > /sys/devices/system/cpu/cpu2/core_ctl/busy_up_thres
    echo 30 > /sys/devices/system/cpu/cpu2/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu2/core_ctl/offline_delay_ms
    echo 3 > /sys/devices/system/cpu/cpu2/core_ctl/task_thres

    # Core control parameters for gold+
    echo 0 > /sys/devices/system/cpu/cpu5/core_ctl/min_cpus
    echo 60 > /sys/devices/system/cpu/cpu5/core_ctl/busy_up_thres
    echo 30 > /sys/devices/system/cpu/cpu5/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu5/core_ctl/offline_delay_ms
    echo 1 > /sys/devices/system/cpu/cpu5/core_ctl/task_thres
    # Controls how many more tasks should be eligible to run on gold CPUs
    # w.r.t number of gold CPUs available to trigger assist (max number of
    # tasks eligible to run on previous cluster minus number of CPUs in
    # the previous cluster).
    #
    # Setting to 1 by default which means there should be at least
    # 4 tasks eligible to run on gold cluster (tasks running on gold cores
    # plus misfit tasks on silver cores) to trigger assitance from gold+.
    echo 1 > /sys/devices/system/cpu/cpu5/core_ctl/nr_prev_assist_thresh

    # Disable Core control on silver
    echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
    echo 0 > /sys/devices/system/cpu/cpu2/core_ctl/enable
    echo 0 > /sys/devices/system/cpu/cpu5/core_ctl/enable


    # Setting b.L scheduler parameters
    echo 85 85 > /proc/sys/walt/sched_upmigrate
    echo 75 75 > /proc/sys/walt/sched_downmigrate
    echo 90 > /proc/sys/walt/sched_group_upmigrate
    echo 75 > /proc/sys/walt/sched_group_downmigrate
    echo 1 > /proc/sys/walt/sched_walt_rotate_big_tasks
    echo 400000000 > /proc/sys/walt/sched_coloc_downmigrate_ns

    # cpuset parameters
    echo 0-1 > /dev/cpuset/background/cpus
    echo 0-1 > /dev/cpuset/system-background/cpus

    # Turn off scheduler boost at the end
    echo 0 > /proc/sys/walt/sched_boost

    # configure governor settings for silver cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/up_rate_limit_us
        if [ `cat /sys/devices/soc0/revision` == "2.0" ]; then
        echo 1248000 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    else
        echo 1228800 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    fi
    echo 518400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy0/walt/pl

    # configure input boost settings
    echo "1324800 0 0 0 0 0 0 0" > /proc/sys/walt/input_boost/input_boost_freq
    echo 120 > /proc/sys/walt/input_boost/input_boost_ms

    # configure governor settings for gold cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy2/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy2/walt/up_rate_limit_us
    echo 1574400 > /sys/devices/system/cpu/cpufreq/policy2/walt/hispeed_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy2/walt/pl


    # configure governor settings for gold+ cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy5/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy5/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy5/walt/up_rate_limit_us
    if [ $rev == "2.0" ] || [ $rev == "2.1" ]; then
        echo 1632000 > /sys/devices/system/cpu/cpufreq/policy5/walt/hispeed_freq
    else
        echo 1612800 > /sys/devices/system/cpu/cpufreq/policy5/walt/hispeed_freq
    fi
    echo 1 > /sys/devices/system/cpu/cpufreq/policy5/walt/pl

    # Enable bus-dcvs
    bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

    for device in $bus_dcvs/*
    do
        cat $device/hw_min_freq > $device/boost_freq
    done

    for llccbw in $bus_dcvs/LLCC/*bwmon-llcc
    do
        echo "4577 7110 9155 12298 14236 15258" > $llccbw/mbps_zones
        echo 4 > $llccbw/sample_ms
        echo 50 > $llccbw/io_percent
        echo 20 > $llccbw/hist_memory
        echo 10 > $llccbw/hyst_length
        echo 30 > $llccbw/down_thres
        echo 0 > $llccbw/guard_band_mbps
        echo 250 > $llccbw/up_scale
        echo 1600 > $llccbw/idle_mbps
        echo 933000 > $llccbw/max_freq
    done

    for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
    do
        echo 40 > $ddrbw/window_ms
        if [ ${ddr_type:4:2} == $ddr_type4 ]; then
            echo "1720 2086 2929 3879 5161 5931 6881 7980" > $ddrbw/mbps_zones
        elif [ ${ddr_type:4:2} == $ddr_type5 ]; then
            echo "1720 2086 2929 3879 5931 6881 7980 10437" > $ddrbw/mbps_zones
        fi
        echo 4 > $ddrbw/sample_ms
        echo 80 > $ddrbw/io_percent
        echo 20 > $ddrbw/hist_memory
        echo 10 > $ddrbw/hyst_length
        echo 30 > $ddrbw/down_thres
        echo 0 > $ddrbw/guard_band_mbps
        echo 250 > $ddrbw/up_scale
        echo 1600 > $ddrbw/idle_mbps
        echo 1804000 > $ddrbw/max_freq
    done

    for l3gold in $bus_dcvs/L3/*gold
    do
        echo 4000 > $l3gold/ipm_ceil
    done

    for l3prime in $bus_dcvs/L3/*prime
    do
        echo 20000 > $l3prime/ipm_ceil
    done

    for qosgold in $bus_dcvs/DDRQOS/*gold
    do
        echo 50 > $qosgold/ipm_ceil
    done

    echo s2idle > /sys/power/mem_sleep
    echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
    configure_memory_parameters
    ;;
esac

#QRB3165 QRB3165N
case "$platformid" in
    "598"|"599")

    ddr_type=`od -An -tx /proc/device-tree/memory/ddr_device_type`
    ddr_type4="07"
    ddr_type5="08"

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
    if [ -d /sys/module/sched_walt_debug ]; then
        echo $long_running_rt_task_ms > /proc/sys/walt/sched_long_running_rt_task_ms
    fi
    echo $sched_rt_period_us > /proc/sys/kernel/sched_rt_period_us
    echo $sched_rt_runtime_us > /proc/sys/kernel/sched_rt_runtime_us

    # Make unbound workqueue not run on cpu0, since all irqs are
    # handled by cpu0 as default, it will preempt the workqueue if
    # the workqueue also run on cpu0, and the latency is out of control.
    echo fe > /sys/devices/virtual/workqueue/cpumask

    # Core control parameters for gold
    echo 2 > /sys/devices/system/cpu/cpu3/core_ctl/min_cpus
    echo 60 > /sys/devices/system/cpu/cpu3/core_ctl/busy_up_thres
    echo 30 > /sys/devices/system/cpu/cpu3/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu3/core_ctl/offline_delay_ms
    echo 3 > /sys/devices/system/cpu/cpu3/core_ctl/task_thres

    # Core control parameters for gold+
    #echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/min_cpus
    #echo 60 > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
    #echo 30 > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
    #echo 100 > /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
    #echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/task_thres
    # Controls how many more tasks should be eligible to run on gold CPUs
    # w.r.t number of gold CPUs available to trigger assist (max number of
    # tasks eligible to run on previous cluster minus number of CPUs in
    # the previous cluster).
    #
    # Setting to 1 by default which means there should be at least
    # 4 tasks eligible to run on gold cluster (tasks running on gold cores
    # plus misfit tasks on silver cores) to trigger assitance from gold+.
    #echo 1 > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh

    # Disable Core control on silver
    echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
    echo 0 > /sys/devices/system/cpu/cpu3/core_ctl/enable
    #echo 0 > /sys/devices/system/cpu/cpu7/core_ctl/enable


    # Setting b.L scheduler parameters
    echo 85 85 > /proc/sys/walt/sched_upmigrate
    echo 75 75 > /proc/sys/walt/sched_downmigrate
    echo 90 > /proc/sys/walt/sched_group_upmigrate
    echo 75 > /proc/sys/walt/sched_group_downmigrate
    echo 1 > /proc/sys/walt/sched_walt_rotate_big_tasks
    echo 400000000 > /proc/sys/walt/sched_coloc_downmigrate_ns

    # cpuset parameters
    echo 0-2 > /dev/cpuset/background/cpus
    echo 0-2 > /dev/cpuset/system-background/cpus

    # Turn off scheduler boost at the end
    echo 0 > /proc/sys/walt/sched_boost

    # configure governor settings for silver cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/up_rate_limit_us
        if [ `cat /sys/devices/soc0/revision` == "2.0" ]; then
        echo 1248000 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    else
        echo 1228800 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    fi
    echo 518400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy0/walt/pl

    # configure input boost settings
    echo "1324800 0 0 0 0 0 0 0" > /proc/sys/walt/input_boost/input_boost_freq
    echo 120 > /proc/sys/walt/input_boost/input_boost_ms

    # configure governor settings for gold cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy3/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy3/walt/up_rate_limit_us
    echo 1574400 > /sys/devices/system/cpu/cpufreq/policy3/walt/hispeed_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy3/walt/pl


    # configure governor settings for gold+ cluster
    #echo "walt" > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
    #echo 0 > /sys/devices/system/cpu/cpufreq/policy7/walt/down_rate_limit_us
    #echo 0 > /sys/devices/system/cpu/cpufreq/policy7/walt/up_rate_limit_us
    #if [ $rev == "2.0" ] || [ $rev == "2.1" ]; then
        #echo 1632000 > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_freq
    #else
        #echo 1612800 > /sys/devices/system/cpu/cpufreq/policy7/walt/hispeed_freq
    #fi
    #echo 1 > /sys/devices/system/cpu/cpufreq/policy7/walt/pl

    # Enable bus-dcvs
    bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

    for device in $bus_dcvs/*
    do
        cat $device/hw_min_freq > $device/boost_freq
    done

    for llccbw in $bus_dcvs/LLCC/*bwmon-llcc
    do
        echo "4577 7110 9155 12298 14236 15258" > $llccbw/mbps_zones
        echo 4 > $llccbw/sample_ms
        echo 50 > $llccbw/io_percent
        echo 20 > $llccbw/hist_memory
        echo 10 > $llccbw/hyst_length
        echo 30 > $llccbw/down_thres
        echo 0 > $llccbw/guard_band_mbps
        echo 250 > $llccbw/up_scale
        echo 1600 > $llccbw/idle_mbps
        echo 933000 > $llccbw/max_freq
    done

    for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
    do
        echo 40 > $ddrbw/window_ms
        if [ ${ddr_type:4:2} == $ddr_type4 ]; then
            echo "1720 2086 2929 3879 5161 5931 6881 7980" > $ddrbw/mbps_zones
        elif [ ${ddr_type:4:2} == $ddr_type5 ]; then
            echo "1720 2086 2929 3879 5931 6881 7980 10437" > $ddrbw/mbps_zones
        fi
        echo 4 > $ddrbw/sample_ms
        echo 80 > $ddrbw/io_percent
        echo 20 > $ddrbw/hist_memory
        echo 10 > $ddrbw/hyst_length
        echo 30 > $ddrbw/down_thres
        echo 0 > $ddrbw/guard_band_mbps
        echo 250 > $ddrbw/up_scale
        echo 1600 > $ddrbw/idle_mbps
        echo 1804000 > $ddrbw/max_freq
    done

    for l3gold in $bus_dcvs/L3/*gold
    do
        echo 4000 > $l3gold/ipm_ceil
    done

    for qosgold in $bus_dcvs/DDRQOS/*gold
    do
        echo 50 > $qosgold/ipm_ceil
    done

    echo s2idle > /sys/power/mem_sleep
    echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
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

echo "init_post_boot completed"
