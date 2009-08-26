library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
	library ddr2_controller;
	use ddr2_controller.parameter.all;
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

	-- user 1 interface
	port0_input_data         : in  STD_LOGIC_VECTOR(143 downto 0);
	port0_byte_enable        : in  STD_LOGIC_VECTOR(17 downto 0):="111111111111111111";
	port0_get_data           : out STD_LOGIC;
	port0_output_data        : out STD_LOGIC_VECTOR(143 downto 0);
	port0_data_valid         : out STD_LOGIC;
	port0_address            : in  STD_LOGIC_VECTOR(31 downto 0);
	port0_read               : in  STD_LOGIC;
	port0_write              : in  STD_LOGIC;
	port0_ready              : out STD_LOGIC;



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

	-- DIMM 1 pads
	signal dimm1_rst_dqs_div_in     :  STD_LOGIC;
	signal dimm1_rst_dqs_div_out    :  STD_LOGIC;
	signal dimm1_casb               :  STD_LOGIC;
	signal dimm1_cke                :  STD_LOGIC; 
	signal dimm1_clk0               :  STD_LOGIC; 
	signal dimm1_clk0b              :  STD_LOGIC; 	
	signal dimm1_clk1               :  STD_LOGIC; 
	signal dimm1_clk1b              :  STD_LOGIC; 
	signal dimm1_clk2               :  STD_LOGIC; 
	signal dimm1_clk2b              :  STD_LOGIC; 
	signal dimm1_csb                :  STD_LOGIC_VECTOR(1 downto 0);
	signal dimm1_rasb               :  STD_LOGIC;
	signal dimm1_web                :  STD_LOGIC; 
	signal dimm1_ODT                :  STD_LOGIC_VECTOR(1 downto 0); 
	signal dimm1_address            :  STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	signal dimm1_ba                 :  STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	signal dimm1_dm                 :  STD_LOGIC_VECTOR(8 downto 0);
	signal dimm1_dqs                :  STD_LOGIC_VECTOR(8 downto 0); 
	signal dimm1_dq                 :  STD_LOGIC_VECTOR(71 downto 0);

	signal dimm1_clk                :  STD_LOGIC_VECTOR(2 downto 0);
	signal dimm1_clkb               :  STD_LOGIC_VECTOR(2 downto 0);
	signal dimm1_dqsb               :  STD_LOGIC_VECTOR(8 downto 0);
	signal dimm1_cke_ext            :  STD_LOGIC_VECTOR(1 downto 0);
	signal dimm1_ba_ext             :  STD_LOGIC_VECTOR(2 downto 0);



begin 

----------------------------------------
-- Power up reset extender
----------------------------------------

process(clk_in)
begin
	if clk_in'event and clk_in = '1' then
		-- counts for more than 200us and then release reset
		if reset_counter /= X"0000000" then
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

cntrl_DIMM1 : ddr2_cntrl_72bit_rl
port map(

	-- system interface
	sys_delay_sel_val    => sys_delay_sel              ,
	sys_clk_int          => clk_in                     , -- using input clock for simulation to get rid of delta delays
	sys_clk90_int        => sys_clk90_int              ,
	sys_rst              => sys_rst                    ,
	sys_rst90            => sys_rst90                  ,
	sys_rst180           => sys_rst180                 ,
	sys_rst270           => sys_rst270                 ,

	-- user interface
	user_input_data      => port0_input_data            ,
	user_byte_enable     => port0_byte_enable           , 
	user_get_data        => port0_get_data              , 
	user_output_data     => port0_output_data           , 
	user_data_valid      => port0_data_valid            , 
	user_col_address     => port0_address(12 downto 3)  , 
	user_row_address     => port0_address(26 downto 13) , 
	user_bank_address    => port0_address(28 downto 27) , 
	user_rank_address    => port0_address(29)           , 
	user_read            => port0_read                  , 
	user_write           => port0_write                 , 
	user_ready           => port0_ready                 , 

	-- pads
	pad_rst_dqs_div_in   => dimm1_rst_dqs_div_in         ,
	pad_rst_dqs_div_out  => dimm1_rst_dqs_div_out        , 
	pad_casb             => dimm1_casb                   ,
	pad_cke              => dimm1_cke                    , 
	pad_clk0             => dimm1_clk0                   , 
	pad_clk0b            => dimm1_clk0b                  , 	
	pad_clk1             => dimm1_clk1                   , 
	pad_clk1b            => dimm1_clk1b                  , 	
	pad_clk2             => dimm1_clk2                   , 
	pad_clk2b            => dimm1_clk2b                  ,   
	pad_csb              => dimm1_csb                    ,
	pad_rasb             => dimm1_rasb                   ,
	pad_web              => dimm1_web                    , 
	pad_ODT              => dimm1_ODT                    ,
	pad_address          => dimm1_address                ,
	pad_ba               => dimm1_ba                     ,
	pad_dm               => dimm1_dm                     ,
	pad_dqs              => dimm1_dqs                    , 
	pad_dq               => dimm1_dq

);


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

----------------------------------------
-- DDR2 DIMM signal mapping
----------------------------------------

dimm1_rst_dqs_div_in <= dimm1_rst_dqs_div_out after 1.6 ns;

dimm1_clk(0)  <= dimm1_clk0;
dimm1_clk(1)  <= dimm1_clk1;
dimm1_clk(2)  <= dimm1_clk2;
dimm1_clkb(0) <= dimm1_clk0b;
dimm1_clkb(1) <= dimm1_clk1b;
dimm1_clkb(2) <= dimm1_clk2b;
dimm1_dqsb    <= (others => '0');
dimm1_cke_ext <= dimm1_cke & dimm1_cke;
dimm1_ba_ext  <= '0' & dimm1_ba;

ddr2_dimm1 : ddr2dimm
port map
(
	ClockPos           => dimm1_clk     ,
	ClockNeg           => dimm1_clkb    ,
	ODT                => dimm1_ODT     ,
	CKE                => dimm1_cke_ext ,
	CS_N               => dimm1_csb     ,
	RAS_N              => dimm1_rasb    ,
	CAS_N              => dimm1_casb    ,
	WE_N               => dimm1_web     ,
	BA                 => dimm1_ba_ext  ,
	A                  => dimm1_address ,
	DM                 => dimm1_dm      ,
	DQ                 => dimm1_dq      ,
	DQS                => dimm1_dqs     ,
	DQS_N              => dimm1_dqsb
);

end arc_ddr2_controller; 

