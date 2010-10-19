--  Copyright (c) 2005-2006, Regents of the University of California
--  All rights reserved.
--
--  Redistribution and use in source and binary forms, with or without modification,
--  are permitted provided that the following conditions are met:
--
--      - Redistributions of source code must retain the above copyright notice,
--          this list of conditions and the following disclaimer.
--      - Redistributions in binary form must reproduce the above copyright
--          notice, this list of conditions and the following disclaimer
--          in the documentation and/or other materials provided with the
--          distribution.
--      - Neither the name of the University of California, Berkeley nor the
--          names of its contributors may be used to endorse or promote
--          products derived from this software without specific prior
--          written permission.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
--  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
--  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

-- ### ###   ##    ### ###  #####             #       ##  
--  #   #     #     #   #     #                      #    
--   # #      #     #   #     #                      #    
--   # #     # #    #   #     #             ###     ####  
--    #      # #    #   #     #               #      #    
--   # #    #   #   #   #     #               #      #    
--   # #    #####   #   #     #               #      #    
--  #   #   #   #   #   #     #               #      #    
-- ### ### ### ###   ###    #####           #####   ####  

-- XAUI interface top level

-- created by Pierre-Yves Droz 2005

------------------------------------------------------------------------------
-- XAUI_interface.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library unisim;
use unisim.all;

entity XAUI_interface is
	generic(
		DEMUX                 : integer           := 1;
		CONNECTOR             : integer           := 0
	);
	port (
		-- application clock
		clk                   : in  std_logic;

		-- communication clocks
		mgt_clk_top_10G       : in  std_logic;
		mgt_clk_bottom_10G    : in  std_logic;
		mgt_clk_top_8G        : in  std_logic;
		mgt_clk_bottom_8G     : in  std_logic;
		xaui_clk_top          : in  std_logic;
		xaui_clk_bottom       : in  std_logic;
		speed_select          : in  std_logic;

		-- rx
		rx_data               : out std_logic_vector((64/DEMUX - 1) downto 0);
		rx_outofband          : out std_logic_vector(( 8/DEMUX - 1) downto 0);
		rx_ack                : in  std_logic;
		rx_empty              : out std_logic;
		rx_valid              : out std_logic;
		rx_full_slots         : out std_logic_vector(15 downto 0);

		-- tx
		tx_data               : in  std_logic_vector((64/DEMUX - 1) downto 0);
		tx_outofband          : in  std_logic_vector(( 8/DEMUX - 1) downto 0);
		tx_valid              : in  std_logic;
		tx_ack                : out std_logic;
		tx_full               : out std_logic;
		tx_empty_slots        : out std_logic_vector(15 downto 0);

		-- status
		linkdown              : out std_logic;
		data_lost             : out std_logic;

		-- MGT ports
		mgt_tx_l0_p           : out std_logic;
		mgt_tx_l0_n           : out std_logic;
		mgt_tx_l1_p           : out std_logic;
		mgt_tx_l1_n           : out std_logic;
		mgt_tx_l2_p           : out std_logic;
		mgt_tx_l2_n           : out std_logic;
		mgt_tx_l3_p           : out std_logic;
		mgt_tx_l3_n           : out std_logic;
		mgt_rx_l0_p           : in  std_logic;
		mgt_rx_l0_n           : in  std_logic;
		mgt_rx_l1_p           : in  std_logic;
		mgt_rx_l1_n           : in  std_logic;
		mgt_rx_l2_p           : in  std_logic;
		mgt_rx_l2_n           : in  std_logic;
		mgt_rx_l3_p           : in  std_logic;
		mgt_rx_l3_n           : in  std_logic		
	);
end entity XAUI_interface;

architecture XAUI_interface_arch of XAUI_interface is

--  ####    ####   #    #   ####    #####
-- #    #  #    #  ##   #  #          #
-- #       #    #  # #  #   ####      #
-- #       #    #  #  # #       #     #
-- #    #  #    #  #   ##  #    #     #
--  ####    ####   #    #   ####      #

	type monitor_state_type is (
		NORMAL_OPERATION,
		IN_RESET,
		WAIT_SYNC,
		WAIT_PACKET
	);

	type tx_state_type is (
		SEND_IDLE,
		SEND_UPACKET,
		SEND_DATA
	);

	type rx_state_type is (
		RECEIVE_IDLE,
		RECEIVE_DATA
	);

	constant DATA  : std_logic                             := '0';
	constant CTRL  : std_logic                             := '1';
	constant IDLE  : std_logic_vector(7 downto 0)          := X"07";
	constant START : std_logic_vector(7 downto 0)          := X"FB";
	constant TERM  : std_logic_vector(7 downto 0)          := X"FD";
	constant ERROR : std_logic_vector(7 downto 0)          := X"FE";

	constant MAX_TX_COUNT    : std_logic_vector(15 downto 0)  := X"01FF";
	constant MAX_RX_COUNT    : std_logic_vector(15 downto 0)  := X"01FF";
	constant MAX_TX_COUNT_2X : std_logic_vector(15 downto 0)  := X"03FF";
	constant MAX_RX_COUNT_2X : std_logic_vector(15 downto 0)  := X"03FF";

