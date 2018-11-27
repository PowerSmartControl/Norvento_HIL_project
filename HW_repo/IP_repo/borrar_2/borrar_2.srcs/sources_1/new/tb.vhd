
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

entity tb1 is
end tb1;

Architecture Behavioral_1 of tb1 is

    component AD1RefComp
         Port    (    
       CLK      : in std_logic;         
       RST      : in std_logic;
       SDATA1   : in std_logic;
       SCLK     : out std_logic;
       nCS      : out std_logic;
       DATA1    : out std_logic_vector(11 downto 0);
       --START    : in std_logic; 
       DONE     : out std_logic
               );
    end component;
    
   
    signal CLK      :std_logic:='0';                                
    signal RST      :std_logic;                                
    signal SDATA1   :std_logic;                                
    signal SCLK     : std_logic;                               
    signal nCS      : std_logic;                               
    signal DATA1    : std_logic_vector(11 downto 0);           
    signal DONE     : std_logic    ;    
    --signal start : std_logic; 
    
begin
    AD1RefComp_uut: AD1RefComp 
        port map (
             CLK    =>  CLK   ,
             RST    =>  RST   ,
             SDATA1 =>  SDATA1,
             SCLK   =>  SCLK  ,
             nCS    =>  nCS   ,
             DATA1  =>  DATA1 ,
             --START=>START,
             DONE   =>  DONE   );
              
        
    clk    <= not(clk) after 30ns;    
    RST    <= '0', '1' after 50ns;
 
    SDATA1  <= '1';
    --start <= '0', '1' after 10us;
    
    
   
    
end Behavioral_1;


