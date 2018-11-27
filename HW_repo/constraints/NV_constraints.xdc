#   PSC | Power Smart Control | JRF | 2018  #
#############################################

#pin constraints
#set_property PACKAGE_PIN V7 [get_ports {gpio_io_o_0[0]}]

## Bank 13, Vcco = Vadj
## Set the bank voltage for bank 13.
#set_property IOSTANDARD LVCMOS18 [get_ports -filter { IOBANK == 13 } ]

##NET BANK13_LVDS_0_N LOC = V7  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_0_N"
#set_property PACKAGE_PIN V7 [get_ports {BANK13_LVDS_0_N}]

##NET BANK13_LVDS_0_P LOC = U7  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_0_P"
#set_property PACKAGE_PIN U7 [get_ports {BANK13_LVDS_0_P}]
##NET BANK13_LVDS_1_N LOC = U10 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_1_N"
#set_property PACKAGE_PIN U10 [get_ports {BANK13_LVDS_1_N}]
##NET BANK13_LVDS_1_P LOC = T9  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_1_P"
#set_property PACKAGE_PIN T9 [get_ports {BANK13_LVDS_1_P}]
##NET BANK13_LVDS_2_N LOC = W8  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_2_N"
#set_property PACKAGE_PIN W8 [get_ports {BANK13_LVDS_2_N}]
##NET BANK13_LVDS_2_P LOC = V8  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_2_P"
#set_property PACKAGE_PIN V8 [get_ports {BANK13_LVDS_2_P}]
##NET BANK13_LVDS_3_N LOC = U5  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_3_N"
#set_property PACKAGE_PIN U5 [get_ports {BANK13_LVDS_3_N}]
##NET BANK13_LVDS_3_P LOC = T5  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_3_P"
#set_property PACKAGE_PIN T5 [get_ports {BANK13_LVDS_3_P}]
##NET BANK13_LVDS_4_N LOC = Y13 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_4_N"
#set_property PACKAGE_PIN Y13 [get_ports {BANK13_LVDS_4_N}]
##NET BANK13_LVDS_4_P LOC = Y12 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_4_P"
#set_property PACKAGE_PIN Y12 [get_ports {BANK13_LVDS_4_P}]
##NET BANK13_LVDS_5_N LOC = V10 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_5_N"
#set_property PACKAGE_PIN V10 [get_ports {BANK13_LVDS_5_N}]
##NET BANK13_LVDS_5_P LOC = V11 | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_5_P"
#set_property PACKAGE_PIN V11 [get_ports {BANK13_LVDS_5_P}]
##NET BANK13_LVDS_6_N LOC = W6  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_6_N"
#set_property PACKAGE_PIN W6 [get_ports {BANK13_LVDS_6_N}]
##NET BANK13_LVDS_6_P LOC = V6  | IOSTANDARD = LVCMOS18;  # "BANK13_LVDS_6_P"
#set_property PACKAGE_PIN V6 [get_ports {BANK13_LVDS_6_P}]
##NET BANK13_SE_0     LOC = V5  | IOSTANDARD = LVCMOS18;  # "BANK13_SE_0"
#set_property PACKAGE_PIN V5 [get_ports {BANK13_SE_0}]
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]]


#################


## Bank 34, Vcco = Vadj
## Set the bank voltage for bank 34.
#set_property IOSTANDARD LVCMOS18 [get_ports -filter { IOBANK == 34 } ]

##NET JX1_LVDS_0_N    LOC = T10 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_0_N"
set_property PACKAGE_PIN T10 [get_ports DRIVER_UP_00]
#DRIVER_DOWN_00 - GRID_A

##NET JX1_LVDS_0_P    LOC = T11 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_0_P"
set_property PACKAGE_PIN T11 [get_ports DRIVER_DOWN_00]
#DRIVER_UP_00 - GRID_A

##NET JX1_LVDS_1_N    LOC = U12 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_1_N"
set_property PACKAGE_PIN U12 [get_ports SCLK_out_7]
#NTC_SCLK

