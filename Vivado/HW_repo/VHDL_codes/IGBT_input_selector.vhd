--  PSC | Power Smart Control | JRF | 2018
    
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
    
    entity IGBT_input_selector is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               mode: in std_logic;  --0=>test mode | 1=>NV inputs
               
               grid_T1_test : in std_logic;
               grid_T2_test : in std_logic;
               grid_T3_test : in std_logic;
               grid_T4_test : in std_logic;
               grid_T5_test : in std_logic;
               grid_T6_test : in std_logic;
               
               grid_T1_NV   : in std_logic;
               grid_T2_NV   : in std_logic;
               grid_T3_NV   : in std_logic;
               grid_T4_NV   : in std_logic;
               grid_T5_NV   : in std_logic;
               grid_T6_NV   : in std_logic;
               
               grid_T1      :out std_logic;
               grid_T2      :out std_logic;
               grid_T3      :out std_logic;
               grid_T4      :out std_logic;
               grid_T5      :out std_logic;
               grid_T6      :out std_logic              
               );
    end IGBT_input_selector;
    
    architecture Behavioral of IGBT_input_selector is
    
        signal counter : integer  range 0 to 200;
        
    begin
    
     process (CLK, RST)
     begin
       if RST='0' then
          grid_T1<='0';
          grid_T2<='0';
          grid_T3<='0';
          grid_T4<='0';
          grid_T5<='0';
          grid_T6<='0';
        
      elsif (CLK'event and CLK='1') then 
            if mode='0' then        --test mode
                grid_T1<=grid_T1_test;
                grid_T2<=grid_T2_test;
                grid_T3<=grid_T3_test;
                grid_T4<=grid_T4_test;
                grid_T5<=grid_T5_test;
                grid_T6<=grid_T6_test;            
            else        --normal mode
                grid_T1<=grid_T1_NV;
                grid_T2<=grid_T2_NV;
                grid_T3<=grid_T3_NV;
                grid_T4<=grid_T4_NV;
                grid_T5<=grid_T5_NV;
                grid_T6<=grid_T6_NV;
            end if;
       
       end if;
          
     end process;
    
    
    end Behavioral;
