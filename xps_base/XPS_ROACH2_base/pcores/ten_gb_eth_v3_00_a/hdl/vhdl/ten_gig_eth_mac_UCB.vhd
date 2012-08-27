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
--          names of its contributors may be used to endorse or --          products derived from this software without specific prior
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

--   #      ###    #####          #######
--  ##     #   #  #     #  #      #
-- # #    # #   # #        #      #
--   #    #  #  # #  ####  #####  #####
--   #    #   # # #     #  #    # #
--   #     #   #  #     #  #    # #
-- #####    ###    #####   #####  #######


-- 10GbEthernet core MAC

-- *********************************************************************
-- * THIS CORE IS INTENDED TO BE USED WITH THE UCB 10GB INTERFACE      *
-- * IT SUPPORTS ONLY A VERY LIMITED RANGE OF THE FUNCTIONALITIES      *
-- * THAT A REAL MAC SHOULD SUPPORT. FOR A FULL SUPPORT OF 10GB,       *
-- * USE THE XILINX MAC.                                               *
-- * NOT SUPPORTED:                                                    *
-- *   - no configuration                                              *
-- *   - no statistics vectors                                         *
-- *   - no CRC check on receive                                       *
-- *   - no interframe minimization                                    *
-- *   - supports only full words or 16 bits word at the input         *
-- *   - no flow control                                               *
-- *********************************************************************

-- created by Pierre-Yves Droz 2006

------------------------------------------------------------------------------
-- mac.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--library unisim;
--use unisim.all;

entity ten_gig_eth_mac_UCB is
	port (
		reset                : in  std_logic;
		tx_underrun          : in  std_logic;
		tx_data              : in  std_logic_vector(63 downto 0);
		tx_data_valid        : in  std_logic_vector(7 downto 0);
		tx_start             : in  std_logic;
		tx_ack               : out std_logic;
		tx_ifg_delay         : in  std_logic_vector(7 downto 0);
		tx_statistics_vector : out std_logic_vector(24 downto 0);
		tx_statistics_valid  : out std_logic;
		rx_data              : out std_logic_vector(63 downto 0);
		rx_data_valid        : out std_logic_vector(7 downto 0);
		rx_good_frame        : out std_logic;
		rx_bad_frame         : out std_logic;
		rx_statistics_vector : out std_logic_vector(28 downto 0);
		rx_statistics_valid  : out std_logic;
		pause_val            : in  std_logic_vector(15 downto 0);
		pause_req            : in  std_logic;
		configuration_vector : in  std_logic_vector(66 downto 0);
		tx_clk0              : in  std_logic;
		tx_dcm_lock          : in  std_logic;
		xgmii_txd            : out std_logic_vector(63 downto 0);
		xgmii_txc            : out std_logic_vector(7 downto 0);
		rx_clk0              : in  std_logic;
		rx_dcm_lock          : in  std_logic;
		xgmii_rxd            : in  std_logic_vector(63 downto 0);
		xgmii_rxc            : in  std_logic_vector(7 downto 0)
	);
end entity ten_gig_eth_mac_UCB;

architecture ten_gig_eth_mac_UCB_arch of ten_gig_eth_mac_UCB is

-- ######  #    #  #    #   ####    #####     #     ####   #    #   ####
-- #       #    #  ##   #  #    #     #       #    #    #  ##   #  #
-- #####   #    #  # #  #  #          #       #    #    #  # #  #   ####
-- #       #    #  #  # #  #          #       #    #    #  #  # #       #
-- #       #    #  #   ##  #    #     #       #    #    #  #   ##  #    #
-- #        ####   #    #   ####      #       #     ####   #    #   ####

