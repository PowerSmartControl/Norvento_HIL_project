--  PSC | Power Smart Control | JRF | 2018

--not gate


    
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
    
    entity NOT_8 is
        Port ( CLK      : in STD_LOGIC;
               RST      : in STD_LOGIC;
               in_8     : in STD_LOGIC_VECTOR (7DOWNTO 0);
               out_8    : out STD_LOGIC_VECTOR (7DOWNTO 0)
               );
    end NOT_8;
    
    architecture Behavioral_3 of NOT_8 is
    
    begin
         
        out_8<=not(in_8);
    
    end Behavioral_3;
