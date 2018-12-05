library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Digital_Outputs_v1_0 is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 7
	);
	port (
		-- Users to add ports here
        out_01 : out std_logic_vector (0 downto 0);
        out_02 : out std_logic_vector (0 downto 0);
        out_03 : out std_logic_vector (0 downto 0);
        out_04 : out std_logic_vector (0 downto 0);
        out_05 : out std_logic_vector (0 downto 0);
        out_06 : out std_logic_vector (0 downto 0);
        out_07 : out std_logic_vector (0 downto 0);
        out_08 : out std_logic_vector (0 downto 0);                         
        out_11 : out std_logic_vector (0 downto 0);
        out_12 : out std_logic_vector (0 downto 0);
        out_13 : out std_logic_vector (0 downto 0);
        out_14 : out std_logic_vector (0 downto 0);
        out_15 : out std_logic_vector (0 downto 0);
        out_16 : out std_logic_vector (0 downto 0);
        out_17 : out std_logic_vector (0 downto 0);
        out_18 : out std_logic_vector (0 downto 0);                             
        out_21 : out std_logic_vector (0 downto 0);
        out_22 : out std_logic_vector (0 downto 0);
        out_23 : out std_logic_vector (0 downto 0);
        out_24 : out std_logic_vector (0 downto 0);
        out_25 : out std_logic_vector (0 downto 0);
        out_26 : out std_logic_vector (0 downto 0);
        out_27 : out std_logic_vector (0 downto 0);
        out_28 : out std_logic_vector (0 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end Digital_Outputs_v1_0;

architecture arch_imp of Digital_Outputs_v1_0 is

	-- component declaration
	component Digital_Outputs_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 7
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		
		out_01 : out std_logic_vector (0 downto 0);
        out_02 : out std_logic_vector (0 downto 0);
        out_03 : out std_logic_vector (0 downto 0);
        out_04 : out std_logic_vector (0 downto 0);
        out_05 : out std_logic_vector (0 downto 0);
        out_06 : out std_logic_vector (0 downto 0);
        out_07 : out std_logic_vector (0 downto 0);
        out_08 : out std_logic_vector (0 downto 0);                         
        out_11 : out std_logic_vector (0 downto 0);
        out_12 : out std_logic_vector (0 downto 0);
        out_13 : out std_logic_vector (0 downto 0);
        out_14 : out std_logic_vector (0 downto 0);
        out_15 : out std_logic_vector (0 downto 0);
        out_16 : out std_logic_vector (0 downto 0);
        out_17 : out std_logic_vector (0 downto 0);
        out_18 : out std_logic_vector (0 downto 0);                             
        out_21 : out std_logic_vector (0 downto 0);
        out_22 : out std_logic_vector (0 downto 0);
        out_23 : out std_logic_vector (0 downto 0);
        out_24 : out std_logic_vector (0 downto 0);
        out_25 : out std_logic_vector (0 downto 0);
        out_26 : out std_logic_vector (0 downto 0);
        out_27 : out std_logic_vector (0 downto 0);
        out_28 : out std_logic_vector (0 downto 0)
		);
	end component Digital_Outputs_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
Digital_Outputs_v1_0_S00_AXI_inst : Digital_Outputs_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready,
		out_01 => out_01,
        out_02 => out_02,
        out_03 => out_03,
        out_04 => out_04,
        out_05 => out_05,
        out_06 => out_06,
        out_07 => out_07,
        out_08 => out_08,                                                
        out_11 => out_11,
        out_12 => out_12,
        out_13 => out_13,
        out_14 => out_14,
        out_15 => out_15,
        out_16 => out_16,
        out_17 => out_17,
        out_18 => out_18,                                                        
        out_21 => out_21,
        out_22 => out_22,
        out_23 => out_23,
        out_24 => out_24,
        out_25 => out_25,
        out_26 => out_26,
        out_27 => out_27,
        out_28 => out_28
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
