#! /bin/sh
# Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

create_sa525m_stm_stp_policy()
{
	echo "++++ $0 -> create_stp_policy START" > /dev/kmsg
	mkdir /sys/kernel/config/stp-policy/coresight-stm:p_ost.policy
	chmod 660 /sys/kernel/config/stp-policy/coresight-stm:p_ost.policy
	mkdir /sys/kernel/config/stp-policy/coresight-stm:p_ost.policy/default
	chmod 660 /sys/kernel/config/stp-policy/coresight-stm:p_ost.policy/default
	echo 0x10 > /sys/bus/coresight/devices/coresight-stm/traceid
	echo "++++ $0 -> create_stp_policy END" > /dev/kmsg
}

configure_coresight()
{
	chmod 660 /dev/byte-cntr
	chown diag:root /dev/byte-cntr
	chmod 660 /sys/bus/coresight/reset_source_sink
	chown diag:root /sys/bus/coresight/reset_source_sink
}

config_sdxpinn_aop_rsc()
{
	#AOP RSC
	echo 0xB0D0208 > $DCC_PATH/config
	echo 0xB0D020C > $DCC_PATH/config
	echo 0xB0D0228 > $DCC_PATH/config
	echo 0xB0D022C > $DCC_PATH/config
	echo 0xB0D0248 > $DCC_PATH/config
	echo 0xB0D024C > $DCC_PATH/config
	echo 0xB0D0268 > $DCC_PATH/config
	echo 0xB0D026C > $DCC_PATH/config
	echo 0xB0D0408 > $DCC_PATH/config
}

config_sdxpinn_mss_rscc()
{
	echo 0x4200110 > $DCC_PATH/config
	echo 0x4200114 > $DCC_PATH/config
	echo 0x4200208 > $DCC_PATH/config
	echo 0x4200228 > $DCC_PATH/config
	echo 0x4200248 > $DCC_PATH/config
	echo 0x4200268 > $DCC_PATH/config
	echo 0x420020C > $DCC_PATH/config
	echo 0x420022C > $DCC_PATH/config
	echo 0x420024C > $DCC_PATH/config
	echo 0x420026C > $DCC_PATH/config
	echo 0x4200210 > $DCC_PATH/config
	echo 0x4200230 > $DCC_PATH/config
	echo 0x4200250 > $DCC_PATH/config
	echo 0x4200270 > $DCC_PATH/config
	echo 0x4200404 > $DCC_PATH/config
	echo 0x4200408 > $DCC_PATH/config
	echo 0x420040C > $DCC_PATH/config
	
	echo 0x4082028 > $DCC_PATH/config
	echo 0x4140110 > $DCC_PATH/config
	echo 0x4140114 > $DCC_PATH/config
	echo 0x414011C > $DCC_PATH/config
	echo 0x4140208 > $DCC_PATH/config
	echo 0x4140228 > $DCC_PATH/config
	echo 0x4140248 > $DCC_PATH/config
	echo 0x4140268 > $DCC_PATH/config
	echo 0x414020C > $DCC_PATH/config
	echo 0x414022C > $DCC_PATH/config
	echo 0x414024C > $DCC_PATH/config
	echo 0x414026C > $DCC_PATH/config
	echo 0x4140210 > $DCC_PATH/config
	echo 0x4140230 > $DCC_PATH/config
	echo 0x4140250 > $DCC_PATH/config
	echo 0x4140270 > $DCC_PATH/config
	echo 0x4140404 > $DCC_PATH/config
	echo 0x4140408 > $DCC_PATH/config
	echo 0x414040C > $DCC_PATH/config
	echo 0x2480C000 > $DCC_PATH/config
}

config_sdxpinn_prng()
{
	# TZ PRNG registers
	echo 0x10C0000 1 > $DCC_PATH/config
	echo 0x10C0004 1 > $DCC_PATH/config
	echo 0x10C0008 1 > $DCC_PATH/config
	echo 0x10C000C 1 > $DCC_PATH/config
	
	echo 0x10C1000 1 > $DCC_PATH/config
	echo 0x10C1004 1 > $DCC_PATH/config
	echo 0x10C1010 1 > $DCC_PATH/config
	echo 0x10C1014 1 > $DCC_PATH/config
	echo 0x10C1018 1 > $DCC_PATH/config
	echo 0x10C101C 1 > $DCC_PATH/config
	echo 0x10C1020 1 > $DCC_PATH/config
	echo 0x10C1024 1 > $DCC_PATH/config
	echo 0x10C1028 1 > $DCC_PATH/config
	echo 0x10C1100 1 > $DCC_PATH/config
	echo 0x10C1104 1 > $DCC_PATH/config
	echo 0x10C1108 1 > $DCC_PATH/config
	echo 0x10C1110 1 > $DCC_PATH/config
	echo 0x10C1114 1 > $DCC_PATH/config
	echo 0x10C1118 1 > $DCC_PATH/config
	echo 0x10C111C 1 > $DCC_PATH/config
	echo 0x10C1120 1 > $DCC_PATH/config
	echo 0x10C1130 1 > $DCC_PATH/config
	echo 0x10C1134 1 > $DCC_PATH/config
	echo 0x10C113C 1 > $DCC_PATH/config
	echo 0x10C1140 1 > $DCC_PATH/config
	echo 0x10C1148 1 > $DCC_PATH/config
	echo 0x10C114C 1 > $DCC_PATH/config
	echo 0x10C1150 1 > $DCC_PATH/config
}

