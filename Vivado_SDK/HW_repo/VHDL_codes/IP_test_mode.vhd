
    --     Power Smart Control | JRF | 2018

    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    
    entity Test_normal_mode_MUX is
           Port ( 
           CLK       : in   STD_LOGIC;      
           RST       : in   STD_LOGIC;
           
           --inputs
           mode                        :  in   STD_LOGIC;  
                                                                       
           Expansor_output_TEST_1      :  in   STD_LOGIC_VECTOR (7 downto 0);  
           Expansor_output_TEST_2      :  in   STD_LOGIC_VECTOR (7 downto 0); 
           Expansor_output_TEST_3      :  in   STD_LOGIC_VECTOR (7 downto 0); 
                                        
           Expansor_output_NORMAL_1    :  in   STD_LOGIC_VECTOR (7 downto 0);  
           Expansor_output_NORMAL_2    :  in   STD_LOGIC_VECTOR (7 downto 0); 
           Expansor_output_NORMAL_3    :  in   STD_LOGIC_VECTOR (7 downto 0);
           
           --outputs: 
           DigPot_output_1             : out   STD_LOGIC_VECTOR (9 downto 0); 
           DigPot_output_2             : out   STD_LOGIC_VECTOR (9 downto 0); 
           DigPot_output_3             : out   STD_LOGIC_VECTOR (9 downto 0); 
           DigPot_output_4             : out   STD_LOGIC_VECTOR (9 downto 0); 

           Expansor_output_1           : out   STD_LOGIC_VECTOR (7 downto 0);   
           Expansor_output_2           : out   STD_LOGIC_VECTOR (7 downto 0);   
           Expansor_output_3           : out   STD_LOGIC_VECTOR (7 downto 0) 
           );    
    end Test_normal_mode_MUX;
    
    architecture MUX of Test_normal_mode_MUX is
                                    
    begin
    
       process (CLK, RST)                                  
       begin
           if RST='0' then
               
               DigPot_output_1   <= (others => '0');
               DigPot_output_2   <= (others => '0');
               DigPot_output_3   <= (others => '0');
               DigPot_output_4   <= (others => '0');
                               
               Expansor_output_1 <= (others => '0');
               Expansor_output_2 <= (others => '0');
               Expansor_output_3 <= (others => '0');   
              
             
           elsif (CLK'event and CLK='1') then              --flanco subida
               if (mode='0') then   --normal mode
                     
                    DigPot_output_1  <= DigPot_output_NORMAL_1;
                    DigPot_output_2  <= DigPot_output_NORMAL_2;
                    DigPot_output_3  <= DigPot_output_NORMAL_3;
                    DigPot_output_4  <= DigPot_output_NORMAL_4;
                                    
                    Expansor_output_1<= Expansor_output_NORMAL_1;
                    Expansor_output_2<= Expansor_output_NORMAL_2;
                    Expansor_output_3<= Expansor_output_NORMAL_3;
                     
               else   --test mode     
                    DigPot_output_1  <= DigPot_output_TEST_1;    
                    DigPot_output_2  <= DigPot_output_TEST_2;    
                    DigPot_output_3  <= DigPot_output_TEST_3;    
                    DigPot_output_4  <= DigPot_output_TEST_4;    
                                                                   
                    Expansor_output_1<= Expansor_output_TEST_1;  
                    Expansor_output_2<= Expansor_output_TEST_2;  
                    Expansor_output_3<= Expansor_output_TEST_3;  
                
             end if;       
                    
           end if;
       end process;
       
       
    end MUX;

