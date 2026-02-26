#!/bin/sh
# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
# SPDX-License-Identifier: BSD-3-Clause-Clear

config_sa535m_dcc_core()
{
	# CORE_HANG_THRESHOLD
	echo R 0x17800058 > $DCC_PATH/$1/config
	echo R 0x17810058 > $DCC_PATH/$1/config
	echo R 0x17820058 > $DCC_PATH/$1/config
	echo R 0x17830058 > $DCC_PATH/$1/config
	# CORE_HANG_VALUE
	echo R 0x1780005c > $DCC_PATH/$1/config
	echo R 0x1781005c > $DCC_PATH/$1/config
	echo R 0x1782005c > $DCC_PATH/$1/config
	echo R 0x1783005c > $DCC_PATH/$1/config
	#first core hang
	echo R 0x1740003c > $DCC_PATH/$1/config
	# CORE_HANG_CONFIG
	echo R 0x17800060 > $DCC_PATH/$1/config
	echo R 0x17810060 > $DCC_PATH/$1/config
	echo R 0x17820060 > $DCC_PATH/$1/config
	echo R 0x17830060 > $DCC_PATH/$1/config
	#CORE_HANG_DBG_STS
	echo R 0x17800064 > $DCC_PATH/$1/config
	echo R 0x17810064 > $DCC_PATH/$1/config
	echo R 0x17820064 > $DCC_PATH/$1/config
	echo R 0x17830064 > $DCC_PATH/$1/config

	#MIBU Debug registers
	echo R 0x17600238 > $DCC_PATH/$1/config

	#LPM_COUNTER_CFG : Core 0 to Core 3
	echo R 0x17800054 > $DCC_PATH/$1/config
	echo R 0x17810054 > $DCC_PATH/$1/config
	echo R 0x17820054 > $DCC_PATH/$1/config
	echo R 0x17830054 > $DCC_PATH/$1/config

	#PWR_CTL_VAL/MASK
	echo R 0x17880140 2 > $DCC_PATH/$1/config

	#SILVER/GOLD HWEVENT_SEL
	echo R 0x1788019C 2 > $DCC_PATH/$1/config

	#GICSLP
	echo R 0x17880250 4 > $DCC_PATH/$1/config

	echo R 0x17880090 5 > $DCC_PATH/$1/config
	echo R 0x178800E0 5 > $DCC_PATH/$1/config
	echo R 0x17880108 4 > $DCC_PATH/$1/config
	echo R 0x17880140 2 > $DCC_PATH/$1/config
	echo R 0x178801C0 2 > $DCC_PATH/$1/config
	echo R 0x178801F0 5 > $DCC_PATH/$1/config
	echo R 0x17880250 4 > $DCC_PATH/$1/config

	#APSS_SHARED_SYSCO_HS_BYP_CSR
	echo R 0x17600044 > $DCC_PATH/$1/config

	#GNOC Hang counters
	echo R 0x17600404 > $DCC_PATH/$1/config
	echo R 0x1760041c 2 > $DCC_PATH/$1/config
	echo R 0x17600434 > $DCC_PATH/$1/config
	echo R 0x1760043c 2 > $DCC_PATH/$1/config

	#CPRh
	echo R 0x17900908 > $DCC_PATH/$1/config
	echo R 0x17900c18 > $DCC_PATH/$1/config

	#CX and MX (RPMH_CPRF_CPRFm_VALUES_1)
	echo R 0xC201244 5 > $DCC_PATH/$1/config

	#rpmh
	#RPMH_CPRF_CPRFm_INTERRUPT_STATUS, m=0..5 | 0xC201220 + (0x1000*m)
	echo R 0xC201220 > $DCC_PATH/$1/config
	echo R 0xC202220 > $DCC_PATH/$1/config
	echo R 0xC203220 > $DCC_PATH/$1/config
	echo R 0xC204220 > $DCC_PATH/$1/config
	echo R 0xC205220 > $DCC_PATH/$1/config
	echo R 0xC206220 > $DCC_PATH/$1/config
	#RPMH_CPRF_CPRFm_VALUES, m=0..5 | 0xC201230 + (0x1000*m)
	echo R 0xC201230 > $DCC_PATH/$1/config
	echo R 0xC202230 > $DCC_PATH/$1/config
	echo R 0xC203230 > $DCC_PATH/$1/config
	echo R 0xC204230 > $DCC_PATH/$1/config
	echo R 0xC205230 > $DCC_PATH/$1/config
	echo R 0xC206230 > $DCC_PATH/$1/config
	#RPMH_CPRF_CPRFm_VALUES_1, m=0..5 | 0xC201244 + (0x1000*m)
	echo R 0xC201244 > $DCC_PATH/$1/config
	echo R 0xC202244 > $DCC_PATH/$1/config
	echo R 0xC203244 > $DCC_PATH/$1/config
	echo R 0xC204244 > $DCC_PATH/$1/config
	echo R 0xC205244 > $DCC_PATH/$1/config
	echo R 0xC206244 > $DCC_PATH/$1/config
	#RPMH_CPRF_CPRFm_VALUES_2_n, m=0..5, n=0..19 | 0xC2012D0 + (0x1000*m) + (0x4*n)
	echo R 0xC2012D0 20 > $DCC_PATH/$1/config
	echo R 0xC2022D0 20 > $DCC_PATH/$1/config
	echo R 0xC2032D0 20 > $DCC_PATH/$1/config
	echo R 0xC2042D0 20 > $DCC_PATH/$1/config
	echo R 0xC2052D0 20 > $DCC_PATH/$1/config
	echo R 0xC2062D0 20 > $DCC_PATH/$1/config
	#RPMH_CPRF_CPRFm_VALUES_3_n, m=0..5, n=0..19 | 0xC201350 + (0x1000*m) + (0x4*n)
	echo R 0xC201350 20 > $DCC_PATH/$1/config
	echo R 0xC202350 20 > $DCC_PATH/$1/config
	echo R 0xC203350 20 > $DCC_PATH/$1/config
	echo R 0xC204350 20 > $DCC_PATH/$1/config
	echo R 0xC205350 20 > $DCC_PATH/$1/config
	echo R 0xC206350 20 > $DCC_PATH/$1/config
	#RPMH_CPRF_CPRFm_VALUES_4_n, m=0..5, n=0..19 | 0xC2013D0 + (0x1000*m) + (0x4*n)
	echo R 0xC2013D0 20 > $DCC_PATH/$1/config
	echo R 0xC2023D0 20 > $DCC_PATH/$1/config
	echo R 0xC2033D0 20 > $DCC_PATH/$1/config
	echo R 0xC2043D0 20 > $DCC_PATH/$1/config
	echo R 0xC2053D0 20 > $DCC_PATH/$1/config
	echo R 0xC2063D0 20 > $DCC_PATH/$1/config
	#RPMH_CPRF_CPRFm_VALUES_5_n, m=0..5, n=0..19 | 0xC201450 + (0x1000*m) + (0x4*n)
	echo R 0xC201450 20 > $DCC_PATH/$1/config
	echo R 0xC202450 20 > $DCC_PATH/$1/config
	echo R 0xC203450 20 > $DCC_PATH/$1/config
	echo R 0xC204450 20 > $DCC_PATH/$1/config
	echo R 0xC205450 20 > $DCC_PATH/$1/config
	echo R 0xC206450 20 > $DCC_PATH/$1/config
	#RPMH_CPRF_CPRFm_VALUES_6, m=0..5 | 0xC201550 + (0x1000*m)
	echo R 0xC201550 1 > $DCC_PATH/$1/config
	echo R 0xC202550 1 > $DCC_PATH/$1/config
	echo R 0xC203550 1 > $DCC_PATH/$1/config
	echo R 0xC204550 1 > $DCC_PATH/$1/config
	echo R 0xC205550 1 > $DCC_PATH/$1/config
	echo R 0xC206550 1 > $DCC_PATH/$1/config

	#CPR related registers
	echo R 0x17ba0000 6 > $DCC_PATH/$1/config
	echo R 0x17ba0020 5 > $DCC_PATH/$1/config
	echo R 0x17ba0050 > $DCC_PATH/$1/config
	echo R 0x17ba0070 > $DCC_PATH/$1/config
	echo R 0x17ba0080 25 > $DCC_PATH/$1/config
	echo R 0x17ba0100 > $DCC_PATH/$1/config
	echo R 0x17ba0120 > $DCC_PATH/$1/config
	echo R 0x17ba0140 > $DCC_PATH/$1/config
	echo R 0x17ba0200 6 > $DCC_PATH/$1/config
	echo R 0x17ba0700 > $DCC_PATH/$1/config
	echo R 0x17ba070c 3 > $DCC_PATH/$1/config
	echo R 0x17ba0780 32 > $DCC_PATH/$1/config
	echo R 0x17ba0808 > $DCC_PATH/$1/config
	echo R 0x17ba0c48 > $DCC_PATH/$1/config
	echo R 0x17ba080c > $DCC_PATH/$1/config
	echo R 0x17ba0c4c > $DCC_PATH/$1/config
	echo R 0x17ba0810 > $DCC_PATH/$1/config
	echo R 0x17ba0c50 > $DCC_PATH/$1/config
	echo R 0x17ba0814 > $DCC_PATH/$1/config
	echo R 0x17ba0c54 > $DCC_PATH/$1/config
	echo R 0x17ba0818 > $DCC_PATH/$1/config
	echo R 0x17ba0c58 > $DCC_PATH/$1/config
	echo R 0x17ba081c > $DCC_PATH/$1/config
	echo R 0x17ba0c5c > $DCC_PATH/$1/config
	echo R 0x17ba0824 > $DCC_PATH/$1/config
	echo R 0x17ba0c64 > $DCC_PATH/$1/config
	echo R 0x17ba0828 > $DCC_PATH/$1/config
	echo R 0x17ba0c68 > $DCC_PATH/$1/config
	echo R 0x17ba082c > $DCC_PATH/$1/config
	echo R 0x17ba0c6c > $DCC_PATH/$1/config
	echo R 0x17ba0840 > $DCC_PATH/$1/config
	echo R 0x17ba0c80 > $DCC_PATH/$1/config
	echo R 0x17ba0844 > $DCC_PATH/$1/config
	echo R 0x17ba0c84 > $DCC_PATH/$1/config
	echo R 0x17ba0848 > $DCC_PATH/$1/config
	echo R 0x17ba0c88 > $DCC_PATH/$1/config
	echo R 0x17ba084c > $DCC_PATH/$1/config
	echo R 0x17ba0c8c > $DCC_PATH/$1/config
	echo R 0x17ba0850 > $DCC_PATH/$1/config
	echo R 0x17ba0c90 > $DCC_PATH/$1/config
	echo R 0x17ba0854 > $DCC_PATH/$1/config
	echo R 0x17ba0c94 > $DCC_PATH/$1/config
	echo R 0x17ba0858 > $DCC_PATH/$1/config
	echo R 0x17ba0c98 > $DCC_PATH/$1/config
	echo R 0x17ba085c > $DCC_PATH/$1/config
	echo R 0x17ba0c9c > $DCC_PATH/$1/config
	echo R 0x17ba0860 > $DCC_PATH/$1/config
	echo R 0x17ba0ca0 > $DCC_PATH/$1/config
	echo R 0x17ba0864 > $DCC_PATH/$1/config
	echo R 0x17ba0ca4 > $DCC_PATH/$1/config
	echo R 0x17ba0868 > $DCC_PATH/$1/config
	echo R 0x17ba0ca8 > $DCC_PATH/$1/config
	echo R 0x17ba086c > $DCC_PATH/$1/config
	echo R 0x17ba0cac > $DCC_PATH/$1/config
	echo R 0x17ba0870 > $DCC_PATH/$1/config
	echo R 0x17ba0cb0 > $DCC_PATH/$1/config
	echo R 0x17ba0874 > $DCC_PATH/$1/config
	echo R 0x17ba0cb4 > $DCC_PATH/$1/config
	echo R 0x17ba0878 > $DCC_PATH/$1/config
	echo R 0x17ba0cb8 > $DCC_PATH/$1/config
	echo R 0x17ba087c > $DCC_PATH/$1/config
	echo R 0x17ba0cbc > $DCC_PATH/$1/config
	echo R 0x17ba3500 80 > $DCC_PATH/$1/config
	echo R 0x17BA3A80 4 > $DCC_PATH/$1/config
	echo R 0x17ba3aa8 18 > $DCC_PATH/$1/config
	echo R 0x17ba3b00 2 > $DCC_PATH/$1/config
	echo R 0x17ba3b20 3 > $DCC_PATH/$1/config
	echo R 0x17ba3b30 11 > $DCC_PATH/$1/config
	echo R 0x17ba3b64 > $DCC_PATH/$1/config
	echo R 0x17ba3b00 2 > $DCC_PATH/$1/config
	echo R 0x17ba3b20 3 > $DCC_PATH/$1/config
	echo R 0x17ba3b30 11 > $DCC_PATH/$1/config
	echo R 0x17BA3C70 3 > $DCC_PATH/$1/config

	#APM
	echo R 0x17b00000 70 > $DCC_PATH/$1/config

	#PLL and Clocks
	echo R 0x100000 > $DCC_PATH/$1/config
	echo R 0x100008 > $DCC_PATH/$1/config
	echo R 0x101000 > $DCC_PATH/$1/config
	echo R 0x101040 > $DCC_PATH/$1/config
	echo R 0x102000 > $DCC_PATH/$1/config
	echo R 0x102008 > $DCC_PATH/$1/config
	echo R 0x103000 > $DCC_PATH/$1/config
	echo R 0x103008 > $DCC_PATH/$1/config
	echo R 0x104000 > $DCC_PATH/$1/config
	echo R 0x104008 > $DCC_PATH/$1/config
	echo R 0x105000 > $DCC_PATH/$1/config
	echo R 0x105008 > $DCC_PATH/$1/config
	echo R 0x106000 > $DCC_PATH/$1/config
	echo R 0x106008 > $DCC_PATH/$1/config
	echo R 0x107000 > $DCC_PATH/$1/config
	echo R 0x107008 > $DCC_PATH/$1/config
	echo R 0x108000 > $DCC_PATH/$1/config
	echo R 0x108008 > $DCC_PATH/$1/config
	echo R 0x17C000 > $DCC_PATH/$1/config
	echo R 0x171008 > $DCC_PATH/$1/config
	echo R 0x17C010 > $DCC_PATH/$1/config
	echo R 0x17C018 > $DCC_PATH/$1/config
	echo R 0x17C020 > $DCC_PATH/$1/config
	echo R 0x17C14C > $DCC_PATH/$1/config
	echo R 0x17C14C > $DCC_PATH/$1/config
	echo R 0x17C154 > $DCC_PATH/$1/config
	echo R 0x17D010 > $DCC_PATH/$1/config
	echo R 0x17D018 > $DCC_PATH/$1/config
	echo R 0x17D020 > $DCC_PATH/$1/config
	echo R 0x17D14C > $DCC_PATH/$1/config
	echo R 0x17E044 > $DCC_PATH/$1/config
	echo R 0x17E04C > $DCC_PATH/$1/config
	echo R 0x17E054 > $DCC_PATH/$1/config
	echo R 0x17E05C > $DCC_PATH/$1/config
	echo R 0x17E064 > $DCC_PATH/$1/config
	echo R 0x17E184 > $DCC_PATH/$1/config
	echo R 0x17E18C > $DCC_PATH/$1/config
	echo R 0x17F000 > $DCC_PATH/$1/config
	echo R 0x17F008 > $DCC_PATH/$1/config
	echo R 0x17F010 > $DCC_PATH/$1/config
	echo R 0x17F018 > $DCC_PATH/$1/config
	echo R 0x17F020 > $DCC_PATH/$1/config

	echo R 0x180000 > $DCC_PATH/$1/config
	echo R 0x180008 > $DCC_PATH/$1/config
	echo R 0x180010 > $DCC_PATH/$1/config
	echo R 0x180018 > $DCC_PATH/$1/config
	echo R 0x180020 > $DCC_PATH/$1/config
	echo R 0x18014C > $DCC_PATH/$1/config
	echo R 0x181000 > $DCC_PATH/$1/config
	echo R 0x181008 > $DCC_PATH/$1/config
	echo R 0x181010 > $DCC_PATH/$1/config
	echo R 0x181018 > $DCC_PATH/$1/config
	echo R 0x181020 > $DCC_PATH/$1/config
	echo R 0x18114C > $DCC_PATH/$1/config
	echo R 0x12F000 > $DCC_PATH/$1/config
	echo R 0x12F008 > $DCC_PATH/$1/config
	echo R 0x12F010 > $DCC_PATH/$1/config
	echo R 0x12F018 > $DCC_PATH/$1/config
	echo R 0x12F020 > $DCC_PATH/$1/config
	echo R 0x12F14C > $DCC_PATH/$1/config
	echo R 0x169044 > $DCC_PATH/$1/config
	echo R 0x16904C > $DCC_PATH/$1/config
	echo R 0x169054 > $DCC_PATH/$1/config
	echo R 0x16905C > $DCC_PATH/$1/config
	echo R 0x169064 > $DCC_PATH/$1/config
	echo R 0x169184 > $DCC_PATH/$1/config
	echo R 0x179000 > $DCC_PATH/$1/config
	echo R 0x173020 > $DCC_PATH/$1/config
	echo R 0x12D040 > $DCC_PATH/$1/config
	echo R 0x111028 > $DCC_PATH/$1/config
	echo R 0x11102C > $DCC_PATH/$1/config
	echo R 0x13F020 > $DCC_PATH/$1/config
	echo R 0x115028 > $DCC_PATH/$1/config
	echo R 0x121024 > $DCC_PATH/$1/config
	echo R 0x124068 > $DCC_PATH/$1/config
	echo R 0x120058 > $DCC_PATH/$1/config
	echo R 0x120058 > $DCC_PATH/$1/config
	echo R 0x15805C > $DCC_PATH/$1/config
	echo R 0x185000 > $DCC_PATH/$1/config
	echo R 0x128008 > $DCC_PATH/$1/config
	echo R 0x12800C > $DCC_PATH/$1/config
	echo R 0x124004 > $DCC_PATH/$1/config
	echo R 0x124008 > $DCC_PATH/$1/config
	echo R 0x158004 > $DCC_PATH/$1/config
	echo R 0x158008 > $DCC_PATH/$1/config
	echo R 0x167004 > $DCC_PATH/$1/config
	echo R 0x167008 > $DCC_PATH/$1/config
	echo R 0x156004 > $DCC_PATH/$1/config
	echo R 0xC2A0000 > $DCC_PATH/$1/config
	echo R 0xC2A0008 > $DCC_PATH/$1/config
	echo R 0xC2A1000 > $DCC_PATH/$1/config
	echo R 0xC2A1008 > $DCC_PATH/$1/config
	echo R 0xC2A9010 > $DCC_PATH/$1/config
	echo R 0x17A80000 > $DCC_PATH/$1/config
	echo R 0x17A80040 > $DCC_PATH/$1/config
	echo R 0x17A84000 > $DCC_PATH/$1/config
	echo R 0x17A84040 > $DCC_PATH/$1/config
	echo R 0x17A88000 > $DCC_PATH/$1/config
	echo R 0x17A88008 > $DCC_PATH/$1/config
	echo R 0x17A81000 > $DCC_PATH/$1/config
	echo R 0x17A81018 > $DCC_PATH/$1/config
	echo R 0x17A85000 > $DCC_PATH/$1/config
	echo R 0x17A85018 > $DCC_PATH/$1/config
	echo R 0x17A89000 > $DCC_PATH/$1/config
	echo R 0x17A89018 > $DCC_PATH/$1/config
}

