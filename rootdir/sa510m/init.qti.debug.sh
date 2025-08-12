#! /bin/sh
# Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear

config_sa510m_dcc_thermal()
{
    #Tsense
    echo 0xc222004 > $DCC_PATH/config
    echo 0xc271014 > $DCC_PATH/config
    echo 0xc2710e0 > $DCC_PATH/config
    echo 0xc2710ec > $DCC_PATH/config
    echo 0xc2710a0 16 > $DCC_PATH/config
    echo 0xc2710e8 > $DCC_PATH/config
    echo 0xc27113c > $DCC_PATH/config

    # Central Broadcast
    echo 0xec80010 > $DCC_PATH/config
    echo 0xec81000 > $DCC_PATH/config
    #echo 0xec81010 64 > $DCC_PATH/config
}

config_sa510m_dcc_core()
{
    echo 0x1701102C > $DCC_PATH/config
    echo 0x17010014 > $DCC_PATH/config
    echo 0x17030000 > $DCC_PATH/config
    echo 0x17030004 > $DCC_PATH/config
}

config_sa510m_dcc_gcc()
{
    echo 0x00080000 > $DCC_PATH/config
    echo 0x00080004 > $DCC_PATH/config
    echo 0x00081000 > $DCC_PATH/config
    echo 0x00081004 > $DCC_PATH/config
    echo 0x00082000 > $DCC_PATH/config
    echo 0x00082004 > $DCC_PATH/config
    echo 0x00083000 > $DCC_PATH/config
    echo 0x00083004 > $DCC_PATH/config
    echo 0x00084000 > $DCC_PATH/config
    echo 0x00084004 > $DCC_PATH/config
    echo 0x0C2A0000 > $DCC_PATH/config
    echo 0x0C2A0004 > $DCC_PATH/config
    echo 0x0C2A1000 > $DCC_PATH/config
    echo 0x0C2A1004 > $DCC_PATH/config
    echo 0x000A006C > $DCC_PATH/config
    echo 0x000A1034 > $DCC_PATH/config
    echo 0x000A403C > $DCC_PATH/config
    echo 0x000AD038 > $DCC_PATH/config
    echo 0x000BC02C > $DCC_PATH/config
    echo 0x000BF020 > $DCC_PATH/config
    echo 0x000D804C > $DCC_PATH/config
    echo 0x000D9024 > $DCC_PATH/config
    echo 0x000E1020 > $DCC_PATH/config
    echo 0x000EC018 > $DCC_PATH/config
    echo 0x000EC150 > $DCC_PATH/config
    echo 0x000EC288 > $DCC_PATH/config
    echo 0x000EC3C0 > $DCC_PATH/config
    echo 0x000EC4F8 > $DCC_PATH/config
    echo 0x000A0004 > $DCC_PATH/config
    echo 0x000A0008 > $DCC_PATH/config
    echo 0x000A000C > $DCC_PATH/config
    echo 0x000A0010 > $DCC_PATH/config
    echo 0x000A0014 > $DCC_PATH/config
    echo 0x000A4004 > $DCC_PATH/config
    echo 0x000A4008 > $DCC_PATH/config
    echo 0x000A400C > $DCC_PATH/config
    echo 0x000A4010 > $DCC_PATH/config
    echo 0x000A4014 > $DCC_PATH/config
    echo 0x000A7004 > $DCC_PATH/config
    echo 0x000A7008 > $DCC_PATH/config
    echo 0x000A700C > $DCC_PATH/config
    echo 0x000A7010 > $DCC_PATH/config
    echo 0x000A7014 > $DCC_PATH/config
    echo 0x000D3004 > $DCC_PATH/config
    echo 0x000D3008 > $DCC_PATH/config
    echo 0x000D300C > $DCC_PATH/config
    echo 0x000D3010 > $DCC_PATH/config
    echo 0x000D3014 > $DCC_PATH/config
    echo 0x000D8004 > $DCC_PATH/config
    echo 0x000D8008 > $DCC_PATH/config
    echo 0x000D800C > $DCC_PATH/config
    echo 0x000D8010 > $DCC_PATH/config
    echo 0x000D8014 > $DCC_PATH/config
    echo 0x000F1004 > $DCC_PATH/config
    echo 0x000F1008 > $DCC_PATH/config
    echo 0x000F100C > $DCC_PATH/config
    echo 0x000F1010 > $DCC_PATH/config
    echo 0x000F1014 > $DCC_PATH/config
    echo 0x000E9038 > $DCC_PATH/config
    echo 0x000E903C > $DCC_PATH/config
    echo 0x000E9040 > $DCC_PATH/config
    echo 0x000E9044 > $DCC_PATH/config
    echo 0x000E9048 > $DCC_PATH/config
    echo 0x000E904C > $DCC_PATH/config
    echo 0x000E9058 > $DCC_PATH/config
    echo 0x000E905C > $DCC_PATH/config
    echo 0x000F3000 > $DCC_PATH/config
    echo 0x000F3004 > $DCC_PATH/config
    echo 0x000F3008 > $DCC_PATH/config
    echo 0x000F300C > $DCC_PATH/config
    echo 0x000F3010 > $DCC_PATH/config
    echo 0x000F3014 > $DCC_PATH/config
    echo 0x000F3020 > $DCC_PATH/config
    echo 0x000F3024 > $DCC_PATH/config
    echo 0x000FC000 > $DCC_PATH/config
    echo 0x000FC004 > $DCC_PATH/config
    echo 0x000FC008 > $DCC_PATH/config
    echo 0x000FC00C > $DCC_PATH/config
    echo 0x000FC010 > $DCC_PATH/config
    echo 0x000FC014 > $DCC_PATH/config
    echo 0x000FC020 > $DCC_PATH/config
    echo 0x000FC030 > $DCC_PATH/config
    echo 0x000FD000 > $DCC_PATH/config
    echo 0x000FD004 > $DCC_PATH/config
    echo 0x000FD008 > $DCC_PATH/config
    echo 0x000FD00C > $DCC_PATH/config
    echo 0x000FD010 > $DCC_PATH/config
    echo 0x000FD014 > $DCC_PATH/config
    echo 0x000FD020 > $DCC_PATH/config
    echo 0x000FD024 > $DCC_PATH/config
    echo 0x000FE000 > $DCC_PATH/config
    echo 0x000FE004 > $DCC_PATH/config
    echo 0x000FE008 > $DCC_PATH/config
    echo 0x000FE00C > $DCC_PATH/config
    echo 0x000FE010 > $DCC_PATH/config
    echo 0x000FE014 > $DCC_PATH/config
    echo 0x000FE040 > $DCC_PATH/config
    echo 0x000FE044 > $DCC_PATH/config
    echo 0x000FF000 > $DCC_PATH/config
    echo 0x000FF004 > $DCC_PATH/config
    echo 0x000FF008 > $DCC_PATH/config
    echo 0x000FF00C > $DCC_PATH/config
    echo 0x000FF010 > $DCC_PATH/config
    echo 0x000FF014 > $DCC_PATH/config
    echo 0x000FF050 > $DCC_PATH/config
    echo 0x000FF054 > $DCC_PATH/config
    echo 0x00100000 > $DCC_PATH/config
    echo 0x00100004 > $DCC_PATH/config
    echo 0x00100008 > $DCC_PATH/config
    echo 0x0010000C > $DCC_PATH/config
    echo 0x00100010 > $DCC_PATH/config
    echo 0x00100014 > $DCC_PATH/config
    echo 0x00100060 > $DCC_PATH/config
    echo 0x00100064 > $DCC_PATH/config
    echo 0x00101000 > $DCC_PATH/config
    echo 0x00101004 > $DCC_PATH/config
    echo 0x00101008 > $DCC_PATH/config
    echo 0x0010100C > $DCC_PATH/config
    echo 0x00101010 > $DCC_PATH/config
    echo 0x00101014 > $DCC_PATH/config
    echo 0x00101070 > $DCC_PATH/config
    echo 0x00101074 > $DCC_PATH/config
    echo 0x00102000 > $DCC_PATH/config
    echo 0x00102004 > $DCC_PATH/config
    echo 0x00102008 > $DCC_PATH/config
    echo 0x0010200C > $DCC_PATH/config
    echo 0x00102010 > $DCC_PATH/config
    echo 0x00102014 > $DCC_PATH/config
    echo 0x00102080 > $DCC_PATH/config
    echo 0x00102084 > $DCC_PATH/config
    echo 0x00103000 > $DCC_PATH/config
    echo 0x00103004 > $DCC_PATH/config
    echo 0x00103008 > $DCC_PATH/config
    echo 0x0010300C > $DCC_PATH/config
    echo 0x00103010 > $DCC_PATH/config
    echo 0x00103014 > $DCC_PATH/config
    echo 0x00103090 > $DCC_PATH/config
    echo 0x00103094 > $DCC_PATH/config
    echo 0x000A4018 > $DCC_PATH/config
    echo 0x000A401C > $DCC_PATH/config
}

