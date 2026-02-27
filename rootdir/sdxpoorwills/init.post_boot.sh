#! /bin/sh

# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. 
# SPDX-License-Identifier: BSD-3-Clause-Clear

echo "++++ $0 -> Starting post boot settings " > /dev/kmsg

if [ -f /sys/devices/soc0/machine ]; then
    target=`cat /sys/devices/soc0/machine | tr [:upper:] [:lower:]`
fi

case "$target" in
  "SA415M" | "sa415m")
        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /etc/init.qti.debug.sh ]; then
            source /etc/init.qti.debug.sh
        fi

        case "$soc_id" in
 "408")

                # enable console suspend
                echo Y > /sys/module/printk/parameters/console_suspend

                echo N > /sys/module/lpm_levels/parameters/sleep_disabled
                echo mem > /sys/power/autosleep

                ;;
            *)
                ;;
        esac
    ;;
esac

echo "++++ $0 -> post boot settings completed" > /dev/kmsg
