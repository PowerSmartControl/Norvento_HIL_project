-- PSC | Power Smart Control | JRF | 2018
    
    library IEEE; 
    use IEEE.STD_LOGIC_1164.ALL; 
    use IEEE.STD_LOGIC_SIGNED.all;
    use IEEE.numeric_std.all; 
    use ieee.std_logic_arith.all;
    
    entity NV_multiplier is
        Port ( reset     : in STD_LOGIC;                     
               clk       : in STD_LOGIC;                         
               input_0_0 : in std_logic;
               input_0_1 : in std_logic;
               input_0_2 : in std_logic;
               input_0_3 : in std_logic;
               input_0_4 : in std_logic;
               input_0_5 : in std_logic;
               
               input_1_0 : in std_logic;
               input_1_1 : in std_logic;
               input_1_2 : in std_logic;
               input_1_3 : in std_logic;
               input_1_4 : in std_logic;
               input_1_5 : in std_logic;               
               
               output_0 : out std_logic;
               output_1 : out std_logic;
               output_2 : out std_logic;
               output_3 : out std_logic;
               output_4 : out std_logic;
               output_5 : out std_logic);
               
    end NV_multiplier;          
                            
    architecture Behavioral of NV_multiplier is
                                            
    begin
    
       output_0 <= input_1_0 AND input_0_0;
       output_1 <= input_1_1 AND input_0_1;
       output_2 <= input_1_2 AND input_0_2;
       output_3 <= input_1_3 AND input_0_3;
       output_4 <= input_1_4 AND input_0_4;
       output_5 <= input_1_5 AND input_0_5;      
      
    end Behavioral;     

     
 
    