--
--            #
--
--
--  #####   ###    ### #
-- #     #    #     # # #
--  ###       #     # # #
--     ##     #     # # #
-- #     #    #     # # #
--  #####   #####  ## # ##

--   Pierre-Yves Droz 2006

------------------------------------------------------------------------------
-- sim_bench.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.all;

library ddr2_controller_v2_00_a;
library ddr2_infrastructure_v2_00_a;

library async_ddr2_v2_00_a;

entity sim_bench is
end entity;

architecture sim_bench_arch of sim_bench is

--            #                              ##
--                                            #
--                                            #
--  #####   ###     ###### ## ##    ####      #     #####
-- #     #    #    #    #   ##  #       #     #    #     #
--  ###       #    #    #   #   #   #####     #     ###
--     ##     #    #    #   #   #  #    #     #        ##
-- #     #    #     #####   #   #  #    #     #    #     #
--  #####   #####       #  ### ###  #### #  #####   #####
--                      #
--                  ####

  constant C_WIDE_DATA                  : integer := 1;
  constant C_HALF_BURST                 : integer := 1;

  -- test clk and rst
  signal clk                            : std_logic := '0';
  signal rst                            : std_logic := '1';

  -- test signals
  signal cmd_count                      : std_logic_vector(5 downto 0);
  signal wr_address                     : std_logic_vector(31 downto 0);
  signal rd_address                     : std_logic_vector(31 downto 0);
  
  -- DDR2 infrastructure clk and rst
  signal sys_clk_in                     : std_logic := '0';  
  signal sys_reset_in                   : std_logic := '1';
  signal sys_dcmlock_in                 : std_logic := '1';

  -- DDR2 controller clk and rst
  signal ddr_clk                        : std_logic;
  signal ddr_clk90                      : std_logic;
  signal ddr_delay_sel                  : std_logic_vector(4 downto 0);
  signal ddr_inf_reset                  : std_logic;

  -- DDR2 controller signals
  signal DDR_input_data                 : std_logic_vector(143 downto 0);
  signal DDR_byte_enable                : std_logic_vector(17 downto 0);
  signal DDR_get_data                   : std_logic;
  signal DDR_output_data                : std_logic_vector(143 downto 0);
  signal DDR_data_valid                 : std_logic;
  signal DDR_address                    : std_logic_vector(31 downto 0);
  signal DDR_read                       : std_logic;
  signal DDR_write                      : std_logic;
  signal DDR_half_burst                 : std_logic;
  signal DDR_ready                      : std_logic;
  signal DDR_reset                      : std_logic;

  -- Memory command signals
  signal Mem_Cmd_Address                : std_logic_vector(31 downto 0);
  signal Mem_Cmd_RNW                    : std_logic;
  signal Mem_Cmd_Valid                  : std_logic;
  signal Mem_Cmd_Tag                    : std_logic_vector(31 downto 0);
  signal Mem_Cmd_Ack                    : std_logic;
  signal Mem_Rd_Dout                    : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal Mem_Rd_Tag                     : std_logic_vector(31 downto 0);
  signal Mem_Rd_Ack                     : std_logic;
  signal Mem_Rd_Valid                   : std_logic;
  signal Mem_Wr_Din                     : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0);
  signal Mem_Wr_BE                      : std_logic_vector((18*(C_WIDE_DATA+1))-1 downto 0) := (others => '1');
  
begin

  -----------------------------------------------------------------------------
  -- Generate test vectors
  -----------------------------------------------------------------------------

  
test_gen: process(clk)
begin
  if clk'event and clk='1' then
    if rst = '1' then
      cmd_count        <= (others => '0');
      wr_address       <= (others => '0');
      rd_address       <= (others => '0');      
      
      Mem_Cmd_Tag      <= (others => '0');
    else
      -- if command is not ack'd, issue next
      if Mem_Cmd_Ack = '1' then
        -- advance write address
        if cmd_count < X"20" then
          wr_address <= wr_address + X"20";
        end if;
        
        -- advance read address and tag
        if cmd_count >= X"20" then
          Mem_Cmd_Tag <= Mem_Cmd_Tag + X"20";
          rd_address  <= rd_address + X"20";
        end if;
        
        -- increment count
        if cmd_count = X"3f" then
          cmd_count <= (others => '0');
        else
          cmd_count <= cmd_count + '1';
        end if;
      end if;
      
    end if;
  end if;