-- smaller packet for simulation
--	constant PACKET_SIZE   : integer                       := 8;
--	constant PACKET_START0 : std_logic_vector(7 downto 0)  := "00000000";
--	constant PACKET_START1 : std_logic_vector(7 downto 0)  := "00000001";
--	constant PACKET_END0   : std_logic_vector(7 downto 0)  := "11111110";
--	constant PACKET_END1   : std_logic_vector(7 downto 0)  := "11111111";

	constant PACKET_SIZE   : integer                       := 12;
	constant PACKET_START0 : std_logic_vector(11 downto 0) := "000000000000";
	constant PACKET_START1 : std_logic_vector(11 downto 0) := "000000000001";
	constant PACKET_END0   : std_logic_vector(11 downto 0) := "111111111110";
	constant PACKET_END1   : std_logic_vector(11 downto 0) := "111111111111";

--  ####    ####   #    #  #####    ####   #    #  ######  #    #   #####   ####
-- #    #  #    #  ##  ##  #    #  #    #  ##   #  #       ##   #     #    #
-- #       #    #  # ## #  #    #  #    #  # #  #  #####   # #  #     #     ####
-- #       #    #  #    #  #####   #    #  #  # #  #       #  # #     #         #
-- #    #  #    #  #    #  #       #    #  #   ##  #       #   ##     #    #    #
--  ####    ####   #    #  #        ####   #    #  ######  #    #     #     ####

	-- xaui ip
	component xaui_if
		port (
			reset                : in  std_logic;
			usrclk               : in  std_logic;
			xgmii_txd            : in  std_logic_vector(63 downto 0);
			xgmii_txc            : in  std_logic_vector(7 downto 0);
			xgmii_rxd            : out std_logic_vector(63 downto 0);
			xgmii_rxc            : out std_logic_vector(7 downto 0);
			signal_detect        : in  std_logic_vector(3 downto 0);
			align_status         : out std_logic;
			sync_status          : out std_logic_vector(3 downto 0);
			configuration_vector : in  std_logic_vector(6 downto 0);
			status_vector        : out std_logic_vector(7 downto 0);
			mgt_txdata           : out std_logic_vector(63 downto 0);
			mgt_txcharisk        : out std_logic_vector(7 downto 0);
			mgt_rxdata           : in  std_logic_vector(63 downto 0);
			mgt_rxcharisk        : in  std_logic_vector(7 downto 0);
			mgt_codevalid        : in  std_logic_vector(7 downto 0);
			mgt_codecomma        : in  std_logic_vector(7 downto 0);
			mgt_enable_align     : out std_logic_vector(3 downto 0);
			mgt_enchansync       : out std_logic;
			mgt_syncok           : in  std_logic_vector(3 downto 0);
			mgt_loopback         : out std_logic;
			mgt_powerdown        : out std_logic;
			mgt_tx_reset         : in  std_logic_vector(3 downto 0);
			mgt_rx_reset         : in  std_logic_vector(3 downto 0)
		);
	end component;
	-- MGT
	component transceiver
		generic (
			CHBONDMODE           : string;
			CONNECTOR            : integer;
			CHANNEL              : integer
		);
		port (
			reset                           : in  std_logic;
			clk                             : in  std_logic;
			brefclk                         : in  std_logic;
			brefclk2                        : in  std_logic;
			refclksel                       : in  std_logic;
			dcm_locked                      : in  std_logic;
			txdata                          : in  std_logic_vector(15 downto 0);
			txcharisk                       : in  std_logic_vector(1 downto 0);
			txp                             : out std_logic;
			txn                             : out std_logic;
			rxdata                          : out std_logic_vector(15 downto 0);
			rxcharisk                       : out std_logic_vector(1 downto 0);
			rxp                             : in  std_logic;
			rxn                             : in  std_logic;
			loopback_ser                    : in  std_logic;
			powerdown                       : in  std_logic;
			chbondi                         : in  std_logic_vector(3 downto 0);
			chbondo                         : out std_logic_vector(3 downto 0);
			enable_align                    : in  std_logic;
			syncok                          : out std_logic;
			enchansync                      : in  std_logic;
			code_valid                      : out std_logic_vector(1 downto 0);
			code_comma                      : out std_logic_vector(1 downto 0);
			mgt_tx_reset                    : out std_logic;
			mgt_rx_reset                    : out std_logic
		);
	end component;


