--  PSC | Power Smart Control | JRF | 2018


--  finite state machine in charge of controlling the init of the operation of HLS block.
--  This code generates the first start signal


    
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
    
    entity FSM is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               Start : out STD_LOGIC);
    end FSM;
    
    architecture Behavioral of FSM is
    
        signal counter : integer  range 0 to 200;
        
    begin
    
     process (CLK, RST)
     begin
       if RST='0' then
          counter<= 0;  
          start <='0';
      elsif (CLK'event and CLK='1') then 

          counter<=counter+1;
          
          if (counter>199) then
            start <='1';
            counter<=0;
          elsif (counter>5) then
            start<='0';
          else
            start<='0';
          end if;
       end if;
          
     end process;
    
    
    end Behavioral;
