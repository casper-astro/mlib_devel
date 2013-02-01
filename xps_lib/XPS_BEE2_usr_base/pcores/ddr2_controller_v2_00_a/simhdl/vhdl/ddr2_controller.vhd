library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.parameter.all;
--library synplify;
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
----------------------------------------
-- ENTITY DECLARATION
----------------------------------------
entity   ddr2_controller  is
generic(
	DIMM                    : integer := 1;
	bank_management         : integer := 0
);
port(
	-- user interface
	user_input_data        : in    std_logic_vector(143 downto 0);
	user_byte_enable       : in    std_logic_vector(17 downto 0);
	user_get_data          : out   std_logic;
	user_output_data       : out   std_logic_vector(143 downto 0):=(others => 'Z');
	user_data_valid        : out   std_logic;
	user_address           : in    std_logic_vector(31 downto 0);
	user_read              : in    std_logic;
	user_write             : in    std_logic;
	user_half_burst        : in    std_logic := '0';
	user_ready             : out   std_logic;
	user_reset             : in    std_logic;

	-- pads
	pad_rst_dqs_div_in     : in    std_logic;
	pad_rst_dqs_div_out    : out   std_logic;
	pad_dqs                : inout std_logic_vector(8 downto 0);
	pad_dq                 : inout std_logic_vector(71 downto 0):= (OTHERS => 'Z');
	pad_cke                : out   std_logic;
	pad_csb                : out   std_logic_vector(1 downto 0);
	pad_rasb               : out   std_logic;
	pad_casb               : out   std_logic;
	pad_web                : out   std_logic;
	pad_dm                 : out   std_logic_vector(8 downto 0);
	pad_ba                 : out   std_logic_vector((bank_address_p-1) downto 0);
	pad_address            : out   std_logic_vector((row_address_p-1) downto 0);
	pad_ODT                : out   std_logic_vector(1 downto 0);
	pad_clk0               : out   std_logic;
	pad_clk0b              : out   std_logic;
	pad_clk1               : out   std_logic;
	pad_clk1b              : out   std_logic;
	pad_clk2               : out   std_logic;
	pad_clk2b              : out   std_logic;

	-- system interface
	sys_clk                : in    std_logic;
	sys_clk90              : in    std_logic;
	sys_delay_sel          : in    std_logic_vector(4 downto 0);
	sys_inf_reset          : in    std_logic

);
end   ddr2_controller;

----------------------------------------
-- ARCHITECTURE DECLARATION
----------------------------------------

architecture   arc_ddr2_controller of   ddr2_controller is

----------------------------------------
-- state machine controller declaration
----------------------------------------
component controller
generic(
	bank_management        : integer := 0
);
port(
	-- system signals
	clk                    : in std_logic;
	reset                  : in std_logic;

	-- user interface
	user_get_data          : out std_logic;
	user_col_address       : in  std_logic_vector((column_address_p - 1) downto 0);
	user_row_address       : in  std_logic_vector((row_address_p - 1) downto 0);
	user_bank_address      : in  std_logic_vector((bank_address_p - 1) downto 0);
	user_rank_address      : in  std_logic;
	user_read              : in  std_logic;
	user_write             : in  std_logic;
	user_half_burst        : in  std_logic := '0';
	user_ready             : out std_logic;

	-- pads
	ddr_rasb               : out std_logic;
	ddr_casb               : out std_logic;
	ddr_ODT                : out std_logic_vector(1 downto 0);
	ddr_web                : out std_logic;
	ddr_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address            : out std_logic_vector((row_address_p-1) downto 0);
	ddr_cke                : out std_logic;
	ddr_csb                : out std_logic_vector(1 downto 0);
	ddr_rst_dqs_div_out    : out std_logic;
	ddr_force_nop          : out std_logic;

	-- init pads
	ddr_rasb_init          : out std_logic;
	ddr_casb_init          : out std_logic;
	ddr_web_init           : out std_logic;
	ddr_ba_init            : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address_init       : out std_logic_vector((row_address_p-1) downto 0);
	ddr_csb_init           : out std_logic_vector(1 downto 0);
	
	-- data path control
	dqs_enable             : out std_logic;
	dqs_reset              : out std_logic;
	write_enable           : out std_logic;
	disable_data           : out std_logic;
	disable_data_valid     : out std_logic;
	input_data_valid       : out std_logic;
	input_data_dummy       : out std_logic
);
end component;

