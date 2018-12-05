        ---------------------------------------
        --     Power Smart Control | JRF | 2018
        --
        --           TCA9538 driver
        ---------------------------------------
     
        
        library ieee;
        use ieee.std_logic_1164.all; 
        use ieee.numeric_std.all;
        
        entity TCA9538_driver_input is
               Port ( 
               CLK              : in     STD_LOGIC;      
               RST              : in     STD_LOGIC;
               start_in         : in     STD_LOGIC;               
               address_in       : in     STD_LOGIC_VECTOR(6 DOWNTO 0);               
               data_out         : out    STD_LOGIC_VECTOR(7 DOWNTO 0);                 
               nRST_out         : out    STD_LOGIC;
               sda              : INOUT  STD_LOGIC;                  
               scl              : INOUT  STD_LOGIC);                  
        end TCA9538_driver_input;
        
        architecture TCA9538_input of TCA9538_driver_input is
        
            component i2c_master
                GENERIC(
                    input_clk : INTEGER := 100_000_000; --input clock speed from user logic in Hz
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
        
            constant input_clk : INTEGER := 100_000_000; 
            constant bus_clk   : INTEGER := 400_000;   
                
            signal command     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal ena         : STD_LOGIC;                    
            signal addr        : STD_LOGIC_VECTOR(6 DOWNTO 0); 
            signal rw          : STD_LOGIC;                    
            signal data_wr     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal busy        : STD_LOGIC;                    
            signal data_rd     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal ack_error   : STD_LOGIC;  
            
            type   FSM IS(start, write, wait_1, read, wait_2);
            signal FSM_state  : FSM;  
                                
            signal counter_0 : integer range 0 to 100000;   
            
            signal counter_400 : integer range 0 to 100000;              
            signal enable_400k :  std_logic;          
                
        begin
                              
        i2c_master_uut : i2c_master 
                generic map(
                        input_clk=> input_clk, bus_clk=> bus_clk) 
                port map(clk=>CLK, reset_n=>RST, ena=>ena, addr=>addr, rw=>rw, data_wr=>data_wr, 
                        busy=>busy, data_rd=>data_rd, ack_error=>ack_error, sda=>sda, scl=>scl);
        
        nRST_out<=RST;
            --i2c read
        
        process (CLK, RST)
        begin
            if RST='0' then
                enable_400k<='0';            
            elsif (CLK'event and CLK='1') then                
                counter_400<=counter_400+1;
                if counter_400>249 then --249 then
                    counter_400<=0;
                    enable_400k<='1';
                else
                    enable_400k<='0';
                end if;            
            end if;            
        end process;
        
        
        process (CLK, RST)
        begin
            if RST='0' then
               FSM_state<=start;
               ena<='0';
               addr<= "0000000";
               data_wr<="00000000";
               counter_0<=0;
               command<="00000000";
               data_out<="00000000";
               
            elsif (CLK'event and CLK='1') then 
                
               
                if enable_400k='1' then         --this code should run at 400KHz (i2c speed)
            
                    case FSM_state is
                    
                         WHEN start => 
                            if start_in='1' then
                               FSM_state<=write;
                            else 
                               FSM_state<=start;
                            end if;
                            ena<='0';
                        
                         WHEN write => 
                            addr<=address_in;
                            data_wr<=command;
                            rw<='0';        --write
                            ena<='0';                            
                            FSM_state<=wait_1;
                            counter_0<=0;
                            
                         WHEN wait_1 => 
                            ena<='1';
                            if counter_0>17 then
                                 counter_0<=0;
                                 --ena<='1';
                                 FSM_state<=read;   
                            else
                                 --ena<='0';
                                 FSM_state<=wait_1;  
                            end if; 
                            
                            counter_0<=counter_0+1;
                  
                         WHEN read => 
                             rw<='1';        --read
                             FSM_state<=wait_2;
                             counter_0<=0;
                             
                                                       
                         WHEN wait_2 => --wait while i2c is sending the first messagge
                              
                              if counter_0>18 then
                                   counter_0<=0;
                                   ena<='0';
                                   FSM_state<=start;   
                                   data_out<=data_rd;
                              else
                                   ena<='0';
                                   FSM_state<=wait_2;  
                              end if; 
                              
                              counter_0<=counter_0+1;
                                                                             
                         WHEN others =>
                            FSM_state<=FSM_state;
                            
                         end case;
                         
                   else --enable_400k
                   end if; 
             
                
            end if;
        
        end process;
        

        
        
--        process (CLK, RST)
--        begin
--            if RST='0' then
--                addr    <=(others => '0');
--                command  <=(others => '0');
--                data_wr <=(others => '0');
--                counter <=0;
--                rw<='0';
            
--            elsif (CLK'event and CLK='1') then 
            
--                command<="00000001"; --write command
--                rw<='0';
            
--                --if (counter=0 and start_in='1') then
--                   -- if start
--                    addr<= address_1_in;
--                    data_wr<= data_1_in;
--                    counter<=counter+1;
                   
--                elsif (counter=1 and start_in='1') then
--                    addr<= address_2_in;
--                    data_wr<= data_2_in;
--                    counter<=counter+1;
                 
--               elsif (counter=2 and start_in='1') then
--                    addr<= address_3_in;
--                    data_wr<= data_3_in;
--                    counter<=0;     
   
--               end if;
                
--            end if;
        
--        end process;
        
        
        
            
        
        end TCA9538_input;