--  ####      #     ####   #    #    ##    #        ####
-- #          #    #    #  ##   #   #  #   #       #
--  ####      #    #       # #  #  #    #  #        ####
--      #     #    #  ###  #  # #  ######  #            #
-- #    #     #    #    #  #   ##  #    #  #       #    #
--  ####      #     ####   #    #  #    #  ######   ####


	-- one and zero
	signal one                             : std_logic := '1';
	signal zero                            : std_logic := '0';

	-- clocks
	signal xaui_clk                        : std_logic := '0';

	-- XAUI IP <-> MGT signals
	signal mgt_brefclk                     : std_logic;
	signal mgt_brefclk2                    : std_logic;
	signal mgt_txdata                      : std_logic_vector(63 downto 0);
	signal mgt_txcharisk                   : std_logic_vector(7 downto 0);
	signal mgt_tx_reset                    : std_logic_vector(3 downto 0);
	signal mgt_rxdata                      : std_logic_vector(63 downto 0);
	signal mgt_rxcharisk                   : std_logic_vector(7 downto 0);
	signal mgt_enable_align                : std_logic_vector(3 downto 0);
	signal mgt_syncok                      : std_logic_vector(3 downto 0);
	signal mgt_enchansync                  : std_logic;
	signal mgt_codevalid                   : std_logic_vector(7 downto 0);
	signal mgt_codecomma                   : std_logic_vector(7 downto 0);
	signal mgt_rx_reset                    : std_logic_vector(3 downto 0);
	signal mgt_loopback                    : std_logic;
	signal mgt_powerdown                   : std_logic;
	signal mgt_chbond                      : std_logic_vector(3 downto 0);

	-- Controller <-> XAUI IP signals
	signal xaui_tx_data                    : std_logic_vector(63 downto 0) := X"0707070707070707";
	signal xaui_tx_ctrl                    : std_logic_vector(7 downto 0)  := "11111111";
	signal xaui_rx_data                    : std_logic_vector(63 downto 0);
	signal xaui_rx_ctrl                    : std_logic_vector(7 downto 0); 
	signal xaui_configuration_vector       : std_logic_vector(6 downto 0);
	signal xaui_status_vector              : std_logic_vector(7 downto 0);

	-- monitor signals
	signal monitor_state                   : monitor_state_type := IN_RESET;
	signal rx_up                           : std_logic;
	signal xaui_reset_cnt                  : std_logic_vector(3 downto 0) := X"0";
	signal xaui_reset                      : std_logic := '1';
	signal linkdown_int                    : std_logic := '1';
	signal data_lost_int                   : std_logic := '1';
	signal xaui_reset_delay                : std_logic_vector(15 downto 0) := (others => '1');

	-- application signals
	signal rx_out                          : std_logic_vector((72/DEMUX - 1) downto 0) := (others => '0');
	signal tx_in                           : std_logic_vector((72/DEMUX - 1) downto 0) := (others => '0');

	-- tx controller signals
	signal tx_state                        : tx_state_type := SEND_IDLE;
	signal packet_counter                  : std_logic_vector((PACKET_SIZE-1) downto 0) := (others => '0');
	signal xaui_tx_stop_sending            : std_logic := '0';
	signal xaui_tx_outofband_last          : std_logic_vector(7 downto 0)  := (others => '0');
	signal xaui_tx_fifo_ack                : std_logic := '0';
	signal xaui_tx_fifo_packet_ack         : std_logic := '0';
	signal xaui_tx_fifo_state_ack          : std_logic := '0';
	signal xaui_tx_fifo_outofband_ack      : std_logic := '0';
	signal xaui_tx_fifo_out                : std_logic_vector(71 downto 0) := (others => '0');
	signal xaui_tx_fifo_data               : std_logic_vector(63 downto 0) := (others => '0');
	signal xaui_tx_fifo_outofband          : std_logic_vector(7 downto 0)  := (others => '0');
	signal xaui_tx_fifo_valid              : std_logic := '0';
	signal xaui_tx_data_count              : std_logic_vector((7+DEMUX) downto 0) := (others => '0');
	signal xaui_tx_full                    : std_logic;

	-- rx controller signals
	signal rx_state                        : rx_state_type := RECEIVE_IDLE;
	signal rx_data_is_aligned              : std_logic := '0';
	signal xaui_rx_data_R                  : std_logic_vector(63 downto 0) := (others => '0');
	signal xaui_rx_ctrl_R                  : std_logic_vector(7 downto 0) := (others => '0');
	signal xaui_rx_fifo_valid              : std_logic := '0';
	signal xaui_rx_fifo_full               : std_logic := '0';
	signal xaui_rx_fifo_in                 : std_logic_vector(71 downto 0) := (others => '0');
	signal xaui_rx_fifo_data               : std_logic_vector(63 downto 0) := (others => '0');
	signal xaui_rx_fifo_outofband          : std_logic_vector( 7 downto 0) := (others => '0');
	signal xaui_rx_fifo_almost_full        : std_logic := '0';
	signal xaui_rx_fifo_almost_full_last   : std_logic := '0';
	signal xaui_rx_data_count              : std_logic_vector((7+DEMUX) downto 0) := (others => '0');

begin

-- MAIN PROCESS

xaui_fsm: process(xaui_clk)
begin
	if xaui_clk'event and xaui_clk = '1' then

-- #    #   ####   #    #     #     #####   ####   #####
-- ##  ##  #    #  ##   #     #       #    #    #  #    #
-- # ## #  #    #  # #  #     #       #    #    #  #    #
-- #    #  #    #  #  # #     #       #    #    #  #####
-- #    #  #    #  #   ##     #       #    #    #  #   #
-- #    #   ####   #    #     #       #     ####   #    #

