#! /bin/sh
# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

# /vendor/lib/modules/ for dpk
if [ -d /vendor/lib/modules/$(uname -r) ]; then
	echo "dlkm for dpk"
	DLKM_DIR="/vendor/lib/modules/$(uname -r)"
	MODPROBE="/sbin/modprobe -d /vendor"
else
# /lib/modules/ for others
	DLKM_DIR="/lib/modules/$(uname -r)"
	MODPROBE="/sbin/modprobe"
fi

if [ $(lsmod |wc -l) -gt 1 ]; then
	loadedmodules_expr=$(lsmod | cut -d ' ' -f 1|tail -n +2 | sed -e 's/-/_/g' -e 's/^/-e /')
else
	echo "lsmod empty!"
	loadedmodules_expr="-e %"
fi

if [ ! -e ${DLKM_DIR}/modules.load ]; then
	echo "modules.load is missing."
	exit 1
fi

if [ -e ${DLKM_DIR}/modules.blocklist ]; then
	blocklist_expr="$(sed -n -e 's/blocklist \(.*\)/\1/p' ${DLKM_DIR}/modules.blocklist | sed -e 's/^/-e /')"
else
# Use pattern that won't be found in modules list so that all modules pass through grep below
	echo "modules.blocklist doesn't exist!"
	blocklist_expr="-e %"
fi

# Filter out modules in blocklist and already loaded modules - we would see unnecessary errors otherwise
load_modules=$(sed -e 's/.ko//g' ${DLKM_DIR}/modules.load| grep -w -v ${blocklist_expr}| grep -w -v ${loadedmodules_expr})
# load modules individually in case one of them fails to init
for module in ${load_modules}; do
	( ${MODPROBE} -a ${module} > /dev/null ) &
done
wait

exit 0
