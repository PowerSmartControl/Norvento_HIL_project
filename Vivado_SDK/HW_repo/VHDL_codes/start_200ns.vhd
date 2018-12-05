--  PSC | Power Smart Control | JRF | 2018


library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
     
    entity start_GRID is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               start_grid_side : out STD_LOGIC);
    end start_GRID;
    
    architecture Behavioral of start_GRID is
    
        signal counter : integer  range 0 to 200;
                
    begin
    
     process (CLK, RST)
     begin
       if RST='0' then
          counter<= 0;  
          start_grid_side <='0';    
      elsif (CLK'event and CLK='1') then 

          counter<=counter+1;
         
          if (counter>48) then
            start_grid_side <='1';
            counter<=0;
          --elsif (counter>18) then
            --start_200n<='0';
          else
            start_grid_side<='0';
          end if;
           
       end if;
          
     end process;
    
    
    end Behavioral;