----------------------------------------
-- data path declaration
----------------------------------------
component	data_path_72bit_rl
port(
	-- system ports
	clk                    : in std_logic;
	clk90                  : in std_logic;
	reset                  : in std_logic;
	reset90                : in std_logic;
	reset180               : in std_logic;
	reset270               : in std_logic;
	delay_sel              : in std_logic_vector(4 downto 0);

	-- data ports (on clk0)
	input_data             : in std_logic_vector(143 downto 0);
	write_enable           : in std_logic;
	input_data_valid       : in std_logic;
	input_data_dummy       : in std_logic;
	byte_enable            : in std_logic_vector(17 downto 0);
	disable_data           : in std_logic;
	disable_data_valid     : in std_logic;
	output_data_valid      : out std_logic;
	output_data            : out std_logic_vector(143 downto 0);

	-- iobs ports
	ddr_dqs_int_delay_in0  : in std_logic;
	ddr_dqs_int_delay_in1  : in std_logic;
	ddr_dqs_int_delay_in2  : in std_logic;
	ddr_dqs_int_delay_in3  : in std_logic;
	ddr_dqs_int_delay_in4  : in std_logic;
	ddr_dqs_int_delay_in5  : in std_logic;
	ddr_dqs_int_delay_in6  : in std_logic;
	ddr_dqs_int_delay_in7  : in std_logic;
	ddr_dqs_int_delay_in8  : in std_logic;
	ddr_dq                 : in std_logic_vector(71 downto 0);
	ddr_rst_dqs_div_in     : in std_logic;
	ddr_write_en           : out std_logic;
	ddr_data_mask_falling  : out std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : out std_logic_vector(8 downto 0);
	ddr_write_data_falling : out std_logic_vector(71 downto 0);
	ddr_write_data_rising  : out std_logic_vector(71 downto 0)
);
end component;

----------------------------------------
-- IO pads declaration
----------------------------------------
component	iobs_72bit
port(
	-- system ports
	clk                    : in std_logic;
	clk90                  : in std_logic;
	reset                  : in std_logic;
	reset90                : in std_logic;
	reset180               : in std_logic;
	reset270               : in std_logic;

	-- signals from/to the fabric
	ddr_rasb               : in std_logic;
	ddr_casb               : in std_logic;
	ddr_web                : in std_logic;
	ddr_cke                : in std_logic;
	ddr_csb                : in std_logic_vector(1 downto 0);
	ddr_ODT                : in std_logic_vector(1 downto 0);
	ddr_address            : in std_logic_vector((row_address_p-1) downto 0);
	ddr_ba                 : in std_logic_vector((bank_address_p-1) downto 0);
	ddr_rasb_init          : in std_logic;
	ddr_casb_init          : in std_logic;
	ddr_web_init           : in std_logic;
	ddr_ba_init            : in std_logic_vector((bank_address_p-1) downto 0);
	ddr_address_init       : in std_logic_vector((row_address_p-1) downto 0);
	ddr_csb_init           : in std_logic_vector(1 downto 0);
	ddr_write_data_falling : in std_logic_vector(71 downto 0);
	ddr_write_data_rising  : in std_logic_vector(71 downto 0);
	ddr_data_mask_falling  : in std_logic_vector(8 downto 0);
	ddr_data_mask_rising   : in std_logic_vector(8 downto 0);
	ddr_rst_dqs_div_out    : in std_logic;
	ddr_rst_dqs_div_in     : out std_logic;
	ddr_dqs_int_delay_in0  : out std_logic;
	ddr_dqs_int_delay_in1  : out std_logic;
	ddr_dqs_int_delay_in2  : out std_logic;
	ddr_dqs_int_delay_in3  : out std_logic;
	ddr_dqs_int_delay_in4  : out std_logic;
	ddr_dqs_int_delay_in5  : out std_logic;
	ddr_dqs_int_delay_in6  : out std_logic;
	ddr_dqs_int_delay_in7  : out std_logic;
	ddr_dqs_int_delay_in8  : out std_logic;
	ddr_dq                 : out std_logic_vector(71 downto 0);
	ddr_force_nop          : in  std_logic;

	-- I/O pads
	pad_dqs                : inout std_logic_vector(8 downto 0);
	pad_dq                 : inout std_logic_vector(71 downto 0);
	pad_dm                 : out std_logic_vector(8 downto 0);
	pad_clk0               : out std_logic;
	pad_clk0b              : out std_logic;
	pad_clk1               : out std_logic;
	pad_clk1b              : out std_logic;
	pad_clk2               : out std_logic;
	pad_clk2b              : out std_logic;
	pad_rasb               : out std_logic;
	pad_casb               : out std_logic;
	pad_web                : out std_logic;
	pad_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	pad_address            : out std_logic_vector((row_address_p-1) downto 0);
	pad_cke                : out std_logic;
	pad_csb                : out std_logic_vector(1 downto 0);
	pad_ODT                : out std_logic_vector(1 downto 0);
	pad_rst_dqs_div_in     : in std_logic;
	pad_rst_dqs_div_out    : out std_logic;

	-- control signals
	ctrl_dqs_reset         : in std_logic;
	ctrl_dqs_enable        : in std_logic;
	ctrl_write_en          : in std_logic

);
end component;

