--  PSC | Power Smart Control | JRF | 2018
    
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
    
    entity bit_order_adjust_tca9538 is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               u10_data_in :   in STD_LOGIC_VECTOR (7 downto 0);
               u12_data_in :   in STD_LOGIC_VECTOR (7 downto 0);
               u14_data_in :   in STD_LOGIC_VECTOR (7 downto 0);
               u10_data_out : out STD_LOGIC_VECTOR (7 downto 0);
               u12_data_out : out STD_LOGIC_VECTOR (7 downto 0);
               u14_data_out : out STD_LOGIC_VECTOR (7 downto 0)
               );
    end bit_order_adjust_tca9538;
    
    architecture Behavioral of bit_order_adjust_tca9538 is
    begin
    
     process (CLK, RST)     
     begin
       if RST='0' then
         u10_data_out  <= (others=>'0');
         u12_data_out  <= (others=>'0');
         u14_data_out  <= (others=>'0');
      elsif (CLK'event and CLK='1') then 
         u10_data_out  <=  u10_data_in(4) & u10_data_in(5) & u10_data_in(6) & u10_data_in(7) & u10_data_in (3 downto 0);
         u12_data_out  <=  u12_data_in(4) & u12_data_in(5) & u12_data_in(6) & u12_data_in(7) & u12_data_in (3 downto 0);
         u14_data_out  <=  u14_data_in(4) & u14_data_in(5) & u14_data_in(6) & u14_data_in(7) & u14_data_in (3 downto 0);
        
       end if;
          
     end process;
    
    
    end Behavioral;