config_sa510m_dcc_rpmh()
{
    echo 0xb251024 > $DCC_PATH/config
    echo 0xbde1034 > $DCC_PATH/config

    #RPMH_PDC_APSS
    echo 0xb201020 > $DCC_PATH/config
    echo 0xb211020 > $DCC_PATH/config
    echo 0xb221020 > $DCC_PATH/config
    echo 0xb231020 > $DCC_PATH/config
    echo 0xb204520 > $DCC_PATH/config

    echo 0xb200010 > $DCC_PATH/config
    echo 0xB200110 > $DCC_PATH/config
    echo 0xb200900 > $DCC_PATH/config
    echo 0xb201030 > $DCC_PATH/config
    echo 0xB20103C > $DCC_PATH/config
    echo 0xB201200 > $DCC_PATH/config
    echo 0xb201204 > $DCC_PATH/config
    echo 0xB201208 > $DCC_PATH/config
    echo 0xb201218 > $DCC_PATH/config
    echo 0xb20122c > $DCC_PATH/config
    echo 0xb201240 > $DCC_PATH/config
    echo 0xb201254 > $DCC_PATH/config
    echo 0xb204510 > $DCC_PATH/config
    echo 0xb220010 > $DCC_PATH/config
    echo 0xb220900 > $DCC_PATH/config
    echo 0xB204514 > $DCC_PATH/config
    echo 0xB201024 > $DCC_PATH/config

    echo 0xB200000 > $DCC_PATH/config
    echo 0xB220000 > $DCC_PATH/config
}

