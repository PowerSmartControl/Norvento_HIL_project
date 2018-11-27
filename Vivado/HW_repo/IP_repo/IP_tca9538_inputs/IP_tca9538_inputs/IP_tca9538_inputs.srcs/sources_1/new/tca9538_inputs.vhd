        ---------------------------------------
        --     Power Smart Control | JRF | 2018
        --
        --           TCA9538 driver
        ---------------------------------------
     
        
        library ieee;
        use ieee.std_logic_1164.all;
        use ieee.numeric_std.all;
        
        entity TCA9538_driver_inputs is
               Port ( 
               CLK_in           : in     STD_LOGIC;      
               RST_in           : in     STD_LOGIC;
               enable_in        : in     STD_LOGIC;
               address_in       : in     STD_LOGIC_VECTOR(6 DOWNTO 0);
               Read_nWrite      : in     STD_LOGIC;      
               data_Write_in    : in     STD_LOGIC_VECTOR(7 DOWNTO 0);
               data_Read_out    : out    STD_LOGIC_VECTOR(7 DOWNTO 0);
               busy_out         : out    STD_LOGIC;
               nRST_out         : out    STD_LOGIC;
               sda              : INOUT  STD_LOGIC;                  
               scl              : INOUT  STD_LOGIC);                  
        end TCA9538_driver_inputs;
        
        architecture TCA9538_input of TCA9538_driver_inputs is
        
            component i2c_master
                GENERIC(
                    input_clk : INTEGER := 50_000_000; --input clock speed from user logic in Hz
                    bus_clk   : INTEGER := 400_000);   --speed the i2c bus (scl) will run at in Hz
                PORT(
                    clk       : IN     STD_LOGIC;                    --system clock
                    reset_n   : IN     STD_LOGIC;                    --active low reset
                    ena       : IN     STD_LOGIC;                    --latch in command
                    addr      : IN     STD_LOGIC_VECTOR(6 DOWNTO 0); --address of target slave
                    rw        : IN     STD_LOGIC;                    --'0' is write, '1' is read
                    data_wr   : IN     STD_LOGIC_VECTOR(7 DOWNTO 0); --data to write to slave
                    busy      : OUT    STD_LOGIC;                    --indicates transaction in progress
                    data_rd   : OUT    STD_LOGIC_VECTOR(7 DOWNTO 0); --data read from slave
                    ack_error : BUFFER STD_LOGIC;                    --flag if improper acknowledge from slave
                    sda       : INOUT  STD_LOGIC;                    --serial data output of i2c bus
                    scl       : INOUT  STD_LOGIC);                   --serial clock output of i2c bus
            end component;
        
            constant input_clk : INTEGER := 50_000_000; 
            constant bus_clk   : INTEGER := 400_000;   
            signal clk         : STD_LOGIC;                    
            signal reset_n     : STD_LOGIC;                    
            signal ena         : STD_LOGIC;                    
            signal addr        : STD_LOGIC_VECTOR(6 DOWNTO 0); 
            signal rw          : STD_LOGIC;                    
            signal data_wr     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal busy        : STD_LOGIC;                    
            signal data_rd     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal ack_error   : STD_LOGIC;                      
                
        begin
                              
        i2c_master_uut : i2c_master generic map(input_clk=> input_clk, bus_clk=> bus_clk) port map(clk=>CLK_in, reset_n=>RST_in, ena=>enable_in, addr=>address_in, rw=>Read_nWrite, data_wr=>data_Write_in, busy=>busy_out, data_rd=>data_Read_out, ack_error=>ack_error, sda=>sda, scl=>scl);
        
        nRST_out<=reset_n;
        
        end TCA9538_input;