----------------------------------------
-- infrastructure declaration
----------------------------------------
component infrastructure
port(
	clk                    : in std_logic;
	clk90                  : in std_logic;
	inf_reset              : in std_logic;
	user_reset             : in std_logic;
	reset0                 : out std_logic;
	reset90                : out std_logic;
	reset180               : out std_logic;
	reset270               : out std_logic
);
end component;

----------------------------------------
-- DDR2 DIMM declaration
----------------------------------------

component   ddr2dimm
port(
	ClockPos           : in    std_logic_vector( 2 downto 0);
	ClockNeg           : in    std_logic_vector( 2 downto 0);
	ODT                : in    std_logic_vector( 1 downto 0);
	CKE                : in    std_logic_vector( 1 downto 0);
	CS_N               : in    std_logic_vector( 1 downto 0);
	RAS_N              : in    std_logic;
	CAS_N              : in    std_logic;
	WE_N               : in    std_logic;
	BA                 : in    std_logic_vector( 2 downto 0);
	A                  : in    std_logic_vector(13 downto 0);
	DM                 : in    std_logic_vector( 8 downto 0);
	DQ                 : inout std_logic_vector(71 downto 0);
	DQS                : inout std_logic_vector( 8 downto 0);
	DQS_N              : inout std_logic_vector( 8 downto 0)
);
end component;

