--  PSC | Power Smart Control | JRF | 2018
    
    library IEEE;
    use IEEE.STD_LOGIC_1164.ALL; 
    use IEEE.STD_LOGIC_SIGNED.all;
    use IEEE.numeric_std.all; 

    entity AD_5293_v2 is
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
    end AD_5293_v2 ;
    
    architecture AD_2 of AD_5293_v2 is
          -- IC commands                                                       X X C3 C2 C1 C0
          constant cmd_DO_NOTHING                : std_logic_vector(5 downto 0) := "000000";
          constant cmd_WRITE_serREG_TO_RDAC      : std_logic_vector(5 downto 0) := "000001";
          constant cmd_READ_RDAC                 : std_logic_vector(5 downto 0) := "000010";
          constant cmd_RESET                     : std_logic_vector(5 downto 0) := "000100";
          constant cmd_WRITE_serREG_TO_ctrlREG   : std_logic_vector(5 downto 0) := "000110";
          constant cmd_READ_ctrlREG              : std_logic_vector(5 downto 0) := "000111";
          constant cmd_pwrDOWN                   : std_logic_vector(5 downto 0) := "001000";
          
          type states is (sleep, cmd_1,  cmd_2, cmd_3, cmd_4, cmd_5, cmd_6, cmd_7, data);  
          signal current_state : states;
          signal next_state    : states;
          
          --auxiliary signals
          signal clk_counter    : integer range 0 to 100;
          signal CLK_OUT_aux    : std_logic;
          signal START_ant      : std_logic;
          signal Data_out_1     : std_logic_vector (15 downto 0);
          signal Data_out_2     : std_logic_vector (15 downto 0);
          signal Data_out_3     : std_logic_vector (15 downto 0);
          signal Data_out_4     : std_logic_vector (15 downto 0);
          signal CLK_OUT_aux_ant: std_logic;
          signal counter_data   : integer range 0 to 100;
          signal fifteen        : integer range 0 to 100;
          signal START_ant_2    : std_logic;
          signal enable_data    : std_logic;
          signal counter_2      : integer range 0 to 100;
          signal counter_3      : integer range 0 to 100;
          signal nSYNC_aux      : std_logic;
          
    begin
         
         --clock signal generation
         process (CLK, RST)
            variable CLK_OUT_aux_var : std_logic;
         begin         
            if (RST='0') then
                clk_counter<=0;
                CLK_OUT_aux<='0';
                CLK_OUT_aux_var:='0';
            elsif (CLK='1' and clk'event) then
                if (clk_counter>19) then
                    clk_counter<=0;
                    CLK_OUT_aux_var:= not (CLK_OUT_aux_var);                
                else 
                    clk_counter<=clk_counter+1;
                end if;
                
                CLK_OUT_aux<=CLK_OUT_aux_var;
                
                if (nSYNC_aux='0')then
                    CLK_OUT<=CLK_OUT_aux; 
                else
                    CLK_OUT<='0';
                end if;

                
            end if;
         end process;
         
         --state machine
         process (CLK, RST)
         begin         
            if (RST='0') then
                current_state<= sleep;
                next_state   <= sleep;
                START_ant<='0';
                Data_out_1 <= (others =>'0');
                Data_out_2 <= (others =>'0');
                Data_out_3 <= (others =>'0');
                Data_out_4 <= (others =>'0');
            elsif (CLK='1' and clk'event) then
            
                case current_state is
                    when sleep =>
                        if (START_ant='0' and START='1') then 
                            next_state<=cmd_3;
                        end if;
                    when cmd_1 =>
                        if (START_ant='0' and START='1') then 
                            next_state<=cmd_2;
                            Data_out_1 <= cmd_RESET & "0000000000";    --data word is not used by IC
                            Data_out_2 <= cmd_RESET & "0000000000";
                            Data_out_3 <= cmd_RESET & "0000000000";
                            Data_out_4 <= cmd_RESET & "0000000000";
                        end if;
                    when cmd_2 =>
                        if (START_ant='0' and START='1') then  --waiting for finishing the reset
                           next_state<=cmd_3;
                           Data_out_1 <= cmd_DO_NOTHING & DATA1;
                           Data_out_2 <= cmd_DO_NOTHING & DATA2;
                           Data_out_3 <= cmd_DO_NOTHING & DATA3;
                           Data_out_4 <= cmd_DO_NOTHING & DATA4;
                        end if;
                    when cmd_3 =>
                        if (START_ant='0' and START='1') then 
                            next_state<=data;
                            Data_out_1 <= "0001100000000110";--cmd_WRITE_serREG_TO_ctrlREG & DATA1;    --data word should enable the wiper update -> C1=1
                            Data_out_2 <= "0001100000000110";--cmd_WRITE_serREG_TO_ctrlREG & DATA2;
                            Data_out_3 <= "0001100000000110";--cmd_WRITE_serREG_TO_ctrlREG & DATA3;
                            Data_out_4 <= "0001100000000110";--cmd_WRITE_serREG_TO_ctrlREG & DATA4;
                        end if;
                    when cmd_4 =>   --skiped
                        if (START_ant='0' and START='1') then  --skiped!!
                            next_state<=cmd_5;
                            Data_out_1 <= cmd_DO_NOTHING & DATA1;
                            Data_out_2 <= cmd_DO_NOTHING & DATA2;
                            Data_out_3 <= cmd_DO_NOTHING & DATA3;
                            Data_out_4 <= cmd_DO_NOTHING & DATA4;
                        end if;
                    when cmd_5 =>   --skiped
                        if (START_ant='0' and START='1') then  --skiped!!
                            next_state<=cmd_6;
                            Data_out_1 <= cmd_DO_NOTHING & DATA1;
                            Data_out_2 <= cmd_DO_NOTHING & DATA2;
                            Data_out_3 <= cmd_DO_NOTHING & DATA3;
                            Data_out_4 <= cmd_DO_NOTHING & DATA4;
                        end if;
                    when cmd_6 =>   --skiped
                        if (START_ant='0' and START='1') then  --skiped!!
                            next_state<=cmd_7;
                            Data_out_1 <= cmd_DO_NOTHING & DATA1;
                            Data_out_2 <= cmd_DO_NOTHING & DATA2;
                            Data_out_3 <= cmd_DO_NOTHING & DATA3;
                            Data_out_4 <= cmd_DO_NOTHING & DATA4;
                        end if;
                    when cmd_7 =>   --skiped
                        if (START_ant='0' and START='1') then  --skiped!!
                            next_state<=data;
                            Data_out_1 <= cmd_DO_NOTHING & DATA1;
                            Data_out_2 <= cmd_DO_NOTHING & DATA2;
                            Data_out_3 <= cmd_DO_NOTHING & DATA3;
                            Data_out_4 <= cmd_DO_NOTHING & DATA4;
                        end if;                                                                                    
                    when data =>
                        if (START_ant='0' and START='1') then 
                            next_state<=data;
                            Data_out_1 <= cmd_WRITE_serREG_TO_RDAC & DATA1;   --data word should is the one provided by the user
                            Data_out_2 <= cmd_WRITE_serREG_TO_RDAC & DATA2;
                            Data_out_3 <= cmd_WRITE_serREG_TO_RDAC & DATA3;
                            Data_out_4 <= cmd_WRITE_serREG_TO_RDAC & DATA4;
                        end if;          
                    when others =>
                       next_state<=current_state;    
                end case;          
                 
                    current_state<=next_state;
                    START_ant<=START;   
            end if;
          end process;

          -- generating output data
          process (CLK, RST)
          begin         
             if (RST='0') then
                CLK_OUT_aux_ant<='0';
                D1<='0';
                D2<='0';
                D3<='0';
                D4<='0';
                counter_data<=0;
                fifteen<=15;
                enable_data<='0';
                START_ant_2<='0';
                counter_2<=0;
                counter_3<=0;
             elsif (CLK='1' and clk'event) then
             
                 if (START_ant_2='0' and START='1') then 
                     enable_data<='1';
                     counter_data<=0;
                 end if;
                 
                 if  (counter_data=20) then --end the data package
                     counter_2<=counter_2+1;
                 else
                     counter_2<=0;
                 end if;
                 
                 if (counter_2=30) then
                     nSYNC<='1';
                     nSYNC_aux<='1';
                 end if;
                 
                 if  (counter_data=4) then  --start the data package
                     counter_3<=counter_3+1;
                 else
                     counter_3<=0;
                 end if;
                 
                 if (counter_3=30) then
                     nSYNC<='0';
                     nSYNC_aux<='0';
                 end if;
             
                 if (CLK_OUT_aux_ant='0' and CLK_OUT_aux='1' and enable_data='1') then  --falling edge of output clock                    
                    if (counter_data<20) then       --range with data    
                                             
                        if  (counter_data>3 and counter_data<20) then
                            D1<=Data_out_1(19-counter_data);   --output data with oposite direction
                            D2<=Data_out_2(19-counter_data);
                            D3<=Data_out_3(19-counter_data);
                            D4<=Data_out_4(19-counter_data);
                        end if;
                        
                        counter_data<=counter_data+1;
                    else
                        D1<='0';
                        D2<='0';
                        D3<='0';
                        D4<='0';      
                        enable_data<='0';
                        counter_data<=0;
                        
                    end if;                   
                 else                  
                 end if; 
         
                 CLK_OUT_aux_ant<=CLK_OUT_aux;
                 START_ant_2<=START;
             end if;
          end process;     
                
    end AD_2;
                