config_sdxpinn_dcc_bam()
{
	echo 0x1C9C000 > $DCC_PATH/config
	echo 0x1C9C008 > $DCC_PATH/config
	echo 0x1C9C014 > $DCC_PATH/config
	echo 0x1C9C01C > $DCC_PATH/config
	echo 0x1C9C040 > $DCC_PATH/config
	echo 0x1C9C044 > $DCC_PATH/config
	echo 0x1C9C07C > $DCC_PATH/config
	echo 0x1C9C084 > $DCC_PATH/config
	echo 0x1C9D000 > $DCC_PATH/config
	echo 0x1C9D004 > $DCC_PATH/config
	echo 0x1C9D008 > $DCC_PATH/config
	echo 0x1C9D010 > $DCC_PATH/config
	echo 0x1C9D014 > $DCC_PATH/config
	echo 0x1C9D024 > $DCC_PATH/config
	echo 0x1C9D028 > $DCC_PATH/config
	echo 0x1C9D02C > $DCC_PATH/config
	echo 0x1C9D100 > $DCC_PATH/config
	echo 0x1C9D104 > $DCC_PATH/config
	echo 0x1C9E000 > $DCC_PATH/config
	echo 0x1C9E020 > $DCC_PATH/config
	echo 0x1C9E024 > $DCC_PATH/config
	echo 0x1C9E028 > $DCC_PATH/config
	echo 0x1C9E02C > $DCC_PATH/config
	echo 0x1C9E030 > $DCC_PATH/config
	echo 0x1C9E034 > $DCC_PATH/config
	echo 0x1C9E038 > $DCC_PATH/config
	echo 0x1C9E03C > $DCC_PATH/config
	echo 0x1C9E040 > $DCC_PATH/config
	echo 0x1C9F000 > $DCC_PATH/config
	echo 0x1CA0000 > $DCC_PATH/config
	echo 0x1CA1000 > $DCC_PATH/config
	echo 0x1CA2000 > $DCC_PATH/config
	echo 0x1C9F004 > $DCC_PATH/config
	echo 0x1CA0004 > $DCC_PATH/config
	echo 0x1CA1004 > $DCC_PATH/config
	echo 0x1CA2004 > $DCC_PATH/config
	echo 0x1C9F008 > $DCC_PATH/config
	echo 0x1CA0008 > $DCC_PATH/config
	echo 0x1CA1008 > $DCC_PATH/config
	echo 0x1CA2008 > $DCC_PATH/config
	echo 0x1C9F00C > $DCC_PATH/config
	echo 0x1CA000C > $DCC_PATH/config
	echo 0x1CA100C > $DCC_PATH/config
	echo 0x1CA200C > $DCC_PATH/config
	echo 0x1C9F010 > $DCC_PATH/config
	echo 0x1C9F014 > $DCC_PATH/config
	echo 0x1C9F018 > $DCC_PATH/config
	echo 0x1CAF000 > $DCC_PATH/config
	echo 0x1CB0000 > $DCC_PATH/config
	echo 0x1CB1000 > $DCC_PATH/config
	echo 0x1CB2000 > $DCC_PATH/config
	echo 0x1CB3000 > $DCC_PATH/config
	echo 0x1CB4000 > $DCC_PATH/config
	echo 0x1CB5000 > $DCC_PATH/config
	echo 0x1CB6000 > $DCC_PATH/config
	echo 0x1CB7000 > $DCC_PATH/config
	echo 0x1CAF008 > $DCC_PATH/config
	echo 0x1CB0008 > $DCC_PATH/config
	echo 0x1CB1008 > $DCC_PATH/config
	echo 0x1CB2008 > $DCC_PATH/config
	echo 0x1CB3008 > $DCC_PATH/config
	echo 0x1CB4008 > $DCC_PATH/config
	echo 0x1CB5008 > $DCC_PATH/config
	echo 0x1CB6008 > $DCC_PATH/config
	echo 0x1CB7008 > $DCC_PATH/config
	echo 0x1CAF010 > $DCC_PATH/config
	echo 0x1CB0010 > $DCC_PATH/config
	echo 0x1CB1010 > $DCC_PATH/config
	echo 0x1CB2010 > $DCC_PATH/config
	echo 0x1CB3010 > $DCC_PATH/config
	echo 0x1CB4010 > $DCC_PATH/config
	echo 0x1CB5010 > $DCC_PATH/config
	echo 0x1CB6010 > $DCC_PATH/config
	echo 0x1CB7010 > $DCC_PATH/config
	echo 0x1CAF018 > $DCC_PATH/config
	echo 0x1CB0018 > $DCC_PATH/config
	echo 0x1CB1018 > $DCC_PATH/config
	echo 0x1CB2018 > $DCC_PATH/config
	echo 0x1CB3018 > $DCC_PATH/config
	echo 0x1CB4018 > $DCC_PATH/config
	echo 0x1CB5018 > $DCC_PATH/config
	echo 0x1CB6018 > $DCC_PATH/config
	echo 0x1CB7018 > $DCC_PATH/config
	echo 0x1CAF01C > $DCC_PATH/config
	echo 0x1CB001C > $DCC_PATH/config
	echo 0x1CB101C > $DCC_PATH/config
	echo 0x1CB201C > $DCC_PATH/config
	echo 0x1CB301C > $DCC_PATH/config
	echo 0x1CB401C > $DCC_PATH/config
	echo 0x1CB501C > $DCC_PATH/config
	echo 0x1CB601C > $DCC_PATH/config
	echo 0x1CB701C > $DCC_PATH/config
	echo 0x1CAF020 > $DCC_PATH/config
	echo 0x1CB0020 > $DCC_PATH/config
	echo 0x1CB1020 > $DCC_PATH/config
	echo 0x1CB2020 > $DCC_PATH/config
	echo 0x1CB3020 > $DCC_PATH/config
	echo 0x1CB4020 > $DCC_PATH/config
	echo 0x1CB5020 > $DCC_PATH/config
	echo 0x1CB6020 > $DCC_PATH/config
	echo 0x1CB7020 > $DCC_PATH/config
	echo 0x1CAF024 > $DCC_PATH/config
	echo 0x1CB0024 > $DCC_PATH/config
	echo 0x1CB1024 > $DCC_PATH/config
	echo 0x1CB2024 > $DCC_PATH/config
	echo 0x1CB3024 > $DCC_PATH/config
	echo 0x1CB4024 > $DCC_PATH/config
	echo 0x1CB5024 > $DCC_PATH/config
	echo 0x1CB6024 > $DCC_PATH/config
	echo 0x1CB7024 > $DCC_PATH/config
	echo 0x1CAF028 > $DCC_PATH/config
	echo 0x1CB0028 > $DCC_PATH/config
	echo 0x1CB1028 > $DCC_PATH/config
	echo 0x1CB2028 > $DCC_PATH/config
	echo 0x1CB3028 > $DCC_PATH/config
	echo 0x1CB4028 > $DCC_PATH/config
	echo 0x1CB5028 > $DCC_PATH/config
	echo 0x1CB6028 > $DCC_PATH/config
	echo 0x1CB7028 > $DCC_PATH/config
	echo 0x1CAF800 > $DCC_PATH/config
	echo 0x1CB0800 > $DCC_PATH/config
	echo 0x1CB1800 > $DCC_PATH/config
	echo 0x1CB2800 > $DCC_PATH/config
	echo 0x1CB3800 > $DCC_PATH/config
	echo 0x1CB4800 > $DCC_PATH/config
	echo 0x1CB5800 > $DCC_PATH/config
	echo 0x1CB6800 > $DCC_PATH/config
	echo 0x1CB7800 > $DCC_PATH/config
	echo 0x1CAF804 > $DCC_PATH/config
	echo 0x1CB0804 > $DCC_PATH/config
	echo 0x1CB1804 > $DCC_PATH/config
	echo 0x1CB2804 > $DCC_PATH/config
	echo 0x1CB3804 > $DCC_PATH/config
	echo 0x1CB4804 > $DCC_PATH/config
	echo 0x1CB5804 > $DCC_PATH/config
	echo 0x1CB6804 > $DCC_PATH/config
	echo 0x1CB7804 > $DCC_PATH/config
	echo 0x1CAF808 > $DCC_PATH/config
	echo 0x1CB0808 > $DCC_PATH/config
	echo 0x1CB1808 > $DCC_PATH/config
	echo 0x1CB2808 > $DCC_PATH/config
	echo 0x1CB3808 > $DCC_PATH/config
	echo 0x1CB4808 > $DCC_PATH/config
	echo 0x1CB5808 > $DCC_PATH/config
	echo 0x1CB6808 > $DCC_PATH/config
	echo 0x1CB7808 > $DCC_PATH/config
	echo 0x1CAF80C > $DCC_PATH/config
	echo 0x1CB080C > $DCC_PATH/config
	echo 0x1CB180C > $DCC_PATH/config
	echo 0x1CB280C > $DCC_PATH/config
	echo 0x1CB380C > $DCC_PATH/config
	echo 0x1CB480C > $DCC_PATH/config
	echo 0x1CB580C > $DCC_PATH/config
	echo 0x1CB680C > $DCC_PATH/config
	echo 0x1CB780C > $DCC_PATH/config
	echo 0x1CAF810 > $DCC_PATH/config
	echo 0x1CB0810 > $DCC_PATH/config
	echo 0x1CB1810 > $DCC_PATH/config
	echo 0x1CB2810 > $DCC_PATH/config
	echo 0x1CB3810 > $DCC_PATH/config
	echo 0x1CB4810 > $DCC_PATH/config
	echo 0x1CB5810 > $DCC_PATH/config
	echo 0x1CB6810 > $DCC_PATH/config
	echo 0x1CB7810 > $DCC_PATH/config
	echo 0x1CAF814 > $DCC_PATH/config
	echo 0x1CB0814 > $DCC_PATH/config
	echo 0x1CB1814 > $DCC_PATH/config
	echo 0x1CB2814 > $DCC_PATH/config
	echo 0x1CB3814 > $DCC_PATH/config
	echo 0x1CB4814 > $DCC_PATH/config
	echo 0x1CB5814 > $DCC_PATH/config
	echo 0x1CB6814 > $DCC_PATH/config
	echo 0x1CB7814 > $DCC_PATH/config
	echo 0x1CAF818 > $DCC_PATH/config
	echo 0x1CB0818 > $DCC_PATH/config
	echo 0x1CB1818 > $DCC_PATH/config
	echo 0x1CB2818 > $DCC_PATH/config
	echo 0x1CB3818 > $DCC_PATH/config
	echo 0x1CB4818 > $DCC_PATH/config
	echo 0x1CB5818 > $DCC_PATH/config
	echo 0x1CB6818 > $DCC_PATH/config
	echo 0x1CB7818 > $DCC_PATH/config
	echo 0x1CAF81C > $DCC_PATH/config
	echo 0x1CB081C > $DCC_PATH/config
	echo 0x1CB181C > $DCC_PATH/config
	echo 0x1CB281C > $DCC_PATH/config
	echo 0x1CB381C > $DCC_PATH/config
	echo 0x1CB481C > $DCC_PATH/config
	echo 0x1CB581C > $DCC_PATH/config
	echo 0x1CB681C > $DCC_PATH/config
	echo 0x1CB781C > $DCC_PATH/config
	echo 0x1CAF820 > $DCC_PATH/config
	echo 0x1CB0820 > $DCC_PATH/config
	echo 0x1CB1820 > $DCC_PATH/config
	echo 0x1CB2820 > $DCC_PATH/config
	echo 0x1CB3820 > $DCC_PATH/config
	echo 0x1CB4820 > $DCC_PATH/config
	echo 0x1CB5820 > $DCC_PATH/config
	echo 0x1CB6820 > $DCC_PATH/config
	echo 0x1CB7820 > $DCC_PATH/config
	echo 0x1CAF824 > $DCC_PATH/config
	echo 0x1CB0824 > $DCC_PATH/config
	echo 0x1CB1824 > $DCC_PATH/config
	echo 0x1CB2824 > $DCC_PATH/config
	echo 0x1CB3824 > $DCC_PATH/config
	echo 0x1CB4824 > $DCC_PATH/config
	echo 0x1CB5824 > $DCC_PATH/config
	echo 0x1CB6824 > $DCC_PATH/config
	echo 0x1CB7824 > $DCC_PATH/config
	echo 0x1CAF828 > $DCC_PATH/config
	echo 0x1CB0828 > $DCC_PATH/config
	echo 0x1CB1828 > $DCC_PATH/config
	echo 0x1CB2828 > $DCC_PATH/config
	echo 0x1CB3828 > $DCC_PATH/config
	echo 0x1CB4828 > $DCC_PATH/config
	echo 0x1CB5828 > $DCC_PATH/config
	echo 0x1CB6828 > $DCC_PATH/config
	echo 0x1CB7828 > $DCC_PATH/config
	echo 0x1CAF82C > $DCC_PATH/config
	echo 0x1CB082C > $DCC_PATH/config
	echo 0x1CB182C > $DCC_PATH/config
	echo 0x1CB282C > $DCC_PATH/config
	echo 0x1CB382C > $DCC_PATH/config
	echo 0x1CB482C > $DCC_PATH/config
	echo 0x1CB582C > $DCC_PATH/config
	echo 0x1CB682C > $DCC_PATH/config
	echo 0x1CB782C > $DCC_PATH/config
	echo 0x1CAF830 > $DCC_PATH/config
	echo 0x1CB0830 > $DCC_PATH/config
	echo 0x1CB1830 > $DCC_PATH/config
	echo 0x1CB2830 > $DCC_PATH/config
	echo 0x1CB3830 > $DCC_PATH/config
	echo 0x1CB4830 > $DCC_PATH/config
	echo 0x1CB5830 > $DCC_PATH/config
	echo 0x1CB6830 > $DCC_PATH/config
	echo 0x1CB7830 > $DCC_PATH/config
	echo 0x1CAF834 > $DCC_PATH/config
	echo 0x1CB0834 > $DCC_PATH/config
	echo 0x1CB1834 > $DCC_PATH/config
	echo 0x1CB2834 > $DCC_PATH/config
	echo 0x1CB3834 > $DCC_PATH/config
	echo 0x1CB4834 > $DCC_PATH/config
	echo 0x1CB5834 > $DCC_PATH/config
	echo 0x1CB6834 > $DCC_PATH/config
	echo 0x1CB7834 > $DCC_PATH/config
	echo 0x1CAF838 > $DCC_PATH/config
	echo 0x1CB0838 > $DCC_PATH/config
	echo 0x1CB1838 > $DCC_PATH/config
	echo 0x1CB2838 > $DCC_PATH/config
	echo 0x1CB3838 > $DCC_PATH/config
	echo 0x1CB4838 > $DCC_PATH/config
	echo 0x1CB5838 > $DCC_PATH/config
	echo 0x1CB6838 > $DCC_PATH/config
	echo 0x1CB7838 > $DCC_PATH/config
	echo 0x1CAF900 > $DCC_PATH/config
	echo 0x1CB0900 > $DCC_PATH/config
	echo 0x1CB1900 > $DCC_PATH/config
	echo 0x1CB2900 > $DCC_PATH/config
	echo 0x1CB3900 > $DCC_PATH/config
	echo 0x1CB4900 > $DCC_PATH/config
	echo 0x1CB5900 > $DCC_PATH/config
	echo 0x1CB6900 > $DCC_PATH/config
	echo 0x1CB7900 > $DCC_PATH/config
	echo 0x1CAF904 > $DCC_PATH/config
	echo 0x1CB0904 > $DCC_PATH/config
	echo 0x1CB1904 > $DCC_PATH/config
	echo 0x1CB2904 > $DCC_PATH/config
	echo 0x1CB3904 > $DCC_PATH/config
	echo 0x1CB4904 > $DCC_PATH/config
	echo 0x1CB5904 > $DCC_PATH/config
	echo 0x1CB6904 > $DCC_PATH/config
	echo 0x1CB7904 > $DCC_PATH/config
	echo 0x1CAF910 > $DCC_PATH/config
	echo 0x1CB0910 > $DCC_PATH/config
	echo 0x1CB1910 > $DCC_PATH/config
	echo 0x1CB2910 > $DCC_PATH/config
	echo 0x1CB3910 > $DCC_PATH/config
	echo 0x1CB4910 > $DCC_PATH/config
	echo 0x1CB5910 > $DCC_PATH/config
	echo 0x1CB6910 > $DCC_PATH/config
	echo 0x1CB7910 > $DCC_PATH/config
	echo 0x1CAF914 > $DCC_PATH/config
	echo 0x1CB0914 > $DCC_PATH/config
	echo 0x1CB1914 > $DCC_PATH/config
	echo 0x1CB2914 > $DCC_PATH/config
	echo 0x1CB3914 > $DCC_PATH/config
	echo 0x1CB4914 > $DCC_PATH/config
	echo 0x1CB5914 > $DCC_PATH/config
	echo 0x1CB6914 > $DCC_PATH/config
	echo 0x1CB7914 > $DCC_PATH/config
	echo 0x1CAF920 > $DCC_PATH/config
	echo 0x1CB0920 > $DCC_PATH/config
	echo 0x1CB1920 > $DCC_PATH/config
	echo 0x1CB2920 > $DCC_PATH/config
	echo 0x1CB3920 > $DCC_PATH/config
	echo 0x1CB4920 > $DCC_PATH/config
	echo 0x1CB5920 > $DCC_PATH/config
	echo 0x1CB6920 > $DCC_PATH/config
	echo 0x1CB7920 > $DCC_PATH/config
	echo 0x1CAF924 > $DCC_PATH/config
	echo 0x1CB0924 > $DCC_PATH/config
	echo 0x1CB1924 > $DCC_PATH/config
	echo 0x1CB2924 > $DCC_PATH/config
	echo 0x1CB3924 > $DCC_PATH/config
	echo 0x1CB4924 > $DCC_PATH/config
	echo 0x1CB5924 > $DCC_PATH/config
	echo 0x1CB6924 > $DCC_PATH/config
	echo 0x1CB7924 > $DCC_PATH/config
	echo 0x1CAF930 > $DCC_PATH/config
	echo 0x1CB0930 > $DCC_PATH/config
	echo 0x1CB1930 > $DCC_PATH/config
	echo 0x1CB2930 > $DCC_PATH/config
	echo 0x1CB3930 > $DCC_PATH/config
	echo 0x1CB4930 > $DCC_PATH/config
	echo 0x1CB5930 > $DCC_PATH/config
	echo 0x1CB6930 > $DCC_PATH/config
	echo 0x1CB7930 > $DCC_PATH/config
	echo 0x1CAF934 > $DCC_PATH/config
	echo 0x1CB0934 > $DCC_PATH/config
	echo 0x1CB1934 > $DCC_PATH/config
	echo 0x1CB2934 > $DCC_PATH/config
	echo 0x1CB3934 > $DCC_PATH/config
	echo 0x1CB4934 > $DCC_PATH/config
	echo 0x1CB5934 > $DCC_PATH/config
	echo 0x1CB6934 > $DCC_PATH/config
	echo 0x1CB7934 > $DCC_PATH/config
	echo 0x1C99000 > $DCC_PATH/config
	echo 0x1C99004 > $DCC_PATH/config
	echo 0x1C99008 > $DCC_PATH/config
	echo 0x1C9900C > $DCC_PATH/config
	echo 0x1C99100 > $DCC_PATH/config
	echo 0x1C99104 > $DCC_PATH/config
	echo 0x1C99208 > $DCC_PATH/config
	echo 0x1C9920C > $DCC_PATH/config
	echo 0x1C99304 > $DCC_PATH/config
	echo 0x1C99500 > $DCC_PATH/config
	echo 0x1C99504 > $DCC_PATH/config
	echo 0x1C99508 > $DCC_PATH/config
	echo 0x1C9950C > $DCC_PATH/config
	echo 0x1C99510 > $DCC_PATH/config
	echo 0x1C99514 > $DCC_PATH/config
	echo 0x1C9A000 > $DCC_PATH/config
	echo 0x1C9A040 > $DCC_PATH/config
	echo 0x1C9A080 > $DCC_PATH/config
	echo 0x1C9A0C0 > $DCC_PATH/config
	echo 0x1C9A100 > $DCC_PATH/config
	echo 0x1C9A140 > $DCC_PATH/config
	echo 0x1C9A180 > $DCC_PATH/config
	echo 0x1C9A1C0 > $DCC_PATH/config
	echo 0x1C9A200 > $DCC_PATH/config
	echo 0x1C9A240 > $DCC_PATH/config
	echo 0x1C9A280 > $DCC_PATH/config
	echo 0x1C9A2C0 > $DCC_PATH/config
	echo 0x1C9A300 > $DCC_PATH/config
	echo 0x1C9A340 > $DCC_PATH/config
	echo 0x1C9A380 > $DCC_PATH/config
	echo 0x1C9A3C0 > $DCC_PATH/config
	echo 0x1C9A400 > $DCC_PATH/config
	echo 0x1C9A440 > $DCC_PATH/config
	echo 0x1C9A480 > $DCC_PATH/config
	echo 0x1C9A4C0 > $DCC_PATH/config
	echo 0x1C9A500 > $DCC_PATH/config
	echo 0x1C9A540 > $DCC_PATH/config
	echo 0x1C9A580 > $DCC_PATH/config
	echo 0x1C9A004 > $DCC_PATH/config
	echo 0x1C9A044 > $DCC_PATH/config
	echo 0x1C9A084 > $DCC_PATH/config
	echo 0x1C9A0C4 > $DCC_PATH/config
	echo 0x1C9A104 > $DCC_PATH/config
	echo 0x1C9A144 > $DCC_PATH/config
	echo 0x1C9A184 > $DCC_PATH/config
	echo 0x1C9A1C4 > $DCC_PATH/config
	echo 0x1C9A204 > $DCC_PATH/config
	echo 0x1C9A244 > $DCC_PATH/config
	echo 0x1C9A284 > $DCC_PATH/config
	echo 0x1C9A2C4 > $DCC_PATH/config
	echo 0x1C9A304 > $DCC_PATH/config
	echo 0x1C9A344 > $DCC_PATH/config
	echo 0x1C9A384 > $DCC_PATH/config
	echo 0x1C9A3C4 > $DCC_PATH/config
	echo 0x1C9A404 > $DCC_PATH/config
	echo 0x1C9A444 > $DCC_PATH/config
	echo 0x1C9A484 > $DCC_PATH/config
	echo 0x1C9A4C4 > $DCC_PATH/config
	echo 0x1C9A504 > $DCC_PATH/config
	echo 0x1C9A544 > $DCC_PATH/config
	echo 0x1C9A584 > $DCC_PATH/config
	echo 0x1C9A018 > $DCC_PATH/config
	echo 0x1C9A058 > $DCC_PATH/config
	echo 0x1C9A098 > $DCC_PATH/config
	echo 0x1C9A0D8 > $DCC_PATH/config
	echo 0x1C9A118 > $DCC_PATH/config
	echo 0x1C9A158 > $DCC_PATH/config
	echo 0x1C9A198 > $DCC_PATH/config
	echo 0x1C9A1D8 > $DCC_PATH/config
	echo 0x1C9A218 > $DCC_PATH/config
	echo 0x1C9A258 > $DCC_PATH/config
	echo 0x1C9A298 > $DCC_PATH/config
	echo 0x1C9A2D8 > $DCC_PATH/config
	echo 0x1C9A318 > $DCC_PATH/config
	echo 0x1C9A358 > $DCC_PATH/config
	echo 0x1C9A398 > $DCC_PATH/config
	echo 0x1C9A3D8 > $DCC_PATH/config
	echo 0x1C9A418 > $DCC_PATH/config
	echo 0x1C9A458 > $DCC_PATH/config
	echo 0x1C9A498 > $DCC_PATH/config
	echo 0x1C9A4D8 > $DCC_PATH/config
	echo 0x1C9A518 > $DCC_PATH/config
	echo 0x1C9A558 > $DCC_PATH/config
	echo 0x1C9A598 > $DCC_PATH/config
	echo 0x1C9A01C > $DCC_PATH/config
	echo 0x1C9A05C > $DCC_PATH/config
	echo 0x1C9A09C > $DCC_PATH/config
	echo 0x1C9A0DC > $DCC_PATH/config
	echo 0x1C9A11C > $DCC_PATH/config
	echo 0x1C9A15C > $DCC_PATH/config
	echo 0x1C9A19C > $DCC_PATH/config
	echo 0x1C9A1DC > $DCC_PATH/config
	echo 0x1C9A21C > $DCC_PATH/config
	echo 0x1C9A25C > $DCC_PATH/config
	echo 0x1C9A29C > $DCC_PATH/config
	echo 0x1C9A2DC > $DCC_PATH/config
	echo 0x1C9A31C > $DCC_PATH/config
	echo 0x1C9A35C > $DCC_PATH/config
	echo 0x1C9A39C > $DCC_PATH/config
	echo 0x1C9A3DC > $DCC_PATH/config
	echo 0x1C9A41C > $DCC_PATH/config
	echo 0x1C9A45C > $DCC_PATH/config
	echo 0x1C9A49C > $DCC_PATH/config
	echo 0x1C9A4DC > $DCC_PATH/config
	echo 0x1C9A51C > $DCC_PATH/config
	echo 0x1C9A55C > $DCC_PATH/config
	echo 0x1C9A59C > $DCC_PATH/config
	echo 0x1C9A030 > $DCC_PATH/config
	echo 0x1C9A070 > $DCC_PATH/config
	echo 0x1C9A0B0 > $DCC_PATH/config
	echo 0x1C9A0F0 > $DCC_PATH/config
	echo 0x1C9A130 > $DCC_PATH/config
	echo 0x1C9A170 > $DCC_PATH/config
	echo 0x1C9A1B0 > $DCC_PATH/config
	echo 0x1C9A1F0 > $DCC_PATH/config
	echo 0x1C9A230 > $DCC_PATH/config
	echo 0x1C9A270 > $DCC_PATH/config
	echo 0x1C9A2B0 > $DCC_PATH/config
	echo 0x1C9A2F0 > $DCC_PATH/config
	echo 0x1C9A330 > $DCC_PATH/config
	echo 0x1C9A370 > $DCC_PATH/config
	echo 0x1C9A3B0 > $DCC_PATH/config
	echo 0x1C9A3F0 > $DCC_PATH/config
	echo 0x1C9A430 > $DCC_PATH/config
	echo 0x1C9A470 > $DCC_PATH/config
	echo 0x1C9A4B0 > $DCC_PATH/config
	echo 0x1C9A4F0 > $DCC_PATH/config
	echo 0x1C9A530 > $DCC_PATH/config
	echo 0x1C9A570 > $DCC_PATH/config
	echo 0x1C9A5B0 > $DCC_PATH/config
	echo 0x1C98000 > $DCC_PATH/config
	echo 0x1C98000 > $DCC_PATH/config
	echo 0x1C98004 > $DCC_PATH/config
	echo 0x1C98008 > $DCC_PATH/config
	echo 0x1C98008 > $DCC_PATH/config
	echo 0x1C98010 > $DCC_PATH/config
	echo 0x1C98010 > $DCC_PATH/config
	echo 0x1C98020 > $DCC_PATH/config
	echo 0x1C98020 > $DCC_PATH/config
	echo 0x1C98024 > $DCC_PATH/config
	echo 0x1C98024 > $DCC_PATH/config
	echo 0x1C98028 > $DCC_PATH/config
	echo 0x1C98028 > $DCC_PATH/config
	echo 0x1C98030 > $DCC_PATH/config
	echo 0x1C98030 > $DCC_PATH/config
	echo 0x1C98034 > $DCC_PATH/config
	echo 0x1C98034 > $DCC_PATH/config
	echo 0x1C9803C > $DCC_PATH/config
	echo 0x1C9803C > $DCC_PATH/config
	echo 0x1C98040 > $DCC_PATH/config
	echo 0x1C98040 > $DCC_PATH/config
	echo 0x1C98048 > $DCC_PATH/config
	echo 0x1C98048 > $DCC_PATH/config
	echo 0x1C9804C > $DCC_PATH/config
	echo 0x1C9804C > $DCC_PATH/config
	echo 0x1C98050 > $DCC_PATH/config
	echo 0x1C98050 > $DCC_PATH/config
	echo 0x1C98054 > $DCC_PATH/config
	echo 0x1C98054 > $DCC_PATH/config
	echo 0x1C98058 > $DCC_PATH/config
	echo 0x1C98058 > $DCC_PATH/config
	echo 0x1C98080 > $DCC_PATH/config
	echo 0x1C98090 > $DCC_PATH/config
	echo 0x1C98090 > $DCC_PATH/config
	echo 0x1C9809C > $DCC_PATH/config
	echo 0x1C98400 > $DCC_PATH/config
	echo 0x1C98408 > $DCC_PATH/config
	echo 0x1C98410 > $DCC_PATH/config
	echo 0x1C98440 > $DCC_PATH/config
	echo 0x1C98448 > $DCC_PATH/config
	echo 0x1C9844C > $DCC_PATH/config
	echo 0x1C98450 > $DCC_PATH/config
	echo 0x1C98454 > $DCC_PATH/config
	echo 0x1C98458 > $DCC_PATH/config
	echo 0x1C98480 > $DCC_PATH/config
	echo 0x1C98490 > $DCC_PATH/config
	echo 0x1C98494 > $DCC_PATH/config
	echo 0x1C98580 > $DCC_PATH/config
	echo 0x1C98594 > $DCC_PATH/config
	echo 0x1C98800 > $DCC_PATH/config
	echo 0x1C98804 > $DCC_PATH/config
	echo 0x1C98808 > $DCC_PATH/config
	echo 0x1C9880C > $DCC_PATH/config
	echo 0x1C98810 > $DCC_PATH/config
	echo 0x1C98814 > $DCC_PATH/config
	echo 0x1C98818 > $DCC_PATH/config
	echo 0x1C9881C > $DCC_PATH/config
	echo 0x1C98820 > $DCC_PATH/config
	echo 0x1C98824 > $DCC_PATH/config
	echo 0x1C98C00 > $DCC_PATH/config
	echo 0x1C98C04 > $DCC_PATH/config
	echo 0x1C98C08 > $DCC_PATH/config
	echo 0x1C98C0C > $DCC_PATH/config
	echo 0x1C98C10 > $DCC_PATH/config
	echo 0x1C98C14 > $DCC_PATH/config
	echo 0x1C98C18 > $DCC_PATH/config
	echo 0x1C98C1C > $DCC_PATH/config
	echo 0x1C98C20 > $DCC_PATH/config
	echo 0x1C98C24 > $DCC_PATH/config
	echo 0x1C98E00 > $DCC_PATH/config
	echo 0x1C98E04 > $DCC_PATH/config
	echo 0x1C98E08 > $DCC_PATH/config
	echo 0x1C98E0C > $DCC_PATH/config
	echo 0x1C98E10 > $DCC_PATH/config
	echo 0x1C98E14 > $DCC_PATH/config
	echo 0x1C98E18 > $DCC_PATH/config
	echo 0x1C98E1C > $DCC_PATH/config
	echo 0x1C98E20 > $DCC_PATH/config
	echo 0x1C98E24 > $DCC_PATH/config
}