config_sa535m_dcc_lpm_pcu()
{
	#PCU -DCC for LPM path
	#  Read only registers
	#Power Gate Status (PWR_GATE_STATUS : Core 0 to Core 3, L3)
	echo R 0x17800010 > $DCC_PATH/$1/config
	echo R 0x17810010 > $DCC_PATH/$1/config
	echo R 0x17820010 > $DCC_PATH/$1/config
	echo R 0x17830010 > $DCC_PATH/$1/config
	echo R 0x17880010 > $DCC_PATH/$1/config

	#Sequence Control (SEQ_CTL : cor0 to core 3, L3)
	echo R 0x17800024 > $DCC_PATH/$1/config
	echo R 0x17810024 > $DCC_PATH/$1/config
	echo R 0x17820024 > $DCC_PATH/$1/config
	echo R 0x17830024 > $DCC_PATH/$1/config
	echo R 0x17880024 > $DCC_PATH/$1/config

	#SEQ_STS, : Core 0 to core 3, L3
	echo R 0x17800038 6 > $DCC_PATH/$1/config
	echo R 0x17810038 6 > $DCC_PATH/$1/config
	echo R 0x17820038 6 > $DCC_PATH/$1/config
	echo R 0x17830038 6 > $DCC_PATH/$1/config
	echo R 0x17880038 3 > $DCC_PATH/$1/config

	#PWR_CTL_STS : Core 0 to Core 3
	echo R 0x1780006C > $DCC_PATH/$1/config
	echo R 0x1781006C > $DCC_PATH/$1/config
	echo R 0x1782006C > $DCC_PATH/$1/config
	echo R 0x1783006C > $DCC_PATH/$1/config

	#SPARE : Core 0 to Core 3
	echo R 0x178000F0 2 > $DCC_PATH/$1/config
	echo R 0x178100F0 2 > $DCC_PATH/$1/config
	echo R 0x178200F0 2 > $DCC_PATH/$1/config
	echo R 0x178300F0 2 > $DCC_PATH/$1/config

	#APPS CL
	echo R 0x17880044 3 > $DCC_PATH/$1/config
	echo R 0x1788006c 6 > $DCC_PATH/$1/config
	# APSS_BOOTFSM_STS
	echo R 0x17880084 > $DCC_PATH/$1/config
	# APSS_SILVER_PLL
	echo R 0x178800f4 5 > $DCC_PATH/$1/config
	# APSS_GOLD_RAIL
	echo R 0x17880118 5 > $DCC_PATH/$1/config
	# APSS_ITM_GOLD
	echo R 0x1788012C 2 > $DCC_PATH/$1/config
	# APSS_ITM_SILVER
	echo R 0x17880134 2 > $DCC_PATH/$1/config
	# APSS_SILVER_PWR_CTL_STS
	echo R 0x178801b4 > $DCC_PATH/$1/config
	# APSS_GOLD_PWR_CTL_STS
	echo R 0x178801B8 > $DCC_PATH/$1/config
	# APSS_CL_PCU_PWR_CTL_STS
	echo R 0x178801bc > $DCC_PATH/$1/config
	echo R 0x178801c8 > $DCC_PATH/$1/config
}