config_sa510m_dcc_apss_rscc()
{
    echo 0x17040010 > $DCC_PATH/config
    echo 0x17040030 > $DCC_PATH/config
    echo 0x17040034 > $DCC_PATH/config
    echo 0x17040038 > $DCC_PATH/config
    echo 0x1704003C > $DCC_PATH/config
    echo 0x17040040 > $DCC_PATH/config
    echo 0x17040044 > $DCC_PATH/config
    echo 0x17040048 > $DCC_PATH/config
    echo 0x17040400 > $DCC_PATH/config
    echo 0x17040404 > $DCC_PATH/config
    echo 0x17040408 > $DCC_PATH/config
    echo 0x17050048 > $DCC_PATH/config
    echo 0x17050408 > $DCC_PATH/config
}

config_sa510m_dcc_mss_rscc()
{
    echo 0x4130208 > $DCC_PATH/config
    echo 0x4130228 > $DCC_PATH/config
    echo 0x4130248 > $DCC_PATH/config
    echo 0x4130268 > $DCC_PATH/config
    echo 0x4130288 > $DCC_PATH/config
    echo 0x41302A8 > $DCC_PATH/config
    echo 0x413020C > $DCC_PATH/config
    echo 0x413022C > $DCC_PATH/config
    echo 0x413024C > $DCC_PATH/config
    echo 0x413026C > $DCC_PATH/config
    echo 0x413028C > $DCC_PATH/config
    echo 0x41302AC > $DCC_PATH/config
    echo 0x4130210 > $DCC_PATH/config
    echo 0x4130230 > $DCC_PATH/config
    echo 0x4130250 > $DCC_PATH/config
    echo 0x4130270 > $DCC_PATH/config
    echo 0x4130290 > $DCC_PATH/config
    echo 0x41302B0 > $DCC_PATH/config
    echo 0x4130400 > $DCC_PATH/config
    echo 0x4130404 > $DCC_PATH/config
    echo 0x4130408 > $DCC_PATH/config
    echo 0x4200400 > $DCC_PATH/config
    echo 0x4200404 > $DCC_PATH/config
    echo 0x4200408 > $DCC_PATH/config
    echo 0x4082028 > $DCC_PATH/config
    echo 0x4080304 > $DCC_PATH/config
    echo 0x4200210 > $DCC_PATH/config
    echo 0x4200230 > $DCC_PATH/config
    echo 0x4200250 > $DCC_PATH/config
    echo 0x4200270 > $DCC_PATH/config
    echo 0x4200290 > $DCC_PATH/config
    echo 0x42002B0 > $DCC_PATH/config
    echo 0x4200208 > $DCC_PATH/config
    echo 0x4200228 > $DCC_PATH/config
    echo 0x4200248 > $DCC_PATH/config
    echo 0x4200268 > $DCC_PATH/config
    echo 0x4200288 > $DCC_PATH/config
    echo 0x42002A8 > $DCC_PATH/config
    echo 0x420020C > $DCC_PATH/config
    echo 0x420022C > $DCC_PATH/config
    echo 0x420024C > $DCC_PATH/config
    echo 0x420026C > $DCC_PATH/config
    echo 0x420028C > $DCC_PATH/config
    echo 0x42002AC > $DCC_PATH/config
}

config_sa510m_dcc_epss()
{
    echo 0x17180100 144 > $DCC_PATH/config
    # EPSSSLOW_CLKDOM0
    echo 0x1719001c > $DCC_PATH/config
    echo 0x171900dc > $DCC_PATH/config
    echo 0x171900e8 > $DCC_PATH/config
    echo 0x17190320 > $DCC_PATH/config
    echo 0x17190020 > $DCC_PATH/config
    echo 0x1719034c > $DCC_PATH/config
    echo 0x17190300 > $DCC_PATH/config
    # EPSSSLOW_CLKDOM1
    echo 0x1719101c > $DCC_PATH/config
    echo 0x171910dc > $DCC_PATH/config
    echo 0x171910e8 > $DCC_PATH/config
    echo 0x17191320 > $DCC_PATH/config
    echo 0x17191020 > $DCC_PATH/config
    echo 0x1719134c > $DCC_PATH/config
    echo 0x17191300 > $DCC_PATH/config

    echo 0x26012000 2 > $DCC_PATH/config
    echo 0x26014c00 > $DCC_PATH/config
    echo 0x26014d04 2 > $DCC_PATH/config
    echo 0x17198014 4 > $DCC_PATH/config
    echo 0x171900e0 > $DCC_PATH/config
    echo 0x17190410 > $DCC_PATH/config
    echo 0x17190074 > $DCC_PATH/config
    echo 0x17190064 > $DCC_PATH/config
    echo 0x17191074 > $DCC_PATH/config
    echo 0x171910e0 > $DCC_PATH/config
    echo 0x17191410 > $DCC_PATH/config

}

