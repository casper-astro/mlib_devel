library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
!TCL! if $synthesize {
	use work.parameter.all;
!TCL! } else {
	library ddr2_controller;
	use ddr2_controller.parameter.all;
!TCL! }
 --library synplify; 
--use synplify.attributes.all;
--
-- pragma translate_off
library UNISIM;use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
----------------------------------------
-- ENTITY DECLARATION
----------------------------------------

entity  ddr2_controller is
port(

!TCL! foreach i $DIMM_NUMS {
!TCL! set user_name [lindex $USER_IFS [expr $i-1]]
	-- user ${i} interface
	${user_name}_input_data         : in  STD_LOGIC_VECTOR(143 downto 0);
	${user_name}_byte_enable        : in  STD_LOGIC_VECTOR(17 downto 0):="111111111111111111";
	${user_name}_get_data           : out STD_LOGIC;
	${user_name}_output_data        : out STD_LOGIC_VECTOR(143 downto 0);
	${user_name}_data_valid         : out STD_LOGIC;
	${user_name}_address            : in  STD_LOGIC_VECTOR(31 downto 0);
	${user_name}_read               : in  STD_LOGIC;
	${user_name}_write              : in  STD_LOGIC;
	${user_name}_ready              : out STD_LOGIC;

!TCL! }

!TCL! if $synthesize {
!TCL! 	foreach i $DIMM_NUMS {
	-- DIMM ${i} pads
	dimm${i}_rst_dqs_div_in         : in STD_LOGIC;
	dimm${i}_rst_dqs_div_out        : out STD_LOGIC;
	dimm${i}_casb                   : out STD_LOGIC;
	dimm${i}_cke                    : out STD_LOGIC; 
	dimm${i}_clk0                   : out STD_LOGIC; 
	dimm${i}_clk0b                  : out STD_LOGIC; 	
	dimm${i}_clk1                   : out STD_LOGIC; 
	dimm${i}_clk1b                  : out STD_LOGIC; 
	dimm${i}_clk2                   : out STD_LOGIC; 
	dimm${i}_clk2b                  : out STD_LOGIC; 
	dimm${i}_csb                    : out STD_LOGIC_VECTOR(1 downto 0);
	dimm${i}_rasb                   : out STD_LOGIC;
	dimm${i}_web                    : out STD_LOGIC; 
	dimm${i}_ODT                    : out STD_LOGIC_VECTOR(1 downto 0); 
	dimm${i}_address                : out STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	dimm${i}_ba                     : out STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	dimm${i}_dm                     : out STD_LOGIC_VECTOR(8 downto 0);
	dimm${i}_dqs                    : inout STD_LOGIC_VECTOR(8 downto 0); 
	dimm${i}_dq                     : inout STD_LOGIC_VECTOR(71 downto 0);

!TCL! 	}
!TCL! }

	-- System interface
	clk_in                          : in STD_LOGIC;
	reset_in                        : in STD_LOGIC

);

end   ddr2_controller; 

----------------------------------------
-- ARCHITECTURE DECLARATION
----------------------------------------

architecture   arc_ddr2_controller of    ddr2_controller    is 