config_sa535m_dcc_rpmh()
{
	echo R 0xb251024 > $DCC_PATH/$1/config
	echo R 0xbde1034 > $DCC_PATH/$1/config

	#RPMH_PDC_APSS
	echo R 0xB200110 180 > $DCC_PATH/$1/config
	echo R 0xB210110 180 > $DCC_PATH/$1/config
	echo R 0xB220110 180 > $DCC_PATH/$1/config
	echo R 0xB230110 180 > $DCC_PATH/$1/config
	echo R 0xB200900 6 > $DCC_PATH/$1/config
	echo R 0xB210900 6 > $DCC_PATH/$1/config
	echo R 0xB220900 6 > $DCC_PATH/$1/config
	echo R 0xB230900 6 > $DCC_PATH/$1/config
	echo R 0xB201020 2 > $DCC_PATH/$1/config
	echo R 0xB211020 2 > $DCC_PATH/$1/config
	echo R 0xB221020 2 > $DCC_PATH/$1/config
	echo R 0xB231020 2 > $DCC_PATH/$1/config
	echo R 0xB201030 > $DCC_PATH/$1/config
	echo R 0xB211030 > $DCC_PATH/$1/config
	echo R 0xB221030 > $DCC_PATH/$1/config
	echo R 0xB231030 > $DCC_PATH/$1/config
	echo R 0xB20103C > $DCC_PATH/$1/config
	echo R 0xB201200 3 > $DCC_PATH/$1/config
	echo R 0xB211200 3 > $DCC_PATH/$1/config
	echo R 0xB221200 3 > $DCC_PATH/$1/config
	echo R 0xB231200 3 > $DCC_PATH/$1/config
	echo R 0xB204510 2 > $DCC_PATH/$1/config
	echo R 0xB204520 2 > $DCC_PATH/$1/config
	echo R 0xb200000 > $DCC_PATH/$1/config

	echo R 0xB261024   > $DCC_PATH/$1/config #RPMH_PDC_TME_SEQ_DBG_PROGRAM_COUNTER_DRVd
	echo R 0xB264524   > $DCC_PATH/$1/config
	echo R 0xB261204   > $DCC_PATH/$1/config
	echo R 0xB261218   > $DCC_PATH/$1/config
	echo R 0xB26122C   > $DCC_PATH/$1/config
	echo R 0xB261240   > $DCC_PATH/$1/config
	echo R 0xB261208   > $DCC_PATH/$1/config
	echo R 0xB26121C   > $DCC_PATH/$1/config
	echo R 0xB261230   > $DCC_PATH/$1/config
	echo R 0xB261244   > $DCC_PATH/$1/config

#P_RSCC_RSCC_RSC_SEQ_PROGRAM_COUNTER_DRV0
	echo R 0x22200408 > $DCC_PATH/$1/config
	echo R 0x22200404 > $DCC_PATH/$1/config
	echo R 0x22200400 > $DCC_PATH/$1/config
	echo R 0x22200208 > $DCC_PATH/$1/config
	echo R 0x22200228 > $DCC_PATH/$1/config
	echo R 0x22200248 > $DCC_PATH/$1/config
	echo R 0x22200268 > $DCC_PATH/$1/config
	echo R 0x2220020C > $DCC_PATH/$1/config
	echo R 0x2220022C > $DCC_PATH/$1/config
	echo R 0x2220024C > $DCC_PATH/$1/config
	echo R 0x2220026C > $DCC_PATH/$1/config
	echo R 0x22200210 > $DCC_PATH/$1/config
	echo R 0x22200230 > $DCC_PATH/$1/config
	echo R 0x22200250 > $DCC_PATH/$1/config
	echo R 0x22200270 > $DCC_PATH/$1/config
	echo R 0x22220408 > $DCC_PATH/$1/config
	echo R 0x22220404 > $DCC_PATH/$1/config
	echo R 0x22220400 > $DCC_PATH/$1/config
	echo R 0x22220208 > $DCC_PATH/$1/config
	echo R 0x22220228 > $DCC_PATH/$1/config
	echo R 0x22220248 > $DCC_PATH/$1/config
	echo R 0x22220268 > $DCC_PATH/$1/config
	echo R 0x2222020C > $DCC_PATH/$1/config
	echo R 0x2222022C > $DCC_PATH/$1/config
	echo R 0x2222024C > $DCC_PATH/$1/config
	echo R 0x2222026C > $DCC_PATH/$1/config
	echo R 0x22220210 > $DCC_PATH/$1/config
	echo R 0x22220230 > $DCC_PATH/$1/config
	echo R 0x22220250 > $DCC_PATH/$1/config
	echo R 0x22220270 > $DCC_PATH/$1/config

#RPMH_PDC_TME
	echo R 0xB271024 > $DCC_PATH/$1/config
	echo R 0xB274524 > $DCC_PATH/$1/config
	echo R 0xB271204 > $DCC_PATH/$1/config
	echo R 0xB271218 > $DCC_PATH/$1/config
	echo R 0xB27122C > $DCC_PATH/$1/config
	echo R 0xB271240 > $DCC_PATH/$1/config
	echo R 0xB271208 > $DCC_PATH/$1/config
	echo R 0xB27121C > $DCC_PATH/$1/config
	echo R 0xB271230 > $DCC_PATH/$1/config
	echo R 0xB271244 > $DCC_PATH/$1/config
}