----------------------------------------
-- signals declaration
----------------------------------------

	-- controller local resets
	signal reset0                 : std_logic := '1';
	signal reset90                : std_logic := '1';
	signal reset180               : std_logic := '1';
	signal reset270               : std_logic := '1';

	-- state machine controller signals
	signal ddr_rasb               :  std_logic;
	signal ddr_casb               :  std_logic;
	signal ddr_web                :  std_logic;
	signal ddr_ba                 :  std_logic_vector((bank_address_p-1) downto 0);
	signal ddr_address            :  std_logic_vector((row_address_p-1) downto 0);
	signal ddr_cke                :  std_logic;
	signal ddr_csb                :  std_logic_vector(1 downto 0);
	signal ddr_ODT                :  std_logic_vector(1 downto 0);
	signal ddr_force_nop          :  std_logic;
	signal ddr_rasb_init          :  std_logic;
	signal ddr_casb_init          :  std_logic;
	signal ddr_web_init           :  std_logic;
	signal ddr_ba_init            :  std_logic_vector((bank_address_p-1) downto 0);
	signal ddr_address_init       :  std_logic_vector((row_address_p-1) downto 0);
	signal ddr_csb_init           :  std_logic_vector(1 downto 0);

	-- data path signals
	-- control
	signal write_enable           : std_logic;
	signal dqs_enable             : std_logic;
	signal dqs_reset              : std_logic;
	signal input_data_valid       : std_logic;
	signal input_data_dummy       : std_logic;
	signal disable_data           : std_logic;
	signal disable_data_valid     : std_logic;
	-- active signals
	signal ddr_rst_dqs_div_in     : std_logic;
	signal ddr_rst_dqs_div_out    : std_logic;
	signal ddr_dqs_int_delay_in0  : std_logic;
	signal ddr_dqs_int_delay_in1  : std_logic;
	signal ddr_dqs_int_delay_in2  : std_logic;
	signal ddr_dqs_int_delay_in3  : std_logic;
	signal ddr_dqs_int_delay_in4  : std_logic;
	signal ddr_dqs_int_delay_in5  : std_logic;
	signal ddr_dqs_int_delay_in6  : std_logic;
	signal ddr_dqs_int_delay_in7  : std_logic;
	signal ddr_dqs_int_delay_in8  : std_logic;
	signal ddr_dq                 : std_logic_vector(71 downto 0);
	signal ddr_write_en           : std_logic;
	signal ddr_data_mask_falling  : std_logic_vector(8 downto 0);
	signal ddr_data_mask_rising   : std_logic_vector(8 downto 0);
	signal ddr_write_data_falling : std_logic_vector(71 downto 0);
	signal ddr_write_data_rising  : std_logic_vector(71 downto 0);

	-- DIMM pads
	signal sim_pad_rst_dqs_div_in  : std_logic;
	signal sim_pad_rst_dqs_div_out : std_logic;
	signal sim_pad_casb            : std_logic;
	signal sim_pad_cke             : std_logic;
	signal sim_pad_clk0            : std_logic;
	signal sim_pad_clk0b           : std_logic;
	signal sim_pad_clk1            : std_logic;
	signal sim_pad_clk1b           : std_logic;
	signal sim_pad_clk2            : std_logic;
	signal sim_pad_clk2b           : std_logic;
	signal sim_pad_csb             : std_logic_vector(1 downto 0);
	signal sim_pad_rasb            : std_logic;
	signal sim_pad_web             : std_logic;
	signal sim_pad_ODT             : std_logic_vector(1 downto 0);
	signal sim_pad_address         : std_logic_vector((row_address_p - 1) downto 0);
	signal sim_pad_ba              : std_logic_vector((bank_address_p - 1) downto 0);
	signal sim_pad_dm              : std_logic_vector(8 downto 0);
	signal sim_pad_dqs             : std_logic_vector(8 downto 0);
	signal sim_pad_dq              : std_logic_vector(71 downto 0);
	-- DIMM wiring signals
	signal dimm_clk                : std_logic_vector(2 downto 0);
	signal dimm_clkb               : std_logic_vector(2 downto 0);
	signal dimm_dqsb               : std_logic_vector(8 downto 0);
	signal dimm_cke                : std_logic_vector(1 downto 0);
	signal dimm_ba                 : std_logic_vector(2 downto 0);


begin

----------------------------------------
-- dummy assignments for XPS
----------------------------------------
pad_rst_dqs_div_out    <= '0';
pad_dqs                <= (others => '0');
pad_dq                 <= (others => '0');
pad_cke                <= '0';
pad_csb                <= (others => '0');
pad_rasb               <= '0';
pad_casb               <= '0';
pad_web                <= '0';
pad_dm                 <= (others => '0');
pad_ba                 <= (others => '0');
pad_address            <= (others => '0');
pad_ODT                <= (others => '0');
pad_clk0               <= '0';
pad_clk0b              <= '0';
pad_clk1               <= '0';
pad_clk1b              <= '0';
pad_clk2               <= '0';
pad_clk2b              <= '0';

----------------------------------------
-- state machine controller signals mapping
----------------------------------------
controller0 : controller
generic map (
	bank_management        => bank_management
)
port map (
	-- system signals
	clk                    => sys_clk                    ,
	reset                  => reset0                     ,

	-- user interface
	user_get_data          => user_get_data              ,
	user_col_address       => user_address(12 downto 3)  ,
	user_row_address       => user_address(27 downto 14) ,
	user_bank_address      => user_address(29 downto 28) ,
	user_rank_address      => user_address(13)           ,
	user_read              => user_read                  ,
	user_write             => user_write                 ,
	user_half_burst        => user_half_burst            ,
	user_ready             => user_ready                 ,

	-- pads
	ddr_rasb               => ddr_rasb                   ,
	ddr_casb               => ddr_casb                   ,
	ddr_ODT                => ddr_ODT                    ,
	ddr_web                => ddr_web                    ,
	ddr_ba                 => ddr_ba                     ,
	ddr_address            => ddr_address                ,
	ddr_cke                => ddr_cke                    ,
	ddr_csb                => ddr_csb                    ,
	ddr_rst_dqs_div_out    => ddr_rst_dqs_div_out        ,
	ddr_force_nop          => ddr_force_nop              ,

	-- init_pads
	ddr_rasb_init          => ddr_rasb_init              ,
	ddr_casb_init          => ddr_casb_init              ,
	ddr_web_init           => ddr_web_init               ,
	ddr_ba_init            => ddr_ba_init                ,
	ddr_address_init       => ddr_address_init           ,
	ddr_csb_init           => ddr_csb_init               ,

	-- data path control
	dqs_enable             => dqs_enable                 ,
	dqs_reset              => dqs_reset                  ,
	write_enable           => write_enable               ,
	disable_data           => disable_data               ,
	disable_data_valid     => disable_data_valid         ,
	input_data_valid       => input_data_valid           ,
	input_data_dummy       => input_data_dummy
);

