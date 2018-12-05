--  PSC | Power Smart Control | JRF | 2018
    
    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use IEEE.STD_LOGIC_ARITH.ALL;
    use IEEE.STD_LOGIC_UNSIGNED.ALL;

    entity DAC_121s101 is
        Port ( clk                : in std_logic;   
               RST                : in std_logic;               
               DATA1              : in std_logic_vector(11 downto 0);
               DATA2              : in std_logic_vector(11 downto 0);
               DATA3              : in std_logic_vector(11 downto 0);
               DATA4              : in std_logic_vector(11 downto 0);
               DATA5              : in std_logic_vector(11 downto 0);
               DATA6              : in std_logic_vector(11 downto 0);
               DATA7              : in std_logic_vector(11 downto 0);
               DATA8              : in std_logic_vector(11 downto 0);
               DATA9              : in std_logic_vector(11 downto 0);
               DATA10             : in std_logic_vector(11 downto 0);
               DATA11             : in std_logic_vector(11 downto 0);
               DATA12             : in std_logic_vector(11 downto 0);
               DATA13             : in std_logic_vector(11 downto 0);
               DATA14             : in std_logic_vector(11 downto 0);
               DATA15             : in std_logic_vector(11 downto 0);
               DATA16             : in std_logic_vector(11 downto 0);
               DATA17             : in std_logic_vector(11 downto 0);
               D1                 : out std_logic;
               D2                 : out std_logic;
               D3                 : out std_logic;
               D4                 : out std_logic;
               D5                 : out std_logic;
               D6                 : out std_logic;
               D7                 : out std_logic;
               D8                 : out std_logic;
               D9                 : out std_logic;
               D10                : out std_logic;
               D11                : out std_logic;
               D12                : out std_logic;
               D13                : out std_logic;
               D14                : out std_logic;
               D15                : out std_logic;
               D16                : out std_logic;
               D17                : out std_logic;    
               CLK_OUT            : out std_logic;
               nSYNC              : out std_logic;             
               DONE               : out std_logic);
    end DAC_121s101 ;
    
    architecture DA2 of DAC_121s101 is
          --control constant: Normal Operation
          constant control     : std_logic_vector(3 downto 0) := "0000";
          type states is (Idle, ShiftOut, SyncData);  
          signal current_state : states;
          signal next_state    : states;
                     
          signal START         : std_logic;
          
          signal temp1         : std_logic_vector(15 downto 0);
          signal temp2         : std_logic_vector(15 downto 0);       
          signal temp3         : std_logic_vector(15 downto 0);
          signal temp4         : std_logic_vector(15 downto 0);  
          signal temp5         : std_logic_vector(15 downto 0);
          signal temp6         : std_logic_vector(15 downto 0);  
          signal temp7         : std_logic_vector(15 downto 0);
          signal temp8         : std_logic_vector(15 downto 0);  
          signal temp9         : std_logic_vector(15 downto 0);
          signal temp10         : std_logic_vector(15 downto 0);  
          signal temp11         : std_logic_vector(15 downto 0);
          signal temp12         : std_logic_vector(15 downto 0);  
          signal temp13         : std_logic_vector(15 downto 0);
          signal temp14         : std_logic_vector(15 downto 0);  
          signal temp15         : std_logic_vector(15 downto 0);
          signal temp16         : std_logic_vector(15 downto 0);  
          signal temp17         : std_logic_vector(15 downto 0);
            
          signal clk_div       : std_logic;      
          signal clk_counter   : std_logic_vector(27 downto 0);    
          signal shiftCounter  : std_logic_vector(3 downto 0); 
          signal enShiftCounter: std_logic;
          signal enParalelLoad : std_logic;
    
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
    
          counter : process(clk_div, enParalelLoad, enShiftCounter)
          begin
                if (clk_div = '1' and clk_div'event) then
                   if enParalelLoad = '1' then
                       shiftCounter <= "0000";
                       temp1  <= control & DATA1;
                       temp2  <= control & DATA2;
                       temp3  <= control & DATA3;
                       temp4  <= control & DATA4;      
                       temp5  <= control & DATA5;
                       temp6  <= control & DATA6;
                       temp7  <= control & DATA7;
                       temp8  <= control & DATA8; 
                       temp9  <= control & DATA9;
                       temp10 <= control & DATA10;
                       temp11 <= control & DATA11;
                       temp12 <= control & DATA12; 
                       temp13 <= control & DATA13;
                       temp14 <= control & DATA14;
                       temp15 <= control & DATA15;
                       temp16 <= control & DATA16; 
                       temp17 <= control & DATA17;                                                                                     
                    elsif (enShiftCounter = '1') then 
                       temp1  <= temp1 (14 downto 0)&temp1 (15);
                       temp2  <= temp2 (14 downto 0)&temp2 (15);    
                       temp3  <= temp3 (14 downto 0)&temp3 (15);
                       temp4  <= temp4 (14 downto 0)&temp4 (15);    
                       temp5  <= temp5 (14 downto 0)&temp5 (15);
                       temp6  <= temp6 (14 downto 0)&temp6 (15);
                       temp7  <= temp7 (14 downto 0)&temp7 (15);
                       temp8  <= temp8 (14 downto 0)&temp8 (15);  
                       temp9  <= temp9 (14 downto 0)&temp9 (15);
                       temp10 <= temp10(14 downto 0)&temp10(15);    
                       temp11 <= temp11(14 downto 0)&temp11(15);
                       temp12 <= temp12(14 downto 0)&temp12(15);  
                       temp13 <= temp13(14 downto 0)&temp13(15);
                       temp14 <= temp14(14 downto 0)&temp14(15);    
                       temp15 <= temp15(14 downto 0)&temp15(15);
                       temp16 <= temp16(14 downto 0)&temp16(15);  
                       temp17 <= temp17(14 downto 0)&temp17(15);
                                                                                                                        
                       shiftCounter <= shiftCounter + '1';
                    end if;
                end if;
          end process;
    
          D1  <= temp1 (15);                             
          D2  <= temp2 (15);
          D3  <= temp3 (15);                             
          D4  <= temp4 (15);
          D5  <= temp5 (15);                             
          D6  <= temp6 (15);
          D7  <= temp7 (15);                             
          D8  <= temp8 (15);
          D9  <= temp9 (15);                             
          D10 <= temp10(15);
          D11 <= temp11(15);                             
          D12 <= temp12(15);
          D13 <= temp13(15);                             
          D14 <= temp14(15);
          D15 <= temp15(15);                             
          D16 <= temp16(15);
          D17 <= temp17(15);    
          
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
                    START <='1';
                    nSYNC <='1';
                    enParalelLoad <= '1';
                elsif current_state = ShiftOut then
                    enShiftCounter <='1';
                    DONE <='0';
                    START <='0';
                    nSYNC <='0';
                    enParalelLoad <= '0';
                else --if current_state = SyncData then
                    enShiftCounter <='0';
                    DONE <='0';
                    nSYNC <='1';
                    START <='0';
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
                
    end DA2;
                