#! /bin/sh
# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

. /etc/initscripts/init.qcom.post_boot.common.sh

target=$(get_target)

case "$target" in
  "sa8775p"| "sa8255p" | "sa8650p" )
    # Tune pm_freeze_timeout smaller than wdt_time_out/2 to avoid wdt when
    # kernel hung in freezing userspace process.
    echo 4000 > /sys/power/pm_freeze_timeout
    if ! uname -r | grep -q perf; then
      # Lemans refined systemd-modules-load, gunyah driver may not be ready
      # after this moment, so need to install the modules explicitly.
      modprobe gunyah hvc_gunyah
      # Set total buffer size as 160M, 20M for each CPU
      set_total_trace_buffer_size 160000
      enable_debug_tracing_events
    fi
    echo "4 4 1 7" > /proc/sys/kernel/printk
;;
esac

echo "init_qcom_post_boot completed"
