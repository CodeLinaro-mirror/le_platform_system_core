#=============================================================================
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#
# Copyright (c) 2014-2017, The Linux Foundation. All rights reserved.
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
#=============================================================================

create_instance()
{
    local instance_dir=$1
    if [ ! -d $instance_dir ]
    then
        mkdir $instance_dir
    fi
}

enable_extra_ftrace_events()
{
    if [ "$debug_build" = false ]; then
        return
    fi
    local instance=/sys/kernel/tracing
    # fastrpc
    echo 1 > $instance/events/fastrpc/enable
    echo 1 > $instance/events/regulator/enable
    echo 1 > /sys/kernel/tracing/tracing_on
}

# function to disable SF tracing on perf config
sf_tracing_disablement()
{
    # disable SF tracing if its perf config
    if [ "$debug_build" = false ]
    then
        setprop debug.sf.enable_transaction_tracing 0
    fi
}

enable_buses_and_interconnect_tracefs_debug()
{
    tracefs=/sys/kernel/tracing
    # enable tracing for consolidate/debug builds, where debug_build is set true
    if [ "$debug_build" = true ]
    then
        setprop persist.vendor.tracing.enabled 1
    fi
    if [ -d $tracefs ] && [ "$(getprop persist.vendor.tracing.enabled)" -eq "1" ]; then
        create_instance $tracefs/instances/hsuart
        #UART
        echo 800 > $tracefs/instances/hsuart/buffer_size_kb
        echo 1 > $tracefs/instances/hsuart/events/serial/enable
        echo 1 > $tracefs/instances/hsuart/tracing_on
        #SPI
        create_instance $tracefs/instances/spi_qup
        echo 20 > $tracefs/instances/spi_qup/buffer_size_kb
        echo 1 > $tracefs/instances/spi_qup/events/qup_spi_trace/enable
        echo 1 > $tracefs/instances/spi_qup/tracing_on
        #I2C
        create_instance $tracefs/instances/i2c_qup
        echo 20 > $tracefs/instances/i2c_qup/buffer_size_kb
        echo 1 > $tracefs/instances/i2c_qup/events/qup_i2c_trace/enable
        echo 1 > $tracefs/instances/i2c_qup/tracing_on
        #SPI_CNSS
        create_instance $tracefs/instances/spi_cnss
        echo 800 > $tracefs/instances/spi_cnss/buffer_size_kb
        echo 1 > $tracefs/instances/spi_cnss/events/spi_cnss_trace/enable
        echo 1 > $tracefs/instances/spi_cnss/tracing_on
    fi
}
config_dcc_cpu_core()
{
    echo 0x17600238 1 > $DCC_PATH/config
    echo 0x17600240 11 > $DCC_PATH/config
    echo 0x17600530 1 > $DCC_PATH/config
    echo 0x1760051C 1 > $DCC_PATH/config
    echo 0x17600524 1 > $DCC_PATH/config
    echo 0x1760052C 1 > $DCC_PATH/config
    echo 0x17600518 1 > $DCC_PATH/config
    echo 0x17600520 1 > $DCC_PATH/config
    echo 0x17600528 1 > $DCC_PATH/config
    echo 0x17600404 3 > $DCC_PATH/config
    echo 0x1760041C 3 > $DCC_PATH/config
    echo 0x17600434 1 > $DCC_PATH/config
    echo 0x1760043C 1 > $DCC_PATH/config
    echo 0x17600440 1 > $DCC_PATH/config
    echo 0x17600044 1 > $DCC_PATH/config
    echo 0x17600500 1 > $DCC_PATH/config
    echo 0x17600504 5 > $DCC_PATH/config
    echo 0x17B90810 1 > $DCC_PATH/config
    echo 0x17B90814 1 > $DCC_PATH/config
    echo 0x17B90818 1 > $DCC_PATH/config
    echo 0x17BA0C50 1 > $DCC_PATH/config
    echo 0x17BA0814 1 > $DCC_PATH/config
    echo 0x17BA0C54 1 > $DCC_PATH/config
    echo 0x17BA0818 1 > $DCC_PATH/config
    echo 0x17BA0C58 1 > $DCC_PATH/config
    echo 0x0C201244 1 > $DCC_PATH/config
    echo 0x0C202244 1 > $DCC_PATH/config
}

config_dcc_gemnoc()
{
    echo 0x24100000 3 > $DCC_PATH/config
    echo 0x24100018 1 > $DCC_PATH/config
    echo 0x24100028 2 > $DCC_PATH/config
    echo 0x24101000 4 > $DCC_PATH/config
    echo 0x24101028 1 > $DCC_PATH/config
    echo 0x24101030 3 > $DCC_PATH/config
    echo 0x24101040 3 > $DCC_PATH/config
    echo 0x24103000 3 > $DCC_PATH/config
    echo 0x24103010 1 > $DCC_PATH/config
    echo 0x24103020 1 > $DCC_PATH/config
    echo 0x24103028 1 > $DCC_PATH/config
    echo 0x24103030 2 > $DCC_PATH/config

    #GEM_NOC_QNS_LLCC_POC_DBG
    echo 0x24100010 1 > $DCC_PATH/config
    echo 0x40 > $DCC_PATH/loop
    echo 0x24100038 1 > $DCC_PATH/config
    echo 0x24100030 2 > $DCC_PATH/config
    echo 0x24100030 2 > $DCC_PATH/config
    echo 0x24100030 2 > $DCC_PATH/config
    echo 0x24100030 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #GEM_NOC_QNS_CNOC_POC_DBG
    echo 0x24200010 1 > $DCC_PATH/config
    echo 0x10 > $DCC_PATH/loop
    echo 0x24200038 1 > $DCC_PATH/config
    echo 0x24200030 2 > $DCC_PATH/config
    echo 0x24200030 2 > $DCC_PATH/config
    echo 0x24200030 2 > $DCC_PATH/config
    echo 0x24200030 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #GEM_NOC_QNS_PCIE_POC_DBG
    echo 0x24200410 1 > $DCC_PATH/config
    echo 0x10 > $DCC_PATH/loop
    echo 0x24200438 1 > $DCC_PATH/config
    echo 0x24200430 2 > $DCC_PATH/config
    echo 0x24200430 2 > $DCC_PATH/config
    echo 0x24200430 2 > $DCC_PATH/config
    echo 0x24200430 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
}

config_dcc_lpm_pcu()
{
    echo 0x17800010 1 > $DCC_PATH/config
    echo 0x17800024 1 > $DCC_PATH/config
    echo 0x17800038 6 > $DCC_PATH/config
    echo 0x17800058 4 > $DCC_PATH/config
    echo 0x178000F0 2 > $DCC_PATH/config
    echo 0x17810010 1 > $DCC_PATH/config
    echo 0x17810024 1 > $DCC_PATH/config
    echo 0x17810038 6 > $DCC_PATH/config
    echo 0x17810058 4 > $DCC_PATH/config
    echo 0x178100F0 2 > $DCC_PATH/config
    echo 0x17820010 1 > $DCC_PATH/config
    echo 0x17820024 1 > $DCC_PATH/config
    echo 0x17820038 6 > $DCC_PATH/config
    echo 0x17820058 4 > $DCC_PATH/config
    echo 0x178200F0 2 > $DCC_PATH/config
    echo 0x17830010 1 > $DCC_PATH/config
    echo 0x17830024 1 > $DCC_PATH/config
    echo 0x17830038 6 > $DCC_PATH/config
    echo 0x17830058 4 > $DCC_PATH/config
    echo 0x178300F0 2 > $DCC_PATH/config
    echo 0x17840010 1 > $DCC_PATH/config
    echo 0x17840024 1 > $DCC_PATH/config
    echo 0x17840038 6 > $DCC_PATH/config
    echo 0x17840058 4 > $DCC_PATH/config
    echo 0x178400F0 2 > $DCC_PATH/config
}

config_dcc_global_cpr()
{
    echo 0x628000 2 > $DCC_PATH/config
    echo 0x6280E0 1 > $DCC_PATH/config
    echo 0x628100 1 > $DCC_PATH/config
    echo 0x628120 1 > $DCC_PATH/config
    echo 0x628140 1 > $DCC_PATH/config
    echo 0x628200 1 > $DCC_PATH/config
    echo 0x62B280 1 > $DCC_PATH/config
    echo 0x62B288 1 > $DCC_PATH/config
    echo 0x628810 3 > $DCC_PATH/config
    echo 0x62C000 2 > $DCC_PATH/config
    echo 0x62C0E0 1 > $DCC_PATH/config
    echo 0x62C100 1 > $DCC_PATH/config
    echo 0x62C120 1 > $DCC_PATH/config
    echo 0x62C140 1 > $DCC_PATH/config
    echo 0x62C200 1 > $DCC_PATH/config
    echo 0x62F280 1 > $DCC_PATH/config
    echo 0x62C80C 4 > $DCC_PATH/config
    echo 0x62F288 1 > $DCC_PATH/config
    echo 0x638000 2 > $DCC_PATH/config
    echo 0x6380E0 1 > $DCC_PATH/config
    echo 0x638100 1 > $DCC_PATH/config
    echo 0x638120 1 > $DCC_PATH/config
    echo 0x638140 1 > $DCC_PATH/config
    echo 0x638200 1 > $DCC_PATH/config
    echo 0x638810 1 > $DCC_PATH/config
    echo 0x638814 2 > $DCC_PATH/config
    echo 0x63B288 1 > $DCC_PATH/config
    echo 0x63C000 2 > $DCC_PATH/config
    echo 0x63C0E0 1 > $DCC_PATH/config
    echo 0x63C100 1 > $DCC_PATH/config
    echo 0x63C120 1 > $DCC_PATH/config
    echo 0x63C140 1 > $DCC_PATH/config
    echo 0x63C810 3 > $DCC_PATH/config
    echo 0x63F288 1 > $DCC_PATH/config
    echo 0x3D9A000 2 > $DCC_PATH/config
    echo 0x3D9A0E0 1 > $DCC_PATH/config
    echo 0x3D9A100 1 > $DCC_PATH/config
    echo 0x3D9A120 1 > $DCC_PATH/config
    echo 0x3D9A140 1 > $DCC_PATH/config
    echo 0x3D9A810 3 > $DCC_PATH/config
    echo 0x3D9D288 1 > $DCC_PATH/config
    echo 0x21A70000 2 > $DCC_PATH/config
    echo 0x21A700E0 1 > $DCC_PATH/config
    echo 0x21A70100 1 > $DCC_PATH/config
    echo 0x21A70120 1 > $DCC_PATH/config
    echo 0x21A70140 1 > $DCC_PATH/config
    echo 0x21A70810 3 > $DCC_PATH/config
    echo 0x21A73288 1 > $DCC_PATH/config
    echo 0x351C8970 28 > $DCC_PATH/config
    echo 0x351C20D4 12 > $DCC_PATH/config
}

config_dcc_apc_cpr()
{
    echo 0x17900900 1 > $DCC_PATH/config
    echo 0x17900C14 1 > $DCC_PATH/config
    echo 0x17901C18 1 > $DCC_PATH/config
    echo 0x17901900 1 > $DCC_PATH/config
    echo 0x17901C14 1 > $DCC_PATH/config
    echo 0x17901908 1 > $DCC_PATH/config
    echo 0x17D80000 7 > $DCC_PATH/config
    echo 0x17D80100 1 > $DCC_PATH/config
    echo 0x17D98000 10 > $DCC_PATH/config
    echo 0x17D90000 4 > $DCC_PATH/config
    echo 0x17D90014 26 > $DCC_PATH/config
    echo 0x17D90080 5 > $DCC_PATH/config
    echo 0x17D900B0 1 > $DCC_PATH/config
    echo 0x17D900B8 2 > $DCC_PATH/config
    echo 0x17D900D0 9 > $DCC_PATH/config
    echo 0x17D90100 1 > $DCC_PATH/config
    echo 0x17D90200 1 > $DCC_PATH/config
    echo 0x17D90300 5 > $DCC_PATH/config
    echo 0x17D90320 1 > $DCC_PATH/config
    echo 0x17D90340 1 > $DCC_PATH/config
    echo 0x17D9034C 2 > $DCC_PATH/config
    echo 0x17D90360 5 > $DCC_PATH/config
    echo 0x17D903B0 6 > $DCC_PATH/config
    echo 0x17D903E0 2 > $DCC_PATH/config
    echo 0x17D90404 1 > $DCC_PATH/config
    echo 0x17D90410 1 > $DCC_PATH/config
    echo 0x17D91000 4 > $DCC_PATH/config
    echo 0x17D91014 26 > $DCC_PATH/config
    echo 0x17D91080 5 > $DCC_PATH/config
    echo 0x17D910B0 1 > $DCC_PATH/config
    echo 0x17D910B8 2 > $DCC_PATH/config
    echo 0x17D910D0 9 > $DCC_PATH/config
    echo 0x17D91100 1 > $DCC_PATH/config
    echo 0x17D91200 1 > $DCC_PATH/config
    echo 0x17D91300 5 > $DCC_PATH/config
    echo 0x17D91320 1 > $DCC_PATH/config
    echo 0x17D91340 1 > $DCC_PATH/config
    echo 0x17D9134C 1 > $DCC_PATH/config
    echo 0x17D91350 1 > $DCC_PATH/config
    echo 0x17D91360 5 > $DCC_PATH/config
    echo 0x17D913B0 6 > $DCC_PATH/config
    echo 0x17D913E0 2 > $DCC_PATH/config
    echo 0x17D91404 1 > $DCC_PATH/config
    echo 0x17D91410 1 > $DCC_PATH/config
    echo 0x17D92000 4 > $DCC_PATH/config
    echo 0x17D92014 26 > $DCC_PATH/config
    echo 0x17D92080 5 > $DCC_PATH/config
    echo 0x17D920B0 1 > $DCC_PATH/config
    echo 0x17D920B8 2 > $DCC_PATH/config
    echo 0x17D920D0 9 > $DCC_PATH/config
    echo 0x17D92100 1 > $DCC_PATH/config
    echo 0x17D92200 1 > $DCC_PATH/config
    echo 0x17D92300 5 > $DCC_PATH/config
    echo 0x17D92320 1 > $DCC_PATH/config
    echo 0x17D92340 1 > $DCC_PATH/config
    echo 0x17D9234C 2 > $DCC_PATH/config
    echo 0x17D92360 5 > $DCC_PATH/config
    echo 0x17D923B0 6 > $DCC_PATH/config
    echo 0x17D923E0 2 > $DCC_PATH/config
    echo 0x17D92404 1 > $DCC_PATH/config
    echo 0x17D92410 1 > $DCC_PATH/config
    echo 0x17BA0810 3 > $DCC_PATH/config
    echo 0x17BA3A84 1 > $DCC_PATH/config
    echo 0x17B90810 3 > $DCC_PATH/config
    echo 0x17B93A84 1 > $DCC_PATH/config
    echo 0x17B00000 4 > $DCC_PATH/config
    echo 0x17B00014 10 > $DCC_PATH/config
    echo 0x17B000CC 1 > $DCC_PATH/config
    echo 0x17B000F4 9 > $DCC_PATH/config
    echo 0x17A94004 1 > $DCC_PATH/config
    echo 0x17A9400C 1 > $DCC_PATH/config
    echo 0x17A9401C 1 > $DCC_PATH/config
    echo 0x17A90004 1 > $DCC_PATH/config
    echo 0x17A9000C 1 > $DCC_PATH/config
    echo 0x17A9001C 1 > $DCC_PATH/config
    echo 0x17A92004 1 > $DCC_PATH/config
    echo 0x17A9200C 1 > $DCC_PATH/config
    echo 0x17A9201C 1 > $DCC_PATH/config
}

