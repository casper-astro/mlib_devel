-------------------------------------------------------------------------------
--                                                                           --
--  Center for Astronomy Signal Processing and Electronics Research          --
--  http://seti.ssl.berkeley.edu/casper/                                     --
--  Copyright (C) 2006 University of California, Berkeley                    --
--                                                                           --
--  This program is free software; you can redistribute it and/or modify     --
--  it under the terms of the GNU General Public License as published by     --
--  the Free Software Foundation; either version 2 of the License, or        --
--  (at your option) any later version.                                      --
--                                                                           --
--  This program is distributed in the hope that it will be useful,          --
--  but WITHOUT ANY WARRANTY; without even the implied warranty of           --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            --
--  GNU General Public License for more details.                             --
--                                                                           --
--  You should have received a copy of the GNU General Public License along  --
--  with this program; if not, write to the Free Software Foundation, Inc.,  --
--  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.              --
--                                                                           --
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- dram_sim.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.all;

entity dram_sim is
    generic (
        C_WIDE_DATA     : in  integer := 0;
        C_HALF_BURST    : in  integer := 0;
        IP_CLOCK        : in  integer := 200;
        SYSCLK_PER      : in  time := 500 ms
    );
    port (
        clk             : in  std_logic := '0';
        ce              : in  std_logic := '0';
        rst             : in  std_logic_vector(  0 downto 0) := (others => '1');
        address         : in  std_logic_vector( 31 downto 0) := (others => '0');
        data_in         : in  std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');
        wr_be           : in  std_logic_vector( (18*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');
        RWn             : in  std_logic_vector(  0 downto 0) := (others => '0');
        cmd_tag         : in  std_logic_vector( 31 downto 0) := (others => '0');
        cmd_valid       : in  std_logic_vector(  0 downto 0) := (others => '0');
        rd_ack          : in  std_logic_vector(  0 downto 0) := (others => '0');
        cmd_ack         : out std_logic_vector(  0 downto 0) := (others => '0');
        data_out        : out std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');
        rd_tag          : out std_logic_vector( 31 downto 0) := (others => '0');
        rd_valid        : out std_logic_vector(  0 downto 0) := (others => '0');

        ----- DEBUGGING PORTS -------
        ddr_clock       : out std_logic_vector(  0 downto 0) := (others => '0');
        ddr_clock90     : out std_logic_vector(  0 downto 0) := (others => '0')
    );

end entity;

architecture dram_sim_arch of dram_sim is

--    constant C_WIDE_DATA                : integer := 0;
--    constant C_HALF_BURST               : integer := 0;

    -- DDR2 infrastructure clk and rst
    signal sys_clk                      : std_logic := '1';
    signal sys_reset_in                 : std_logic := '1';
    signal sys_dcmlock_in               : std_logic := '1';

    -- DDR2 controller clk and rst
    signal ddr_delay_sel                : std_logic_vector(  4 downto 0) := (others => '0');
    signal ddr_clk                      : std_logic := '0';
    signal ddr_clk90                    : std_logic := '0';
    signal ddr_inf_reset                : std_logic := '1';

    -- DDR2 controller signals
    signal DDR_input_data               : std_logic_vector(143 downto 0) := (others => '0');
    signal DDR_byte_enable              : std_logic_vector( 17 downto 0) := (others => '0');
    signal DDR_output_data              : std_logic_vector(143 downto 0) := (others => '0');
    signal DDR_address                  : std_logic_vector( 31 downto 0) := (others => '0');
    signal DDR_get_data                 : std_logic := '0';
    signal DDR_data_valid               : std_logic := '0';
    signal DDR_read                     : std_logic := '0';
    signal DDR_write                    : std_logic := '0';
    signal DDR_half_burst               : std_logic := '0';
    signal DDR_ready                    : std_logic := '0';
    signal DDR_reset                    : std_logic := '0';

    -- DDR2 controller pad stubs
	signal pad_dqs                      : std_logic_vector(  8 downto 0);
	signal pad_dq                       : std_logic_vector( 71 downto 0):= (OTHERS => 'Z');
	signal pad_csb                      : std_logic_vector(  1 downto 0);
	signal pad_dm                       : std_logic_vector(  8 downto 0);
	signal pad_ba                       : std_logic_vector(  1 downto 0);
	signal pad_address                  : std_logic_vector( 13 downto 0);
	signal pad_ODT                      : std_logic_vector(  1 downto 0);
    signal pad_rst_dqs_div_in           : std_logic := '0';
	signal pad_rst_dqs_div_out          : std_logic := '0';
	signal pad_cke                      : std_logic := '0';
	signal pad_rasb                     : std_logic := '0';
	signal pad_casb                     : std_logic := '0';
	signal pad_web                      : std_logic := '0';
	signal pad_clk0                     : std_logic := '0';
	signal pad_clk0b                    : std_logic := '0';
	signal pad_clk1                     : std_logic := '0';
	signal pad_clk1b                    : std_logic := '0';
	signal pad_clk2                     : std_logic := '0';
	signal pad_clk2b                    : std_logic := '0';

    -- Memory command signals
    signal Mem_Cmd_Address              : std_logic_vector( 31 downto 0) := (others => '0');
    signal Mem_Cmd_Tag                  : std_logic_vector( 31 downto 0) := (others => '0');
    signal Mem_Rd_Dout                  : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');
    signal Mem_Rd_Tag                   : std_logic_vector( 31 downto 0) := (others => '0');
    signal Mem_Wr_Din                   : std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');
    signal Mem_Wr_BE                    : std_logic_vector( (18*(C_WIDE_DATA+1))-1 downto 0) := (others => '1');
    signal Mem_Cmd_RNW                  : std_logic := '0';
    signal Mem_Cmd_Valid                : std_logic := '0';
    signal Mem_Cmd_Ack                  : std_logic := '0';
    signal Mem_Rd_Ack                   : std_logic := '0';
    signal Mem_Rd_Valid                 : std_logic := '0';

    signal rst_int                      : std_logic := '1';
    signal rst_sel                      : std_logic := '0';


    component async_ddr2 is
        generic(
            C_WIDE_DATA         : in  integer := 0;
            C_HALF_BURST        : in  integer := 0
        );
        port(
            -- mem interface
            Mem_Clk             : in  std_logic := '0';
            Mem_Rst             : in  std_logic := '0';
            Mem_Cmd_Address     : in  std_logic_vector( 31 downto 0) := (others => '0');
            Mem_Cmd_RNW         : in  std_logic := '0';
            Mem_Cmd_Valid       : in  std_logic := '0';
            Mem_Cmd_Tag         : in  std_logic_vector( 31 downto 0) := (others => '0');
            Mem_Cmd_Ack         : out std_logic := '0';
            Mem_Rd_Dout         : out std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');
            Mem_Rd_Tag          : out std_logic_vector( 31 downto 0) := (others => '0');
            Mem_Rd_Ack          : in  std_logic := '0';
            Mem_Rd_Valid        : out std_logic := '0';
            Mem_Wr_Din          : in  std_logic_vector((144*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');
            Mem_Wr_BE           : in  std_logic_vector( (18*(C_WIDE_DATA+1))-1 downto 0) := (others => '0');

            -- ddr interface
            DDR_clk             : in  std_logic := '0';
            DDR_input_data      : out std_logic_vector(143 downto 0) := (others => '0');
            DDR_byte_enable     : out std_logic_vector( 17 downto 0) := (others => '0');
            DDR_get_data        : in  std_logic := '0';
            DDR_output_data     : in  std_logic_vector(143 downto 0) := (others => 'Z');
            DDR_data_valid      : in  std_logic := '0';
            DDR_address         : out std_logic_vector( 31 downto 0) := (others => '0');
            DDR_read            : out std_logic := '0';
            DDR_write           : out std_logic := '0';
            DDR_half_burst      : out std_logic := '0';
            DDR_ready           : in  std_logic := '0';
            DDR_reset           : out std_logic := '0'
        );
    end component;

    component ddr2_controller is
        generic(
            IP_CLOCK                : integer := IP_CLOCK
        );
        port(
        	-- user interface
        	user_input_data         : in    std_logic_vector(143 downto 0) := (others => '0');
        	user_byte_enable        : in    std_logic_vector( 17 downto 0) := (others => '0');
        	user_get_data           : out   std_logic := '0';
        	user_output_data        : out   std_logic_vector(143 downto 0) := (others => 'Z');
        	user_data_valid         : out   std_logic := '0';
        	user_address            : in    std_logic_vector( 31 downto 0) := (others => '0');
        	user_read               : in    std_logic := '0';
        	user_write              : in    std_logic := '0';
        	user_half_burst         : in    std_logic := '0';
        	user_ready              : out   std_logic := '0';
        	user_reset              : in    std_logic := '0';

	        -- pads
	        pad_rst_dqs_div_in      : in    std_logic := '0';
	        pad_rst_dqs_div_out     : out   std_logic := '0';
	        pad_dqs                 : inout std_logic_vector(  8 downto 0) := (others => '0');
	        pad_dq                  : inout std_logic_vector( 71 downto 0):= (OTHERS => 'Z');
	        pad_cke                 : out   std_logic := '0';
	        pad_csb                 : out   std_logic_vector(  1 downto 0) := (others => '0');
	        pad_rasb                : out   std_logic := '0';
	        pad_casb                : out   std_logic := '0';
	        pad_web                 : out   std_logic := '0';
	        pad_dm                  : out   std_logic_vector(  8 downto 0) := (others => '0');
	        pad_ba                  : out   std_logic_vector(  1 downto 0) := (others => '0');
	        pad_address             : out   std_logic_vector( 13 downto 0) := (others => '0');
	        pad_ODT                 : out   std_logic_vector(  1 downto 0) := (others => '0');
	        pad_clk0                : out   std_logic := '0';
	        pad_clk0b               : out   std_logic := '0';
	        pad_clk1                : out   std_logic := '0';
	        pad_clk1b               : out   std_logic := '0';
	        pad_clk2                : out   std_logic := '0';
	        pad_clk2b               : out   std_logic := '0';

        	-- system interface
        	sys_clk                 : in    std_logic := '0';
        	sys_clk90               : in    std_logic := '0';
        	sys_delay_sel           : in    std_logic_vector(  4 downto 0) := (others => '0');
        	sys_inf_reset           : in    std_logic := '0'

        );
    end component;

begin

-- Connect to Simulink interface

    Mem_Cmd_Address <= address;
    Mem_Cmd_RNW     <= RWn(0);
    Mem_Cmd_Valid   <= cmd_valid(0);
    Mem_Cmd_Tag     <= cmd_tag;
    Mem_Rd_Ack      <= rd_ack(0);
    Mem_Wr_Din      <= data_in;
    Mem_Wr_BE       <= wr_be;

    cmd_ack(0)      <= Mem_Cmd_Ack;
    data_out        <= Mem_Rd_Dout;
    rd_tag          <= Mem_Rd_Tag;
    rd_valid(0)     <= Mem_Rd_Valid;


    -- clock generation process
    clk_gen: process
    begin
    	sys_clk <= '0';
    	wait for SYSCLK_PER;
    	sys_clk <= '1';
    	wait for SYSCLK_PER;
    end process clk_gen;

    ddr_clk <= sys_clk after 1 ms;
    ddr_clk90 <= ddr_clk after SYSCLK_PER/2;

    ddr_clock(0)   <= ddr_clk;
    ddr_clock90(0) <= ddr_clk90;

    reset_gen: process
    begin
        wait for 100 ms;
        ddr_inf_reset <= '0';
    end process reset_gen;

    reset_sel: process
    begin
        wait for 1500 ms;
        rst_sel <= '1';
    end process reset_sel;

    rst_int <= rst(0) when (rst_sel = '1') else '1' when (rst_sel = '0');


    ------------------------------------------
    -- Instance of DDR2 controller
    ------------------------------------------
    ddr2_controller_0 : ddr2_controller
      generic map
      (
        IP_CLOCK               =>   IP_CLOCK
      )
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

        -- pads
        pad_rst_dqs_div_in     =>   pad_rst_dqs_div_in  ,
	    pad_rst_dqs_div_out    =>   pad_rst_dqs_div_out ,
	    pad_dqs                =>   pad_dqs             ,
	    pad_dq                 =>   pad_dq              ,
	    pad_cke                =>   pad_cke             ,
	    pad_csb                =>   pad_csb             ,
	    pad_rasb               =>   pad_rasb            ,
	    pad_casb               =>   pad_casb            ,
	    pad_web                =>   pad_web             ,
	    pad_dm                 =>   pad_dm              ,
	    pad_ba                 =>   pad_ba              ,
	    pad_address            =>   pad_address         ,
	    pad_ODT                =>   pad_ODT             ,
	    pad_clk0               =>   pad_clk0            ,
	    pad_clk0b              =>   pad_clk0b           ,
	    pad_clk1               =>   pad_clk1            ,
	    pad_clk1b              =>   pad_clk1b           ,
	    pad_clk2               =>   pad_clk2            ,
	    pad_clk2b              =>   pad_clk2b           ,

        -- system interface
        sys_clk                =>   ddr_clk         ,
        sys_clk90              =>   ddr_clk90       ,
        sys_delay_sel          =>   ddr_delay_sel   ,
        sys_inf_reset          =>   ddr_inf_reset
        );

    ------------------------------------------
    -- Instance of Async DDR2
    ------------------------------------------
    async_ddr2_0 : async_ddr2
      generic map
      (
        C_WIDE_DATA     => C_WIDE_DATA        ,
        C_HALF_BURST    => C_HALF_BURST
        )
      port map
      (
        -- mem interface
        Mem_Clk          => clk             ,
        Mem_Rst          => rst_int         ,
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
        DDR_clk          => sys_clk         ,
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

end architecture dram_sim_arch;