config_sdxpinn_dcc_rpmh()
{
	echo 0xb251024 > $DCC_PATH/config
	echo 0xbde1034 > $DCC_PATH/config

	#RPMH_PDC_APSS
	echo 0xb201020 2 > $DCC_PATH/config
	echo 0xb211020 2 > $DCC_PATH/config
	echo 0xb221020 2 > $DCC_PATH/config
	echo 0xb231020 2 > $DCC_PATH/config
	echo 0xb204520 > $DCC_PATH/config

	echo 0xb200010 4 > $DCC_PATH/config
	echo 0xb200900 4 > $DCC_PATH/config
	echo 0xb201030 > $DCC_PATH/config
	echo 0xb201204 2 > $DCC_PATH/config
	echo 0xb201218 2 > $DCC_PATH/config
	echo 0xb20122c 2 > $DCC_PATH/config
	echo 0xb201240 2 > $DCC_PATH/config
	echo 0xb201254 2 > $DCC_PATH/config
	echo 0xb204510 2 > $DCC_PATH/config
	echo 0xb220010 4 > $DCC_PATH/config
	echo 0xb220900 4 > $DCC_PATH/config

	echo 0xB200000 > $DCC_PATH/config
	echo 0xB220000 > $DCC_PATH/config

}

config_sdxpinn_dcc_thermal()
{
	#Tsense
	echo 0xc222004 > $DCC_PATH/config
	echo 0xc271014 > $DCC_PATH/config
	echo 0xc2710e0 > $DCC_PATH/config
	echo 0xc2710ec > $DCC_PATH/config
	echo 0xc2710a0 16 > $DCC_PATH/config
	echo 0xc2710e8 > $DCC_PATH/config
	echo 0xc27113c > $DCC_PATH/config

	#Silver LLVM
	echo 0x17b784a0 12 > $DCC_PATH/config
	echo 0x17b78520 > $DCC_PATH/config
	echo 0x17b78588 > $DCC_PATH/config
	echo 0x17b78d90 8 > $DCC_PATH/config
	echo 0x17b79010 6 > $DCC_PATH/config
	echo 0x17b79090 6 > $DCC_PATH/config
	echo 0x17b79a90 4 > $DCC_PATH/config

	# Central Broadcast
	echo 0xec80010 > $DCC_PATH/config
	echo 0xec81000 > $DCC_PATH/config
}

