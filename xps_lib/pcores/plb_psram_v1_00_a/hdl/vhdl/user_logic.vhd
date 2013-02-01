------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.all;


------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------

entity user_logic is
	generic
	(
		C_DWIDTH                       : integer              := 64;
		C_AWIDTH                       : integer              := 32;
		C_NUM_CE                       : integer              := 1
	);
	port
	(
		pads_address                   : out std_logic_vector(22 downto 0);
		pads_clk                       : out std_logic;
		pads_adv_b                     : out std_logic;
		pads_cre                       : out std_logic;
		pads_ce_b                      : out std_logic;
		pads_oe_b                      : out std_logic;
		pads_we_b                      : out std_logic;
		pads_lb_b                      : out std_logic;
		pads_ub_b                      : out std_logic;
		pads_dq_T                      : out std_logic_vector(15 downto 0);
		pads_dq_I                      : in  std_logic_vector(15 downto 0);
		pads_dq_O                      : out std_logic_vector(15 downto 0);
		pads_wait                      : in  std_logic;

		Bus2IP_Clk                     : in  std_logic;
		Bus2IP_Reset                   : in  std_logic;
		Bus2IP_Data                    : in  std_logic_vector(0 to C_DWIDTH-1);
		Bus2IP_BE                      : in  std_logic_vector(0 to C_DWIDTH/8-1);
		Bus2IP_Burst                   : in  std_logic;
		Bus2IP_CS                      : in  std_logic_vector(0 downto 0);
		Bus2IP_RdReq                   : in  std_logic;
		Bus2IP_WrReq                   : in  std_logic;
		Bus2IP_Addr                    : in  std_logic_vector(0 to C_AWIDTH-1);
		IP2Bus_Data                    : out std_logic_vector(0 to C_DWIDTH-1);
		IP2Bus_Retry                   : out std_logic;
		IP2Bus_Error                   : out std_logic;
		IP2Bus_ToutSup                 : out std_logic;
		IP2Bus_AddrAck                 : out std_logic;
		IP2Bus_Busy                    : out std_logic;
		IP2Bus_RdAck                   : out std_logic;
		IP2Bus_WrAck                   : out std_logic
	);
end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is
	------------------------------------------
	-- constants
	------------------------------------------
	constant BCR      : std_logic_vector(22 downto 0) :=
		"000"        & -- reserved
		"10"         & -- BCR select
		"00"         & -- reserved
		"0"          & -- synchronous burst mode
		"0"          & -- variable latency
		"010"        & -- latency counter = 3 clocks
		"1"          & -- Wait is active high
		"0"          & -- reserved
		"0"          & -- wait asserted during delay
		"00"         & -- reserved
		"01"         & -- drive strength 1/2
		"1"          & -- no burst wrap
		"001"        ; -- burst of 4
		
	constant RCR      : std_logic_vector(22 downto 0) :=
		"000"        & -- reserved
		"00"         & -- RCR select
		"0000000000" & -- reserved
		"0"          & -- page mode disabled
		"00"         & -- reserved
		"1"          & -- no deep power down
		"0"          & -- reserved
		"000"        ; -- refresh full array

	type fsm_state is (
		INIT_RCR0,
		INIT_RCR1,
		INIT_BCR0,
		INIT_BCR1,
		INIT_READ0,
		INIT_READ1,
		INIT_READ2,
		IDLE,
		WRITE_CYCLE,
		READ_CYCLE
	);


	------------------------------------------
	-- signals
	------------------------------------------
	signal psram_clk      : std_logic := '0';
	signal psram_address  : std_logic_vector(22 downto 0);
	signal psram_adv_n    : std_logic;
	signal psram_cre      : std_logic;
	signal psram_ce_n     : std_logic;
	signal psram_oe_n     : std_logic;
	signal psram_we_n     : std_logic;
	signal psram_lb_n     : std_logic;
	signal psram_ub_n     : std_logic;
	signal psram_dq_T     : std_logic_vector(15 downto 0);
	signal psram_dq_I     : std_logic_vector(15 downto 0);
	signal psram_dq_O     : std_logic_vector(15 downto 0);
	signal psram_wait     : std_logic;
	signal state          : fsm_state := INIT_RCR0;
	signal wait_cnt       : std_logic_vector(1 downto 0);
	signal data_index     : std_logic_vector(1 downto 0);
	signal Bus2IP_RdReq_R : std_logic;
	signal Bus2IP_WrReq_R : std_logic;
	
	------------------------------------------
	-- constraints
	------------------------------------------
	attribute equivalent_register_removal : string;
	attribute equivalent_register_removal of pads_dq_T : signal is "false";
		
