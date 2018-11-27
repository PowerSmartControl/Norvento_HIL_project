library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parameter_load_2_v1_0 is
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
		rL2          : out std_logic_vector (31 downto 0);
        Preload      : out std_logic_vector (31 downto 0);
        ena_chop_res : out std_logic_vector (0 downto 0);
        rL1          : out std_logic_vector (31 downto 0);
        gain_current_grid : out std_logic_vector (31 downto 0);
        gain_voltage_grid : out std_logic_vector (31 downto 0);
        gain_dc_bus  : out std_logic_vector (31 downto 0);
        inv_R_eq     : out std_logic_vector (31 downto 0);
        mode_L_LCL   : out std_logic_vector (0 downto 0);
        download_RC  : out std_logic_vector ( 0 downto 0);
        Ld           : out std_logic_vector (15 downto 0);
        Lq           : out std_logic_vector (15 downto 0);
        Rs         : out std_logic_vector (25 downto 0);
        Wn         : out std_logic_vector (20 downto 0);
        gain_current_pmsm : out std_logic_vector (31 downto 0);
        gain_voltage_pmsm : out std_logic_vector (31 downto 0);
        Ls           : out std_logic_vector (15 downto 0);
        dT_Ls        : out std_logic_vector (19 downto 0);
        ma         : out std_logic_vector (10 downto 0);
        sp19         : out std_logic_vector (31 downto 0);
        sp20         : out std_logic_vector (31 downto 0);
        sp21         : out std_logic_vector (31 downto 0);
        sp22         : out std_logic_vector (31 downto 0);
        sp23         : out std_logic_vector (31 downto 0);
        sp24         : out std_logic_vector (31 downto 0);
        sp25         : out std_logic_vector (31 downto 0);
        sp26         : out std_logic_vector (31 downto 0);
        sp27         : out std_logic_vector (31 downto 0);
        sp28         : out std_logic_vector (31 downto 0);
        sp29         : out std_logic_vector (31 downto 0);
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
end parameter_load_2_v1_0;

architecture arch_imp of parameter_load_2_v1_0 is

	-- component declaration
	component parameter_load_2_v1_0_S00_AXI is
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
		rL2          : out std_logic_vector (31 downto 0);
        Preload      : out std_logic_vector (31 downto 0);
        ena_chop_res : out std_logic_vector (0 downto 0); 
        rL1          : out std_logic_vector (31 downto 0);
        gain_current_grid : out std_logic_vector (31 downto 0);
        gain_voltage_grid : out std_logic_vector (31 downto 0);
        gain_dc_bus  : out std_logic_vector (31 downto 0);
        inv_R_eq     : out std_logic_vector (31 downto 0);
        mode_L_LCL   : out std_logic_vector ( 0 downto 0);
        download_RC  : out std_logic_vector ( 0 downto 0);
        Ld         : out std_logic_vector (15 downto 0);
        Lq         : out std_logic_vector (15 downto 0);
        Rs         : out std_logic_vector (25 downto 0);
        Wn         : out std_logic_vector (20 downto 0);
        gain_current_pmsm : out std_logic_vector (31 downto 0);
        gain_voltage_pmsm : out std_logic_vector (31 downto 0);
        Ls           : out std_logic_vector (15 downto 0);
        dT_Ls        : out std_logic_vector (19 downto 0);
        ma         : out std_logic_vector (10 downto 0);
        sp19         : out std_logic_vector (31 downto 0);
        sp20         : out std_logic_vector (31 downto 0);
        sp21         : out std_logic_vector (31 downto 0);
        sp22         : out std_logic_vector (31 downto 0);
        sp23         : out std_logic_vector (31 downto 0);
        sp24         : out std_logic_vector (31 downto 0);
        sp25         : out std_logic_vector (31 downto 0);
        sp26         : out std_logic_vector (31 downto 0);
        sp27         : out std_logic_vector (31 downto 0);
        sp28         : out std_logic_vector (31 downto 0);
        sp29         : out std_logic_vector (31 downto 0)
		);
	end component parameter_load_2_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
parameter_load_2_v1_0_S00_AXI_inst : parameter_load_2_v1_0_S00_AXI
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
		rL2          => rL2          ,
        Preload      => Preload      ,
        ena_chop_res => ena_chop_res ,
       rL1          => rL1          ,
        gain_current_grid          => gain_current_grid          ,
        gain_voltage_grid          => gain_voltage_grid          ,
        gain_dc_bus           => gain_dc_bus           ,
        inv_R_eq          => inv_R_eq          ,
        mode_L_LCL          => mode_L_LCL          ,
        download_RC          => download_RC          ,
        Ld         => Ld         ,
        Lq         => Lq         ,
        Rs         => Rs         ,
        Wn         => Wn         ,
       gain_current_pmsm          => gain_current_pmsm          ,
        gain_voltage_pmsm          => gain_voltage_pmsm          ,
        Ls         => Ls         ,
        dT_Ls         => dT_Ls         ,
        ma         => ma         ,
        sp19         => sp19         ,
        sp20         => sp20         ,
        sp21         => sp21         ,
        sp22         => sp22         ,
        sp23         => sp23         ,
        sp24         => sp24         ,
        sp25         => sp25         ,
        sp26         => sp26         ,
        sp27         => sp27         ,
        sp28         => sp28         ,
        sp29         => sp29         
		
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