config_sdxpinn_dcc_core()
{
	# CORE_HANG_THRESHOLD
	echo 0x17800058 > $DCC_PATH/config
	echo 0x17810058 > $DCC_PATH/config
	echo 0x17820058 > $DCC_PATH/config
	echo 0x17830058 > $DCC_PATH/config
	# CORE_HANG_VALUE
	echo 0x1780005c > $DCC_PATH/config
	echo 0x1781005c > $DCC_PATH/config
	echo 0x1782005c > $DCC_PATH/config
	echo 0x1783005c > $DCC_PATH/config
	#first core hang
	echo 0x1740003c > $DCC_PATH/config
	# CORE_HANG_CONFIG
	echo 0x17800060 > $DCC_PATH/config
	echo 0x17810060 > $DCC_PATH/config
	echo 0x17820060 > $DCC_PATH/config
	echo 0x17830060 > $DCC_PATH/config
	#CORE_HANG_DBG_STS
	echo 0x17800064 > $DCC_PATH/config
	echo 0x17810064 > $DCC_PATH/config
	echo 0x17820064 > $DCC_PATH/config
	echo 0x17830064 > $DCC_PATH/config

	#MIBU Debug registers
	echo 0x17600238 > $DCC_PATH/config

	#GNOC Hang counters
	echo 0x17600404 > $DCC_PATH/config
	echo 0x1760041c 2 > $DCC_PATH/config
	echo 0x17600434 > $DCC_PATH/config
	echo 0x1760043c 2 > $DCC_PATH/config

	#CPRh
	echo 0x17900908 > $DCC_PATH/config
	echo 0x17900c18 > $DCC_PATH/config

	# pll status for all banks and all domains
	# silver PLL
	echo 0x17a80000 0x8007 > $DCC_PATH/config_write
	echo 0x17a80000 > $DCC_PATH/config
	echo 0x17a80028 0x0 > $DCC_PATH/config_write
	echo 0x17a80028 > $DCC_PATH/config
	echo 0x17a80024 0x0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x40 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x80 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0xc0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x100 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x140 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x180 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x1c0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x200 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x240 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x280 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x2c0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x300 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x340 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x380 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x3c0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x4000 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a80024 0x0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a80024 0x0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a80024 0x0 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config
	echo 0x17a80024 0x40 > $DCC_PATH/config_write
	echo 0x17a80024 > $DCC_PATH/config
	echo 0x17a8003c > $DCC_PATH/config

	# L3 pll
	echo 0x17a84000 0x8007 > $DCC_PATH/config_write
	echo 0x17a84000 > $DCC_PATH/config
	echo 0x17a84018 0x0 > $DCC_PATH/config_write
	echo 0x17a84018 > $DCC_PATH/config
	echo 0x17a84014 0x0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x40 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x80 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0xc0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x100 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x140 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x180 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x1c0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x200 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x240 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x280 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x2c0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x300 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x340 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x380 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x3c0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84018 0x4000 > $DCC_PATH/config_write
	echo 0x17a84018 > $DCC_PATH/config
	echo 0x17a84014 0x0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a84014 0x0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a84014 0x0 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config
	echo 0x17a84014 0x40 > $DCC_PATH/config_write
	echo 0x17a84014 > $DCC_PATH/config
	echo 0x17a8403c > $DCC_PATH/config

	#rpmh
	echo 0xc201244 > $DCC_PATH/config
	echo 0xc202244 > $DCC_PATH/config

	#L3-ACD
	echo 0x17a94030 > $DCC_PATH/config
	echo 0x17a9408c > $DCC_PATH/config
	echo 0x17a9409c 0x78 > $DCC_PATH/config_write
	echo 0x17a9409c 0x0  > $DCC_PATH/config_write
	echo 0x17a94048 0x1  > $DCC_PATH/config_write
	echo 0x17a94090 0x0  > $DCC_PATH/config_write
	echo 0x17a94090 0x25 > $DCC_PATH/config_write
	echo 0x17a94098 > $DCC_PATH/config
	echo 0x17a94048 0x1D > $DCC_PATH/config_write
	echo 0x17a94090 0x0  > $DCC_PATH/config_write
	echo 0x17a94090 0x25 > $DCC_PATH/config_write
	echo 0x17a94098 > $DCC_PATH/config

	#SILVER-ACD
	echo 0x17a90030 > $DCC_PATH/config
	echo 0x17a9008c > $DCC_PATH/config
	echo 0x17a9009c 0x78 > $DCC_PATH/config_write
	echo 0x17a9009c 0x0  > $DCC_PATH/config_write
	echo 0x17a90048 0x1  > $DCC_PATH/config_write
	echo 0x17a90090 0x0  > $DCC_PATH/config_write
	echo 0x17a90090 0x25 > $DCC_PATH/config_write
	echo 0x17a90098 > $DCC_PATH/config
	echo 0x17a90048 0x1D > $DCC_PATH/config_write
	echo 0x17a90090 0x0  > $DCC_PATH/config_write
	echo 0x17a90090 0x25 > $DCC_PATH/config_write
	echo 0x17a90098 > $DCC_PATH/config

	echo 0x17ba0000 6 > $DCC_PATH/config
	echo 0x17ba0020 5 > $DCC_PATH/config
	echo 0x17ba0050 > $DCC_PATH/config
	echo 0x17ba0070 > $DCC_PATH/config
	echo 0x17ba0080 25 > $DCC_PATH/config
	echo 0x17ba0100 > $DCC_PATH/config
	echo 0x17ba0120 > $DCC_PATH/config
	echo 0x17ba0140 > $DCC_PATH/config
	echo 0x17ba0200 6 > $DCC_PATH/config
	echo 0x17ba0700 > $DCC_PATH/config
	echo 0x17ba070c 3 > $DCC_PATH/config
	echo 0x17ba0780 32 > $DCC_PATH/config
	echo 0x17ba0808 > $DCC_PATH/config
	echo 0x17ba0c48 > $DCC_PATH/config
	echo 0x17ba080c > $DCC_PATH/config
	echo 0x17ba0c4c > $DCC_PATH/config
	echo 0x17ba0810 > $DCC_PATH/config
	echo 0x17ba0c50 > $DCC_PATH/config
	echo 0x17ba0814 > $DCC_PATH/config
	echo 0x17ba0c54 > $DCC_PATH/config
	echo 0x17ba0818 > $DCC_PATH/config
	echo 0x17ba0c58 > $DCC_PATH/config
	echo 0x17ba081c > $DCC_PATH/config
	echo 0x17ba0c5c > $DCC_PATH/config
	echo 0x17ba0824 > $DCC_PATH/config
	echo 0x17ba0c64 > $DCC_PATH/config
	echo 0x17ba0828 > $DCC_PATH/config
	echo 0x17ba0c68 > $DCC_PATH/config
	echo 0x17ba082c > $DCC_PATH/config
	echo 0x17ba0c6c > $DCC_PATH/config
	echo 0x17ba0840 > $DCC_PATH/config
	echo 0x17ba0c80 > $DCC_PATH/config
	echo 0x17ba0844 > $DCC_PATH/config
	echo 0x17ba0c84 > $DCC_PATH/config
	echo 0x17ba0848 > $DCC_PATH/config
	echo 0x17ba0c88 > $DCC_PATH/config
	echo 0x17ba084c > $DCC_PATH/config
	echo 0x17ba0c8c > $DCC_PATH/config
	echo 0x17ba0850 > $DCC_PATH/config
	echo 0x17ba0c90 > $DCC_PATH/config
	echo 0x17ba0854 > $DCC_PATH/config
	echo 0x17ba0c94 > $DCC_PATH/config
	echo 0x17ba0858 > $DCC_PATH/config
	echo 0x17ba0c98 > $DCC_PATH/config
	echo 0x17ba085c > $DCC_PATH/config
	echo 0x17ba0c9c > $DCC_PATH/config
	echo 0x17ba0860 > $DCC_PATH/config
	echo 0x17ba0ca0 > $DCC_PATH/config
	echo 0x17ba0864 > $DCC_PATH/config
	echo 0x17ba0ca4 > $DCC_PATH/config
	echo 0x17ba0868 > $DCC_PATH/config
	echo 0x17ba0ca8 > $DCC_PATH/config
	echo 0x17ba086c > $DCC_PATH/config
	echo 0x17ba0cac > $DCC_PATH/config
	echo 0x17ba0870 > $DCC_PATH/config
	echo 0x17ba0cb0 > $DCC_PATH/config
	echo 0x17ba0874 > $DCC_PATH/config
	echo 0x17ba0cb4 > $DCC_PATH/config
	echo 0x17ba0878 > $DCC_PATH/config
	echo 0x17ba0cb8 > $DCC_PATH/config
	echo 0x17ba087c > $DCC_PATH/config
	echo 0x17ba0cbc > $DCC_PATH/config
	echo 0x17ba3500 80 > $DCC_PATH/config
	echo 0x17ba3a00 3 > $DCC_PATH/config
	echo 0x17ba3aa8 18 > $DCC_PATH/config
	echo 0x17ba3b00 2 > $DCC_PATH/config
	echo 0x17ba3b20 3 > $DCC_PATH/config
	echo 0x17ba3b30 11 > $DCC_PATH/config
	echo 0x17ba3b64 > $DCC_PATH/config
	echo 0x17ba3b00 2 > $DCC_PATH/config
	echo 0x17ba3b20 3 > $DCC_PATH/config
	echo 0x17ba3b30 11 > $DCC_PATH/config
	echo 0x17ba3b70 2 > $DCC_PATH/config

	#APM
	echo 0x17b00000 70 > $DCC_PATH/config
}