end process test_gen;

Mem_Rd_Ack      <= Mem_Rd_Valid;
Mem_Cmd_Address <= wr_address when Mem_Cmd_RNW = '0' else rd_address;
Mem_Cmd_Valid   <= '1';
Mem_Cmd_RNW     <= '1' when cmd_count >= X"20" else '0';

use_mux: if C_WIDE_DATA = 1 generate
  Mem_Wr_Din <=
    wr_address(7 downto 0) + X"23" &          
    wr_address(7 downto 0) + X"22" &          
    wr_address(7 downto 0) + X"21" &
    wr_address(7 downto 0) + X"20" &
    wr_address(7 downto 0) + X"1f" &
    wr_address(7 downto 0) + X"1e" &
    wr_address(7 downto 0) + X"1d" &
    wr_address(7 downto 0) + X"1c" &
    wr_address(7 downto 0) + X"1b" &
    wr_address(7 downto 0) + X"1a" &
    wr_address(7 downto 0) + X"19" &
    wr_address(7 downto 0) + X"18" &
    wr_address(7 downto 0) + X"17" &
    wr_address(7 downto 0) + X"16" &
    wr_address(7 downto 0) + X"15" &
    wr_address(7 downto 0) + X"14" &
    wr_address(7 downto 0) + X"13" &
    wr_address(7 downto 0) + X"12" &
    wr_address(7 downto 0) + X"11" &
    wr_address(7 downto 0) + X"10" &
    wr_address(7 downto 0) + X"f" &
    wr_address(7 downto 0) + X"e" &
    wr_address(7 downto 0) + X"d" &
    wr_address(7 downto 0) + X"c" &
    wr_address(7 downto 0) + X"b" &
    wr_address(7 downto 0) + X"a" &
    wr_address(7 downto 0) + X"9" &
    wr_address(7 downto 0) + X"8" &
    wr_address(7 downto 0) + X"7" &
    wr_address(7 downto 0) + X"6" &
    wr_address(7 downto 0) + X"5" &
    wr_address(7 downto 0) + X"4" &
    wr_address(7 downto 0) + X"3" &
    wr_address(7 downto 0) + X"2" &
    wr_address(7 downto 0) + X"1" &
    wr_address(7 downto 0) + X"0" ;
end generate use_mux;

no_use_mux: if C_WIDE_DATA = 0 generate
  Mem_Wr_din <=
    wr_address(7 downto 0) + X"11" &
    wr_address(7 downto 0) + X"10" &
    wr_address(7 downto 0) + X"f" &
    wr_address(7 downto 0) + X"e" &
    wr_address(7 downto 0) + X"d" &
    wr_address(7 downto 0) + X"c" &
    wr_address(7 downto 0) + X"b" &
    wr_address(7 downto 0) + X"a" &
    wr_address(7 downto 0) + X"9" &
    wr_address(7 downto 0) + X"8" &
    wr_address(7 downto 0) + X"7" &
    wr_address(7 downto 0) + X"6" &
    wr_address(7 downto 0) + X"5" &
    wr_address(7 downto 0) + X"4" &
    wr_address(7 downto 0) + X"3" &
    wr_address(7 downto 0) + X"2" &
    wr_address(7 downto 0) + X"1" &
    wr_address(7 downto 0) + X"0" ;
end generate no_use_mux;
         
--           ##    ##                ##
--            #     #               #                                #
--            #     #               #                                #
--  #####     #     #  ##            #             ### ##   #####   ####
-- #     #    #     #  #            ##               ##  # #     #   #
-- #          #     # #            #  #  #           #      ###      #
-- #          #     ###            #  # #            #         ##    #
-- #     #    #     #  #           #   #             #     #     #   #  #
--  #####   #####  ##   ##          ### ##         #####    #####     ##

-- clock generation process
clk_gen: process
begin
	clk <= '0';
	wait for 5 ns;
	clk <= '1';
	wait for 5 ns;
end process clk_gen;

-- reset generation process
rst_gen: process
begin
	wait for 30 ns;
	rst <= '0';
	wait for 10000000 ns;
end process rst_gen;

-- DDR2 clock generation process
sys_clk_in_gen: process
begin
	sys_clk_in <= '1';
	wait for 2.5 ns;
	sys_clk_in <= '0';
	wait for 2.5 ns;