##NET JX1_LVDS_1_P    LOC = T12 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_1_P"
set_property PACKAGE_PIN T12 [get_ports nSync_out_6]
#NTC_SYNC

##NET JX1_LVDS_10_N   LOC = U15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_10_N"
set_property PACKAGE_PIN U15 [get_ports DRIVER_UP_05]
#DRIVER_DOWN_05 - PMSM_C

##NET JX1_LVDS_10_P   LOC = U14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_10_P"
set_property PACKAGE_PIN U14 [get_ports DRIVER_DOWN_05]
#DRIVER_UP_05 - PMSM_C

##NET JX1_LVDS_11_N   LOC = U19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_11_N"
#set_property PACKAGE_PIN U19 [get_ports {JX1_LVDS_11_N}]
##NET JX1_LVDS_11_P   LOC = U18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_11_P"
#set_property PACKAGE_PIN U18 [get_ports {JX1_LVDS_11_P}]

##NET JX1_LVDS_12_N   LOC = P19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_12_N"
set_property PACKAGE_PIN P19 [get_ports DRIVER_UP_06]
#DRIVER_DOWN_06

##NET JX1_LVDS_12_P   LOC = N18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_12_P"
set_property PACKAGE_PIN N18 [get_ports DRIVER_DOWN_06]
#DRIVER_UP_06

##NET JX1_LVDS_13_N   LOC = P20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_13_N"
#set_property PACKAGE_PIN P20 [get_ports {JX1_LVDS_13_N}]
##NET JX1_LVDS_13_P   LOC = N20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_13_P"
#set_property PACKAGE_PIN N20 [get_ports {JX1_LVDS_13_P}]
##NET JX1_LVDS_14_N   LOC = U20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_14_N"
#set_property PACKAGE_PIN U20 [get_ports {JX1_LVDS_14_N}]
##NET JX1_LVDS_14_P   LOC = T20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_14_P"
#set_property PACKAGE_PIN T20 [get_ports {JX1_LVDS_14_P}]
##NET JX1_LVDS_15_N   LOC = W20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_15_N"
#set_property PACKAGE_PIN W20 [get_ports {JX1_LVDS_15_N}]
##NET JX1_LVDS_15_P   LOC = V20 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_15_P"
#set_property PACKAGE_PIN V20 [get_ports {JX1_LVDS_15_P}]

##NET JX1_LVDS_16_N   LOC = Y19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_16_N"     
set_property PACKAGE_PIN Y19 [get_ports sda_1]
#DI_SDA

##NET JX1_LVDS_16_P   LOC = Y18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_16_P"
#set_property PACKAGE_PIN Y18 [get_ports {JX1_LVDS_16_P}]
##NET JX1_LVDS_17_N   LOC = W16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_17_N"
#set_property PACKAGE_PIN W16 [get_ports {JX1_LVDS_17_N}]
##NET JX1_LVDS_17_P   LOC = V16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_17_P"
#set_property PACKAGE_PIN V16 [get_ports {JX1_LVDS_17_P}]

##NET JX1_LVDS_18_N   LOC = R17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_18_N"
set_property PACKAGE_PIN R17 [get_ports nRST_out_1]
#DI_RST

##NET JX1_LVDS_18_P   LOC = R16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_18_P"
set_property PACKAGE_PIN R16 [get_ports scl_1]
#DI_SCL

##NET JX1_LVDS_19_N   LOC = R18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_19_N"
#set_property PACKAGE_PIN R18 [get_ports {JX1_LVDS_19_N}]

##NET JX1_LVDS_19_P   LOC = T17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_19_P"
set_property PACKAGE_PIN T17 [get_ports {nCS_0}]
#AD_/cs

##NET JX1_LVDS_2_N    LOC = V13 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_2_N"
set_property PACKAGE_PIN V13 [get_ports DRIVER_UP_01]
#DRIVER_DOWN_01 - GRID_B