config_sdxpinn_dcc_lpm_pcu()
{
	#PCU -DCC for LPM path
	#Read only registers
	#core#0
	echo 0x17800010 > $DCC_PATH/config
	echo 0x17800024 > $DCC_PATH/config
	echo 0x17800038 6 > $DCC_PATH/config
	echo 0x1780006c > $DCC_PATH/config
	echo 0x178000f0 2 > $DCC_PATH/config
	# core#1
	echo 0x17810010 > $DCC_PATH/config
	echo 0x17810024 > $DCC_PATH/config
	echo 0x17810038 6 > $DCC_PATH/config
	echo 0x1781006c > $DCC_PATH/config
	echo 0x178100f0 2 > $DCC_PATH/config
	# core#2
	echo 0x17820010 > $DCC_PATH/config
	echo 0x17820024 > $DCC_PATH/config
	echo 0x17820038 6 > $DCC_PATH/config
	echo 0x1782006c > $DCC_PATH/config
	echo 0x178200f0 2 > $DCC_PATH/config
	# core#3
	echo 0x17830010 > $DCC_PATH/config
	echo 0x17830024 > $DCC_PATH/config
	echo 0x17830038 6 > $DCC_PATH/config
	echo 0x1783006c > $DCC_PATH/config
	echo 0x178300f0 2 > $DCC_PATH/config
	# L3
	echo 0x17880010 > $DCC_PATH/config
	echo 0x17880024 > $DCC_PATH/config
	echo 0x17880038 3 > $DCC_PATH/config
	#APPS CL
	echo 0x17880044 3 > $DCC_PATH/config
	echo 0x1788006c 5 > $DCC_PATH/config
	# APSS_BOOTFSM_STS
	echo 0x17880084 > $DCC_PATH/config
	# APSS_SILVER_PLL
	echo 0x178800f4 5 > $DCC_PATH/config
	# APSS_ITM_SILVER
	echo 0x17880134 2 > $DCC_PATH/config
	# APSS_SILVER_PWR_CTL_STS
	echo 0x178801b4 > $DCC_PATH/config
	# APSS_CL_PCU_PWR_CTL_STS
	echo 0x178801bc 2 > $DCC_PATH/config
	echo 0x178801c8 > $DCC_PATH/config
}

