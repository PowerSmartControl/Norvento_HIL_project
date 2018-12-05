--        ---------------------------------------
--        --     Power Smart Control | JRF | 2018
--        --
--        --           I2C driver
--        --            testbench
--        ---------------------------------------
    
--    library ieee;
--    use ieee.std_logic_1164.all;
--    use ieee.numeric_std.all;
    
--    entity tb_i2c_controller is
--    end tb_i2c_controller;
    
--    architecture rtl of tb_i2c_controller is
    
--    component i2c_master
--        generic(
--           input_clk : INTEGER := 50_000_000; --input clock speed from user logic in Hz
--           bus_clk   : INTEGER := 400_000 );   --speed the i2c bus (scl) will run at in Hz
--        port (
--           clk       : IN     STD_LOGIC;                    --system clock
--           reset_n   : IN     STD_LOGIC;                    --active low reset
--           ena       : IN     STD_LOGIC;                    --latch in command
--           addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
--           rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
--           data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
--           busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
--           data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
--           ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
--           sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
--           scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
--        end component;
    
--      signal input_clk : INTEGER range 0 to 100_000_000   := 50_000_000; 
--      signal bus_clk   : INTEGER range 0 to 600_000       := 400_000;  
--      signal clk       :  STD_LOGIC:='0';                   
--      signal reset_n   :  STD_LOGIC:='0';                   
--      signal ena       :  STD_LOGIC:='0';                   
--      signal addr      :  STD_LOGIC_VECTOR(6 DOWNTO 0);
--      signal rw        :  STD_LOGIC;                   
--      signal data_wr   :  STD_LOGIC_VECTOR(7 DOWNTO 0);
--      signal busy      :  STD_LOGIC;                   
--      signal data_rd   :  STD_LOGIC_VECTOR(7 DOWNTO 0);
--      signal ack_error :  STD_LOGIC;                   
--      signal sda       :  STD_LOGIC;                   
--      signal scl       :  STD_LOGIC;                  
    
--    begin
    
--        clk         <= not clk after 5 ns;
--        reset_n     <= '0', '1' after 200 ns;
        
        
--        process
--        begin
--          ena<='0';
--          wait for 100us;               
--          ena<='1';
--          wait for 10us;
--        end process;

        
----        --**********************************************************************************
----        --read from slave
----        --**********************************************************************************     
----        process
----         begin
----          ena<='0';
----          wait for 100us;               
----          ena<='1';
----          wait for 10us;
----        end process;
        
----         process          --first slv ack
----         begin
----          sda<='Z';
----          wait for 112_195ns;               
----          sda<='0';
----          wait for 1.25us;
----          sda<='Z';
----        end process;
        
----        process          --second slv ack
----         begin
----          sda<='Z';
----          wait for 123.445us;               
----          sda<='0';
----          wait for 1.25us;
----          sda<='Z';
----        end process;
        
----        process          --emulating slv sending data
----        begin
----         sda<='Z';
----         wait for 113.445us; 
                       
----         sda<='0';          --1st bit data
----         wait for 1.25us;         
----         sda<='0';          --2 bit data
----         wait for 1.25us;         
----         sda<='1';          --3 bit data
----         wait for 1.25us;         
----         sda<='1';          --4 bit data
----         wait for 1.25us;         
----         sda<='1';          --5 bit data
----         wait for 1.25us;         
----         sda<='1';          --6 bit data
----         wait for 1.25us;         
----         sda<='1';          --7 bit data
----         wait for 1.25us;         
----         sda<='0';          --8 bit data
----         wait for 1.25us;
         
----         sda<='Z';          --release the bus data line
----       end process;
                
--        addr        <="0000000", "1110000" after 1us;
--        data_wr     <="00000000";   --unused, just for initialisation
--        rw         <='1';  --write
        
        
--        --**********************************************************************************
--        --instantiation
--        --**********************************************************************************    
--        i2c_master_uut : i2c_master generic map(input_clk=>input_clk, bus_clk=>bus_clk) port map(clk=> clk, reset_n=>reset_n, ena=>ena, addr=>addr, rw=>rw, data_wr=>data_wr, busy=>busy, data_rd=>data_rd, ack_error=>ack_error, sda=>sda, scl=>scl);
        
--    end rtl;











