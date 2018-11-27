--        ---------------------------------------
--        --     Power Smart Control | JRF | 2018
--        --
--        --           AD5293 driver
--        --            testbench
--        ---------------------------------------
     
        
--        library ieee;
--        use ieee.std_logic_1164.all;
--        use ieee.numeric_std.all;
        
--        entity tb_AD5293 is            
--        end tb_AD5293;
        
--        architecture tb of tb_AD5293 is
        
--            component AD5293_driver
--                Port ( 
--                   CLK_in       : in   STD_LOGIC;      
--                   RST_in       : in   STD_LOGIC;
--                   start_in     : in   STD_LOGIC;      
--                   data_in      : in   std_logic_vector(9 downto 0);
--                   SCLK_out     : out  STD_LOGIC;
--                   nSync_out    : out  STD_LOGIC;
--                   Din_out      : out  STD_LOGIC;              
--                   RST_out      : out  STD_LOGIC);   
--            end component;
            
--            signal CLK_in       : STD_LOGIC:='0';      
--            signal RST_in       : STD_LOGIC:='0';
--            signal start_in     : STD_LOGIC:='0';      
--            signal data_in      : std_logic_vector(9 downto 0);
--            signal SCLK_out     : STD_LOGIC;
--            signal nSync_out    : STD_LOGIC;
--            signal Din_out      : STD_LOGIC;              
--            signal RST_out      : STD_LOGIC; 
                
--        begin
            
--            AD5293_uut: AD5293_driver port map (CLK_in=>CLK_in, RST_in=>RST_in, start_in=>start_in, data_in => data_in, SCLK_out=>SCLK_out, nSync_out=>nSync_out, Din_out=>Din_out, RST_out=>RST_out);
            
--            CLK_in<= not (CLK_in) after 5ns;
--            RST_in<= '0', '1' after 163 ns;
--            data_in<="1000111110";
            
--            process
--            begin
--                start_in<='0';
--                wait for 100us;
--                start_in<='1';
--                wait for 15ns;
--                start_in<='0';
                
--                wait for 100us;
--                start_in<='1';
--                wait for 15ns;
--                start_in<='0';
--           end process;
           
--        end tb;