##NET JX1_LVDS_2_P    LOC = U13 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_2_P"
set_property PACKAGE_PIN U13 [get_ports DRIVER_DOWN_01]
#DRIVER_UP_01 - GRID_B

##NET JX1_LVDS_20_N   LOC = V18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_20_N"
set_property PACKAGE_PIN V18 [get_ports scl_0]
#D0_SCL

##NET JX1_LVDS_20_P   LOC = V17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_20_P"
#set_property PACKAGE_PIN V17 [get_ports {JX1_LVDS_20_P}]

##NET JX1_LVDS_21_N   LOC = W19 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_21_N"
set_property PACKAGE_PIN W19 [get_ports SCLK_0]
#AD_SCL

##NET JX1_LVDS_21_P   LOC = W18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_21_P"
set_property PACKAGE_PIN W18 [get_ports SDATA1_0]
#AD_SDA

##NET JX1_LVDS_22_N   LOC = P18 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_22_N"
set_property PACKAGE_PIN P18 [get_ports nRST_out_0]
#D0_RST

##NET JX1_LVDS_22_P   LOC = N17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_22_P"
set_property PACKAGE_PIN N17 [get_ports sda_0]
#D0_SDA

##NET JX1_LVDS_23_N   LOC = P16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_23_N"
#set_property PACKAGE_PIN P16 [get_ports {JX1_LVDS_23_N}]
##NET JX1_LVDS_23_P   LOC = P15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_23_P"
#set_property PACKAGE_PIN P15 [get_ports {JX1_LVDS_23_P}]

##NET JX1_LVDS_3_N    LOC = W13 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_3_N"
set_property PACKAGE_PIN W13 [get_ports Din_out_18]
#NTC_D2

##NET JX1_LVDS_3_P    LOC = V12 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_3_P"
set_property PACKAGE_PIN V12 [get_ports Din_out_17]
#NTC_D0

##NET JX1_LVDS_4_N    LOC = T15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_4_N"
set_property PACKAGE_PIN T15 [get_ports DRIVER_UP_02]
#DRIVER_DOWN_02 - GRID_C

##NET JX1_LVDS_4_P    LOC = T14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_4_P"
set_property PACKAGE_PIN T14 [get_ports DRIVER_DOWN_02]
#DRIVER_UP_02 - GRID_C

##NET JX1_LVDS_5_N    LOC = R14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_5_N"
#set_property PACKAGE_PIN R14 [get_ports {JX1_LVDS_5_N}]
##NET JX1_LVDS_5_P    LOC = P14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_5_P"
#set_property PACKAGE_PIN P14 [get_ports {JX1_LVDS_5_P}]

##NET JX1_LVDS_6_N    LOC = Y17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_6_N"
set_property PACKAGE_PIN Y17 [get_ports DRIVER_UP_03]
#DRIVER_DOWN_03 - PMSM_A

##NET JX1_LVDS_6_P    LOC = Y16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_6_P"
set_property PACKAGE_PIN Y16 [get_ports DRIVER_DOWN_03]
#DRIVER_UP_03 - PMSM_A

##NET JX1_LVDS_7_N    LOC = Y14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_7_N"
set_property PACKAGE_PIN Y14 [get_ports Din_out_20]
#NTC_D3

##NET JX1_LVDS_7_P    LOC = W14 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_7_P"
set_property PACKAGE_PIN W14 [get_ports Din_out_19]
#NTC_D1

##NET JX1_LVDS_8_N    LOC = U17 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_8_N"
set_property PACKAGE_PIN U17 [get_ports DRIVER_UP_04]
#DRIVER_DOWN_04 - PMSM_B

##NET JX1_LVDS_8_P    LOC = T16 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_8_P"
set_property PACKAGE_PIN T16 [get_ports DRIVER_DOWN_04]
#DRIVER_UP_04 - PMSM_B