----------------------------------------
-- low level controller declaration
----------------------------------------
component   ddr2_cntrl_72bit_rl
port(

	-- system interface
	sys_delay_sel_val           : in    STD_LOGIC_VECTOR(4 downto 0);
	sys_clk_int                 : in    STD_LOGIC;
	sys_clk90_int               : in    STD_LOGIC;
	sys_rst                     : in    STD_LOGIC;
	sys_rst90                   : in    STD_LOGIC;
	sys_rst180                  : in    STD_LOGIC;
	sys_rst270                  : in    STD_LOGIC;

	-- user interface
	user_input_data             : in    STD_LOGIC_VECTOR(143 downto 0);
	user_byte_enable            : in    STD_LOGIC_VECTOR(17 downto 0):="111111111111111111";
	user_get_data               : out   STD_LOGIC;
	user_output_data            : out   STD_LOGIC_VECTOR(143 downto 0);
	user_data_valid             : out   STD_LOGIC;

	user_col_address            : in    STD_LOGIC_VECTOR((column_address_p - 1) downto 0);
	user_row_address            : in    STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	user_bank_address           : in    STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	user_rank_address           : in    STD_LOGIC;

	user_read                   : in    STD_LOGIC;
	user_write                  : in    STD_LOGIC;
	user_ready                  : out   STD_LOGIC;
	
	-- DIMM pads
	pad_rst_dqs_div_in          : in    STD_LOGIC;
	pad_rst_dqs_div_out         : out   STD_LOGIC; 
	pad_casb                    : out   STD_LOGIC;
	pad_cke                     : out   STD_LOGIC;
	pad_clk0                    : out   STD_LOGIC; 
	pad_clk0b                   : out   STD_LOGIC; 
	pad_clk1                    : out   STD_LOGIC; 
	pad_clk1b                   : out   STD_LOGIC; 
	pad_clk2                    : out   STD_LOGIC; 
	pad_clk2b                   : out   STD_LOGIC; 
	pad_csb                     : out   STD_LOGIC_VECTOR(1 downto 0);
	pad_rasb                    : out   STD_LOGIC;
	pad_web                     : out   STD_LOGIC; 
	pad_ODT                     : out   STD_LOGIC_VECTOR(1 downto 0); 
	pad_address                 : out   STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	pad_ba                      : out   STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	pad_dm                      : out   STD_LOGIC_VECTOR(8 downto 0);
	pad_dqs                     : inout STD_LOGIC_VECTOR(8 downto 0);
	pad_dq                      : inout STD_LOGIC_VECTOR(71 downto 0) 
);
end component;   

!TCL! if !$synthesize {
----------------------------------------
-- DDR2 DIMM declaration
----------------------------------------

component   ddr2dimm
port(
	ClockPos           : in    STD_LOGIC_VECTOR( 2 downto 0);
	ClockNeg           : in    STD_LOGIC_VECTOR( 2 downto 0);
	ODT                : in    STD_LOGIC_VECTOR( 1 downto 0);
	CKE                : in    STD_LOGIC_VECTOR( 1 downto 0);
	CS_N               : in    STD_LOGIC_VECTOR( 1 downto 0);
	RAS_N              : in    STD_LOGIC;
	CAS_N              : in    STD_LOGIC;
	WE_N               : in    STD_LOGIC;
	BA                 : in    STD_LOGIC_VECTOR( 2 downto 0);
	A                  : in    STD_LOGIC_VECTOR(13 downto 0);
	DM                 : in    STD_LOGIC_VECTOR( 8 downto 0);
	DQ                 : inout STD_LOGIC_VECTOR(71 downto 0);
	DQS                : inout STD_LOGIC_VECTOR( 8 downto 0);
	DQS_N              : inout STD_LOGIC_VECTOR( 8 downto 0)
);
end component;   
!TCL! }

----------------------------------------
-- system infrastructure declaration
----------------------------------------
component infrastructure_top
port (
	-- system interface
	reset_in                    : in  STD_LOGIC;
	sys_clk_ibuf                : in  STD_LOGIC; 
	delay_sel_val1_val          : out STD_LOGIC_VECTOR(4 downto 0); 
	sys_rst_val                 : out STD_LOGIC;
	sys_rst90_val               : out STD_LOGIC;
	sys_rst180_val              : out STD_LOGIC;
	sys_rst270_val              : out STD_LOGIC;
	clk_int_val                 : out STD_LOGIC;
	clk90_int_val               : out STD_LOGIC

);
end component;

----------------------------------------
-- signals declaration
----------------------------------------

	-- system signals
	signal extended_reset              :  STD_LOGIC := '1';
	signal reset_counter               :  STD_LOGIC_VECTOR(27 downto 0) := X"0000000";
	signal sys_rst                     :  STD_LOGIC;
	signal sys_rst90                   :  STD_LOGIC;
	signal sys_rst180                  :  STD_LOGIC;
	signal sys_rst270                  :  STD_LOGIC;
	signal sys_clk_int                 :  STD_LOGIC;
	signal sys_clk90_int               :  STD_LOGIC; 
	signal sys_delay_sel               :  STD_LOGIC_VECTOR(4 downto 0);