config_sa510m_dcc_misc()
{
    # APSS_WDT_TMR1_WDOG_STATUS
    echo 0x1701700C > $DCC_PATH/config
    # APSS_WDT_TMR2_WDOG_STATUS
    echo 0x1701800C > $DCC_PATH/config
    # AOP_WDOG_STATUS
    echo 0x0B080048 > $DCC_PATH/config
    #WDOG_RESET_REG
    echo 0xC230000 > $DCC_PATH/config
    #WDOG_CTL_REG
    echo 0xC230004 > $DCC_PATH/config
    #WDOG_STATUS_REG
    echo 0xC230008 > $DCC_PATH/config
    #WDOG_BARK_VAL_REG
    echo 0xC23000C > $DCC_PATH/config
    #WDOG_BITE_VAL_REG
    echo 0xC230010 > $DCC_PATH/config
    #WDOG_MSIC_STATUS_REG
    echo 0xC230014 > $DCC_PATH/config
    # EPSSTOP_MUC_HANG_DET_CTRL
    echo 0x17198010 > $DCC_PATH/config
    # EPSSTOP_MUC_HANG_DET_STATUS
    echo 0x17198020 > $DCC_PATH/config
    # SOC_HW_VERSION
    echo 0x1fc8000 > $DCC_PATH/config
}

config_sa510m_dcc_gemnoc()
{
    # mem_noc
    echo 0x19100000 > $DCC_PATH/config
    echo 0x19100004 > $DCC_PATH/config
    echo 0x19100008 > $DCC_PATH/config
    echo 0x19100010 > $DCC_PATH/config
    echo 0x19100018 > $DCC_PATH/config
    echo 0x19100020 > $DCC_PATH/config
    echo 0x19100024 > $DCC_PATH/config
    echo 0x19100028 > $DCC_PATH/config
    echo 0x1910002C > $DCC_PATH/config
    echo 0x19100030 > $DCC_PATH/config
    echo 0x19100034 > $DCC_PATH/config
    echo 0x19100038 > $DCC_PATH/config
    echo 0x1910003C > $DCC_PATH/config
    echo 0x19100248 > $DCC_PATH/config
    echo 0x19101000 > $DCC_PATH/config
    echo 0x19101004 > $DCC_PATH/config

    echo 0x19101008 > $DCC_PATH/config
    echo 0x8 > $DCC_PATH/loop
    echo 0x19101010 > $DCC_PATH/config
    echo 0x19101014 > $DCC_PATH/config
    echo 1 > $DCC_PATH/loop
    echo 0x19125008 > $DCC_PATH/config

    echo 0x19127008 > $DCC_PATH/config
    echo 0x19129008 > $DCC_PATH/config
    echo 0x1912A008 > $DCC_PATH/config
    echo 0x1912B008 > $DCC_PATH/config
    echo 0x1912C008 > $DCC_PATH/config
    echo 0x1912D008 > $DCC_PATH/config

    # snoc_anoc
    echo 0x01640000 > $DCC_PATH/config
    echo 0x01640004 > $DCC_PATH/config
    echo 0x01640008 > $DCC_PATH/config
    echo 0x01640010 > $DCC_PATH/config
    echo 0x01640018 > $DCC_PATH/config
    echo 0x01640020 > $DCC_PATH/config
    echo 0x01640024 > $DCC_PATH/config
    echo 0x01640028 > $DCC_PATH/config
    echo 0x0164002C > $DCC_PATH/config
    echo 0x01640030 > $DCC_PATH/config
    echo 0x01640034 > $DCC_PATH/config
    echo 0x01640038 > $DCC_PATH/config
    echo 0x0164003C > $DCC_PATH/config

    # aggre_noc
    echo 0x01640240 > $DCC_PATH/config
    echo 0x01640248 > $DCC_PATH/config
    echo 0x01661010 > $DCC_PATH/config
    echo 0x01664010 > $DCC_PATH/config
    echo 0x01667010 > $DCC_PATH/config
    echo 0x01668010 > $DCC_PATH/config
    echo 0x01669010 > $DCC_PATH/config
    echo 0x0166A010 > $DCC_PATH/config

    echo 0x01641008 > $DCC_PATH/config
    echo 0x7 > $DCC_PATH/loop
    echo 0x01641010 > $DCC_PATH/config
    echo 0x01641014 > $DCC_PATH/config
    echo 1 > $DCC_PATH/loop
    echo 0x01641018 > $DCC_PATH/config

    # snoc_cnoc
    echo 0x01580000 > $DCC_PATH/config
    echo 0x01580004 > $DCC_PATH/config
    echo 0x01580008 > $DCC_PATH/config
    echo 0x01580010 > $DCC_PATH/config
    echo 0x01580018 > $DCC_PATH/config
    echo 0x01580020 > $DCC_PATH/config
    echo 0x01580024 > $DCC_PATH/config
    echo 0x01580028 > $DCC_PATH/config
    echo 0x0158002C > $DCC_PATH/config
    echo 0x01580030 > $DCC_PATH/config
    echo 0x01580034 > $DCC_PATH/config
    echo 0x01580038 > $DCC_PATH/config
    echo 0x0158003C > $DCC_PATH/config

    # cnoc
    echo 0x01580240 > $DCC_PATH/config
    echo 0x01580248 > $DCC_PATH/config

    echo 0x01581008 > $DCC_PATH/config
    echo 0xE > $DCC_PATH/loop
    echo 0x01581010 > $DCC_PATH/config
    echo 0x01581014 > $DCC_PATH/config
    echo 1 > $DCC_PATH/loop
    echo 0x01581018 > $DCC_PATH/config

    # aggre_noc_pcie_snoc
    echo 0x016C0000 > $DCC_PATH/config
    echo 0x016C0004 > $DCC_PATH/config
    echo 0x016C0008 > $DCC_PATH/config
    echo 0x016C0010 > $DCC_PATH/config
    echo 0x016C0018 > $DCC_PATH/config
    echo 0x016C0020 > $DCC_PATH/config
    echo 0x016C0024 > $DCC_PATH/config
    echo 0x016C0028 > $DCC_PATH/config
    echo 0x016C002C > $DCC_PATH/config
    echo 0x016C0030 > $DCC_PATH/config
    echo 0x016C0034 > $DCC_PATH/config
    echo 0x016C0038 > $DCC_PATH/config
    echo 0x016C003C > $DCC_PATH/config
    echo 0x016C0240 > $DCC_PATH/config
    echo 0x016C0248 > $DCC_PATH/config
    echo 0x016CA010 > $DCC_PATH/config

    echo 0x016C1008 > $DCC_PATH/config
    echo 0x7 > $DCC_PATH/loop
    echo 0x016C1010 > $DCC_PATH/config
    echo 0x016C1014 > $DCC_PATH/config
    echo 1 > $DCC_PATH/loop
    echo 0x016C1018 > $DCC_PATH/config

    # GCC_ANOC
    echo 0x0011F000 > $DCC_PATH/config
    echo 0x0011F004 > $DCC_PATH/config
    echo 0x0011F008 > $DCC_PATH/config
    echo 0x0011F00C > $DCC_PATH/config
    echo 0x0012A004 > $DCC_PATH/config

}