config_sa535m_dcc_apss_rscc()
{
#APSS_RSC_RSCC
	echo R 0x17A00010 > $DCC_PATH/$1/config
	echo R 0x17A10010 > $DCC_PATH/$1/config
	echo R 0x17A20010 > $DCC_PATH/$1/config
	echo R 0x17A30010 > $DCC_PATH/$1/config
	echo R 0x17A00030 > $DCC_PATH/$1/config
	echo R 0x17A10030 > $DCC_PATH/$1/config
	echo R 0x17A20030 > $DCC_PATH/$1/config
	echo R 0x17A30030 > $DCC_PATH/$1/config
	echo R 0x17A00038 > $DCC_PATH/$1/config
	echo R 0x17A10038 > $DCC_PATH/$1/config
	echo R 0x17A20038 > $DCC_PATH/$1/config
	echo R 0x17A30038 > $DCC_PATH/$1/config
	echo R 0x17A00040 > $DCC_PATH/$1/config
	echo R 0x17A10040 > $DCC_PATH/$1/config
	echo R 0x17A20040 > $DCC_PATH/$1/config
	echo R 0x17A30040 > $DCC_PATH/$1/config
	echo R 0x17A00048 > $DCC_PATH/$1/config
	echo R 0x17A00400 3 > $DCC_PATH/$1/config
	echo R 0x17A10408 > $DCC_PATH/$1/config
	echo R 0x17A20408 > $DCC_PATH/$1/config
	echo R 0x17A30408 > $DCC_PATH/$1/config

#P_RSCC_RSCC_TCSm_CMDn_DRV1_ADDR
	echo R 0x22210d38 > $DCC_PATH/$1/config
	echo R 0x22210d50 > $DCC_PATH/$1/config
	echo R 0x22210d68 > $DCC_PATH/$1/config
	echo R 0x22210d80 > $DCC_PATH/$1/config
	echo R 0x22210d98 > $DCC_PATH/$1/config
	echo R 0x22210fd8 > $DCC_PATH/$1/config
	echo R 0x22210ff0 > $DCC_PATH/$1/config
	echo R 0x22211008 > $DCC_PATH/$1/config
	echo R 0x22211020 > $DCC_PATH/$1/config
	echo R 0x22211038 > $DCC_PATH/$1/config

#P_RSCC_RSCC_TCSm_CMDn_DRV1_STATUS
	echo R 0x22210d40 > $DCC_PATH/$1/config
	echo R 0x22210d58 > $DCC_PATH/$1/config
	echo R 0x22210d70 > $DCC_PATH/$1/config
	echo R 0x22210d88 > $DCC_PATH/$1/config
	echo R 0x22210da0 > $DCC_PATH/$1/config
	echo R 0x22210fe0 > $DCC_PATH/$1/config
	echo R 0x22210ff8 > $DCC_PATH/$1/config
	echo R 0x22211010 > $DCC_PATH/$1/config
	echo R 0x22211028 > $DCC_PATH/$1/config
	echo R 0x22211040 > $DCC_PATH/$1/config
}

config_sa535m_dcc_epss()
{
	echo R 0x17d80200 192 > $DCC_PATH/$1/config
	# EPSSSLOW_CLKDOM0
	echo R 0x17d9001c > $DCC_PATH/$1/config
	echo R 0x17d900dc > $DCC_PATH/$1/config
	echo R 0x17d900e8 > $DCC_PATH/$1/config
	echo R 0x17d90320 > $DCC_PATH/$1/config
	echo R 0x17d90020 > $DCC_PATH/$1/config
	echo R 0x17d9034c > $DCC_PATH/$1/config
	echo R 0x17d90300 > $DCC_PATH/$1/config
	echo R 0x17d90064 > $DCC_PATH/$1/config
	echo R 0x17d90074 > $DCC_PATH/$1/config
	echo R 0x17d900e0 > $DCC_PATH/$1/config

	# EPSSSLOW_CLKDOM1
	echo R 0x17d9101c > $DCC_PATH/$1/config
	echo R 0x17d910dc > $DCC_PATH/$1/config
	echo R 0x17d910e8 > $DCC_PATH/$1/config
	echo R 0x17d91320 > $DCC_PATH/$1/config
	echo R 0x17d91020 > $DCC_PATH/$1/config
	echo R 0x17d9134c > $DCC_PATH/$1/config
	echo R 0x17d91300 > $DCC_PATH/$1/config
	echo R 0x17d91064 > $DCC_PATH/$1/config
	echo R 0x17d91074 > $DCC_PATH/$1/config
	echo R 0x17d910e0 > $DCC_PATH/$1/config
	echo R 0x17d91410 > $DCC_PATH/$1/config

	# EPSSSLOW_CLKDOM2
	echo R 0x17d9201c > $DCC_PATH/$1/config
	echo R 0x17d920dc > $DCC_PATH/$1/config
	echo R 0x17d920e8 > $DCC_PATH/$1/config
	echo R 0x17d92320 > $DCC_PATH/$1/config
	echo R 0x17d92020 > $DCC_PATH/$1/config
	echo R 0x17d9234c > $DCC_PATH/$1/config
	echo R 0x17d92300 > $DCC_PATH/$1/config
	echo R 0x17d92064 > $DCC_PATH/$1/config
	echo R 0x17d92074 > $DCC_PATH/$1/config
	echo R 0x17d920e0 > $DCC_PATH/$1/config
	echo R 0x17d92410 > $DCC_PATH/$1/config

	#EPSSTOP_EPSS_TOP
	echo R 0x17d98014 5 > $DCC_PATH/$1/config
}

config_sa535m_dcc_misc()
{
	# WDOG_BITE_INT0_CONFIG
	echo R 0x17400038 > $DCC_PATH/$1/config
	#GIC_ERR_IPC
	echo R 0x17400438 > $DCC_PATH/$1/config
	# EPSSTOP_MUC_HANG_DET_CTRL
	echo R 0x17D98014 > $DCC_PATH/$1/config
	# SOC_HW_VERSION
	echo R 0x1FC8000 > $DCC_PATH/$1/config
	#GCC Reset status : 0x3 -> Secure bite/System bite
	echo R 0xC2F1000 > $DCC_PATH/$1/config
}

config_sa535m_dcc_gic()
{
	echo R 0x17200104 30 > $DCC_PATH/$1/config
	echo R 0x17200204 30 > $DCC_PATH/$1/config
	echo R 0x17200384 30 > $DCC_PATH/$1/config
}

config_sa535m_dcc_errorloggers()
{
	#QTB_NSP_NOC
	echo R 0x7D6248 > $DCC_PATH/$1/config
	#PCIE_NOC
	echo R 0x1780010 > $DCC_PATH/$1/config
	echo R 0x1780018 > $DCC_PATH/$1/config
	echo R 0x1780020 > $DCC_PATH/$1/config
	echo R 0x1780024 > $DCC_PATH/$1/config
	echo R 0x1780028 > $DCC_PATH/$1/config
	echo R 0x178002C > $DCC_PATH/$1/config
	echo R 0x1780030 > $DCC_PATH/$1/config
	echo R 0x1780034 > $DCC_PATH/$1/config
	echo R 0x1780038 > $DCC_PATH/$1/config
	echo R 0x178003C > $DCC_PATH/$1/config
	echo R 0x1780248 > $DCC_PATH/$1/config #FAULT_MANAGER_PCIE_FAULTINSTATUS0_LOW
	#SYSTEM_NOC
	echo R 0x1900010 > $DCC_PATH/$1/config
	echo R 0x1900018 > $DCC_PATH/$1/config
	echo R 0x1900020 > $DCC_PATH/$1/config
	echo R 0x1900024 > $DCC_PATH/$1/config
	echo R 0x1900028 > $DCC_PATH/$1/config
	echo R 0x190002C > $DCC_PATH/$1/config
	echo R 0x1900030 > $DCC_PATH/$1/config
	echo R 0x1900034 > $DCC_PATH/$1/config
	echo R 0x1900038 > $DCC_PATH/$1/config
	echo R 0x190003C > $DCC_PATH/$1/config
	echo R 0x1900448 > $DCC_PATH/$1/config #FAULT_MANAGER_FAULTINSTATUS0_LOW
	echo R 0x190044C > $DCC_PATH/$1/config #FAULT_MANAGER_FAULTINSTATUS0_HIGH
	echo R 0x1900458 > $DCC_PATH/$1/config #FAULT_MANAGER_FAULTINSTATUS1_LOW
	echo R 0x190045C > $DCC_PATH/$1/config #FAULT_MANAGER_FAULTINSTATUS1_HIGH
	#APSS_GIC_NOC
	echo R 0x17C40010 > $DCC_PATH/$1/config
	echo R 0x17C40018 > $DCC_PATH/$1/config
	echo R 0x17C40020 > $DCC_PATH/$1/config
	echo R 0x17C40024 > $DCC_PATH/$1/config
	echo R 0x17C40028 > $DCC_PATH/$1/config
	echo R 0x17C4002C > $DCC_PATH/$1/config
	echo R 0x17C40030 > $DCC_PATH/$1/config
	echo R 0x17C40034 > $DCC_PATH/$1/config
	echo R 0x17C40038 > $DCC_PATH/$1/config
	echo R 0x17C4003C > $DCC_PATH/$1/config
	#TURING_NSP_NOC
	echo R 0x260C003C > $DCC_PATH/$1/config
	echo R 0x260C0038 > $DCC_PATH/$1/config
	echo R 0x260C0034 > $DCC_PATH/$1/config
	echo R 0x260C0030 > $DCC_PATH/$1/config
	echo R 0x260C002C > $DCC_PATH/$1/config
	echo R 0x260C0028 > $DCC_PATH/$1/config
	echo R 0x260C0024 > $DCC_PATH/$1/config
	echo R 0x260C0020 > $DCC_PATH/$1/config
	echo R 0x260C0018 > $DCC_PATH/$1/config
	echo R 0x260C0010 > $DCC_PATH/$1/config
	echo R 0x260C0248 > $DCC_PATH/$1/config #TURING_NSP_NOC_SBM_FAULTINSTATUS0_LOW
	#DC_NOC_DCH
	echo R 0x300E0010 > $DCC_PATH/$1/config
	echo R 0x300E0018 > $DCC_PATH/$1/config
	echo R 0x300E0020 > $DCC_PATH/$1/config
	echo R 0x300E0024 > $DCC_PATH/$1/config
	echo R 0x300E0028 > $DCC_PATH/$1/config
	echo R 0x300E002C > $DCC_PATH/$1/config
	echo R 0x300E0030 > $DCC_PATH/$1/config
	echo R 0x300E0034 > $DCC_PATH/$1/config
	echo R 0x300E0038 > $DCC_PATH/$1/config
	echo R 0x300E003C > $DCC_PATH/$1/config
	echo R 0x300E0248 > $DCC_PATH/$1/config #DC_NOC_DCH_ERROR_SBM_FAULTINSTATUS0_LOW
	#GEM_NOC
	echo R 0x30100C34 > $DCC_PATH/$1/config
	echo R 0x30100C30 > $DCC_PATH/$1/config
	echo R 0x30100C2C > $DCC_PATH/$1/config
	echo R 0x30100C28 > $DCC_PATH/$1/config
	echo R 0x30100C24 > $DCC_PATH/$1/config
	echo R 0x30100C20 > $DCC_PATH/$1/config
	echo R 0x30100C18 > $DCC_PATH/$1/config
	echo R 0x30100C10 > $DCC_PATH/$1/config
	echo R 0x30100C08 > $DCC_PATH/$1/config
	echo R 0x30100834 > $DCC_PATH/$1/config
	echo R 0x30100830 > $DCC_PATH/$1/config
	echo R 0x3010082C > $DCC_PATH/$1/config
	echo R 0x30100828 > $DCC_PATH/$1/config
	echo R 0x30100824 > $DCC_PATH/$1/config
	echo R 0x30100820 > $DCC_PATH/$1/config
	echo R 0x30100818 > $DCC_PATH/$1/config
	echo R 0x30100810 > $DCC_PATH/$1/config
	echo R 0x30100808 > $DCC_PATH/$1/config
	echo R 0x30100434 > $DCC_PATH/$1/config
	echo R 0x30100430 > $DCC_PATH/$1/config
	echo R 0x3010042C > $DCC_PATH/$1/config
	echo R 0x30100428 > $DCC_PATH/$1/config
	echo R 0x30100424 > $DCC_PATH/$1/config
	echo R 0x30100420 > $DCC_PATH/$1/config
	echo R 0x30100418 > $DCC_PATH/$1/config
	echo R 0x30100410 > $DCC_PATH/$1/config
	echo R 0x30100408 > $DCC_PATH/$1/config
	echo R 0x30100034 > $DCC_PATH/$1/config
	echo R 0x30100030 > $DCC_PATH/$1/config
	echo R 0x3010002C > $DCC_PATH/$1/config
	echo R 0x30100028 > $DCC_PATH/$1/config
	echo R 0x30100024 > $DCC_PATH/$1/config
	echo R 0x30100020 > $DCC_PATH/$1/config
	echo R 0x30100018 > $DCC_PATH/$1/config
	echo R 0x30100010 > $DCC_PATH/$1/config
	echo R 0x30100008 > $DCC_PATH/$1/config
	echo R 0x30102048 > $DCC_PATH/$1/config
	echo R 0x3010204C > $DCC_PATH/$1/config
	echo R 0x3010D848 > $DCC_PATH/$1/config
	#DC_NOC_CH_HM
	echo R 0x317F0010 > $DCC_PATH/$1/config
	echo R 0x317F0018 > $DCC_PATH/$1/config
	echo R 0x317F0020 > $DCC_PATH/$1/config
	echo R 0x317F0024 > $DCC_PATH/$1/config
	echo R 0x317F0028 > $DCC_PATH/$1/config
	echo R 0x317F002C > $DCC_PATH/$1/config
	echo R 0x317F0030 > $DCC_PATH/$1/config
	echo R 0x317F0034 > $DCC_PATH/$1/config
	echo R 0x317F0038 > $DCC_PATH/$1/config
	echo R 0x317F003C > $DCC_PATH/$1/config
	echo R 0x317F0248 > $DCC_PATH/$1/config
}

