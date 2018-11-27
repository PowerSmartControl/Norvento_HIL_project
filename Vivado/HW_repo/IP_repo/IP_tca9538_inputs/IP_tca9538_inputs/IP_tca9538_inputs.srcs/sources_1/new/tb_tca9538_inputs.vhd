--    ---------------------------------------
--    --     Power Smart Control | JRF | 2018
--    --
--    --           TCA9538 driver
--    --            testbench        
--    ---------------------------------------

--    library ieee;
--    use ieee.std_logic_1164.all;
--    use ieee.numeric_std.all;
    
--    entity tb_TCA9538 is            
--    end tb_TCA9538;
    
--    architecture tb of tb_TCA9538 is
    
--        component TCA9538_driver
--            Port ( 
--               CLK_in           : in   STD_LOGIC;      
--               RST_in           : in   STD_LOGIC;
--               enable_in        : in   STD_LOGIC;
--               address_in       : in   STD_LOGIC_VECTOR(6 DOWNTO 0);
--               Read_nWrite      : in   STD_LOGIC;      
--               data_Write_in    : in   STD_LOGIC_VECTOR(7 DOWNTO 0);
--               data_Read_out    : out   STD_LOGIC_VECTOR(7 DOWNTO 0);
--               busy_out         : out  STD_LOGIC;
--               sda              : INOUT  STD_LOGIC;                  
--               scl              : INOUT  STD_LOGIC);   
--        end component;
        
--           signal CLK_in           : STD_LOGIC:='0';      
--           signal RST_in           : STD_LOGIC:='0';  
--           signal enable_in        : STD_LOGIC;
--           signal address_in       : STD_LOGIC_VECTOR(6 DOWNTO 0);
--           signal Read_nWrite      : STD_LOGIC;      
--           signal data_Write_in    : STD_LOGIC_VECTOR(7 DOWNTO 0);
--           signal data_Read_out    : STD_LOGIC_VECTOR(7 DOWNTO 0);
--           signal busy_out         : STD_LOGIC;
--           signal sda              : STD_LOGIC;                  
--           signal scl              : STD_LOGIC;  
            
--    begin
        
--        TCA9538_uut: TCA9538_driver port map (CLK_in=>CLK_in, RST_in=>RST_in, enable_in=>enable_in, address_in=>address_in, Read_nWrite=>Read_nWrite, data_Write_in=>data_Write_in, data_Read_out=>data_Read_out, busy_out=>busy_out, sda=>sda, scl=>scl);
        
--        CLK_in<= not (CLK_in) after 5ns;
--        RST_in<= '0', '1' after 200 ns;
        
--       --**********************************************************************************
--       --write to slave
--       --**********************************************************************************
----       process
----        begin
----         enable_in<='0';
----         wait for 100us;               
----         enable_in<='1';
----         wait for 10us;
----       end process;
       
----        process          --first slv ack
----        begin
----         sda<='Z';
----         wait for 112_195ns;               
----         sda<='0';
----         wait for 1.25us;
----         sda<='Z';
----       end process;
       
----       process          --second slv ack
----        begin
----         sda<='Z';
----         wait for 123.445us;               
----         sda<='0';
----         wait for 1.25us;
----         sda<='Z';
----       end process;
               
----       address_in        <="0000000", "1011011" after 1us;
----       data_Write_in     <="11111000";
----       Read_nWrite       <='0';  --write
               
               
--       --**********************************************************************************
--       --read from slave
--       --**********************************************************************************     
--       process
--        begin
--         enable_in<='0';
--         wait for 100us;               
--         enable_in<='1';
--         wait for 10us;
--       end process;
       
--        process          --first slv ack
--        begin
--         sda<='Z';
--         wait for 112_195ns;               
--         sda<='0';
--         wait for 1.25us;
--         sda<='Z';
--       end process;
       
--       process          --second slv ack
--        begin
--         sda<='Z';
--         wait for 123.445us;               
--         sda<='0';
--         wait for 1.25us;
--         sda<='Z';
--       end process;
       
--       process          --emulating slv sending data
--       begin
--        sda<='Z';
--        wait for 113.445us; 
                      
--        sda<='0';          --1st bit data
--        wait for 1.25us;         
--        sda<='0';          --2 bit data
--        wait for 1.25us;         
--        sda<='1';          --3 bit data
--        wait for 1.25us;         
--        sda<='1';          --4 bit data
--        wait for 1.25us;         
--        sda<='1';          --5 bit data
--        wait for 1.25us;         
--        sda<='1';          --6 bit data
--        wait for 1.25us;         
--        sda<='1';          --7 bit data
--        wait for 1.25us;         
--        sda<='0';          --8 bit data
--        wait for 1.25us;
        
--        sda<='Z';          --release the bus data line
--      end process;
                       
--       address_in        <="0000000", "1011011" after 1us;
--       data_Write_in     <="00000000";   --unused, just for initialisation
--       Read_nWrite       <='1';  --write
               
        
           
--    end tb;