config_dcc_mach9()
{
    echo 0x24A08050 5 > $DCC_PATH/config
    echo 0x24A08070 1 > $DCC_PATH/config
    echo 0x24A08090 4 > $DCC_PATH/config
    echo 0x24A080BC 1 > $DCC_PATH/config
    echo 0x24A09100 1 > $DCC_PATH/config
    echo 0x24A09170 1 > $DCC_PATH/config
    echo 0x24A09180 1 > $DCC_PATH/config
    echo 0x24A09184 1 > $DCC_PATH/config
    echo 0x24A091A0 1 > $DCC_PATH/config
    echo 0x24A091B0 1 > $DCC_PATH/config
    echo 0x24A091C0 1 > $DCC_PATH/config
    echo 0x24A091C4 1 > $DCC_PATH/config
    echo 0x24A091E0 1 > $DCC_PATH/config
    echo 0x24A09400 1 > $DCC_PATH/config
    echo 0x24A0B034 4 > $DCC_PATH/config
    echo 0x24A0B734 2 > $DCC_PATH/config
    echo 0x24A0B744 1 > $DCC_PATH/config
    echo 0x24A0B900 4 > $DCC_PATH/config
    echo 0x24A0D400 1 > $DCC_PATH/config
    echo 0x24860000 4 > $DCC_PATH/config
    echo 0x24860100 2 > $DCC_PATH/config
    echo 0x2486020C 1 > $DCC_PATH/config
    echo 0x24860304 1 > $DCC_PATH/config
    echo 0x24860400 1 > $DCC_PATH/config
    echo 0x24860500 6 > $DCC_PATH/config
    echo 0x24861000 8 > $DCC_PATH/config
    echo 0x24861030 1 > $DCC_PATH/config
    echo 0x24864000 1 > $DCC_PATH/config
    echo 0x24864040 1 > $DCC_PATH/config
    echo 0x2486400C 1 > $DCC_PATH/config
    echo 0x24864010 1 > $DCC_PATH/config
    echo 0x2486401C 1 > $DCC_PATH/config
    echo 0x24864020 1 > $DCC_PATH/config
    echo 0x2486402C 1 > $DCC_PATH/config
    echo 0x24864030 1 > $DCC_PATH/config
    echo 0x2486403C 1 > $DCC_PATH/config
    echo 0x24864040 1 > $DCC_PATH/config
    echo 0x2486404C 1 > $DCC_PATH/config
    echo 0x24864050 2 > $DCC_PATH/config
    echo 0x24864060 3 > $DCC_PATH/config
    echo 0x24864070 5 > $DCC_PATH/config
    echo 0x24864090 2 > $DCC_PATH/config
    echo 0x248640A0 1 > $DCC_PATH/config
    echo 0x248640B0 1 > $DCC_PATH/config
    echo 0x248640C0 1 > $DCC_PATH/config
    echo 0x248640D0 1 > $DCC_PATH/config
    echo 0x248640E0 1 > $DCC_PATH/config
    echo 0x248640E8 5 > $DCC_PATH/config
    echo 0x248650A4 4 > $DCC_PATH/config
    echo 0x248650B8 4 > $DCC_PATH/config
    echo 0x248650D4 1 > $DCC_PATH/config
    echo 0x24866004 3 > $DCC_PATH/config
    echo 0x24866014 2 > $DCC_PATH/config
    echo 0x24866020 1 > $DCC_PATH/config
    echo 0x248660E0 2 > $DCC_PATH/config
    echo 0x248660F0 1 > $DCC_PATH/config
    echo 0x24866100 1 > $DCC_PATH/config
    echo 0x24866120 1 > $DCC_PATH/config
    echo 0x24866140 1 > $DCC_PATH/config
    echo 0x24866160 1 > $DCC_PATH/config
    echo 0x24866180 1 > $DCC_PATH/config
    echo 0x24866190 1 > $DCC_PATH/config
    echo 0x248661A0 1 > $DCC_PATH/config
    echo 0x248661B0 1 > $DCC_PATH/config
    echo 0x248661C0 1 > $DCC_PATH/config
    echo 0x248661C8 1 > $DCC_PATH/config
    echo 0x248661D0 6 > $DCC_PATH/config
    echo 0x24867000 3 > $DCC_PATH/config
    echo 0x24867048 1 > $DCC_PATH/config
    echo 0x24867088 1 > $DCC_PATH/config
    echo 0x2486801C 1 > $DCC_PATH/config
    echo 0x24868020 9 > $DCC_PATH/config
    echo 0x24868050 3 > $DCC_PATH/config
    echo 0x24868060 1 > $DCC_PATH/config
    echo 0x24868080 2 > $DCC_PATH/config
    echo 0x248680F0 1 > $DCC_PATH/config
    echo 0x24868100 14 > $DCC_PATH/config
    echo 0x24868200 5 > $DCC_PATH/config
    echo 0x24868218 1 > $DCC_PATH/config
    echo 0x248690FC 1 > $DCC_PATH/config
    echo 0x2486C000 2 > $DCC_PATH/config
    echo 0x2486C014 1 > $DCC_PATH/config
    echo 0x2486C024 3 > $DCC_PATH/config
    echo 0x2486C054 1 > $DCC_PATH/config
    echo 0x2486C05C 3 > $DCC_PATH/config
    echo 0x2486C088 3 > $DCC_PATH/config
    echo 0x2486C0D0 1 > $DCC_PATH/config
    echo 0x2486C0F0 1 > $DCC_PATH/config
    echo 0x2486C100 1 > $DCC_PATH/config
    echo 0x2486C110 1 > $DCC_PATH/config
    echo 0x2486C114 1 > $DCC_PATH/config
    echo 0x2486C134 1 > $DCC_PATH/config
    echo 0x2486C160 2 > $DCC_PATH/config
    echo 0x2486D064 1 > $DCC_PATH/config
    echo 0x24870008 13 > $DCC_PATH/config
    echo 0x24870048 5 > $DCC_PATH/config
    echo 0x24870060 12 > $DCC_PATH/config
    echo 0x2487203C 14 > $DCC_PATH/config
    echo 0x2487208C 4 > $DCC_PATH/config
    echo 0x248720AC 2 > $DCC_PATH/config
    echo 0x248720B8 3 > $DCC_PATH/config
    echo 0x248720F0 10 > $DCC_PATH/config
    echo 0x248722FC 1 > $DCC_PATH/config
    echo 0x24872324 14 > $DCC_PATH/config
    echo 0x24872408 1 > $DCC_PATH/config
    echo 0x24872410 1 > $DCC_PATH/config
    echo 0x24872438 4 > $DCC_PATH/config
    echo 0x248730A8 1 > $DCC_PATH/config
    echo 0x24874038 4 > $DCC_PATH/config
    echo 0x24874060 7 > $DCC_PATH/config
    echo 0x24874804 1 > $DCC_PATH/config
    echo 0x24875000 1 > $DCC_PATH/config
    echo 0x24875010 1 > $DCC_PATH/config
    echo 0x24875020 1 > $DCC_PATH/config
    echo 0x24875030 1 > $DCC_PATH/config
    echo 0x24875040 1 > $DCC_PATH/config
    echo 0x24875050 1 > $DCC_PATH/config
    echo 0x24875060 1 > $DCC_PATH/config
    echo 0x24875070 1 > $DCC_PATH/config
    echo 0x24875080 1 > $DCC_PATH/config
    echo 0x24875090 1 > $DCC_PATH/config
    echo 0x24875100 1 > $DCC_PATH/config
    echo 0x24875110 1 > $DCC_PATH/config
    echo 0x24875120 1 > $DCC_PATH/config
    echo 0x24875130 1 > $DCC_PATH/config
    echo 0x24876000 3 > $DCC_PATH/config
    echo 0x24876010 6 > $DCC_PATH/config
    echo 0x2487602C 7 > $DCC_PATH/config
    echo 0x2487604C 3 > $DCC_PATH/config
    echo 0x24876060 2 > $DCC_PATH/config
    echo 0x24876070 1 > $DCC_PATH/config
    echo 0x24876100 1 > $DCC_PATH/config
    echo 0x24878004 6 > $DCC_PATH/config
    echo 0x24878024 4 > $DCC_PATH/config
    echo 0x24878040 1 > $DCC_PATH/config
    echo 0x24878048 2 > $DCC_PATH/config
    echo 0x24879064 1 > $DCC_PATH/config
    echo 0x2487C000 2 > $DCC_PATH/config
    echo 0x2487C010 7 > $DCC_PATH/config
    echo 0x2487C030 1 > $DCC_PATH/config
    echo 0x2487C038 1 > $DCC_PATH/config
    echo 0x2487C040 3 > $DCC_PATH/config
    echo 0x2487C050 3 > $DCC_PATH/config
    echo 0x2487C060 3 > $DCC_PATH/config
    echo 0x2487C070 3 > $DCC_PATH/config
    echo 0x2487C080 1 > $DCC_PATH/config
    echo 0x2487C100 4 > $DCC_PATH/config
    echo 0x2487C208 4 > $DCC_PATH/config
    echo 0x24880004 1 > $DCC_PATH/config
    echo 0x24880010 2 > $DCC_PATH/config
    echo 0x24880020 1 > $DCC_PATH/config
    echo 0x24880028 2 > $DCC_PATH/config
    echo 0x24881054 1 > $DCC_PATH/config
    echo 0x24882008 6 > $DCC_PATH/config
    echo 0x24882030 25 > $DCC_PATH/config
    echo 0x248820A0 1 > $DCC_PATH/config
    echo 0x248820A8 3 > $DCC_PATH/config
    echo 0x248820E0 1 > $DCC_PATH/config
    echo 0x248820F4 42 > $DCC_PATH/config
    echo 0x24890000 1 > $DCC_PATH/config
    echo 0x24891000 8 > $DCC_PATH/config
    echo 0x24892008 6 > $DCC_PATH/config
    echo 0x24893000 8 > $DCC_PATH/config
    echo 0x2489302C 4 > $DCC_PATH/config
    echo 0x24893044 1 > $DCC_PATH/config
    echo 0x24894000 8 > $DCC_PATH/config
    echo 0x2489402C 4 > $DCC_PATH/config
    echo 0x24894044 1 > $DCC_PATH/config
    echo 0x24895004 6 > $DCC_PATH/config
    echo 0x24896008 1 > $DCC_PATH/config
    echo 0x24897010 1 > $DCC_PATH/config
    echo 0x24897020 1 > $DCC_PATH/config
    echo 0x24897030 1 > $DCC_PATH/config
    echo 0x24897040 1 > $DCC_PATH/config
    echo 0x24897050 1 > $DCC_PATH/config
    echo 0x24897060 1 > $DCC_PATH/config
    echo 0x24897070 1 > $DCC_PATH/config
    echo 0x24897080 1 > $DCC_PATH/config
    echo 0x24897090 1 > $DCC_PATH/config
    echo 0x248970A0 1 > $DCC_PATH/config
    echo 0x24897110 1 > $DCC_PATH/config
    echo 0x24897120 1 > $DCC_PATH/config
    echo 0x24897130 1 > $DCC_PATH/config
    echo 0x24897140 1 > $DCC_PATH/config
    echo 0x248A6000 17 > $DCC_PATH/config
    echo 0x248A6048 3 > $DCC_PATH/config
    echo 0x248A605C 1 > $DCC_PATH/config
    echo 0x248A6068 2 > $DCC_PATH/config
    echo 0x248A6100 1 > $DCC_PATH/config
    echo 0x248A6114 1 > $DCC_PATH/config
    echo 0x248A611C 4 > $DCC_PATH/config
    echo 0x248A6168 1 > $DCC_PATH/config
    echo 0x248A61A8 1 > $DCC_PATH/config
    echo 0x248A6200 1 > $DCC_PATH/config
    echo 0x248A6208 4 > $DCC_PATH/config
    echo 0x248A7004 1 > $DCC_PATH/config
    echo 0x248A7010 5 > $DCC_PATH/config
    echo 0x248A7028 22 > $DCC_PATH/config
    echo 0x248A7084 8 > $DCC_PATH/config
    echo 0x248A718C 3 > $DCC_PATH/config
    echo 0x248A71B0 1 > $DCC_PATH/config
    echo 0x248A7204 15 > $DCC_PATH/config
    echo 0x248A7244 1 > $DCC_PATH/config
    echo 0x248B0000 4 > $DCC_PATH/config
    echo 0x248B0100 2 > $DCC_PATH/config
    echo 0x248B020C 1 > $DCC_PATH/config
    echo 0x248B0304 1 > $DCC_PATH/config
    echo 0x248B0400 1 > $DCC_PATH/config
    echo 0x248B0500 6 > $DCC_PATH/config
    echo 0x248B1000 2 > $DCC_PATH/config
    echo 0x248B100C 1 > $DCC_PATH/config
    echo 0x248B1014 3 > $DCC_PATH/config
    echo 0x248B1030 1 > $DCC_PATH/config
    echo 0x248E0000 1 > $DCC_PATH/config
    echo 0x248E002C 1 > $DCC_PATH/config
    echo 0x248E0030 2 > $DCC_PATH/config
    echo 0x248E0058 1 > $DCC_PATH/config
    echo 0x248E006C 2 > $DCC_PATH/config
    echo 0x248E009C 2 > $DCC_PATH/config
    echo 0x248E00A8 3 > $DCC_PATH/config
    echo 0x248E00B8 1 > $DCC_PATH/config
    echo 0x248E00C0 7 > $DCC_PATH/config
    echo 0x248E00E0 1 > $DCC_PATH/config
    echo 0x248E00E8 1 > $DCC_PATH/config
    echo 0x248E00F0 1 > $DCC_PATH/config
    echo 0x248E00F8 1 > $DCC_PATH/config
    echo 0x248E0100 1 > $DCC_PATH/config
    echo 0x248E0108 1 > $DCC_PATH/config
    echo 0x248E0110 1 > $DCC_PATH/config
    echo 0x248E0118 1 > $DCC_PATH/config
    echo 0x248E0120 1 > $DCC_PATH/config
    echo 0x248E0128 1 > $DCC_PATH/config
    echo 0x248E012C 1 > $DCC_PATH/config
    echo 0x248E0130 12 > $DCC_PATH/config
    echo 0x248E0164 1 > $DCC_PATH/config
    echo 0x248E01E8 2 > $DCC_PATH/config
    echo 0x248E01F4 2 > $DCC_PATH/config
    echo 0x248E0210 3 > $DCC_PATH/config
    echo 0x248E0220 1 > $DCC_PATH/config
    echo 0x248E0228 1 > $DCC_PATH/config
    echo 0x248E0230 1 > $DCC_PATH/config
    echo 0x248E025C 1 > $DCC_PATH/config
    echo 0x248E0264 8 > $DCC_PATH/config
    echo 0x248E0288 1 > $DCC_PATH/config
    echo 0x248E0290 1 > $DCC_PATH/config
    echo 0x248E0298 1 > $DCC_PATH/config
    echo 0x248E02A0 1 > $DCC_PATH/config
    echo 0x248E02A8 1 > $DCC_PATH/config
    echo 0x248E02B0 1 > $DCC_PATH/config
    echo 0x248E02B8 1 > $DCC_PATH/config
    echo 0x248E02D0 1 > $DCC_PATH/config
    echo 0x248E02DC 1 > $DCC_PATH/config
    echo 0x248E0300 21 > $DCC_PATH/config
    echo 0x248E0358 2 > $DCC_PATH/config
    echo 0x248E0364 2 > $DCC_PATH/config
    echo 0x248E1004 25 > $DCC_PATH/config
    echo 0x248E1068 1 > $DCC_PATH/config
    echo 0x248E1070 3 > $DCC_PATH/config
    echo 0x248E1084 4 > $DCC_PATH/config
    echo 0x248E3004 1 > $DCC_PATH/config
    echo 0x248E300C 1 > $DCC_PATH/config
    echo 0x248E4008 4 > $DCC_PATH/config
    echo 0x248E401C 4 > $DCC_PATH/config
    echo 0x248E4030 4 > $DCC_PATH/config
    echo 0x248E41C0 1 > $DCC_PATH/config
    echo 0x248E600C 1 > $DCC_PATH/config
    echo 0x248E6010 4 > $DCC_PATH/config
    echo 0x248E700C 1 > $DCC_PATH/config
    echo 0x248E7010 4 > $DCC_PATH/config
    echo 0x248E9004 1 > $DCC_PATH/config
    echo 0x248E9010 3 > $DCC_PATH/config
    echo 0x248E9020 3 > $DCC_PATH/config
    echo 0x248E9030 3 > $DCC_PATH/config
    echo 0x248E9040 3 > $DCC_PATH/config
    echo 0x248E9050 3 > $DCC_PATH/config
    echo 0x248EA004 1 > $DCC_PATH/config
    echo 0x248EA010 3 > $DCC_PATH/config
    echo 0x248EA020 3 > $DCC_PATH/config
    echo 0x248EA030 3 > $DCC_PATH/config
    echo 0x248EA040 3 > $DCC_PATH/config
    echo 0x248EA050 3 > $DCC_PATH/config
    echo 0x248F000C 2 > $DCC_PATH/config
    echo 0x248F001C 1 > $DCC_PATH/config
    echo 0x248F0050 1 > $DCC_PATH/config
    echo 0x248F0058 1 > $DCC_PATH/config
    echo 0x248F0060 1 > $DCC_PATH/config
}

