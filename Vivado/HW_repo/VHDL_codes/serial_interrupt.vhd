--  PSC | Power Smart Control | JRF | 2018

    
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
    
    entity serial_interrupt is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               Console_1s_interrupt : out STD_LOGIC_VECTOR (0 downto 0)
               );
    end serial_interrupt; 
    
    architecture Behavioral of serial_interrupt is
    
        signal counter : integer  range 0 to 110_000_000;
         
    begin
    
     process (CLK, RST)
     begin
       if RST='0' then
          counter<= 0;  
          Console_1s_interrupt <="0";
      elsif (CLK'event and CLK='1') then 

          counter<=counter+1;
          
          if (counter>99_999_999) then
            Console_1s_interrupt <="1";
            counter<=0;
          elsif (counter>50) then
            Console_1s_interrupt<="0";
          else
            Console_1s_interrupt<="0";
          end if;
       end if;
          
     end process;
    
    
    end Behavioral;