----------------------------------------
-- data path signals mapping
----------------------------------------
data_path0	:	data_path_72bit_rl
port	map	(
	-- system ports
	clk                    => sys_clk               ,
	clk90                  => sys_clk90             ,
	reset                  => reset0                ,
	reset90                => reset90               ,
	reset180               => reset180              ,
	reset270               => reset270              ,
	delay_sel              => sys_delay_sel         ,

	-- data ports (on clk0)
	input_data             => user_input_data       ,
	write_enable           => write_enable          ,
	disable_data           => disable_data          ,
	disable_data_valid     => disable_data_valid    ,
	byte_enable            => user_byte_enable      ,
	output_data_valid      => user_data_valid       ,
	output_data            => user_output_data      ,
	input_data_valid       => input_data_valid      ,
	input_data_dummy       => input_data_dummy      ,

	-- iobs ports
	ddr_dqs_int_delay_in0  => ddr_dqs_int_delay_in0 ,
	ddr_dqs_int_delay_in1  => ddr_dqs_int_delay_in1 ,
	ddr_dqs_int_delay_in2  => ddr_dqs_int_delay_in2 ,
	ddr_dqs_int_delay_in3  => ddr_dqs_int_delay_in3 ,
	ddr_dqs_int_delay_in4  => ddr_dqs_int_delay_in4 ,
	ddr_dqs_int_delay_in5  => ddr_dqs_int_delay_in5 ,
	ddr_dqs_int_delay_in6  => ddr_dqs_int_delay_in6 ,
	ddr_dqs_int_delay_in7  => ddr_dqs_int_delay_in7 ,
	ddr_dqs_int_delay_in8  => ddr_dqs_int_delay_in8 ,
	ddr_dq                 => ddr_dq                ,
	ddr_rst_dqs_div_in     => ddr_rst_dqs_div_in    ,
	ddr_write_en           => ddr_write_en          ,
	ddr_data_mask_falling  => ddr_data_mask_falling ,
	ddr_data_mask_rising   => ddr_data_mask_rising  ,
	ddr_write_data_falling => ddr_write_data_falling,
	ddr_write_data_rising  => ddr_write_data_rising
);

