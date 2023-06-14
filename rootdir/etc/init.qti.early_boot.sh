#! /bin/sh
# Copyright (c) 2019 The Linux Foundation. All rights reserved.
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

target=`cat /sys/devices/soc0/machine | tr [:upper:] [:lower:]`

echo -n "Starting init_early_boot: [$target] "

case "$target" in
    "sa8155p" | "sa8155" )
        if [ -d "/sys/devices/system/cpu/bus_dcvs/L3" ]; then
            echo 902400 > /sys/devices/system/cpu/bus_dcvs/L3/boost_freq
            echo 902400 > /sys/devices/system/cpu/bus_dcvs/L3/soc:qcom,memlat:l3:gold/min_freq
            echo 902400 > /sys/devices/system/cpu/bus_dcvs/L3/soc:qcom,memlat:l3:silver/min_freq
            echo 902400 > /sys/devices/system/cpu/bus_dcvs/L3/soc:qcom,memlat:l3:prime/min_freq
        else
            for l3lat in /sys/class/devfreq/*qcom,cpu*-cpu-l3-lat
            do
                echo  902400000 > $l3lat/min_freq
                echo 1612800000 > $l3lat/max_freq
            done
        fi
        ;;
    "sa8195p" )
        if [ -d "/sys/devices/system/cpu/bus_dcvs/L3" ]; then
            echo 940800 > /sys/devices/system/cpu/bus_dcvs/L3/boost_freq
            echo 940800 > /sys/devices/system/cpu/bus_dcvs/L3/soc:qcom,memlat:l3:gold/min_freq
            echo 940800 > /sys/devices/system/cpu/bus_dcvs/L3/soc:qcom,memlat:l3:silver/min_freq
        else
            for l3lat in /sys/class/devfreq/*qcom,cpu*-cpu-l3-lat
            do
                echo 940800000 > $l3lat/min_freq
            done
        fi
        ;;
    "sa6155p" | "sa6155" )
        if [ -d "/sys/devices/system/cpu/bus_dcvs/L3" ]; then
            echo 940800 > /sys/devices/system/cpu/bus_dcvs/L3/boost_freq
        else
            for l3lat in /sys/class/devfreq/*qcom,cpu*-cpu-l3-lat
            do
                echo 940800000 > $l3lat/min_freq
            done
        fi
        ;;
    *)
        ;;
esac
