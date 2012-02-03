--  File name :       controller.vhd
--
--  Description :     
--                    Main DDR SDRAM controller block.
--
--  Date - revision : 08/10/2005
--
--  Author :          Pierre-Yves Droz
--


--                   #                    
--                   #                    
-- ## ##    #####   ####    #####   ##### 
--  ##  #  #     #   #     #     # #     #
--  #   #  #     #   #     #######  ###   
--  #   #  #     #   #     #           ## 
--  #   #  #     #   #  #  #     # #     #
-- ### ###  #####     ##    #####   ##### 


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.parameter.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on
--
entity controller is
port(
	-- system signals
	clk                    : in std_logic;
	reset                  : in std_logic;

	-- user interface
	user_get_data          : out STD_LOGIC;
	user_col_address       : in  STD_LOGIC_VECTOR((column_address_p - 1) downto 0);
	user_row_address       : in  STD_LOGIC_VECTOR((row_address_p - 1) downto 0);
	user_bank_address      : in  STD_LOGIC_VECTOR((bank_address_p - 1) downto 0);
	user_rank_address      : in  STD_LOGIC;
	user_read              : in  STD_LOGIC;
	user_write             : in  STD_LOGIC;
	user_ready             : out  STD_LOGIC := '0';

	-- pads
	ddr_rasb               : out std_logic;
	ddr_casb               : out std_logic;
	ddr_web                : out std_logic;
	ddr_ODT                : out std_logic_vector(1 downto 0);
	ddr_ba                 : out std_logic_vector((bank_address_p-1) downto 0);
	ddr_address            : out std_logic_vector((row_address_p-1) downto 0);
	ddr_cke                : out std_logic;
	ddr_csb                : out std_logic_vector(1 downto 0);
	ddr_rst_dqs_div_out    : out std_logic;
	ddr_force_nop          : out std_logic_vector(1 downto 0);
	
	-- data path control
	dqs_enable             : out std_logic;
	dqs_reset              : out std_logic;
	write_enable           : out std_logic;
	input_data_valid       : out std_logic;

	-- infrastructure control
	rst_calib              : out std_logic
);
end controller;

architecture arc_controller of controller is

attribute syn_noprune : boolean;

type fsm_state is (
			INIT_WAIT_POWER_UP,
			INIT_WAIT_01_COMMAND,
			INIT_WAIT_02_COMMAND,
			INIT_WAIT_03_COMMAND,			
			INIT_WAIT_04_COMMAND,			
			INIT_WAIT_05_COMMAND,			
			INIT_WAIT_06_COMMAND,			
			INIT_WAIT_07_COMMAND,			
			INIT_WAIT_08_COMMAND,			
			INIT_WAIT_09_COMMAND,			
			INIT_WAIT_10_COMMAND,			
			INIT_WAIT_11_COMMAND,			
			INIT_WAIT_12_COMMAND,			
			INIT_WAIT_COMPLETION,
			INIT_COMPLETE
		);
