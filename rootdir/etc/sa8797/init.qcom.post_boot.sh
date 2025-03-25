#! /bin/sh
# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

. /etc/initscripts/init.qcom.post_boot.common.sh

target=$(get_target)

case "$target" in
  "sa8797p" )
    # Tune pm_freeze_timeout smaller than wdt_time_out/2 to avoid wdt when
    # kernel hung in freezing userspace process.
    echo 4000 > /sys/power/pm_freeze_timeout
    # Set total buffer size as 3600M, 20M for each CPU
    set_total_trace_buffer_size 3600000
    enable_debug_tracing_events
    echo "4 4 1 7" > /proc/sys/kernel/printk
;;
esac

echo "init_qcom_post_boot completed"