-- link status monitoring

		rx_up <= '1';
		-- check if the xaui core is reporting a problem with the link
		if xaui_status_vector(6 downto 2) /= "11111" then
			-- All lanes synchronized ---------1111
			-- All lanes aligned      --------1
			rx_up <= '0';
		end if;

		-- monitor state machine
		case monitor_state is
			-- resetting the core
			when IN_RESET =>
				-- keeps the reset high for a while and then goes out of reset
				if xaui_reset_cnt = X"F" then
					xaui_reset    <= '0';
					monitor_state <= WAIT_SYNC;
				else
					xaui_reset_cnt <= xaui_reset_cnt + 1;
				end if;
				-- signal that the link is down
				linkdown_int <= '1';
			-- wainting for RX to be up
			when WAIT_SYNC =>
				-- if the receive syncs then start sending micropackets
				if rx_up = '1' then
					monitor_state <= WAIT_PACKET;
				end if;
				-- signal that the link is down
				linkdown_int <= '1';
			-- waiting first packet from transmitter
			when WAIT_PACKET =>
				-- if we receive a packet, then we can start transmitting (means that the other receive is up and running)
				if rx_state = RECEIVE_DATA then
					monitor_state <= NORMAL_OPERATION;
				end if;
				-- signal that the link is down
				linkdown_int <= '1';
			when NORMAL_OPERATION =>
				-- signal that the link is up
				linkdown_int <= '0';
				-- in case of a rx fault, bring the core to reset
				if rx_up = '0' then
					xaui_reset_cnt <= X"0";
					xaui_reset     <= '1';
					monitor_state  <= IN_RESET;
					-- signal that the link is down
					linkdown_int <= '1';
				end if;
		end case;

-- ######  #####   #####    ####   #####
-- #       #    #  #    #  #    #  #    #
-- #####   #    #  #    #  #    #  #    #
-- #       #####   #####   #    #  #####
-- #       #   #   #   #   #    #  #   #
-- ######  #    #  #    #   ####   #    #

-- data lost monitoring
		-- delay reset to match fifo reset delay
		xaui_reset_delay <= xaui_reset_delay(14 downto 0) & xaui_reset;
		if xaui_reset = '1' or xaui_reset_delay(15) = '1' then
			data_lost_int <= '0';
		else
			if xaui_rx_fifo_full = '1' then
				data_lost_int <= '1';
			end if;
		end if;

-- #####   #    #           ####    #####  #####   #
-- #    #   #  #           #    #     #    #    #  #
-- #    #    ##            #          #    #    #  #
-- #####     ##            #          #    #####   #
-- #   #    #  #           #    #     #    #   #   #
-- #    #  #    #           ####      #    #    #  ######

-- receive controller
		if xaui_reset = '1' then
			rx_state                        <= RECEIVE_IDLE;
			rx_data_is_aligned              <= '0';
			xaui_rx_fifo_outofband          <= (others => '0');
		else
			-- defaults the fifo write enable to 0
			xaui_rx_fifo_valid <= '0';
			-- delay signals for pipelining
			xaui_rx_data_R <= xaui_rx_data;
			xaui_rx_ctrl_R <= xaui_rx_ctrl;
			-- receive state machine
			case rx_state is
				when RECEIVE_IDLE =>
					-- check if we get an aligned packet start
					if xaui_rx_data_R(7 downto 0)   = START and xaui_rx_ctrl_R(0) = '1' then
						rx_data_is_aligned <= '1';
						rx_state           <= RECEIVE_DATA;
					end if;
					-- check if we get a non-aligned packet start
					if xaui_rx_data_R(39 downto 32) = START and xaui_rx_ctrl_R(4) = '1' then
						rx_data_is_aligned <= '0';
						rx_state           <= RECEIVE_DATA;
					end if;
				when RECEIVE_DATA =>
					-- output correct data depending on the alignement
					if rx_data_is_aligned = '1' then
						-- check if we are receiving the end of a packet, in that case we go back to idle state
						if xaui_rx_data_R(7 downto 0)   = TERM and xaui_rx_ctrl_R(1 downto 0) = "11" then
							rx_state           <= RECEIVE_IDLE;
						else
							-- if we receive an outofband signal, update the oob value 
							if xaui_rx_ctrl_R(2 downto 0) = "100" then
								xaui_rx_fifo_outofband <= xaui_rx_data_R(7 downto 0);
								xaui_tx_stop_sending   <= xaui_rx_data_R(8);
							else
								xaui_rx_fifo_data      <= xaui_rx_data_R;
								xaui_rx_fifo_valid     <= '1';
							end if;
						end if;
					else
						-- check if we are receving the end of a packet, in that case we go back to idle state
						if xaui_rx_data_R(39 downto 32) = TERM and xaui_rx_ctrl_R(5 downto 4) = "11" then
							rx_state           <= RECEIVE_IDLE;
						else
							-- if we receive an outofband signal, update the oob value 
							if xaui_rx_ctrl_R(6 downto 4) = "100" then
								xaui_rx_fifo_outofband <= xaui_rx_data_R(39 downto 32);
								xaui_tx_stop_sending   <= xaui_rx_data_R(40);
							else
								xaui_rx_fifo_data  <= xaui_rx_data(31 downto 0) & xaui_rx_data_R(63 downto 32);
								xaui_rx_fifo_valid <= '1';
							end if;
						end if;
					end if;
			end case;
		end if;


--  #####  #    #           ####    #####  #####   #
--    #     #  #           #    #     #    #    #  #
--    #      ##            #          #    #    #  #
--    #      ##            #          #    #####   #
--    #     #  #           #    #     #    #   #   #
--    #    #    #           ####      #    #    #  ######