signal init_state: fsm_state;

	-- timming constants
	-- init
	constant POWERUP_CNT       : std_logic_vector(15 downto 0) := X"000F";
	constant CLKLOCK_CNT       : std_logic_vector(7 downto 0)  := X"50";
	constant TRPA_CNT          : std_logic_vector(3 downto 0)  := X"4";
	constant TMRD_CNT          : std_logic_vector(3 downto 0)  := X"2";
	constant TRFC_CNT          : std_logic_vector(7 downto 0)  := X"15";
	constant PLLLOCK_CNT       : std_logic_vector(7 downto 0)  := X"C8";
	-- command to command
	constant REF_2_REF_CNT     : std_logic_vector(7 downto 0)  := X"15";
	constant REF_2_ACT_CNT     : std_logic_vector(7 downto 0)  := X"15";
	constant REF_2_PRE_CNT     : std_logic_vector(7 downto 0)  := X"15";
	constant REF_2_RD_CNT      : std_logic_vector(7 downto 0)  := X"00";  -- FORBIDDEN
	constant REF_2_WR_CNT      : std_logic_vector(7 downto 0)  := X"00";  -- FORBIDDEN
	constant ACT_2_REF_CNT     : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant ACT_2_ACT_CNT     : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant ACT_2_PRE_CNT     : std_logic_vector(3 downto 0)  := X"8";
	constant ACT_2_RD_CNT      : std_logic_vector(3 downto 0)  := X"3";
	constant ACT_2_WR_CNT      : std_logic_vector(3 downto 0)  := X"3";
	constant PRE_2_REF_CNT     : std_logic_vector(3 downto 0)  := X"3";
	constant PRE_2_ACT_CNT     : std_logic_vector(3 downto 0)  := X"3";
	constant PRE_2_PRE_CNT     : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant PRE_2_RD_CNT      : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant PRE_2_WR_CNT      : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant RD_2_REF_CNT      : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant RD_2_ACT_CNT      : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant RD_2_PRE_CNT      : std_logic_vector(3 downto 0)  := X"2";
	constant RD_2_RD_CNT       : std_logic_vector(3 downto 0)  := X"2";
	constant RD_2_WR_CNT       : std_logic_vector(3 downto 0)  := X"5"; -- X"4"; DEBUG
	constant WR_2_REF_CNT      : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant WR_2_ACT_CNT      : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant WR_2_PRE_CNT      : std_logic_vector(3 downto 0)  := X"7";
	constant WR_2_RD_CNT       : std_logic_vector(3 downto 0)  := X"7"; -- X"6"; DEBUG
	constant WR_2_WR_CNT       : std_logic_vector(3 downto 0)  := X"2";
	-- command to ready
	constant REF_2_READY_CNT   : std_logic_vector(7 downto 0)  := X"15";
	constant ACT_2_READY_CNT   : std_logic_vector(3 downto 0)  := X"0";  -- FORBIDDEN
	constant PRE_2_READY_CNT   : std_logic_vector(3 downto 0)  := X"3";
	constant RD_2_READY_CNT    : std_logic_vector(3 downto 0)  := X"2";
	constant WR_2_READY_CNT    : std_logic_vector(3 downto 0)  := X"2";
	-- maximum time
	constant REFRESHMAX_CNT    : std_logic_vector(15 downto 0) := X"0601";
	constant ROWACTIVEMAX_CNT  : std_logic_vector(15 downto 0) := X"FFFF";

	-- command constant
	constant CMD_NOP           : std_logic_vector(2 downto 0) := "111";
	constant CMD_READ          : std_logic_vector(2 downto 0) := "101";
	constant CMD_WRITE         : std_logic_vector(2 downto 0) := "100";
	constant CMD_ACTIVE        : std_logic_vector(2 downto 0) := "011";
	constant CMD_PRECHARGE     : std_logic_vector(2 downto 0) := "010";
	constant CMD_REFRESH       : std_logic_vector(2 downto 0) := "001";
	constant CMD_MODESET       : std_logic_vector(2 downto 0) := "000";

	-- CSB constants
	constant CSB_BOTH          : std_logic_vector(1 downto 0) := "00";
	constant CSB_ZERO          : std_logic_vector(1 downto 0) := "10";
	constant CSB_ONE           : std_logic_vector(1 downto 0) := "01";
	constant CSB_NONE          : std_logic_vector(1 downto 0) := "11";

	-- ODT constants
	constant ODT_BOTH          : std_logic_vector(1 downto 0) := "11";
	constant ODT_ZERO          : std_logic_vector(1 downto 0) := "01";
	constant ODT_ONE           : std_logic_vector(1 downto 0) := "10";
	constant ODT_NONE          : std_logic_vector(1 downto 0) := "00";

	-- CKE constants
	constant CKE_DISABLED      : std_logic := '0';
	constant CKE_ENABLED       : std_logic := '1';

	-- address constants
	constant ADD_PADZEROS      : std_logic_vector((row_address_p-12) downto 0) := (others => '0');
	constant ADD_ALLBANKS      : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "10000000000";
	constant ADD_SINGLEBANK    : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "00000000000";
	constant ADD_AUTOPRE       : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "10000000000";
	constant ADD_NOAUTOPRE     : std_logic_vector((row_address_p-1) downto 0) := ADD_PADZEROS & "00000000000";

	-- bank address constants
	constant BA_MR             : std_logic_vector((bank_address_p-1) downto 0) := "00";
	constant BA_EMR1           : std_logic_vector((bank_address_p-1) downto 0) := "01";
	constant BA_EMR2           : std_logic_vector((bank_address_p-1) downto 0) := "10";
	constant BA_EMR3           : std_logic_vector((bank_address_p-1) downto 0) := "11";

	-- internal mode registers values
	constant REG_PADZEROS      : std_logic_vector((row_address_p-14) downto 0) := (others => '0');
	constant REG_MR            : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0010000110010";
	-- Fast-exit down mode-----------------------------------------------------------------------0
	-- Write Recovery = 3 ------------------------------------------------------------------------010
	-- PLL reset disabled ---------------------------------------------------------------------------0
	-- Test mode disabled ----------------------------------------------------------------------------0
	-- CAS latency = 3    -----------------------------------------------------------------------------011                                                                   
    -- sequential burst   --------------------------------------------------------------------------------0
	-- burstlength = 4    ---------------------------------------------------------------------------------010
	constant REG_MR_DLL_RESET  : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0010100110010";
	-- Fast-exit down mode-----------------------------------------------------------------------0
	-- Write Recovery = 3 ------------------------------------------------------------------------010
	-- PLL reset enabled  ---------------------------------------------------------------------------1
	-- Test mode disabled ----------------------------------------------------------------------------0
	-- CAS latency = 3    -----------------------------------------------------------------------------011                                                                   
    -- sequential burst   --------------------------------------------------------------------------------0
	-- burstlength = 4    ---------------------------------------------------------------------------------010
	constant REG_EMR1_OCD_DEF  : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0011110000100";
	-- output enabled     -----------------------------------------------------------------------0
	-- RDQS disabled      ------------------------------------------------------------------------0
	-- DQS# disabled      -------------------------------------------------------------------------1
	-- Default OCD state  --------------------------------------------------------------------------111
	-- Posted AL = 0      ------------------------------------------------------------------------------000
	-- RTT = 75 Ohm       -----------------------------------------------------------------------------0---1
    -- Full strength out  ----------------------------------------------------------------------------------0
	-- DLL enabled        -----------------------------------------------------------------------------------0
	constant REG_EMR1_OCD_EXIT : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0010000000100";
	-- output enabled     -----------------------------------------------------------------------0
	-- RDQS disabled      ------------------------------------------------------------------------0
	-- DQS# disabled      -------------------------------------------------------------------------1
	-- Default OCD state  --------------------------------------------------------------------------000
	-- Posted AL = 0      ------------------------------------------------------------------------------000
	-- RTT = 75 Ohm       -----------------------------------------------------------------------------0---1
    -- Full strength out  ----------------------------------------------------------------------------------0
	-- DLL enabled        -----------------------------------------------------------------------------------0
	constant REG_EMR2          : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0000000000000";
	-- reserved           -----------------------------------------------------------------------0000000000000
	constant REG_EMR3          : std_logic_vector((row_address_p-1) downto 0) := REG_PADZEROS & "0000000000000";
	-- reserved           -----------------------------------------------------------------------0000000000000

	-- command signal
	signal ddr_cmd             : std_logic_vector(2 downto 0) := "111";
	-- timing counters
	-- init
	signal powerup_counter     : std_logic_vector(15 downto 0) := X"0000";
	signal clklock_counter     : std_logic_vector(7 downto 0)  := CLKLOCK_CNT;
	signal trpa_counter        : std_logic_vector(3 downto 0)  := TRPA_CNT;
	signal tmrd_counter        : std_logic_vector(3 downto 0)  := TMRD_CNT;
	signal trfc_counter        : std_logic_vector(7 downto 0)  := TRFC_CNT;
	signal plllock_counter     : std_logic_vector(7 downto 0)  := PLLLOCK_CNT;
	-- command to command
	signal ref_2_ref_counter   : std_logic_vector(7 downto 0)  := REF_2_REF_CNT;
	signal ref_2_act_counter   : std_logic_vector(7 downto 0)  := REF_2_ACT_CNT;
	signal ref_2_pre_counter   : std_logic_vector(7 downto 0)  := REF_2_PRE_CNT;
	signal ref_2_rd_counter    : std_logic_vector(7 downto 0)  := REF_2_RD_CNT ;
	signal ref_2_wr_counter    : std_logic_vector(7 downto 0)  := REF_2_WR_CNT ;
	signal act_2_ref_counter   : std_logic_vector(3 downto 0)  := ACT_2_REF_CNT;
	signal act_2_act_counter   : std_logic_vector(3 downto 0)  := ACT_2_ACT_CNT;
	signal act_2_pre_counter   : std_logic_vector(3 downto 0)  := ACT_2_PRE_CNT;
	signal act_2_rd_counter    : std_logic_vector(3 downto 0)  := ACT_2_RD_CNT ;
	signal act_2_wr_counter    : std_logic_vector(3 downto 0)  := ACT_2_WR_CNT ;
	signal pre_2_ref_counter   : std_logic_vector(3 downto 0)  := PRE_2_REF_CNT;
	signal pre_2_act_counter   : std_logic_vector(3 downto 0)  := PRE_2_ACT_CNT;
	signal pre_2_pre_counter   : std_logic_vector(3 downto 0)  := PRE_2_PRE_CNT;
	signal pre_2_rd_counter    : std_logic_vector(3 downto 0)  := PRE_2_RD_CNT ;
	signal pre_2_wr_counter    : std_logic_vector(3 downto 0)  := PRE_2_WR_CNT ;
	signal rd_2_ref_counter    : std_logic_vector(3 downto 0)  := RD_2_REF_CNT ;
	signal rd_2_act_counter    : std_logic_vector(3 downto 0)  := RD_2_ACT_CNT ;
	signal rd_2_pre_counter    : std_logic_vector(3 downto 0)  := RD_2_PRE_CNT ;
	signal rd_2_rd_counter     : std_logic_vector(3 downto 0)  := RD_2_RD_CNT  ;
	signal rd_2_wr_counter     : std_logic_vector(3 downto 0)  := RD_2_WR_CNT  ;
	signal wr_2_ref_counter    : std_logic_vector(3 downto 0)  := WR_2_REF_CNT ;
	signal wr_2_act_counter    : std_logic_vector(3 downto 0)  := WR_2_ACT_CNT ;
	signal wr_2_pre_counter    : std_logic_vector(3 downto 0)  := WR_2_PRE_CNT ;
	signal wr_2_rd_counter     : std_logic_vector(3 downto 0)  := WR_2_RD_CNT  ;
	signal wr_2_wr_counter     : std_logic_vector(3 downto 0)  := WR_2_WR_CNT  ;
	-- command to ready
	signal ref_2_ready_counter : std_logic_vector(7 downto 0)  := REF_2_READY_CNT;
	signal act_2_ready_counter : std_logic_vector(3 downto 0)  := ACT_2_READY_CNT;
	signal pre_2_ready_counter : std_logic_vector(3 downto 0)  := PRE_2_READY_CNT;
	signal rd_2_ready_counter  : std_logic_vector(3 downto 0)  := RD_2_READY_CNT ;
	signal wr_2_ready_counter  : std_logic_vector(3 downto 0)  := WR_2_READY_CNT ;
	-- maximum time
	signal refreshmax_counter  : std_logic_vector(15 downto 0) := REFRESHMAX_CNT  ;
	signal rowactivemax_counter: std_logic_vector(15 downto 0) := ROWACTIVEMAX_CNT;
                                                                  
	-- timming counters reached signals                           
	-- init                                                       
	signal powerup_reached     : std_logic := '0';
	signal clklock_reached     : std_logic := '1';
	signal trpa_reached        : std_logic := '1';
	signal tmrd_reached        : std_logic := '1';
	signal trfc_reached        : std_logic := '1';
	signal plllock_reached     : std_logic := '1';
	-- command to command
	signal ref_2_ref_reached   : std_logic := '1';
	signal ref_2_act_reached   : std_logic := '1';
	signal ref_2_pre_reached   : std_logic := '1';
	signal ref_2_rd_reached    : std_logic := '1';
	signal ref_2_wr_reached    : std_logic := '1';
	signal act_2_ref_reached   : std_logic := '1';
	signal act_2_act_reached   : std_logic := '1';
	signal act_2_pre_reached   : std_logic := '1';
	signal act_2_rd_reached    : std_logic := '1';
	signal act_2_wr_reached    : std_logic := '1';
	signal pre_2_ref_reached   : std_logic := '1';
	signal pre_2_act_reached   : std_logic := '1';
	signal pre_2_pre_reached   : std_logic := '1';
	signal pre_2_rd_reached    : std_logic := '1';
	signal pre_2_wr_reached    : std_logic := '1';
	signal rd_2_ref_reached    : std_logic := '1';
	signal rd_2_act_reached    : std_logic := '1';
	signal rd_2_pre_reached    : std_logic := '1';
	signal rd_2_rd_reached     : std_logic := '1';
	signal rd_2_wr_reached     : std_logic := '1';
	signal wr_2_ref_reached    : std_logic := '1';
	signal wr_2_act_reached    : std_logic := '1';
	signal wr_2_pre_reached    : std_logic := '1';
	signal wr_2_rd_reached     : std_logic := '1';
	signal wr_2_wr_reached     : std_logic := '1';
	-- command to ready
	signal ref_2_ready_reached : std_logic := '1';
	signal act_2_ready_reached : std_logic := '1';
	signal pre_2_ready_reached : std_logic := '1';
	signal rd_2_ready_reached  : std_logic := '1';
	signal wr_2_ready_reached  : std_logic := '1';
	-- maximum time
	signal refreshmax_reached  : std_logic := '1';
	signal rowactivemax_reached: std_logic := '1';

	-- opened bank state
	signal bank_is_opened      : std_logic := '0';
	signal opened_row          : std_logic_vector((row_address_p-1) downto 0) := (others => '0');
	signal opened_bank         : std_logic_vector((bank_address_p-1) downto 0) := (others => '0');
	signal opened_rank         : std_logic := '0';

	-- initialisation done
	signal init_done           : std_logic := '0';
	signal init_done_delay     : std_logic := '0';
	
	-- address conflict
	signal address_conflict    : std_logic := '0';

	-- csb decoding
	signal user_csb            : std_logic_vector(1 downto 0);
	signal opened_csb          : std_logic_vector(1 downto 0);

	-- refresh internal command
	signal auto_refresh        : std_logic;
	signal do_auto_refresh     : std_logic := '0';

	-- rowclose internal command
	signal auto_rowclose       : std_logic;
	signal do_auto_rowclose    : std_logic := '0';

	-- registered and latched input signals
	signal reg_col_address     : std_logic_vector((column_address_p - 1) downto 0) := (others => '0');
	signal reg_row_address     : std_logic_vector((row_address_p - 1) downto 0) := (others => '0');
	signal reg_bank_address    : std_logic_vector((bank_address_p - 1) downto 0) := (others => '0');
	signal reg_rank_address    : std_logic := '0';
	signal reg_read            : std_logic := '0';
	signal reg_write           : std_logic := '0';
	signal reg_csb             : std_logic_vector(1 downto 0);
	signal latch_col_address   : std_logic_vector((column_address_p - 1) downto 0);
	signal latch_row_address   : std_logic_vector((row_address_p - 1) downto 0);
	signal latch_bank_address  : std_logic_vector((bank_address_p - 1) downto 0);
	signal latch_rank_address  : std_logic;
	signal latch_read          : std_logic;
	signal latch_write         : std_logic;
	signal latch_csb           : std_logic_vector(1 downto 0);

	-- data request from the user
	signal user_get_data_next  : std_logic := '0';

	-- internal version of output signals
	signal input_data_valid_int    : std_logic := '0';
	signal user_get_data_int       : std_logic := '0';
	signal user_ready_int          : std_logic := '0';
	signal dqs_reset_int           : std_logic := '0';
	signal dqs_enable_int          : std_logic := '0';
	signal write_enable_int        : std_logic := '0';
	signal ddr_rst_dqs_div_out_int : std_logic := '0';
	signal rst_calib_int           : std_logic := '0';
	signal ddr_csb_int             : std_logic_vector(1 downto 0) := CSB_NONE;
	signal ddr_odt_int             : std_logic_vector(1 downto 0) := ODT_NONE;
	attribute syn_noprune of ddr_csb_int: signal is true;
	signal ddr_ba_int              : std_logic_vector((bank_address_p - 1) downto 0) := (others => '0');
	signal ddr_address_int         : std_logic_vector((row_address_p - 1) downto 0) := (others => '0');
	signal ddr_cke_int             : std_logic := CKE_DISABLED;
	signal ddr_force_nop_int       : std_logic_vector(1 downto 0) := "00";
	attribute syn_noprune of ddr_force_nop_int : signal is true;

	-- init output signals
	signal ddr_csb_init            : std_logic_vector(1 downto 0) := CSB_NONE;
	signal ddr_cmd_init            : std_logic_vector(2 downto 0) := CMD_NOP;
	signal ddr_address_init        : std_logic_vector((row_address_p - 1) downto 0) := (others => '0');
	signal ddr_ba_init             : std_logic_vector((bank_address_p - 1) downto 0) := (others => '0');
	signal ddr_cke_init            : std_logic := CKE_DISABLED;

	-- enable receive path
	signal receive_enable          : std_logic := '0';
	signal receive_enable_delay1   : std_logic := '0';
	signal receive_enable_delay2   : std_logic := '0';
	signal receive_enable_next     : std_logic := '0';

	-- enable sending path
	signal write_enable_delay1     : std_logic := '0';
	signal write_enable_delay2     : std_logic := '0';

	-- abort command mode signal
	signal abort_read              : std_logic;
	signal abort_write             : std_logic;
	signal valid_read              : std_logic;
	signal valid_write             : std_logic;

	-- pipeline empty signal
	signal pipeline_not_empty      : std_logic := '0';
	
	-- tell what was the command executed on the previous cycle
	signal last_was_read           : std_logic := '0';
	signal last_was_write          : std_logic := '0';
	signal last_was_precharge      : std_logic := '0';
	signal last_was_active         : std_logic := '0';
	signal last_was_refresh        : std_logic := '0';