----------------------------------------
-- IO pads signals mapping
----------------------------------------
iobs0	:	iobs_72bit	port	map
(
	-- system ports
	clk                    => sys_clk               ,
	clk90                  => sys_clk90             ,
	reset                  => reset0                ,
	reset90                => reset90               ,
	reset180               => reset180              ,
	reset270               => reset270              ,

	-- signals from/to the fabric  
	ddr_rasb               => ddr_rasb              , 
	ddr_casb               => ddr_casb              , 
	ddr_web                => ddr_web               , 
	ddr_cke                => ddr_cke               , 
	ddr_csb                => ddr_csb               , 
	ddr_ODT                => ddr_ODT               , 
	ddr_address            => ddr_address           , 
	ddr_ba                 => ddr_ba                , 
	ddr_rasb_init          => ddr_rasb_init         ,
	ddr_casb_init          => ddr_casb_init         ,
	ddr_web_init           => ddr_web_init          ,
	ddr_ba_init            => ddr_ba_init           ,
	ddr_address_init       => ddr_address_init      ,
	ddr_csb_init           => ddr_csb_init          ,
	ddr_write_data_falling => ddr_write_data_falling, 
	ddr_write_data_rising  => ddr_write_data_rising , 
	ddr_data_mask_falling  => ddr_data_mask_falling , 
	ddr_data_mask_rising   => ddr_data_mask_rising  ,                                                      
	ddr_rst_dqs_div_out    => ddr_rst_dqs_div_out   , 
	ddr_rst_dqs_div_in     => ddr_rst_dqs_div_in    , 
	ddr_dqs_int_delay_in0  => ddr_dqs_int_delay_in0 , 
	ddr_dqs_int_delay_in1  => ddr_dqs_int_delay_in1 , 
	ddr_dqs_int_delay_in2  => ddr_dqs_int_delay_in2 , 
	ddr_dqs_int_delay_in3  => ddr_dqs_int_delay_in3 , 
	ddr_dqs_int_delay_in4  => ddr_dqs_int_delay_in4 , 
	ddr_dqs_int_delay_in5  => ddr_dqs_int_delay_in5 , 
	ddr_dqs_int_delay_in6  => ddr_dqs_int_delay_in6 , 
	ddr_dqs_int_delay_in7  => ddr_dqs_int_delay_in7 , 
	ddr_dqs_int_delay_in8  => ddr_dqs_int_delay_in8 , 
	ddr_dq                 => ddr_dq                , 
	ddr_force_nop          => ddr_force_nop         ,

	-- I/O pads
	pad_dqs                => sim_pad_dqs               ,
	pad_dq                 => sim_pad_dq                ,
	pad_dm                 => sim_pad_dm                ,
	pad_clk0               => sim_pad_clk0              ,
	pad_clk0b              => sim_pad_clk0b             ,
	pad_clk1               => sim_pad_clk1              ,
	pad_clk1b              => sim_pad_clk1b             ,
	pad_clk2               => sim_pad_clk2              ,
	pad_clk2b              => sim_pad_clk2b             ,
	pad_rasb               => sim_pad_rasb              ,
	pad_casb               => sim_pad_casb              ,
	pad_web                => sim_pad_web               ,
	pad_ba                 => sim_pad_ba                ,
	pad_address            => sim_pad_address           ,
	pad_cke                => sim_pad_cke               ,
	pad_csb                => sim_pad_csb               ,
	pad_ODT                => sim_pad_ODT               ,
	pad_rst_dqs_div_in     => sim_pad_rst_dqs_div_in    ,
	pad_rst_dqs_div_out    => sim_pad_rst_dqs_div_out   ,

	-- control signals
	ctrl_dqs_reset         => dqs_reset             ,
	ctrl_dqs_enable        => dqs_enable            ,
	ctrl_write_en          => ddr_write_en

);

----------------------------------------
-- infrastructure signals mapping
----------------------------------------
infrastructure0 : infrastructure port map
(
	clk                    => sys_clk               ,
	clk90                  => sys_clk90             ,
	inf_reset              => sys_inf_reset         ,
	user_reset             => user_reset            ,
	reset0                 => reset0                ,
	reset90                => reset90               ,
	reset180               => reset180              ,
	reset270               => reset270
);

----------------------------------------
-- DDR2 DIMM signal mapping
----------------------------------------

sim_pad_rst_dqs_div_in <= sim_pad_rst_dqs_div_out after 1.6 ns;

dimm_clk(0)  <= sim_pad_clk0;
dimm_clk(1)  <= sim_pad_clk1;
dimm_clk(2)  <= sim_pad_clk2;
dimm_clkb(0) <= sim_pad_clk0b;
dimm_clkb(1) <= sim_pad_clk1b;
dimm_clkb(2) <= sim_pad_clk2b;
dimm_dqsb    <= (others => '0');
dimm_cke     <= sim_pad_cke & sim_pad_cke;
dimm_ba      <= '0' & sim_pad_ba;

ddr2dimm0 : ddr2dimm
port map
(
	ClockPos           => dimm_clk        ,
	ClockNeg           => dimm_clkb       ,
	ODT                => sim_pad_ODT     ,
	CKE                => dimm_cke        ,
	CS_N               => sim_pad_csb     ,
	RAS_N              => sim_pad_rasb    ,
	CAS_N              => sim_pad_casb    ,
	WE_N               => sim_pad_web     ,
	BA                 => dimm_ba         ,
	A                  => sim_pad_address ,
	DM                 => sim_pad_dm      ,
	DQ                 => sim_pad_dq      ,
	DQS                => sim_pad_dqs     ,
	DQS_N              => dimm_dqsb
);

end   arc_ddr2_controller;