config_sa535m_dcc_tr_pending()
{
	echo R 0x7DD010 > $DCC_PATH/$1/config
	echo R 0x7DE010 > $DCC_PATH/$1/config
	echo R 0x260D4010 > $DCC_PATH/$1/config
	echo R 0x260D5010 > $DCC_PATH/$1/config
	echo R 0x1787010 > $DCC_PATH/$1/config
	echo R 0x1788010 > $DCC_PATH/$1/config
	echo R 0x1789010 > $DCC_PATH/$1/config
	echo R 0x178A010 > $DCC_PATH/$1/config
	echo R 0x1915010 > $DCC_PATH/$1/config
	echo R 0x1920010 > $DCC_PATH/$1/config
	echo R 0x1921010 > $DCC_PATH/$1/config
	echo R 0x1922010 > $DCC_PATH/$1/config
	echo R 0x1923010 > $DCC_PATH/$1/config
	echo R 0x1924010 > $DCC_PATH/$1/config
	echo R 0x1925010 > $DCC_PATH/$1/config
	echo R 0x1926010 > $DCC_PATH/$1/config
	echo R 0x1927010 > $DCC_PATH/$1/config
	echo R 0x1928010 > $DCC_PATH/$1/config
	echo R 0x1929010 > $DCC_PATH/$1/config
	echo R 0x192A010 > $DCC_PATH/$1/config
	echo R 0x192B010 > $DCC_PATH/$1/config
	echo R 0x192C010 > $DCC_PATH/$1/config
	echo R 0x192D010 > $DCC_PATH/$1/config
	echo R 0x192F010 > $DCC_PATH/$1/config
	echo R 0x1930010 > $DCC_PATH/$1/config
	echo R 0x1990010 > $DCC_PATH/$1/config
	echo R 0x1991010 > $DCC_PATH/$1/config
	echo R 0x1992010 > $DCC_PATH/$1/config
	echo R 0x1993010 > $DCC_PATH/$1/config
	echo R 0x1994010 > $DCC_PATH/$1/config
	echo R 0x1995010 > $DCC_PATH/$1/config
	echo R 0x1996010 > $DCC_PATH/$1/config
	echo R 0x1997010 > $DCC_PATH/$1/config
	echo R 0x1998010 > $DCC_PATH/$1/config
	echo R 0x1999010 > $DCC_PATH/$1/config
	echo R 0x199A010 > $DCC_PATH/$1/config
	echo R 0x199B010 > $DCC_PATH/$1/config
	echo R 0x199C010 > $DCC_PATH/$1/config
	echo R 0x199D010 > $DCC_PATH/$1/config
	echo R 0x30130010 > $DCC_PATH/$1/config
	echo R 0x30131010 > $DCC_PATH/$1/config
	echo R 0x30132010 > $DCC_PATH/$1/config
	echo R 0x30133010 > $DCC_PATH/$1/config
	echo R 0x30134010 > $DCC_PATH/$1/config
	echo R 0x30135010 > $DCC_PATH/$1/config
	echo R 0x30136010 > $DCC_PATH/$1/config
	echo R 0x30137010 > $DCC_PATH/$1/config
	echo R 0x30138010 > $DCC_PATH/$1/config
	echo R 0x30139010 > $DCC_PATH/$1/config
	echo R 0x178B010 > $DCC_PATH/$1/config
	echo R 0x1916010 > $DCC_PATH/$1/config
	echo R 0x1931010 > $DCC_PATH/$1/config
	echo R 0x178C010 > $DCC_PATH/$1/config
	echo R 0x178D010 > $DCC_PATH/$1/config
	echo R 0x178E010 > $DCC_PATH/$1/config
	echo R 0x1932010 > $DCC_PATH/$1/config
	echo R 0x1933010 > $DCC_PATH/$1/config
	echo R 0x1934010 > $DCC_PATH/$1/config
	echo R 0x1935010 > $DCC_PATH/$1/config
	echo R 0x1936010 > $DCC_PATH/$1/config
	echo R 0x1937010 > $DCC_PATH/$1/config
	echo R 0x1938010 > $DCC_PATH/$1/config
	echo R 0x1939010 > $DCC_PATH/$1/config
	echo R 0x193A010 > $DCC_PATH/$1/config
	echo R 0x19A0010 > $DCC_PATH/$1/config
	echo R 0x19A1010 > $DCC_PATH/$1/config
	echo R 0x19A2010 > $DCC_PATH/$1/config
	echo R 0x19A3010 > $DCC_PATH/$1/config
	echo R 0x19A4010 > $DCC_PATH/$1/config
	echo R 0x19A5010 > $DCC_PATH/$1/config
	echo R 0x19A6010 > $DCC_PATH/$1/config
	echo R 0x19A7010 > $DCC_PATH/$1/config
	echo R 0x19A8010 > $DCC_PATH/$1/config
	echo R 0x19A9010 > $DCC_PATH/$1/config
	echo R 0x19AA010 > $DCC_PATH/$1/config
	echo R 0x19AB010 > $DCC_PATH/$1/config
	echo R 0x19AC010 > $DCC_PATH/$1/config
	echo R 0x260DB010 > $DCC_PATH/$1/config
	echo R 0x260DC010 > $DCC_PATH/$1/config
	echo R 0x300EB010 > $DCC_PATH/$1/config
	echo R 0x300EB110 > $DCC_PATH/$1/config
	echo R 0x30140010 > $DCC_PATH/$1/config
	echo R 0x30141010 > $DCC_PATH/$1/config
	echo R 0x30150010 > $DCC_PATH/$1/config
	echo R 0x30151010 > $DCC_PATH/$1/config
	echo R 0x30152010 > $DCC_PATH/$1/config
	echo R 0x30153010 > $DCC_PATH/$1/config
	echo R 0x30154010 > $DCC_PATH/$1/config
	echo R 0x30155010 > $DCC_PATH/$1/config
	echo R 0x30156010 > $DCC_PATH/$1/config
	echo R 0x30157010 > $DCC_PATH/$1/config
	echo R 0x30158010 > $DCC_PATH/$1/config
	echo R 0x30159010 > $DCC_PATH/$1/config
	echo R 0x3015A010 > $DCC_PATH/$1/config
	echo R 0x3015B010 > $DCC_PATH/$1/config
}