-- transmit controller
		if xaui_reset = '1' then
			tx_state                        <= SEND_IDLE;
			packet_counter                  <= PACKET_START0;
			xaui_tx_outofband_last          <= (others => '0');
			xaui_rx_fifo_almost_full_last   <= '0';
			xaui_tx_data                    <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE ; 
			xaui_tx_ctrl                    <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
			xaui_tx_stop_sending            <= '0';
		else
			-- tx fsm
			case tx_state is
				when SEND_IDLE =>
					-- send idle until the monitor asks for sending micropackets
					xaui_tx_data                    <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE ; 
					xaui_tx_ctrl                    <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
					if monitor_state = WAIT_PACKET then
						tx_state <= SEND_UPACKET;
					end if;
				when SEND_UPACKET =>
					-- counter to send the packet limits
					packet_counter <= packet_counter + 1;
					-- packet shaping
					case packet_counter is
						when PACKET_START0 =>
							-- start of a packet
							xaui_tx_data <= ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & START;
							xaui_tx_ctrl <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when PACKET_START1 =>
							-- end of a packet
							xaui_tx_data <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & TERM ;
							xaui_tx_ctrl <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when others =>
							-- idle between packets
							xaui_tx_data <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE;
							xaui_tx_ctrl <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
							-- if the monitor asks for it, starts transmitting
							if monitor_state = NORMAL_OPERATION then
								packet_counter       <= PACKET_START0;
								tx_state             <= SEND_DATA;
							end if;
					end case;
				when SEND_DATA =>
					-- packet index counter
					packet_counter <= packet_counter + 1;
					-- packet shaping
					case packet_counter is
						when PACKET_START0 =>
							-- start of a packet
							xaui_tx_data <= ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & START;
							xaui_tx_ctrl <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when PACKET_END0 =>
							-- at the end of a packet
							xaui_tx_data <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & TERM ;
							xaui_tx_ctrl <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when PACKET_END1 =>
							-- idle between packets
							xaui_tx_data <= IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE  & IDLE;
							xaui_tx_ctrl <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL ;
						when others =>
							-- send data or outofband
							if (xaui_tx_fifo_outofband = xaui_tx_outofband_last) and (xaui_rx_fifo_almost_full = xaui_rx_fifo_almost_full_last) and (xaui_tx_fifo_valid = '1') and (xaui_tx_stop_sending = '0') then
								xaui_tx_data <= xaui_tx_fifo_data;
								xaui_tx_ctrl <= DATA & DATA & DATA & DATA & DATA & DATA & DATA & DATA; 
							else
								xaui_tx_outofband_last        <= xaui_tx_fifo_outofband;
								xaui_rx_fifo_almost_full_last <= xaui_rx_fifo_almost_full;
								xaui_tx_data <= ERROR & ERROR & ERROR & ERROR & ERROR & ERROR & "0000000" & xaui_rx_fifo_almost_full & xaui_tx_fifo_outofband;
								xaui_tx_ctrl <= CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & CTRL  & DATA & DATA ;
							end if;
							-- detect the presence of a change in the outofband signals
					end case;
			end case;
		end if;
	end if;
end process xaui_fsm;

-- control the stat fifo ack signal
with tx_state select xaui_tx_fifo_state_ack <=
	'1' when SEND_DATA,
	'0' when others;

-- control the packet fifo ack signal
with packet_counter select xaui_tx_fifo_packet_ack <=
	'0' when PACKET_START0,
	'0' when PACKET_END0,
	'0' when PACKET_END1,
	'1' when others;

-- control the outofband ack signal
xaui_tx_fifo_outofband_ack <= '0' when (((xaui_tx_fifo_outofband /= xaui_tx_outofband_last or xaui_rx_fifo_almost_full /= xaui_rx_fifo_almost_full_last) and (xaui_tx_fifo_valid = '1')) or (xaui_tx_stop_sending = '1')) else '1';

--  ####   #       #    #          #####    ####   #    #    ##       #    #    #
-- #    #  #       #   #           #    #  #    #  ##  ##   #  #      #    ##   #
-- #       #       ####            #    #  #    #  # ## #  #    #     #    # #  #
-- #       #       #  #            #    #  #    #  #    #  ######     #    #  # #
-- #    #  #       #   #           #    #  #    #  #    #  #    #     #    #   ##
--  ####   ######  #    #          #####    ####   #    #  #    #     #    #    #

clk_boundary: process(clk)
begin
	if clk'event and clk = '1' then
		-- recapture the link_down signal on the application clock
		linkdown  <= linkdown_int;
		-- recapture the error signal on the application clock
		data_lost <= data_lost_int;
	end if;
end process clk_boundary;


--  #####  #    #          ######     #    ######   ####
--    #     #  #           #          #    #       #    #
--    #      ##            #####      #    #####   #    #
--    #      ##            #          #    #       #    #
--    #     #  #           #          #    #       #    #
--    #    #    #          #          #    #        ####

-- transmit FIFO instantiation

-- DEMUX = 1

TX_FIFO_GEN_DEMUX1: if DEMUX = 1 generate
	component tx_fifo
		port (
			din           : in  std_logic_vector(71 downto 0);
			rd_clk        : in  std_logic;
			rd_en         : in  std_logic;
			rst           : in  std_logic;
			wr_clk        : in  std_logic;
			wr_en         : in  std_logic;
			dout          : out std_logic_vector(71 downto 0);
			empty         : out std_logic;
			full          : out std_logic;
			valid         : out std_logic;
			wr_ack        : out std_logic;
			wr_data_count : out std_logic_vector(8 downto 0)
		);
	end component;