##NET JX1_LVDS_9_N    LOC = W15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_9_N"
#set_property PACKAGE_PIN W15 [get_ports {JX1_LVDS_9_N}]
##NET JX1_LVDS_9_P    LOC = V15 | IOSTANDARD = LVCMOS18;  # "JX1_LVDS_9_P"
#set_property PACKAGE_PIN V15 [get_ports {JX1_LVDS_9_P}]
##NET JX1_SE_0        LOC = R19 | IOSTANDARD = LVCMOS18;  # "JX1_SE_0"
#set_property PACKAGE_PIN R19 [get_ports {JX1_SE_0}]
##NET JX1_SE_1        LOC = T19 | IOSTANDARD = LVCMOS18;  # "JX1_SE_1"
#set_property PACKAGE_PIN T19 [get_ports {JX1_SE_1}]
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]]


#################


## Bank 35, Vcco = Vadj
## Set the bank voltage for bank 35.
#set_property IOSTANDARD LVCMOS18 [get_ports -filter { IOBANK == 35 } ]

##NET JX2_LVDS_0_N    LOC = B20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_0_N"
set_property PACKAGE_PIN B20 [get_ports Din_out_11]
#DAC_D9

##NET JX2_LVDS_0_P    LOC = C20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_0_P"
set_property PACKAGE_PIN C20 [get_ports Din_out_2]
#DAC_D5

##NET JX2_LVDS_1_N    LOC = A20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_1_N"
set_property PACKAGE_PIN A20 [get_ports Din_out_15]
#DAC_D10

##NET JX2_LVDS_1_P    LOC = B19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_1_P"
set_property PACKAGE_PIN B19 [get_ports SCLK_out_1]
#DAC_SCLK1

##NET JX2_LVDS_10_N   LOC = L17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_10_N"
#set_property PACKAGE_PIN L17 [get_ports {JX2_LVDS_10_N}]
##NET JX2_LVDS_10_P   LOC = L16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_10_P"
#set_property PACKAGE_PIN L16 [get_ports {JX2_LVDS_10_P}]

##NET JX2_LVDS_11_N   LOC = K18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_11_N"
set_property PACKAGE_PIN K18 [get_ports Din_out_9]
#DAC_D11

##NET JX2_LVDS_11_P   LOC = K17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_11_P"
set_property PACKAGE_PIN K17 [get_ports SCLK_out_2]
#DAC_SCLK2

##NET JX2_LVDS_12_N   LOC = H17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_12_N"
#set_property PACKAGE_PIN H17 [get_ports {JX2_LVDS_12_N}]
##NET JX2_LVDS_12_P   LOC = H16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_12_P"
#set_property PACKAGE_PIN H16 [get_ports {JX2_LVDS_12_P}]
##NET JX2_LVDS_13_N   LOC = H18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_13_N"
#set_property PACKAGE_PIN H18 [get_ports {JX2_LVDS_13_N}]

##NET JX2_LVDS_13_P   LOC = J18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_13_P"
set_property PACKAGE_PIN J18 [get_ports Din_out_4]
#DAC_D3

##NET JX2_LVDS_14_N   LOC = G18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_14_N"
#set_property PACKAGE_PIN G18 [get_ports {JX2_LVDS_14_N}]
##NET JX2_LVDS_14_P   LOC = G17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_14_P"
#set_property PACKAGE_PIN G17 [get_ports {JX2_LVDS_14_P}]
##NET JX2_LVDS_15_N   LOC = F20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_15_N"
#set_property PACKAGE_PIN F20 [get_ports {JX2_LVDS_15_N}]
##NET JX2_LVDS_15_P   LOC = F19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_15_P"
#set_property PACKAGE_PIN F19 [get_ports {JX2_LVDS_15_P}]
##NET JX2_LVDS_16_N   LOC = G20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_16_N"
#set_property PACKAGE_PIN G20 [get_ports {JX2_LVDS_16_N}]
##NET JX2_LVDS_16_P   LOC = G19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_16_P"
#set_property PACKAGE_PIN G19 [get_ports {JX2_LVDS_16_P}]
##NET JX2_LVDS_17_N   LOC = H20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_17_N"
#set_property PACKAGE_PIN H20 [get_ports {JX2_LVDS_17_N}]
##NET JX2_LVDS_17_P   LOC = J20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_17_P"
#set_property PACKAGE_PIN J20 [get_ports {JX2_LVDS_17_P}]
##NET JX2_LVDS_18_N   LOC = J14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_18_N"
#set_property PACKAGE_PIN J14 [get_ports {JX2_LVDS_18_N}]
##NET JX2_LVDS_18_P   LOC = K14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_18_P"
#set_property PACKAGE_PIN K14 [get_ports {JX2_LVDS_18_P}]

