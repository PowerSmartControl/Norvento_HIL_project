--  PSC | Power Smart Control | JRF | 2018
    
    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_ARITH.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity AD_5293_v2 is
        Port ( clk                : in std_logic;   
               RST                : in std_logic;               
               DATA1              : in std_logic_vector(9 downto 0);
               DATA2              : in std_logic_vector(9 downto 0);
               DATA3              : in std_logic_vector(9 downto 0);
               DATA4              : in std_logic_vector(9 downto 0);
               D1                 : out std_logic;
               D2                 : out std_logic;
               D3                 : out std_logic;
               D4                 : out std_logic;   
               START              : in std_logic;  
               CLK_OUT            : out std_logic;
               nSYNC              : out std_logic;             
               DONE               : out std_logic);
    end AD_5293_v2 ;
    
    architecture AD_2 of AD_5293_v2 is
          --control constant: Normal Operation
          constant control_RESET      : std_logic_vector(5 downto 0) := "000100";
          constant control_WRITE      : std_logic_vector(5 downto 0) := "000001";
          constant control_ENABLE     : std_logic_vector(5 downto 0) := "001000";
          
          type states is (Idle, ShiftOut, SyncData);  
          signal current_state : states;
          signal next_state    : states;
                     
         --signal START         : std_logic;
          
          signal temp1         : std_logic_vector(15 downto 0);
          signal temp2         : std_logic_vector(15 downto 0);       
          signal temp3         : std_logic_vector(15 downto 0);
          signal temp4         : std_logic_vector(15 downto 0); 
            
          signal clk_div       : std_logic;      
          signal clk_counter   : std_logic_vector(27 downto 0);    
          signal shiftCounter  : std_logic_vector(3 downto 0); 
          signal enShiftCounter: std_logic;
          signal enParalelLoad : std_logic;
          signal control       : std_logic_vector(5 downto 0);
          
          signal counter_1       : integer range 0 to 10;
          signal flag            : integer range 0 to 10;
          signal star_prev      : std_logic;
          
          
    
    begin

          clock_divide : process(rst,clk)
          begin
              if rst = '0' then
                  clk_counter <= "0000000000000000000000000000";
              elsif (clk = '1' and clk'event) then
                  clk_counter <= clk_counter + '1';
              end if;
          end process;

          clk_div <= clk_counter(0);
          clk_out <= clk_counter(0);
          
          process (CLK, RST)
          begin
                if RST='0' then
                    counter_1<=0;
                    star_prev<='0';
                    control<=control_RESET;
                    flag<=0;
                elsif (CLK'event and CLk='1') then
                    
                    if START='1' and star_prev='0' then
                    
                        if counter_1=1 then
                            control<=control_RESET;
                            counter_1<=counter_1+1;
                            flag<=1;
                        elsif counter_1=2 then
                            control<=control_ENABLE;
                            counter_1<=counter_1+1;
                            flag<=2;
                        elsif counter_1=3 then
                            control<=control_WRITE; 
                            flag<=3;                         
                        else
                            counter_1<=counter_1+1;   
                            flag<=4;              
                        end if;
                        
                    end if;
                    
                    star_prev<=start;   --edge detector
                    
                end if;
          end process;
    
          counter : process(clk_div, enParalelLoad, enShiftCounter, counter_1)
          begin
                if (clk_div = '1' and clk_div'event) then
                   if enParalelLoad = '1' then
                       shiftCounter <= "0000";
                       
                       if flag=1 then 
                          temp1  <= control & "0000000000"; --reset
                          temp2  <= control & "0000000000";
                          temp3  <= control & "0000000000";
                          temp4  <= control & "0000000000";
                       elsif flag=2 then
                          temp1  <= control & "0000000010"; --enable wiper
                          temp2  <= control & "0000000010";
                          temp3  <= control & "0000000010";
                          temp4  <= control & "0000000010";                       
                       elsif flag=3 then                       
                          temp1  <= control & DATA1;    --write data
                          temp2  <= control & DATA2;
                          temp3  <= control & DATA3;
                          temp4  <= control & DATA4;                       
                       else
                          temp1  <= control & "0000000000"; --otherwisde no data
                          temp2  <= control & "0000000000";
                          temp3  <= control & "0000000000";
                          temp4  <= control & "0000000000";                       
                       end if;
                                                                                                                 
                    elsif (enShiftCounter = '1') then 
                       
                       temp1  <= temp1 (14 downto 0)&temp1 (15);
                       temp2  <= temp2 (14 downto 0)&temp2 (15);    
                       temp3  <= temp3 (14 downto 0)&temp3 (15);
                       temp4  <= temp4 (14 downto 0)&temp4 (15);    
                                                                                                                        
                       shiftCounter <= shiftCounter + '1';
                    end if;
                end if;
          end process;
    
          D1  <= temp1 (15);                             
          D2  <= temp2 (15);
          D3  <= temp3 (15);                             
          D4  <= temp4 (15); 
          
          SYNC_PROC: process (clk_div, rst)
          begin
             if (clk_div'event and clk_div = '1') then
                if (rst = '0') then
                   current_state <= Idle;
                else
                   current_state <= next_state;
                end if;        
             end if;
          end process;
        
         OUTPUT_DECODE: process (current_state)
         begin
              if current_state = Idle then
                    enShiftCounter <='0';
                    DONE <='1';
                    --START <='1';
                    nSYNC <='1';
                    enParalelLoad <= '1';
                elsif current_state = ShiftOut then
                    enShiftCounter <='1';
                    DONE <='0';
                    --START <='0';
                    nSYNC <='0';
                    enParalelLoad <= '0';
                else --if current_state = SyncData then
                    enShiftCounter <='0';
                    DONE <='0';
                    nSYNC <='1';
                    --START <='0';
                    enParalelLoad <= '0';
                end if;
           end process;
        
        NEXT_STATE_DECODE: process (current_state, START, shiftCounter)
        begin
          next_state <= current_state;  --default is to stay in current state
          case (current_state) is
             when Idle =>
                if START = '1' then
                   next_state <= ShiftOut;
                end if;
             when ShiftOut =>
                if shiftCounter = x"F" then
                   next_state <= SyncData;
                end if;
             when SyncData =>
                if START = '0' then
                next_state <= Idle;
                end if;
             when others =>
                next_state <= Idle;
          end case;      
       end process;
                
    end AD_2;
                