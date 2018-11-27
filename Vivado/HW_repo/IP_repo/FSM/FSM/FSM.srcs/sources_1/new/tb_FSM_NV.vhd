library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
    
    entity tb is
    end tb;
    
    architecture BBehavioral of tb is
    
        signal counter : integer  range 0 to 120;
            
        component FSM 
            Port ( CLK : in STD_LOGIC;
                   RST : in STD_LOGIC;
                   Start : out STD_LOGIC);
        end component;
                    
        signal CLK :  STD_LOGIC:='0';  
        signal RST :  STD_LOGIC;  
        signal Start : STD_LOGIC;
          
   begin
        uut: FSM 
            port map (CLK=>CLK, RST=>RST, Start=>Start);
            
            
       clk           <= not(clk)   after 10ns; 
       rst           <= '1', '0'   after 100ns;   
     
    
    end BBehavioral;