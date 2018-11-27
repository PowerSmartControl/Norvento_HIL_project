
--    --     Power Smart Control | JRF | 2018

--    library ieee;
--    use ieee.std_logic_1164.all;
--    use ieee.numeric_std.all;

    
--    entity Test_normal_mode_MUX is
--           Port ( 
--           CLK       : in   STD_LOGIC;      
--           RST       : in   STD_LOGIC;
           
--           --inputs
--           mode                        :  in   STD_LOGIC;  
           
--           analog_output_TEST_1        :  in   STD_LOGIC_VECTOR (11 downto 0);   
--           analog_output_TEST_2        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_3        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_4        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_5        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_6        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_7        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_8        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_9        :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_10       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_11       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_12       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_13       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_14       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_15       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_16       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_17       :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_TEST_18       :  in   STD_LOGIC_VECTOR (11 downto 0); 
                                        
--           analog_output_NORMAL_1      :  in   STD_LOGIC_VECTOR (11 downto 0);   
--           analog_output_NORMAL_2      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_3      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_4      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_5      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_6      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_7      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_8      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_9      :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_10     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_11     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_12     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_13     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_14     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_15     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_16     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_17     :  in   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_NORMAL_18     :  in   STD_LOGIC_VECTOR (11 downto 0);    
                                       
--           DigPot_output_TEST_1        :  in   STD_LOGIC_VECTOR (9 downto 0);   
--           DigPot_output_TEST_2        :  in   STD_LOGIC_VECTOR (9 downto 0); 
--           DigPot_output_TEST_3        :  in   STD_LOGIC_VECTOR (9 downto 0);    
--           DigPot_output_TEST_4        :  in   STD_LOGIC_VECTOR (9 downto 0);    
                                        
--           DigPot_output_NORMAL_1      :  in   STD_LOGIC_VECTOR (9 downto 0);   
--           DigPot_output_NORMAL_2      :  in   STD_LOGIC_VECTOR (9 downto 0); 
--           DigPot_output_NORMAL_3      :  in   STD_LOGIC_VECTOR (9 downto 0);  
--           DigPot_output_NORMAL_4      :  in   STD_LOGIC_VECTOR (9 downto 0);  
                                    
--           Expansor_output_TEST_1      :  in   STD_LOGIC_VECTOR (7 downto 0);  
--           Expansor_output_TEST_2      :  in   STD_LOGIC_VECTOR (7 downto 0); 
--           Expansor_output_TEST_3      :  in   STD_LOGIC_VECTOR (7 downto 0); 
                                        
--           Expansor_output_NORMAL_1    :  in   STD_LOGIC_VECTOR (7 downto 0);  
--           Expansor_output_NORMAL_2    :  in   STD_LOGIC_VECTOR (7 downto 0); 
--           Expansor_output_NORMAL_3    :  in   STD_LOGIC_VECTOR (7 downto 0);
           
--           --outputs:           
--           analog_output_1             : out   STD_LOGIC_VECTOR (11 downto 0);   
--           analog_output_2             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_3             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_4             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_5             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_6             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_7             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_8             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_9             : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_10            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_11            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_12            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_13            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_14            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_15            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_16            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_17            : out   STD_LOGIC_VECTOR (11 downto 0); 
--           analog_output_18            : out   STD_LOGIC_VECTOR (11 downto 0); 
           
--           DigPot_output_1             : out   STD_LOGIC_VECTOR (9 downto 0); 
--           DigPot_output_2             : out   STD_LOGIC_VECTOR (9 downto 0); 
--           DigPot_output_3             : out   STD_LOGIC_VECTOR (9 downto 0); 
--           DigPot_output_4             : out   STD_LOGIC_VECTOR (9 downto 0); 

--           Expansor_output_1           : out   STD_LOGIC_VECTOR (7 downto 0);   
--           Expansor_output_2           : out   STD_LOGIC_VECTOR (7 downto 0);   
--           Expansor_output_3           : out   STD_LOGIC_VECTOR (7 downto 0) 
--           );    
--    end Test_normal_mode_MUX;
    
--    architecture MUX of Test_normal_mode_MUX is
--            signal counter : integer range 0 to 10000;
--            signal selector: std_logic;            
            
--            signal value_analog_output_1  : integer range 0 to 10000;
--            signal value_analog_output_2  : integer range 0 to 10000;
--            signal value_analog_output_3  : integer range 0 to 10000;
--            signal value_analog_output_4  : integer range 0 to 10000;
--            signal value_analog_output_5  : integer range 0 to 10000;
--            signal value_analog_output_6  : integer range 0 to 10000;
--            signal value_analog_output_7  : integer range 0 to 10000;
--            signal value_analog_output_8  : integer range 0 to 10000;
--            signal value_analog_output_9  : integer range 0 to 10000;
--            signal value_analog_output_10 : integer range 0 to 10000;
--            signal value_analog_output_11 : integer range 0 to 10000;
--            signal value_analog_output_12 : integer range 0 to 10000;
--            signal value_analog_output_13 : integer range 0 to 10000;
--            signal value_analog_output_14 : integer range 0 to 10000;
--            signal value_analog_output_15 : integer range 0 to 10000;
--            signal value_analog_output_16 : integer range 0 to 10000;
--            signal value_analog_output_17 : integer range 0 to 10000;
--            signal value_analog_output_18 : integer range 0 to 10000;
            