config_dcc_mccc()
{
    echo 0x240BA000 2 > $DCC_PATH/config
    echo 0x240BA020 1 > $DCC_PATH/config
    echo 0x240BA288 8 > $DCC_PATH/config
    echo 0x240BA2C0 1 > $DCC_PATH/config
    echo 0x240BA2C4 1 > $DCC_PATH/config
}

config_dcc_dpcc()
{
    echo 0x240A8000 24 > $DCC_PATH/config
    echo 0x240A8064 12 > $DCC_PATH/config
    echo 0x240A8098 37 > $DCC_PATH/config
    echo 0x240A813C 2 > $DCC_PATH/config
    echo 0x240A8154 18 > $DCC_PATH/config
    echo 0x240A81A8 1 > $DCC_PATH/config
    echo 0x240A81B0 16 > $DCC_PATH/config
    echo 0x240A82C0 3 > $DCC_PATH/config
    echo 0x240A82D8 1 > $DCC_PATH/config
    echo 0x240A82E0 16 > $DCC_PATH/config
    echo 0x240A83F0 9 > $DCC_PATH/config
    echo 0x240A9000 2 > $DCC_PATH/config
    echo 0x240A9010 2 > $DCC_PATH/config
    echo 0x240A9020 3 > $DCC_PATH/config
    echo 0x240A9034 2 > $DCC_PATH/config
    echo 0x240A9040 24 > $DCC_PATH/config
    echo 0x240A9100 10 > $DCC_PATH/config
    echo 0x240A9130 7 > $DCC_PATH/config
    echo 0x240A9150 7 > $DCC_PATH/config
    echo 0x240A9178 1 > $DCC_PATH/config
    echo 0x240A91AC 1 > $DCC_PATH/config
    echo 0x240A91B4 1 > $DCC_PATH/config
    echo 0x240A91C8 2 > $DCC_PATH/config
    echo 0x240A9200 7 > $DCC_PATH/config
    echo 0x240A9220 1 > $DCC_PATH/config
    echo 0x240A9244 9 > $DCC_PATH/config
    echo 0x240A9280 2 > $DCC_PATH/config
    echo 0x240A9294 7 > $DCC_PATH/config
    echo 0x240A92B4 5 > $DCC_PATH/config
    echo 0x240A92D0 2 > $DCC_PATH/config
    echo 0x240A92E0 4 > $DCC_PATH/config
    echo 0x240A92F4 3 > $DCC_PATH/config
    echo 0x240AA000 2 > $DCC_PATH/config
    echo 0x240AB000 19 > $DCC_PATH/config
    echo 0x24A00000 3 > $DCC_PATH/config
    echo 0x24A00030 6 > $DCC_PATH/config
    echo 0x24A00304 1 > $DCC_PATH/config
    echo 0x24A004BC 1 > $DCC_PATH/config
    echo 0x24A00700 1 > $DCC_PATH/config
    echo 0x24A00708 5 > $DCC_PATH/config
    echo 0x24A00720 1 > $DCC_PATH/config
    echo 0x24A00740 1 > $DCC_PATH/config
    echo 0x24A00748 1 > $DCC_PATH/config
    echo 0x24A007A0 1 > $DCC_PATH/config
    echo 0x24A007B0 3 > $DCC_PATH/config
    echo 0x24A007D0 3 > $DCC_PATH/config
    echo 0x24A007E0 2 > $DCC_PATH/config
    echo 0x24A007F0 2 > $DCC_PATH/config
    echo 0x24A01418 4 > $DCC_PATH/config
    echo 0x24A0142C 2 > $DCC_PATH/config
    echo 0x24A01550 1 > $DCC_PATH/config
    echo 0x24A02700 2 > $DCC_PATH/config
    echo 0x24A02710 1 > $DCC_PATH/config
    echo 0x24A02718 1 > $DCC_PATH/config
    echo 0x24A02720 22 > $DCC_PATH/config
    echo 0x24A03400 11 > $DCC_PATH/config
    echo 0x24A03448 1 > $DCC_PATH/config
    echo 0x24A03480 1 > $DCC_PATH/config
    echo 0x24A04900 7 > $DCC_PATH/config
    echo 0x24A04928 1 > $DCC_PATH/config
    echo 0x24A04938 3 > $DCC_PATH/config
    echo 0x24A04950 1 > $DCC_PATH/config
    echo 0x24A04960 1 > $DCC_PATH/config
    echo 0x24A04970 7 > $DCC_PATH/config
    echo 0x24A04A00 7 > $DCC_PATH/config
    echo 0x24A04B00 24 > $DCC_PATH/config
    echo 0x24A04C00 25 > $DCC_PATH/config
    echo 0x24A04D00 6 > $DCC_PATH/config
    echo 0x24A04E00 1 > $DCC_PATH/config
    echo 0x24A04E10 1 > $DCC_PATH/config
    echo 0x24A04E20 1 > $DCC_PATH/config
    echo 0x24A04E30 1 > $DCC_PATH/config
    echo 0x24A04E40 1 > $DCC_PATH/config
    echo 0x24A05110 1 > $DCC_PATH/config
    echo 0x24A05210 1 > $DCC_PATH/config
    echo 0x24A05230 1 > $DCC_PATH/config
    echo 0x24A053B0 1 > $DCC_PATH/config
    echo 0x24A053B4 1 > $DCC_PATH/config
    echo 0x24A053C0 1 > $DCC_PATH/config
    echo 0x24A053E0 1 > $DCC_PATH/config
    echo 0x24A05400 4 > $DCC_PATH/config
    echo 0x24A05480 4 > $DCC_PATH/config
    echo 0x24A05A38 2 > $DCC_PATH/config
    echo 0x24A05AC0 1 > $DCC_PATH/config
    echo 0x24A05AD0 1 > $DCC_PATH/config
    echo 0x24A05AE0 4 > $DCC_PATH/config
    echo 0x24A05B20 4 > $DCC_PATH/config
    echo 0x24A05C00 18 > $DCC_PATH/config
    echo 0x24A05C4C 6 > $DCC_PATH/config
    echo 0x24A05C70 18 > $DCC_PATH/config
    echo 0x24A05CC0 15 > $DCC_PATH/config
    echo 0x24A06728 13 > $DCC_PATH/config
}

config_dcc_shrm()
{
    echo 0x24076000 1 > $DCC_PATH/config
    echo 0x24076008 1 > $DCC_PATH/config
    echo 0x24076070 1 > $DCC_PATH/config
    echo 0x24076090 1 > $DCC_PATH/config
    echo 0x240760B4 1 > $DCC_PATH/config
    echo 0x24076948 1 > $DCC_PATH/config
    echo 0x24076B00 3 > $DCC_PATH/config
    echo 0x24076D00 3 > $DCC_PATH/config
    echo 0x2407700C 1 > $DCC_PATH/config
    echo 0x2407703C 1 > $DCC_PATH/config
    echo 0x24079008 1 > $DCC_PATH/config
    echo 0x24079018 1 > $DCC_PATH/config
    echo 0x24080004 3 > $DCC_PATH/config
    echo 0x24080020 18 > $DCC_PATH/config
    echo 0x24080074 8 > $DCC_PATH/config
    echo 0x2408009C 5 > $DCC_PATH/config
    echo 0x240800B4 9 > $DCC_PATH/config
    echo 0x240800FC 6 > $DCC_PATH/config
    echo 0x2408012C 1 > $DCC_PATH/config
    echo 0x24080140 5 > $DCC_PATH/config
    echo 0x24080164 1 > $DCC_PATH/config
    echo 0x24080170 20 > $DCC_PATH/config
    echo 0x24080208 4 > $DCC_PATH/config
    echo 0x24080220 5 > $DCC_PATH/config
    echo 0x24080240 1 > $DCC_PATH/config
    echo 0x24080250 2 > $DCC_PATH/config
    echo 0x24080290 10 > $DCC_PATH/config
    echo 0x24B81E64 1 > $DCC_PATH/config
    echo 0x24B81EA4 2 > $DCC_PATH/config
    echo 0x24B81F2C 3 > $DCC_PATH/config
    echo 0x24B84E64 1 > $DCC_PATH/config
    echo 0x24B84EA4 2 > $DCC_PATH/config
    echo 0x24B84F2C 3 > $DCC_PATH/config
    echo 0x24B8627C 1 > $DCC_PATH/config
    echo 0x24B86294 1 > $DCC_PATH/config
    echo 0x24B864EC 1 > $DCC_PATH/config
    echo 0x24B864F4 1 > $DCC_PATH/config
    echo 0x24B86514 1 > $DCC_PATH/config
    echo 0x24B8651C 1 > $DCC_PATH/config
    echo 0x24B86524 1 > $DCC_PATH/config
    echo 0x24B86554 1 > $DCC_PATH/config
    echo 0x24B8655C 1 > $DCC_PATH/config
    echo 0x24B86564 1 > $DCC_PATH/config
    echo 0x24099000 1 > $DCC_PATH/config
    echo 0x24099008 1 > $DCC_PATH/config
    echo 0x240A92A4 1 > $DCC_PATH/config
    echo 0x240A91C8 1 > $DCC_PATH/config
    echo 0x240A9168 1 > $DCC_PATH/config
    echo 0x240A9178 1 > $DCC_PATH/config
    echo 0x240A0018 1 > $DCC_PATH/config
    echo 0x240A1018 1 > $DCC_PATH/config
    echo 0x240A0000 1 > $DCC_PATH/config
    echo 0x240A1000 1 > $DCC_PATH/config
    echo 0x240A9134 1 > $DCC_PATH/config
    echo 0x240BA164 1 > $DCC_PATH/config
    echo 0x240BA160 1 > $DCC_PATH/config
    echo 0x24B865D0 1 > $DCC_PATH/config
    echo 0x24B86D64 1 > $DCC_PATH/config
    echo 0x24B86D68 1 > $DCC_PATH/config
    echo 0x24B86D6C 1 > $DCC_PATH/config
    echo 0x24B8746C 1 > $DCC_PATH/config
    echo 0x24B86720 1 > $DCC_PATH/config
    echo 0x24B86724 1 > $DCC_PATH/config
    echo 0x24A06060 1 > $DCC_PATH/config
    echo 0x24A06604 1 > $DCC_PATH/config
    echo 0x24A06030 1 > $DCC_PATH/config
    echo 0x24A05704 1 > $DCC_PATH/config
    echo 0x24A05BC0 1 > $DCC_PATH/config
    echo 0x24A03120 1 > $DCC_PATH/config
    echo 0x24A05BC4 1 > $DCC_PATH/config
    echo 0x24A00330 1 > $DCC_PATH/config
    echo 0x24A00338 1 > $DCC_PATH/config
    echo 0x24A05BC8 1 > $DCC_PATH/config
    echo 0x24A05BE0 1 > $DCC_PATH/config
    echo 0x24A05BE8 1 > $DCC_PATH/config
    echo 0x24A05BF0 1 > $DCC_PATH/config
    echo 0x24A05BF0 1 > $DCC_PATH/config
    echo 0x24A05A1C 1 > $DCC_PATH/config
    echo 0x24076100 1 > $DCC_PATH/config
    echo 0x24076104 1 > $DCC_PATH/config
    echo 0x24076108 1 > $DCC_PATH/config
    echo 0x24076100 1 > $DCC_PATH/config
    echo 0x2407610C 1 > $DCC_PATH/config
    echo 0x24076110 1 > $DCC_PATH/config
    echo 0x24076114 1 > $DCC_PATH/config
    echo 0x24076118 1 > $DCC_PATH/config
    echo 0x2407611C 1 > $DCC_PATH/config
    echo 0x24076120 1 > $DCC_PATH/config
    echo 0x24076124 1 > $DCC_PATH/config
    echo 0x24076128 1 > $DCC_PATH/config
    echo 0x2407612C 1 > $DCC_PATH/config
    echo 0x24076130 1 > $DCC_PATH/config
    echo 0x24076134 1 > $DCC_PATH/config
    echo 0x24076138 1 > $DCC_PATH/config
}

