--    ---------------------------------------
--    --     Power Smart Control | JRF | 2018
--    --
--    --           TCA9538 driver
--    --            testbench        
--    ---------------------------------------

--    library ieee;
--    use ieee.std_logic_1164.all;
--    use ieee.numeric_std.all;
    
--    entity tb_TCA9538_input is            
--    end tb_TCA9538_input;
    
--    architecture tb of tb_TCA9538_input is
    
--        component TCA9538_driver_input
--            Port ( 
--               CLK              : in     STD_LOGIC;      
--               RST              : in     STD_LOGIC;
--               start_in         : in     STD_LOGIC;               
--               address_in       : in     STD_LOGIC_VECTOR(6 DOWNTO 0);               
--               data_out         : out     STD_LOGIC_VECTOR(7 DOWNTO 0);                 
--               nRST_out         : out    STD_LOGIC;
--               sda              : INOUT  STD_LOGIC;                  
--               scl              : INOUT  STD_LOGIC);    
--        end component;
                                                             
--          signal  CLK              : STD_LOGIC:='0';                    
--          signal  RST              : STD_LOGIC;                    
--          signal  start_in         : STD_LOGIC;                    
--          signal  data_out        : STD_LOGIC_VECTOR(7 DOWNTO 0); 
--          signal  address_in     : STD_LOGIC_VECTOR(6 DOWNTO 0); 
         
--          signal  nRST_out         : STD_LOGIC;                    
--          signal  sda              : STD_LOGIC;                    
--          signal  scl              : STD_LOGIC;                   
           
            
--    begin
        
--        TCA9538_input_uut: TCA9538_driver_input port map (CLK=>CLK, RST=>RST, start_in=>start_in, data_out=>data_out, address_in=>address_in, nRST_out=>nRST_out, sda=>sda, scl=>scl);
        
--        CLK<= not (CLK) after 5ns;
--        RST<= '0', '1' after 200 ns;
        
--        address_in         <="1110000";
        
        
--       --**********************************************************************************
--       --write to slave
--       --**********************************************************************************
--       process
--        begin
--         start_in<='0';
--         wait for 100us;               
--         start_in<='1';
--         wait for 50us;
--         start_in<='0';
--         wait;
--       end process;
       
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
               

               
               
--       --**********************************************************************************
--       --read from slave
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
       
----       process          --emulating slv sending data
----       begin
----        sda<='Z';
----        wait for 113.445us; 
                      
----        sda<='0';          --1st bit data
----        wait for 1.25us;         
----        sda<='0';          --2 bit data
----        wait for 1.25us;         
----        sda<='1';          --3 bit data
----        wait for 1.25us;         
----        sda<='1';          --4 bit data
----        wait for 1.25us;         
----        sda<='1';          --5 bit data
----        wait for 1.25us;         
----        sda<='1';          --6 bit data
----        wait for 1.25us;         
----        sda<='1';          --7 bit data
----        wait for 1.25us;         
----        sda<='0';          --8 bit data
----        wait for 1.25us;
        
----        sda<='Z';          --release the bus data line
----      end process;
                       
----       address_in        <="0000000", "1011011" after 1us;
----       data_Write_in     <="00000000";   --unused, just for initialisation
----       Read_nWrite       <='1';  --write
               
        
           
--    end tb;
