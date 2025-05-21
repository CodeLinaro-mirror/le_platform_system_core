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

    if [ ! -d "/sys/kernel/debug/dynamic_mem_dump" ]
    then
        mount -t debugfs none /sys/kernel/debug
    fi

    echo 1 >/sys/kernel/debug/dynamic_mem_dump/apps_scandump/enable
    echo 1 >/sys/kernel/debug/dynamic_mem_dump/cluster_cache/enable
    echo 1 >/sys/kernel/debug/dynamic_mem_dump/cpu_cache/enable
    echo 1 >/sys/kernel/debug/dynamic_mem_dump/cpucp/enable
    echo 1 >/sys/kernel/debug/dynamic_mem_dump/cpuss_cluster/enable
    echo 1 >/sys/kernel/debug/dynamic_mem_dump/cpuss_cpu/enable
    echo 1 >/sys/kernel/debug/dynamic_mem_dump/cpuss_reg/enable
    echo 1 >/sys/kernel/debug/dynamic_mem_dump/spr/enable
}

case "$target" in
  "sa8797p" )
    # Tune pm_freeze_timeout smaller than wdt_time_out/2 to avoid wdt when
    # kernel hung in freezing userspace process.
    echo 4000 > /sys/power/pm_freeze_timeout
    # Set total buffer size as 3600M, 20M for each CPU
    set_total_trace_buffer_size 3600000
    enable_debug_tracing_events
    echo "4 4 1 7" > /proc/sys/kernel/printk
    find_build_type
    init_dynamic_mem_dum
;;
esac

echo "init_qcom_post_boot completed"