begin

	------------------------------------------
	-- state machine
	------------------------------------------

	STATE_PROC : process( Bus2IP_Clk ) is
	begin

		if ( Bus2IP_Clk'event and Bus2IP_Clk = '1' ) then
			if ( Bus2IP_Reset = '1' ) then
				-- start in PSAM initialization state
				state          <= INIT_RCR0;
				wait_cnt       <= (others => '0');
				psram_address  <= (others => '0');
				psram_clk      <= '0';
				psram_adv_n    <= '1';
				psram_cre      <= '0';
				psram_ce_n     <= '1';
				psram_oe_n     <= '1';
				psram_we_n     <= '1';
				psram_lb_n     <= '0';
				psram_ub_n     <= '0';
				psram_dq_T     <= (others => '1');
				data_index     <= (others => '0');
				IP2Bus_WrAck   <= '0';
				IP2Bus_RdAck   <= '0';
				IP2Bus_AddrAck <= '0';
			else
				-- toggle the clock at 50 Mhz
				psram_clk <= not psram_clk;

				-- default the acks to 0
				IP2Bus_WrAck   <= '0';
				IP2Bus_RdAck   <= '0';
				IP2Bus_AddrAck <= '0';

				-- register the bus request signals
				Bus2IP_RdReq_R <= Bus2IP_RdReq;
				Bus2IP_WrReq_R <= Bus2IP_WrReq;

				-- allow output changes only on clocks faling edges
				if psram_clk = '1' then
					case state is
						when INIT_RCR0 =>
							-- prepare the address, but leave the control signal inactive						
							psram_address <= RCR;
							psram_cre     <= '1';
							psram_adv_n   <= '1';
							psram_ce_n    <= '1';
							psram_oe_n    <= '1';
							psram_we_n    <= '1';
							-- go to the next step
							state         <= INIT_RCR1;
						when INIT_RCR1 =>
							-- enable write enable, address valid and chip enable
							psram_adv_n   <= '0';
							psram_ce_n    <= '0';
							psram_we_n    <= '0';
							-- wait for 4 cycles and then go to the next step
							if wait_cnt = 3 then
								state         <= INIT_BCR0;
								wait_cnt      <= (others => '0');
								-- release the enables
								psram_adv_n   <= '1';
								psram_ce_n    <= '1';
								psram_we_n    <= '1';
							else
								wait_cnt      <= wait_cnt + 1;
							end if;
						when INIT_BCR0 =>
							-- prepare the address, but leave the control signal inactive						
							psram_address <= BCR;
							psram_cre     <= '1';
							psram_adv_n   <= '1';
							psram_ce_n    <= '1';
							psram_oe_n    <= '1';
							psram_we_n    <= '1';
							-- go to the next step
							state         <= INIT_BCR1;
						when INIT_BCR1 =>
							-- enable write enable, address valid and chip enable
							psram_adv_n   <= '0';
							psram_ce_n    <= '0';
							psram_we_n    <= '0';
							-- wait for 4 cycles and then go to the next step
							if wait_cnt = 3 then
								state         <= INIT_READ0;
								wait_cnt      <= (others => '0');
								-- release the enables
								psram_adv_n   <= '1';
								psram_ce_n    <= '1';
								psram_we_n    <= '1';
							else
								wait_cnt      <= wait_cnt + 1;
							end if;
						when INIT_READ0 =>
							-- perform initial dummy read as recommended by Micron datasheet
							psram_address <= (others => '0');
							psram_cre     <= '0';
							psram_adv_n   <= '0';
							psram_ce_n    <= '0';
							psram_we_n    <= '1';
							psram_oe_n    <= '0';
							psram_lb_n    <= '0';
							psram_ub_n    <= '0';
							-- go to the next step
							state         <= INIT_READ1;
						when INIT_READ1 =>
							psram_adv_n   <= '1';
							-- go to the next step
							state         <= INIT_READ2;
						when INIT_READ2 =>
							psram_adv_n   <= '1';
							-- wait for 4 cycles and then go to the next step
							if wait_cnt = 3 then
								state         <= IDLE;
								wait_cnt      <= (others => '0');
								-- release the enables
								psram_ce_n    <= '1';
								psram_oe_n    <= '1';								
							else
								wait_cnt      <= wait_cnt + 1;
							end if;
						when IDLE =>
							-- read cycle
							if (Bus2IP_RdReq = '1' or Bus2IP_RdReq_R = '1') and Bus2IP_CS(0) = '1' then
								psram_address <= Bus2IP_Addr(8 to 28) & "00";
								psram_adv_n   <= '0';
								psram_ce_n    <= '0';
								psram_we_n    <= '1';
								psram_ub_n    <= '0';
								psram_lb_n    <= '0';
								-- got to read cycle
								state         <= READ_CYCLE;
							end if;
							-- write cycle
							if (Bus2IP_WrReq = '1' or Bus2IP_WrReq_R = '1') and Bus2IP_CS(0) = '1' then
								psram_address <= Bus2IP_Addr(8 to 28) & "00";
								psram_adv_n   <= '0';
								psram_ce_n    <= '0';
								psram_we_n    <= '0';
								psram_oe_n    <= '1';
								psram_dq_O    <= Bus2IP_Data(0 to 15);
								psram_ub_n    <= not Bus2IP_BE(0);
								psram_lb_n    <= not Bus2IP_BE(1);
								-- got to write cycle
								state         <= WRITE_CYCLE;
							end if;
						when WRITE_CYCLE =>
							-- enable tristates
							psram_dq_T   <= (others => '0');
							-- release address valid
							psram_adv_n  <= '1';
							-- advance the data index when wait is low
							if psram_wait = '0' then
								data_index    <= data_index + 1;
								if data_index = "00" then
									psram_dq_O      <= Bus2IP_Data(16 to 31);
									psram_ub_n      <= not Bus2IP_BE(2);
									psram_lb_n      <= not Bus2IP_BE(3);
								end if;
								if data_index = "01" then
									psram_dq_O      <= Bus2IP_Data(32 to 47);
									psram_ub_n      <= not Bus2IP_BE(4);
									psram_lb_n      <= not Bus2IP_BE(5);
								end if;
								if data_index = "10" then
									psram_dq_O      <= Bus2IP_Data(48 to 63);
									psram_ub_n      <= not Bus2IP_BE(6);
									psram_lb_n      <= not Bus2IP_BE(7);
								end if;
								if data_index = "11" then
									-- disable the psram
									psram_ce_n      <= '1';
									-- disable tristates
									psram_dq_T      <= (others => '1');
									-- acknowledge the write and go back to idle state
									IP2Bus_AddrAck  <= '1';
									IP2Bus_WrAck    <= '1';									
									state           <= IDLE;
								end if;
							end if;
						when READ_CYCLE =>
							-- enable PSRAM output
							psram_oe_n    <= '0';
							-- release address valid
							psram_adv_n  <= '1';
							-- advance the data index when wait is low
							if psram_wait = '0' then
								data_index  <= data_index + 1;
								-- mux data onto the bus
								if data_index = "00" then
									IP2BUS_Data(0 to 15)  <= psram_dq_I;
								end if;
								if data_index = "01" then
									IP2BUS_Data(16 to 31) <= psram_dq_I;
								end if;
								if data_index = "10" then
									IP2BUS_Data(32 to 47) <= psram_dq_I;
								end if;
								if data_index = "11" then
									IP2BUS_Data(48 to 63) <= psram_dq_I;
									-- disable the psram
									psram_ce_n      <= '1';
									psram_oe_n      <= '1';
									-- acknowledge the read and go back to idle state
									IP2Bus_RdAck    <= '1';									
									IP2Bus_AddrAck  <= '1';									
									state           <= IDLE;
								end if;
							end if;
					end case;
				end if;
			end if;
		end if;

	end process STATE_PROC;

	------------------------------------------
	-- PSRAM interface
	------------------------------------------

	
	-- connect the pads
	pads_address       <= psram_address;
	pads_clk           <= psram_clk    ;
	pads_adv_b         <= psram_adv_n  ;
	pads_cre           <= psram_cre    ;
	pads_ce_b          <= psram_ce_n   ;
	pads_oe_b          <= psram_oe_n   ;
	pads_we_b          <= psram_we_n   ;
	pads_lb_b          <= psram_lb_n   ;
	pads_ub_b          <= psram_ub_n   ;
	pads_dq_T          <= psram_dq_T   ;
	psram_dq_I         <= pads_dq_I    ;
	pads_dq_O          <= psram_dq_O   ;
	psram_wait         <= pads_wait    ;

	------------------------------------------
	-- IP to Bus signals
	------------------------------------------

	IP2Bus_Busy        <= '0';
	IP2Bus_Error       <= '0';
	IP2Bus_Retry       <= '0';
	IP2Bus_ToutSup     <= '0';

end IMP;