begin

-- #######  #####  ##   ##
--  #    # #     #  #   # 
--  #      #        ## ## 
--  #  #   #        ## ## 
--  ####    #####   # # # 
--  #  #         #  # # # 
--  #            #  #   # 
--  #      #     #  #   # 
-- ####     #####  ### ###

controller_fsm: process(clk)
begin
	if clk'event and clk = '1' then
		if reset = '1' then
            --                                   #    
            --                                   #    
            -- ### ##   #####   #####   #####   ####  
            --   ##  # #     # #     # #     #   #    
            --   #     #######  ###    #######   #    
            --   #     #           ##  #         #    
            --   #     #     # #     # #     #   #  # 
            -- #####    #####   #####   #####     ##  

			-- disable outputs and clock
			ddr_cmd                 <= CMD_NOP; 
			ddr_csb_int             <= CSB_NONE;  
			ddr_odt_int             <= ODT_NONE;
			ddr_ba_int              <= (others => '0');  
			ddr_address_int         <= (others => '0');  
			ddr_cke_int             <= CKE_DISABLED; 
			-- disable the data path
			input_data_valid_int    <= '0';
			dqs_enable_int          <= '0';
			dqs_reset_int           <= '0';
			write_enable_delay1     <= '0';
			write_enable_delay2     <= '0';
			write_enable_int        <= '0';
			receive_enable          <= '0';
			receive_enable_delay1   <= '0';
			receive_enable_delay2   <= '0';
			receive_enable_next     <= '0';
			ddr_rst_dqs_div_out_int <= '0';
			rst_calib_int           <= '0';
			-- user interface disabled
			user_ready_int          <= '0';
			user_ready              <= '0';
			user_get_data_int       <= '0';
			user_get_data_next      <= '0';
			-- initial state
			init_state              <= INIT_WAIT_POWER_UP;
			-- timing counters reset
			-- init
			powerup_counter     <=  X"0000"         ;
			trpa_counter        <=  TRPA_CNT        ;
			tmrd_counter        <=  TMRD_CNT        ;
			trfc_counter        <=  TRFC_CNT        ;
			plllock_counter     <=  PLLLOCK_CNT     ;
			clklock_counter     <=  CLKLOCK_CNT     ;
			-- command to command
			ref_2_ref_counter   <= 	REF_2_REF_CNT   ;
			ref_2_act_counter   <= 	REF_2_ACT_CNT   ;
			ref_2_pre_counter   <= 	REF_2_PRE_CNT   ;
			ref_2_rd_counter    <= 	REF_2_RD_CNT    ;
			ref_2_wr_counter    <= 	REF_2_WR_CNT    ;
			act_2_ref_counter   <= 	ACT_2_REF_CNT   ;
			act_2_act_counter   <= 	ACT_2_ACT_CNT   ;
			act_2_pre_counter   <= 	ACT_2_PRE_CNT   ;
			act_2_rd_counter    <= 	ACT_2_RD_CNT    ;
			act_2_wr_counter    <= 	ACT_2_WR_CNT    ;
			pre_2_ref_counter   <= 	PRE_2_REF_CNT   ;
			pre_2_act_counter   <= 	PRE_2_ACT_CNT   ;
			pre_2_pre_counter   <= 	PRE_2_PRE_CNT   ;
			pre_2_rd_counter    <= 	PRE_2_RD_CNT    ;
			pre_2_wr_counter    <= 	PRE_2_WR_CNT    ;
			rd_2_ref_counter    <= 	RD_2_REF_CNT    ;
			rd_2_act_counter    <= 	RD_2_ACT_CNT    ;
			rd_2_pre_counter    <= 	RD_2_PRE_CNT    ;
			rd_2_rd_counter     <= 	RD_2_RD_CNT     ;
			rd_2_wr_counter     <= 	RD_2_WR_CNT     ;
			wr_2_ref_counter    <= 	WR_2_REF_CNT    ;
			wr_2_act_counter    <= 	WR_2_ACT_CNT    ;
			wr_2_pre_counter    <= 	WR_2_PRE_CNT    ;
			wr_2_rd_counter     <= 	WR_2_RD_CNT     ;
			wr_2_wr_counter     <= 	WR_2_WR_CNT     ;
			-- command to ready
			ref_2_ready_counter <=  REF_2_READY_CNT ;
			act_2_ready_counter <=  ACT_2_READY_CNT ;
			pre_2_ready_counter <=  PRE_2_READY_CNT ;
			rd_2_ready_counter  <=  RD_2_READY_CNT  ;
			wr_2_ready_counter  <=  WR_2_READY_CNT  ;
			-- max time
			refreshmax_counter  <=  REFRESHMAX_CNT  ;
			rowactivemax_counter<=  ROWACTIVEMAX_CNT;
			-- timming counters reached signals                           
			-- init                                                       
			powerup_reached     <= '0';
			clklock_reached     <= '1';
			trpa_reached        <= '1';
			tmrd_reached        <= '1';
			trfc_reached        <= '1';
			plllock_reached     <= '1';
			-- command to command
			ref_2_ref_reached   <= '1';
			ref_2_act_reached   <= '1';
			ref_2_pre_reached   <= '1';
			ref_2_rd_reached    <= '1';
			ref_2_wr_reached    <= '1';
			act_2_ref_reached   <= '1';
			act_2_act_reached   <= '1';
			act_2_pre_reached   <= '1';
			act_2_rd_reached    <= '1';
			act_2_wr_reached    <= '1';
			pre_2_ref_reached   <= '1';
			pre_2_act_reached   <= '1';
			pre_2_pre_reached   <= '1';
			pre_2_rd_reached    <= '1';
			pre_2_wr_reached    <= '1';
			rd_2_ref_reached    <= '1';
			rd_2_act_reached    <= '1';
			rd_2_pre_reached    <= '1';
			rd_2_rd_reached     <= '1';
			rd_2_wr_reached     <= '1';
			wr_2_ref_reached    <= '1';
			wr_2_act_reached    <= '1';
			wr_2_pre_reached    <= '1';
			wr_2_rd_reached     <= '1';
			wr_2_wr_reached     <= '1';
			-- command to ready
			ref_2_ready_reached <= '1';
			act_2_ready_reached <= '1';
			pre_2_ready_reached <= '1';
			rd_2_ready_reached  <= '1';
			wr_2_ready_reached  <= '1';
			-- maximum time
			refreshmax_reached  <= '1';
			rowactivemax_reached<= '1';
			-- bank opened state
			bank_is_opened      <= '0';
			opened_row          <= (others => '0');
			opened_bank         <= (others => '0');
			opened_rank         <= '0';
			-- initialisation done
			init_done           <= '0';
			init_done_delay     <= '0';
			-- registered input signals
			reg_col_address     <= (others => '0');
			reg_row_address     <= (others => '0');
			reg_bank_address    <= (others => '0');
			reg_rank_address    <= '0';
			reg_read            <= '0';
			reg_write           <= '0';
			-- delayed refresh command
			do_auto_refresh     <= '0';
			-- delayed rowclose command
			do_auto_rowclose    <= '0';
			-- pipeline empty signal
			pipeline_not_empty  <= '0';
			-- address conflict detect
			address_conflict    <= '0';
			-- tell what was the command executed on the previous cycle
			last_was_read       <= '0';
			last_was_write      <= '0';
			last_was_precharge  <= '0';
			last_was_active     <= '0';
			last_was_refresh    <= '0';
			-- init command signals
			ddr_csb_init        <= CSB_NONE;
			ddr_cmd_init        <= CMD_NOP;
			ddr_address_init    <= (others => '0');
			ddr_ba_init         <= (others => '0');
			ddr_cke_init        <= CKE_DISABLED;
			-- abort signals
			ddr_force_nop_int   <= "00";
		else
			-- make sure the default value of chip selects is (none selected)
			ddr_csb_int  <= CSB_NONE;
			ddr_csb_init <= CSB_NONE;
			-- make sure the default value of the abort signals is low
			ddr_force_nop_int  <= "00";
			-- delay the init_done signal
			init_done_delay    <= init_done;
			-- make sure the default value of the last command indicators is 0
			last_was_read       <= '0';
			last_was_write      <= '0';
			last_was_precharge  <= '0';
			last_was_active     <= '0';
			last_was_refresh    <= '0';
			-- registered input signals
			if user_ready_int = '1' then
				reg_col_address     <= user_col_address ; 
				reg_row_address     <= user_row_address ; 
				reg_bank_address    <= user_bank_address; 
				reg_rank_address    <= user_rank_address; 
				reg_read            <= user_read        ; 
				reg_write           <= user_write       ; 
    		end if;

			--     ##                                                          ##     
			--      #            #                                       #      #     
			--      #            #                                       #      #     
			--  #####   ####    ####    ####           ######   ####    ####    # ##  
			-- #    #       #    #          #           #    #      #    #      ##  # 
			-- #    #   #####    #      #####           #    #  #####    #      #   # 
			-- #    #  #    #    #     #    #           #    # #    #    #      #   # 
			-- #    #  #    #    #  #  #    #           #    # #    #    #  #   #   # 
			--  ######  #### #    ##    #### #          #####   #### #    ##   ### ###
			--                                          #                             
			--                                         ###                            

			-- delaying of data request from the user
			user_get_data_next         <= '0';
			user_get_data_int          <= user_get_data_next;
			-- signaling a valid data to the data path
			input_data_valid_int       <= user_get_data_int;
			-- delaying of receive enable
			receive_enable_next        <= '0';
			receive_enable             <= receive_enable_next;
			receive_enable_delay1      <= receive_enable;
			receive_enable_delay2      <= receive_enable_delay1;
			-- dqs div output reset
			ddr_rst_dqs_div_out_int    <= receive_enable_delay2;
			-- calibration reset
			rst_calib_int              <= receive_enable_delay2;
			-- write enable signal
			write_enable_delay1        <= '0';
			write_enable_delay2        <= write_enable_delay1;
			write_enable_int           <= write_enable_delay2;
			-- bring dqs enable down at the end of a burst
			if write_enable_int = '0' then
				dqs_enable_int  <= '0';
			end if;
			-- make sure the default value of dqs reset is (not reset)
			dqs_reset_int <= '0';
			-- if we are not currently bursting, reset the dqs circuitry and take the bus
			if write_enable_delay2 = '1' and write_enable_int = '0' and abort_write = '0' then
				dqs_enable_int  <= '1';
				dqs_reset_int   <= '1';
			end if;

			--                            ##     ##       #                   
			--                           #        #                      #    
			--                           #        #                      #    
			--  #####   #####  ## ##    ####      #     ###     #####   ####  
			-- #     # #     #  ##  #    #        #       #    #     #   #    
			-- #       #     #  #   #    #        #       #    #         #    
			-- #       #     #  #   #    #        #       #    #         #    
			-- #     # #     #  #   #    #        #       #    #     #   #  # 
			--  #####   #####  ### ###  ####    #####   #####   #####     ##  

			-- address conflict detection
			if user_ready_int = '1' then
				if
					bank_is_opened = '1' and
					(user_row_address /= opened_row  or
					user_bank_address /= opened_bank or
					user_rank_address /= opened_rank)
				then
					-- if we asked for a transaction in the cycle in any case we want to cancel the next command
					ddr_force_nop_int <= "11";
					address_conflict  <= '1';
				else
					address_conflict  <= '0';
				end if;
			end if;


            --                                   #                            
            --                                   #                            
            --  #####   #####  ##  ##  ## ##    ####    #####  ### ##   ##### 
            -- #     # #     #  #   #   ##  #    #     #     #   ##  # #     #
            -- #       #     #  #   #   #   #    #     #######   #      ###   
            -- #       #     #  #   #   #   #    #     #         #         ## 
            -- #     # #     #  #  ##   #   #    #  #  #     #   #     #     #
            --  #####   #####    ## ## ### ###    ##    #####  #####    ##### 

			-- counters
			-- init
			if powerup_reached      = '0' then powerup_counter       <= powerup_counter      + 1; end if;
			if clklock_reached      = '0' then clklock_counter       <= clklock_counter      + 1; end if;
			if trpa_reached         = '0' then trpa_counter          <= trpa_counter         + 1; end if;
			if tmrd_reached         = '0' then tmrd_counter          <= tmrd_counter         + 1; end if;
			if trfc_reached         = '0' then trfc_counter          <= trfc_counter         + 1; end if;
			if plllock_reached      = '0' then plllock_counter       <= plllock_counter      + 1; end if;
			-- command to command
			if ref_2_ref_reached    = '0' then ref_2_ref_counter     <= ref_2_ref_counter    + 1; end if;
			if ref_2_act_reached    = '0' then ref_2_act_counter     <= ref_2_act_counter    + 1; end if;
			if ref_2_pre_reached    = '0' then ref_2_pre_counter     <= ref_2_pre_counter    + 1; end if;
			if ref_2_rd_reached     = '0' then ref_2_rd_counter      <= ref_2_rd_counter     + 1; end if;
			if ref_2_wr_reached     = '0' then ref_2_wr_counter      <= ref_2_wr_counter     + 1; end if;
			if act_2_ref_reached    = '0' then act_2_ref_counter     <= act_2_ref_counter    + 1; end if;
			if act_2_act_reached    = '0' then act_2_act_counter     <= act_2_act_counter    + 1; end if;
			if act_2_pre_reached    = '0' then act_2_pre_counter     <= act_2_pre_counter    + 1; end if;
			if act_2_rd_reached     = '0' then act_2_rd_counter      <= act_2_rd_counter     + 1; end if;
			if act_2_wr_reached     = '0' then act_2_wr_counter      <= act_2_wr_counter     + 1; end if;
			if pre_2_ref_reached    = '0' then pre_2_ref_counter     <= pre_2_ref_counter    + 1; end if;
			if pre_2_act_reached    = '0' then pre_2_act_counter     <= pre_2_act_counter    + 1; end if;
			if pre_2_pre_reached    = '0' then pre_2_pre_counter     <= pre_2_pre_counter    + 1; end if;
			if pre_2_rd_reached     = '0' then pre_2_rd_counter      <= pre_2_rd_counter     + 1; end if;
			if pre_2_wr_reached     = '0' then pre_2_wr_counter      <= pre_2_wr_counter     + 1; end if;
			if rd_2_ref_reached     = '0' then rd_2_ref_counter      <= rd_2_ref_counter     + 1; end if;
			if rd_2_act_reached     = '0' then rd_2_act_counter      <= rd_2_act_counter     + 1; end if;
			if rd_2_pre_reached     = '0' then rd_2_pre_counter      <= rd_2_pre_counter     + 1; end if;
			if rd_2_rd_reached      = '0' then rd_2_rd_counter       <= rd_2_rd_counter      + 1; end if;
			if rd_2_wr_reached      = '0' then rd_2_wr_counter       <= rd_2_wr_counter      + 1; end if;
			if wr_2_ref_reached     = '0' then wr_2_ref_counter      <= wr_2_ref_counter     + 1; end if;
			if wr_2_act_reached     = '0' then wr_2_act_counter      <= wr_2_act_counter     + 1; end if;
			if wr_2_pre_reached     = '0' then wr_2_pre_counter      <= wr_2_pre_counter     + 1; end if;
			if wr_2_rd_reached      = '0' then wr_2_rd_counter       <= wr_2_rd_counter      + 1; end if;
			if wr_2_wr_reached      = '0' then wr_2_wr_counter       <= wr_2_wr_counter      + 1; end if;
			-- command to ready
			if ref_2_ready_reached  = '0' then ref_2_ready_counter   <= ref_2_ready_counter  + 1; end if;
			if act_2_ready_reached  = '0' then act_2_ready_counter   <= act_2_ready_counter  + 1; end if;
			if pre_2_ready_reached  = '0' then pre_2_ready_counter   <= pre_2_ready_counter  + 1; end if;
			if rd_2_ready_reached   = '0' then rd_2_ready_counter    <= rd_2_ready_counter   + 1; end if;
			if wr_2_ready_reached   = '0' then wr_2_ready_counter    <= wr_2_ready_counter   + 1; end if;
			-- max time
			if refreshmax_reached   = '0' then refreshmax_counter    <= refreshmax_counter   + 1; end if;
			if rowactivemax_reached = '0' then rowactivemax_counter  <= rowactivemax_counter + 1; end if;

			-- counters overflow detect
			-- init        
			if powerup_counter      = POWERUP_CNT     - 2 then powerup_reached      <= '1'; end if;
			if clklock_counter      = CLKLOCK_CNT     - 2 then clklock_reached      <= '1'; end if;
			if trpa_counter         = TRPA_CNT        - 2 then trpa_reached         <= '1'; end if;
			if tmrd_counter         = TMRD_CNT        - 2 then tmrd_reached         <= '1'; end if;
			if trfc_counter         = TRFC_CNT        - 2 then trfc_reached         <= '1'; end if;
			if plllock_counter      = PLLLOCK_CNT     - 2 then plllock_reached      <= '1'; end if;
			-- command to command
			if ref_2_ref_counter    = REF_2_REF_CNT   - 2 then ref_2_ref_reached    <= '1'; end if;
			if ref_2_act_counter    = REF_2_ACT_CNT   - 2 then ref_2_act_reached    <= '1'; end if;
			if ref_2_pre_counter    = REF_2_PRE_CNT   - 2 then ref_2_pre_reached    <= '1'; end if;
			if ref_2_rd_counter     = REF_2_RD_CNT    - 2 then ref_2_rd_reached     <= '1'; end if;
			if ref_2_wr_counter     = REF_2_WR_CNT    - 2 then ref_2_wr_reached     <= '1'; end if;
			if act_2_ref_counter    = ACT_2_REF_CNT   - 2 then act_2_ref_reached    <= '1'; end if;
			if act_2_act_counter    = ACT_2_ACT_CNT   - 2 then act_2_act_reached    <= '1'; end if;
			if act_2_pre_counter    = ACT_2_PRE_CNT   - 2 then act_2_pre_reached    <= '1'; end if;
			if act_2_rd_counter     = ACT_2_RD_CNT    - 2 then act_2_rd_reached     <= '1'; end if;
			if act_2_wr_counter     = ACT_2_WR_CNT    - 2 then act_2_wr_reached     <= '1'; end if;
			if pre_2_ref_counter    = PRE_2_REF_CNT   - 2 then pre_2_ref_reached    <= '1'; end if;
			if pre_2_act_counter    = PRE_2_ACT_CNT   - 2 then pre_2_act_reached    <= '1'; end if;
			if pre_2_pre_counter    = PRE_2_PRE_CNT   - 2 then pre_2_pre_reached    <= '1'; end if;
			if pre_2_rd_counter     = PRE_2_RD_CNT    - 2 then pre_2_rd_reached     <= '1'; end if;
			if pre_2_wr_counter     = PRE_2_WR_CNT    - 2 then pre_2_wr_reached     <= '1'; end if;
			if rd_2_ref_counter     = RD_2_REF_CNT    - 2 then rd_2_ref_reached     <= '1'; end if;
			if rd_2_act_counter     = RD_2_ACT_CNT    - 2 then rd_2_act_reached     <= '1'; end if;
			if rd_2_pre_counter     = RD_2_PRE_CNT    - 2 then rd_2_pre_reached     <= '1'; end if;
			if rd_2_rd_counter      = RD_2_RD_CNT     - 2 then rd_2_rd_reached      <= '1'; end if;
			if rd_2_wr_counter      = RD_2_WR_CNT     - 2 then rd_2_wr_reached      <= '1'; end if;
			if wr_2_ref_counter     = WR_2_REF_CNT    - 2 then wr_2_ref_reached     <= '1'; end if;
			if wr_2_act_counter     = WR_2_ACT_CNT    - 2 then wr_2_act_reached     <= '1'; end if;
			if wr_2_pre_counter     = WR_2_PRE_CNT    - 2 then wr_2_pre_reached     <= '1'; end if;
			if wr_2_rd_counter      = WR_2_RD_CNT     - 2 then wr_2_rd_reached      <= '1'; end if;
			if wr_2_wr_counter      = WR_2_WR_CNT     - 2 then wr_2_wr_reached      <= '1'; end if;
			-- command to ready
			if ref_2_ready_counter  = REF_2_READY_CNT - 2 then ref_2_ready_reached  <= '1'; end if;
			if act_2_ready_counter  = ACT_2_READY_CNT - 2 then act_2_ready_reached  <= '1'; end if;
			if pre_2_ready_counter  = PRE_2_READY_CNT - 2 then pre_2_ready_reached  <= '1'; end if;
			if rd_2_ready_counter   = RD_2_READY_CNT  - 2 then rd_2_ready_reached   <= '1'; end if;
			if wr_2_ready_counter   = WR_2_READY_CNT  - 2 then wr_2_ready_reached   <= '1'; end if;
			-- maximum time
			if refreshmax_counter   = REFRESHMAX_CNT  - 2 then refreshmax_reached   <= '1'; end if;
			if rowactivemax_counter = ROWACTIVEMAX_CNT- 2 then rowactivemax_reached <= '1'; end if;

			--    #               #           
			--                           #    
			--                           #    
			--  ###    ## ##    ###     ####  
			--    #     ##  #     #      #    
			--    #     #   #     #      #    
			--    #     #   #     #      #    
			--    #     #   #     #      #  # 
			--  #####  ### ###  #####     ##  

			case init_state is
				-- wait for full power up of the DIMM
				when INIT_WAIT_POWER_UP => 
					-- wait for DDR power-up
					if powerup_reached = '1' then
						-- send a first NOP to the two ranks
						ddr_cmd_init     <= CMD_NOP;
						ddr_csb_init     <= CSB_BOTH;
						-- activate the clock
						ddr_cke_init      <= CKE_ENABLED;
						-- start the clklock counter
						clklock_counter   <= X"00";
						clklock_reached   <= '0';				
						-- go to the next state
						init_state       <= INIT_WAIT_01_COMMAND;
					end if;
				-- first precharge
				when INIT_WAIT_01_COMMAND =>
					-- wait 400ns for the first clock lock
					if clklock_reached = '1' then
						-- send a precharge all command
						ddr_cmd_init     <= CMD_PRECHARGE;
						ddr_address_init <= ADD_ALLBANKS;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RPA) counter
						trpa_counter     <= X"0";
						trpa_reached     <= '0';				
						-- go to the next state
						init_state       <= INIT_WAIT_02_COMMAND;
					end if;
				-- load EMR2
				when INIT_WAIT_02_COMMAND =>
					-- wait until last precharge all finished
					if trpa_reached = '1' then
						-- Load EMR2
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR2;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR2;
						-- start the t(MRD) counter
						tmrd_counter     <= X"0";	
						tmrd_reached     <= '0';			
						-- go to the next state
						init_state       <= INIT_WAIT_03_COMMAND;
					end if;
				-- load EMR3
				when INIT_WAIT_03_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR3
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR3;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR3;
						-- start the t(MRD) counter
						tmrd_counter     <= X"0";
						tmrd_reached     <= '0';
						-- go to the next state
						init_state       <= INIT_WAIT_04_COMMAND;
					end if;
				-- load EMR	to enable DLL			
				when INIT_WAIT_04_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD exit
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR1_OCD_EXIT;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR1;
						-- start the t(MRD) counter
						tmrd_counter     <= X"0";
						tmrd_reached     <= '0';			
						-- go to the next state
						init_state       <= INIT_WAIT_05_COMMAND;
					end if;
				-- load MR with DLL reset
				when INIT_WAIT_05_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load MR with DLL reset
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_MR_DLL_RESET;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_MR;
						-- start the t(MRD) and the plllock counter
						tmrd_counter     <= X"0";				
						tmrd_reached     <= '0';			
						plllock_counter  <= X"00";				
						plllock_reached  <= '0';			
						-- go to the next state
						init_state       <= INIT_WAIT_06_COMMAND;
					end if;
				-- second precharge				
				when INIT_WAIT_06_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- send a precharge all command
						ddr_cmd_init     <= CMD_PRECHARGE;
						ddr_address_init <= ADD_ALLBANKS;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RPA) counter
						trpa_counter     <= X"0";
						trpa_reached     <= '0';							
						-- go to the next state
						init_state       <= INIT_WAIT_07_COMMAND;
					end if;
				-- first refresh
				when INIT_WAIT_07_COMMAND =>
					-- wait until last precharge all finished
					if trpa_reached = '1' then
						-- issue a refresh
						ddr_cmd_init     <= CMD_REFRESH;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RFC) counter
						trfc_counter     <= X"00";
						trfc_reached     <= '0';			
						-- go to the next state
						init_state       <= INIT_WAIT_08_COMMAND;
					end if;
				-- second refresh
				when INIT_WAIT_08_COMMAND =>
					-- wait until last refresh finished
					if trfc_reached = '1' then
						-- issue a refresh
						ddr_cmd_init     <= CMD_REFRESH;
						ddr_csb_init     <= CSB_BOTH;
						-- start the t(RFC) counter
						trfc_counter     <= X"00";
						trfc_reached     <= '0';			
						-- go to the next state
						init_state       <= INIT_WAIT_09_COMMAND;
					end if;
				-- load MR without DLL reset
				when INIT_WAIT_09_COMMAND =>
					-- wait until last refresh finished
					if trfc_reached = '1' then
						-- Load MR without DLL reset
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_MR;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_MR;
						-- start the t(MRD) counter
						tmrd_counter     <= X"0";
						tmrd_reached     <= '0';							
						-- go to the next state
						init_state       <= INIT_WAIT_10_COMMAND;
					end if;
				-- load EMR1 with OCD default
				when INIT_WAIT_10_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD default
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR1_OCD_DEF;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR1;
						-- start the t(MRD) counter
						tmrd_counter     <= X"0";
						tmrd_reached     <= '0';							
						-- go to the next state
						init_state       <= INIT_WAIT_11_COMMAND;
					end if;
				-- load EMR1 with OCD exit
				when INIT_WAIT_11_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD exit
						ddr_cmd_init     <= CMD_MODESET;
						ddr_address_init <= REG_EMR1_OCD_EXIT;
						ddr_csb_init     <= CSB_BOTH;
						ddr_ba_init      <= BA_EMR1;
						-- start the t(MRD) counter
						tmrd_counter     <= X"0";
						tmrd_reached     <= '0';							
						-- go to the next state
						init_state       <= INIT_WAIT_12_COMMAND;
					end if;
				-- issue a NOP
				when INIT_WAIT_12_COMMAND =>
					-- wait until last modeset finished
					if tmrd_reached = '1' then
						-- Load EMR1 with OCD exit
						ddr_cmd_init     <= CMD_NOP;
						ddr_csb_init     <= CSB_BOTH;
						-- go to the next state
						init_state       <= INIT_WAIT_COMPLETION;
					end if;
				-- wait until the PLL is locked to start normal operation
				when INIT_WAIT_COMPLETION =>
					-- wait until the pll locked
					if plllock_reached = '1' then
						-- go to idle state and launches a first auto refresh
						init_state       <= INIT_COMPLETE;
						init_done        <= '1';
						do_auto_refresh  <= '1';
						-- enable ODT
						ddr_odt_int      <= ODT_BOTH;
					end if;

				when INIT_COMPLETE =>

				when others =>
			end case;

			if init_done_delay = '1' then
	
	
				--                             ## 
				--                              # 
				--                              # 
				-- ### ##   #####   ####    ##### 
				--   ##  # #     #      #  #    # 
				--   #     #######  #####  #    # 
				--   #     #       #    #  #    # 
				--   #     #     # #    #  #    # 
				-- #####    #####   #### #  ######
	
				-- we issue a read command in the following cases:
				--   * a READ request is issued and a bank is opened and there is no write request on the same cycle
	
				if 
					-- timming check
					(
						-- ref_2_rd_reached = '1' -- FORBIDDEN
						act_2_rd_reached = '1' and
						-- pre_2_rd_reached = '1' -- FORBIDDEN
						-- we cannot trust the counters if the last command was a read or a write (they could be aborted), so in this case we do nothing
						(rd_2_rd_reached  = '1' and last_was_read  = '0') and
						(wr_2_rd_reached  = '1' and last_was_write = '0')
					) and
					-- issue condition
					(
						latch_read       = '1' and
						bank_is_opened   = '1' and
						(address_conflict = '0' or user_ready_int = '1') and
						latch_write      = '0'
					)
				then
					-- send a read command
					ddr_cmd          <= CMD_READ;
					ddr_address_int  <= ADD_PADZEROS & '0' & latch_col_address;
					ddr_ba_int       <= latch_bank_address;
					ddr_csb_int      <= latch_csb;
					-- enable receive circuitry during two cycles
					receive_enable      <= '1';
					receive_enable_next <= '1';
					-- signal the read
					last_was_read       <= '1';
				end if;
                    
				-- Read abort logic
				-- we abort the previous read in the following cases:
				--   * A read was issued on the previous cycle and there is an address conflict

				if abort_read = '1' then
					-- disable the receive circuitry during two cycles
					receive_enable        <= '0';
					receive_enable_delay1 <= '0';
					receive_enable_next   <= '0';
				end if;

				if valid_read = '1' then
					-- start the timming counters now that we know that the read was valid
					rd_2_ref_counter    <= X"1";
					rd_2_act_counter    <= X"1";
					rd_2_pre_counter    <= X"1";
					rd_2_rd_counter     <= X"1";
					rd_2_wr_counter     <= X"1";
					rd_2_ready_counter  <= X"1";
					if RD_2_REF_CNT   = 2 then rd_2_ref_reached   <= '1'; else rd_2_ref_reached   <= '0'; end if;
					if RD_2_ACT_CNT   = 2 then rd_2_act_reached   <= '1'; else rd_2_act_reached   <= '0'; end if;
					if RD_2_PRE_CNT   = 2 then rd_2_pre_reached   <= '1'; else rd_2_pre_reached   <= '0'; end if;
					if RD_2_RD_CNT    = 2 then rd_2_rd_reached    <= '1'; else rd_2_rd_reached    <= '0'; end if;
					if RD_2_WR_CNT    = 2 then rd_2_wr_reached    <= '1'; else rd_2_wr_reached    <= '0'; end if;
					if RD_2_READY_CNT = 2 then rd_2_ready_reached <= '1'; else rd_2_ready_reached <= '0'; end if;
				end if;

				--                    #                   
				--                           #            
				--                           #            
				-- ### ### ### ##   ###     ####    ##### 
				--  #   #    ##  #    #      #     #     #
				--  # # #    #        #      #     #######
				--  # # #    #        #      #     #      
				--   # #     #        #      #  #  #     #
				--   # #   #####    #####     ##    ##### 
	
				-- we issue a write command in the following cases:
				--   * a WRITE request is issued and a bank is opened and there is no write request on the same cycle
	
				if 
					-- timming check
					(
						-- ref_2_wr_reached = '1' -- FORBIDDEN
						act_2_wr_reached = '1' and
						-- pre_2_wr_reached = '1 -- FORBIDDEN
						-- we cannot trust the counters if the last command was a read or a write (they could be aborted), so in this case we do nothing
						(rd_2_wr_reached  = '1' and last_was_read  = '0') and
						(wr_2_wr_reached  = '1' and last_was_write = '0')
					) and
					-- issue condition
					(
						latch_write      = '1' and
						bank_is_opened   = '1' and
						(address_conflict = '0' or user_ready_int = '1') and
						latch_read       = '0'
					)
				then
					-- send a write command
					ddr_cmd          <= CMD_WRITE;
					ddr_address_int  <= ADD_PADZEROS & '0' & latch_col_address;
					ddr_ba_int       <= latch_bank_address;
					ddr_csb_int      <= latch_csb;
					-- request data on two cycles if the pipeline is empty, on only one cycle otherwise
					if pipeline_not_empty = '1' then
						user_get_data_int      <= '0';
						user_get_data_next     <= '1';
						pipeline_not_empty     <= '0';
					else
						user_get_data_int      <= '1';
						user_get_data_next     <= '1';
					end if;
					-- enable data write on two cycles
					write_enable_delay1    <= '1';
					write_enable_delay2    <= '1';
					-- signal the write
					last_was_write         <= '1';
				end if;

				-- Write abort logic
				-- we abort the previous write in the following cases:
				--   * A write was issued on the previous cycle and there is an address conflict

				if abort_write = '1' then
					-- disable the write pipeline
					user_get_data_int     <= '0';
					-- data write
					write_enable_delay2   <= '0';
					write_enable_int      <= '0';
					-- signal that we have one word waiting in the pipeline
					pipeline_not_empty    <= '1';
				end if;

				if valid_write = '1' then
					-- start the timming counters now that we know that the write was valid
					wr_2_ref_counter    <= X"1";
					wr_2_act_counter    <= X"1";
					wr_2_pre_counter    <= X"1";
					wr_2_rd_counter     <= X"1";
					wr_2_wr_counter     <= X"1";
					wr_2_ready_counter  <= X"1";
					if WR_2_REF_CNT   = 2 then wr_2_ref_reached   <= '1'; else wr_2_ref_reached   <= '0'; end if;
					if WR_2_ACT_CNT   = 2 then wr_2_act_reached   <= '1'; else wr_2_act_reached   <= '0'; end if;
					if WR_2_PRE_CNT   = 2 then wr_2_pre_reached   <= '1'; else wr_2_pre_reached   <= '0'; end if;
					if WR_2_RD_CNT    = 2 then wr_2_rd_reached    <= '1'; else wr_2_rd_reached    <= '0'; end if;
					if WR_2_WR_CNT    = 2 then wr_2_wr_reached    <= '1'; else wr_2_wr_reached    <= '0'; end if;
					if WR_2_READY_CNT = 2 then wr_2_ready_reached <= '1'; else wr_2_ready_reached <= '0'; end if;
				end if;

				--                                 ##                                     
				--                                  #                                     
				--                                  #                                     
				-- ######  ### ##   #####   #####   # ##    ####   ### ##   ######  ##### 
				--  #    #   ##  # #     # #     #  ##  #       #    ##  # #    #  #     #
				--  #    #   #     ####### #        #   #   #####    #     #    #  #######
				--  #    #   #     #       #        #   #  #    #    #     #    #  #      
				--  #    #   #     #     # #     #  #   #  #    #    #      #####  #     #
				--  #####  #####    #####   #####  ### ###  #### # #####        #   ##### 
				--  #                                                           #         
				-- ###                                                      ####          
	    
				-- we need to precharge in the following cases:
				--   * a READ  request is issued whith an address conflict on an opened bank
				--   * a WRITE request is issued whith an address conflict or an opened bank
				--   * a refresh has to be issued but a bank is opened
				--   * a row has been opened for too long and needs to be closed	

				if 
					-- timming check
					(
						-- ref_2_pre_reached = '1' -- FORBIDDEN
						act_2_pre_reached = '1' and
						-- pre_2_pre_reached = '1' -- FORBIDDEN
						-- we cannot trust the counters if the last command was a read or a write (they could be aborted), so in this case we do nothing
						(rd_2_pre_reached  = '1' and last_was_read  = '0') and
						(wr_2_pre_reached  = '1' and last_was_write = '0')
					) and
					-- issue condition
					bank_is_opened = '1' and
					(
						(latch_read  = '1' and address_conflict = '1' and user_ready_int = '0') or
						(latch_write = '1' and address_conflict = '1' and user_ready_int = '0') or
						(do_auto_refresh = '1') or
						(do_auto_rowclose = '1')
					)
				then
					-- send a precharge command
					ddr_cmd          <= CMD_PRECHARGE;
					ddr_address_int  <= ADD_SINGLEBANK;
					ddr_ba_int       <= opened_bank;
					ddr_csb_int      <= opened_csb;
					-- start the timming counters
					pre_2_ref_counter    <= X"0";
					pre_2_act_counter    <= X"0";
					pre_2_pre_counter    <= X"0";
					pre_2_rd_counter     <= X"0";
					pre_2_wr_counter     <= X"0";
					pre_2_ready_counter  <= X"0";
					pre_2_ref_reached    <= '0';
					pre_2_act_reached    <= '0';
					pre_2_pre_reached    <= '0';
					pre_2_rd_reached     <= '0';
					pre_2_wr_reached     <= '0';
					pre_2_ready_reached  <= '0';
					-- signal that the bank is closed
					bank_is_opened       <= '0';	
					-- signal the precharge
					last_was_precharge   <= '1';
				end if;
	                                                
				--                            #                   
				--                   #                            
				--                   #                            
				--  ####    #####   ####    ###    ### ###  ##### 
				--      #  #     #   #        #     #   #  #     #
				--  #####  #         #        #     #   #  #######
				-- #    #  #         #        #      # #   #      
				-- #    #  #     #   #  #     #      # #   #     #
				--  #### #  #####     ##    #####     #     ##### 
	
				-- we need to activate in the following cases:
				--   * a READ  request is issued on a closed bank
				--   * a WRITE request is issued on a closed bank
	
				if 
					-- timming check
					(
						ref_2_act_reached = '1' and
						-- act_2_act_reached = '1' and -- FORBIDDEN
						pre_2_act_reached = '1'
						-- rd_2_act_reached  = '1' -- FORBIDDEN
						-- wr_2_act_reached  = '1' -- FORBIDDEN
					) and
					-- issue condition
					bank_is_opened = '0' and
					(
						(latch_read  = '1') or
						(latch_write = '1')
					)
				then
					-- send an activate command
					ddr_cmd          <= CMD_ACTIVE;
					ddr_address_int  <= latch_row_address;
					ddr_ba_int       <= latch_bank_address;
					ddr_csb_int      <= latch_csb;
					-- start the timming counters
					act_2_ref_counter    <= X"0";
					act_2_act_counter    <= X"0";
					act_2_pre_counter    <= X"0";
					act_2_rd_counter     <= X"0";
					act_2_wr_counter     <= X"0";
					act_2_ready_counter  <= X"0";
					rowactivemax_counter <= X"0000";
					act_2_ref_reached    <= '0';
					act_2_act_reached    <= '0';
					act_2_pre_reached    <= '0';
					act_2_rd_reached     <= '0';
					act_2_wr_reached     <= '0';
					act_2_ready_reached  <= '0';
					rowactivemax_reached <= '0';
					-- signal that the bank is opened
					bank_is_opened <= '1';
					-- latches the addresses for the opened bank
					opened_row   <= latch_row_address;
					opened_bank  <= latch_bank_address;
					opened_rank  <= latch_rank_address;
					-- signal that the address conflict has been solved
					address_conflict <= '0';
					-- signal the active
					last_was_active  <= '1';
				end if;
	
	
				--                    ##                           ##     
				--                   #                              #     
				--                   #                              #     
				-- ### ##   #####   ####   ### ##   #####   #####   # ##  
				--   ##  # #     #   #       ##  # #     # #     #  ##  # 
				--   #     #######   #       #     #######  ###     #   # 
				--   #     #         #       #     #           ##   #   # 
				--   #     #     #   #       #     #     # #     #  #   # 
				-- #####    #####   ####   #####    #####   #####  ### ###
	
				-- we need to refresh in the following cases:
				--   * the refresh controller is requesting a refresh, the bank is opened and there is no read or write going on
	
				if
					-- timming check
					(
						ref_2_ref_reached = '1' and
						-- act_2_ref_reached = '1' -- FORBIDDEN
						pre_2_ref_reached = '1'
						-- rd_2_ref_reached  = '1' -- FORBIDDEN
						-- wr_2_ref_reached  = '1' -- FORBIDDEN
					) and
					-- issue condition
					(
						(do_auto_refresh = '1' and bank_is_opened = '0')
					)
				then
					ddr_cmd     <= CMD_REFRESH;
					ddr_csb_int <= CSB_BOTH;
					-- start the timming counters
					ref_2_ref_counter    <= X"00";
					ref_2_act_counter    <= X"00";
					ref_2_pre_counter    <= X"00";
					ref_2_rd_counter     <= X"00";
					ref_2_wr_counter     <= X"00";
					ref_2_ready_counter  <= X"00";
					refreshmax_counter   <= X"0000";
					ref_2_ref_reached    <= '0';
					ref_2_act_reached    <= '0';
					ref_2_pre_reached    <= '0';
					ref_2_rd_reached     <= '0';
					ref_2_wr_reached     <= '0';
					ref_2_ready_reached  <= '0';
					refreshmax_reached   <= '0';
					-- signal the refresh
					last_was_refresh     <= '1';
				end if;
			end if;	


			--                             ##         
			--                              #         
			--                              #         
			-- ### ##   #####   ####    #####  ### ###
			--   ##  # #     #      #  #    #   #   # 
			--   #     #######  #####  #    #   #   # 
			--   #     #       #    #  #    #    # #  
			--   #     #     # #    #  #    #    # #  
			-- #####    #####   #### #  ######    #   
			--                                    #   
			--                                  ##    

			-- take the ready bit down if we got a command to execute
			if (
					(user_ready_int = '1' and
					( user_write = '1' or user_read = '1'))
				)
			then
				-- disable the ready bit
				user_ready_int <= '0';
				user_ready     <= '0';
			end if;
			-- when a transaction is over or when we are idle, evaluate what to do next
			if	(
					-- a refresh is about to complete
					(ref_2_ready_counter = (REF_2_READY_CNT - 2) and do_auto_refresh = '1') or
					-- a read is about to complete
					(valid_read = '1' and latch_read = '1') or
					-- a write is about to complete
					(valid_write = '1' and latch_write = '1') or
					-- an automatic row close is about to complete
					(pre_2_ready_counter = (PRE_2_READY_CNT - 2) and do_auto_rowclose = '1') or
					-- no command was sent previsously
					(user_ready_int = '1' and latch_read = '0' and latch_write = '0')
				)
			then
				-- deassert the command signals
				do_auto_refresh  <= '0';
				do_auto_rowclose <= '0';
				reg_read         <= '0';
				reg_write        <= '0';
				-- by default we request a new command
				user_ready_int   <= '1';
				user_ready       <= '1';
				-- if a refresh is needed, we execute it and we don't assert ready
				if auto_refresh = '1' then
					do_auto_refresh <= '1';
					user_ready_int  <= '0';
					user_ready      <= '0';
				end if;
				-- if a row close is needed and there is no refresh to do, we execute it and we don't assert ready
				if auto_rowclose = '1' and auto_refresh = '0' then
					do_auto_rowclose <= '1';
					user_ready_int   <= '0';
					user_ready       <= '0';
				end if;
			end if;

			-- if we are in init then use the init commands
			if init_done = '0' then
				ddr_csb_int       <= ddr_csb_init;
				ddr_cmd           <= ddr_cmd_init;
				ddr_address_int   <= ddr_address_init;
				ddr_ba_int        <= ddr_ba_init;
				ddr_cke_int       <= ddr_cke_init;
			end if;

		end if;
	end if;