config_sa510m_dcc_ddr()
{
    echo 0x19080024 > $DCC_PATH/config
    echo 0x1908002C > $DCC_PATH/config
    echo 0x19080034 > $DCC_PATH/config
    echo 0x1908003C > $DCC_PATH/config
    echo 0x19080044 > $DCC_PATH/config
    echo 0x1908004C > $DCC_PATH/config
    echo 0x19080054 > $DCC_PATH/config
    echo 0x1908005C > $DCC_PATH/config
    echo 0x1908012C > $DCC_PATH/config
    echo 0x19080144 > $DCC_PATH/config
    echo 0x1908014C > $DCC_PATH/config
    echo 0x19080164 > $DCC_PATH/config
    echo 0x19080174 > $DCC_PATH/config
    echo 0x1908017C > $DCC_PATH/config
    echo 0x19080184 > $DCC_PATH/config
    echo 0x1908018C > $DCC_PATH/config
    echo 0x19080194 > $DCC_PATH/config
    echo 0x1908019C > $DCC_PATH/config
    echo 0x190801A4 > $DCC_PATH/config
    echo 0x190801AC > $DCC_PATH/config
    echo 0x190801B4 > $DCC_PATH/config
    echo 0x19091000 > $DCC_PATH/config
    echo 0x19092000 > $DCC_PATH/config
    echo 0x19093000 > $DCC_PATH/config
    echo 0x19093104 > $DCC_PATH/config
    echo 0x19094000 > $DCC_PATH/config
    echo 0x19094104 > $DCC_PATH/config
    echo 0x19095220 > $DCC_PATH/config
    echo 0x190A8804 > $DCC_PATH/config
    echo 0x190A880C > $DCC_PATH/config
    echo 0x190A8834 > $DCC_PATH/config
    echo 0x190A8840 > $DCC_PATH/config
    echo 0x190A8844 > $DCC_PATH/config
    echo 0x190A8854 > $DCC_PATH/config
    echo 0x190A8860 > $DCC_PATH/config
    echo 0x190A8864 > $DCC_PATH/config
    echo 0x190A8868 > $DCC_PATH/config
    echo 0x190A8878 > $DCC_PATH/config
    echo 0x190A888C > $DCC_PATH/config
    echo 0x190A9140 > $DCC_PATH/config
    echo 0x190A914C > $DCC_PATH/config
    echo 0x190A9158 > $DCC_PATH/config
    echo 0x190A915C > $DCC_PATH/config
    echo 0x190A9164 > $DCC_PATH/config
    echo 0x190A9188 > $DCC_PATH/config
    echo 0x190A9198 > $DCC_PATH/config
    echo 0x190A91AC > $DCC_PATH/config
    echo 0x190A91B4 > $DCC_PATH/config
    echo 0x190A91C4 > $DCC_PATH/config
    echo 0x190A91C8 > $DCC_PATH/config
    echo 0x190AA034 > $DCC_PATH/config
    echo 0x190AA038 > $DCC_PATH/config
    echo 0x190AA03C > $DCC_PATH/config
    echo 0x190AA040 > $DCC_PATH/config
    echo 0x190AA04C > $DCC_PATH/config
    echo 0x190AA058 > $DCC_PATH/config
    echo 0x190AA064 > $DCC_PATH/config
    echo 0x190AA070 > $DCC_PATH/config
    echo 0x19243400 > $DCC_PATH/config
    echo 0x19243404 > $DCC_PATH/config
    echo 0x19243408 > $DCC_PATH/config
    echo 0x1924340C > $DCC_PATH/config
    echo 0x19243410 > $DCC_PATH/config
    echo 0x19243414 > $DCC_PATH/config
    echo 0x19243418 > $DCC_PATH/config
    echo 0x19243420 > $DCC_PATH/config
    echo 0x19243424 > $DCC_PATH/config
    echo 0x19243430 > $DCC_PATH/config
    echo 0x19243434 > $DCC_PATH/config
    echo 0x19243438 > $DCC_PATH/config
    echo 0x1924343C > $DCC_PATH/config
    echo 0x19243440 > $DCC_PATH/config
    echo 0x19243460 > $DCC_PATH/config
    echo 0x19243464 > $DCC_PATH/config
    echo 0x19243468 > $DCC_PATH/config
    echo 0x1924346C > $DCC_PATH/config
    echo 0x19243470 > $DCC_PATH/config
    echo 0x1924390C > $DCC_PATH/config
    echo 0x19243920 > $DCC_PATH/config
    echo 0x19250400 > $DCC_PATH/config
    echo 0x19250404 > $DCC_PATH/config
    echo 0x19250410 > $DCC_PATH/config
    echo 0x19250414 > $DCC_PATH/config
    echo 0x19250418 > $DCC_PATH/config
    echo 0x19250420 > $DCC_PATH/config
    echo 0x19250424 > $DCC_PATH/config
    echo 0x19250430 > $DCC_PATH/config
    echo 0x19250440 > $DCC_PATH/config
    echo 0x19250448 > $DCC_PATH/config
    echo 0x192504A0 > $DCC_PATH/config
    echo 0x192504B0 > $DCC_PATH/config
    echo 0x192504B4 > $DCC_PATH/config
    echo 0x192504B8 > $DCC_PATH/config
    echo 0x192504BC > $DCC_PATH/config
    echo 0x192504D0 > $DCC_PATH/config
    echo 0x192504D4 > $DCC_PATH/config
    echo 0x192504E0 > $DCC_PATH/config
    echo 0x19252400 > $DCC_PATH/config
    echo 0x19252404 > $DCC_PATH/config
    echo 0x19252410 > $DCC_PATH/config
    echo 0x19252418 > $DCC_PATH/config
    echo 0x19252450 > $DCC_PATH/config
    echo 0x19252454 > $DCC_PATH/config
    echo 0x19252458 > $DCC_PATH/config
    echo 0x1925245C > $DCC_PATH/config
    echo 0x19252460 > $DCC_PATH/config
    echo 0x19252464 > $DCC_PATH/config
    echo 0x19252468 > $DCC_PATH/config
    echo 0x1925246C > $DCC_PATH/config
    echo 0x19252470 > $DCC_PATH/config
    echo 0x19253400 > $DCC_PATH/config
    echo 0x19253404 > $DCC_PATH/config
    echo 0x19253408 > $DCC_PATH/config
    echo 0x1925340C > $DCC_PATH/config
    echo 0x19253410 > $DCC_PATH/config
    echo 0x19253414 > $DCC_PATH/config
    echo 0x19253418 > $DCC_PATH/config
    echo 0x1925341C > $DCC_PATH/config
    echo 0x19253420 > $DCC_PATH/config
    echo 0x19255110 > $DCC_PATH/config
    echo 0x19255210 > $DCC_PATH/config
    echo 0x19255230 > $DCC_PATH/config
    echo 0x192553B0 > $DCC_PATH/config
    echo 0x192553B4 > $DCC_PATH/config
    echo 0x19255840 > $DCC_PATH/config
    echo 0x19255920 > $DCC_PATH/config
    echo 0x19255924 > $DCC_PATH/config
    echo 0x19255928 > $DCC_PATH/config
    echo 0x1925592C > $DCC_PATH/config
    echo 0x19255B00 > $DCC_PATH/config
    echo 0x19255B04 > $DCC_PATH/config
    echo 0x19255B08 > $DCC_PATH/config
    echo 0x19255B0C > $DCC_PATH/config
    echo 0x19255B10 > $DCC_PATH/config
    echo 0x19255B14 > $DCC_PATH/config
    echo 0x19255B18 > $DCC_PATH/config
    echo 0x19255B1C > $DCC_PATH/config
    echo 0x19255B28 > $DCC_PATH/config
    echo 0x19255B2C > $DCC_PATH/config
    echo 0x19255B30 > $DCC_PATH/config
    echo 0x19255B34 > $DCC_PATH/config
    echo 0x19255B38 > $DCC_PATH/config
    echo 0x19255B3C > $DCC_PATH/config
    echo 0x19255B40 > $DCC_PATH/config
    echo 0x19255B44 > $DCC_PATH/config
    echo 0x19255B48 > $DCC_PATH/config
    echo 0x19256400 > $DCC_PATH/config
    echo 0x19256410 > $DCC_PATH/config
    echo 0x19256414 > $DCC_PATH/config
    echo 0x19256418 > $DCC_PATH/config
    echo 0x1925641C > $DCC_PATH/config
    echo 0x19256420 > $DCC_PATH/config
    echo 0x19259100 > $DCC_PATH/config
    echo 0x19250100 > $DCC_PATH/config
    echo 0x19250080 > $DCC_PATH/config
    echo 0x192530B0 > $DCC_PATH/config
    echo 0x19255040 > $DCC_PATH/config
    echo 0x19255050 > $DCC_PATH/config
    echo 0x19255060 > $DCC_PATH/config
    echo 0x19255240 > $DCC_PATH/config
    echo 0x19255244 > $DCC_PATH/config
    echo 0x19255248 > $DCC_PATH/config
    echo 0x19255844 > $DCC_PATH/config
    echo 0x19255848 > $DCC_PATH/config
    echo 0x19255328 > $DCC_PATH/config
    echo 0x19254714 > $DCC_PATH/config
    echo 0x19254710 > $DCC_PATH/config
    echo 0x19256050 > $DCC_PATH/config
    echo 0x1925D060 > $DCC_PATH/config
    echo 0x1925D064 > $DCC_PATH/config
    echo 0x1925D050 > $DCC_PATH/config
    echo 0x1925D054 > $DCC_PATH/config
    echo 0x1925D060 > $DCC_PATH/config
    echo 0x1925D064 > $DCC_PATH/config
    echo 0x19281814 > $DCC_PATH/config
    echo 0x19283814 > $DCC_PATH/config
    echo 0x19285014 > $DCC_PATH/config
    echo 0x19286C04 > $DCC_PATH/config
    echo 0x19286D04 > $DCC_PATH/config
    echo 0x192E0610 > $DCC_PATH/config
    echo 0x192E0614 > $DCC_PATH/config
    echo 0x192E0618 > $DCC_PATH/config
    echo 0x192E061C > $DCC_PATH/config
    echo 0x192E0624 > $DCC_PATH/config
    echo 0x192E0628 > $DCC_PATH/config
    echo 0x192E062C > $DCC_PATH/config
    echo 0x192E0630 > $DCC_PATH/config
    echo 0x192E0634 > $DCC_PATH/config
    echo 0x192E0640 > $DCC_PATH/config
    echo 0x192E0650 > $DCC_PATH/config
    echo 0x192E0654 > $DCC_PATH/config
    echo 0x192E0658 > $DCC_PATH/config
    echo 0x192E065C > $DCC_PATH/config
    echo 0x192E0670 > $DCC_PATH/config
    echo 0x192E0680 > $DCC_PATH/config
    echo 0x192E0684 > $DCC_PATH/config
    echo 0x192E0688 > $DCC_PATH/config
    echo 0x192E068C > $DCC_PATH/config
    echo 0x1908E008 > $DCC_PATH/config
    echo 0x1908E01C > $DCC_PATH/config
    echo 0x1908E030 > $DCC_PATH/config
    echo 0x1908E050 > $DCC_PATH/config
    echo 0x1908E070 > $DCC_PATH/config
    echo 0x1908E948 > $DCC_PATH/config
    echo 0x1908F04C > $DCC_PATH/config
    echo 0x19032020 > $DCC_PATH/config
    echo 0x19032024 > $DCC_PATH/config
    echo 0x1908E01C > $DCC_PATH/config
    echo 0x1908E030 > $DCC_PATH/config
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1908E008 > $DCC_PATH/config
    echo 0x19032020 > $DCC_PATH/config
    echo 0x1908E948 > $DCC_PATH/config
    echo 0x19032024 > $DCC_PATH/config
    echo 0x19030040 > $DCC_PATH/config
    echo 0x1903005C 0x22C000 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C001 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C002 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C003 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C004 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C005 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C006 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C007 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C008 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C009 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C00A 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C00B 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C00C 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C00D 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C00E 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C00F 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C010 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C011 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C012 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C013 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C014 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C015 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C016 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C017 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C018 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C019 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C01A 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C01B 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C01C 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C01D 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C01E 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C01F 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C300 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C341 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
    echo 0x1903005C 0x22C7B1 1 > $DCC_PATH/config_write
    echo 0x19030010 > $DCC_PATH/config
}