##NET JX2_LVDS_19_N   LOC = G15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_19_N"
set_property PACKAGE_PIN G15 [get_ports nSync_out_0]
#DAC_SYNC

##NET JX2_LVDS_19_P   LOC = H15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_19_P"
#set_property PACKAGE_PIN H15 [get_ports {JX2_LVDS_19_P}]

##NET JX2_LVDS_2_N    LOC = D18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_2_N"
set_property PACKAGE_PIN D18 [get_ports Din_out_10]
#DAC_D8

##NET JX2_LVDS_2_P    LOC = E17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_2_P"
set_property PACKAGE_PIN E17 [get_ports Din_out_1]
#DAC_D6

##NET JX2_LVDS_20_N   LOC = N16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_20_N"
set_property PACKAGE_PIN N16 [get_ports Din_out_13]
#DAC_D14

##NET JX2_LVDS_20_P   LOC = N15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_20_P"
#set_property PACKAGE_PIN N15 [get_ports {JX2_LVDS_20_P}]

##NET JX2_LVDS_21_N   LOC = L15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_21_N"
set_property PACKAGE_PIN L15 [get_ports Din_out_8]
#DAC_D12

##NET JX2_LVDS_21_P   LOC = L14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_21_P"
set_property PACKAGE_PIN L14 [get_ports SCLK_out_3]
#DAC_SCLK3

##NET JX2_LVDS_22_N   LOC = M15 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_22_N"
set_property PACKAGE_PIN M15 [get_ports Din_out_6]
#DAC_D1

##NET JX2_LVDS_22_P   LOC = M14 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_22_P"
set_property PACKAGE_PIN M14 [get_ports SCLK_out_6]
#DAC_SCLK5

##NET JX2_LVDS_23_N   LOC = J16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_23_N"
set_property PACKAGE_PIN J16 [get_ports Din_out_14]
#DAC_D13

##NET JX2_LVDS_23_P   LOC = K16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_23_P"
set_property PACKAGE_PIN K16 [get_ports Din_out_5]
#DAC_D2

##NET JX2_LVDS_3_N    LOC = D20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_3_N"
#set_property PACKAGE_PIN D20 [get_ports {JX2_LVDS_3_N}]

##NET JX2_LVDS_3_P    LOC = D19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_3_P"
#set_property PACKAGE_PIN D19 [get_ports {Start_pot_dig[0]}]
############################################debugging pin

##NET JX2_LVDS_4_N    LOC = E19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_4_N"
set_property PACKAGE_PIN E19 [get_ports SCLK_out_0]
#DAC_SCLK0

##NET JX2_LVDS_4_P    LOC = E18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_4_P"
set_property PACKAGE_PIN E18 [get_ports Din_out_7]
#DAC_D7

##NET JX2_LVDS_5_N    LOC = F17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_5_N"
#set_property PACKAGE_PIN F17 [get_ports {JX2_LVDS_5_N}]
##NET JX2_LVDS_5_P    LOC = F16 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_5_P"
#set_property PACKAGE_PIN F16 [get_ports {JX2_LVDS_5_P}]

##NET JX2_LVDS_6_N    LOC = L20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_6_N"
set_property PACKAGE_PIN L20 [get_ports SCLK_out_4]
#DAC_SCLK4

