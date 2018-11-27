--  PSC | Power Smart Control | JRF | 2018


library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
     
    entity start_PMSM is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               start_pmsm_side : out STD_LOGIC);
    end start_PMSM;
    
    architecture Behavioral of start_PMSM is
    
        signal counter_2 : integer  range 0 to 200;
        
    begin
    
     process (CLK, RST)
     begin
       if RST='0' then
          counter_2<= 0;  
          start_pmsm_side <='0';
      elsif (CLK'event and CLK='1') then 

          counter_2<=counter_2+1;
          
          if (counter_2>73) then
            start_pmsm_side <='1';
            counter_2<=0;
          --elsif (counter>18) then
            --start_200n<='0';
          else
            start_pmsm_side<='0';
          end if;
                    
       end if;
          
     end process;
    
    
    end Behavioral;