end process controller_fsm;

-- abort signals
abort_read           <= '1' when address_conflict = '1' and last_was_read  = '1' else '0';
abort_write          <= '1' when address_conflict = '1' and last_was_write = '1' else '0';
valid_read           <= '1' when address_conflict = '0' and last_was_read  = '1' else '0';
valid_write          <= '1' when address_conflict = '0' and last_was_write = '1' else '0';

-- refresh command
auto_refresh    <= refreshmax_reached;

-- automatic row closing command
auto_rowclose   <= rowactivemax_reached and bank_is_opened;

-- command signals assignments
ddr_rasb        <= ddr_cmd(2);
ddr_casb        <= ddr_cmd(1);
ddr_web         <= ddr_cmd(0);
ddr_csb         <= ddr_csb_int;
ddr_ODT         <= ddr_odt_int;
ddr_ba          <= ddr_ba_int     ;
ddr_address     <= ddr_address_int;
ddr_cke         <= ddr_cke_int    ;
ddr_force_nop   <= ddr_force_nop_int;

-- decoded csbs
user_csb     <= CSB_ZERO when user_rank_address  = '0'  else CSB_ONE;
latch_csb    <= CSB_ZERO when latch_rank_address = '0'  else CSB_ONE;
opened_csb   <= CSB_ZERO when opened_rank        = '0'  else CSB_ONE;
reg_csb      <= CSB_ZERO when reg_rank_address   = '0'  else CSB_ONE;

-- latched input signals
latch_col_address     <= user_col_address  when user_ready_int = '1' else reg_col_address ; 
latch_row_address     <= user_row_address  when user_ready_int = '1' else reg_row_address ; 
latch_bank_address    <= user_bank_address when user_ready_int = '1' else reg_bank_address; 
latch_rank_address    <= user_rank_address when user_ready_int = '1' else reg_rank_address; 
latch_read            <= user_read         when user_ready_int = '1' else reg_read        ; 
latch_write           <= user_write        when user_ready_int = '1' else reg_write       ; 
latch_csb             <= user_csb          when user_ready_int = '1' else reg_csb         ;

-- internal version of output signals
user_get_data       <= user_get_data_int;
dqs_reset           <= dqs_reset_int;
write_enable        <= write_enable_int;
dqs_enable          <= dqs_enable_int;
ddr_rst_dqs_div_out <= ddr_rst_dqs_div_out_int;
rst_calib           <= rst_calib_int;
input_data_valid    <= input_data_valid_int;
-- user_ready is coassigned with user_ready_int directly in the code
--    to avoid delta delay simulation problems and make routing easier
-- user_ready          <= user_ready_int;

end arc_controller;                