config_dcc_ddrphy()
{
    echo 0x24B86614 1 > $DCC_PATH/config
    echo 0x24B8661C 1 > $DCC_PATH/config
    echo 0x24B86654 1 > $DCC_PATH/config
    echo 0x24B869E0 1 > $DCC_PATH/config
    echo 0x24B869F0 1 > $DCC_PATH/config
    echo 0x24B86A24 1 > $DCC_PATH/config
    echo 0x24B86A2C 1 > $DCC_PATH/config
    echo 0x24B86A34 1 > $DCC_PATH/config
    echo 0x24B86A3C 1 > $DCC_PATH/config
    echo 0x24B86A6C 2 > $DCC_PATH/config
    echo 0x24B86AA4 1 > $DCC_PATH/config
    echo 0x24B86AAC 1 > $DCC_PATH/config
    echo 0x24B86AE4 1 > $DCC_PATH/config
    echo 0x24B86AEC 1 > $DCC_PATH/config
    echo 0x24B86B24 1 > $DCC_PATH/config
    echo 0x24B87178 1 > $DCC_PATH/config
    echo 0x24B87180 1 > $DCC_PATH/config
    echo 0x24B86AB0 3 > $DCC_PATH/config
    echo 0x24B86A6C 1 > $DCC_PATH/config
    echo 0x24B8656C 1 > $DCC_PATH/config
    echo 0x24B86AB8 1 > $DCC_PATH/config
    echo 0x24B8656C 1 > $DCC_PATH/config
    echo 0x24B8181C 1 > $DCC_PATH/config
    echo 0x24B81804 1 > $DCC_PATH/config
    echo 0x24B86AB0 2 > $DCC_PATH/config
    echo 0x24B86BBC 3 > $DCC_PATH/config
    echo 0x24A05C10 1 > $DCC_PATH/config
    echo 0x240BA29C 2 > $DCC_PATH/config
    echo 0x24B86710 1 > $DCC_PATH/config
    echo 0x24B8717C 1 > $DCC_PATH/config
    echo 0x24B875FC 1 > $DCC_PATH/config
    echo 0x24B8782C 1 > $DCC_PATH/config
    echo 0x24B87A5C 1 > $DCC_PATH/config
}
config_dcc_gpu()
{
    echo 0x3d00000 1 > $DCC_PATH/config
    echo 0x3d00008 1 > $DCC_PATH/config
    echo 0x3d00020 6 > $DCC_PATH/config
    echo 0x3d00040 4 > $DCC_PATH/config
    echo 0x3d00054 2 > $DCC_PATH/config
    echo 0x3d00060 1 > $DCC_PATH/config
    echo 0x3d00068 1 > $DCC_PATH/config
    echo 0x3d00070 1 > $DCC_PATH/config
    echo 0x3d000a0 4 > $DCC_PATH/config
    echo 0x3d000b4 13 > $DCC_PATH/config
    echo 0x3d3c000 3 > $DCC_PATH/config
    echo 0x3d3d000 1 > $DCC_PATH/config
    echo 0x3d3e000 4 > $DCC_PATH/config
    echo 0x3d3f000 1 > $DCC_PATH/config
    echo 0x3d7d03c 3 > $DCC_PATH/config
    echo 0x3d7d400 1 > $DCC_PATH/config
    echo 0x3d7d41c 1 > $DCC_PATH/config
    echo 0x3d7d424 3 > $DCC_PATH/config
    echo 0x3d7dc58 1 > $DCC_PATH/config
    echo 0x3d7dc94 1 > $DCC_PATH/config
    echo 0x3d7dca4 1 > $DCC_PATH/config
    echo 0x3d7dd58 2 > $DCC_PATH/config
    echo 0x3d7df80 2 > $DCC_PATH/config
    echo 0x3d7df90 2 > $DCC_PATH/config
    echo 0x3d7dfa0 2 > $DCC_PATH/config
    echo 0x3d7dfb0 2 > $DCC_PATH/config
    echo 0x3d7e000 5 > $DCC_PATH/config
    echo 0x3d7e01c 2 > $DCC_PATH/config
    echo 0x3d7e02c 2 > $DCC_PATH/config
    echo 0x3d7e03c 1 > $DCC_PATH/config
    echo 0x3d7e044 1 > $DCC_PATH/config
    echo 0x3d7e04c 5 > $DCC_PATH/config
    echo 0x3d7e064 4 > $DCC_PATH/config
    echo 0x3d7e100 2 > $DCC_PATH/config
    echo 0x3d7e130 1 > $DCC_PATH/config
    echo 0x3d7e140 1 > $DCC_PATH/config
    echo 0x3d7e500 2 > $DCC_PATH/config
    echo 0x3d7e50c 1 > $DCC_PATH/config
    echo 0x3d7e520 1 > $DCC_PATH/config
    echo 0x3d7e53c 1 > $DCC_PATH/config
    echo 0x3d7e550 2 > $DCC_PATH/config
    echo 0x3d7e574 1 > $DCC_PATH/config
    echo 0x3d7e5c0 1 > $DCC_PATH/config
    echo 0x3d7e5f0 3 > $DCC_PATH/config
    echo 0x3d7e600 2 > $DCC_PATH/config
    echo 0x3d7e610 3 > $DCC_PATH/config
    echo 0x3d7e648 2 > $DCC_PATH/config
    echo 0x3d7e658 9 > $DCC_PATH/config
    echo 0x3d7e7c4 1 > $DCC_PATH/config
    echo 0x3d7e7e0 3 > $DCC_PATH/config
    echo 0x3d7e7f0 1 > $DCC_PATH/config
    echo 0x3d7e800 4 > $DCC_PATH/config
    echo 0x3d9200c 3 > $DCC_PATH/config
    echo 0x3d93000 1 > $DCC_PATH/config
    echo 0x3d94000 3 > $DCC_PATH/config
    echo 0x3d95000 5 > $DCC_PATH/config
    echo 0x3d96000 5 > $DCC_PATH/config
    echo 0x3d97000 5 > $DCC_PATH/config
    echo 0x3d98000 5 > $DCC_PATH/config
    echo 0x3d99000 7 > $DCC_PATH/config
    echo 0x3d99054 4 > $DCC_PATH/config
    echo 0x3d99070 2 > $DCC_PATH/config
    echo 0x3d990e4 2 > $DCC_PATH/config
    echo 0x3d990f0 4 > $DCC_PATH/config
    echo 0x3d9910c 2 > $DCC_PATH/config
    echo 0x3d991e0 3 > $DCC_PATH/config
    echo 0x3d99224 2 > $DCC_PATH/config
    echo 0x3d99270 3 > $DCC_PATH/config
    echo 0x3d99280 2 > $DCC_PATH/config
    echo 0x3d99314 3 > $DCC_PATH/config
    echo 0x3d993a0 3 > $DCC_PATH/config
    echo 0x3d993e4 4 > $DCC_PATH/config
    echo 0x3d9942c 1 > $DCC_PATH/config
    echo 0x3d99470 3 > $DCC_PATH/config
    echo 0x3d99500 12 > $DCC_PATH/config
    echo 0x3d99550 3 > $DCC_PATH/config
    echo 0x3d99560 5 > $DCC_PATH/config
    echo 0x3d99578 2 > $DCC_PATH/config
    echo 0x3d9958c 1 > $DCC_PATH/config
    echo 0x3d995b4 7 > $DCC_PATH/config
    echo 0x3d995d8 1 > $DCC_PATH/config
    echo 0x3d995e0 3 > $DCC_PATH/config
    echo 0x3d9e000 1 > $DCC_PATH/config
    echo 0x3d9e040 5 > $DCC_PATH/config
    echo 0x3d9e080 5 > $DCC_PATH/config
}

config_dcc_mmss_noc()
{
    echo 0x1780000 3 > $DCC_PATH/config
    echo 0x1780010 1 > $DCC_PATH/config
    echo 0x1780018 1 > $DCC_PATH/config
    echo 0x1780020 8 > $DCC_PATH/config
    echo 0x1780240 1 > $DCC_PATH/config
    echo 0x1780248 1 > $DCC_PATH/config
}

config_dcc_system_noc()
{
    echo 0x1680010 1 > $DCC_PATH/config
    echo 0x1680018 1 > $DCC_PATH/config
    echo 0x1680020 8 > $DCC_PATH/config
    echo 0x1681040 1 > $DCC_PATH/config
    echo 0x1681048 1 > $DCC_PATH/config
    echo 0x1690010 1 > $DCC_PATH/config
    echo 0x1698010 1 > $DCC_PATH/config
    echo 0x1699010 1 > $DCC_PATH/config
    echo 0x169C010 1 > $DCC_PATH/config
    echo 0x169D010 1 > $DCC_PATH/config
}

config_dcc_apps_gic_noc()
{
    echo 0x17C40010 1 > $DCC_PATH/config
    echo 0x17C40018 1 > $DCC_PATH/config
    echo 0x17C40020 1 > $DCC_PATH/config
    echo 0x17C40024 1 > $DCC_PATH/config
    echo 0x17C40028 1 > $DCC_PATH/config
    echo 0x17C4002C 1 > $DCC_PATH/config
    echo 0x17C40030 1 > $DCC_PATH/config
    echo 0x17C40034 1 > $DCC_PATH/config
    echo 0x17C40038 1 > $DCC_PATH/config
    echo 0x17C4003C 1 > $DCC_PATH/config
    echo 0x17C40848 1 > $DCC_PATH/config
}

config_dcc_aggre_noc()
{
    echo 0x16E0000 3 > $DCC_PATH/config
    echo 0x16E0010 1 > $DCC_PATH/config
    echo 0x16E0018 1 > $DCC_PATH/config
    echo 0x16E0020 8 > $DCC_PATH/config
    echo 0x16E0240 1 > $DCC_PATH/config
    echo 0x16E0248 1 > $DCC_PATH/config
    echo 0x16E1080 3 > $DCC_PATH/config
    echo 0x16E1098 1 > $DCC_PATH/config
    echo 0x16E1100 3 > $DCC_PATH/config
    echo 0x16E1180 3 > $DCC_PATH/config
    echo 0x16E1198 1 > $DCC_PATH/config
    echo 0x16EC010 1 > $DCC_PATH/config
    echo 0x16ED010 1 > $DCC_PATH/config
    echo 0x16EF010 1 > $DCC_PATH/config
    echo 0x16F0010 1 > $DCC_PATH/config
    echo 0x16C0000 3 > $DCC_PATH/config
    echo 0x16C0010 1 > $DCC_PATH/config
    echo 0x16C0018 1 > $DCC_PATH/config
    echo 0x16C0020 8 > $DCC_PATH/config
    echo 0x16C0240 1 > $DCC_PATH/config
    echo 0x16C0248 1 > $DCC_PATH/config
    echo 0x16C2000 3 > $DCC_PATH/config
    echo 0x16C3000 3 > $DCC_PATH/config
    echo 0x16CB010 1 > $DCC_PATH/config
    echo 0x1700000 3 > $DCC_PATH/config
}

config_dcc_nsp_noc()
{
    echo 0x7D6040 1 > $DCC_PATH/config
    echo 0x7D6048 1 > $DCC_PATH/config
    echo 0x7DF000 3 > $DCC_PATH/config
    echo 0x7DF018 1 > $DCC_PATH/config
    echo 0x7E0000 3 > $DCC_PATH/config
    echo 0x7E0018 1 > $DCC_PATH/config
    echo 0x320C0010 1 > $DCC_PATH/config
    echo 0x320C0018 1 > $DCC_PATH/config
    echo 0x320C0020 1 > $DCC_PATH/config
    echo 0x320C0024 1 > $DCC_PATH/config
    echo 0x320C0028 1 > $DCC_PATH/config
    echo 0x320C002C 1 > $DCC_PATH/config
    echo 0x320C0030 1 > $DCC_PATH/config
    echo 0x320C0034 1 > $DCC_PATH/config
    echo 0x320C0038 1 > $DCC_PATH/config
    echo 0x320C003C 1 > $DCC_PATH/config
    echo 0x320C0248 1 > $DCC_PATH/config
}

config_dcc_rpmh_apps_pdc()
{
    echo 0xB200110 1 > $DCC_PATH/config
    echo 0xB200900 1 > $DCC_PATH/config
    echo 0xB201020 1 > $DCC_PATH/config
    echo 0xB201030 1 > $DCC_PATH/config
    echo 0xB20103C 1 > $DCC_PATH/config
    echo 0xB201200 2 > $DCC_PATH/config
    echo 0xB204510 2 > $DCC_PATH/config
    echo 0xB204520 2 > $DCC_PATH/config
}

config_dcc_apss_rsc()
{
    echo 0x17A00010 1 > $DCC_PATH/config
    echo 0x17A00030 1 > $DCC_PATH/config
    echo 0x17A00038 1 > $DCC_PATH/config
    echo 0x17A00040 1 > $DCC_PATH/config
    echo 0x17A00048 1 > $DCC_PATH/config
    echo 0x17A00400 1 > $DCC_PATH/config
    echo 0x17A10010 1 > $DCC_PATH/config
    echo 0x17A10030 1 > $DCC_PATH/config
    echo 0x17A10038 1 > $DCC_PATH/config
    echo 0x17A10040 1 > $DCC_PATH/config
    echo 0x17A10400 1 > $DCC_PATH/config
    echo 0x17A20010 1 > $DCC_PATH/config
    echo 0x17A20030 1 > $DCC_PATH/config
    echo 0x17A20038 1 > $DCC_PATH/config
    echo 0x17A20040 1 > $DCC_PATH/config
    echo 0x17A20400 1 > $DCC_PATH/config
    echo 0x17A30010 1 > $DCC_PATH/config
    echo 0x17A30030 1 > $DCC_PATH/config
    echo 0x17A30038 1 > $DCC_PATH/config
    echo 0x17A30040 1 > $DCC_PATH/config
    echo 0x17A30400 1 > $DCC_PATH/config
    echo 0x17a10d3c 1 > $DCC_PATH/config
    echo 0x17a10d54 1 > $DCC_PATH/config
    echo 0x17a10d6c 1 > $DCC_PATH/config
    echo 0x17a10d84 1 > $DCC_PATH/config
    echo 0x17a10d9c 1 > $DCC_PATH/config
    echo 0x17a10db4 1 > $DCC_PATH/config
    echo 0x17a10dcc 1 > $DCC_PATH/config
    echo 0x17a10de4 1 > $DCC_PATH/config
    echo 0x17a10dfc 1 > $DCC_PATH/config
    echo 0x17a10e14 1 > $DCC_PATH/config
    echo 0x17a10e2c 1 > $DCC_PATH/config
    echo 0x17a10e44 1 > $DCC_PATH/config
    echo 0x17a10e5c 1 > $DCC_PATH/config
    echo 0x17a10e74 1 > $DCC_PATH/config
    echo 0x17a10e8c 1 > $DCC_PATH/config
    echo 0x17a10ea4 1 > $DCC_PATH/config
    echo 0x17a10fdc 1 > $DCC_PATH/config
    echo 0x17a10ff4 1 > $DCC_PATH/config
    echo 0x17a1100c 1 > $DCC_PATH/config
    echo 0x17a11024 1 > $DCC_PATH/config
    echo 0x17a1103c 1 > $DCC_PATH/config
    echo 0x17a11054 1 > $DCC_PATH/config
    echo 0x17a1106c 1 > $DCC_PATH/config
    echo 0x17a11084 1 > $DCC_PATH/config
    echo 0x17a1109c 1 > $DCC_PATH/config
    echo 0x17a110b4 1 > $DCC_PATH/config
    echo 0x17a110cc 1 > $DCC_PATH/config
    echo 0x17a110e4 1 > $DCC_PATH/config
    echo 0x17a110fc 1 > $DCC_PATH/config
    echo 0x17a11114 1 > $DCC_PATH/config
    echo 0x17a1112c 1 > $DCC_PATH/config
    echo 0x17a11144 1 > $DCC_PATH/config
    echo 0x17a1127c 1 > $DCC_PATH/config
    echo 0x17a11294 1 > $DCC_PATH/config
    echo 0x17a112ac 1 > $DCC_PATH/config
    echo 0x17a112c4 1 > $DCC_PATH/config
    echo 0x17a112dc 1 > $DCC_PATH/config
    echo 0x17a112f4 1 > $DCC_PATH/config
    echo 0x17a1130c 1 > $DCC_PATH/config
    echo 0x17a11324 1 > $DCC_PATH/config
    echo 0x17a1133c 1 > $DCC_PATH/config
    echo 0x17a11354 1 > $DCC_PATH/config
    echo 0x17a1136c 1 > $DCC_PATH/config
    echo 0x17a11384 1 > $DCC_PATH/config
    echo 0x17a1139c 1 > $DCC_PATH/config
    echo 0x17a113b4 1 > $DCC_PATH/config
    echo 0x17a113cc 1 > $DCC_PATH/config
    echo 0x17a113e4 1 > $DCC_PATH/config
    echo 0x17a1151c 1 > $DCC_PATH/config
    echo 0x17a11534 1 > $DCC_PATH/config
    echo 0x17a1154c 1 > $DCC_PATH/config
    echo 0x17a11564 1 > $DCC_PATH/config
    echo 0x17a1157c 1 > $DCC_PATH/config
    echo 0x17a11594 1 > $DCC_PATH/config
    echo 0x17a115ac 1 > $DCC_PATH/config
    echo 0x17a115c4 1 > $DCC_PATH/config
    echo 0x17a115dc 1 > $DCC_PATH/config
    echo 0x17a115f4 1 > $DCC_PATH/config
    echo 0x17a1160c 1 > $DCC_PATH/config
    echo 0x17a11624 1 > $DCC_PATH/config
    echo 0x17a1163c 1 > $DCC_PATH/config
    echo 0x17a11654 1 > $DCC_PATH/config
    echo 0x17a1166c 1 > $DCC_PATH/config
    echo 0x17a11684 1 > $DCC_PATH/config
}

