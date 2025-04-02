#! /bin/sh
# Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

# This function lets you configure the total trace buffer size, splitting
# buffer size evenly per cpu
set_total_trace_buffer_size() {
        # $1 arg is the desired buffer_total_size_kb
        if [ -z "$1" ]; then
                echo "Error: missing arg for desired total trace buffer size"
                echo "Usage: set_total_trace_buffer_size <buffer_total_size_kb>"
                exit 1
        fi

        desired_buffer_total_size_kb=$1
        num_cpus=$(ls /sys/kernel/tracing/per_cpu | wc -l)
        buffer_size_kb=$((desired_buffer_total_size_kb / num_cpus))
        echo $buffer_size_kb > /sys/kernel/tracing/buffer_size_kb
}

# These trace events will be enabled for easier performance debugging
enable_debug_tracing_events() {
    tracing_events_dir="/sys/kernel/tracing/events"
    # includes timer, irq, workqueue, sched events
    events=" \
        timer/timer_expire_entry \
        timer/timer_expire_exit \
        timer/hrtimer_cancel \
        timer/hrtimer_expire_entry \
        timer/hrtimer_expire_exit \
        timer/hrtimer_init \
        timer/hrtimer_start \
        irq \
        workqueue \
        ipi \
        sched \
        safelinux \
        gunyah \
        iommu \
        oom \
        rwmmio \
        scmi \
        secure_buffer \
    "

    for event in $events; do
        echo 1 > "$tracing_events_dir/$event/enable"
    done
}

get_target() {
  if [ -f /sys/devices/soc0/machine ]; then
    target=$(cat /sys/devices/soc0/machine | tr [:upper:] [:lower:])
  elif [ -f /sys/devices/soc0/soc_id ]; then
    target=$(cat /sys/devices/soc0/soc_id)
  else
    target=$(getprop ro.board.platform)
  fi
  printf "%s" "$target"
}