!TCL! if !$synthesize {
!TCL! 	foreach i $DIMM_NUMS {
	-- DIMM ${i} pads
	signal dimm${i}_rst_dqs_div_in     :  STD_LOGIC;
	signal dimm${i}_rst_dqs_div_out    :  STD_LOGIC;
	signal dimm${i}_casb               :  STD_LOGIC;
	signal dimm${i}_cke                :  STD_LOGIC; 
	signal dimm${i}_clk0               :  STD_LOGIC; 
	signal dimm${i}_clk0b              :  STD_LOGIC; 	
	signal dimm${i}_clk1               :  STD_LOGIC; 
	signal dimm${i}_clk1b              :  STD_LOGIC; 
	signal dimm${i}_clk2               :  STD_LOGIC; 
	signal dimm${i}_clk2b              :  STD_LOGIC; 
	signal dimm${i}_csb                :  STD_LOGIC_VECTOR(1 downto 0);
	signal dimm${i}_rasb               :  STD_LOGIC;
	signal dimm${i}_web                :  STD_LOGIC; 
	signal dimm${i}_ODT                :  STD_LOGIC_VECTOR(1 downto 0); 
	signal dimm${i}_address            :  STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	signal dimm${i}_ba                 :  STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	signal dimm${i}_dm                 :  STD_LOGIC_VECTOR(8 downto 0);
	signal dimm${i}_dqs                :  STD_LOGIC_VECTOR(8 downto 0); 
	signal dimm${i}_dq                 :  STD_LOGIC_VECTOR(71 downto 0);

	signal dimm${i}_clk                :  STD_LOGIC_VECTOR(2 downto 0);
	signal dimm${i}_clkb               :  STD_LOGIC_VECTOR(2 downto 0);
	signal dimm${i}_dqsb               :  STD_LOGIC_VECTOR(8 downto 0);
	signal dimm${i}_cke_ext            :  STD_LOGIC_VECTOR(1 downto 0);
	signal dimm${i}_ba_ext             :  STD_LOGIC_VECTOR(2 downto 0);

!TCL! 	}
!TCL! }


begin 

----------------------------------------
-- Power up reset extender
----------------------------------------

process(clk_in)
begin
	if clk_in'event and clk_in = '1' then
		-- counts for more than 200us and then release reset
!TCL! if $synthesize {
		if reset_counter /= X"0030D40" then
!TCL! } else {
		if reset_counter /= X"0000000" then
!TCL! }
			reset_counter <= reset_counter + 1;
			extended_reset <= '1';
		else
			extended_reset <= reset_in;
		end if;
	end if;
end process;

----------------------------------------
-- Low level controller signals mapping
----------------------------------------

