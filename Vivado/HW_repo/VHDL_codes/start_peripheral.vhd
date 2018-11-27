--  PSC | Power Smart Control | JRF | 2018
    
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.numeric_std.all; 
     
    
    entity start_peripheral is
        Port ( CLK : in STD_LOGIC;
               RST : in STD_LOGIC;
               Start_DAC : out STD_LOGIC;
               Start_ADC : out STD_LOGIC;
               start_grid : out std_logic;
               Start_pot_dig : out STD_LOGIC;
               Start_inp_expa : out STD_LOGIC;
               Start_out_expa : out STD_LOGIC               
               );
    end start_peripheral;
    
    architecture Behavioral_1 of start_peripheral is
    
        signal counter_1 : integer  range 0 to 50000;
        signal counter_2 : integer  range 0 to 50000;
        signal counter_3 : integer  range 0 to 200000;
        signal counter_4 : integer  range 0 to 200000;
        signal counter_5 : integer  range 0 to 200000;
        signal counter_6 : integer  range 0 to 200000;
        
    begin
    
     process (CLK, RST)
     begin
       if RST='0' then
          counter_1<= 0;  
          counter_2<= 0; 
          counter_3<= 0; 
          counter_4<= 0;
          counter_5<= 0;
          counter_6<= 0;
          Start_DAC <='0';
          Start_pot_dig <='0';
          Start_out_expa <='0';
          Start_ADC<='0';
          start_grid<='0';
      elsif (CLK'event and CLK='1') then 
      
           counter_1<=counter_1+1;          
            if (counter_1>999) then  
              Start_pot_dig <='1';
              counter_1<=0;
            elsif (counter_1<5) then
              Start_pot_dig<='1';
            else
              Start_pot_dig<='0';
            end if;
          
          counter_2<=counter_2+1;            
            if (counter_2>100) then  
              Start_DAC <='1';
              counter_2<=0;
            elsif (counter_2<10) then
              Start_DAC<='1';
            else
              Start_DAC<='0';
            end if; 

          counter_3<=counter_3+1;            
            if (counter_3>33332) then  --100000
              Start_out_expa <='1';
              counter_3<=0;
            elsif (counter_3<5000) then
              Start_out_expa<='1';
            else
              Start_out_expa<='0';
            end if;
            
          counter_4<=counter_4+1;            
            if (counter_4>24999) then  --100000
              Start_inp_expa <='1';
              counter_4<=0;
            elsif (counter_4<5000) then
              Start_inp_expa<='1';
            else
              Start_inp_expa<='0';
            end if;
            
              counter_5<=counter_5+1;            
              if (counter_5>100000) then  
                Start_ADC <='1';
                counter_5<=0;
              elsif (counter_5<100) then
                Start_ADC<='1';
              else
                Start_ADC<='0';
              end if;
          
             counter_6<=counter_6+1;            
              if (counter_6>6) then  
                start_grid <='1';
                counter_6<=0;
              elsif (counter_6<2) then
                start_grid<='1';
              else
                start_grid<='0';
              end if;
          
          
          
       end if;
          
     end process;
    
    
    end Behavioral_1;
