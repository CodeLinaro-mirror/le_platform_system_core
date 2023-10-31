#! /bin/sh

#=============================================================================
#
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
# Changes from Qualcomm Innovation Center are provided under the following license:
# Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#=============================================================================

function configure_zram_parameters() {
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}

    low_ram=`getprop ro.config.low_ram`

    # Zram disk - 75% for Go and < 2GB devices .
    # For >2GB Non-Go devices, size = 50% of RAM size. Limit the size to 4GB.
    # And enable lz4 zram compression for Go targets.

    let RamSizeGB="( $MemTotal / 1048576 ) + 1"
    diskSizeUnit=M
    if [ $RamSizeGB -le 2 ]; then
        let zRamSizeMB="( $RamSizeGB * 1024 ) * 3 / 4"
    else
        let zRamSizeMB="( $RamSizeGB * 1024 ) / 2"
    fi

    # use MB avoid 32 bit overflow
    if [ $zRamSizeMB -gt 4096 ]; then
        let zRamSizeMB=4096
    fi

    if [ "$low_ram" == "true" ]; then
        echo lz4 > /sys/block/zram0/comp_algorithm
    fi

    if [ -f /sys/block/zram0/disksize ]; then
        if [ -f /sys/block/zram0/use_dedup ]; then
            echo 1 > /sys/block/zram0/use_dedup
        fi
        echo "$zRamSizeMB""$diskSizeUnit" > /sys/block/zram0/disksize

        # ZRAM may use more memory than it saves if SLAB_STORE_USER
        # debug option is enabled.
        if [ -e /sys/kernel/slab/zs_handle ]; then
            echo 0 > /sys/kernel/slab/zs_handle/store_user
        fi
        if [ -e /sys/kernel/slab/zspage ]; then
            echo 0 > /sys/kernel/slab/zspage/store_user
        fi

        mkswap /dev/block/zram0
        swapon /dev/block/zram0 -p 32758
    fi
}

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

    configure_zram_parameters
    configure_read_ahead_kb_values
    echo 100 > /proc/sys/vm/swappiness

    # Disable periodic kcompactd wakeups. We do not use THP, so having many
    # huge pages is not as necessary.
    echo 0 > /proc/sys/vm/compaction_proactiveness

    # With THP enabled, the kernel greatly increases min_free_kbytes over its
    # default value. Disable THP to prevent resetting of min_free_kbytes
    # value during online/offline pages.
    if [ -f /sys/kernel/mm/transparent_hugepage/enabled ]; then
        echo never > /sys/kernel/mm/transparent_hugepage/enabled
    fi

    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}
    let RamSizeGB="( $MemTotal / 1048576 ) + 1"

    # Set the min_free_kbytes to standard kernel value
    if [ $RamSizeGB -ge 8 ]; then
        echo 11584 > /proc/sys/vm/min_free_kbytes
    elif [ $RamSizeGB -ge 4 ]; then
        echo 8192 > /proc/sys/vm/min_free_kbytes
    elif [ $RamSizeGB -ge 2 ]; then
        echo 5792 > /proc/sys/vm/min_free_kbytes
    else
        echo 4096 > /proc/sys/vm/min_free_kbytes
    fi
}

configure_memory_parameters

if [ -f /sys/devices/soc0/soc_id ]; then
        platformid=`cat /sys/devices/soc0/soc_id`
fi

case "$platformid" in
    "603")
    # Disable Core control on silver/gold/gold_plus
    echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable
    echo 0 > /sys/devices/system/cpu/cpu3/core_ctl/enable
    echo 0 > /sys/devices/system/cpu/cpu5/core_ctl/enable

    nonGPUid=`cat /sys/devices/soc0/gpu`
    if [ $nonGPUid == "0x1" ]; then
        # limit DDR frequency to 3.2GHz
        echo "{class:ddr, res:capped, val: 3187}" > /sys/kernel/debug/aoss_send_message
	echo "limit DDR frequnecy to 3.2G for nonGPU"
    fi
esac