config_dcc_misc()
{
    echo 0xC234004 5 > $DCC_PATH/config
    echo 0x5 > $DCC_PATH/loop
    echo 0x17410000 6 > $DCC_PATH/config
    echo 0x17411000 6 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
}

config_dcc_epss()
{
    echo 0x17D10200 320 > $DCC_PATH/config
    echo 0x17900900 1 > $DCC_PATH/config
    echo 0x17900908 1 > $DCC_PATH/config
    echo 0x17900C14 2 > $DCC_PATH/config
    echo 0x17A90004 1 > $DCC_PATH/config
    echo 0x17A9000C 1 > $DCC_PATH/config
    echo 0x17A9001C 1 > $DCC_PATH/config
    echo 0x17A92004 1 > $DCC_PATH/config
    echo 0x17A9200C 1 > $DCC_PATH/config
    echo 0x17A9201C 1 > $DCC_PATH/config
    echo 0x17A94004 1 > $DCC_PATH/config
    echo 0x17A9400C 1 > $DCC_PATH/config
    echo 0x17A9401C 1 > $DCC_PATH/config
    echo 0x17B00000 4 > $DCC_PATH/config
    echo 0x17B00014 10 > $DCC_PATH/config
    echo 0x17B000CC 1 > $DCC_PATH/config
    echo 0x17B000F4 9 > $DCC_PATH/config
    echo 0x17BA0810 3 > $DCC_PATH/config
    echo 0x17BA3A84 3 > $DCC_PATH/config
    echo 0x17D80000 9 > $DCC_PATH/config
    echo 0x17D80040 1 > $DCC_PATH/config
    echo 0x17D80060 1 > $DCC_PATH/config
    echo 0x17D80080 1 > $DCC_PATH/config
    echo 0x17D800A0 1 > $DCC_PATH/config
    echo 0x17D800C0 1 > $DCC_PATH/config
    echo 0x17D800E0 1 > $DCC_PATH/config
    echo 0x17D80100 1 > $DCC_PATH/config
    echo 0x17D80200 1 > $DCC_PATH/config
    echo 0x17D80700 2 > $DCC_PATH/config
    echo 0x17D80714 5 > $DCC_PATH/config
    echo 0x17D80764 14 > $DCC_PATH/config
    echo 0x17D80800 1 > $DCC_PATH/config
    echo 0x17D80900 4 > $DCC_PATH/config
    echo 0x17D80914 1 > $DCC_PATH/config
    echo 0x17D80920 3 > $DCC_PATH/config
    echo 0x17D809FC 11 > $DCC_PATH/config
    echo 0x17D80AFC 18 > $DCC_PATH/config
    echo 0x17D90000 4 > $DCC_PATH/config
    echo 0x17D90014 2 > $DCC_PATH/config
    echo 0x17D9001C 5 > $DCC_PATH/config
    echo 0x17D90048 6 > $DCC_PATH/config
    echo 0x17D90064 3 > $DCC_PATH/config
    echo 0x17D90078 1 > $DCC_PATH/config
    echo 0x17D90088 3 > $DCC_PATH/config
    echo 0x17D900D8 7 > $DCC_PATH/config
    echo 0x17D90080 5 > $DCC_PATH/config
    echo 0x17D900B0 1 > $DCC_PATH/config
    echo 0x17D900B8 2 > $DCC_PATH/config
    echo 0x17D900D0 9 > $DCC_PATH/config
    echo 0x17D90300 5 > $DCC_PATH/config
    echo 0x17D90320 1 > $DCC_PATH/config
    echo 0x17D9034C 2 > $DCC_PATH/config
    echo 0x17D90360 5 > $DCC_PATH/config
    echo 0x17D903B0 6 > $DCC_PATH/config
    echo 0x17D903E0 2 > $DCC_PATH/config
    echo 0x17D90404 3 > $DCC_PATH/config
    echo 0x17D90420 1 > $DCC_PATH/config
    echo 0x17D90430 1 > $DCC_PATH/config
    echo 0x17D90450 1 > $DCC_PATH/config
    echo 0x17D90470 7 > $DCC_PATH/config
    echo 0x17D91000 4 > $DCC_PATH/config
    echo 0x17D91014 26 > $DCC_PATH/config
    echo 0x17D91088 3 > $DCC_PATH/config
    echo 0x17D910B0 1 > $DCC_PATH/config
    echo 0x17D910D8 7 > $DCC_PATH/config
    echo 0x17D91300 5 > $DCC_PATH/config
    echo 0x17D91320 1 > $DCC_PATH/config
    echo 0x17D9134C 2 > $DCC_PATH/config
    echo 0x17D913B0 6 > $DCC_PATH/config
    echo 0x17D91404 3 > $DCC_PATH/config
    echo 0x17D91420 1 > $DCC_PATH/config
    echo 0x17D91430 1 > $DCC_PATH/config
    echo 0x17D91450 1 > $DCC_PATH/config
    echo 0x17D91470 7 > $DCC_PATH/config
    echo 0x17D92000 4 > $DCC_PATH/config
    echo 0x17D92014 26 > $DCC_PATH/config
    echo 0x17D92080 5 > $DCC_PATH/config
    echo 0x17D920B0 1 > $DCC_PATH/config
    echo 0x17D920B8 2 > $DCC_PATH/config
    echo 0x17D920D8 7 > $DCC_PATH/config
    echo 0x17D92300 5 > $DCC_PATH/config
    echo 0x17D92320 1 > $DCC_PATH/config
    echo 0x17D9234C 2 > $DCC_PATH/config
    echo 0x17D92370 1 > $DCC_PATH/config
    echo 0x17D923B0 1 > $DCC_PATH/config
    echo 0x17D92404 3 > $DCC_PATH/config
    echo 0x17D92420 1 > $DCC_PATH/config
    echo 0x17D92430 1 > $DCC_PATH/config
    echo 0x17D92450 1 > $DCC_PATH/config
    echo 0x17D92470 7 > $DCC_PATH/config
    echo 0x17D98010 6 > $DCC_PATH/config
    echo 0x17D9201C 5 > $DCC_PATH/config
    echo 0x17D92050 4 > $DCC_PATH/config
    echo 0x17D92064 3 > $DCC_PATH/config
    echo 0x17D92078 1 > $DCC_PATH/config
    echo 0x17D92088 3 > $DCC_PATH/config
}

config_dcc_apps_hang()
{
    echo 0x351C20D0 1 > $DCC_PATH/config
    echo 0x1740003C 1 > $DCC_PATH/config
    echo 0x17840064 1 > $DCC_PATH/config
    echo 0x17830064 1 > $DCC_PATH/config
    echo 0x17820064 1 > $DCC_PATH/config
    echo 0x17810064 1 > $DCC_PATH/config
    echo 0x17800064 1 > $DCC_PATH/config
    echo 0x17600448 2 > $DCC_PATH/config
    echo 0x17600450 2 > $DCC_PATH/config
    echo 0x17600534 1 > $DCC_PATH/config
    echo 0x17800040 1 > $DCC_PATH/config
    echo 0x17810040 1 > $DCC_PATH/config
    echo 0x17820040 1 > $DCC_PATH/config
    echo 0x17830040 1 > $DCC_PATH/config
    echo 0x17840040 1 > $DCC_PATH/config
    echo 0x17880104 1 > $DCC_PATH/config
    echo 0x17880128 1 > $DCC_PATH/config
    echo 0x17880040 1 > $DCC_PATH/config
    echo 0x17D90020 1 > $DCC_PATH/config
    echo 0x17D91020 1 > $DCC_PATH/config
    echo 0x17D92020 1 > $DCC_PATH/config
    echo 0x17D900DC 1 > $DCC_PATH/config
    echo 0x17D910DC 1 > $DCC_PATH/config
    echo 0x17D920DC 1 > $DCC_PATH/config
    echo 0x17D900E8 1 > $DCC_PATH/config
    echo 0x17D910E8 1 > $DCC_PATH/config
    echo 0x17D920E8 1 > $DCC_PATH/config
    echo 0x17D98020 1 > $DCC_PATH/config
    echo 0x17D98018 2 > $DCC_PATH/config
}

config_dcc_bt_uart()
{
    echo 0x221C4000 1 > $DCC_PATH/config
    echo 0x221C5000 1 > $DCC_PATH/config
    echo 0x221C6000 1 > $DCC_PATH/config
    echo 0x221C7000 1 > $DCC_PATH/config
    echo 0x22988010 1 > $DCC_PATH/config
    echo 0x22988024 1 > $DCC_PATH/config
    echo 0x22988040 1 > $DCC_PATH/config
    echo 0x22988048 2 > $DCC_PATH/config
    echo 0x22988060 2 > $DCC_PATH/config
    echo 0x22988074 1 > $DCC_PATH/config
    echo 0x2298807C 1 > $DCC_PATH/config
    echo 0x22988080 1 > $DCC_PATH/config
    echo 0x22988240 1 > $DCC_PATH/config
    echo 0x22988248 1 > $DCC_PATH/config
    echo 0x2298825C 1 > $DCC_PATH/config
    echo 0x22988268 1 > $DCC_PATH/config
    echo 0x2298826C 1 > $DCC_PATH/config
    echo 0x22988270 1 > $DCC_PATH/config
    echo 0x22988280 1 > $DCC_PATH/config
    echo 0x2298828C 1 > $DCC_PATH/config
    echo 0x22988294 1 > $DCC_PATH/config
    echo 0x229882AC 1 > $DCC_PATH/config
    echo 0x22988600 2 > $DCC_PATH/config
    echo 0x22988610 2 > $DCC_PATH/config
    echo 0x22988624 2 > $DCC_PATH/config
    echo 0x22988630 2 > $DCC_PATH/config
    echo 0x22988640 2 > $DCC_PATH/config
    echo 0x22988800 2 > $DCC_PATH/config
    echo 0x2298880C 3 > $DCC_PATH/config
    echo 0x22988908 1 > $DCC_PATH/config
    echo 0x22988910 2 > $DCC_PATH/config
    echo 0x22988C30 5 > $DCC_PATH/config
    echo 0x22988C48 1 > $DCC_PATH/config
    echo 0x22988C54 1 > $DCC_PATH/config
    echo 0x22988D30 5 > $DCC_PATH/config
    echo 0x22988D48 1 > $DCC_PATH/config
    echo 0x22988D54 1 > $DCC_PATH/config
    echo 0x22988E18 2 > $DCC_PATH/config
    echo 0x22988E20 1 > $DCC_PATH/config
    echo 0x22988E30 1 > $DCC_PATH/config
    echo 0x22988E40 1 > $DCC_PATH/config
    echo 0x229C0008 1 > $DCC_PATH/config
    echo 0x229C0100 3 > $DCC_PATH/config
    echo 0x229C0110 1 > $DCC_PATH/config
    echo 0x229C0120 2 > $DCC_PATH/config
    echo 0x229C1200 3 > $DCC_PATH/config
    echo 0x22905010 1 > $DCC_PATH/config
    echo 0x22905048 1 > $DCC_PATH/config
    echo 0x22905100 32 > $DCC_PATH/config
    echo 0x22907880 2 > $DCC_PATH/config
    echo 0x22914000 8 > $DCC_PATH/config
    echo 0x22914080 8 > $DCC_PATH/config
    echo 0x22914060 1 > $DCC_PATH/config
    echo 0x229140E0 1 > $DCC_PATH/config
    echo 0x22915000 8 > $DCC_PATH/config
    echo 0x22914054 1 > $DCC_PATH/config
    echo 0x229140D4 1 > $DCC_PATH/config
    echo 0x22917048 1 > $DCC_PATH/config
    echo 0x22917080 1 > $DCC_PATH/config
    echo 0x22917088 1 > $DCC_PATH/config
    echo 0x22917090 4 > $DCC_PATH/config
    echo 0x229170B0 1 > $DCC_PATH/config
    echo 0x229170B8 1 > $DCC_PATH/config
    echo 0x22917100 1 > $DCC_PATH/config
    echo 0x22917108 1 > $DCC_PATH/config
    echo 0x22917118 1 > $DCC_PATH/config
    echo 0x22917120 1 > $DCC_PATH/config
    echo 0x22917200 1 > $DCC_PATH/config
    echo 0x22917400 1 > $DCC_PATH/config
    echo 0x22905484 1 > $DCC_PATH/config
    echo 0x22904008 1 > $DCC_PATH/config
    echo 0x22A06130 1 > $DCC_PATH/config
    echo 0x22A06004 6 > $DCC_PATH/config
    echo 0x22A20000 1 > $DCC_PATH/config
    echo 0x22A21000 1 > $DCC_PATH/config
    echo 0x22A22000 1 > $DCC_PATH/config
    echo 0x22A23000 1 > $DCC_PATH/config
}

config_dcc_modem()
{
    echo 0x4080304 1 > $DCC_PATH/config
    echo 0x4082028 1 > $DCC_PATH/config
    echo 0x4130208 1 > $DCC_PATH/config
    echo 0x4130228 3 > $DCC_PATH/config
    echo 0x4130248 3 > $DCC_PATH/config
    echo 0x4130268 3 > $DCC_PATH/config
    echo 0x4130288 3 > $DCC_PATH/config
    echo 0x41302A8 3 > $DCC_PATH/config
    echo 0x413020C 2 > $DCC_PATH/config
    echo 0x4130400 3 > $DCC_PATH/config
    echo 0x4200208 3 > $DCC_PATH/config
    echo 0x4200228 3 > $DCC_PATH/config
    echo 0x4200248 3 > $DCC_PATH/config
    echo 0x4200268 3 > $DCC_PATH/config
    echo 0x4200288 3 > $DCC_PATH/config
    echo 0x42002A8 3 > $DCC_PATH/config
    echo 0x4200400 3 > $DCC_PATH/config
    echo 0x41AF418 3 > $DCC_PATH/config
    echo 0x41AE000 1 > $DCC_PATH/config
    echo 0x41AF508 3 > $DCC_PATH/config
}

config_dcc_cdsp()
{
    echo 0x320A4208 2 > $DCC_PATH/config
    echo 0x320A4228 3 > $DCC_PATH/config
    echo 0x320A4248 3 > $DCC_PATH/config
    echo 0x320A4268 3 > $DCC_PATH/config
    echo 0x320A4288 3 > $DCC_PATH/config
    echo 0x320A42A8 3 > $DCC_PATH/config
    echo 0x320A4400 3 > $DCC_PATH/config
    echo 0x3230030C 1 > $DCC_PATH/config
    echo 0x32302028 1 > $DCC_PATH/config
    echo 0x3238C108 0x3BFFF > $DCC_PATH/config_write
    echo 0x323005B4 0x1 > $DCC_PATH/config_write
    echo 0xA > $DCC_PATH/loop
    echo 0x3238C108 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x32340000 1 > $DCC_PATH/config
    echo 0x32340004 1 > $DCC_PATH/config
    echo 0x32340008 1 > $DCC_PATH/config
    echo 0x3234000C 1 > $DCC_PATH/config
    echo 0x32340010 1 > $DCC_PATH/config
    echo 0x32340014 1 > $DCC_PATH/config
    echo 0x32340018 1 > $DCC_PATH/config
    echo 0x3234001C 1 > $DCC_PATH/config
    echo 0x32340020 1 > $DCC_PATH/config
    echo 0x32340024 1 > $DCC_PATH/config
    echo 0x32340028 1 > $DCC_PATH/config
    echo 0x3234002C 1 > $DCC_PATH/config
    echo 0x32340030 1 > $DCC_PATH/config
    echo 0x32340034 1 > $DCC_PATH/config
    echo 0x32344020 1 > $DCC_PATH/config
    echo 0x32344024 1 > $DCC_PATH/config
    echo 0x32344040 1 > $DCC_PATH/config
    echo 0x323C0208 3 > $DCC_PATH/config
    echo 0x323C0228 3 > $DCC_PATH/config
    echo 0x323C0248 3 > $DCC_PATH/config
    echo 0x323C0268 3 > $DCC_PATH/config
    echo 0x323C0288 3 > $DCC_PATH/config
    echo 0x323C02A8 3 > $DCC_PATH/config
    echo 0x323C0400 3 > $DCC_PATH/config
}

