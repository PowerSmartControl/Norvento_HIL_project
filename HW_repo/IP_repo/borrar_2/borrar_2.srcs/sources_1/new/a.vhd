--  PSC | Power Smart Control | JRF | 2018



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity AD1RefComp is
  Port    (    
    CLK      : in std_logic;         
    RST      : in std_logic;
    SDATA1   : in std_logic;
    SCLK     : out std_logic;
    nCS      : out std_logic;
    DATA1    : out std_logic_vector(11 downto 0);
    --START    : in std_logic; 
    DONE     : out std_logic
            );

end AD1RefComp ;

architecture AD1 of AD1RefComp is



          type states is (Idle, ShiftIn,  SyncData);  
          signal current_state : states;
          signal next_state    : states;
          signal temp1         : std_logic_vector(15 downto 0);
          signal clk_div       : std_logic;      
          signal clk_counter   : std_logic_vector(1 downto 0);    
          signal shiftCounter  : std_logic_vector(3 downto 0) := x"0"; 
          signal enShiftCounter: std_logic;
          signal enParalelLoad : std_logic;
          
          signal start : std_logic;


begin
     
        clock_divide : process(rst,clk)
        begin
            if rst = '0' then
                clk_counter <= "00";
            elsif (clk = '1' and clk'event) then
                clk_counter <= clk_counter + '1';
            end if;
        end process;

        clk_div <= clk_counter(1);
        SCLK <=  not clk_counter(1);



counter : process(clk_div, enParalelLoad, enShiftCounter)
        begin
            if (clk_div = '1' and clk_div'event) then
               
                if (enShiftCounter = '1') then 
                   temp1 <= temp1(14 downto 0) & SDATA1;
                    shiftCounter <= shiftCounter + '1';
                elsif (enParalelLoad = '1') then
                   shiftCounter <= "0000";
                   DATA1 <= temp1(11 downto 0);
                end if;
            end if;
        end process;
   
          
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
            start<='1';
            nCS <='1';
            enParalelLoad <= '0';
        elsif current_state = ShiftIn then
            enShiftCounter <='1';
            DONE <='0';
            nCS <='0';
            enParalelLoad <= '0';
            start<='0';
        else --if current_state = SyncData then
            enShiftCounter <='0';
            DONE <='0';
            nCS <='1';
            enParalelLoad <= '1';
            start<='0';
        end if;
   end process;    
    
  
    NEXT_STATE_DECODE: process (current_state, START, shiftCounter)
   begin
      
      next_state <= current_state;  -- default is to stay in current state
     
      case (current_state) is
         when Idle =>
            if START = '1' then
               next_state <= ShiftIn;
            end if;
         when ShiftIn =>
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


end AD1;
