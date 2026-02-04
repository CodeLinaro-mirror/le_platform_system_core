#! /bin/sh
#Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
#SPDX-License-Identifier: BSD-3-Clause-Clear

echo "4 4 1 4" > /proc/sys/kernel/printk
sleep 6
echo mem > /sys/power/autosleep

if [ -f /etc/init.qti.debug.sh ]; then
    /etc/init.qti.debug.sh
fi

echo -n "Started post boot settings " > /dev/kmsg

#disable watermark boost
echo 0 > /proc/sys/vm/watermark_boost_factor
echo -n "Watermark boost is disabled" > /dev/kmsg

#ftrace
tracefs=/sys/kernel/debug/tracing

#SPI
#mkdir $tracefs/instances/spi_qup
#echo 2 > $tracefs/instances/spi_qup/buffer_size_kb
#echo 1 > $tracefs/instances/spi_qup/events/qup_spi_trace/enable
#echo 1 > $tracefs/instances/spi_qup/tracing_on

#I2C
#mkdir $tracefs/instances/i2c_qup
#echo 2 > $tracefs/instances/i2c_qup/buffer_size_kb
#echo 1 > $tracefs/instances/i2c_qup/events/qup_i2c_trace/enable
#echo 1 > $tracefs/instances/i2c_qup/tracing_on

#GENI_COMMON
#mkdir $tracefs/instances/qupv3_common
#echo 2 > $tracefs/instances/qupv3_common/buffer_size_kb
#echo 1 > $tracefs/instances/qupv3_common/events/qup_common_trace/enable
#echo 1 > $tracefs/instances/qupv3_common/tracing_on