config_sa510m_dcc_gic()
{
    echo 0x17000100 11 > $DCC_PATH/config
    echo 0x17000200 11 > $DCC_PATH/config
    echo 0x17000380 11 > $DCC_PATH/config
}

config_sa510m_dcc_smmu()
{
    #echo 0x150fc008 > $DCC_PATH/config
    echo 0x150025dc > $DCC_PATH/config
    echo 0x150055dc > $DCC_PATH/config
    echo 0x150075dc > $DCC_PATH/config
    echo 0x150075dc > $DCC_PATH/config
    echo 0x15002204 > $DCC_PATH/config
    echo 0x15002670 > $DCC_PATH/config
    #echo 0x15002648 > $DCC_PATH/config
    echo 0x150022fc 3 > $DCC_PATH/config
    echo 0x150022fc > $DCC_PATH/config
    echo 0x15002304 > $DCC_PATH/config
    #echo 0x150fc010 > $DCC_PATH/config
}

config_sa510m_dcc_bam()
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

config_sa510m_dcc_snoc()
{
    # snoc_anoc
    echo 0x01640000 > $DCC_PATH/config
    echo 0x01640004 > $DCC_PATH/config

    #errlog
    echo 0x01640008 > $DCC_PATH/config
    echo 0x01640010 > $DCC_PATH/config
    echo 0x01640018 > $DCC_PATH/config
    echo 0x01640020 > $DCC_PATH/config
    echo 0x01640024 > $DCC_PATH/config
    echo 0x01640028 > $DCC_PATH/config
    echo 0x0164002C > $DCC_PATH/config
    echo 0x01640030 > $DCC_PATH/config
    echo 0x01640034 > $DCC_PATH/config
    echo 0x01640038 > $DCC_PATH/config
    echo 0x0164003C > $DCC_PATH/config

    # snoc
    echo 0x015C0000 > $DCC_PATH/config
    echo 0x015C0004 > $DCC_PATH/config
    echo 0x015C0008 > $DCC_PATH/config
    echo 0x015C0010 > $DCC_PATH/config
    echo 0x015C0018 > $DCC_PATH/config
    echo 0x015C0020 > $DCC_PATH/config
    echo 0x015C0024 > $DCC_PATH/config
    echo 0x015C0028 > $DCC_PATH/config
    echo 0x015C002C > $DCC_PATH/config
    echo 0x015C0030 > $DCC_PATH/config
    echo 0x015C0034 > $DCC_PATH/config
    echo 0x015C0038 > $DCC_PATH/config
    echo 0x015C003C > $DCC_PATH/config
    echo 0x015C0240 > $DCC_PATH/config
    echo 0x015C0248 > $DCC_PATH/config
    echo 0x015D1010 > $DCC_PATH/config
    echo 0x015D2010 > $DCC_PATH/config
    echo 0x015D3010 > $DCC_PATH/config
    echo 0x015D4010 > $DCC_PATH/config

    echo 0x015C1008 > $DCC_PATH/config
    echo 0x7 > $DCC_PATH/loop
    echo 0x15C1010 > $DCC_PATH/config
    echo 0x15C1014 > $DCC_PATH/config
    echo 1 > $DCC_PATH/loop
    echo 0x015C1018 > $DCC_PATH/config

}