config_sa535m_dcc_smmu()
{
	echo R 0x150025DC > $DCC_PATH/$1/config
	echo R 0x150055DC > $DCC_PATH/$1/config
	echo R 0x150075DC > $DCC_PATH/$1/config
	echo R 0x150075DC > $DCC_PATH/$1/config
	echo R 0x15002204 > $DCC_PATH/$1/config
	echo R 0x15002670 > $DCC_PATH/$1/config
	echo R 0x150022FC 3 > $DCC_PATH/$1/config
	echo R 0x150022FC > $DCC_PATH/$1/config
	echo R 0x15002304 > $DCC_PATH/$1/config
}

config_sa535m_mss_rscc()
{
	echo R 0x4200208 > $DCC_PATH/$1/config
	echo R 0x4200228 > $DCC_PATH/$1/config
	echo R 0x4200248 > $DCC_PATH/$1/config
	echo R 0x4200268 > $DCC_PATH/$1/config
	echo R 0x4200288 > $DCC_PATH/$1/config
	echo R 0x42002A8 > $DCC_PATH/$1/config
	echo R 0x420020C > $DCC_PATH/$1/config
	echo R 0x420022C > $DCC_PATH/$1/config
	echo R 0x420024C > $DCC_PATH/$1/config
	echo R 0x420026C > $DCC_PATH/$1/config
	echo R 0x420028C > $DCC_PATH/$1/config
	echo R 0x42002AC > $DCC_PATH/$1/config
	echo R 0x4200210 > $DCC_PATH/$1/config
	echo R 0x4200230 > $DCC_PATH/$1/config
	echo R 0x4200250 > $DCC_PATH/$1/config
	echo R 0x4200270 > $DCC_PATH/$1/config
	echo R 0x4200290 > $DCC_PATH/$1/config
	echo R 0x42002B0 > $DCC_PATH/$1/config
	echo R 0x4200400 > $DCC_PATH/$1/config
	echo R 0x4200404 > $DCC_PATH/$1/config
	echo R 0x4200408 > $DCC_PATH/$1/config

	echo R 0x40C0208 > $DCC_PATH/$1/config
	echo R 0x40C0228 > $DCC_PATH/$1/config
	echo R 0x40C0248 > $DCC_PATH/$1/config
	echo R 0x40C0268 > $DCC_PATH/$1/config
	echo R 0x40C0288 > $DCC_PATH/$1/config
	echo R 0x40C02A8 > $DCC_PATH/$1/config
	echo R 0x40C020C > $DCC_PATH/$1/config
	echo R 0x40C022C > $DCC_PATH/$1/config
	echo R 0x40C024C > $DCC_PATH/$1/config
	echo R 0x40C026C > $DCC_PATH/$1/config
	echo R 0x40C028C > $DCC_PATH/$1/config
	echo R 0x40C02AC > $DCC_PATH/$1/config
	echo R 0x40C0210 > $DCC_PATH/$1/config
	echo R 0x40C0230 > $DCC_PATH/$1/config
	echo R 0x40C0250 > $DCC_PATH/$1/config
	echo R 0x40C0270 > $DCC_PATH/$1/config
	echo R 0x40C0290 > $DCC_PATH/$1/config
	echo R 0x40C02B0 > $DCC_PATH/$1/config
	echo R 0x40C0400 > $DCC_PATH/$1/config
	echo R 0x40C0404 > $DCC_PATH/$1/config
	echo R 0x40C0408 > $DCC_PATH/$1/config
	echo R 0x4002028 > $DCC_PATH/$1/config
	echo R 0x4000304 > $DCC_PATH/$1/config
	echo R 0x400030C > $DCC_PATH/$1/config
	echo R 0x408C020 > $DCC_PATH/$1/config
}

config_sa535m_dcc_contexttable_tmo()
{
#llcc_0 poc
	echo R 0x30104010 > $DCC_PATH/$1/config
	#looping 0x40 times
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104038 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config
	echo R 0x30104030 2 > $DCC_PATH/$1/config

#llcc_0 poc
	echo R 0x30104410 > $DCC_PATH/$1/config
	#looping 0x40 times
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104438 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config
	echo R 0x30104430 2 > $DCC_PATH/$1/config

#cnoc poc
	echo R 0x30104810 > $DCC_PATH/$1/config
	#looping 0x20 times
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104838 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config
	echo R 0x30104830 2 > $DCC_PATH/$1/config

#pcie poc
	echo R 0x30104C10 > $DCC_PATH/$1/config
	#looping 0x40 times
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C38 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
	echo R 0x30104C30 2 > $DCC_PATH/$1/config
}

