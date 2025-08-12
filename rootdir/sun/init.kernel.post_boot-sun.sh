#=============================================================================
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#=============================================================================

get_num_logical_cores_in_physical_cluster()
{
    i=0 
    if [ -f /sys/devices/system/cpu/cpu0/topology/cluster_id ] ; then
        physical_cluster="cluster_id"
    else
        physical_cluster="physical_package_id"
    fi  
    for i in `ls -d /sys/devices/system/cpu/cpufreq/policy[0-9]*`
    do  
        if [ -e $i ] ; then
            num_cores=$(cat $i/related_cpus | wc -w)
            first_cpu=$(echo "$i" | sed 's/[^0-9]*//g')
            cluster_id=$(cat /sys/devices/system/cpu/cpu$first_cpu/topology/$physical_cluster)
            if [ $cluster_id -eq 0 ]; then
                logical_cores0=$num_cores
            elif [ $cluster_id -eq 1  ]; then
                logical_cores1=$num_cores
            elif [ $cluster_id -eq 2 ]; then
                logical_cores2=$num_cores
            elif [ $cluster_id -eq 3 ]; then
                logical_cores3=$num_cores
            fi
        fi
    done
    echo $logical_cores0"_"$logical_cores1"_"$logical_cores2"_"$logical_cores3
}

#Implementing this mechanism to jump to powersave governor if the script is not running
#as it would be an indication for devs for debug purposes.
fallback_setting()
{
	governor="powersave"
	for i in `ls -d /sys/devices/system/cpu/cpufreq/policy[0-9]*`
	do
		if [ -f $i/scaling_governor ] ; then
			echo $governor > $i/scaling_governor
		fi
	done
}

variant=$(get_num_logical_cores_in_physical_cluster "$1")
echo "CPU topology: ${variant}"
case "$variant" in
	"6_2__")
	/bin/sh /etc/init.kernel.post_boot-sun_default_6_2.sh
	;;
	"6_0__")
	/bin/sh /etc/init.kernel.post_boot-sun_6_0.sh
	;;
	"5_2__")
	/bin/sh /etc/init.kernel.post_boot-sun_5_2.sh
	;;
	*)
	echo "***WARNING***: Postboot script not present for the variant ${variant}"
	fallback_setting
	;;
esac