end process sys_clk_in_gen;

-- DDR2 reset generation process
sys_reset_in_gen: process
begin
	wait for 30 ns;
	sys_reset_in <= '0';
	wait for 10000000 ns;
end process sys_reset_in_gen;

--                                    #
--
--
-- ### #    ####   ######  ######   ###    ## ##    ######
--  # # #       #   #    #  #    #    #     ##  #  #    #
--  # # #   #####   #    #  #    #    #     #   #  #    #
--  # # #  #    #   #    #  #    #    #     #   #  #    #
--  # # #  #    #   #    #  #    #    #     #   #   #####
-- ## # ##  #### #  #####   #####   #####  ### ###      #
--                  #       #                           #
--                 ###     ###                      ####

------------------------------------------
-- Instance of DDR2 infrastructure
------------------------------------------
ddr2_infrastructure_0 : entity ddr2_infrastructure_v2_00_a.ddr2_infrastructure
  port map
  (
    reset_in               =>   sys_reset_in   ,
    clk_in                 =>   sys_clk_in     ,
    dcmlock_in             =>   sys_dcmlock_in ,
    ddr_inf_reset          =>   ddr_inf_reset  ,
    ddr_delay_sel          =>   ddr_delay_sel  ,
    ddr_clk                =>   ddr_clk        ,
    ddr_clk90              =>   ddr_clk90
    );

------------------------------------------
-- Instance of DDR2 controller
------------------------------------------
ddr2_controller_0 : entity ddr2_controller_v2_00_a.ddr2_controller
  port map
  (
    -- user interface
    user_input_data        =>   DDR_input_data  ,
    user_byte_enable       =>   DDR_byte_enable ,
    user_get_data          =>   DDR_get_data    ,
    user_output_data       =>   DDR_output_data ,
    user_data_valid        =>   DDR_data_valid  ,
    user_address           =>   DDR_address     ,
    user_read              =>   DDR_read        ,
    user_write             =>   DDR_write       ,
    user_half_burst        =>   DDR_half_burst  ,
    user_ready             =>   DDR_ready       ,
    user_reset             =>   DDR_reset       ,

    -- system interface
    sys_clk                =>   ddr_clk         ,
    sys_clk90              =>   ddr_clk90       ,
    sys_delay_sel          =>   ddr_delay_sel   ,
    sys_inf_reset          =>   ddr_inf_reset
    );

------------------------------------------
-- Instance of Async DDR2
------------------------------------------
async_ddr2_0 : entity async_ddr2_v2_00_a.async_ddr2
  generic map
  (
    C_WIDE_DATA     => C_WIDE_DATA        ,
    C_HALF_BURST    => C_HALF_BURST
    )
  port map
  (
    -- mem interface
    Mem_Clk          => clk             ,
    Mem_Rst          => rst             ,
    Mem_Cmd_Address  => Mem_Cmd_Address , 
    Mem_Cmd_RNW      => Mem_Cmd_RNW     ,
    Mem_Cmd_Valid    => Mem_Cmd_Valid   ,
    Mem_Cmd_Tag      => Mem_Cmd_Tag     ,
    Mem_Cmd_Ack      => Mem_Cmd_Ack     ,
    Mem_Rd_Dout      => Mem_Rd_Dout     ,
    Mem_Rd_Tag       => Mem_Rd_Tag      ,
    Mem_Rd_Ack       => Mem_Rd_Ack      ,
    Mem_Rd_Valid     => Mem_Rd_Valid    ,
    Mem_Wr_Din       => Mem_Wr_Din      ,
    Mem_Wr_BE        => Mem_Wr_BE       ,
    
    -- ddr interface
    DDR_clk          => sys_clk_in      ,
    DDR_input_data   => DDR_input_data  ,
    DDR_byte_enable  => DDR_byte_enable ,
    DDR_get_data     => DDR_get_data    ,
    DDR_output_data  => DDR_output_data ,
    DDR_data_valid   => DDR_data_valid  ,
    DDR_address      => DDR_address     ,
    DDR_read         => DDR_read        ,
    DDR_write        => DDR_write       ,
    DDR_half_burst   => DDR_half_burst  ,
    DDR_ready        => DDR_ready       ,
    DDR_reset        => DDR_reset      
    );

end architecture sim_bench_arch;