begin
	xaui_tx_fifo : tx_fifo
		port map (
			-- read clock domain
			rd_clk        => xaui_clk,
			rd_en         => xaui_tx_fifo_ack,
			dout          => xaui_tx_fifo_out,
			empty         => open,
			valid         => xaui_tx_fifo_valid,
			rst           => xaui_reset,
	
			-- write clock domain
			wr_clk        => clk,
			wr_en         => tx_valid,
			wr_ack        => open,
			din           => tx_in,
			full          => xaui_tx_full,
			wr_data_count => xaui_tx_data_count
		);

	-- transmit fifo signals mapping
	xaui_tx_fifo_ack       <= xaui_tx_fifo_outofband_ack and xaui_tx_fifo_packet_ack and xaui_tx_fifo_state_ack;
	xaui_tx_fifo_outofband <= xaui_tx_fifo_out(71 downto 64)           ;
	xaui_tx_fifo_data      <= xaui_tx_fifo_out(63 downto  0)           ;
	tx_in                  <= tx_outofband                             &
	                          tx_data                                  ;
	tx_empty_slots         <= MAX_TX_COUNT - ("0000000" & xaui_tx_data_count);
	-- we generate our own ack as Xilinx ack has a weird timing
	tx_ack                 <= tx_valid and not xaui_tx_full;
	tx_full                <= xaui_tx_full;
end generate TX_FIFO_GEN_DEMUX1;

-- DEMUX = 2

TX_FIFO_GEN_DEMUX2: if DEMUX = 2 generate
	component tx_fifo_2x
		port (
			din           : in  std_logic_vector(35 downto 0);
			rd_clk        : in  std_logic;
			rd_en         : in  std_logic;
			rst           : in  std_logic;
			wr_clk        : in  std_logic;
			wr_en         : in  std_logic;
			dout          : out std_logic_vector(71 downto 0);
			empty         : out std_logic;
			full          : out std_logic;
			valid         : out std_logic;
			wr_ack        : out std_logic;
			wr_data_count : out std_logic_vector(9 downto 0)
		);
	end component;
begin
	xaui_tx_fifo : tx_fifo_2x
		port map (
			-- read clock domain
			rd_clk        => xaui_clk,
			rd_en         => xaui_tx_fifo_ack,
			dout          => xaui_tx_fifo_out,
			empty         => open,
			valid         => xaui_tx_fifo_valid,
			rst           => xaui_reset,
	
			-- write clock domain
			wr_clk        => clk,
			wr_en         => tx_valid,
			wr_ack        => open,
			din           => tx_in,
			full          => xaui_tx_full,
			wr_data_count => xaui_tx_data_count
		);

	-- transmit fifo signals mapping
	xaui_tx_fifo_ack       <= xaui_tx_fifo_outofband_ack and xaui_tx_fifo_packet_ack and xaui_tx_fifo_state_ack;
	xaui_tx_fifo_outofband <= xaui_tx_fifo_out(71 downto 68)               &
	                          xaui_tx_fifo_out(35 downto 32)               ;
	xaui_tx_fifo_data      <= xaui_tx_fifo_out(67 downto 36)               &
	                          xaui_tx_fifo_out(31 downto  0)               ;
	tx_in                  <= tx_outofband                                 &
	                          tx_data                                      ;
	tx_empty_slots         <= MAX_TX_COUNT_2X - ("000000" & xaui_tx_data_count);
	-- we generate our own ack as Xilinx ack has a weird timing
	tx_ack                 <= tx_valid and not xaui_tx_full;
	tx_full                <= xaui_tx_full;
end generate TX_FIFO_GEN_DEMUX2;

-- #####   #    #          ######     #    ######   ####
-- #    #   #  #           #          #    #       #    #
-- #    #    ##            #####      #    #####   #    #
-- #####     ##            #          #    #       #    #
-- #   #    #  #           #          #    #       #    #
-- #    #  #    #          #          #    #        ####

-- receive FIFO instantiation

-- DEMUX = 1

RX_FIFO_GEN_DEMUX1: if DEMUX = 1 generate
	component rx_fifo
		port (
			din           : in  std_logic_vector(71 downto 0);
			rd_clk        : in  std_logic;
			rd_en         : in  std_logic;
			rst           : in  std_logic;
			wr_clk        : in  std_logic;
			wr_en         : in  std_logic;
			dout          : out std_logic_vector(71 downto 0);
			empty         : out std_logic;
			full          : out std_logic;
			prog_full     : out std_logic;
			valid         : out std_logic;
			rd_data_count : out std_logic_vector(8 downto 0)
		);
	end component;
begin
	xaui_rx_fifo : rx_fifo
		port map (
			-- read clock domain
			rd_clk        => clk,
			rd_en         => rx_ack,
			dout          => rx_out,
			empty         => rx_empty,
			valid         => rx_valid,
			rd_data_count => xaui_rx_data_count,
			
			-- write clock domain
			wr_clk        => xaui_clk,
			wr_en         => xaui_rx_fifo_valid,
			din           => xaui_rx_fifo_in,
			full          => xaui_rx_fifo_full,
			rst           => xaui_reset,
			prog_full     => xaui_rx_fifo_almost_full
		);

	-- receive fifo signals mapping
	xaui_rx_fifo_in        <= xaui_rx_fifo_outofband            &
	                          xaui_rx_fifo_data                 ;
	rx_outofband           <= rx_out(71 downto 64)              ;
	rx_data                <= rx_out(63 downto  0)              ;
	rx_full_slots          <= "0000000" & xaui_rx_data_count     ;
