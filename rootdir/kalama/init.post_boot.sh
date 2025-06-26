#! /bin/sh

#=============================================================================
#
# Copyright (c) 2009-2012, 2014-2019, The Linux Foundation. All rights reserved.
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
# Changes from Qualcomm Technologies, Inc. are provided under the following license:
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
			fi
		fi
	done
	echo ${logical_cores0:-0}"_"${logical_cores1:-0}"_"${logical_cores2:-0}
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

variant=$(get_num_logical_cores_in_physical_cluster)
echo "CPU topology: ${variant}"
if [ -e "/etc/init.post_boot_$variant.sh" ]; then
	/bin/sh "/etc/init.post_boot_$variant.sh"
elif [ -e "/etc/init.post_boot_default_$variant.sh" ]; then
	/bin/sh "/etc/init.post_boot_default_$variant.sh"
else
	echo "***WARNING***: Postboot script not present for the variant ${variant}"
	fallback_setting
fi