--            signal incr_1 : std_logic;
--            signal incr_2 : std_logic;
--            signal incr_3 : std_logic;
--            signal incr_4 : std_logic;
--            signal incr_5 : std_logic;
--            signal incr_6 : std_logic;
--            signal incr_7 : std_logic;
--            signal incr_8 : std_logic;
--            signal incr_9 : std_logic;
--            signal incr_10 : std_logic;
--            signal incr_11 : std_logic;
--            signal incr_12 : std_logic;
--            signal incr_13 : std_logic;
--            signal incr_14 : std_logic;
--            signal incr_15 : std_logic;
--            signal incr_16 : std_logic;
--            signal incr_17 : std_logic;
--            signal incr_18 : std_logic;
            
--    begin
    
--       process (CLK, RST)                                   --aqui se genera la triangular
--       begin
--           if RST='0' then
--               analog_output_1   <= (others => '0');
--               analog_output_2   <= (others => '0');
--               analog_output_3   <= (others => '0');
--               analog_output_4   <= (others => '0');
--               analog_output_5   <= (others => '0');
--               analog_output_6   <= (others => '0');
--               analog_output_7   <= (others => '0');
--               analog_output_8   <= (others => '0');
--               analog_output_9   <= (others => '0');
--               analog_output_10  <= (others => '0');
--               analog_output_11  <= (others => '0');
--               analog_output_12  <= (others => '0');
--               analog_output_13  <= (others => '0');
--               analog_output_14  <= (others => '0');
--               analog_output_15  <= (others => '0');
--               analog_output_16  <= (others => '0');
--               analog_output_17  <= (others => '0');
--               analog_output_18  <= (others => '0');
                                           
--               DigPot_output_1   <= (others => '0');
--               DigPot_output_2   <= (others => '0');
--               DigPot_output_3   <= (others => '0');
--               DigPot_output_4   <= (others => '0');
                               
--               Expansor_output_1 <= (others => '0');
--               Expansor_output_2 <= (others => '0');
--               Expansor_output_3 <= (others => '0');   
--               selector<='0';
--               counter<=0;  
               
--               incr_1 <='0';
--               incr_2 <='0';
--               incr_3 <='0';
--               incr_4 <='0';
--               incr_5 <='0';
--               incr_6 <='0';
--               incr_7 <='0';
--               incr_8 <='0';
--               incr_9 <='0';
--               incr_10<='0';
--               incr_11<='0';
--               incr_12<='0';
--               incr_13<='0';
--               incr_14<='0';
--               incr_15<='0';
--               incr_16<='0';
--               incr_17<='0';
--               incr_18<='0';  
               
--               value_analog_output_1 <=0;
--               value_analog_output_2 <=0;
--               value_analog_output_3 <=0;
--               value_analog_output_4 <=0;
--               value_analog_output_5 <=0;
--               value_analog_output_6 <=0;
--               value_analog_output_7 <=0;
--               value_analog_output_8 <=0;
--               value_analog_output_9 <=0;
--               value_analog_output_10<=0;
--               value_analog_output_11<=0;
--               value_analog_output_12<=0;
--               value_analog_output_13<=0;
--               value_analog_output_14<=0;
--               value_analog_output_15<=0;
--               value_analog_output_16<=0;
--               value_analog_output_17<=0;
--               value_analog_output_18<=0;   
             
