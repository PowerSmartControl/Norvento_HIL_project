--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Thu Nov 22 13:28:39 2018
--Host        : DESKTOP-ANME3V9-JORGE running 64-bit major release  (build 9200)
--Command     : generate_target NV_project_wrapper.bd
--Design      : NV_project_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity NV_project_wrapper is
  port (
    DDR_0_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_0_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_0_cas_n : inout STD_LOGIC;
    DDR_0_ck_n : inout STD_LOGIC;
    DDR_0_ck_p : inout STD_LOGIC;
    DDR_0_cke : inout STD_LOGIC;
    DDR_0_cs_n : inout STD_LOGIC;
    DDR_0_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_0_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_odt : inout STD_LOGIC;
    DDR_0_ras_n : inout STD_LOGIC;
    DDR_0_reset_n : inout STD_LOGIC;
    DDR_0_we_n : inout STD_LOGIC;
    DRIVER_DOWN_00 : in STD_LOGIC;
    DRIVER_DOWN_01 : in STD_LOGIC;
    DRIVER_DOWN_02 : in STD_LOGIC;
    DRIVER_DOWN_03 : in STD_LOGIC;
    DRIVER_DOWN_04 : in STD_LOGIC;
    DRIVER_DOWN_05 : in STD_LOGIC;
    DRIVER_DOWN_06 : in STD_LOGIC;
    DRIVER_UP_00 : in STD_LOGIC;
    DRIVER_UP_01 : in STD_LOGIC;
    DRIVER_UP_02 : in STD_LOGIC;
    DRIVER_UP_03 : in STD_LOGIC;
    DRIVER_UP_04 : in STD_LOGIC;
    DRIVER_UP_05 : in STD_LOGIC;
    DRIVER_UP_06 : in STD_LOGIC;
    Din_out_0 : out STD_LOGIC;
    Din_out_1 : out STD_LOGIC;
    Din_out_10 : out STD_LOGIC;
    Din_out_11 : out STD_LOGIC;
    Din_out_12 : out STD_LOGIC;
    Din_out_13 : out STD_LOGIC;
    Din_out_14 : out STD_LOGIC;
    Din_out_15 : out STD_LOGIC;
    Din_out_16 : out STD_LOGIC;
    Din_out_17 : out STD_LOGIC_VECTOR ( 0 to 0 );
    Din_out_18 : out STD_LOGIC;
    Din_out_19 : out STD_LOGIC;
    Din_out_2 : out STD_LOGIC;
    Din_out_20 : out STD_LOGIC;
    Din_out_3 : out STD_LOGIC;
    Din_out_4 : out STD_LOGIC;
    Din_out_5 : out STD_LOGIC;
    Din_out_6 : out STD_LOGIC;
    Din_out_7 : out STD_LOGIC;
    Din_out_8 : out STD_LOGIC;
    Din_out_9 : out STD_LOGIC;
    FIXED_IO_0_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_0_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_0_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_0_ps_clk : inout STD_LOGIC;
    FIXED_IO_0_ps_porb : inout STD_LOGIC;
    FIXED_IO_0_ps_srstb : inout STD_LOGIC;
    SCLK_0 : out STD_LOGIC;
    SCLK_out_0 : out STD_LOGIC;
    SCLK_out_1 : out STD_LOGIC;
    SCLK_out_2 : out STD_LOGIC;
    SCLK_out_3 : out STD_LOGIC;
    SCLK_out_4 : out STD_LOGIC;
    SCLK_out_6 : out STD_LOGIC;
    SCLK_out_7 : out STD_LOGIC;
    SDATA1_0 : in STD_LOGIC;
    nCS_0 : out STD_LOGIC;
    nRST_out_0 : out STD_LOGIC;
    nRST_out_1 : out STD_LOGIC;
    nSync_out_0 : out STD_LOGIC;
    nSync_out_6 : out STD_LOGIC;
    scl_0 : inout STD_LOGIC;
    scl_1 : inout STD_LOGIC;
    sda_0 : inout STD_LOGIC;
    sda_1 : inout STD_LOGIC
  );
end NV_project_wrapper;

