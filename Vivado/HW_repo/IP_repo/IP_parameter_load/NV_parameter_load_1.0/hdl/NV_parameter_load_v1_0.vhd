-- PSC | Power Smart Control | JRF | 2018

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NV_parameter_load_v1_0 is
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
		
            P_wind              : out std_logic_vector (20 downto 0);
            t_step_C            : out std_logic_vector (31 downto 0);
            dt_L1               : out std_logic_vector (31 downto 0);
            dt_L2               : out std_logic_vector (31 downto 0);
            dt_C                : out std_logic_vector (31 downto 0);
            rC                  : out std_logic_vector (31 downto 0);
            counter_limit       : out std_logic_vector (31 downto 0);
            amp_a               : out std_logic_vector (31 downto 0);  
            amp_b               : out std_logic_vector (31 downto 0);
            amp_c               : out std_logic_vector (31 downto 0);
            Lcc_dt              : out std_logic_vector (31 downto 0);
            phase_step_on       : out std_logic_vector ( 0 downto 0);
            phase_step          : out std_logic_vector (31 downto 0);        
            DC_bus_fixed_volt   : out std_logic_vector (31 downto 0);
            lamda_e                 : out std_logic_vector (14 downto 0);
            Pole_Pairs          : out std_logic_vector (7 downto 0);
            inv_seq             : out std_logic_vector ( 0 downto 0);        
            DC_bus_fived        : out std_logic_vector ( 0 downto 0);
            mode_igbt_input_PMSM          : out std_logic_vector ( 0 downto 0);
            mode_igbt_input     : out std_logic_vector ( 0 downto 0);
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
end NV_parameter_load_v1_0;

architecture arch_imp of NV_parameter_load_v1_0 is

	-- component declaration
	component NV_parameter_load_v1_0_S00_AXI is
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
		
		    P_wind             : out std_logic_vector (20 downto 0);
            t_step_C           : out std_logic_vector (31 downto 0);
            dt_L1              : out std_logic_vector (31 downto 0);
            dt_L2              : out std_logic_vector (31 downto 0);
            dt_C               : out std_logic_vector (31 downto 0);
            rC                 : out std_logic_vector (31 downto 0);
            counter_limit      : out std_logic_vector (31 downto 0);
            amp_a              : out std_logic_vector (31 downto 0);  
            amp_b              : out std_logic_vector (31 downto 0);
            amp_c              : out std_logic_vector (31 downto 0);
            Lcc_dt             : out std_logic_vector (31 downto 0);
            phase_step_on      : out std_logic_vector ( 0 downto 0);
            phase_step         : out std_logic_vector (31 downto 0);        
            DC_bus_fixed_volt  : out std_logic_vector (31 downto 0);
            lamda_e                : out std_logic_vector (14 downto 0);
            Pole_Pairs                : out std_logic_vector (7 downto 0);
            inv_seq            : out std_logic_vector ( 0 downto 0);        
            DC_bus_fived       : out std_logic_vector ( 0 downto 0);
            mode_igbt_input_PMSM         : out std_logic_vector ( 0 downto 0);
            mode_igbt_input    : out std_logic_vector ( 0 downto 0)
        
		);
	end component NV_parameter_load_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
NV_parameter_load_v1_0_S00_AXI_inst : NV_parameter_load_v1_0_S00_AXI
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
		
        P_wind                =>P_wind                    ,
        t_step_C              =>t_step_C              ,
        dt_L1                 =>dt_L1                 ,
        dt_L2                 =>dt_L2                 ,
        dt_C                  =>dt_C                  ,
        rC                    =>rC                    ,
        counter_limit         =>counter_limit         ,
        amp_a                 =>amp_a                 ,
        amp_b                 =>amp_b                 ,
        amp_c                 =>amp_c                 ,
        Lcc_dt                =>Lcc_dt                 ,
        phase_step_on         =>phase_step_on         ,
        phase_step            =>phase_step            ,
        DC_bus_fixed_volt     =>DC_bus_fixed_volt     ,
        lamda_e                   =>lamda_e                   ,
        Pole_Pairs                   =>Pole_Pairs                   ,
        inv_seq               =>inv_seq               ,
        --unused regiter      =>--unused regiter      ,
        DC_bus_fived                  =>DC_bus_fived                  ,
        mode_igbt_input_PMSM                  =>mode_igbt_input_PMSM                  ,
        mode_igbt_input                  =>mode_igbt_input                  
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
