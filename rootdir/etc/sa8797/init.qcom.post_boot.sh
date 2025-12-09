#! /bin/sh
# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

. /etc/initscripts/init.qcom.post_boot.common.sh

target=$(get_target)

init_dynamic_mem_dump()
{
    if [ "$debug_build" != true ]
    then
        return
    fi

    if [ ! -d "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump" ]
    then
        return
    fi

    echo "cluster_cache" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
    echo "cpu_cache" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
    echo "cpucp" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
    echo "cpuss_cluster" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
    echo "cpuss_cpu" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
    echo "spr" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
    echo "cpuss_reg" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
    echo "scandump_gpu" > "/sys/devices/platform/soc@0/soc@0:mem-dump/dynamic_mem_dump/enable"
}

set_cpu_governor_policy()
{
    CPUFREQ_POLICY="/sys/devices/system/cpu/cpufreq"
    reg_val=`cat /sys/devices/platform/soc@0/1f97070.qfprom/qfprom0/nvmem | od -An -tx1`
    sku_variant=$(echo $reg_val | awk '{print $2}' | cut -c1)

    # SKU Config
    # 0x0 - NonSafe-IVI
    # 0x1 - ADAS
    # 0x2 - Safe-IVI
    # 0x3 - Flex"
    if [ $sku_variant -ne 0 ]; then
        return
    fi

    # schedutil cpufreq governor should be set only to Nonsafe variant
    for dir in $CPUFREQ_POLICY/*; do
        echo schedutil > $dir/scaling_governor
    done
}

case "$target" in
  "qam8797p" )
    # Tune pm_freeze_timeout smaller than wdt_time_out/2 to avoid wdt when
    # kernel hung in freezing userspace process.
    echo 4000 > /sys/power/pm_freeze_timeout
    # Set total buffer size as 3600M, 20M for each CPU
    set_total_trace_buffer_size 3600000
    enable_debug_tracing_events
    echo "4 4 1 7" > /proc/sys/kernel/printk
    find_build_type
    init_dynamic_mem_dump
    # Disabling the schedutil governor temporarily
    #set_cpu_governor_policy
;;
esac

echo "init_qcom_post_boot completed"