config_sdxpinn_dcc_apss_rscc()
{
	#APSS_RSCC
	echo 0x17A20000 > $DCC_PATH/config
	echo 0x17A00004 > $DCC_PATH/config
	echo 0x17A20004 > $DCC_PATH/config
	echo 0x17A10004 > $DCC_PATH/config
	echo 0x17A00008 > $DCC_PATH/config
	echo 0x17A10008 > $DCC_PATH/config
	echo 0x17A20008 > $DCC_PATH/config
	echo 0x17A00010 > $DCC_PATH/config
	echo 0x17A10010 > $DCC_PATH/config
	echo 0x17A20010 > $DCC_PATH/config
	echo 0x17A00014 > $DCC_PATH/config
	echo 0x17A10014 > $DCC_PATH/config
	echo 0x17A20014 > $DCC_PATH/config
	echo 0x17A00018 > $DCC_PATH/config
	echo 0x17A10018 > $DCC_PATH/config
	echo 0x17A20018 > $DCC_PATH/config
	echo 0x17A0000C > $DCC_PATH/config
	echo 0x17A1000C > $DCC_PATH/config
	echo 0x17A2000C > $DCC_PATH/config
	echo 0x17A0001C > $DCC_PATH/config
	echo 0x17A00020 > $DCC_PATH/config
	echo 0x17A00024 > $DCC_PATH/config
	echo 0x17A00028 > $DCC_PATH/config
	echo 0x17A00030 > $DCC_PATH/config
	echo 0x17A10030 > $DCC_PATH/config
	echo 0x17A20030 > $DCC_PATH/config
	echo 0x17A20034 > $DCC_PATH/config
	echo 0x17A20038 > $DCC_PATH/config
	echo 0x17A2003C > $DCC_PATH/config
	echo 0x17A20040 > $DCC_PATH/config
	echo 0x17A20044 > $DCC_PATH/config
	echo 0x17A00048 > $DCC_PATH/config
	echo 0x17A0004C > $DCC_PATH/config
	echo 0x17A000D0 > $DCC_PATH/config
	echo 0x17A000D4 > $DCC_PATH/config
	echo 0x17A000D8 > $DCC_PATH/config
	echo 0x17A00104 > $DCC_PATH/config
	echo 0x17A0010C > $DCC_PATH/config
	echo 0x17A00110 > $DCC_PATH/config
	echo 0x17A20204 > $DCC_PATH/config
	echo 0x17A20224 > $DCC_PATH/config
	echo 0x17A20244 > $DCC_PATH/config
	echo 0x17A20264 > $DCC_PATH/config
	echo 0x17A20284 > $DCC_PATH/config
	echo 0x17A20208 > $DCC_PATH/config
	echo 0x17A20228 > $DCC_PATH/config
	echo 0x17A20248 > $DCC_PATH/config
	echo 0x17A20268 > $DCC_PATH/config
	echo 0x17A20288 > $DCC_PATH/config
	echo 0x17A2020C > $DCC_PATH/config
	echo 0x17A2022C > $DCC_PATH/config
	echo 0x17A2024C > $DCC_PATH/config
	echo 0x17A2026C > $DCC_PATH/config
	echo 0x17A2028C > $DCC_PATH/config
	echo 0x17A00404 > $DCC_PATH/config
	echo 0x17A00408 > $DCC_PATH/config
	echo 0x17A2001C > $DCC_PATH/config
	echo 0x17A20020 > $DCC_PATH/config
	echo 0x17A20024 > $DCC_PATH/config
	echo 0x17A20028 > $DCC_PATH/config
	echo 0x17A20048 > $DCC_PATH/config
	echo 0x17A20400 > $DCC_PATH/config
	echo 0x17A20404 > $DCC_PATH/config
	echo 0x17A20408 > $DCC_PATH/config
	echo 0x17A20460 > $DCC_PATH/config
	echo 0x17A20464 > $DCC_PATH/config
	echo 0x17A20D00 > $DCC_PATH/config
	echo 0x17A20D04 > $DCC_PATH/config
	echo 0x17A20D08 > $DCC_PATH/config
	echo 0x17A20D10 > $DCC_PATH/config
	echo 0x17A20D20 > $DCC_PATH/config
	echo 0x17A20D28 > $DCC_PATH/config
	echo 0x17A20D2C > $DCC_PATH/config
	echo 0x17A20D30 > $DCC_PATH/config
	echo 0x17A20D40 > $DCC_PATH/config
}

config_sdxpinn_dcc_epss()
{
	echo 0x17d80100 144 > $DCC_PATH/config
	# EPSSSLOW_CLKDOM0
	echo 0x17d9001c > $DCC_PATH/config
	echo 0x17d900dc > $DCC_PATH/config
	echo 0x17d900e8 > $DCC_PATH/config
	echo 0x17d90320 > $DCC_PATH/config
	echo 0x17d90020 > $DCC_PATH/config
	echo 0x17d9034c > $DCC_PATH/config
	echo 0x17d90300 > $DCC_PATH/config
	# EPSSSLOW_CLKDOM1
	echo 0x17d9101c > $DCC_PATH/config
	echo 0x17d910dc > $DCC_PATH/config
	echo 0x17d910e8 > $DCC_PATH/config
	echo 0x17d91320 > $DCC_PATH/config
	echo 0x17d91020 > $DCC_PATH/config
	echo 0x17d9134c > $DCC_PATH/config
	echo 0x17d91300 > $DCC_PATH/config

	echo 0x26822000 2 > $DCC_PATH/config
	echo 0x26824c00 > $DCC_PATH/config
	echo 0x26824d04 2 > $DCC_PATH/config
	echo 0x17d98014 4 > $DCC_PATH/config
	echo 0x17d900e0 > $DCC_PATH/config
	echo 0x17d90410 > $DCC_PATH/config
	echo 0x17d90074 > $DCC_PATH/config
	echo 0x17d90064 > $DCC_PATH/config
	echo 0x17d91074 > $DCC_PATH/config
	echo 0x17d910e0 > $DCC_PATH/config
	echo 0x17d91410 > $DCC_PATH/config
}

config_sdxpinn_dcc_misc()
{
	#WDOG_BITE_INT0_CONFIG
	echo 0x17400038 > $DCC_PATH/config
	#EPSSTOP_MUC_HANG_DET_CTRL
	echo 0x17d98010 > $DCC_PATH/config
	#SOC_HW_VERSION
	echo 0x1fc8000 > $DCC_PATH/config
}

config_sdxpinn_dcc_gemnoc()
{
	#LLC0
	echo 0x19127010 > $DCC_PATH/config
	echo 0x19127018 > $DCC_PATH/config
	echo 0x19127020 > $DCC_PATH/config
	echo 0x19127024 > $DCC_PATH/config
	echo 0x19127028 > $DCC_PATH/config
	echo 0x1912702C > $DCC_PATH/config
	echo 0x19127030 > $DCC_PATH/config
	echo 0x19127034 > $DCC_PATH/config

	#CNOC
	echo 0x19127410 > $DCC_PATH/config
	echo 0x19127418 > $DCC_PATH/config
	echo 0x19127420 > $DCC_PATH/config
	echo 0x19127424 > $DCC_PATH/config
	echo 0x19127428 > $DCC_PATH/config
	echo 0x1912742C > $DCC_PATH/config
	echo 0x19127430 > $DCC_PATH/config
	echo 0x19127434 > $DCC_PATH/config

	#PCIe
	echo 0x19127810 > $DCC_PATH/config
	echo 0x19127818 > $DCC_PATH/config
	echo 0x19127820 > $DCC_PATH/config
	echo 0x19127824 > $DCC_PATH/config
	echo 0x19127828 > $DCC_PATH/config
	echo 0x1912782C > $DCC_PATH/config
	echo 0x19127830 > $DCC_PATH/config
	echo 0x19127834 > $DCC_PATH/config

	echo 0x19128048 > $DCC_PATH/config
	echo 0x1912804C > $DCC_PATH/config
}

