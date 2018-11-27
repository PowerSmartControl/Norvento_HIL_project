        ---------------------------------------
        --     Power Smart Control | JRF | 2018
        --
        --           DAC121S101 driver
        ---------------------------------------
     
        
        library ieee;
        use ieee.std_logic_1164.all;
        use ieee.numeric_std.all;
        
        entity DAC121S101_driver is
               Port ( 
               CLK_in       : in   STD_LOGIC;      
               RST_in       : in   STD_LOGIC;
               start_in     : in   STD_LOGIC;      
               data_in      : in   std_logic_vector(11 downto 0);
               SCLK_out     : out  STD_LOGIC;
               nSync_out    : out  STD_LOGIC;
               Din_out      : out  STD_LOGIC);    
        end DAC121S101_driver;
        
        architecture DAC121S101 of DAC121S101_driver is
        
            component spi_controller
                generic(
                    N                     : integer range 0 to 31:= 8;      -- number of bit to serialize
                    CLK_DIV               : integer range 0 to 120:= 100 );  -- input clock divider to generate output serial clock; o_sclk frequency = i_clk/(2*CLK_DIV)
                port (
                    i_clk                       : in  std_logic;
                    i_rstb                      : in  std_logic;
                    i_tx_start                  : in  std_logic;  -- start TX on serial line
                    o_tx_end                    : out std_logic;  -- TX data completed; o_data_parallel available
                    i_data_parallel             : in  std_logic_vector(N-1 downto 0);  -- data to sent
                    o_data_parallel             : out std_logic_vector(N-1 downto 0);  -- received data
                    o_sclk                      : out std_logic;
                    o_ss                        : out std_logic;
                    o_mosi                      : out std_logic;
                    i_miso                      : in  std_logic);
            end component;
        
        constant N                          : integer range 0 to 31:= 16;      -- number of bit to serialize
        constant CLK_DIV                    : integer range 0 to 120:= 2;  -- input clock divider to generate output serial clock; o_sclk frequency = i_clk/(2*CLK_DIV)
        
        signal i_clk                       : std_logic:='0';
        signal i_rstb                      : std_logic;
        signal i_tx_start                  : std_logic;  -- start TX on serial line
        signal o_tx_end                    : std_logic;  -- TX data completed; o_data_parallel available
        signal i_data_parallel             : std_logic_vector(N-1 downto 0);  -- data to sent
        signal o_data_parallel             : std_logic_vector(N-1 downto 0);  -- received data
        signal o_sclk                      : std_logic;
        signal o_ss                        : std_logic;
        signal o_mosi                      : std_logic;
        signal i_miso                      : std_logic;
        
        signal mosi_test                   : std_logic_vector(N-1 downto 0);  -- tx data
        signal miso_test                   : std_logic_vector(N-1 downto 0);  -- received data
        signal count_rise                  : integer range 0 to 60;
        signal count_fall                  : integer range 0 to 60;
        
        signal data_plus_control           : std_logic_vector(15 downto 0); 
        signal control                     : std_logic_vector(3 downto 0):="0000"; 
                
        begin
        
        data_plus_control<=control&data_in;
                
        u_spi_controller : spi_controller generic map(N=> N, CLK_DIV=> CLK_DIV) port map(i_clk=> CLK_in, i_rstb=> RST_in, i_tx_start=> start_in, o_tx_end=> o_tx_end, i_data_parallel=>data_plus_control, o_data_parallel=> o_data_parallel, o_sclk=> SCLK_out, o_ss=> nSync_out, o_mosi=> Din_out, i_miso=> i_miso);
        
        end DAC121S101;

