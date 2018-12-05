        ---------------------------------------
        --     Power Smart Control | JRF | 2018
        --
        --           TCA9538 driver
        ---------------------------------------
     
        
        library ieee;
        use ieee.std_logic_1164.all; 
        use ieee.numeric_std.all;
        
        entity TCA9538_driver is
               Port ( 
               CLK              : in     STD_LOGIC;      
               RST              : in     STD_LOGIC;
               start_in         : in     STD_LOGIC;
               
               data_1_in        : in     STD_LOGIC_VECTOR(7 DOWNTO 0);
               address_1_in     : in     STD_LOGIC_VECTOR(6 DOWNTO 0);
               data_2_in        : in     STD_LOGIC_VECTOR(7 DOWNTO 0);
               address_2_in     : in     STD_LOGIC_VECTOR(6 DOWNTO 0);
               data_3_in        : in     STD_LOGIC_VECTOR(7 DOWNTO 0);
               address_3_in     : in     STD_LOGIC_VECTOR(6 DOWNTO 0);  
                 
               nRST_out         : out    STD_LOGIC;
               sda              : INOUT  STD_LOGIC;                  
               scl              : INOUT  STD_LOGIC);                  
        end TCA9538_driver;
        
        architecture TCA9538 of TCA9538_driver is
        
            component i2c_master_2
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
            --signal clk         : STD_LOGIC;                    
            --signal reset_n     : STD_LOGIC;                    
            signal command     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal ena         : STD_LOGIC;                    
            signal addr        : STD_LOGIC_VECTOR(6 DOWNTO 0); 
            signal rw          : STD_LOGIC;                    
            signal data_wr     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal busy        : STD_LOGIC;                    
            signal data_rd     : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            signal ack_error   : STD_LOGIC;  
            signal first_run    : std_logic;
            
            type   FSM IS(start, address1, command1, data1, address2, command2, data2, address3, command3, data3, wait_1, wait_2, wait_3);
            signal FSM_state  : FSM;  
                                
            signal counter_0 : integer range 0 to 100000;   
--            signal counter_1 : integer range 0 to 100000;     
--            signal counter_2 : integer range 0 to 100000;   
--            signal counter_3 : integer range 0 to 100000;  
--            signal counter_4 : integer range 0 to 100000;   
--            signal counter_5 : integer range 0 to 100000;              
            
            signal counter_400 : integer range 0 to 100000;              
            signal enable_400k :  std_logic;          
                
        begin
                              
        i2c_master_2_uut : i2c_master_2 
                generic map(
                        input_clk=> input_clk, bus_clk=> bus_clk) 
                port map(clk=>CLK, reset_n=>RST, ena=>ena, addr=>addr, rw=>rw, data_wr=>data_wr, 
                        busy=>busy, data_rd=>data_rd, ack_error=>ack_error, sda=>sda, scl=>scl);
        
        nRST_out<=RST;
        
        process (CLK, RST)
        begin
            if RST='0' then
                enable_400k<='0';            
            elsif (CLK'event and CLK='1') then                
                counter_400<=counter_400+1;
                if counter_400>249 then --999 then
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
               command<="00000001";
               rw<='0';
               first_run<='0';
            elsif (CLK'event and CLK='1') then 
                
                rw<='0';
                if enable_400k='1' then         --this code should run at 400KHz (i2c speed)
            
                    case FSM_state is
                    
                         WHEN start => 
                            if start_in='1' then
                               FSM_state<=address1;
                            else 
                               FSM_state<=start;
                            end if;
                            ena<='0';
                        
                         WHEN address1 => 
                            addr<=address_1_in;
                            ena<='0';
                            FSM_state<=command1;
                            
                         WHEN command1 => 
                            if first_run='0' then
                                data_wr<="00000011";
                            else
                                data_wr<=command;
                            end if;
                            ena<='1';
                            
                            counter_0<=counter_0+1;
                            if counter_0>17 then
                                 counter_0<=0;
                                 --ena<='1';
                                 FSM_state<=data1;   
                            else
                                 --ena<='0';
                                 FSM_state<=command1;  
                            end if;  
                         
                         WHEN data1 =>    
                            if first_run='0' then
                                data_wr<="00000000";
                            else                        
                                data_wr<=data_1_in;
                           end if;
                           FSM_state<=wait_1;
                                                       
                         WHEN wait_1 => --wait while i2c is sending the first messagge
                              counter_0<=counter_0+1;
                              if counter_0>7 then
                                   counter_0<=0;
                                   FSM_state<=address2;   
                                   ena<='0';
                              else
                                   FSM_state<=wait_1;  
                              end if;
                         ------------------     
                          WHEN address2 => 
                             addr<=address_2_in;
                             ena<='0';
                             FSM_state<=command2;
                             
                          WHEN command2 => 
                             if first_run='0' then
                                  data_wr<="00000011";
                              else
                                  data_wr<=command;
                              end if;
                             ena<='1';
                             
                             counter_0<=counter_0+1;
                             if counter_0>17 then
                                  counter_0<=0;
                                  --ena<='1';
                                  FSM_state<=data2;   
                             else
                                  --ena<='0';
                                  FSM_state<=command2;  
                             end if;  
                          
                            WHEN data2 => 
                              if first_run='0' then
                                data_wr<="00000000";
                            else                        
                                data_wr<=data_2_in;
                           end if;
                              FSM_state<=wait_2;
                                                         
                           WHEN wait_2 => --wait while i2c is sending the first messagge
                                counter_0<=counter_0+1;
                                if counter_0>7 then
                                     counter_0<=0;
                                     FSM_state<=address3;   
                                     ena<='0';
                                else
                                     FSM_state<=wait_2;  
                                end if; 
                              
                         ------------------     
                              WHEN address3 => 
                                 addr<=address_3_in;
                                 ena<='0';
                                 FSM_state<=command3;
                                 
                              WHEN command3 => 
                                  if first_run='0' then
                                      data_wr<="00000011";
                                  else
                                      data_wr<=command;
                                  end if;                                 
                                 ena<='1';
                                 
                                 counter_0<=counter_0+1;
                                 if counter_0>17 then
                                      counter_0<=0;
                                      --ena<='1';
                                      FSM_state<=data3;   
                                 else
                                      --ena<='0';
                                      FSM_state<=command3;  
                                 end if;  
                              
                              WHEN data3 => 
                                 if first_run='0' then
                                      data_wr<="00000000";
                                  else                        
                                      data_wr<=data_3_in;
                                 end if;
                                 FSM_state<=wait_3;
                                                            
                              WHEN wait_3 => --wait while i2c is sending the first messagge
                                   counter_0<=counter_0+1;
                                   first_run<='1';
                                   if counter_0>7 then
                                        counter_0<=0;
                                        FSM_state<=start;   
                                        ena<='0';
                                   else
                                        FSM_state<=wait_3;  
                                   end if;       
                                                          
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
        
        
        
            
        
        end TCA9538;

