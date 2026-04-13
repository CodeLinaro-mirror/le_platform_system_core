#!/bin/sh
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear

echo "++++ $0 -> Starting sa535m post boot script " > /dev/kmsg

if [ -f /etc/init.qti.debug.sh ]; then
    source /etc/init.qti.debug.sh
fi

echo "++++ $0 -> enable_sa535m_debug - START" > /dev/kmsg
enable_sa535m_debug
echo "++++ $0 -> enable_sa535m_debug - END" > /dev/kmsg

echo "++++ $0 -> sa535m post boot script done" > /dev/kmsg


#enable schedutil governor
echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo "schedutil" > /sys/devices/system/cpu/cpufreq/policy2/scaling_governor