config_sdxpinn_dcc_ddr()
{
	#SHRM CSR
	echo 0x1908e008 > $DCC_PATH/config
	#MCCC
	echo 0x190ba280 > $DCC_PATH/config
	echo 0x19460610 > $DCC_PATH/config
	echo 0x190ba288 8 > $DCC_PATH/config
	echo 0x19460614 3 > $DCC_PATH/config
	#LLCC/CABO
	echo 0x19238100 > $DCC_PATH/config
	echo 0x192420b0 > $DCC_PATH/config
	echo 0x19242044 4 > $DCC_PATH/config
	echo 0x19250020 > $DCC_PATH/config
	echo 0x1926005c 5 > $DCC_PATH/config
	#PHY
	echo 0x194056d4 4 > $DCC_PATH/config
	echo 0x19401b1c 3 > $DCC_PATH/config
	echo 0x19403b1c 3 > $DCC_PATH/config
	echo 0x19405188 3 > $DCC_PATH/config
	echo 0x19401db4 > $DCC_PATH/config
	echo 0x19401dbc > $DCC_PATH/config
	echo 0x19401dc4 > $DCC_PATH/config
	echo 0x19403db4 > $DCC_PATH/config
	echo 0x19403dbc > $DCC_PATH/config
	echo 0x19403dc4 > $DCC_PATH/config
	echo 0x1940583c > $DCC_PATH/config
	echo 0x1940581c > $DCC_PATH/config
	echo 0x194057fc > $DCC_PATH/config
	echo 0x19405830 > $DCC_PATH/config
	echo 0x19405840 > $DCC_PATH/config
	echo 0x19405848 > $DCC_PATH/config
	echo 0x19405810 > $DCC_PATH/config
	echo 0x19405258 > $DCC_PATH/config
	echo 0x19401f20 2 > $DCC_PATH/config
	echo 0x19401e6c > $DCC_PATH/config
	echo 0x19403e6c > $DCC_PATH/config

	#SHRM
	echo 0x19032020 2 > $DCC_PATH/config
	echo 0x1908e01c > $DCC_PATH/config
	echo 0x1908e030 > $DCC_PATH/config
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1908e008 > $DCC_PATH/config
	echo 0x19032020 > $DCC_PATH/config
	echo 0x1908e948 > $DCC_PATH/config
	echo 0x19032024 > $DCC_PATH/config
	echo 0x19030040 0x1 > $DCC_PATH/config_write
	echo 0x1903005c 0x22C000 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C001 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C002 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C003 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C004 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C005 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C006 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C007 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C008 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C009 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00A > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00B > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00C > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00D > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00E > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00F > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C010 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C011 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C012 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C013 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C014 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C015 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C016 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C017 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C018 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C019 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01A > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01B > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01C > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01D > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01E > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01F > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C300 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C341 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C7B1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config

	#LLCC
	echo 0x19220344 9 > $DCC_PATH/config
	echo 0x19220370 7 > $DCC_PATH/config
	echo 0x19220480 > $DCC_PATH/config
	echo 0x19222400 26 > $DCC_PATH/config
	echo 0x19222470 5 > $DCC_PATH/config
	echo 0x1922320c > $DCC_PATH/config
	echo 0x19223214 2 > $DCC_PATH/config
	echo 0x19223308 > $DCC_PATH/config
	echo 0x19223318 > $DCC_PATH/config
	echo 0x19223318 > $DCC_PATH/config
	echo 0x1922358c > $DCC_PATH/config
	echo 0x19234010 > $DCC_PATH/config
	echo 0x1923801c 8 > $DCC_PATH/config
	echo 0x19238050 > $DCC_PATH/config
	echo 0x19238100 > $DCC_PATH/config
	echo 0x19238100 7 > $DCC_PATH/config
	echo 0x1923c004 > $DCC_PATH/config
	echo 0x1923c014 > $DCC_PATH/config
	echo 0x1923c020 > $DCC_PATH/config
	echo 0x1923c030 > $DCC_PATH/config
	echo 0x1923c05c 3 > $DCC_PATH/config
	echo 0x1923c074 > $DCC_PATH/config
	echo 0x1923c088 > $DCC_PATH/config
	echo 0x1923c0a0 > $DCC_PATH/config
	echo 0x1923c0b0 > $DCC_PATH/config
	echo 0x1923c0c0 > $DCC_PATH/config
	echo 0x1923c0d0 > $DCC_PATH/config
	echo 0x1923c0e0 > $DCC_PATH/config
	echo 0x1923c0f0 > $DCC_PATH/config
	echo 0x1923c100 > $DCC_PATH/config
	echo 0x1923d064 > $DCC_PATH/config
	echo 0x19240008 6 > $DCC_PATH/config
	echo 0x19240028 > $DCC_PATH/config
	echo 0x1924203c 3 > $DCC_PATH/config
	echo 0x19242044 2 > $DCC_PATH/config
	echo 0x19242048 2 > $DCC_PATH/config
	echo 0x1924204c 10 > $DCC_PATH/config
	echo 0x1924208c > $DCC_PATH/config
	echo 0x192420b0 > $DCC_PATH/config
	echo 0x192420b0 > $DCC_PATH/config
	echo 0x192420b8 3 > $DCC_PATH/config
	echo 0x192420f4 > $DCC_PATH/config
	echo 0x192420fc 3 > $DCC_PATH/config
	echo 0x19242104 5 > $DCC_PATH/config
	echo 0x19242114 > $DCC_PATH/config
	echo 0x19242324 14 > $DCC_PATH/config
	echo 0x19242410 > $DCC_PATH/config
	echo 0x192430a8 > $DCC_PATH/config
	echo 0x19248004 7 > $DCC_PATH/config
	echo 0x19248024 > $DCC_PATH/config
	echo 0x19248040 > $DCC_PATH/config
	echo 0x19248048 > $DCC_PATH/config
	echo 0x19249064 > $DCC_PATH/config
	echo 0x1924c000 > $DCC_PATH/config
	echo 0x1924c048 > $DCC_PATH/config
	echo 0x1924c054 2 > $DCC_PATH/config
	echo 0x1924c078 > $DCC_PATH/config
	echo 0x1924c108 > $DCC_PATH/config
	echo 0x19250020 > $DCC_PATH/config
	echo 0x19250020 > $DCC_PATH/config
	echo 0x19251054 > $DCC_PATH/config
	echo 0x19252014 3 > $DCC_PATH/config
	echo 0x19252030 15 > $DCC_PATH/config
	echo 0x19252070 8 > $DCC_PATH/config
	echo 0x192520a0 > $DCC_PATH/config
	echo 0x192520d0 3 > $DCC_PATH/config
	echo 0x192520f4 10 > $DCC_PATH/config
	echo 0x19252120 12 > $DCC_PATH/config
	echo 0x1926004c > $DCC_PATH/config
	echo 0x1926004c 2 > $DCC_PATH/config
	echo 0x19260050 2 > $DCC_PATH/config
	echo 0x19260054 2 > $DCC_PATH/config
	echo 0x19260058 2 > $DCC_PATH/config
	echo 0x1926005c 2 > $DCC_PATH/config
	echo 0x19260060 2 > $DCC_PATH/config
	echo 0x19260064 2 > $DCC_PATH/config
	echo 0x19260068 3 > $DCC_PATH/config
	echo 0x19260078 > $DCC_PATH/config
	echo 0x1926020c > $DCC_PATH/config
	echo 0x19260214 > $DCC_PATH/config
	echo 0x19261084 > $DCC_PATH/config
	echo 0x19262020 > $DCC_PATH/config
	echo 0x19263020 > $DCC_PATH/config
	echo 0x19264020 > $DCC_PATH/config
	echo 0x19265020 > $DCC_PATH/config
	echo 0x19200004 > $DCC_PATH/config
	echo 0x19201004 > $DCC_PATH/config
	echo 0x19202004 > $DCC_PATH/config
	echo 0x19203004 > $DCC_PATH/config
	echo 0x19204004 > $DCC_PATH/config
	echo 0x19205004 > $DCC_PATH/config
	echo 0x19206004 > $DCC_PATH/config
	echo 0x19207004 > $DCC_PATH/config
	echo 0x19208004 > $DCC_PATH/config
	echo 0x19209004 > $DCC_PATH/config
	echo 0x1920a004 > $DCC_PATH/config
	echo 0x1920b004 > $DCC_PATH/config
	echo 0x1920c004 > $DCC_PATH/config
	echo 0x1920d004 > $DCC_PATH/config
	echo 0x1920e004 > $DCC_PATH/config
	echo 0x1920f004 > $DCC_PATH/config
	echo 0x19210004 > $DCC_PATH/config
	echo 0x19211004 > $DCC_PATH/config
	echo 0x19212004 > $DCC_PATH/config
	echo 0x19213004 > $DCC_PATH/config
	echo 0x19214004 > $DCC_PATH/config
	echo 0x19215004 > $DCC_PATH/config
	echo 0x19216004 > $DCC_PATH/config
	echo 0x19217004 > $DCC_PATH/config
	echo 0x19218004 > $DCC_PATH/config
	echo 0x19219004 > $DCC_PATH/config
	echo 0x1921a004 > $DCC_PATH/config
	echo 0x1921b004 > $DCC_PATH/config
	echo 0x1921c004 > $DCC_PATH/config
	echo 0x1921d004 > $DCC_PATH/config
	echo 0x1921e004 > $DCC_PATH/config
	echo 0x1921f004 > $DCC_PATH/config

	#MCCC
	echo 0x190ba280 > $DCC_PATH/config
	echo 0x190ba288 8 > $DCC_PATH/config
	echo 0x19460610 4 > $DCC_PATH/config
	echo 0x19460680 4 > $DCC_PATH/config

	#DDRPHY
	echo 0x19401e64 > $DCC_PATH/config
	echo 0x19401ea0 > $DCC_PATH/config
	echo 0x19401f30 2 > $DCC_PATH/config
	echo 0x19403e64 > $DCC_PATH/config
	echo 0x19403ea0 > $DCC_PATH/config
	echo 0x19403f30 2 > $DCC_PATH/config
	echo 0x1940527c > $DCC_PATH/config
	echo 0x19405290 > $DCC_PATH/config
	echo 0x194054ec > $DCC_PATH/config
	echo 0x194054f4 > $DCC_PATH/config
	echo 0x19405514 > $DCC_PATH/config
	echo 0x1940551c > $DCC_PATH/config
	echo 0x19405524 > $DCC_PATH/config
	echo 0x19405548 > $DCC_PATH/config
	echo 0x19405550 > $DCC_PATH/config
	echo 0x19405558 > $DCC_PATH/config
	echo 0x194055b8 > $DCC_PATH/config
	echo 0x194055c0 > $DCC_PATH/config
	echo 0x194055ec > $DCC_PATH/config
	echo 0x19405860 > $DCC_PATH/config
	echo 0x19405870 > $DCC_PATH/config
	echo 0x194058a0 > $DCC_PATH/config
	echo 0x194058a8 > $DCC_PATH/config
	echo 0x194058b0 > $DCC_PATH/config
	echo 0x194058b8 > $DCC_PATH/config
	echo 0x194058d8 2 > $DCC_PATH/config
	echo 0x194058f4 > $DCC_PATH/config
	echo 0x194058fc > $DCC_PATH/config
	echo 0x19405920 > $DCC_PATH/config
	echo 0x19405928 > $DCC_PATH/config
	echo 0x19405944 > $DCC_PATH/config
	echo 0x19406604 > $DCC_PATH/config
	echo 0x1940660c > $DCC_PATH/config

	#SHRM2
	echo 0x19032020 2 > $DCC_PATH/config
	echo 0x1908e01c > $DCC_PATH/config
	echo 0x1908e030 > $DCC_PATH/config
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1908e008 > $DCC_PATH/config
	echo 0x19032020 > $DCC_PATH/config
	echo 0x1908e948 > $DCC_PATH/config
	echo 0x19032024 > $DCC_PATH/config

	echo 0x19030040 0x1 1 > $DCC_PATH/config_write
	echo 0x1903005c 0x22C000 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config

	echo 0x1903005c 0x22C001 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C002 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C003 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C004 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C005 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C006 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C007 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C008 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C009 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00A 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00B 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00C 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00D 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00E 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C00F 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C010 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C011 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C012 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C013 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C014 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C015 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C016 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C017 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C018 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C019 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01A 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01B 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01C 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01D 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01E 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C01F 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C300 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C341 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
	echo 0x1903005c 0x22C7B1 1 > $DCC_PATH/config_write
	echo 0x19030010 > $DCC_PATH/config
}