config_noc_dump()
{
    echo 0x1500010 1 > $DCC_PATH/config
    echo 0x1500018 1 > $DCC_PATH/config
    echo 0x1500020 8 > $DCC_PATH/config
    echo 0x1500240 1 > $DCC_PATH/config
    echo 0x1500248 1 > $DCC_PATH/config
    echo 0x1500440 1 > $DCC_PATH/config
    echo 0x1500448 1 > $DCC_PATH/config

    echo 0x1502008 1 > $DCC_PATH/config
    echo 0xb > $DCC_PATH/loop
    echo 0x1502010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1502018 1 > $DCC_PATH/config

    echo 0x1600010 1 > $DCC_PATH/config
    echo 0x1600018 1 > $DCC_PATH/config
    echo 0x1600020 8 > $DCC_PATH/config
    echo 0x1600258 1 > $DCC_PATH/config

    echo 0x1602008 1 > $DCC_PATH/config
    echo 0xA > $DCC_PATH/loop
    echo 0x1602010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1602018 1 > $DCC_PATH/config

    echo 0x1602108 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x1602110 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1602118 1 > $DCC_PATH/config

    echo 0x1602188 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x1602190 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1602198 1 > $DCC_PATH/config

    echo 0x1602208 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x1602210 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1602218 1 > $DCC_PATH/config

    echo 0x1682008 1 > $DCC_PATH/config
    echo 0x5 > $DCC_PATH/loop
    echo 0x1682010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1682018 1 > $DCC_PATH/config

    echo 0x16C2008 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x16C2010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x16C2018 1 > $DCC_PATH/config

    echo 0x16C3008 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x16C3010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x16C3018 1 > $DCC_PATH/config

    echo 0x16E1008 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x16E1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x16E1018 1 > $DCC_PATH/config

    echo 0x16E1088 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x16E1090 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x16E1098 1 > $DCC_PATH/config

    echo 0x16E1108 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x16E1110 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x16E1118 1 > $DCC_PATH/config

    echo 0x16E1188 1 > $DCC_PATH/config
    echo 0x5 > $DCC_PATH/loop
    echo 0x16E1190 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x16E1198 1 > $DCC_PATH/config

    echo 0x1782008 1 > $DCC_PATH/config
    echo 0x7 > $DCC_PATH/loop
    echo 0x1782010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1782018 1 > $DCC_PATH/config

    echo 0x1783008 1 > $DCC_PATH/config
    echo 0x7 > $DCC_PATH/loop
    echo 0x1783010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x1783018 1 > $DCC_PATH/config

    echo 0x2851008 1 > $DCC_PATH/config
    echo 0x6 > $DCC_PATH/loop
    echo 0x2851010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x2851018 1 > $DCC_PATH/config

    echo 0x2861008 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x2861010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x2861018 1 > $DCC_PATH/config

    echo 0x22003008 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x22003010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x22003018 1 > $DCC_PATH/config

    echo 0x22012008 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x22012010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x22012018 1 > $DCC_PATH/config

    echo 0x22021008 1 > $DCC_PATH/config
    echo 0x12 > $DCC_PATH/loop
    echo 0x22021010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x22021018 1 > $DCC_PATH/config

    echo 0x22058008 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x22058010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x22058018 1 > $DCC_PATH/config

    echo 0x22060008 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x22060010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x22060018 1 > $DCC_PATH/config

    echo 0x22501008 1 > $DCC_PATH/config
    echo 0xf > $DCC_PATH/loop
    echo 0x22501010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x22501018 1 > $DCC_PATH/config

    echo 0x23E42008 1 > $DCC_PATH/config
    echo 0x6 > $DCC_PATH/loop
    echo 0x23E42010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x23E42018 1 > $DCC_PATH/config

    echo 0x240E1008 1 > $DCC_PATH/config
    echo 0x9 > $DCC_PATH/loop
    echo 0x240E1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x240E1018 1 > $DCC_PATH/config

    echo 0x24100808 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x24100810 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x24100818 1 > $DCC_PATH/config

    echo 0x24101008 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x24101010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x24101018 1 > $DCC_PATH/config

    echo 0x24201008 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x24201010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x24201018 1 > $DCC_PATH/config

    echo 0x24201108 1 > $DCC_PATH/config
    echo 0x15 > $DCC_PATH/loop
    echo 0x24201110 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x24201118 1 > $DCC_PATH/config

    echo 0x24BF2008 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x24BF2010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x24BF2018 1 > $DCC_PATH/config

    echo 0x320C1008 1 > $DCC_PATH/config
    echo 0x6 > $DCC_PATH/loop
    echo 0x320C1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x320C1018 1 > $DCC_PATH/config

    echo 0x7BE008 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x7BE010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x7BE018 1 > $DCC_PATH/config

    echo 0x7BF008 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x7BF010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x7BF018 1 > $DCC_PATH/config

    echo 0x7DF008 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x7DF010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x7DF018 1 > $DCC_PATH/config

    echo 0x7E0008 1 > $DCC_PATH/config
    echo 0x7 > $DCC_PATH/loop
    echo 0x7E0010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x7E0018 1 > $DCC_PATH/config

    echo 0x7B6040 1 > $DCC_PATH/config
    echo 0x7B6048 1 > $DCC_PATH/config
    echo 0x7BE000 3 > $DCC_PATH/config
    echo 0x7BF000 3 > $DCC_PATH/config
}

config_dcc_dc_noc_dump()
{
    echo 0x240E0000 3 > $DCC_PATH/config
    echo 0x240E0010 1 > $DCC_PATH/config
    echo 0x240E0018 1 > $DCC_PATH/config
    echo 0x240E0020 8 > $DCC_PATH/config
    echo 0x240E0240 1 > $DCC_PATH/config
    echo 0x240E0248 1 > $DCC_PATH/config
}

config_dcc_gemnoc_qns()
{
    echo 0x24104008 1 > $DCC_PATH/config
    echo 0x24104010 1 > $DCC_PATH/config
    echo 0x24104018 1 > $DCC_PATH/config
    echo 0x24104020 1 > $DCC_PATH/config
    echo 0x24104024 1 > $DCC_PATH/config
    echo 0x24104028 1 > $DCC_PATH/config
    echo 0x2410402C 1 > $DCC_PATH/config
    echo 0x24104030 1 > $DCC_PATH/config
    echo 0x24104034 1 > $DCC_PATH/config
    echo 0x24210008 1 > $DCC_PATH/config
    echo 0x24210010 1 > $DCC_PATH/config
    echo 0x24210018 1 > $DCC_PATH/config
    echo 0x24210020 1 > $DCC_PATH/config
    echo 0x24210024 1 > $DCC_PATH/config
    echo 0x24210028 1 > $DCC_PATH/config
    echo 0x2421002C 1 > $DCC_PATH/config
    echo 0x24210030 1 > $DCC_PATH/config
    echo 0x24210034 1 > $DCC_PATH/config
    echo 0x24210408 1 > $DCC_PATH/config
    echo 0x24210410 1 > $DCC_PATH/config
    echo 0x24210418 1 > $DCC_PATH/config
    echo 0x24210420 1 > $DCC_PATH/config
    echo 0x24210424 1 > $DCC_PATH/config
    echo 0x24210428 1 > $DCC_PATH/config
    echo 0x2421042C 1 > $DCC_PATH/config
    echo 0x24210430 1 > $DCC_PATH/config
    echo 0x24210434 1 > $DCC_PATH/config
    echo 0x24210848 1 > $DCC_PATH/config
    echo 0x24231048 1 > $DCC_PATH/config
    echo 0x2423104C 1 > $DCC_PATH/config
    echo 0x24BF0010 1 > $DCC_PATH/config
    echo 0x24BF0018 1 > $DCC_PATH/config
    echo 0x24BF0020 1 > $DCC_PATH/config
    echo 0x24BF0024 1 > $DCC_PATH/config
    echo 0x24BF0028 1 > $DCC_PATH/config
    echo 0x24BF002C 1 > $DCC_PATH/config
    echo 0x24BF0030 1 > $DCC_PATH/config
    echo 0x24BF0034 1 > $DCC_PATH/config
    echo 0x24BF0038 1 > $DCC_PATH/config
    echo 0x24BF003C 1 > $DCC_PATH/config
    echo 0x24BF0248 1 > $DCC_PATH/config
}

config_dcc_thermal_limits()
{
    echo 0x0C222004 1 > $DCC_PATH/config
    echo 0x0C228014 1 > $DCC_PATH/config
    echo 0x0C2280E0 1 > $DCC_PATH/config
    echo 0x0C2280EC 1 > $DCC_PATH/config
    echo 0x0C2280A0 16 > $DCC_PATH/config
    echo 0x0C2280E8 1 > $DCC_PATH/config
    echo 0x0C22813C 1 > $DCC_PATH/config
    echo 0x0C223004 1 > $DCC_PATH/config
    echo 0x0C229014 1 > $DCC_PATH/config
    echo 0x0C2290E0 1 > $DCC_PATH/config
    echo 0x0C2290EC 1 > $DCC_PATH/config
    echo 0x0C2290A0 16 > $DCC_PATH/config
    echo 0x0C2290E8 1 > $DCC_PATH/config
    echo 0x0C22913C 1 > $DCC_PATH/config
    echo 0x0C224004 1 > $DCC_PATH/config
    echo 0x0C22A014 1 > $DCC_PATH/config
    echo 0x0C22A0E0 1 > $DCC_PATH/config
    echo 0x0C22A0EC 1 > $DCC_PATH/config
    echo 0x0C22A0A0 16 > $DCC_PATH/config
    echo 0x0C22A0E8 1 > $DCC_PATH/config
    echo 0x0C22A13C 1 > $DCC_PATH/config
    echo 0x0C225004 1 > $DCC_PATH/config
    echo 0x0C22B014 1 > $DCC_PATH/config
    echo 0x0C22B0E0 1 > $DCC_PATH/config
    echo 0x0C22B0EC 1 > $DCC_PATH/config
    echo 0x0C22B0A0 16 > $DCC_PATH/config
    echo 0x0C22B0E8 1 > $DCC_PATH/config
    echo 0x0C22B13C 1 > $DCC_PATH/config
    echo 0xEC80010 1 > $DCC_PATH/config
    echo 0xEC81000 1 > $DCC_PATH/config
    echo 0xEC81010 16 > $DCC_PATH/config
    echo 0xEC81050 4 > $DCC_PATH/config
    echo 0xEC81090 16 > $DCC_PATH/config
    echo 0xEC810D0 16 > $DCC_PATH/config
    echo 0xEC81550 1 > $DCC_PATH/config
    echo 0x17B704E0 16 > $DCC_PATH/config
    echo 0x17B70560 1 > $DCC_PATH/config
    echo 0x17B70580 1 > $DCC_PATH/config
    echo 0x17B70688 1 > $DCC_PATH/config
    echo 0x17B70730 2 > $DCC_PATH/config
    echo 0x17B70738 2 > $DCC_PATH/config
    echo 0x17B70740 2 > $DCC_PATH/config
    echo 0x17B71190 24 > $DCC_PATH/config
    echo 0x17B71490 16 > $DCC_PATH/config
    echo 0x17B71510 16 > $DCC_PATH/config
    echo 0x17B72290 8 > $DCC_PATH/config
    echo 0x17B744E0 16 > $DCC_PATH/config
    echo 0x17B74560 1 > $DCC_PATH/config
    echo 0x17B74580 1 > $DCC_PATH/config
    echo 0x17B74688 1 > $DCC_PATH/config
    echo 0x17B74730 2 > $DCC_PATH/config
    echo 0x17B74738 2 > $DCC_PATH/config
    echo 0x17B74740 2 > $DCC_PATH/config
    echo 0x17B75190 24 > $DCC_PATH/config
    echo 0x17B75490 16 > $DCC_PATH/config
    echo 0x17B75510 16 > $DCC_PATH/config
    echo 0x17B76290 8 > $DCC_PATH/config
    echo 0x17B78220 6 > $DCC_PATH/config
    echo 0x17B782A0 6 > $DCC_PATH/config
    echo 0x17B78320 1 > $DCC_PATH/config
    echo 0x17B784E0 16 > $DCC_PATH/config
    echo 0x17B78560 1 > $DCC_PATH/config
    echo 0x17B78580 1 > $DCC_PATH/config
    echo 0x17B78688 1 > $DCC_PATH/config
    echo 0x17B78730 2 > $DCC_PATH/config
    echo 0x17B78738 2 > $DCC_PATH/config
    echo 0x17B78740 2 > $DCC_PATH/config
    echo 0x17B79190 24 > $DCC_PATH/config
    echo 0x17B79490 16 > $DCC_PATH/config
    echo 0x17B79510 16 > $DCC_PATH/config
    echo 0x17B7A290 8 > $DCC_PATH/config
}