config_sa535m_dcc_debugchain()
{
#NSP_DEBUGCHAIN_DEBUG
	echo R 0x7D7008 > $DCC_PATH/$1/config
	#looping 0x4 times
	echo R 0x7D7010 > $DCC_PATH/$1/config
	echo R 0x7D7014 > $DCC_PATH/$1/config
	echo R 0x7D7010 > $DCC_PATH/$1/config
	echo R 0x7D7014 > $DCC_PATH/$1/config
	echo R 0x7D7010 > $DCC_PATH/$1/config
	echo R 0x7D7014 > $DCC_PATH/$1/config
	echo R 0x7D7010 > $DCC_PATH/$1/config
	echo R 0x7D7014 > $DCC_PATH/$1/config
	echo R 0x7D7018 > $DCC_PATH/$1/config

#NSP_QTB500DEBUGCHAIN_DEBUG
	echo R 0x7D7088 > $DCC_PATH/$1/config
	#looping 0x7 times
	echo R 0x7D7090 > $DCC_PATH/$1/config
	echo R 0x7D7094 > $DCC_PATH/$1/config
	echo R 0x7D7090 > $DCC_PATH/$1/config
	echo R 0x7D7094 > $DCC_PATH/$1/config
	echo R 0x7D7090 > $DCC_PATH/$1/config
	echo R 0x7D7094 > $DCC_PATH/$1/config
	echo R 0x7D7090 > $DCC_PATH/$1/config
	echo R 0x7D7094 > $DCC_PATH/$1/config
	echo R 0x7D7090 > $DCC_PATH/$1/config
	echo R 0x7D7094 > $DCC_PATH/$1/config
	echo R 0x7D7090 > $DCC_PATH/$1/config
	echo R 0x7D7094 > $DCC_PATH/$1/config
	echo R 0x7D7090 > $DCC_PATH/$1/config
	echo R 0x7D7094 > $DCC_PATH/$1/config
	echo R 0x7D7098 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_PCIE_DEBUG
	echo R 0x1781008 > $DCC_PATH/$1/config
	#looping 0x6 times
	echo R 0x1781010 > $DCC_PATH/$1/config
	echo R 0x1781014 > $DCC_PATH/$1/config
	echo R 0x1781010 > $DCC_PATH/$1/config
	echo R 0x1781014 > $DCC_PATH/$1/config
	echo R 0x1781010 > $DCC_PATH/$1/config
	echo R 0x1781014 > $DCC_PATH/$1/config
	echo R 0x1781010 > $DCC_PATH/$1/config
	echo R 0x1781014 > $DCC_PATH/$1/config
	echo R 0x1781010 > $DCC_PATH/$1/config
	echo R 0x1781014 > $DCC_PATH/$1/config
	echo R 0x1781010 > $DCC_PATH/$1/config
	echo R 0x1781014 > $DCC_PATH/$1/config
	echo R 0x1781018 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_QTB_PCIE_DEBUG
	echo R 0x1781088 > $DCC_PATH/$1/config
	#looping 0x4 times
	echo R 0x1781090 > $DCC_PATH/$1/config
	echo R 0x1781094 > $DCC_PATH/$1/config
	echo R 0x1781090 > $DCC_PATH/$1/config
	echo R 0x1781094 > $DCC_PATH/$1/config
	echo R 0x1781090 > $DCC_PATH/$1/config
	echo R 0x1781094 > $DCC_PATH/$1/config
	echo R 0x1781090 > $DCC_PATH/$1/config
	echo R 0x1781094 > $DCC_PATH/$1/config
	echo R 0x1781098 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_DEBUG
	echo R 0x1901008 > $DCC_PATH/$1/config
	#looping 0x1C times
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901010 > $DCC_PATH/$1/config
	echo R 0x1901014 > $DCC_PATH/$1/config
	echo R 0x1901018 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_QTB_DEBUG
	echo R 0x1901088 > $DCC_PATH/$1/config
	#looping 0xC times
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901090 > $DCC_PATH/$1/config
	echo R 0x1901094 > $DCC_PATH/$1/config
	echo R 0x1901098 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_ANOC_NIU_DEBUG
	echo R 0x1901108 > $DCC_PATH/$1/config
	#looping 0x3 times
	echo R 0x1901110 > $DCC_PATH/$1/config
	echo R 0x1901114 > $DCC_PATH/$1/config
	echo R 0x1901110 > $DCC_PATH/$1/config
	echo R 0x1901114 > $DCC_PATH/$1/config
	echo R 0x1901110 > $DCC_PATH/$1/config
	echo R 0x1901114 > $DCC_PATH/$1/config
	echo R 0x1901118 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_CNOC_PCIE_DEBUG
	echo R 0x1981008 > $DCC_PATH/$1/config
	#looping 0x4 times
	echo R 0x1981010 > $DCC_PATH/$1/config
	echo R 0x1981014 > $DCC_PATH/$1/config
	echo R 0x1981010 > $DCC_PATH/$1/config
	echo R 0x1981014 > $DCC_PATH/$1/config
	echo R 0x1981010 > $DCC_PATH/$1/config
	echo R 0x1981014 > $DCC_PATH/$1/config
	echo R 0x1981010 > $DCC_PATH/$1/config
	echo R 0x1981014 > $DCC_PATH/$1/config
	echo R 0x1981018 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_ETH_DEBUG
	echo R 0x1981088 > $DCC_PATH/$1/config
	#looping 0x5 times
	echo R 0x1981090 > $DCC_PATH/$1/config
	echo R 0x1981094 > $DCC_PATH/$1/config
	echo R 0x1981090 > $DCC_PATH/$1/config
	echo R 0x1981094 > $DCC_PATH/$1/config
	echo R 0x1981090 > $DCC_PATH/$1/config
	echo R 0x1981094 > $DCC_PATH/$1/config
	echo R 0x1981090 > $DCC_PATH/$1/config
	echo R 0x1981094 > $DCC_PATH/$1/config
	echo R 0x1981090 > $DCC_PATH/$1/config
	echo R 0x1981094 > $DCC_PATH/$1/config
	echo R 0x1981098 > $DCC_PATH/$1/config

#SYSTEM_NOC_DEBUGCHAIN_TME_DEBUG
	echo R 0x1981108 > $DCC_PATH/$1/config
	#looping 0x3 times
	echo R 0x1981110 > $DCC_PATH/$1/config
	echo R 0x1981114 > $DCC_PATH/$1/config
	echo R 0x1981110 > $DCC_PATH/$1/config
	echo R 0x1981114 > $DCC_PATH/$1/config
	echo R 0x1981110 > $DCC_PATH/$1/config
	echo R 0x1981114 > $DCC_PATH/$1/config
	echo R 0x1981118 > $DCC_PATH/$1/config

#APSS_GIC_NOC_DEBUG
	echo R 0x17C41008 > $DCC_PATH/$1/config
	#looping 0x5 times
	echo R 0x17C41010 > $DCC_PATH/$1/config
	echo R 0x17C41014 > $DCC_PATH/$1/config
	echo R 0x17C41010 > $DCC_PATH/$1/config
	echo R 0x17C41014 > $DCC_PATH/$1/config
	echo R 0x17C41010 > $DCC_PATH/$1/config
	echo R 0x17C41014 > $DCC_PATH/$1/config
	echo R 0x17C41010 > $DCC_PATH/$1/config
	echo R 0x17C41014 > $DCC_PATH/$1/config
	echo R 0x17C41010 > $DCC_PATH/$1/config
	echo R 0x17C41014 > $DCC_PATH/$1/config
	echo R 0x17C41018 > $DCC_PATH/$1/config

#TURING_NSP_NOC_DEBUG
	echo R 0x260C1008 > $DCC_PATH/$1/config
	#looping 0x4 times
	echo R 0x260C1010 > $DCC_PATH/$1/config
	echo R 0x260C1014 > $DCC_PATH/$1/config
	echo R 0x260C1010 > $DCC_PATH/$1/config
	echo R 0x260C1014 > $DCC_PATH/$1/config
	echo R 0x260C1010 > $DCC_PATH/$1/config
	echo R 0x260C1014 > $DCC_PATH/$1/config
	echo R 0x260C1010 > $DCC_PATH/$1/config
	echo R 0x260C1014 > $DCC_PATH/$1/config
	echo R 0x260C1018 > $DCC_PATH/$1/config

#DC_NOC_DCH_DEBUG
	echo R 0x300E1008 > $DCC_PATH/$1/config
	#looping 0x7 times
	echo R 0x300E1010 > $DCC_PATH/$1/config
	echo R 0x300E1014 > $DCC_PATH/$1/config
	echo R 0x300E1010 > $DCC_PATH/$1/config
	echo R 0x300E1014 > $DCC_PATH/$1/config
	echo R 0x300E1010 > $DCC_PATH/$1/config
	echo R 0x300E1014 > $DCC_PATH/$1/config
	echo R 0x300E1010 > $DCC_PATH/$1/config
	echo R 0x300E1014 > $DCC_PATH/$1/config
	echo R 0x300E1010 > $DCC_PATH/$1/config
	echo R 0x300E1014 > $DCC_PATH/$1/config
	echo R 0x300E1010 > $DCC_PATH/$1/config
	echo R 0x300E1014 > $DCC_PATH/$1/config
	echo R 0x300E1010 > $DCC_PATH/$1/config
	echo R 0x300E1014 > $DCC_PATH/$1/config
	echo R 0x300E1018 > $DCC_PATH/$1/config

#GEM_NOC_COHERENT_CHAIN_DEBUG
	echo R 0x30106008 > $DCC_PATH/$1/config
	#looping 0x4 times
	echo R 0x30106010 > $DCC_PATH/$1/config
	echo R 0x30106014 > $DCC_PATH/$1/config
	echo R 0x30106010 > $DCC_PATH/$1/config
	echo R 0x30106014 > $DCC_PATH/$1/config
	echo R 0x30106010 > $DCC_PATH/$1/config
	echo R 0x30106014 > $DCC_PATH/$1/config
	echo R 0x30106010 > $DCC_PATH/$1/config
	echo R 0x30106014 > $DCC_PATH/$1/config
	echo R 0x30106018 > $DCC_PATH/$1/config

#GEM_NOC_NONCOHERENT_CHAIN_DEBUG
	echo R 0x30106088 > $DCC_PATH/$1/config
	#looping 0xD times
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106090 > $DCC_PATH/$1/config
	echo R 0x30106094 > $DCC_PATH/$1/config
	echo R 0x30106098 > $DCC_PATH/$1/config

#SVC_CH02_DC_NOC_CH_HM_DEBUG
	echo R 0x317F2008 > $DCC_PATH/$1/config
	#looping 0x3 times
	echo R 0x317F2010 > $DCC_PATH/$1/config
	echo R 0x317F2014 > $DCC_PATH/$1/config
	echo R 0x317F2010 > $DCC_PATH/$1/config
	echo R 0x317F2014 > $DCC_PATH/$1/config
	echo R 0x317F2010 > $DCC_PATH/$1/config
	echo R 0x317F2014 > $DCC_PATH/$1/config
	echo R 0x317F2018 > $DCC_PATH/$1/config
}

config_sa535m_cpr_dcc()
{
	echo R 0x4198000 > $DCC_PATH/$1/config
	echo R 0x4198004 > $DCC_PATH/$1/config
	echo R 0x41980E0 > $DCC_PATH/$1/config
	echo R 0x4198100 > $DCC_PATH/$1/config
	echo R 0x4198120 > $DCC_PATH/$1/config
	echo R 0x4198140 > $DCC_PATH/$1/config
	echo R 0x4198200 > $DCC_PATH/$1/config
	echo R 0x419880C > $DCC_PATH/$1/config
	echo R 0x4198810 > $DCC_PATH/$1/config
	echo R 0x4198814 > $DCC_PATH/$1/config
	echo R 0x4198818 > $DCC_PATH/$1/config
	echo R 0x419B280 > $DCC_PATH/$1/config
	echo R 0x419B288 > $DCC_PATH/$1/config
	echo R 0x638000 > $DCC_PATH/$1/config
	echo R 0x638004 > $DCC_PATH/$1/config
	echo R 0x6380E0 > $DCC_PATH/$1/config
	echo R 0x638100 > $DCC_PATH/$1/config
	echo R 0x638120 > $DCC_PATH/$1/config
	echo R 0x638140 > $DCC_PATH/$1/config
	echo R 0x638200 > $DCC_PATH/$1/config
	echo R 0x63880C > $DCC_PATH/$1/config
	echo R 0x638810 > $DCC_PATH/$1/config
	echo R 0x638814 > $DCC_PATH/$1/config
	echo R 0x638818 > $DCC_PATH/$1/config
	echo R 0x63B280 > $DCC_PATH/$1/config
	echo R 0x63B288 > $DCC_PATH/$1/config
	echo R 0x628000 > $DCC_PATH/$1/config
	echo R 0x628004 > $DCC_PATH/$1/config
	echo R 0x6280E0 > $DCC_PATH/$1/config
	echo R 0x628100 > $DCC_PATH/$1/config
	echo R 0x628120 > $DCC_PATH/$1/config
	echo R 0x628140 > $DCC_PATH/$1/config
	echo R 0x628200 > $DCC_PATH/$1/config
	echo R 0x62880C > $DCC_PATH/$1/config
	echo R 0x628810 > $DCC_PATH/$1/config
	echo R 0x628814 > $DCC_PATH/$1/config
	echo R 0x628818 > $DCC_PATH/$1/config
	echo R 0x62B280 > $DCC_PATH/$1/config
	echo R 0x62B288 > $DCC_PATH/$1/config
	echo R 0x62C000 > $DCC_PATH/$1/config
	echo R 0x62C004 > $DCC_PATH/$1/config
	echo R 0x62C0E0 > $DCC_PATH/$1/config
	echo R 0x62C100 > $DCC_PATH/$1/config
	echo R 0x62C120 > $DCC_PATH/$1/config
	echo R 0x62C140 > $DCC_PATH/$1/config
	echo R 0x62C200 > $DCC_PATH/$1/config
	echo R 0x62C80C > $DCC_PATH/$1/config
	echo R 0x62C810 > $DCC_PATH/$1/config
	echo R 0x62C814 > $DCC_PATH/$1/config
	echo R 0x62C818 > $DCC_PATH/$1/config
	echo R 0x62F280 > $DCC_PATH/$1/config
	echo R 0x62F288 > $DCC_PATH/$1/config
	echo R 0x634000 > $DCC_PATH/$1/config
	echo R 0x634004 > $DCC_PATH/$1/config
	echo R 0x6340E0 > $DCC_PATH/$1/config
	echo R 0x634100 > $DCC_PATH/$1/config
	echo R 0x634120 > $DCC_PATH/$1/config
	echo R 0x634140 > $DCC_PATH/$1/config
	echo R 0x634200 > $DCC_PATH/$1/config
	echo R 0x63480C > $DCC_PATH/$1/config
	echo R 0x634810 > $DCC_PATH/$1/config
	echo R 0x634814 > $DCC_PATH/$1/config
	echo R 0x634818 > $DCC_PATH/$1/config
	echo R 0x637280 > $DCC_PATH/$1/config
	echo R 0x637288 > $DCC_PATH/$1/config
	echo R 0x221C8970 29 > $DCC_PATH/$1/config
}