config_sdxpinn_dcc_gic()
{
	#GIC
	echo 0x17200104 29 > $DCC_PATH/config
	echo 0x17200204 29 > $DCC_PATH/config
	echo 0x17200384 29 > $DCC_PATH/config
}

config_sdxpinn_dcc_smmu()
{
	#SMMU
	echo 0x150025dc > $DCC_PATH/config
	echo 0x150055dc > $DCC_PATH/config
	echo 0x150075dc > $DCC_PATH/config
	echo 0x150075dc > $DCC_PATH/config
	echo 0x15002204 > $DCC_PATH/config
	echo 0x15002670 > $DCC_PATH/config
	echo 0x150022fc 3 > $DCC_PATH/config
	echo 0x150022fc > $DCC_PATH/config
	echo 0x15002304 > $DCC_PATH/config
}

config_sdxpinn_dcc_snoc()
{
	#errlog
	echo 0x1640008 > $DCC_PATH/config
	echo 0x1640010 > $DCC_PATH/config
	echo 0x1640018 > $DCC_PATH/config
	echo 0x1640020 > $DCC_PATH/config
	echo 0x1640024 > $DCC_PATH/config
	echo 0x1640028 > $DCC_PATH/config
	echo 0x164002C > $DCC_PATH/config
	echo 0x1640030 > $DCC_PATH/config
	echo 0x1640034 > $DCC_PATH/config
	echo 0x1640038 > $DCC_PATH/config
	echo 0x164003C > $DCC_PATH/config
	#faultin
	echo 0x1640240 > $DCC_PATH/config
	echo 0x1640248 > $DCC_PATH/config
	echo 0x1644040 > $DCC_PATH/config
	echo 0x1644044 > $DCC_PATH/config
	echo 0x1644048 > $DCC_PATH/config
	echo 0x164404C > $DCC_PATH/config
	echo 0x1644050 > $DCC_PATH/config
	echo 0x1644054 > $DCC_PATH/config
	echo 0x1644058 > $DCC_PATH/config
	echo 0x164405C > $DCC_PATH/config
	#qosgen
	echo 0x1656010 > $DCC_PATH/config
	echo 0x166F010 > $DCC_PATH/config
	echo 0x1672010 > $DCC_PATH/config
	echo 0x1675010 > $DCC_PATH/config
	echo 0x1678010 > $DCC_PATH/config
	echo 0x1679010 > $DCC_PATH/config
	echo 0x167A010 > $DCC_PATH/config
	echo 0x167B010 > $DCC_PATH/config
	echo 0x167C010 > $DCC_PATH/config
	echo 0x167D010 > $DCC_PATH/config
	echo 0x167E010 > $DCC_PATH/config
	#debugchain
	echo 0x1641008 > $DCC_PATH/config
	echo 0x1A  > $DCC_PATH/loop
	echo 0x1641010 > $DCC_PATH/config
	echo 0x1641014 > $DCC_PATH/config
	echo 0x1  > $DCC_PATH/loop
	echo 0x1641018 > $DCC_PATH/config

	echo 0x1641088 > $DCC_PATH/config
	echo 0x5  > $DCC_PATH/loop
	echo 0x1641090 > $DCC_PATH/config
	echo 0x1641094 > $DCC_PATH/config
	echo 0x1  > $DCC_PATH/loop
	echo 0x1641098 > $DCC_PATH/config

	echo 0x1641108 > $DCC_PATH/config
	echo 0x2  > $DCC_PATH/loop
	echo 0x1641110 > $DCC_PATH/config
	echo 0x1641114 > $DCC_PATH/config
	echo 0x1  > $DCC_PATH/loop
	echo 0x1641118 > $DCC_PATH/config
}

config_sdxpinn_dcc_noc_dch_erl()
{
	#DCG_ERL
	echo 0x190E0008 > $DCC_PATH/config
	echo 0x190E0010 > $DCC_PATH/config
	echo 0x190E0018 > $DCC_PATH/config
	echo 0x190E0020 > $DCC_PATH/config
	echo 0x190E0024 > $DCC_PATH/config
	echo 0x190E0028 > $DCC_PATH/config
	echo 0x190E002C > $DCC_PATH/config
	echo 0x190E0030 > $DCC_PATH/config
	echo 0x190E0034 > $DCC_PATH/config
	echo 0x190E0038 > $DCC_PATH/config
	echo 0x190E003C > $DCC_PATH/config

	echo 0x190E0240 > $DCC_PATH/config
	echo 0x190E0248 > $DCC_PATH/config


	echo 0x190E5008 > $DCC_PATH/config
	echo 0x190E5010 > $DCC_PATH/config
	echo 0x190E5014 > $DCC_PATH/config
	echo 0x190E5018 > $DCC_PATH/config
}

enable_SA525M_debug()
{
	echo "++++ $0 -> SA525M target specific debug file" > /dev/kmsg
	echo "++++ $0 -> DCC-Enable START" > /dev/kmsg
	DCC_PATH="/sys/devices/platform/soc/240ff000.dcc_v2"

	if [ ! -d $DCC_PATH ]; then
		 echo "++++ $0 -> Not a debug build. No DCC available" > /dev/kmsg
		 echo "DCC does not exist on this build."
		 return
	fi

	echo 0 > $DCC_PATH/enable
	echo 1 > $DCC_PATH/config_reset
	echo 6 > $DCC_PATH/curr_list
	echo 1 > $DCC_PATH/hw_trig
	echo cap > $DCC_PATH/func_type
	echo sram > $DCC_PATH/data_sink

	config_sdxpinn_dcc_thermal
	config_sdxpinn_dcc_core
	config_sdxpinn_dcc_lpm_pcu
	config_sdxpinn_dcc_rpmh
	config_sdxpinn_dcc_apss_rscc
	config_sdxpinn_dcc_epss
	config_sdxpinn_dcc_misc
	config_sdxpinn_dcc_ddr

	echo 4 > $DCC_PATH/curr_list
	echo 1 > $DCC_PATH/hw_trig
	echo cap > $DCC_PATH/func_type
	echo sram > $DCC_PATH/data_sink

	config_sdxpinn_dcc_gic
	config_sdxpinn_dcc_gemnoc
	config_sdxpinn_dcc_snoc
	config_sdxpinn_dcc_noc_dch_erl
	config_sdxpinn_dcc_smmu
	config_sdxpinn_dcc_bam
	config_sdxpinn_prng
	config_sdxpinn_mss_rscc
	config_sdxpinn_aop_rsc

	echo 1 > $DCC_PATH/enable

	echo "++++ $0 -> DCC-Enable END" > /dev/kmsg

	configure_coresight

	echo "++++ $0 -> ENABLE-FTRACE START" > /dev/kmsg

	create_sa525m_stm_stp_policy

	#bail out if its perf config
	if [ ! -d /sys/module/msm_rtb ] ; then
		echo "++++ $0 -> Not a debug build. No RTB" > /dev/kmsg
		return
	fi

	# bail out if coresight isn't present
	if [ ! -d /sys/bus/coresight ] ; then
		echo "++++ $0 -> Not a debug build. No Coresight" > /dev/kmsg
		return
	fi

	#bail out if ftrace events are not present
	if [ ! -d /sys/kernel/debug/tracing/events ] ; then
		echo "++++ $0 -> Not a debug build. No Tracing events" > /dev/kmsg
		return
	fi

	echo 0x200000 > /sys/bus/coresight/devices/coresight-tmc-etr/buffer_size
	echo 1 > /sys/bus/coresight/devices/coresight-tmc-etr/enable_sink
	echo coresight-stm > /sys/class/stm_source/ftrace/stm_source_link
	echo 1 > /sys/bus/coresight/devices/coresight-stm/enable_source
	echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable

	echo 1 >/sys/bus/coresight/devices/coresight-cti-swao_cti/enable
	echo 0 24 >/sys/bus/coresight/devices/coresight-cti-swao_cti/channels/trigin_attach
	echo 0 1 >/sys/bus/coresight/devices/coresight-cti-swao_cti/channels/trigout_attach

	#IRQs
	echo 1 > /sys/kernel/debug/tracing/events/irq/enable
	echo 1 > /sys/kernel/debug/tracing/events/irq/irq_handler_entry/enable
	echo 1 > /sys/kernel/debug/tracing/events/irq/irq_handler_exit/enable

	#Workqueue
	echo 1 > /sys/kernel/debug/tracing/events/workqueue/enable

	#SoftIRQs
	echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_entry/enable
	echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_exit/enable
	echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_raise/enable

	#Scheduler
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_pi_setprio/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_migrate_task/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
	echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/enable

	#Timer
	echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_entry/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_exit/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_cancel/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_entry/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_exit/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_init/enable
	echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_start/enable

	#usb
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_alloc_request/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_event/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_gadget_generic_cmd/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_complete_trb/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_free_request/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_gadget_giveback/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_ctrl_req/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_gadget_ep_cmd/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_prepare_trb/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_ep_dequeue/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_gadget_ep_disable/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_readl/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_ep_queue/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_gadget_ep_enable/enable
	echo 1 > /sys/kernel/debug/tracing/events/dwc3/dwc3_writel/enable

	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_alloc_request/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_clear_halt/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_dequeue/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_disable/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_enable/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_fifo_flush/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_fifo_status/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_free_request/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_set_halt/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_set_maxpacket_limit/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_ep_set_wedge/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_activate/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_clear_selfpowered/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_connect/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_deactivate/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_disconnect/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_frame_number/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_giveback_request/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_set_remote_wakeup/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_set_selfpowered/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_vbus_connect/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_vbus_disconnect/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_vbus_draw/enable
	echo 1 > /sys/kernel/debug/tracing/events/gadget/usb_gadget_wakeup/enable

	#Hot-plug
	echo 1 > /sys/kernel/debug/tracing/events/cpuhp/enable

	echo 1 > /sys/kernel/debug/tracing/events/power/cpu_frequency/enable
	echo 1 > /sys/kernel/debug/tracing/events/clk/enable
	echo 1 > /sys/kernel/debug/tracing/events/regulator/enable
	echo 1 > /sys/kernel/debug/tracing/events/rpmh/enable

	echo 1 > /sys/kernel/debug/tracing/tracing_on

	echo "++++ $0 -> FTRACE-Enable END" > /dev/kmsg

}