config_dcc_lpass_noc()
{
    echo 0x21510010 1 > $DCC_PATH/config
    echo 0x21510018 1 > $DCC_PATH/config
    echo 0x21510020 1 > $DCC_PATH/config
    echo 0x21510024 1 > $DCC_PATH/config
    echo 0x21510028 1 > $DCC_PATH/config
    echo 0x2151002C 1 > $DCC_PATH/config
    echo 0x21510030 1 > $DCC_PATH/config
    echo 0x21510034 1 > $DCC_PATH/config
    echo 0x21510038 1 > $DCC_PATH/config
    echo 0x2151003C 1 > $DCC_PATH/config
    echo 0x21510248 1 > $DCC_PATH/config
    echo 0x21530010 1 > $DCC_PATH/config
    echo 0x21530018 1 > $DCC_PATH/config
    echo 0x21530020 1 > $DCC_PATH/config
    echo 0x21530024 1 > $DCC_PATH/config
    echo 0x21530028 1 > $DCC_PATH/config
    echo 0x2153002C 1 > $DCC_PATH/config
    echo 0x21530030 1 > $DCC_PATH/config
    echo 0x21530034 1 > $DCC_PATH/config
    echo 0x21530038 1 > $DCC_PATH/config
    echo 0x2153003C 1 > $DCC_PATH/config
    echo 0x21530248 1 > $DCC_PATH/config
    echo 0x22500010 1 > $DCC_PATH/config
    echo 0x22500018 1 > $DCC_PATH/config
    echo 0x22500020 1 > $DCC_PATH/config
    echo 0x22500024 1 > $DCC_PATH/config
    echo 0x22500028 1 > $DCC_PATH/config
    echo 0x2250002C 1 > $DCC_PATH/config
    echo 0x22500030 1 > $DCC_PATH/config
    echo 0x22500034 1 > $DCC_PATH/config
    echo 0x22500038 1 > $DCC_PATH/config
    echo 0x2250003C 1 > $DCC_PATH/config
    echo 0x22500248 1 > $DCC_PATH/config
    echo 0x2850010 1 > $DCC_PATH/config
    echo 0x2850018 1 > $DCC_PATH/config
    echo 0x2850020 1 > $DCC_PATH/config
    echo 0x2850024 1 > $DCC_PATH/config
    echo 0x2850028 1 > $DCC_PATH/config
    echo 0x285002C 1 > $DCC_PATH/config
    echo 0x2850030 1 > $DCC_PATH/config
    echo 0x2850034 1 > $DCC_PATH/config
    echo 0x2850038 1 > $DCC_PATH/config
    echo 0x285003C 1 > $DCC_PATH/config
    echo 0x2850248 1 > $DCC_PATH/config
    echo 0x2861248 1 > $DCC_PATH/config
    echo 0x22000010 1 > $DCC_PATH/config
    echo 0x22000018 1 > $DCC_PATH/config
    echo 0x22000020 1 > $DCC_PATH/config
    echo 0x22000024 1 > $DCC_PATH/config
    echo 0x22000028 1 > $DCC_PATH/config
    echo 0x2200002C 1 > $DCC_PATH/config
    echo 0x22000030 1 > $DCC_PATH/config
    echo 0x22000034 1 > $DCC_PATH/config
    echo 0x22000038 1 > $DCC_PATH/config
    echo 0x2200003C 1 > $DCC_PATH/config
    echo 0x22010010 1 > $DCC_PATH/config
    echo 0x22010018 1 > $DCC_PATH/config
    echo 0x22010020 1 > $DCC_PATH/config
    echo 0x22010024 1 > $DCC_PATH/config
    echo 0x22010028 1 > $DCC_PATH/config
    echo 0x2201002C 1 > $DCC_PATH/config
    echo 0x22010030 1 > $DCC_PATH/config
    echo 0x22010034 1 > $DCC_PATH/config
    echo 0x22010038 1 > $DCC_PATH/config
    echo 0x2201003C 1 > $DCC_PATH/config
    echo 0x22002048 1 > $DCC_PATH/config
    echo 0x22010248 1 > $DCC_PATH/config
    echo 0x22020010 1 > $DCC_PATH/config
    echo 0x22020018 1 > $DCC_PATH/config
    echo 0x22020020 1 > $DCC_PATH/config
    echo 0x22020024 1 > $DCC_PATH/config
    echo 0x22020028 1 > $DCC_PATH/config
    echo 0x2202002C 1 > $DCC_PATH/config
    echo 0x22020030 1 > $DCC_PATH/config
    echo 0x22020034 1 > $DCC_PATH/config
    echo 0x22020038 1 > $DCC_PATH/config
    echo 0x2202003C 1 > $DCC_PATH/config
    echo 0x22020248 1 > $DCC_PATH/config
    echo 0x2205A048 1 > $DCC_PATH/config
    echo 0x22062048 1 > $DCC_PATH/config
    echo 0x22BC4010 1 > $DCC_PATH/config
    echo 0x22BC4018 1 > $DCC_PATH/config
    echo 0x22BC4020 1 > $DCC_PATH/config
    echo 0x22BC4024 1 > $DCC_PATH/config
    echo 0x22BC4028 1 > $DCC_PATH/config
    echo 0x22BC402C 1 > $DCC_PATH/config
    echo 0x22BC4030 1 > $DCC_PATH/config
    echo 0x22BC4034 1 > $DCC_PATH/config
    echo 0x22BC4038 1 > $DCC_PATH/config
    echo 0x22BC403C 1 > $DCC_PATH/config
    echo 0x23E40010 1 > $DCC_PATH/config
    echo 0x23E40018 1 > $DCC_PATH/config
    echo 0x23E40020 1 > $DCC_PATH/config
    echo 0x23E40024 1 > $DCC_PATH/config
    echo 0x23E40028 1 > $DCC_PATH/config
    echo 0x23E4002C 1 > $DCC_PATH/config
    echo 0x23E40030 1 > $DCC_PATH/config
    echo 0x23E40034 1 > $DCC_PATH/config
    echo 0x23E40038 1 > $DCC_PATH/config
    echo 0x23E4003C 1 > $DCC_PATH/config
    echo 0x23E40248 1 > $DCC_PATH/config
    echo 0x23E0A008 1 > $DCC_PATH/config
    echo 0x23E0C004 1 > $DCC_PATH/config
    echo 0x21E78000 1 > $DCC_PATH/config
    echo 0x21E79000 1 > $DCC_PATH/config
    echo 0x21E7A000 1 > $DCC_PATH/config
    echo 0x21E7B000 1 > $DCC_PATH/config
    echo 0x21E77000 1 > $DCC_PATH/config
}

config_dcc_gcc()
{
    echo 0x110018 10 > $DCC_PATH/config
    echo 0x11C018 10 > $DCC_PATH/config
    echo 0x100000 2 > $DCC_PATH/config
    echo 0x101000 2 > $DCC_PATH/config
    echo 0x102000 > $DCC_PATH/config
    echo 0x102030 > $DCC_PATH/config
    echo 0x103000 2 > $DCC_PATH/config
    echo 0x104000 2 > $DCC_PATH/config
    echo 0x105000 2 > $DCC_PATH/config
    echo 0x106000 2 > $DCC_PATH/config
    echo 0x107000 2 > $DCC_PATH/config
    echo 0x108000 2 > $DCC_PATH/config
    echo 0x109000 2 > $DCC_PATH/config
    echo 0x110004 2 > $DCC_PATH/config
    echo 0x110024 2 > $DCC_PATH/config
    echo 0x110078 > $DCC_PATH/config
    echo 0x118028 > $DCC_PATH/config
    echo 0x118164 > $DCC_PATH/config
    echo 0x1182B4 > $DCC_PATH/config
    echo 0x1183F0 > $DCC_PATH/config
    echo 0x11852C > $DCC_PATH/config
    echo 0x118668 > $DCC_PATH/config
    echo 0x1187A4 > $DCC_PATH/config
    echo 0x1188D4 > $DCC_PATH/config
    echo 0x11C004 2 > $DCC_PATH/config
    echo 0x11C024 2 > $DCC_PATH/config
    echo 0x11E028 > $DCC_PATH/config
    echo 0x11E164 > $DCC_PATH/config
    echo 0x11E2A0 > $DCC_PATH/config
    echo 0x11E3DC > $DCC_PATH/config
    echo 0x11E518 > $DCC_PATH/config
    echo 0x11E654 > $DCC_PATH/config
    echo 0x11E790 > $DCC_PATH/config
    echo 0x11E8CC > $DCC_PATH/config
    echo 0x123040 > $DCC_PATH/config
    echo 0x135034 > $DCC_PATH/config
    echo 0x135054 > $DCC_PATH/config
    echo 0x136028 > $DCC_PATH/config
    echo 0x139004 2 > $DCC_PATH/config
    echo 0x141030 > $DCC_PATH/config
    echo 0x144008 > $DCC_PATH/config
    echo 0x144044 > $DCC_PATH/config
    echo 0x1442A0 > $DCC_PATH/config
    echo 0x14502C > $DCC_PATH/config
    echo 0x150018 2 > $DCC_PATH/config
    echo 0x151000 > $DCC_PATH/config
    echo 0x151020 > $DCC_PATH/config
    echo 0x152000 > $DCC_PATH/config
    echo 0x152020 > $DCC_PATH/config
    echo 0x153034 > $DCC_PATH/config
    echo 0x153054 > $DCC_PATH/config
    echo 0x155000 > $DCC_PATH/config
    echo 0x155020 > $DCC_PATH/config
    echo 0x156000 > $DCC_PATH/config
    echo 0x156020 > $DCC_PATH/config
    echo 0x157000 > $DCC_PATH/config
    echo 0x157020 > $DCC_PATH/config
    echo 0x15A000 > $DCC_PATH/config
    echo 0x15A020 > $DCC_PATH/config
    echo 0x15B000 > $DCC_PATH/config
    echo 0x15B020 > $DCC_PATH/config
    echo 0x169034 > $DCC_PATH/config
    echo 0x169054 > $DCC_PATH/config
    echo 0x16B004 2 > $DCC_PATH/config
    echo 0x16C000 2 > $DCC_PATH/config
    echo 0x174074 > $DCC_PATH/config
    echo 0x1741A0 > $DCC_PATH/config
    echo 0x175000 > $DCC_PATH/config
    echo 0x176040 > $DCC_PATH/config
    echo 0x177004 2 > $DCC_PATH/config
    echo 0x178030 > $DCC_PATH/config
    echo 0x178040 > $DCC_PATH/config
    echo 0x179000 > $DCC_PATH/config
    echo 0x179020 > $DCC_PATH/config
    echo 0x17A80000 > $DCC_PATH/config
    echo 0x17A80030 > $DCC_PATH/config
    echo 0x17A84000 > $DCC_PATH/config
    echo 0x17A84030 > $DCC_PATH/config
    echo 0x17A88000 > $DCC_PATH/config
    echo 0x17A88030 > $DCC_PATH/config
    echo 0x199014 10 > $DCC_PATH/config
    echo 0x19D014 10 > $DCC_PATH/config
    echo 0x1AD030 4 > $DCC_PATH/config
    echo 0x183004 2 > $DCC_PATH/config
    echo 0x183018 2 > $DCC_PATH/config
    echo 0x18315C 5 > $DCC_PATH/config
    echo 0x183184 > $DCC_PATH/config
    echo 0x1833D0 > $DCC_PATH/config
    echo 0x189004 2 > $DCC_PATH/config
    echo 0x18905C > $DCC_PATH/config
    echo 0x190890 > $DCC_PATH/config
    echo 0x199000 2 > $DCC_PATH/config
    echo 0x199020 2 > $DCC_PATH/config
    echo 0x199064 > $DCC_PATH/config
    echo 0x19D000 2 > $DCC_PATH/config
    echo 0x19D020 2 > $DCC_PATH/config
    echo 0x19D068 > $DCC_PATH/config
    echo 0x19E000 2 > $DCC_PATH/config
    echo 0x1A1000 2 > $DCC_PATH/config
    echo 0x1A8034 > $DCC_PATH/config
    echo 0x1A8054 > $DCC_PATH/config
    echo 0x1AD030 4 > $DCC_PATH/config
    echo 0xC2A0000 2 > $DCC_PATH/config
    echo 0xC2A1000 2 > $DCC_PATH/config
    echo 0x144018 1 > $DCC_PATH/config
}

config_dcc_gic()
{
    echo 0x17200104 29 > $DCC_PATH/config
    echo 0x17200204 29 > $DCC_PATH/config
    echo 0x17200384 29 > $DCC_PATH/config
}

config_dcc_lpass()
{
    echo 0x214C0208 1 > $DCC_PATH/config
    echo 0x214C0228 1 > $DCC_PATH/config
    echo 0x214C0248 1 > $DCC_PATH/config
    echo 0x214C0268 1 > $DCC_PATH/config
    echo 0x214C0288 1 > $DCC_PATH/config
    echo 0x214C02A8 1 > $DCC_PATH/config
    echo 0x214C020C 1 > $DCC_PATH/config
    echo 0x214C022C 1 > $DCC_PATH/config
    echo 0x214C024C 1 > $DCC_PATH/config
    echo 0x214C026C 1 > $DCC_PATH/config
    echo 0x214C028C 1 > $DCC_PATH/config
    echo 0x214C02AC 1 > $DCC_PATH/config
    echo 0x214C0210 1 > $DCC_PATH/config
    echo 0x214C0230 1 > $DCC_PATH/config
    echo 0x214C0250 1 > $DCC_PATH/config
    echo 0x214C0270 1 > $DCC_PATH/config
    echo 0x214C0290 1 > $DCC_PATH/config
    echo 0x214C02b0 1 > $DCC_PATH/config
    echo 0x214C0404 2 > $DCC_PATH/config
    echo 0x21F00208 1 > $DCC_PATH/config
    echo 0x21F00228 1 > $DCC_PATH/config
    echo 0x21F00248 1 > $DCC_PATH/config
    echo 0x21F00268 1 > $DCC_PATH/config
    echo 0x21F00288 1 > $DCC_PATH/config
    echo 0x21F002A8 3 > $DCC_PATH/config
    echo 0x21F0020C 2 > $DCC_PATH/config
    echo 0x21F0022C 2 > $DCC_PATH/config
    echo 0x21F0024C 2 > $DCC_PATH/config
    echo 0x21F0026C 2 > $DCC_PATH/config
    echo 0x21F0028C 2 > $DCC_PATH/config
    echo 0x2140030C 1 > $DCC_PATH/config
    echo 0x21F00408 1 > $DCC_PATH/config
    echo 0x21400304 2 > $DCC_PATH/config
    echo 0x21440000 11 > $DCC_PATH/config
    echo 0x21440034 1 > $DCC_PATH/config
    echo 0x21448000 2 > $DCC_PATH/config
    echo 0x21448020 1 > $DCC_PATH/config
    echo 0x21C20408 1 > $DCC_PATH/config
    echo 0x21C20208 2 > $DCC_PATH/config
    echo 0x21920408 1 > $DCC_PATH/config
    echo 0x21920208 2 > $DCC_PATH/config
    echo 0x21F3387C 1 > $DCC_PATH/config
    echo 0x21F33A6C 1 > $DCC_PATH/config
    echo 0x21F33C5C 1 > $DCC_PATH/config
    echo 0x21F33E4C 1 > $DCC_PATH/config
    echo 0x21F3403C 1 > $DCC_PATH/config
    echo 0x21F3422C 1 > $DCC_PATH/config
    echo 0x21F3441C 1 > $DCC_PATH/config
    echo 0x21F3460C 1 > $DCC_PATH/config
    echo 0x21F30264 1 > $DCC_PATH/config
    echo 0x21F30284 1 > $DCC_PATH/config
    echo 0x21F302A4 1 > $DCC_PATH/config
    echo 0x21F302C4 1 > $DCC_PATH/config
    echo 0x21F302E4 1 > $DCC_PATH/config
    echo 0x21F30304 1 > $DCC_PATH/config
    echo 0x21F31264 1 > $DCC_PATH/config
    echo 0x21F31284 1 > $DCC_PATH/config
    echo 0x21F312A4 1 > $DCC_PATH/config
    echo 0x21F312C4 1 > $DCC_PATH/config
    echo 0x21F312E4 1 > $DCC_PATH/config
    echo 0x21F31304 1 > $DCC_PATH/config
    echo 0x21F32264 1 > $DCC_PATH/config
    echo 0x21F32284 1 > $DCC_PATH/config
    echo 0x21F322A4 1 > $DCC_PATH/config
    echo 0x21F322C4 1 > $DCC_PATH/config
    echo 0x21F322E4 1 > $DCC_PATH/config
    echo 0x21F32304 1 > $DCC_PATH/config
    echo 0x21920228 1 > $DCC_PATH/config
    echo 0x21920248 1 > $DCC_PATH/config
    echo 0x21920268 1 > $DCC_PATH/config
    echo 0x2192020C 1 > $DCC_PATH/config
    echo 0x2192022C 1 > $DCC_PATH/config
    echo 0x2192024C 1 > $DCC_PATH/config
    echo 0x2192026C 1 > $DCC_PATH/config
    echo 0x2192040C 1 > $DCC_PATH/config
    echo 0x21C20408 1 > $DCC_PATH/config
}

config_dcc_qup()
{
    echo 0xAC0008 1 > $DCC_PATH/config
    echo 0xAC0100 3 > $DCC_PATH/config
    echo 0xAC0110 1 > $DCC_PATH/config
    echo 0xAC0120 2 > $DCC_PATH/config
    echo 0xAC1000 3 > $DCC_PATH/config
}

