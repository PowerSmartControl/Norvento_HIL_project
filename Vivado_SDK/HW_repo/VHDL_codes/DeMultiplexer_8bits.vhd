--  PSC | Power Smart Control | JRF | 2018
    
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
    
    entity De_Multiplexer_8b is 
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               data_in : in std_logic_vector (7 downto 0);
               data_out_0 : out std_logic;
               data_out_1 : out std_logic;
               data_out_2 : out std_logic;
               data_out_3 : out std_logic;
               data_out_4 : out std_logic;
               data_out_5 : out std_logic;
               data_out_6 : out std_logic;
               data_out_7 : out std_logic;
               NOT_data_out_7 : out std_logic                    
              );
    end De_Multiplexer_8b;
    
    architecture Behavioral of De_Multiplexer_8b is
    
        signal counter : integer  range 0 to 200;
        
    begin
    
     process (CLK, RST)
     begin
       if RST='0' then
          data_out_0 <='0';
          data_out_1 <='0';
          data_out_2 <='0';
          data_out_3 <='0';
          data_out_4 <='0';
          data_out_5 <='0';
          data_out_6 <='0';
          data_out_7 <='0';
          NOT_data_out_7<='0';
      elsif (CLK'event and CLK='1') then 
          data_out_0 <= data_in(0);
          data_out_1 <= data_in(1);
          data_out_2 <= data_in(2);
          data_out_3 <= data_in(3);
          data_out_4 <= data_in(4);
          data_out_5 <= data_in(5);
          data_out_6 <= data_in(6);
          data_out_7 <= data_in(7);
          NOT_data_out_7 <= not(data_in(7));
       end if;
          
     end process;
    
    
    end Behavioral;