config_sa510m_dcc_noc_dch_erl()
{
    echo 0x190E0000 > $DCC_PATH/config
    echo 0x190E0004 > $DCC_PATH/config
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
    echo 0x7 > $DCC_PATH/loop
    echo 0x190E5010 > $DCC_PATH/config
    echo 0x190E5014 > $DCC_PATH/config
    echo 1 > $DCC_PATH/loop
    echo 0x190E5018 > $DCC_PATH/config
}


enable_sa510m_dcc()
{
    echo "++++ $0 -> START dcc settings" > /dev/kmsg

    DCC_PATH="/sys/devices/platform/soc/240ff000.dcc_v2"

    if [ ! -d $DCC_PATH ]; then
        echo "DCC does not exist on this build."
        return
    fi

    echo 0 > $DCC_PATH/enable
    echo 1 > $DCC_PATH/config_reset
    echo 6 > $DCC_PATH/curr_list
    echo 1 > $DCC_PATH/hw_trig
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink

    config_sa510m_dcc_thermal
    config_sa510m_dcc_core
    config_sa510m_dcc_gcc
    config_sa510m_dcc_rpmh
    config_sa510m_dcc_apss_rscc
    config_sa510m_dcc_mss_rscc
    config_sa510m_dcc_epss
    config_sa510m_dcc_misc
    config_sa510m_dcc_ddr

    echo 4 > $DCC_PATH/curr_list
    echo 1 > $DCC_PATH/hw_trig
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink

    config_sa510m_dcc_gic
    config_sa510m_dcc_gemnoc
    config_sa510m_dcc_snoc
    config_sa510m_dcc_noc_dch_erl
    config_sa510m_dcc_smmu
    config_sa510m_dcc_bam

    echo 1 > $DCC_PATH/sw_trig
    echo 1 > $DCC_PATH/enable

    echo "++++ $0 -> END dcc settings" > /dev/kmsg
}

enable_sa510m_ftrace_event_tracing()
{
    echo "++++ $0 -> ENABLE-FTRACE START" > /dev/kmsg

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

    #rwmmio
    echo 1 > /sys/kernel/debug/tracing/events/rwmmio/rwmmio_read/enable
    echo 1 > /sys/kernel/debug/tracing/events/rwmmio/rwmmio_write/enable
    echo 1 > /sys/kernel/debug/tracing/events/rwmmio/rwmmio_post_read/enable
    echo 1 > /sys/kernel/debug/tracing/events/rwmmio/rwmmio_post_write/enable

    echo 1 > /sys/kernel/debug/tracing/tracing_on
    echo "++++ $0 -> ENABLE-FTRACE END" > /dev/kmsg
}

enable_sa510m_debug()
{
    echo "++++ $0 -> enable_sa510m_debug START" > /dev/kmsg
    enable_sa510m_dcc
    enable_sa510m_ftrace_event_tracing
    echo "++++ $0 -> enable_sa510m_debug END" > /dev/kmsg
}