config_sa535m_dcc_ddr()
{
	#MACH9_0_common_Address
	echo R 0x3086400C > $DCC_PATH/$1/config
	echo R 0x30864010 > $DCC_PATH/$1/config
	echo R 0x30864020 > $DCC_PATH/$1/config
	echo R 0x30864030 > $DCC_PATH/$1/config
	echo R 0x30864040 > $DCC_PATH/$1/config
	echo R 0x30864064 > $DCC_PATH/$1/config
	echo R 0x308650A4 > $DCC_PATH/$1/config
	echo R 0x308650A8 > $DCC_PATH/$1/config
	echo R 0x308650AC > $DCC_PATH/$1/config
	echo R 0x308650B0 > $DCC_PATH/$1/config
	echo R 0x308650B8 > $DCC_PATH/$1/config
	echo R 0x308650BC > $DCC_PATH/$1/config
	echo R 0x308650C0 > $DCC_PATH/$1/config
	echo R 0x308650C4 > $DCC_PATH/$1/config
	#MACH9_0_FEWC_Address
	echo R 0x30868100 > $DCC_PATH/$1/config
	#MACH9_0_MC5_global_Address
	echo R 0x30A00004 > $DCC_PATH/$1/config
	echo R 0x30A00008 > $DCC_PATH/$1/config
	echo R 0x30A00030 6 > $DCC_PATH/$1/config
	echo R 0x30A00304 > $DCC_PATH/$1/config
	echo R 0x30A004BC > $DCC_PATH/$1/config
	echo R 0x30A00700 > $DCC_PATH/$1/config
	echo R 0x30A00708 5 > $DCC_PATH/$1/config
	echo R 0x30A00720 > $DCC_PATH/$1/config
	echo R 0x30A00740 > $DCC_PATH/$1/config
	echo R 0x30A00748 > $DCC_PATH/$1/config
	echo R 0x30A007A0 > $DCC_PATH/$1/config
	echo R 0x30A007B0 > $DCC_PATH/$1/config
	echo R 0x30A007B4 > $DCC_PATH/$1/config
	echo R 0x30A007B8 > $DCC_PATH/$1/config
	echo R 0x30A007D0 > $DCC_PATH/$1/config
	echo R 0x30A007D4 > $DCC_PATH/$1/config
	echo R 0x30A007D8 > $DCC_PATH/$1/config
	echo R 0x30A007E0 > $DCC_PATH/$1/config
	echo R 0x30A007E4 > $DCC_PATH/$1/config
	echo R 0x30A007F0 > $DCC_PATH/$1/config
	echo R 0x30A007F4 > $DCC_PATH/$1/config
	#MACH9_0_MC5_MPE_Address
	echo R 0x30A03404 10 > $DCC_PATH/$1/config
	echo R 0x30A03448 > $DCC_PATH/$1/config
	echo R 0x30A03468 > $DCC_PATH/$1/config
	echo R 0x30A0346C > $DCC_PATH/$1/config
	echo R 0x30A03470 > $DCC_PATH/$1/config
	echo R 0x30A03480 > $DCC_PATH/$1/config
	#MACH9_0_MC5
	echo R 0x30A091A0 > $DCC_PATH/$1/config
	#MACH9_0_MC5_MC5_INTERRUPT_STATUS
	echo R 0x30A09100 > $DCC_PATH/$1/config
	echo R 0x30A09110 > $DCC_PATH/$1/config
	echo R 0x30A09120 > $DCC_PATH/$1/config
	echo R 0x30A09130 > $DCC_PATH/$1/config

	#MACH9_2_FEWC_Address
	echo R 0x30C68100 > $DCC_PATH/$1/config

	#MACH9_2_MC5
	echo R 0x30E091A0 > $DCC_PATH/$1/config
	#MACH9_2_MC5_MC5_INTERRUPT_STATUS
	echo R 0x30E09100 > $DCC_PATH/$1/config
	echo R 0x30E09110 > $DCC_PATH/$1/config
	echo R 0x30E09120 > $DCC_PATH/$1/config
	echo R 0x30E09130 > $DCC_PATH/$1/config
	#LLCC LCP NS Auth Error
	echo R 0x308EA004 > $DCC_PATH/$1/config
	echo R 0x308EA010 > $DCC_PATH/$1/config
	echo R 0x308EA020 > $DCC_PATH/$1/config
	echo R 0x308EA030 > $DCC_PATH/$1/config
	echo R 0x308EA040 > $DCC_PATH/$1/config
	echo R 0x308EA050 > $DCC_PATH/$1/config
	echo R 0x30CEA004 > $DCC_PATH/$1/config
	echo R 0x30CEA010 > $DCC_PATH/$1/config
	echo R 0x30CEA020 > $DCC_PATH/$1/config
	echo R 0x30CEA030 > $DCC_PATH/$1/config
	echo R 0x30CEA040 > $DCC_PATH/$1/config
	echo R 0x30CEA050 > $DCC_PATH/$1/config
	#LLCC LCP secure Auth Error
	echo R 0x308E9004 > $DCC_PATH/$1/config
	echo R 0x308E9010 > $DCC_PATH/$1/config
	echo R 0x308E9020 > $DCC_PATH/$1/config
	echo R 0x308E9030 > $DCC_PATH/$1/config
	echo R 0x308E9040 > $DCC_PATH/$1/config
	echo R 0x308E9050 > $DCC_PATH/$1/config
	echo R 0x30CE9004 > $DCC_PATH/$1/config
	echo R 0x30CE9010 > $DCC_PATH/$1/config
	echo R 0x30CE9020 > $DCC_PATH/$1/config
	echo R 0x30CE9030 > $DCC_PATH/$1/config
	echo R 0x30CE9040 > $DCC_PATH/$1/config
	echo R 0x30CE9050 > $DCC_PATH/$1/config
	#SHRM2_RVSS_PERIPH_SHRM2
	echo R 0x30076100 16 > $DCC_PATH/$1/config
}

enable_sa535m_dcc()
{
	echo "++++ $0 -> START dcc settings" > /dev/kmsg

	DCC_PATH="/sys/kernel/debug/qcom_dcc/100ff000.dma"

	if [ ! -d $DCC_PATH ]; then
		echo "DCC does not exist on this build."
		return
	fi

	LLNUM=6
	echo 0 > $DCC_PATH/$LLNUM/enable
	echo 1 > /sys/kernel/debug/qcom_dcc/config_reset

	config_sa535m_dcc_core $LLNUM
	config_sa535m_dcc_lpm_pcu $LLNUM
	config_sa535m_dcc_rpmh $LLNUM
	config_sa535m_dcc_apss_rscc $LLNUM
	config_sa535m_dcc_epss $LLNUM
	config_sa535m_dcc_misc $LLNUM
	config_sa535m_dcc_ddr $LLNUM
	echo 1 > $DCC_PATH/$LLNUM/enable

	LLNUM=4
	echo 0 > $DCC_PATH/$LLNUM/enable
	config_sa535m_dcc_gic $LLNUM
	config_sa535m_dcc_errorloggers $LLNUM
	config_sa535m_dcc_tr_pending $LLNUM
	config_sa535m_dcc_contexttable_tmo $LLNUM
	config_sa535m_dcc_debugchain $LLNUM
	config_sa535m_dcc_smmu $LLNUM
	config_sa535m_mss_rscc $LLNUM
	config_sa535m_cpr_dcc $LLNUM
	echo 1 > $DCC_PATH/$LLNUM/enable
	echo "++++ $0 -> END dcc settings" > /dev/kmsg
}

enable_sa535m_ftraces()
{
	echo "++++ $0 -> ENABLE-FTRACE START" > /dev/kmsg

	# bail out if ftrace events aren't present
	if [ ! -d /sys/kernel/debug/tracing/events ]
	then
	echo "++++ $0 -> It's NOT DEBUG Build" > /dev/kmsg
		return
	fi

	echo 0 > /sys/kernel/debug/tracing/events/enable
	echo 0 > /sys/kernel/debug/tracing/tracing_on

	#IRQs
	echo 1 > /sys/kernel/debug/tracing/events/irq/enable
	#Workqueue
	echo 1 > /sys/kernel/debug/tracing/events/workqueue/enable
	#Timer
	echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_entry/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_exit/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_cancel/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_entry/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_exit/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_init/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_start/enable
	#sched
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_migrate_task/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_pi_setprio/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/enable
	# hot-plug
	echo 1 > /sys/kernel/debug/tracing/events/cpuhp/enable

	echo 1 > /sys/kernel/debug/tracing/events/power/cpu_frequency/enable
	echo 1 > /sys/kernel/debug/tracing/events/clk/enable
	echo 1 > /sys/kernel/debug/tracing/events/regulator/enable
	echo 1 > /sys/kernel/debug/tracing/events/rpmh/enable

	echo 1 > /sys/kernel/debug/tracing/tracing_on

	echo "++++ $0 -> ENABLE-FTRACE END" > /dev/kmsg
}

enable_sa535m_debug()
{
	enable_sa535m_dcc
	enable_sa535m_ftraces
}