end generate RX_FIFO_GEN_DEMUX1;

-- DEMUX = 2

RX_FIFO_GEN_DEMUX2: if DEMUX = 2 generate
	component rx_fifo_2x
		port (
			din           : in  std_logic_vector(71 downto 0);
			rd_clk        : in  std_logic;
			rd_en         : in  std_logic;
			rst           : in  std_logic;
			wr_clk        : in  std_logic;
			wr_en         : in  std_logic;
			dout          : out std_logic_vector(35 downto 0);
			empty         : out std_logic;
			full          : out std_logic;
			prog_full     : out std_logic;
			valid         : out std_logic;
			rd_data_count : out std_logic_vector(9 downto 0)
		);
	end component;
begin
	xaui_rx_fifo : rx_fifo_2x
		port map (
			-- read clock domain
			rd_clk        => clk,
			rd_en         => rx_ack,
			dout          => rx_out,
			empty         => rx_empty,
			valid         => rx_valid,
			rd_data_count => xaui_rx_data_count,
			
			-- write clock domain
			wr_clk        => xaui_clk,
			wr_en         => xaui_rx_fifo_valid,
			din           => xaui_rx_fifo_in,
			full          => xaui_rx_fifo_full,
			rst           => xaui_reset,
			prog_full     => xaui_rx_fifo_almost_full
		);

	-- receive fifo signals mapping
	xaui_rx_fifo_in        <= xaui_rx_fifo_outofband(7 downto 4) &
	                          xaui_rx_fifo_data(63 downto 32)    &
	                          xaui_rx_fifo_outofband(3 downto 0) &
	                          xaui_rx_fifo_data(31 downto 0)     ;
	rx_outofband           <= rx_out(35 downto 32)               ;
	rx_data                <= rx_out(31 downto  0)               ;
	rx_full_slots          <= "000000" & xaui_rx_data_count      ;
end generate RX_FIFO_GEN_DEMUX2;

-- #    #    ##    #    #     #             ####    ####   #####   ######
--  #  #    #  #   #    #     #            #    #  #    #  #    #  #
--   ##    #    #  #    #     #            #       #    #  #    #  #####
--   ##    ######  #    #     #            #       #    #  #####   #
--  #  #   #    #  #    #     #            #    #  #    #  #   #   #
-- #    #  #    #   ####      #             ####    ####   #    #  ######


-- configuration vector
xaui_configuration_vector <= "000" & xaui_reset & xaui_reset & '0' & '0'; -- no test, no powerdown, use internal reset to re-arm the status bits, no loopback

-- XAUI core IP
xaui_core : xaui_if
	port map (
		-- reset
		reset                 => xaui_reset,
		-- clock
		usrclk                => xaui_clk,
		-- data
		xgmii_txd             => xaui_tx_data,
		xgmii_txc             => xaui_tx_ctrl,
		xgmii_rxd             => xaui_rx_data,
		xgmii_rxc             => xaui_rx_ctrl,
		-- status and configuration
		signal_detect         => "1111",
		align_status          => open,
		sync_status           => open,
		configuration_vector  => xaui_configuration_vector,
		status_vector         => xaui_status_vector,
		-- link to the MGTs
		mgt_txdata            => mgt_txdata,
		mgt_txcharisk         => mgt_txcharisk,
		mgt_rxdata            => mgt_rxdata,
		mgt_rxcharisk         => mgt_rxcharisk,
		mgt_codevalid         => mgt_codevalid,
		mgt_codecomma         => mgt_codecomma,
		mgt_enable_align      => mgt_enable_align,
		mgt_enchansync        => mgt_enchansync,
		mgt_syncok            => mgt_syncok,
		mgt_loopback          => mgt_loopback,
		mgt_powerdown         => mgt_powerdown,
		mgt_tx_reset          => mgt_tx_reset,
		mgt_rx_reset          => mgt_rx_reset
	);

-- #    #   ####    #####   ####
-- ##  ##  #    #     #    #
-- # ## #  #          #     ####
-- #    #  #  ###     #         #
-- #    #  #    #     #    #    #
-- #    #   ####      #     ####

genclk0 : if (CONNECTOR = 0 or CONNECTOR = 1) generate
	mgt_brefclk     <= mgt_clk_top_8G;
	mgt_brefclk2    <= mgt_clk_top_10G;
	xaui_clk        <= xaui_clk_top;
end generate;

genclk1 : if (CONNECTOR = 2 or CONNECTOR = 3) generate
	mgt_brefclk     <= mgt_clk_bottom_8G;
	mgt_brefclk2    <= mgt_clk_bottom_10G;
	xaui_clk        <= xaui_clk_bottom;
end generate;

