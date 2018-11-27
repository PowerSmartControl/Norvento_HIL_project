
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

entity tb1 is
end tb1;

Architecture Behavioral_1 of tb1 is

    component gen_referencias
        Port ( reset              : in  STD_LOGIC;                          -- 0 1
               clk                : in  STD_LOGIC;                          -- 0 1     
               ma                 : in  std_logic_vector (10 downto 0);     -- 0->255
               T1                 : out std_logic;                          --disparos de transistores
               T2                 : out std_logic;
               T3                 : out std_logic;
               T4                 : out std_logic;
               T5                 : out std_logic;
               T6                 : out std_logic);
    end component;
    
    signal reset              : STD_LOGIC;                         
    signal clk                : STD_LOGIC:='0';                         
    signal ma                 : std_logic_vector (10 downto 0);    
    signal T1                 : std_logic;                         
    signal T2                 : std_logic;                         
    signal T3                 : std_logic;                         
    signal T4                 : std_logic;                         
    signal T5                 : std_logic;                                                                
    signal T6                 : std_logic;     
    
begin
    gen_referencias_uut: gen_referencias 
        port map (reset=>reset, clk=>clk, ma=>ma, T1=>T1, T2=>T2, T3=>T3, T4=>T4, T5=>T5, T6=>T6);
    
    
    --generacion de relojes, reset y enable    
    clk                 <= not(clk)         after 5ns;    --reloj general           (100MHz)
    reset               <= '1', '0'         after 100ns;
 
    ma<="00000111111";
    
    
end Behavioral_1;


