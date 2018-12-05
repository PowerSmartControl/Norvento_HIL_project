        ---------------------------------------
        --     Power Smart Control | JRF | 2018
        --
        --           AD5293 driver
        ---------------------------------------
     
        
        library ieee;
        use ieee.std_logic_1164.all;
        use ieee.numeric_std.all;
        
        entity AD5293_driver is
               Port ( 
               CLK_in       : in   STD_LOGIC;      
               RST_in       : in   STD_LOGIC;
               start_in     : in   STD_LOGIC;      
               data_in      : in   std_logic_vector(9 downto 0);
               SCLK_out     : out  STD_LOGIC;
               nSync_out    : out  STD_LOGIC;
               Din_out      : out  STD_LOGIC;              
               RST_out      : out  STD_LOGIC);    
        end AD5293_driver;
        
        architecture AD5293 of AD5293_driver is
        
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
        constant CLK_DIV                    : integer range 0 to 120:= 10;  -- input clock divider to generate output serial clock; o_sclk frequency = i_clk/(2*CLK_DIV)
        
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
        signal control                     : std_logic_vector(5 downto 0);
        
        signal counter                   : integer range 0 to 100;
                
        begin
        
        --data_plus_control<=control&data_in;
 
        
        u_spi_controller : spi_controller generic map(N=> N, CLK_DIV=> CLK_DIV) port map(i_clk=> CLK_in, i_rstb=> RST_in, i_tx_start=> start_in, o_tx_end=> o_tx_end, i_data_parallel=>data_plus_control, o_data_parallel=> o_data_parallel, o_sclk=> o_sclk, o_ss=> o_ss, o_mosi=> o_mosi, i_miso=> i_miso);
        
        process (CLK_in, RST_in)        
        begin
            if (RST_in='0') then
                control<="000100";  --reset comand of the IC (COMMAND 3)
                counter<=0;
            elsif (CLK_in='1' and CLK_in'event) then
            
                if start_in='1' then                
                    if (counter<2) then
                        control<="000100";      --COMMAND 3 (reset)
                        counter<=counter+1;
                        data_plus_control<="0001000000000000";
                        
                    elsif counter=2 then
                        control<="001000";      --COMMAND 6 (turn on).
                        counter<=counter+1;
                        data_plus_control<="0010000000000000";
                        
                    elsif counter=3 then
                        control<="000110";      --COMMAND 4 (enable wiper).
                        counter<=counter+1;
                        data_plus_control<="0001100000000010";
                    else                        
                        control<="000001";      --COMMAND 1 (program)
                        data_plus_control<="000001"&data_in;
                    end if;
                else
                    data_plus_control<=control&data_in;
                end if;
            end if;
        end process;
        
        
        process (RST_in, CLK_in)
        begin
            if RST_in='0' then
                  RST_out   <= '0';
                  SCLK_out  <= '0';
                  nSync_out <= '0';
                  Din_out   <= '0';
            elsif (CLK_in'event and CLK_in='0') then
                  RST_out   <= RST_in ;
                  SCLK_out  <= o_sclk ;
                  nSync_out <= o_ss   ;
                  Din_out   <= o_mosi ;   
            end if;
         end process; 
        
        end AD5293;