-- transceiver 0
transceiver0 : transceiver
	generic map (
		CHBONDMODE => "MASTER" ,
		CONNECTOR  => CONNECTOR,
		CHANNEL    => 0        
	)
	port map (
		reset        => xaui_reset,
		clk          => xaui_clk,
		brefclk      => mgt_brefclk,
		brefclk2     => mgt_brefclk2,
		refclksel    => speed_select,
		dcm_locked   => one,
		txdata       => mgt_txdata(15 downto 0),
		txcharisk    => mgt_txcharisk(1 downto 0),
		txp          => mgt_tx_l0_p,
		txn          => mgt_tx_l0_n,
		rxdata       => mgt_rxdata(15 downto 0),
		rxcharisk    => mgt_rxcharisk(1 downto 0),
		rxp          => mgt_rx_l0_p,
		rxn          => mgt_rx_l0_n,
		enable_align => mgt_enable_align(0),
		syncok       => mgt_syncok(0),
		enchansync   => mgt_enchansync,
		code_valid   => mgt_codevalid(1 downto 0),
		code_comma   => mgt_codecomma(1 downto 0),
		loopback_ser => mgt_loopback,
		powerdown    => mgt_powerdown,
		chbondi      => "XXXX",
		chbondo      => mgt_chbond,
		mgt_tx_reset => mgt_tx_reset(0),
		mgt_rx_reset => mgt_rx_reset(0)
	);

-- transceiver 1
transceiver1 : transceiver
	generic map (
		CHBONDMODE => "SLAVE_1_HOP",
		CONNECTOR  => CONNECTOR    ,
		CHANNEL    => 1  
	)          
	port map (
		reset        => xaui_reset,
		clk          => xaui_clk,
		brefclk      => mgt_brefclk,  
		brefclk2     => mgt_brefclk2, 
		refclksel    => speed_select,
		dcm_locked   => one,
		txdata       => mgt_txdata(31 downto 16),
		txcharisk    => mgt_txcharisk(3 downto 2),
		txp          => mgt_tx_l1_p,
		txn          => mgt_tx_l1_n,
		rxdata       => mgt_rxdata(31 downto 16),
		rxcharisk    => mgt_rxcharisk(3 downto 2),
		rxp          => mgt_rx_l1_p,
		rxn          => mgt_rx_l1_n,
		enable_align => mgt_enable_align(1),
		syncok       => mgt_syncok(1),
		enchansync   => one,
		code_valid   => mgt_codevalid(3 downto 2),
		code_comma   => mgt_codecomma(3 downto 2),
		loopback_ser => mgt_loopback,
		powerdown    => mgt_powerdown,
		chbondi      => mgt_chbond,
		chbondo      => open,
		mgt_tx_reset => mgt_tx_reset(1),
		mgt_rx_reset => mgt_rx_reset(1)
	);

-- transceiver 2
transceiver2 : transceiver
	generic map (
		CHBONDMODE => "SLAVE_1_HOP",
		CONNECTOR  => CONNECTOR    ,
		CHANNEL    => 2            
	)
	port map (
		reset        => xaui_reset,
		clk          => xaui_clk,
		brefclk      => mgt_brefclk,  
		brefclk2     => mgt_brefclk2, 
		refclksel    => speed_select,
		dcm_locked   => one,
		txdata       => mgt_txdata(47 downto 32),
		txcharisk    => mgt_txcharisk(5 downto 4),
		txp          => mgt_tx_l2_p,
		txn          => mgt_tx_l2_n,
		rxdata       => mgt_rxdata(47 downto 32),
		rxcharisk    => mgt_rxcharisk(5 downto 4),
		rxp          => mgt_rx_l2_p,
		rxn          => mgt_rx_l2_n,
		enable_align => mgt_enable_align(2),
		syncok       => mgt_syncok(2),
		enchansync   => one,
		code_valid   => mgt_codevalid(5 downto 4),
		code_comma   => mgt_codecomma(5 downto 4),
		loopback_ser => mgt_loopback,
		powerdown    => mgt_powerdown,
		chbondi      => mgt_chbond,
		chbondo      => open,
		mgt_tx_reset => mgt_tx_reset(2),
		mgt_rx_reset => mgt_rx_reset(2)
	);

-- transceiver 3
transceiver3 : transceiver
	generic map (
		CHBONDMODE => "SLAVE_1_HOP",
		CONNECTOR  => CONNECTOR    ,
		CHANNEL    => 3            
	)
	port map (
		reset        => xaui_reset,
		clk          => xaui_clk,
		brefclk      => mgt_brefclk,  
		brefclk2     => mgt_brefclk2, 
		refclksel    => speed_select,
		dcm_locked   => one,
		txdata       => mgt_txdata(63 downto 48),
		txcharisk    => mgt_txcharisk(7 downto 6),
		txp          => mgt_tx_l3_p,
		txn          => mgt_tx_l3_n,
		rxdata       => mgt_rxdata(63 downto 48),
		rxcharisk    => mgt_rxcharisk(7 downto 6),
		rxp          => mgt_rx_l3_p,
		rxn          => mgt_rx_l3_n,
		enable_align => mgt_enable_align(3),
		syncok       => mgt_syncok(3),
		enchansync   => one,
		code_valid   => mgt_codevalid(7 downto 6),
		code_comma   => mgt_codecomma(7 downto 6),
		loopback_ser => mgt_loopback,
		powerdown    => mgt_powerdown,
		chbondi      => mgt_chbond,
		chbondo      => open,
		mgt_tx_reset => mgt_tx_reset(3),
		mgt_rx_reset => mgt_rx_reset(3)
	);

end architecture XAUI_interface_arch;
