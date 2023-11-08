#! /bin/sh
# Copyright (c) 2009-2020, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

echo -n "Starting post boot settings "
echo "++++ $0 -> Starting post boot settings " > /dev/kmsg

emmc_boot=`getprop ro.boot.emmc`
case "$emmc_boot"
    in "true")
        chown -h system /sys/devices/platform/rs300000a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300000a7.65536/sync_sts
        chown -h system /sys/devices/platform/rs300100a7.65536/force_sync
        chown -h system /sys/devices/platform/rs300100a7.65536/sync_sts
    ;;
esac

if [ -f /sys/devices/soc0/machine ]; then
    target=`cat /sys/devices/soc0/machine | tr [:upper:] [:lower:]`
else
    target=`getprop ro.board.platform`
fi

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
		echo $ra_kb > $dm
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

    configure_read_ahead_kb_values
    echo 0 > /proc/sys/vm/page-cluster
    echo 100 > /proc/sys/vm/swappiness
    # Disable periodic kcompactd wakeups. We do not use THP, so having many
    # huge pages is not as necessary.
    #disable proactive compaction
    echo 0 > /proc/sys/vm/compaction_proactiveness
}

case "$target" in
    "qcs405" | "qcs404" | "qcs407")
        if [ -f /sys/devices/soc0/soc_id ]; then
            soc_id=`cat /sys/devices/soc0/soc_id`
        else
            soc_id=`cat /sys/devices/system/soc/soc0/id`
        fi

        if [ -f /sys/devices/soc0/hw_platform ]; then
            hw_platform=`cat /sys/devices/soc0/hw_platform`
        else
            hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
        fi

        if [ -f /etc/init.qti.debug.sh ]; then
            source /etc/init.qti.debug.sh
        fi

        case "$soc_id" in
           "352" | "410" | "411")

		# PELT Tunable setting for qcs405, as WALT is disabled
		sched="/proc/sys/kernel"

		echo 1 > $sched/sched_child_runs_first
		echo 4194304 > $sched/sched_deadline_period_max_us
		echo 100 > $sched/sched_deadline_period_min_us
		echo 1 > $sched/sched_energy_aware
		echo 1 > $sched/sched_pelt_multiplier
		echo 100 > $sched/sched_rr_timeslice_ms
		echo 1000000 > $sched/sched_rt_period_us
		echo 950000 > $sched/sched_rt_runtime_us
		echo 0 > $sched/sched_schedstats
		echo 1024 > $sched/sched_util_clamp_max
		echo 1024 > $sched/sched_util_clamp_min
		echo 1024 > $sched/sched_util_clamp_min_rt_default

		# configure bus-dcvs
		bus_dcvs="/sys/devices/system/cpu/bus_dcvs"

		for device in $bus_dcvs/*
		    do
			cat $device/hw_min_freq > $device/boost_freq
		    done

		for ddrbw in $bus_dcvs/DDR/*bwmon-ddr
		    do
			#echo "1720 2086 2929 3879 5161 5931 6881 7980" > $ddrbw/mbps_zones
			echo 4 > $ddrbw/sample_ms
			echo 68 > $ddrbw/io_percent
			echo 20 > $ddrbw/hist_memory
			echo 0 > $ddrbw/hyst_length
			echo 80 > $ddrbw/down_thres
			echo 30 > $ddrbw/guard_band_mbps
			echo 250 > $ddrbw/up_scale
			echo 762 > $ddrbw/idle_mbps
			echo 710000 > $ddrbw/max_freq
			echo 40 > $ddrbw/window_ms
			done

		for latfloor in $bus_dcvs/*/*latfloor
		    do
			echo 25000 > $latfloor/ipm_ceil
		    done

                echo 1 > /sys/devices/system/cpu/cpu0/online
		echo "schedutil" >  /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
                echo 0 > /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
		echo 1094400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq

		# enable console suspend
                echo Y > /sys/module/printk/parameters/console_suspend

                # Bring up all cores online
                echo 1 > /sys/devices/system/cpu/cpu1/online
                echo 1 > /sys/devices/system/cpu/cpu2/online
                echo 1 > /sys/devices/system/cpu/cpu3/online

		echo N > /sys/devices/system/cpu/qcom_lpm/parameters/sleep_disabled
                #echo mem > /sys/power/autosleep

                configure_memory_parameters
                echo "++++ $0 -> Debug QCS40X - START" > /dev/kmsg
                enable_qcs40x_debug
                echo "++++ $0 -> Debug QCS40X - END" > /dev/kmsg
                ;;
                *)
                ;;
        esac
    ;;
esac

echo "post boot settings completed"
echo "++++ $0 -> post boot settings completed" > /dev/kmsg
