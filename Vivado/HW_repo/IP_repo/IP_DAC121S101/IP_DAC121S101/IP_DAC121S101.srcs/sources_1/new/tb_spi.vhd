--    ---------------------------------------
--    --     Power Smart Control | JRF | 2018
--    --
--    --           SPI driver
--    --              testbench
--    ---------------------------------------
    
    
--    -- ******************************************************************** 
--    -- Coding style summary:
--    --
--    --	i_   Input signal 
--    --	o_   Output signal 
--    --	b_   Bi-directional signal 
--    --	r_   Register signal 
--    --	w_   Wire signal (no registered logic) 
--    --	t_   User-Defined Type 
--    --	p_   pipe
--    --  pad_ PAD used in the top level
--    --	G_   Generic (UPPER CASE)
--    --	C_   Constant (UPPER CASE)
--    --  ST_  FSM state definition (UPPER CASE)
--    --
--    -- ******************************************************************** 
    
    
--    library ieee;
--    use ieee.std_logic_1164.all;
--    use ieee.numeric_std.all;
    
--    entity tb_spi_controller is
--    end tb_spi_controller;
    
--    architecture rtl of tb_spi_controller is
    
--    component spi_controller
--    generic(
--        N                     : integer := 8;      -- number of bit to serialize
--        CLK_DIV               : integer := 100 );  -- input clock divider to generate output serial clock; o_sclk frequency = i_clk/(2*CLK_DIV)
--    port (
--        i_clk                       : in  std_logic;
--        i_rstb                      : in  std_logic;
--        i_tx_start                  : in  std_logic;  -- start TX on serial line
--        o_tx_end                    : out std_logic;  -- TX data completed; o_data_parallel available
--        i_data_parallel             : in  std_logic_vector(N-1 downto 0);  -- data to sent
--        o_data_parallel             : out std_logic_vector(N-1 downto 0);  -- received data
--        o_sclk                      : out std_logic;
--        o_ss                        : out std_logic;
--        o_mosi                      : out std_logic;
--        i_miso                      : in  std_logic);
--    end component;
    
--    constant N                     : integer := 16;      -- number of bit to serialize
--    constant CLK_DIV               : integer := 100;  -- input clock divider to generate output serial clock; o_sclk frequency = i_clk/(2*CLK_DIV)
    
--    signal i_clk                       : std_logic:='0';
--    signal i_rstb                      : std_logic;
--    signal i_tx_start                  : std_logic;  -- start TX on serial line
--    signal o_tx_end                    : std_logic;  -- TX data completed; o_data_parallel available
--    signal i_data_parallel             : std_logic_vector(N-1 downto 0);  -- data to sent
--    signal o_data_parallel             : std_logic_vector(N-1 downto 0);  -- received data
--    signal o_sclk                      : std_logic;
--    signal o_ss                        : std_logic;
--    signal o_mosi                      : std_logic;
--    signal i_miso                      : std_logic;
    
--    signal mosi_test                   : std_logic_vector(N-1 downto 0);  -- tx data
--    signal miso_test                   : std_logic_vector(N-1 downto 0);  -- received data
--    signal count_rise                  : integer;
--    signal count_fall                  : integer;
    
--    begin
    
--    i_clk     <= not i_clk after 5 ns;
--    i_rstb    <= '0', '1' after 163 ns;
    
    
--    u_spi_controller : spi_controller
--    generic map(
--        N                     => N                     ,
--        CLK_DIV               => CLK_DIV               )
--    port map(
--        i_clk                       => i_clk                       ,
--        i_rstb                      => i_rstb                      ,
--        i_tx_start                  => i_tx_start                  ,
--        o_tx_end                    => o_tx_end                    ,
--        i_data_parallel             => i_data_parallel             ,
--        o_data_parallel             => o_data_parallel             ,
--        o_sclk                      => o_sclk                      ,
--        o_ss                        => o_ss                        ,
--        o_mosi                      => o_mosi                      ,
--        i_miso                      => i_miso                      );
    
    
--    --------------------------------------------------------------------
--    -- FSM
--    p_control : process(i_clk,i_rstb)
--    variable v_control         : unsigned(12 downto 0);
--    begin
--        if(i_rstb='0') then
--            v_control         := (others=>'0');
--            i_tx_start        <= '0';
--            i_data_parallel   <= std_logic_vector(to_unsigned(16#92#,N));
--        elsif(rising_edge(i_clk)) then
--            v_control    := v_control + 1;
--            if(v_control=10) then
--                i_tx_start        <= '1';
--            else
--                i_tx_start        <= '0';
--            end if;
            
--            if(o_tx_end='1') then
--                i_data_parallel   <= std_logic_vector(unsigned(i_data_parallel)+1);
--            end if;
--        end if;
--    end process p_control;
    
--    p_control_sclk : process(o_sclk)
--    begin
--        if(i_rstb='0') then
--            miso_test   <= std_logic_vector(to_unsigned(16#C9#,N));
--            mosi_test   <= std_logic_vector(to_unsigned(16#00#,N));
--            i_miso      <= '0';
--            count_rise  <= 0;
--            count_fall  <= 0;
--        else
--            if(rising_edge(o_sclk)) then
--                if(o_ss='0') then
--                    mosi_test   <= mosi_test(N-2 downto 0)&o_mosi;
--                    count_rise     <= count_rise+1;
--                else
--                    count_rise     <= 0;
--                end if;
--            end if;
    
--            if(falling_edge(o_sclk)) then
--                if(o_ss='0') then
--                    miso_test   <= std_logic_vector(rotate_right(unsigned(miso_test),1));
--                    i_miso      <= miso_test(N-1) after 63 ns;
--                    count_fall     <= count_fall+1;
--                else
--                    count_fall     <= 0;
--                end if;
--            end if;
--        end if;
--    end process p_control_sclk;
    
    
--    end rtl;
