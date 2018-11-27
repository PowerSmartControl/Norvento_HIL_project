
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 

entity tb1 is
end tb1;

Architecture Behavioral_1 of tb1 is

    component AD_5293_v2
         Port (   clk                : in std_logic;   
                  RST                : in std_logic;               
                  DATA1              : in std_logic_vector(9 downto 0);
                  DATA2              : in std_logic_vector(9 downto 0);
                  DATA3              : in std_logic_vector(9 downto 0);
                  DATA4              : in std_logic_vector(9 downto 0);
                  D1                 : out std_logic;
                  D2                 : out std_logic;
                  D3                 : out std_logic;
                  D4                 : out std_logic;   
                  START              : in std_logic;  
                  CLK_OUT            : out std_logic;
                  nSYNC              : out std_logic;             
                  DONE               : out std_logic);
    end component;
    
   
    signal clk        : std_logic:='0';   
    signal RST        : std_logic;               
    signal DATA1      : std_logic_vector(9 downto 0);
    signal DATA2      : std_logic_vector(9 downto 0);
    signal DATA3      : std_logic_vector(9 downto 0);
    signal DATA4      : std_logic_vector(9 downto 0);
    signal D1         : std_logic;
    signal D2         : std_logic;
    signal D3         : std_logic;
    signal D4         : std_logic;   
    signal START      : std_logic:='0';  
    signal CLK_OUT    :  std_logic;
    signal nSYNC      :  std_logic;             
    signal DONE       :  std_logic;  
    
begin
    AD_5293_v2_uut: AD_5293_v2 
        port map (
            clk     => clk     ,
            RST     => RST     ,
            DATA1   => DATA1   ,
            DATA2   => DATA2   ,
            DATA3   => DATA3   ,
            DATA4   => DATA4   ,
            D1      => D1      ,
            D2      => D2      ,
            D3      => D3      ,
            D4      => D4      ,
            START   => START   ,
            CLK_OUT => CLK_OUT ,
            nSYNC   => nSYNC   ,
            DONE    => DONE    );
              
        
    clk    <= not(clk) after 10ns;    
    RST    <= '0', '1' after 50ns;
 
    DATA1  <= "0111010001";
    DATA2  <= "0111010001";
    DATA3  <= "0111010001";
    DATA4  <= "0111010001";
    
    START<= not(start) after 800ns;
    
   
    
end Behavioral_1;