architecture STRUCTURE of NV_project_wrapper is
  component NV_project is
  port (
    DDR_0_cas_n : inout STD_LOGIC;
    DDR_0_cke : inout STD_LOGIC;
    DDR_0_ck_n : inout STD_LOGIC;
    DDR_0_ck_p : inout STD_LOGIC;
    DDR_0_cs_n : inout STD_LOGIC;
    DDR_0_reset_n : inout STD_LOGIC;
    DDR_0_odt : inout STD_LOGIC;
    DDR_0_ras_n : inout STD_LOGIC;
    DDR_0_we_n : inout STD_LOGIC;
    DDR_0_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_0_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_0_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_0_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_0_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_0_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_0_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_0_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_0_ps_srstb : inout STD_LOGIC;
    FIXED_IO_0_ps_clk : inout STD_LOGIC;
    FIXED_IO_0_ps_porb : inout STD_LOGIC;
    DRIVER_DOWN_03 : in STD_LOGIC;
    nRST_out_1 : out STD_LOGIC;
    sda_1 : inout STD_LOGIC;
    scl_1 : inout STD_LOGIC;
    Din_out_0 : out STD_LOGIC;
    Din_out_6 : out STD_LOGIC;
    Din_out_5 : out STD_LOGIC;
    Din_out_4 : out STD_LOGIC;
    Din_out_3 : out STD_LOGIC;
    Din_out_2 : out STD_LOGIC;
    Din_out_1 : out STD_LOGIC;
    Din_out_7 : out STD_LOGIC;
    Din_out_10 : out STD_LOGIC;
    Din_out_11 : out STD_LOGIC;
    Din_out_15 : out STD_LOGIC;
    Din_out_9 : out STD_LOGIC;
    Din_out_8 : out STD_LOGIC;
    Din_out_14 : out STD_LOGIC;
    Din_out_13 : out STD_LOGIC;
    Din_out_12 : out STD_LOGIC;
    Din_out_16 : out STD_LOGIC;
    SCLK_out_6 : out STD_LOGIC;
    SCLK_out_4 : out STD_LOGIC;
    SCLK_out_3 : out STD_LOGIC;
    SCLK_out_2 : out STD_LOGIC;
    SCLK_out_1 : out STD_LOGIC;
    SCLK_out_0 : out STD_LOGIC;
    nSync_out_0 : out STD_LOGIC;
    SCLK_out_7 : out STD_LOGIC;
    nSync_out_6 : out STD_LOGIC;
    Din_out_19 : out STD_LOGIC;
    Din_out_18 : out STD_LOGIC;
    Din_out_20 : out STD_LOGIC;
    nCS_0 : out STD_LOGIC;
    SCLK_0 : out STD_LOGIC;
    SDATA1_0 : in STD_LOGIC;
    nRST_out_0 : out STD_LOGIC;
    sda_0 : inout STD_LOGIC;
    scl_0 : inout STD_LOGIC;
    DRIVER_UP_06 : in STD_LOGIC;
    DRIVER_DOWN_06 : in STD_LOGIC;
    DRIVER_UP_05 : in STD_LOGIC;
    DRIVER_DOWN_05 : in STD_LOGIC;
    DRIVER_UP_04 : in STD_LOGIC;
    DRIVER_DOWN_04 : in STD_LOGIC;
    DRIVER_UP_03 : in STD_LOGIC;
    Din_out_17 : out STD_LOGIC_VECTOR ( 0 to 0 );
    DRIVER_UP_00 : in STD_LOGIC;
    DRIVER_UP_01 : in STD_LOGIC;
    DRIVER_UP_02 : in STD_LOGIC;
    DRIVER_DOWN_00 : in STD_LOGIC;
    DRIVER_DOWN_01 : in STD_LOGIC;
    DRIVER_DOWN_02 : in STD_LOGIC
  );
  end component NV_project;
