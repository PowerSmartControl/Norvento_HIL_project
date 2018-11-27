--  PSC | Power Smart Control | JRF | 2018


library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
    
     
    entity truncate_bits is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;    
               start : in std_logic;
               
               in_1_AP_21_13 : in STD_LOGIC_vector (20 downto 0);
               in_2_AP_21_13 : in STD_LOGIC_vector (20 downto 0);
               in_3_AP_21_13 : in STD_LOGIC_vector (20 downto 0);
               in_4_AP_21_13 : in STD_LOGIC_vector (20 downto 0);
               in_5_AP_21_13 : in STD_LOGIC_vector (20 downto 0);
               in_6_AP_21_13 : in STD_LOGIC_vector (20 downto 0);
               
               out_1_AP_21_13 : out STD_LOGIC_vector (12 downto 0);
               out_2_AP_21_13 : out STD_LOGIC_vector (12 downto 0);
               out_3_AP_21_13 : out STD_LOGIC_vector (12 downto 0);
               out_4_AP_21_13 : out STD_LOGIC_vector (12 downto 0);
               out_5_AP_21_13 : out STD_LOGIC_vector (12 downto 0);
               out_6_AP_21_13 : out STD_LOGIC_vector (12 downto 0));
    end truncate_bits;
    
    architecture Behavioral of truncate_bits is
            
    begin   
    
     process (CLK, RST)
        begin
          if RST='0' then
               out_1_AP_21_13<= (others=>'0');
               out_2_AP_21_13<= (others=>'0');
               out_3_AP_21_13<= (others=>'0');
               out_4_AP_21_13<= (others=>'0');
               out_5_AP_21_13<= (others=>'0');
               out_6_AP_21_13<= (others=>'0');
               
         elsif (CLK'event and CLK='1') then 
            if (start='1') then
               out_1_AP_21_13<= in_1_AP_21_13 (20 downto 8);
               out_2_AP_21_13<= in_2_AP_21_13 (20 downto 8);
               out_3_AP_21_13<= in_3_AP_21_13 (20 downto 8);
               out_4_AP_21_13<= in_4_AP_21_13 (20 downto 8);
               out_5_AP_21_13<= in_5_AP_21_13 (20 downto 8);
               out_6_AP_21_13<= in_6_AP_21_13 (20 downto 8);
             end if;
             
         end if;
             
        end process;
       
     
      
    
    end Behavioral;