!TCL! foreach i $DIMM_NUMS {
!TCL! set user_name [lindex $USER_IFS [expr $i-1]]
cntrl_DIMM${i} : ddr2_cntrl_72bit_rl
port map(

	-- system interface
	sys_delay_sel_val    => sys_delay_sel              ,
!TCL! if $synthesize {
	sys_clk_int          => sys_clk_int                ,
!TCL! } else {
	sys_clk_int          => clk_in                     , -- using input clock for simulation to get rid of delta delays
!TCL! }
	sys_clk90_int        => sys_clk90_int              ,
	sys_rst              => sys_rst                    ,
	sys_rst90            => sys_rst90                  ,
	sys_rst180           => sys_rst180                 ,
	sys_rst270           => sys_rst270                 ,

	-- user interface
	user_input_data      => ${user_name}_input_data            ,
	user_byte_enable     => ${user_name}_byte_enable           , 
	user_get_data        => ${user_name}_get_data              , 
	user_output_data     => ${user_name}_output_data           , 
	user_data_valid      => ${user_name}_data_valid            , 
	user_col_address     => ${user_name}_address(12 downto 3)  , 
	user_row_address     => ${user_name}_address(26 downto 13) , 
	user_bank_address    => ${user_name}_address(28 downto 27) , 
	user_rank_address    => ${user_name}_address(29)           , 
	user_read            => ${user_name}_read                  , 
	user_write           => ${user_name}_write                 , 
	user_ready           => ${user_name}_ready                 , 

	-- pads
	pad_rst_dqs_div_in   => dimm${i}_rst_dqs_div_in         ,
	pad_rst_dqs_div_out  => dimm${i}_rst_dqs_div_out        , 
	pad_casb             => dimm${i}_casb                   ,
	pad_cke              => dimm${i}_cke                    , 
	pad_clk0             => dimm${i}_clk0                   , 
	pad_clk0b            => dimm${i}_clk0b                  , 	
	pad_clk1             => dimm${i}_clk1                   , 
	pad_clk1b            => dimm${i}_clk1b                  , 	
	pad_clk2             => dimm${i}_clk2                   , 
	pad_clk2b            => dimm${i}_clk2b                  ,   
	pad_csb              => dimm${i}_csb                    ,
	pad_rasb             => dimm${i}_rasb                   ,
	pad_web              => dimm${i}_web                    , 
	pad_ODT              => dimm${i}_ODT                    ,
	pad_address          => dimm${i}_address                ,
	pad_ba               => dimm${i}_ba                     ,
	pad_dm               => dimm${i}_dm                     ,
	pad_dqs              => dimm${i}_dqs                    , 
	pad_dq               => dimm${i}_dq

);

!TCL! }

----------------------------------------
-- infrastructure signals mapping
----------------------------------------
infrastructure_top0 : infrastructure_top
port map
(
	reset_in             => extended_reset             ,
	sys_clk_ibuf         => clk_in                     ,
	delay_sel_val1_val   => sys_delay_sel              , 
	sys_rst_val          => sys_rst                    ,
	sys_rst90_val        => sys_rst90                  ,
	sys_rst180_val       => sys_rst180                 ,
	sys_rst270_val       => sys_rst270                 ,
	clk_int_val          => sys_clk_int                ,
	clk90_int_val        => sys_clk90_int
);

!TCL! if !${synthesize} {
----------------------------------------
-- DDR2 DIMM signal mapping
----------------------------------------

!TCL! 	foreach i $DIMM_NUMS {
dimm${i}_rst_dqs_div_in <= dimm${i}_rst_dqs_div_out after 1.6 ns;

dimm${i}_clk(0)  <= dimm${i}_clk0;
dimm${i}_clk(1)  <= dimm${i}_clk1;
dimm${i}_clk(2)  <= dimm${i}_clk2;
dimm${i}_clkb(0) <= dimm${i}_clk0b;
dimm${i}_clkb(1) <= dimm${i}_clk1b;
dimm${i}_clkb(2) <= dimm${i}_clk2b;
dimm${i}_dqsb    <= (others => '0');
dimm${i}_cke_ext <= dimm${i}_cke & dimm${i}_cke;
dimm${i}_ba_ext  <= '0' & dimm${i}_ba;

ddr2_dimm${i} : ddr2dimm
port map
(
	ClockPos           => dimm${i}_clk     ,
	ClockNeg           => dimm${i}_clkb    ,
	ODT                => dimm${i}_ODT     ,
	CKE                => dimm${i}_cke_ext ,
	CS_N               => dimm${i}_csb     ,
	RAS_N              => dimm${i}_rasb    ,
	CAS_N              => dimm${i}_casb    ,
	WE_N               => dimm${i}_web     ,
	BA                 => dimm${i}_ba_ext  ,
	A                  => dimm${i}_address ,
	DM                 => dimm${i}_dm      ,
	DQ                 => dimm${i}_dq      ,
	DQS                => dimm${i}_dqs     ,
	DQS_N              => dimm${i}_dqsb
);
!TCL! 	}
!TCL! }

end arc_ddr2_controller; 