--           elsif (CLK'event and CLK='1') then              --flanco subida
--               if (mode='0') then   --normal mode
--                     analog_output_1  <=  analog_output_NORMAL_1;
--                     analog_output_2  <=  analog_output_NORMAL_2;
--                     analog_output_3  <=  analog_output_NORMAL_3;
--                     analog_output_4  <=  analog_output_NORMAL_4;
--                     analog_output_5  <=  analog_output_NORMAL_5;
--                     analog_output_6  <=  analog_output_NORMAL_6;
--                     analog_output_7  <=  analog_output_NORMAL_7;
--                     analog_output_8  <=  analog_output_NORMAL_8;
--                     analog_output_9  <=  analog_output_NORMAL_9;
--                     analog_output_10 <=  analog_output_NORMAL_10;
--                     analog_output_11 <=  analog_output_NORMAL_11;
--                     analog_output_12 <=  analog_output_NORMAL_12;
--                     analog_output_13 <=  analog_output_NORMAL_13;
--                     analog_output_14 <=  analog_output_NORMAL_14;
--                     analog_output_15 <=  analog_output_NORMAL_15;
--                     analog_output_16 <=  analog_output_NORMAL_16;
--                     analog_output_17 <=  analog_output_NORMAL_17;
--                     analog_output_18 <=  analog_output_NORMAL_18;
                                       
--                     DigPot_output_1  <= DigPot_output_NORMAL_1;
--                     DigPot_output_2  <= DigPot_output_NORMAL_2;
--                     DigPot_output_3  <= DigPot_output_NORMAL_3;
--                     DigPot_output_4  <= DigPot_output_NORMAL_4;
                                     
--                     Expansor_output_1<= Expansor_output_NORMAL_1;
--                     Expansor_output_2<= Expansor_output_NORMAL_2;
--                     Expansor_output_3<= Expansor_output_NORMAL_3;
                     
--               else   --test mode
                    
--                    if (value_analog_output_1=-to_integer(signed(analog_output_TEST_1))) then
--                        incr_1<='1';
--                    elsif (value_analog_output_1=to_integer(signed(analog_output_TEST_1))) then
--                        incr_1<='0';
--                    end if;                    
--                    if (incr_1='1') then
--                        value_analog_output_1<=value_analog_output_1+1;
--                    else
--                        value_analog_output_1<=value_analog_output_1-1;
--                    end if;
                    
--                    if (value_analog_output_2=-to_integer(signed(analog_output_TEST_2))) then
--                        incr_2<='1';
--                    elsif (value_analog_output_2=to_integer(signed(analog_output_TEST_2))) then
--                        incr_2<='0';
--                    end if;                    
--                    if (incr_2='1') then
--                        value_analog_output_2<=value_analog_output_2+1;
--                    else
--                        value_analog_output_2<=value_analog_output_2-1;
--                    end if;
                    
--                    if (value_analog_output_3=-to_integer(signed(analog_output_TEST_3))) then
--                        incr_3<='1';
--                    elsif (value_analog_output_3=to_integer(signed(analog_output_TEST_3))) then
--                        incr_3<='0';
--                    end if;                    
--                    if (incr_3='1') then
--                        value_analog_output_3<=value_analog_output_3+1;
--                    else
--                        value_analog_output_3<=value_analog_output_3-1;
--                    end if;
                    
--                    if (value_analog_output_4=-to_integer(signed(analog_output_TEST_4))) then
--                        incr_4<='1';
--                    elsif (value_analog_output_4=to_integer(signed(analog_output_TEST_4))) then
--                        incr_4<='0';
--                    end if;                    
--                    if (incr_4='1') then
--                        value_analog_output_4<=value_analog_output_4+1;
--                    else
--                        value_analog_output_4<=value_analog_output_4-1;
--                    end if;
                    
--                    if (value_analog_output_5=-to_integer(signed(analog_output_TEST_5))) then
--                        incr_5<='1';
--                    elsif (value_analog_output_5=to_integer(signed(analog_output_TEST_5))) then
--                        incr_5<='0';
--                    end if;                    
--                    if (incr_5='1') then
--                        value_analog_output_5<=value_analog_output_5+1;
--                    else
--                        value_analog_output_5<=value_analog_output_5-1;
--                    end if;
                    
--                    if (value_analog_output_6=-to_integer(signed(analog_output_TEST_6))) then
--                        incr_6<='1';
--                    elsif (value_analog_output_6=to_integer(signed(analog_output_TEST_6))) then
--                        incr_6<='0';
--                    end if;                    
--                    if (incr_6='1') then
--                        value_analog_output_6<=value_analog_output_6+1;
--                    else
--                        value_analog_output_6<=value_analog_output_6-1;
--                    end if;
                    
--                    if (value_analog_output_7=-to_integer(signed(analog_output_TEST_7))) then
--                        incr_7<='1';
--                    elsif (value_analog_output_7=to_integer(signed(analog_output_TEST_7))) then
--                        incr_7<='0';
--                    end if;                    
--                    if (incr_7='1') then
--                        value_analog_output_7<=value_analog_output_7+1;
--                    else
--                        value_analog_output_7<=value_analog_output_7-1;
--                    end if;
                    
--                    if (value_analog_output_8=-to_integer(signed(analog_output_TEST_8))) then
--                        incr_8<='1';
--                    elsif (value_analog_output_8=to_integer(signed(analog_output_TEST_8))) then
--                        incr_8<='0';
--                    end if;                    
--                    if (incr_8='1') then
--                        value_analog_output_8<=value_analog_output_8+1;
--                    else
--                        value_analog_output_8<=value_analog_output_8-1;
--                    end if;
                    
--                    if (value_analog_output_9=-to_integer(signed(analog_output_TEST_9))) then
--                        incr_9<='1';
--                    elsif (value_analog_output_9=to_integer(signed(analog_output_TEST_9))) then
--                        incr_9<='0';
--                    end if;                    
--                    if (incr_9='1') then
--                        value_analog_output_9<=value_analog_output_9+1;
--                    else
--                        value_analog_output_9<=value_analog_output_9-1;
--                    end if;
                    
--                    if (value_analog_output_10=-to_integer(signed(analog_output_TEST_10))) then
--                        incr_10<='1';
--                    elsif (value_analog_output_10=to_integer(signed(analog_output_TEST_10))) then
--                        incr_10<='0';
--                    end if;                    
--                    if (incr_10='1') then
--                        value_analog_output_10<=value_analog_output_10+1;
--                    else
--                        value_analog_output_10<=value_analog_output_10-1;
--                    end if;
                    
--                    if (value_analog_output_11=-to_integer(signed(analog_output_TEST_11))) then
--                        incr_11<='1';
--                    elsif (value_analog_output_11=to_integer(signed(analog_output_TEST_11))) then
--                        incr_11<='0';
--                    end if;                    
--                    if (incr_11='1') then
--                        value_analog_output_11<=value_analog_output_11+1;
--                    else
--                        value_analog_output_11<=value_analog_output_11-1;
--                    end if;
                    
--                    if (value_analog_output_12=-to_integer(signed(analog_output_TEST_12))) then
--                        incr_12<='1';
--                    elsif (value_analog_output_12=to_integer(signed(analog_output_TEST_12))) then
--                        incr_12<='0';
--                    end if;                    
--                    if (incr_12='1') then
--                        value_analog_output_12<=value_analog_output_12+1;
--                    else
--                        value_analog_output_12<=value_analog_output_12-1;
--                    end if;
                    
--                    if (value_analog_output_13=-to_integer(signed(analog_output_TEST_13))) then
--                        incr_13<='1';
--                    elsif (value_analog_output_13=to_integer(signed(analog_output_TEST_13))) then
--                        incr_13<='0';
--                    end if;                    
--                    if (incr_13='1') then
--                        value_analog_output_13<=value_analog_output_13+1;
--                    else
--                        value_analog_output_13<=value_analog_output_13-1;
--                    end if;
                    
--                    if (value_analog_output_14=-to_integer(signed(analog_output_TEST_14))) then
--                        incr_14<='1';
--                    elsif (value_analog_output_14=to_integer(signed(analog_output_TEST_14))) then
--                        incr_14<='0';
--                    end if;                    
--                    if (incr_14='1') then
--                        value_analog_output_14<=value_analog_output_14+1;
--                    else
--                        value_analog_output_14<=value_analog_output_14-1;
--                    end if;
                    
--                    if (value_analog_output_15=-to_integer(signed(analog_output_TEST_15))) then
--                        incr_15<='1';
--                    elsif (value_analog_output_15=to_integer(signed(analog_output_TEST_15))) then
--                        incr_15<='0';
--                    end if;                    
--                    if (incr_15='1') then
--                        value_analog_output_15<=value_analog_output_15+1;
--                    else
--                        value_analog_output_15<=value_analog_output_15-1;
--                    end if;
                    
--                    if (value_analog_output_16=-to_integer(signed(analog_output_TEST_16))) then
--                        incr_16<='1';
--                    elsif (value_analog_output_16=to_integer(signed(analog_output_TEST_16))) then
--                        incr_16<='0';
--                    end if;                    
--                    if (incr_16='1') then
--                        value_analog_output_16<=value_analog_output_16+1;
--                    else
--                        value_analog_output_16<=value_analog_output_16-1;
--                    end if;      
                               
--                    if (value_analog_output_17=-to_integer(signed(analog_output_TEST_17))) then
--                        incr_17<='1';
--                    elsif (value_analog_output_17=to_integer(signed(analog_output_TEST_17))) then
--                        incr_17<='0';
--                    end if;                    
--                    if (incr_17='1') then
--                        value_analog_output_17<=value_analog_output_17+1;
--                    else
--                        value_analog_output_17<=value_analog_output_17-1;
--                    end if;
                    
--                    if (value_analog_output_18=-to_integer(signed(analog_output_TEST_18))) then
--                        incr_18<='1';
--                    elsif (value_analog_output_18=to_integer(signed(analog_output_TEST_18))) then
--                        incr_18<='0';
--                    end if;                    
--                    if (incr_18='1') then
--                        value_analog_output_18<=value_analog_output_18+1;
--                    else
--                        value_analog_output_18<=value_analog_output_18-1;
--                    end if;                                                         
                                                                                                    
                                
--                    analog_output_1  <= std_logic_vector(to_signed(value_analog_output_1 , 12)) ;
--                    analog_output_2  <= std_logic_vector(to_signed(value_analog_output_2 , 12)) ; 
--                    analog_output_3  <= std_logic_vector(to_signed(value_analog_output_3 , 12)) ; 
--                    analog_output_4  <= std_logic_vector(to_signed(value_analog_output_4 , 12)) ; 
--                    analog_output_5  <= std_logic_vector(to_signed(value_analog_output_5 , 12)) ; 
--                    analog_output_6  <= std_logic_vector(to_signed(value_analog_output_6 , 12)) ; 
--                    analog_output_7  <= std_logic_vector(to_signed(value_analog_output_7 , 12)) ; 
--                    analog_output_8  <= std_logic_vector(to_signed(value_analog_output_8 , 12)) ; 
--                    analog_output_9  <= std_logic_vector(to_signed(value_analog_output_9 , 12)) ; 
--                    analog_output_10 <= std_logic_vector(to_signed(value_analog_output_10, 12)) ; 
--                    analog_output_11 <= std_logic_vector(to_signed(value_analog_output_11, 12)) ; 
--                    analog_output_12 <= std_logic_vector(to_signed(value_analog_output_12, 12)) ; 
--                    analog_output_13 <= std_logic_vector(to_signed(value_analog_output_13, 12)) ; 
--                    analog_output_14 <= std_logic_vector(to_signed(value_analog_output_14, 12)) ; 
--                    analog_output_15 <= std_logic_vector(to_signed(value_analog_output_15, 12)) ; 
--                    analog_output_16 <= std_logic_vector(to_signed(value_analog_output_16, 12)) ; 
--                    analog_output_17 <= std_logic_vector(to_signed(value_analog_output_17, 12)) ; 
--                    analog_output_18 <= std_logic_vector(to_signed(value_analog_output_18, 12)) ; 
                                       
--                    DigPot_output_1  <= DigPot_output_TEST_1;    
--                    DigPot_output_2  <= DigPot_output_TEST_2;    
--                    DigPot_output_3  <= DigPot_output_TEST_3;    
--                    DigPot_output_4  <= DigPot_output_TEST_4;    
                                                                   
--                    Expansor_output_1<= Expansor_output_TEST_1;  
--                    Expansor_output_2<= Expansor_output_TEST_2;  
--                    Expansor_output_3<= Expansor_output_TEST_3;  
                    
                    
                
--             end if;       
                    
                    
                    
--           end if;
--       end process;
       
       
--    end MUX;


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
           
           analog_output_TEST_1        :  in   STD_LOGIC_VECTOR (11 downto 0);   
           analog_output_TEST_2        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_3        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_4        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_5        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_6        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_7        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_8        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_9        :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_10       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_11       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_12       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_13       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_14       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_15       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_16       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_17       :  in   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_TEST_18       :  in   STD_LOGIC_VECTOR (11 downto 0); 
                                        
           analog_output_NORMAL_1      :  in   STD_LOGIC_VECTOR (24 downto 0);   
           analog_output_NORMAL_2      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_3      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_4      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_5      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_6      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_7      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_8      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_9      :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_10     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_11     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_12     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_13     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_14     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_15     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_16     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_17     :  in   STD_LOGIC_VECTOR (24 downto 0); 
           analog_output_NORMAL_18     :  in   STD_LOGIC_VECTOR (24 downto 0);    
                                       
           DigPot_output_TEST_1        :  in   STD_LOGIC_VECTOR (9 downto 0);   
           DigPot_output_TEST_2        :  in   STD_LOGIC_VECTOR (9 downto 0); 
           DigPot_output_TEST_3        :  in   STD_LOGIC_VECTOR (9 downto 0);    
           DigPot_output_TEST_4        :  in   STD_LOGIC_VECTOR (9 downto 0);    
                                        
           DigPot_output_NORMAL_1      :  in   STD_LOGIC_VECTOR (9 downto 0);   
           DigPot_output_NORMAL_2      :  in   STD_LOGIC_VECTOR (9 downto 0); 
           DigPot_output_NORMAL_3      :  in   STD_LOGIC_VECTOR (9 downto 0);  
           DigPot_output_NORMAL_4      :  in   STD_LOGIC_VECTOR (9 downto 0);  
                                    
           Expansor_output_TEST_1      :  in   STD_LOGIC_VECTOR (7 downto 0);  
           Expansor_output_TEST_2      :  in   STD_LOGIC_VECTOR (7 downto 0); 
           Expansor_output_TEST_3      :  in   STD_LOGIC_VECTOR (7 downto 0); 
                                        
           Expansor_output_NORMAL_1    :  in   STD_LOGIC_VECTOR (7 downto 0);  
           Expansor_output_NORMAL_2    :  in   STD_LOGIC_VECTOR (7 downto 0); 
           Expansor_output_NORMAL_3    :  in   STD_LOGIC_VECTOR (7 downto 0);
           
           --outputs:           
           analog_output_1             : out   STD_LOGIC_VECTOR (11 downto 0);   
           analog_output_2             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_3             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_4             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_5             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_6             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_7             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_8             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_9             : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_10            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_11            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_12            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_13            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_14            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_15            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_16            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_17            : out   STD_LOGIC_VECTOR (11 downto 0); 
           analog_output_18            : out   STD_LOGIC_VECTOR (11 downto 0); 
           
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
            signal counter : integer range 0 to 10000;
            signal selector: std_logic;            
            
            signal value_analog_output_1  : integer range 0 to 100000;
            signal value_analog_output_2  : integer range 0 to 100000;
            signal value_analog_output_3  : integer range 0 to 100000;
            signal value_analog_output_4  : integer range 0 to 100000;
            signal value_analog_output_5  : integer range 0 to 100000;
            signal value_analog_output_6  : integer range 0 to 100000;
            signal value_analog_output_7  : integer range 0 to 100000;
            signal value_analog_output_8  : integer range 0 to 100000;
            signal value_analog_output_9  : integer range 0 to 100000;
            signal value_analog_output_10 : integer range 0 to 100000;
            signal value_analog_output_11 : integer range 0 to 100000;
            signal value_analog_output_12 : integer range 0 to 100000;
            signal value_analog_output_13 : integer range 0 to 100000;
            signal value_analog_output_14 : integer range 0 to 100000;
            signal value_analog_output_15 : integer range 0 to 100000;
            signal value_analog_output_16 : integer range 0 to 100000;
            signal value_analog_output_17 : integer range 0 to 100000;
            signal value_analog_output_18 : integer range 0 to 100000;
            
            signal incr_1 : std_logic;
            signal incr_2 : std_logic;
            signal incr_3 : std_logic;
            signal incr_4 : std_logic;
            signal incr_5 : std_logic;
            signal incr_6 : std_logic;
            signal incr_7 : std_logic;
            signal incr_8 : std_logic;
            signal incr_9 : std_logic;
            signal incr_10 : std_logic;
            signal incr_11 : std_logic;
            signal incr_12 : std_logic;
            signal incr_13 : std_logic;
            signal incr_14 : std_logic;
            signal incr_15 : std_logic;
            signal incr_16 : std_logic;
            signal incr_17 : std_logic;
            signal incr_18 : std_logic;
            
    begin
    
       process (CLK, RST)                                   --aqui se genera la triangular
       begin
           if RST='0' then
               analog_output_1   <= (others => '0');
               analog_output_2   <= (others => '0');
               analog_output_3   <= (others => '0');
               analog_output_4   <= (others => '0');
               analog_output_5   <= (others => '0');
               analog_output_6   <= (others => '0');
               analog_output_7   <= (others => '0');
               analog_output_8   <= (others => '0');
               analog_output_9   <= (others => '0');
               analog_output_10  <= (others => '0');
               analog_output_11  <= (others => '0');
               analog_output_12  <= (others => '0');
               analog_output_13  <= (others => '0');
               analog_output_14  <= (others => '0');
               analog_output_15  <= (others => '0');
               analog_output_16  <= (others => '0');
               analog_output_17  <= (others => '0');
               analog_output_18  <= (others => '0');
                                           
               DigPot_output_1   <= (others => '0');
               DigPot_output_2   <= (others => '0');
               DigPot_output_3   <= (others => '0');
               DigPot_output_4   <= (others => '0');
                               
               Expansor_output_1 <= (others => '0');
               Expansor_output_2 <= (others => '0');
               Expansor_output_3 <= (others => '0');   
               selector<='0';
               counter<=0;  
               
               incr_1 <='0';
               incr_2 <='0';
               incr_3 <='0';
               incr_4 <='0';
               incr_5 <='0';
               incr_6 <='0';
               incr_7 <='0';
               incr_8 <='0';
               incr_9 <='0';
               incr_10<='0';
               incr_11<='0';
               incr_12<='0';
               incr_13<='0';
               incr_14<='0';
               incr_15<='0';
               incr_16<='0';
               incr_17<='0';
               incr_18<='0';  
               
               value_analog_output_1 <=0;
               value_analog_output_2 <=0;
               value_analog_output_3 <=0;
               value_analog_output_4 <=0;
               value_analog_output_5 <=0;
               value_analog_output_6 <=0;
               value_analog_output_7 <=0;
               value_analog_output_8 <=0;
               value_analog_output_9 <=0;
               value_analog_output_10<=0;
               value_analog_output_11<=0;
               value_analog_output_12<=0;
               value_analog_output_13<=0;
               value_analog_output_14<=0;
               value_analog_output_15<=0;
               value_analog_output_16<=0;
               value_analog_output_17<=0;
               value_analog_output_18<=0;   
             
           elsif (CLK'event and CLK='1') then              --flanco subida
               if (mode='0') then   --normal mode
                     analog_output_1  <=  analog_output_NORMAL_1  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_2  <=  analog_output_NORMAL_2  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_3  <=  analog_output_NORMAL_3  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_4  <=  analog_output_NORMAL_4  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_5  <=  analog_output_NORMAL_5  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_6  <=  analog_output_NORMAL_6  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_7  <=  analog_output_NORMAL_7  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_8  <=  analog_output_NORMAL_8  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_9  <=  analog_output_NORMAL_9  (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_10 <=  analog_output_NORMAL_10 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_11 <=  analog_output_NORMAL_11 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_12 <=  analog_output_NORMAL_12 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_13 <=  analog_output_NORMAL_13 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_14 <=  analog_output_NORMAL_14 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_15 <=  analog_output_NORMAL_15 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_16 <=  analog_output_NORMAL_16 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_17 <=  analog_output_NORMAL_17 (24 downto 13);   --input analog signals are truncated to 12 bits
                     analog_output_18 <=  analog_output_NORMAL_18 (24 downto 13);   --input analog signals are truncated to 12 bits
                                       
                     DigPot_output_1  <= DigPot_output_NORMAL_1;
                     DigPot_output_2  <= DigPot_output_NORMAL_2;
                     DigPot_output_3  <= DigPot_output_NORMAL_3;
                     DigPot_output_4  <= DigPot_output_NORMAL_4;
                                     
                     Expansor_output_1<= Expansor_output_NORMAL_1;
                     Expansor_output_2<= Expansor_output_NORMAL_2;
                     Expansor_output_3<= Expansor_output_NORMAL_3;
                     
               else   --test mode
                    
                    if (value_analog_output_1=-to_integer(signed(analog_output_TEST_1))) then
                        incr_1<='1';
                    elsif (value_analog_output_1=to_integer(signed(analog_output_TEST_1))) then
                        incr_1<='0';
                    end if;                    
                    if (incr_1='1') then
                        value_analog_output_1<=value_analog_output_1+1;
                    else
                        value_analog_output_1<=value_analog_output_1-1;
                    end if;
                    
                    if (value_analog_output_2=-to_integer(signed(analog_output_TEST_2))) then
                        incr_2<='1';
                    elsif (value_analog_output_2=to_integer(signed(analog_output_TEST_2))) then
                        incr_2<='0';
                    end if;                    
                    if (incr_2='1') then
                        value_analog_output_2<=value_analog_output_2+1;
                    else
                        value_analog_output_2<=value_analog_output_2-1;
                    end if;
                    
                    if (value_analog_output_3=-to_integer(signed(analog_output_TEST_3))) then
                        incr_3<='1';
                    elsif (value_analog_output_3=to_integer(signed(analog_output_TEST_3))) then
                        incr_3<='0';
                    end if;                    
                    if (incr_3='1') then
                        value_analog_output_3<=value_analog_output_3+1;
                    else
                        value_analog_output_3<=value_analog_output_3-1;
                    end if;
                    
                    if (value_analog_output_4=-to_integer(signed(analog_output_TEST_4))) then
                        incr_4<='1';
                    elsif (value_analog_output_4=to_integer(signed(analog_output_TEST_4))) then
                        incr_4<='0';
                    end if;                    
                    if (incr_4='1') then
                        value_analog_output_4<=value_analog_output_4+1;
                    else
                        value_analog_output_4<=value_analog_output_4-1;
                    end if;
                    
                    if (value_analog_output_5=-to_integer(signed(analog_output_TEST_5))) then
                        incr_5<='1';
                    elsif (value_analog_output_5=to_integer(signed(analog_output_TEST_5))) then
                        incr_5<='0';
                    end if;                    
                    if (incr_5='1') then
                        value_analog_output_5<=value_analog_output_5+1;
                    else
                        value_analog_output_5<=value_analog_output_5-1;
                    end if;
                    
                    if (value_analog_output_6=-to_integer(signed(analog_output_TEST_6))) then
                        incr_6<='1';
                    elsif (value_analog_output_6=to_integer(signed(analog_output_TEST_6))) then
                        incr_6<='0';
                    end if;                    
                    if (incr_6='1') then
                        value_analog_output_6<=value_analog_output_6+1;
                    else
                        value_analog_output_6<=value_analog_output_6-1;
                    end if;
                    
                    if (value_analog_output_7=-to_integer(signed(analog_output_TEST_7))) then
                        incr_7<='1';
                    elsif (value_analog_output_7=to_integer(signed(analog_output_TEST_7))) then
                        incr_7<='0';
                    end if;                    
                    if (incr_7='1') then
                        value_analog_output_7<=value_analog_output_7+1;
                    else
                        value_analog_output_7<=value_analog_output_7-1;
                    end if;
                    
                    if (value_analog_output_8=-to_integer(signed(analog_output_TEST_8))) then
                        incr_8<='1';
                    elsif (value_analog_output_8=to_integer(signed(analog_output_TEST_8))) then
                        incr_8<='0';
                    end if;                    
                    if (incr_8='1') then
                        value_analog_output_8<=value_analog_output_8+1;
                    else
                        value_analog_output_8<=value_analog_output_8-1;
                    end if;
                    
                    if (value_analog_output_9=-to_integer(signed(analog_output_TEST_9))) then
                        incr_9<='1';
                    elsif (value_analog_output_9=to_integer(signed(analog_output_TEST_9))) then
                        incr_9<='0';
                    end if;                    
                    if (incr_9='1') then
                        value_analog_output_9<=value_analog_output_9+1;
                    else
                        value_analog_output_9<=value_analog_output_9-1;
                    end if;
                    
                    if (value_analog_output_10=-to_integer(signed(analog_output_TEST_10))) then
                        incr_10<='1';
                    elsif (value_analog_output_10=to_integer(signed(analog_output_TEST_10))) then
                        incr_10<='0';
                    end if;                    
                    if (incr_10='1') then
                        value_analog_output_10<=value_analog_output_10+1;
                    else
                        value_analog_output_10<=value_analog_output_10-1;
                    end if;
                    
                    if (value_analog_output_11=-to_integer(signed(analog_output_TEST_11))) then
                        incr_11<='1';
                    elsif (value_analog_output_11=to_integer(signed(analog_output_TEST_11))) then
                        incr_11<='0';
                    end if;                    
                    if (incr_11='1') then
                        value_analog_output_11<=value_analog_output_11+1;
                    else
                        value_analog_output_11<=value_analog_output_11-1;
                    end if;
                    
                    if (value_analog_output_12=-to_integer(signed(analog_output_TEST_12))) then
                        incr_12<='1';
                    elsif (value_analog_output_12=to_integer(signed(analog_output_TEST_12))) then
                        incr_12<='0';
                    end if;                    
                    if (incr_12='1') then
                        value_analog_output_12<=value_analog_output_12+1;
                    else
                        value_analog_output_12<=value_analog_output_12-1;
                    end if;
                    
                    if (value_analog_output_13=-to_integer(signed(analog_output_TEST_13))) then
                        incr_13<='1';
                    elsif (value_analog_output_13=to_integer(signed(analog_output_TEST_13))) then
                        incr_13<='0';
                    end if;                    
                    if (incr_13='1') then
                        value_analog_output_13<=value_analog_output_13+1;
                    else
                        value_analog_output_13<=value_analog_output_13-1;
                    end if;
                    
                    if (value_analog_output_14=-to_integer(signed(analog_output_TEST_14))) then
                        incr_14<='1';
                    elsif (value_analog_output_14=to_integer(signed(analog_output_TEST_14))) then
                        incr_14<='0';
                    end if;                    
                    if (incr_14='1') then
                        value_analog_output_14<=value_analog_output_14+1;
                    else
                        value_analog_output_14<=value_analog_output_14-1;
                    end if;
                    
                    if (value_analog_output_15=-to_integer(signed(analog_output_TEST_15))) then
                        incr_15<='1';
                    elsif (value_analog_output_15=to_integer(signed(analog_output_TEST_15))) then
                        incr_15<='0';
                    end if;                    
                    if (incr_15='1') then
                        value_analog_output_15<=value_analog_output_15+1;
                    else
                        value_analog_output_15<=value_analog_output_15-1;
                    end if;
                    
                    if (value_analog_output_16=-to_integer(signed(analog_output_TEST_16))) then
                        incr_16<='1';
                    elsif (value_analog_output_16=to_integer(signed(analog_output_TEST_16))) then
                        incr_16<='0';
                    end if;                    
                    if (incr_16='1') then
                        value_analog_output_16<=value_analog_output_16+1;
                    else
                        value_analog_output_16<=value_analog_output_16-1;
                    end if;      
                               
                    if (value_analog_output_17=-to_integer(signed(analog_output_TEST_17))) then
                        incr_17<='1';
                    elsif (value_analog_output_17=to_integer(signed(analog_output_TEST_17))) then
                        incr_17<='0';
                    end if;                    
                    if (incr_17='1') then
                        value_analog_output_17<=value_analog_output_17+1;
                    else
                        value_analog_output_17<=value_analog_output_17-1;
                    end if;
                    
                    if (value_analog_output_18=-to_integer(signed(analog_output_TEST_18))) then
                        incr_18<='1';
                    elsif (value_analog_output_18=to_integer(signed(analog_output_TEST_18))) then
                        incr_18<='0';
                    end if;                    
                    if (incr_18='1') then
                        value_analog_output_18<=value_analog_output_18+1;
                    else
                        value_analog_output_18<=value_analog_output_18-1;
                    end if;                                                         
                                                                                                    
                                
                    analog_output_1  <= std_logic_vector(to_signed(value_analog_output_1 , 12)) ;
                    analog_output_2  <= std_logic_vector(to_signed(value_analog_output_2 , 12)) ; 
                    analog_output_3  <= std_logic_vector(to_signed(value_analog_output_3 , 12)) ; 
                    analog_output_4  <= std_logic_vector(to_signed(value_analog_output_4 , 12)) ; 
                    analog_output_5  <= std_logic_vector(to_signed(value_analog_output_5 , 12)) ; 
                    analog_output_6  <= std_logic_vector(to_signed(value_analog_output_6 , 12)) ; 
                    analog_output_7  <= std_logic_vector(to_signed(value_analog_output_7 , 12)) ; 
                    analog_output_8  <= std_logic_vector(to_signed(value_analog_output_8 , 12)) ; 
                    analog_output_9  <= std_logic_vector(to_signed(value_analog_output_9 , 12)) ; 
                    analog_output_10 <= std_logic_vector(to_signed(value_analog_output_10, 12)) ; 
                    analog_output_11 <= std_logic_vector(to_signed(value_analog_output_11, 12)) ; 
                    analog_output_12 <= std_logic_vector(to_signed(value_analog_output_12, 12)) ; 
                    analog_output_13 <= std_logic_vector(to_signed(value_analog_output_13, 12)) ; 
                    analog_output_14 <= std_logic_vector(to_signed(value_analog_output_14, 12)) ; 
                    analog_output_15 <= std_logic_vector(to_signed(value_analog_output_15, 12)) ; 
                    analog_output_16 <= std_logic_vector(to_signed(value_analog_output_16, 12)) ; 
                    analog_output_17 <= std_logic_vector(to_signed(value_analog_output_17, 12)) ; 
                    analog_output_18 <= std_logic_vector(to_signed(value_analog_output_18, 12)) ; 
                                       
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