config_dcc_noc_tr()
{
    echo 0x150E010 1 > $DCC_PATH/config
    echo 0x150F010 1 > $DCC_PATH/config
    echo 0x1510010 1 > $DCC_PATH/config
    echo 0x1511010 1 > $DCC_PATH/config
    echo 0x1512010 1 > $DCC_PATH/config
    echo 0x1513010 1 > $DCC_PATH/config
    echo 0x1691010 1 > $DCC_PATH/config
    echo 0x1693010 1 > $DCC_PATH/config
    echo 0x1694010 1 > $DCC_PATH/config
    echo 0x1695010 1 > $DCC_PATH/config
    echo 0x16C9010 1 > $DCC_PATH/config
    echo 0x16EA010 1 > $DCC_PATH/config
    echo 0x16EB010 1 > $DCC_PATH/config
    echo 0x16EC010 1 > $DCC_PATH/config
    echo 0x16ED010 1 > $DCC_PATH/config
    echo 0x16EE010 1 > $DCC_PATH/config
    echo 0x16EF010 1 > $DCC_PATH/config
    echo 0x16F0010 1 > $DCC_PATH/config
    echo 0x16F1010 1 > $DCC_PATH/config
    echo 0x16F2010 1 > $DCC_PATH/config
    echo 0x1790010 1 > $DCC_PATH/config
    echo 0x1793010 1 > $DCC_PATH/config
    echo 0x1794010 1 > $DCC_PATH/config
    echo 0x1795010 1 > $DCC_PATH/config
    echo 0x1798010 1 > $DCC_PATH/config
    echo 0x179D010 1 > $DCC_PATH/config
    echo 0x21515010 1 > $DCC_PATH/config
    echo 0x21535010 1 > $DCC_PATH/config
    echo 0x22018010 1 > $DCC_PATH/config
    echo 0x22034010 1 > $DCC_PATH/config
    echo 0x22035010 1 > $DCC_PATH/config
    echo 0x22036010 1 > $DCC_PATH/config
    echo 0x22037010 1 > $DCC_PATH/config
    echo 0x22038010 1 > $DCC_PATH/config
    echo 0x22039010 1 > $DCC_PATH/config
    echo 0x2203A010 1 > $DCC_PATH/config
    echo 0x2203B010 1 > $DCC_PATH/config
    echo 0x2203C010 1 > $DCC_PATH/config
    echo 0x2203D010 1 > $DCC_PATH/config
    echo 0x2203E010 1 > $DCC_PATH/config
    echo 0x2203F010 1 > $DCC_PATH/config
    echo 0x22040010 1 > $DCC_PATH/config
    echo 0x22041010 1 > $DCC_PATH/config
    echo 0x2205C010 1 > $DCC_PATH/config
    echo 0x22064010 1 > $DCC_PATH/config
    echo 0x22510010 1 > $DCC_PATH/config
    echo 0x22510090 1 > $DCC_PATH/config
    echo 0x22510110 1 > $DCC_PATH/config
    echo 0x22510190 1 > $DCC_PATH/config
    echo 0x22510210 1 > $DCC_PATH/config
    echo 0x22510290 1 > $DCC_PATH/config
    echo 0x22510310 1 > $DCC_PATH/config
    echo 0x22510390 1 > $DCC_PATH/config
    echo 0x22510410 1 > $DCC_PATH/config
    echo 0x22510490 1 > $DCC_PATH/config
    echo 0x285B010 1 > $DCC_PATH/config
    echo 0x285B090 1 > $DCC_PATH/config
    echo 0x285B110 1 > $DCC_PATH/config
    echo 0x285B190 1 > $DCC_PATH/config
    echo 0x23E4A010 1 > $DCC_PATH/config
    echo 0x23E4B010 1 > $DCC_PATH/config
    echo 0x23E4C010 1 > $DCC_PATH/config
    echo 0x240EB010 1 > $DCC_PATH/config
    echo 0x240EC010 1 > $DCC_PATH/config
    echo 0x240ED010 1 > $DCC_PATH/config
    echo 0x240EE010 1 > $DCC_PATH/config
    echo 0x22BC7010 1 > $DCC_PATH/config
    echo 0x24125010 1 > $DCC_PATH/config
    echo 0x24126010 1 > $DCC_PATH/config
    echo 0x24127010 1 > $DCC_PATH/config
    echo 0x24128010 1 > $DCC_PATH/config
    echo 0x241D0010 1 > $DCC_PATH/config
    echo 0x241D0410 1 > $DCC_PATH/config
    echo 0x24250010 1 > $DCC_PATH/config
    echo 0x24251010 1 > $DCC_PATH/config
    echo 0x24252010 1 > $DCC_PATH/config
    echo 0x24253010 1 > $DCC_PATH/config
    echo 0x24254010 1 > $DCC_PATH/config
    echo 0x24255010 1 > $DCC_PATH/config
    echo 0x24256010 1 > $DCC_PATH/config
    echo 0x24257010 1 > $DCC_PATH/config
    echo 0x24258010 1 > $DCC_PATH/config
    echo 0x24BF6010 1 > $DCC_PATH/config
    echo 0x320D4010 1 > $DCC_PATH/config
    echo 0x320D5010 1 > $DCC_PATH/config
    echo 0x320DA010 1 > $DCC_PATH/config
    echo 0x169A010 1 > $DCC_PATH/config
    echo 0x169B010 1 > $DCC_PATH/config
    echo 0x16CB010 1 > $DCC_PATH/config
    echo 0x16F3010 1 > $DCC_PATH/config
    echo 0x16F4010 1 > $DCC_PATH/config
    echo 0x16F5010 1 > $DCC_PATH/config
    echo 0x16F6010 1 > $DCC_PATH/config
    echo 0x16F7010 1 > $DCC_PATH/config
    echo 0x16F8010 1 > $DCC_PATH/config
    echo 0x16F9010 1 > $DCC_PATH/config
    echo 0x16FA010 1 > $DCC_PATH/config
    echo 0x16FB010 1 > $DCC_PATH/config
    echo 0x17AC010 1 > $DCC_PATH/config
    echo 0x17AD010 1 > $DCC_PATH/config
    echo 0x17AE010 1 > $DCC_PATH/config
    echo 0x17B1010 1 > $DCC_PATH/config
    echo 0x17B6010 1 > $DCC_PATH/config
    echo 0x285C010 1 > $DCC_PATH/config
    echo 0x285C090 1 > $DCC_PATH/config
    echo 0x285C110 1 > $DCC_PATH/config
    echo 0x285C190 1 > $DCC_PATH/config
    echo 0x21516010 1 > $DCC_PATH/config
    echo 0x21536010 1 > $DCC_PATH/config
    echo 0x22042010 1 > $DCC_PATH/config
    echo 0x22043010 1 > $DCC_PATH/config
    echo 0x22044010 1 > $DCC_PATH/config
    echo 0x22045010 1 > $DCC_PATH/config
    echo 0x22046010 1 > $DCC_PATH/config
    echo 0x22047010 1 > $DCC_PATH/config
    echo 0x22048010 1 > $DCC_PATH/config
    echo 0x22049010 1 > $DCC_PATH/config
    echo 0x2204A010 1 > $DCC_PATH/config
    echo 0x2205D010 1 > $DCC_PATH/config
    echo 0x22511010 1 > $DCC_PATH/config
    echo 0x22511090 1 > $DCC_PATH/config
    echo 0x22511110 1 > $DCC_PATH/config
    echo 0x22511190 1 > $DCC_PATH/config
    echo 0x22511210 1 > $DCC_PATH/config
    echo 0x22511290 1 > $DCC_PATH/config
    echo 0x22511310 1 > $DCC_PATH/config
    echo 0x22511390 1 > $DCC_PATH/config
    echo 0x22511410 1 > $DCC_PATH/config
    echo 0x22511490 1 > $DCC_PATH/config
    echo 0x22511510 1 > $DCC_PATH/config
    echo 0x22511590 1 > $DCC_PATH/config
    echo 0x22511610 1 > $DCC_PATH/config
    echo 0x22511690 1 > $DCC_PATH/config
    echo 0x22BC9010 1 > $DCC_PATH/config
    echo 0x23E4D010 1 > $DCC_PATH/config
    echo 0x23E4E010 1 > $DCC_PATH/config
    echo 0x240EF110 1 > $DCC_PATH/config
    echo 0x240EF210 1 > $DCC_PATH/config
    echo 0x240EF310 1 > $DCC_PATH/config
    echo 0x24130010 1 > $DCC_PATH/config
    echo 0x24132010 1 > $DCC_PATH/config
    echo 0x24134010 1 > $DCC_PATH/config
    echo 0x24136010 1 > $DCC_PATH/config
    echo 0x24137010 1 > $DCC_PATH/config
    echo 0x241F0010 1 > $DCC_PATH/config
    echo 0x241F0410 1 > $DCC_PATH/config
    echo 0x24260010 1 > $DCC_PATH/config
    echo 0x24262010 1 > $DCC_PATH/config
    echo 0x24270010 1 > $DCC_PATH/config
    echo 0x24272010 1 > $DCC_PATH/config
    echo 0x24274010 1 > $DCC_PATH/config
    echo 0x24276010 1 > $DCC_PATH/config
    echo 0x24278010 1 > $DCC_PATH/config
    echo 0x2427A010 1 > $DCC_PATH/config
    echo 0x2427C010 1 > $DCC_PATH/config
    echo 0x2427D010 1 > $DCC_PATH/config
    echo 0x2427E010 1 > $DCC_PATH/config
    echo 0x320DB010 1 > $DCC_PATH/config
    echo 0x320DC010 1 > $DCC_PATH/config
    echo 0x320DF010 1 > $DCC_PATH/config
}

config_dcc_cprf()
{
    echo 0xC201244 1 > $DCC_PATH/config
    echo 0xC202244 1 > $DCC_PATH/config
    echo 0x17880000 1 > $DCC_PATH/config
}

config_dcc_timer()
{
    echo 0x17421000 2 > $DCC_PATH/config
}

config_dcc_power()
{
    echo 0x23E0A000 1 > $DCC_PATH/config
    echo 0x23E0A004 0x1 > $DCC_PATH/config_write
    echo 0xA > $DCC_PATH/loop
    echo 0x23E0A000 1 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x23E0A000 0x000000d > $DCC_PATH/config_write
    echo 0x23E0A004 1 > $DCC_PATH/config
    echo 0x32 > $DCC_PATH/loop
    echo 0x23E0A008 1 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x23E0A000 1 > $DCC_PATH/config
}

enable_dcc()
{
    #TODO: Add DCC configuration
    DCC_PATH="/sys/bus/platform/devices/100ff000.dcc"
    soc_version=`cat /sys/devices/soc0/revision`
    soc_version=${soc_version/./}

    if [ ! -d $DCC_PATH ]; then
        echo "DCC does not exist on this build."
        return
    fi

    echo 0 > $DCC_PATH/enable
    echo 1 > $DCC_PATH/config_reset
    echo 4 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    echo 1 > $DCC_PATH/ap_ns_qad_override_en
    config_dcc_timer
    config_dcc_cpu_core
    config_dcc_gemnoc
    config_dcc_mach9
    config_dcc_mccc
    config_dcc_dpcc
    config_dcc_shrm
    config_dcc_ddrphy
    config_dcc_power

    config_dcc_lpm_pcu
    config_dcc_apss_rsc
    config_dcc_rpmh_apps_pdc
    config_dcc_cdsp
    config_dcc_misc
    config_dcc_cprf
    config_dcc_epss
    config_dcc_apps_hang
    config_dcc_bt_uart

    echo 3 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    echo 1 > $DCC_PATH/ap_ns_qad_override_en
    config_dcc_timer
    config_dcc_mmss_noc
    config_dcc_system_noc
    config_dcc_apps_gic_noc
    config_dcc_lpass_noc
    config_dcc_dc_noc_dump
    config_dcc_gemnoc_qns
    config_dcc_aggre_noc
    config_noc_dump
    config_dcc_thermal_limits
    #config_dcc_nsp_noc
    config_dcc_gcc
    config_dcc_gic

    config_dcc_lpass
    config_dcc_qup
    config_dcc_gpu
    config_dcc_noc_tr

    echo 2 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    echo 0 > $DCC_PATH/ap_ns_qad_override_en
    config_dcc_modem
    echo  1 > $DCC_PATH/enable
}

init_dynamic_mem_dump()
{
    if [ "$debug_build" != true ]
    then
        return
    fi

    if [ ! -d "/sys/bus/platform/devices/soc:mem_dump/dynamic_mem_dump" ]
    then
        return
    fi
    echo "enabling dynamic_mem_dump"
    echo cpuss_reg > /sys/bus/platform/devices/soc:mem_dump/dynamic_mem_dump/enable
}

create_stp_policy()
{
    create_instance /config/stp-policy/stm0:p_ost.policy
    chmod 660 /config/stp-policy/stm0:p_ost.policy
    create_instance /config/stp-policy/stm0:p_ost.policy/default
    chmod 660 /config/stp-policy/stm0:p_ost.policy/default
    echo ftrace > /config/stp-policy/stm0:p_ost.policy/default/entity
}

adjust_permission()
{
    #add permission for block_size, mem_type, mem_size nodes to collect diag over QDSS by ODL
    #application by "oem_2902" group
    chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/tmc_etr0/block_size
    chmod 660 /sys/devices/platform/soc/10048000.tmc/tmc_etr0/block_size
    chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/tmc_etr0/buffer_size
    chmod 660 /sys/devices/platform/soc/10048000.tmc/tmc_etr0/buffer_size
    chmod 660 /sys/devices/platform/soc/10048000.tmc/tmc_etr0/out_mode
    chown -h root.oem_2902 /sys/devices/platform/soc/1004f000.tmc/tmc_etr1/block_size
    chmod 660 /sys/devices/platform/soc/1004f000.tmc/tmc_etr1/block_size
    chown -h root.oem_2902 /sys/devices/platform/soc/1004f000.tmc/tmc_etr1/buffer_size
    chmod 660 /sys/devices/platform/soc/1004f000.tmc/tmc_etr1/buffer_size
    chmod 660 /sys/devices/platform/soc/1004f000.tmc/tmc_etr1/out_mode

    chgrp shell /sys/bus/coresight/devices/*/enable_source
    chmod 660 /sys/bus/coresight/devices/*/enable_source
    chgrp shell /sys/bus/coresight/devices/*/enable_sink
    chmod 660 /sys/bus/coresight/devices/*/enable_sink
}

enable_stm_events()
{
    # bail out if its perf config
    if [ "$debug_build" = false ]
    then
        return
    fi
    # bail out if coresight isn't present
    if [ ! -d /sys/bus/coresight ]
    then
        return
    fi
    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/tracing/events ]
    then
        return
    fi

    echo $etr_size > /sys/bus/coresight/devices/tmc_etr0/buffer_size
    echo 1 > /sys/bus/coresight/devices/tmc_etr0/$sinkenable
    #echo stm0 > /sys/class/stm_source/ftrace/stm_source_link
    echo 1 > /sys/bus/coresight/devices/stm0/$srcenable
    echo 1 > /sys/kernel/tracing/tracing_on
    echo 0 > /sys/bus/coresight/devices/stm0/hwevent_enable
}

enable_cti_flush_for_etf()
{
    if [ "$debug_build" != true ]
    then
        return
    fi

    echo 1 > /sys/bus/coresight/devices/tmc_etf0/stop_on_flush
    echo 1 > /sys/bus/coresight/devices/cti_swao/enable
    echo 1 > /sys/bus/coresight/devices/cti_trace_noc_center1/enable
    echo 0 24 > /sys/bus/coresight/devices/cti_trace_noc_center1/channels/trigin_attach
    echo 0 1 > /sys/bus/coresight/devices/cti_swao/channels/trigout_attach
}

find_build_type()
{
    linux_banner=`cat /proc/version`
    if [[ "$linux_banner" == *"-debug"* ]]
    then
        debug_build=true
    fi
}

ftrace_disable=`getprop persist.debug.ftrace_events_disable`
debug_build=false
enable_debug()
{
    echo "vienna debug"
    etr_size="0x2000000"
    srcenable="enable_source"
    sinkenable="enable_sink"
    find_build_type
    init_dynamic_mem_dump
    create_stp_policy
    adjust_permission
    enable_stm_events
    enable_cti_flush_for_etf
    if [ "$ftrace_disable" != "Yes" ]; then
        enable_extra_ftrace_events
        enable_buses_and_interconnect_tracefs_debug
    fi
    enable_dcc
    sf_tracing_disablement
}

enable_debug