##NET JX2_LVDS_6_P    LOC = L19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_6_P"
set_property PACKAGE_PIN L19 [get_ports Din_out_16]
#DAC_D16

##NET JX2_LVDS_7_N    LOC = M20 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_7_N"
#set_property PACKAGE_PIN M20 [get_ports {JX2_LVDS_7_N}]
##NET JX2_LVDS_7_P    LOC = M19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_7_P"
#set_property PACKAGE_PIN M19 [get_ports {JX2_LVDS_7_P}]

##NET JX2_LVDS_8_N    LOC = M18 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_8_N"
set_property PACKAGE_PIN M18 [get_ports Din_out_0]
#DAC_D0

##NET JX2_LVDS_8_P    LOC = M17 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_8_P"
set_property PACKAGE_PIN M17 [get_ports Din_out_12]
#DAC_D15

##NET JX2_LVDS_9_N    LOC = J19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_9_N"
set_property PACKAGE_PIN J19 [get_ports Din_out_3]
#DAC_D4

##NET JX2_LVDS_9_P    LOC = K19 | IOSTANDARD = LVCMOS18;  # "JX2_LVDS_9_P"
#set_property PACKAGE_PIN K19 [get_ports {JX2_LVDS_9_P}]
##NET JX2_SE_0        LOC = G14 | IOSTANDARD = LVCMOS18;  # "JX2_SE_0"
#set_property PACKAGE_PIN G14 [get_ports {JX2_SE_0}]
##NET JX2_SE_1        LOC = J15 | IOSTANDARD = LVCMOS18;  # "JX2_SE_1"
#set_property PACKAGE_PIN J15 [get_ports {JX2_SE_1}]
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]]





#timing constraints of TI-DAC121S101 -   DO NOT CHANGE VALUES!!
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_0]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_0]

set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 2.100 [get_ports Din_out_1]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 3.000 [get_ports Din_out_1]

set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_10]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_10]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_11]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_11]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_12]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_12]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_13]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_13]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_14]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_14]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_15]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_15]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_16]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_16]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_2]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_2]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_3]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_3]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_4]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_4]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_5]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_5]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_6]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_6]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_7]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_7]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_8]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_8]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.200 [get_ports Din_out_9]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports Din_out_9]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports SCLK_out_0]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports SCLK_out_0]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports SCLK_out_1]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports SCLK_out_1]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports SCLK_out_2]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports SCLK_out_2]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports SCLK_out_3]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports SCLK_out_3]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports SCLK_out_4]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports SCLK_out_4]
set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports SCLK_out_6]
set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports SCLK_out_6]


##timing constraints of AD5293 (dig pot) -   DO NOT CHANGE VALUES!!
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports SCLK_out_7]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports SCLK_out_7]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.100 [get_ports nSync_out_6]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.500 [get_ports nSync_out_6]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.500 [get_ports Din_out_17]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 2.000 [get_ports Din_out_17]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.500 [get_ports Din_out_18]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 2.000 [get_ports Din_out_18]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.500 [get_ports Din_out_19]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 2.000 [get_ports Din_out_19]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 1.500 [get_ports Din_out_20]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 2.000 [get_ports Din_out_20]


##timing constraints of AD9538 (output expansor) -   DO NOT CHANGE VALUES!!
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports nRST_out_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 0.300 [get_ports nRST_out_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports scl_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 0.300 [get_ports scl_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.100 [get_ports sda_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 0.300 [get_ports sda_0]


#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.900 [get_ports nRST_out_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports nRST_out_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.900 [get_ports nSync_out_0]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports nSync_out_0]

#set_output_delay -clock [get_clocks clk_fpga_0] -min -add_delay 0.900 [get_ports {gpio_io_o_0[0]}]
#set_output_delay -clock [get_clocks clk_fpga_0] -max -add_delay 1.000 [get_ports {gpio_io_o_0[0]}]