begin
NV_project_i: component NV_project
     port map (
      DDR_0_addr(14 downto 0) => DDR_0_addr(14 downto 0),
      DDR_0_ba(2 downto 0) => DDR_0_ba(2 downto 0),
      DDR_0_cas_n => DDR_0_cas_n,
      DDR_0_ck_n => DDR_0_ck_n,
      DDR_0_ck_p => DDR_0_ck_p,
      DDR_0_cke => DDR_0_cke,
      DDR_0_cs_n => DDR_0_cs_n,
      DDR_0_dm(3 downto 0) => DDR_0_dm(3 downto 0),
      DDR_0_dq(31 downto 0) => DDR_0_dq(31 downto 0),
      DDR_0_dqs_n(3 downto 0) => DDR_0_dqs_n(3 downto 0),
      DDR_0_dqs_p(3 downto 0) => DDR_0_dqs_p(3 downto 0),
      DDR_0_odt => DDR_0_odt,
      DDR_0_ras_n => DDR_0_ras_n,
      DDR_0_reset_n => DDR_0_reset_n,
      DDR_0_we_n => DDR_0_we_n,
      DRIVER_DOWN_00 => DRIVER_DOWN_00,
      DRIVER_DOWN_01 => DRIVER_DOWN_01,
      DRIVER_DOWN_02 => DRIVER_DOWN_02,
      DRIVER_DOWN_03 => DRIVER_DOWN_03,
      DRIVER_DOWN_04 => DRIVER_DOWN_04,
      DRIVER_DOWN_05 => DRIVER_DOWN_05,
      DRIVER_DOWN_06 => DRIVER_DOWN_06,
      DRIVER_UP_00 => DRIVER_UP_00,
      DRIVER_UP_01 => DRIVER_UP_01,
      DRIVER_UP_02 => DRIVER_UP_02,
      DRIVER_UP_03 => DRIVER_UP_03,
      DRIVER_UP_04 => DRIVER_UP_04,
      DRIVER_UP_05 => DRIVER_UP_05,
      DRIVER_UP_06 => DRIVER_UP_06,
      Din_out_0 => Din_out_0,
      Din_out_1 => Din_out_1,
      Din_out_10 => Din_out_10,
      Din_out_11 => Din_out_11,
      Din_out_12 => Din_out_12,
      Din_out_13 => Din_out_13,
      Din_out_14 => Din_out_14,
      Din_out_15 => Din_out_15,
      Din_out_16 => Din_out_16,
      Din_out_17(0) => Din_out_17(0),
      Din_out_18 => Din_out_18,
      Din_out_19 => Din_out_19,
      Din_out_2 => Din_out_2,
      Din_out_20 => Din_out_20,
      Din_out_3 => Din_out_3,
      Din_out_4 => Din_out_4,
      Din_out_5 => Din_out_5,
      Din_out_6 => Din_out_6,
      Din_out_7 => Din_out_7,
      Din_out_8 => Din_out_8,
      Din_out_9 => Din_out_9,
      FIXED_IO_0_ddr_vrn => FIXED_IO_0_ddr_vrn,
      FIXED_IO_0_ddr_vrp => FIXED_IO_0_ddr_vrp,
      FIXED_IO_0_mio(53 downto 0) => FIXED_IO_0_mio(53 downto 0),
      FIXED_IO_0_ps_clk => FIXED_IO_0_ps_clk,
      FIXED_IO_0_ps_porb => FIXED_IO_0_ps_porb,
      FIXED_IO_0_ps_srstb => FIXED_IO_0_ps_srstb,
      SCLK_0 => SCLK_0,
      SCLK_out_0 => SCLK_out_0,
      SCLK_out_1 => SCLK_out_1,
      SCLK_out_2 => SCLK_out_2,
      SCLK_out_3 => SCLK_out_3,
      SCLK_out_4 => SCLK_out_4,
      SCLK_out_6 => SCLK_out_6,
      SCLK_out_7 => SCLK_out_7,
      SDATA1_0 => SDATA1_0,
      nCS_0 => nCS_0,
      nRST_out_0 => nRST_out_0,
      nRST_out_1 => nRST_out_1,
      nSync_out_0 => nSync_out_0,
      nSync_out_6 => nSync_out_6,
      scl_0 => scl_0,
      scl_1 => scl_1,
      sda_0 => sda_0,
      sda_1 => sda_1
    );
end STRUCTURE;
