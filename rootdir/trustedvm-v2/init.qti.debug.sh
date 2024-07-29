#! /bin/sh
#Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
#SPDX-License-Identifier: BSD-3-Clause-Clear

configure_memory_debug_parameters()
{
    #panic whenever oom is detected
    echo 2 > /proc/sys/vm/panic_on_oom
}

enable_debug()
{
    echo -n "Configuring post boot debug settings "
    configure_memory_debug_parameters
}

enable_debug
