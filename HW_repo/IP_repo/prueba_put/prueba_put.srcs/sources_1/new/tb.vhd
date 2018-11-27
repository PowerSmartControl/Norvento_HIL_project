--  PSC | Power Smart Control | JRF | 2018

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

entity tb1 is
end tb1;

Architecture Behavioral_1 of tb1 is

    component AD_5293_v2
        Port ( clk                : in std_logic;   --100 MHz input clock
               RST                : in std_logic;               
               DATA1              : in std_logic_vector(9 downto 0);
               DATA2              : in std_logic_vector(9 downto 0);
               DATA3              : in std_logic_vector(9 downto 0);
               DATA4              : in std_logic_vector(9 downto 0);               
               START              : in std_logic;   --100 KHz signal
               D1                 : out std_logic;
               D2                 : out std_logic;
               D3                 : out std_logic;
               D4                 : out std_logic;   
               CLK_OUT            : out std_logic;  --2.4 MHz output clock
               nSYNC              : out std_logic);
    end component;
    
   
    signal clk          : std_logic:='0';
    signal RST          : STD_LOGIC:='0';
    signal DATA1        : std_logic_vector(9 downto 0);
    signal DATA2        : std_logic_vector(9 downto 0);
    signal DATA3        : std_logic_vector(9 downto 0);
    signal DATA4        : std_logic_vector(9 downto 0);               
    signal START        : std_logic:='0';
    signal D1           : std_logic;
    signal D2           : std_logic;
    signal D3           : std_logic;
    signal D4           : std_logic;   
    signal CLK_OUT      : std_logic;
    signal nSYNC        : std_logic;
   
    
begin
    AD_5293_uut: AD_5293_v2 
        port map (clk=>clk, RST=>RST, DATA1=>DATA1, DATA2 => DATA2, DATA3=>DATA3, DATA4=>DATA4, START=>START, D1=>D1, D2=>D2, D3=>D3, D4=>D4, CLK_OUT=>CLK_OUT, nSYNC=>nSYNC);
   
   clk      <= not(clk)     after 5ns;    --100kHz
   START    <= not(START)   after 5us;    --reloj general           (100MHz)  
   RST      <= '0', '1'     after 20ns;
   
   DATA1 <= "0001100100";
   DATA2 <= "0001100100";
   DATA3 <= "0001100100";
   DATA4 <= "0001100100";   
    
end Behavioral_1;