case "$platformid" in
    "519"|"536"|"600"|"601"|"603")
    rev=`cat /sys/devices/soc0/revision`
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
    echo $sched_rt_period_us > /proc/sys/kernel/sched_rt_period_us
    echo $sched_rt_runtime_us > /proc/sys/kernel/sched_rt_runtime_us

    # Core control parameters for gold
    echo 2 > /sys/devices/system/cpu/cpu3/core_ctl/min_cpus
    echo 60 > /sys/devices/system/cpu/cpu3/core_ctl/busy_up_thres
    echo 30 > /sys/devices/system/cpu/cpu3/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu3/core_ctl/offline_delay_ms
    echo 4 > /sys/devices/system/cpu/cpu3/core_ctl/task_thres
    echo 0 0 > /sys/devices/system/cpu/cpu3/core_ctl/not_preferred

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
    # 5 tasks eligible to run on gold cluster (tasks running on gold cores
    # plus misfit tasks on silver cores) to trigger assitance from gold+.
    echo 1 > /sys/devices/system/cpu/cpu5/core_ctl/nr_prev_assist_thresh

    # Disable Core control on silver
    echo 0 > /sys/devices/system/cpu/cpu0/core_ctl/enable

    # Setting b.L scheduler parameters
    echo 95 95 > /proc/sys/walt/sched_upmigrate
    echo 85 85 > /proc/sys/walt/sched_downmigrate
    echo 100 > /proc/sys/walt/sched_group_upmigrate
    echo 85 > /proc/sys/walt/sched_group_downmigrate
    echo 1 > /proc/sys/walt/sched_walt_rotate_big_tasks
    echo 400000000 > /proc/sys/walt/sched_coloc_downmigrate_ns
    echo 16000000 16000000 16000000 16000000 16000000 16000000 16000000 5000000 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_ns
    echo 248 > /proc/sys/walt/sched_coloc_busy_hysteresis_enable_cpus
    echo 10 10 10 10 10 10 10 95 > /proc/sys/walt/sched_coloc_busy_hyst_cpu_busy_pct
    echo 8500000 8500000 8500000 8500000 8500000 8500000 8500000 2000000 > /proc/sys/walt/sched_util_busy_hyst_cpu_ns
    echo 255 > /proc/sys/walt/sched_util_busy_hysteresis_enable_cpus
    echo 1 1 1 1 1 1 1 15 > /proc/sys/walt/sched_util_busy_hyst_cpu_util
    echo 40 > /proc/sys/walt/sched_cluster_util_thres_pct
    echo 30 > /proc/sys/walt/sched_idle_enough
    echo 10 > /proc/sys/walt/sched_ed_boost

    #Set early upmigrate tunables
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

    # set the threshold for low latency task boost feature which prioritize
    # binder activity tasks
    echo 325 > /proc/sys/walt/walt_low_latency_task_threshold

    # cpuset parameters
    echo 0-2 > /dev/cpuset/background/cpus
    echo 0-2 > /dev/cpuset/system-background/cpus

    # Turn off scheduler boost at the end
    echo 0 > /proc/sys/walt/sched_boost

    # Reset the RT boost, which is 1024 (max) by default.
    echo 0 > /proc/sys/kernel/sched_util_clamp_min_rt_default

    # configure governor settings for silver cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy0/walt/up_rate_limit_us
    if [ $rev == "1.0" ] || [ $rev == "1.1" ]; then
        echo 1324800 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    else
        echo 1267200 > /sys/devices/system/cpu/cpufreq/policy0/walt/hispeed_freq
    fi
    echo 556800 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy0/walt/pl

    # configure input boost settings
    if [ $rev == "1.0" ] || [ $rev == "1.1" ]; then
        echo 1382800 0 0 0 0 0 0 0 > /proc/sys/walt/input_boost/input_boost_freq
    else
        echo 1228800 0 0 0 0 0 0 0 > /proc/sys/walt/input_boost/input_boost_freq
    fi
    echo 100 > /proc/sys/walt/input_boost/input_boost_ms

    # configure governor settings for gold cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy3/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy3/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy3/walt/up_rate_limit_us
    if [ $rev == "1.0" ] || [ $rev == "1.1" ]; then
        echo 1555200 > /sys/devices/system/cpu/cpufreq/policy3/walt/hispeed_freq
    else
        echo 1555200 > /sys/devices/system/cpu/cpufreq/policy3/walt/hispeed_freq
    fi
    echo 537600 > /sys/devices/system/cpu/cpufreq/policy3/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy3/walt/pl

    # configure governor settings for gold+ cluster
    echo "walt" > /sys/devices/system/cpu/cpufreq/policy5/scaling_governor
    echo 0 > /sys/devices/system/cpu/cpufreq/policy5/walt/down_rate_limit_us
    echo 0 > /sys/devices/system/cpu/cpufreq/policy5/walt/up_rate_limit_us
    if [ $rev == "1.0" ] || [ $rev == "1.1" ]; then
        echo 1593600 > /sys/devices/system/cpu/cpufreq/policy5/walt/hispeed_freq
    else
        echo 1728000 > /sys/devices/system/cpu/cpufreq/policy5/walt/hispeed_freq
    fi
    echo 748800 > /sys/devices/system/cpu/cpufreq/policy5/scaling_min_freq
    echo 1 > /sys/devices/system/cpu/cpufreq/policy5/walt/pl

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
        echo 80 > $llccbw/io_percent
        echo 20 > $llccbw/hist_memory
        echo 5 > $llccbw/hyst_length
        echo 1 > $llccbw/idle_length
        echo 30 > $llccbw/down_thres
        echo 0 > $llccbw/guard_band_mbps
        echo 250 > $llccbw/up_scale
        echo 1600 > $llccbw/idle_mbps
        echo 806000 > $llccbw/max_freq
        echo 40 > $llccbw/window_ms
    done

    for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
    do
        echo "2086 5931 6515 7980 12191 16259" > $ddrbw/mbps_zones
        echo 4 > $ddrbw/sample_ms
        echo 80 > $ddrbw/io_percent
        echo 20 > $ddrbw/hist_memory
        echo 5 > $ddrbw/hyst_length
        echo 1 > $ddrbw/idle_length
        echo 30 > $ddrbw/down_thres
        echo 0 > $ddrbw/guard_band_mbps
        echo 250 > $ddrbw/up_scale
        echo 1600 > $ddrbw/idle_mbps
        echo 2736000 > $ddrbw/max_freq
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

    for qosgold in $bus_dcvs/DDRQOS/*gold
    do
        echo 50 > $qosgold/ipm_ceil
    done

    for qosprime in $bus_dcvs/DDRQOS/*prime
    do
        echo 100 > $qosprime/ipm_ceil
    done

    for ddrprime in $bus_dcvs/DDR/*prime
    do
        echo 25 > $ddrprime/freq_scale_pct
        echo 1500 > $ddrprime/freq_scale_floor_mhz
        echo 2726 > $ddrprime/freq_scale_ceil_mhz
    done

    echo s2idle > /sys/power/mem_sleep
    echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled

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
        ;;
    *)
        echo "***WARNING***: Invalid SoC ID\n\t No postboot settings applied!!\n"
        ;;
esac