-- bit reverse a signal
function byte_reverse (a: in std_logic_vector) return std_logic_vector is
	variable result: std_logic_vector(a'RANGE);
	alias    aa    : std_logic_vector(a'RANGE) is a;
begin
	for i in aa'RANGE loop
    result(i) := aa( (i/8)*8 + 7 - i mod 8 );
	end loop;
	return result;
end;

function bit_reverse (a: in std_logic_vector) return std_logic_vector is
	variable result: std_logic_vector(a'RANGE);
	alias    aa    : std_logic_vector(a'REVERSE_RANGE) is a;
begin
	for i in aa'RANGE loop
		result(i) := aa(i);
	end loop;
	return result;
end;

--Virtex-5 Hard CRC Macro

component CRC64
        generic
        (
                CRC_INIT : std_logic_vector := X"FFFFFFFF"
        );
        port
        (
                CRCOUT       : out std_logic_vector(31 downto 0);
                CRCCLK       : in std_ulogic;
                CRCDATAVALID : in std_ulogic;
                CRCDATAWIDTH : in std_logic_vector(2 downto 0);
                CRCIN        : in std_logic_vector(64-1 downto 0);
                CRCRESET     : in std_ulogic
        );
end component;


--  ####    ####   #    #   ####    #####
-- #    #  #    #  ##   #  #          #
-- #       #    #  # #  #   ####      #
-- #       #    #  #  # #       #     #
-- #    #  #    #  #   ##  #    #     #
--  ####    ####   #    #   ####      #

	type tx_fsm_state is (
			IDLE                 ,
			INTERFRAME           ,
			SEND_PREAMBLE        ,
			SEND_DATA            ,
			SEND_END_ALIGNED     ,
			SEND_END_NON_ALIGNED ,
			SEND_CORRUPTED_CRC   
		);

	type rx_fsm_state is (
			IDLE,
			WAIT_ONE,
			RECEIVE_DATA
		);


--  ####      #     ####   #    #    ##    #        ####
-- #          #    #    #  ##   #   #  #   #       #
--  ####      #    #       # #  #  #    #  #        ####
--      #     #    #  ###  #  # #  ######  #            #
-- #    #     #    #    #  #   ##  #    #  #       #    #
--  ####      #     ####   #    #  #    #  ######   ####

	-- TX controller signals
	signal tx_state                                : tx_fsm_state := IDLE;
	signal tx_state_z                              : tx_fsm_state := IDLE;
	signal tx_start_latched                        : std_logic := '0';
	signal xgmii_tx0                               : std_logic_vector(63 downto 0);

	signal xgmii_txd_int                           : std_logic_vector(63 downto 0);
	signal xgmii_txc_int                           : std_logic_vector( 7 downto 0);
	signal xgmii_txd_z                             : std_logic_vector(63 downto 0);
	signal xgmii_txc_z                             : std_logic_vector( 7 downto 0);
	signal xgmii_txd_zz                            : std_logic_vector(63 downto 0);
	signal xgmii_txc_zz                            : std_logic_vector( 7 downto 0);
  signal partial_crc_insert                      : std_logic;

	-- RX controller signals
	signal rx_state                                : rx_fsm_state := IDLE;
	signal xgmii_rxd0                              : std_logic_vector(63 downto 0);
	signal xgmii_rxc0                              : std_logic_vector(7 downto 0);
	signal xgmii_rxd_aligned                       : std_logic_vector(63 downto 0);
	signal xgmii_rxc_aligned                       : std_logic_vector(7 downto 0);
	signal xgmii_rxd_aligned0                      : std_logic_vector(63 downto 0);
	signal xgmii_rxc_aligned0                      : std_logic_vector(7 downto 0);
	signal rx_data_is_aligned                      : std_logic;
	signal rx_enable                               : std_logic_vector(7 downto 0);
	signal rx_good_frame0                          : std_logic;

  -- CRC Signals
  signal tx_crc_data                             : std_logic_vector(31 downto 0);
  signal tx_crc_data_revd                        : std_logic_vector(31 downto 0);
  signal tx_crc_width                            : std_logic_vector( 2 downto 0);
  signal tx_crc_reset                            : std_logic;

  signal tx_data_revd                            : std_logic_vector(63 downto 0);

begin

  TX_CRC : CRC64 generic map(
    CRC_INIT                => x"FFFFFFFF"
  ) port map (
    CRCOUT             =>   tx_crc_data,
    CRCCLK             =>   tx_clk0,
    CRCDATAVALID       =>   '1',
    CRCDATAWIDTH       =>   tx_crc_width,
    CRCIN              =>   tx_data_revd,
    CRCRESET           =>   tx_crc_reset
  );

  -- bit and byte reversal as required by core
  tx_data_revd     <= byte_reverse(bit_reverse(xgmii_tx0));
  tx_crc_data_revd <= bit_reverse(byte_reverse(tx_crc_data));


	-- statistic vectors are not supported
	rx_statistics_vector <= (others => '0');
	rx_statistics_valid  <= '0';
	tx_statistics_vector <= (others => '0');
	tx_statistics_valid  <= '0';

	--  #####  #    # 
	--    #     #  #  
	--    #      ##   
	--    #      ##   
	--    #     #  #  
	--    #    #    # 
	
	-- Transmit state machine
	tx_proc: process(tx_clk0)
	begin
		if tx_clk0'event and tx_clk0 = '1' then
      -- single cycle reset
      tx_crc_reset <= '0';
			-- register the data coming from the user
			xgmii_tx0 <= tx_data;

			if reset = '1' then
				tx_state         <= IDLE;
				tx_ack           <= '0';
				tx_start_latched <= '0';
			else
				-- single cycle active signals
				tx_ack   <= '0';

				-- latch tx_start when we receive it, until we can acknowledge the request
				if tx_start = '1' then
					tx_start_latched <= '1';
				end if;
				
				case tx_state is
					when IDLE            =>
						if tx_start = '1' or tx_start_latched = '1' then
							tx_ack   <= '1';		
							tx_start_latched <= '0';
							tx_state         <= SEND_PREAMBLE;
						end if;
					when SEND_PREAMBLE   =>
						tx_state <= SEND_DATA;
            -- reset the CRC macro, reset is asserted on same cycle as first data
            tx_crc_reset <= '1';
					when SEND_DATA       =>
						case tx_data_valid is
							when "11111111" =>
							when "00000000" =>
								tx_state         <= SEND_END_ALIGNED;
							when "00000011" =>
								tx_state         <= SEND_END_NON_ALIGNED;
							when others =>
								-- this version of the mac does not support any other enable pattern. if we receive an unsupported one then we send a shorter frame and corrupt the CRC.
								tx_state         <= SEND_CORRUPTED_CRC;

						end case;
					when SEND_END_ALIGNED       =>
						tx_state <= INTERFRAME;
					when SEND_END_NON_ALIGNED   =>
						tx_state <= INTERFRAME;
					when SEND_CORRUPTED_CRC     =>
						tx_state <= INTERFRAME;
					when INTERFRAME             =>
						tx_state <= IDLE;
					when others => 
				end case;
			
			end if;	


		end if;
	end process;

	-- Assign the data to be sent to the XGMII depending on the current state
	with tx_state select xgmii_txd_int <= 
		X"0707070707070707"                              when IDLE,
		X"0707070707070707"                              when INTERFRAME,
		X"D5555555555555FB"                              when SEND_PREAMBLE,
		xgmii_tx0                                        when SEND_DATA,
		X"070707FD" & X"00000000"                        when SEND_END_ALIGNED,
		X"07FD" & X"00000000" & xgmii_tx0(15 downto 0)   when SEND_END_NON_ALIGNED,
		X"070707FD" & X"00000000"                        when SEND_CORRUPTED_CRC,
		(others => '0')                                  when others;
	with tx_state select xgmii_txc_int <= 
		"11111111"                                       when IDLE,
		"11111111"                                       when INTERFRAME,
		"00000001"                                       when SEND_PREAMBLE,
		"00000000"                                       when SEND_DATA,
		"11110000"                                       when SEND_END_ALIGNED,
		"11000000"                                       when SEND_END_NON_ALIGNED,
		"11110000"                                       when SEND_CORRUPTED_CRC,
		(others => '0')                                  when others;	

  -- the data needs to be pipelined twice in order to compensate for extra latency due to the CRC macro
  -- the in the aligned case the CRC is inserted in the first pipe
  -- in the non-aligned case the CRC is inserted in the second pipe along with the outgoing data that has been crc'd
	xgmii_tx_buf: process(tx_clk0)
	begin
		if tx_clk0'event and tx_clk0 = '1' then
      -- signal cycle strobe
      partial_crc_insert <= '0';
      -- delay the control and data bits
	    xgmii_txc_z  <= xgmii_txc_int;
	    xgmii_txd_z  <= xgmii_txd_int;
	    xgmii_txc_zz <= xgmii_txc_z;
      tx_state_z   <= tx_state;
      if reset = '1' then
      else
				case tx_state_z is
					when SEND_END_ALIGNED       =>
	          xgmii_txd_zz <= xgmii_txd_z or (X"00000000" & tx_crc_data_revd);
					when SEND_CORRUPTED_CRC     =>
	          xgmii_txd_zz <= xgmii_txd_z or (X"00000000" & (tx_crc_data_revd xor X"00000001")) ;
					when others => 
	          xgmii_txd_zz <= xgmii_txd_z;
				end case;

        if tx_state_z = SEND_END_NON_ALIGNED then
          partial_crc_insert <= '1';
        end if;
      end if;
    end if;
  end process;

  tx_crc_width <= "001" when tx_state = SEND_END_NON_ALIGNED else "111";
  -- when state == SEND_END_NON_ALIGNED, xgmii_tx0 contains the 16bits of data

  xgmii_txc <= xgmii_txc_zz;
  xgmii_txd <= xgmii_txd_zz or (X"0000" & tx_crc_data_revd & X"0000") when partial_crc_insert = '1' else xgmii_txd_zz;
  -- slip in the CRC in the non-aligned case


	-- #####   #    #
	-- #    #   #  #
	-- #    #    ##
	-- #####     ##
	-- #   #    #  #
	-- #    #  #    #

	-- Receive state machine
	rx_proc: process(rx_clk0)
	begin
		if rx_clk0'event and rx_clk0 = '1' then
			if reset = '1' then
				rx_state           <= IDLE;
				rx_data_valid      <= (others => '0');
				rx_enable          <= "00000000";
				rx_data_is_aligned <= '1';
				rx_good_frame      <= '0';
				rx_good_frame0     <= '0';
				rx_bad_frame       <= '0';
			else
				-- register data and control
				xgmii_rxd0         <= xgmii_rxd;
				xgmii_rxc0         <= xgmii_rxc;
				xgmii_rxd_aligned0 <= xgmii_rxd_aligned;
				xgmii_rxc_aligned0 <= xgmii_rxc_aligned;

				-- defaults rx_enable to 0
				rx_enable          <= "00000000";

				-- defaults good and bad signals to 0
				rx_good_frame0     <= '0';
				rx_good_frame      <= rx_good_frame0;
				rx_bad_frame       <= '0';

				-- data to user
				rx_data       <= xgmii_rxd_aligned0;
				rx_data_valid <= rx_enable;

				case rx_state is
					when IDLE               =>
						if xgmii_rxd(7 downto 0) = X"FB" and xgmii_rxc(0) = '1' then
							rx_data_is_aligned <= '1';
							rx_state        <= RECEIVE_DATA;
						end if;
						if xgmii_rxd0(39 downto 32) = X"FB" and xgmii_rxc0(4) = '1' then
							rx_data_is_aligned <= '0';
							rx_state        <= RECEIVE_DATA;
						end if;
					when RECEIVE_DATA       =>
						rx_enable      <= "11111111";
						if xgmii_rxc_aligned /= "00000000" then
							rx_state          <= IDLE;
							rx_good_frame0    <= '1';
							rx_enable         <= "10101010";
							rx_data_valid     <= not(xgmii_rxc_aligned(3 downto 0)) & "1111";
							rx_enable         <= "0000" & not(xgmii_rxc_aligned(7 downto 4));
						end if;
					when others => 
				end case;
	
	
			end if;
		end if;
	end process;

	with rx_data_is_aligned select xgmii_rxd_aligned <=
		xgmii_rxd                                          when '1',
		xgmii_rxd(31 downto 0) & xgmii_rxd0(63 downto 32)  when '0',
		(others => '0')                                    when others;

	with rx_data_is_aligned select xgmii_rxc_aligned <=
		xgmii_rxc                                          when '1',
		xgmii_rxc(3 downto 0)  & xgmii_rxc0(7 downto 4)    when '0',
		(others => '0')                                    when others;


end architecture ten_gig_eth_mac_UCB_arch;
