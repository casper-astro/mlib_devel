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

--   #      ###    #####          #######
--  ##     #   #  #     #  #      #
-- # #    # #   # #        #      #
--   #    #  #  # #  ####  #####  #####
--   #    #   # # #     #  #    # #
--   #     #   #  #     #  #    # #
-- #####    ###    #####   #####  #######


-- 10GbEthernet core top level

-- created by Pierre-Yves Droz 2006
-- altered to support external mgts and wishbone interface -- David George 2008

------------------------------------------------------------------------------
-- ten_gb_eth.vhd
------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ten_gb_eth is
	generic(
		C_BASEADDR             : std_logic_vector	:= X"00000000";
		C_HIGHADDR             : std_logic_vector	:= X"0000FFFF";
		C_OPB_AWIDTH           : integer	:= 32;
		C_OPB_DWIDTH           : integer	:= 32;
    DEFAULT_FABRIC_MAC     : std_logic_vector := x"ffffffffffff";
    DEFAULT_FABRIC_IP      : std_logic_vector := x"ffffffff";
    DEFAULT_FABRIC_GATEWAY : std_logic_vector := x"ff";
    DEFAULT_FABRIC_PORT    : std_logic_vector := x"ffff";
    FABRIC_RUN_ON_STARTUP  : integer := 0;
		PREEMPHASYS            : string  := "4";
		SWING                  : string  := "800"
	);
	port (
		-- application clock
		clk                   : in  std_logic;
		-- application reset
		rst                   : in  std_logic;

		-- tx ports
		tx_valid              : in  std_logic                      := '0';
		tx_ack                : out std_logic;
		tx_end_of_frame       : in  std_logic                      := '0';
		tx_discard            : in  std_logic                      := '0';
		tx_data               : in  std_logic_vector(63 downto 0);
		tx_dest_ip            : in  std_logic_vector(31 downto 0);
		tx_dest_port          : in  std_logic_vector(15 downto 0);
		
		-- rx port
		rx_valid              : out std_logic;
		rx_ack                : in  std_logic                      := '0';
		rx_data               : out std_logic_vector(63 downto 0);
		rx_end_of_frame       : out std_logic;
		rx_size               : out std_logic_vector(15 downto 0);
		rx_source_ip          : out std_logic_vector(31 downto 0);
		rx_source_port        : out std_logic_vector(15 downto 0);

		-- status led
		led_up                : out std_logic;
		led_rx                : out std_logic;
		led_tx                : out std_logic;

    -- XAUI signals     
    xaui_clk              : in  std_logic;
    xaui_reset            : out std_logic;
    xaui_status           : in  std_logic_vector( 7 downto 0);
    xgmii_txd             : out std_logic_vector(63 downto 0);
    xgmii_txc             : out std_logic_vector( 7 downto 0);
    xgmii_rxd             : in  std_logic_vector(63 downto 0);
    xgmii_rxc             : in  std_logic_vector( 7 downto 0);

    -- mgt config signals     
    mgt_rxeqmix           : out std_logic_vector( 1 downto 0);
    mgt_rxeqpole          : out std_logic_vector( 3 downto 0);
    mgt_txpreemphasis     : out std_logic_vector( 2 downto 0);
    mgt_txdiffctrl        : out std_logic_vector( 2 downto 0);

		-- OPB attachment
		OPB_Clk	              : in	std_logic;
		OPB_Rst	              : in	std_logic;
		Sl_DBus	              : out	std_logic_vector(0 to C_OPB_DWIDTH-1);
		Sl_errAck	            : out	std_logic;
		Sl_retry	            : out	std_logic;
		Sl_toutSup	          : out	std_logic;
		Sl_xferAck	          : out	std_logic;
		OPB_ABus	            : in	std_logic_vector(0 to C_OPB_AWIDTH-1);
		OPB_BE	              : in	std_logic_vector(0 to C_OPB_DWIDTH/8-1);
		OPB_DBus	            : in	std_logic_vector(0 to C_OPB_DWIDTH-1);
		OPB_RNW	              : in	std_logic;
		OPB_select            : in	std_logic;
		OPB_seqAddr           : in	std_logic
	);
end entity ten_gb_eth;

architecture ten_gb_eth_arch of ten_gb_eth is

--  ####    ####   #    #   ####    #####
-- #    #  #    #  ##   #  #          #
-- #       #    #  # #  #   ####      #
-- #       #    #  #  # #       #     #
-- #    #  #    #  #   ##  #    #     #
--  ####    ####   #    #   ####      #

	type tx_fsm_state is (
			IDLE,
			SEND_HDR_WORD_1,
			SEND_HDR_WORD_2,
			SEND_HDR_WORD_3,
			SEND_HDR_WORD_4,
			SEND_HDR_WORD_5,
			SEND_HDR_WORD_6,
			SEND_DATA,
			SEND_LAST,
			SEND_CPU_DATA
		);

	type rx_fsm_state is (
			IDLE,
			RECEIVE_HDR_WORD_2,
			RECEIVE_HDR_WORD_3,
			RECEIVE_HDR_WORD_4,
			RECEIVE_HDR_WORD_5,
			RECEIVE_HDR_WORD_6,
			RECEIVE_DATA
		);

	type size_array is array (1 downto 0) of std_logic_vector(7 downto 0);

--  ####    ####   #    #  #####    ####   #    #  ######  #    #   #####   ####
-- #    #  #    #  ##  ##  #    #  #    #  ##   #  #       ##   #     #    #
-- #       #    #  # ## #  #    #  #    #  # #  #  #####   # #  #     #     ####
-- #       #    #  #    #  #####   #    #  #  # #  #       #  # #     #         #
-- #    #  #    #  #    #  #       #    #  #   ##  #       #   ##     #    #    #
--  ####    ####   #    #  #        ####   #    #  ######  #    #     #     ####

	-- 10 Gb Ethernet MAC (UCB)
	component ten_gig_eth_mac_UCB
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
	end component;

  attribute box_type : string;

	-- packet buffer
	component packet_buffer
		port (
			clka                            : in  std_logic;
			dina                            : in  std_logic_vector(64 downto 0);
			addra                           : in  std_logic_vector(10 downto 0);
			wea                             : in  std_logic_vector(0  downto 0);
			clkb                            : in  std_logic;
			addrb                           : in  std_logic_vector(10 downto 0);
			doutb                           : out std_logic_vector(64 downto 0)
		);
	end component;
  attribute box_type of packet_buffer: component is "user_black_box"; 

	component packet_buffer_cpu
		port (
			clka                            : in  std_logic;
			dina                            : in  std_logic_vector(63 downto 0);
			addra                           : in  std_logic_vector(8  downto 0);
			wea                             : in  std_logic_vector(0  downto 0);
			douta                           : out std_logic_vector(63 downto 0);
			clkb                            : in  std_logic;
			dinb                            : in  std_logic_vector(63 downto 0);
			addrb                           : in  std_logic_vector(8  downto 0);
			web                             : in  std_logic_vector(0  downto 0);
			doutb                           : out std_logic_vector(63 downto 0)
		);
	end component;
  attribute box_type of packet_buffer_cpu: component is "user_black_box"; 

	-- address_fifos
	component address_fifo
		port (
			din                             : in  std_logic_vector(63 downto 0);
			rd_clk                          : in  std_logic;
			rd_en                           : in  std_logic;
			valid                           : out std_logic;
			rst                             : in  std_logic;
			wr_clk                          : in  std_logic;
			wr_en                           : in  std_logic;
			dout                            : out std_logic_vector(63 downto 0);
			empty                           : out std_logic;
			full                            : out std_logic
		);
	end component;
  attribute box_type of address_fifo: component is "user_black_box"; 

	-- ARP cache
	component arp_cache
		port (
			clka                            : in  std_logic;
			dina                            : in  std_logic_vector(47 downto 0);
			addra                           : in  std_logic_vector( 7 downto 0);
			wea                             : in  std_logic_vector( 0 downto 0);
			douta                           : out std_logic_vector(47 downto 0);
			clkb                            : in  std_logic;
			dinb                            : in  std_logic_vector(47 downto 0);
			addrb                           : in  std_logic_vector( 7 downto 0);
			web                             : in  std_logic_vector( 0 downto 0);
			doutb                           : out std_logic_vector(47 downto 0)
		);
	end component;
  attribute box_type of arp_cache: component is "user_black_box"; 

	-- retimer
	component retimer
		generic(
			WIDTH                           : integer           := 32
		);
		port (
			src_clk                         : in  std_logic;
			src_data                        : in  std_logic_vector(WIDTH-1 downto 0);
			dest_clk                        : in  std_logic;
			dest_data                       : out std_logic_vector(WIDTH-1 downto 0);
			dest_new_data                   : out std_logic
		);
	end component;

	-- opb attachment
	component opb_attach
		generic(
	    C_BASEADDR             : std_logic_vector	:= X"00000000";
	    C_HIGHADDR             : std_logic_vector	:= X"0000FFFF";
	    C_OPB_AWIDTH           : integer	:= 32;
	    C_OPB_DWIDTH           : integer	:= 32;
      DEFAULT_FABRIC_MAC     : std_logic_vector := x"ffffffffffff";
      DEFAULT_FABRIC_IP      : std_logic_vector := x"ffffffff";
      DEFAULT_FABRIC_GATEWAY : std_logic_vector := x"ff";
      DEFAULT_FABRIC_PORT    : std_logic_vector := x"ffff";
      FABRIC_RUN_ON_STARTUP  : integer := 1;
      DEFAULT_RXEQMIX        : std_logic_vector := "00";
      DEFAULT_RXEQPOLE       : std_logic_vector := "0000";
      DEFAULT_TXPREEMPHASIS  : std_logic_vector := "000";
      DEFAULT_TXDIFFCTRL     : std_logic_vector := "100"
		);
		port (
			-- local configuration
			local_mac             : out std_logic_vector(47 downto 0);
			local_ip              : out std_logic_vector(31 downto 0);
			local_gateway         : out std_logic_vector( 7 downto 0);
			local_port            : out std_logic_vector(15 downto 0);
			local_valid           : out std_logic;

			-- tx buffer
			tx_buffer_data_in     : out std_logic_vector(63 downto 0);
			tx_buffer_address     : out std_logic_vector( 8 downto 0);
			tx_buffer_we          : out std_logic;
			tx_buffer_data_out    : in  std_logic_vector(63 downto 0);
			tx_cpu_buffer_size    : out std_logic_vector(7 downto 0) := (others => '0');
			tx_cpu_free_buffer    : in  std_logic := '0';
			tx_cpu_buffer_filled  : out std_logic; 
			tx_cpu_buffer_select  : in  std_logic := '0';

			-- rx buffer
			rx_buffer_data_in     : out std_logic_vector(63 downto 0);
			rx_buffer_address     : out std_logic_vector( 8 downto 0);
			rx_buffer_we          : out std_logic;
			rx_buffer_data_out    : in  std_logic_vector(63 downto 0);
			rx_cpu_buffer_size    : in  std_logic_vector( 7 downto 0);
			rx_cpu_new_buffer     : in  std_logic;
			rx_cpu_buffer_cleared : out std_logic;
			rx_cpu_buffer_select  : in  std_logic;

			-- ARP cache
			arp_cache_data_in     : out std_logic_vector(47 downto 0);
			arp_cache_address     : out std_logic_vector( 7 downto 0); 
			arp_cache_we          : out std_logic;                    
			arp_cache_data_out    : in  std_logic_vector(47 downto 0);
			
			-- PHY status
      phy_status            : in  std_logic_vector( 7 downto 0);

      --MGT/GTP PMA Config
      mgt_rxeqmix           : out std_logic_vector(1  downto 0);
      mgt_rxeqpole          : out std_logic_vector(3  downto 0);
      mgt_txpreemphasis     : out std_logic_vector(2  downto 0);
      mgt_txdiffctrl        : out std_logic_vector(2  downto 0);

			-- OPB attachment
	    OPB_Clk     : in	std_logic;
	    OPB_Rst     : in	std_logic;
	    Sl_DBus     : out	std_logic_vector(0 to C_OPB_DWIDTH-1);
	    Sl_errAck   : out	std_logic;
	    Sl_retry    : out	std_logic;
	    Sl_toutSup	: out	std_logic;
	    Sl_xferAck	: out	std_logic;
	    OPB_ABus	  : in	std_logic_vector(0 to C_OPB_AWIDTH-1);
	    OPB_BE	    : in	std_logic_vector(0 to C_OPB_DWIDTH/8-1);
	    OPB_DBus    : in	std_logic_vector(0 to C_OPB_DWIDTH-1);
	    OPB_RNW     : in	std_logic;
	    OPB_select  : in	std_logic;
	    OPB_seqAddr : in	std_logic
		);
	end component;

--  ####      #     ####   #    #    ##    #        ####
-- #          #    #    #  ##   #   #  #   #       #
--  ####      #    #       # #  #  #    #  #        ####
--      #     #    #  ###  #  # #  ######  #            #
-- #    #     #    #    #  #   ##  #    #  #       #    #
--  ####      #     ####   #    #  #    #  ######   ####

  -- MGT signals
  signal usr_reset_stretch                       : std_logic_vector(7 downto 0);
  signal xaui_reset_int                          : std_logic;
  signal xaui_reset_0                            : std_logic;
  signal xaui_reset_1                            : std_logic;
  signal xaui_reset_2                            : std_logic;
  signal xaui_reset_3                            : std_logic;

	-- PHY signals
	signal phy_rx_up                               : std_logic;

	-- MAC signals
	signal mac_flow_pause_val                      : std_logic_vector(15 downto 0);
	signal mac_flow_pause_req                      : std_logic;
	signal mac_configuration_vector                : std_logic_vector(66 downto 0);

	-- MAC <-> Buffers signals
	signal mac_tx_underrun                         : std_logic;
	signal mac_tx_data                             : std_logic_vector(63 downto 0);
	signal mac_tx_data_valid                       : std_logic_vector(7 downto 0) := (others => '0');
	signal mac_tx_start                            : std_logic := '0';
	signal mac_tx_ack                              : std_logic;
	signal mac_tx_ifg_delay                        : std_logic_vector(7 downto 0);
	signal mac_tx_statistics_vector                : std_logic_vector(24 downto 0);
	signal mac_tx_statistics_valid                 : std_logic;
	signal mac_rx_data                             : std_logic_vector(63 downto 0);
	signal mac_rx_data_R                           : std_logic_vector(63 downto 0);
	signal mac_rx_data_valid                       : std_logic_vector(7 downto 0);
	signal mac_rx_data_valid_R                     : std_logic_vector(7 downto 0);
	signal mac_rx_good_frame                       : std_logic;
	signal mac_rx_bad_frame                        : std_logic;
	signal mac_rx_statistics_vector                : std_logic_vector(28 downto 0);
	signal mac_rx_statistics_valid                 : std_logic;

	-- TX controller signals
	signal tx_state                                : tx_fsm_state := IDLE;
	signal tx_buffer_write_data                    : std_logic_vector(64 downto 0);
	signal tx_buffer_write_address                 : std_logic_vector(10 downto 0) := (others => '0');
  signal tx_buffer_full_pre                      : std_logic;
	signal tx_buffer_write_address_snapshot        : std_logic_vector(10 downto 0) := (others => '0');
	signal tx_buffer_we                            : std_logic_vector(0  downto 0);
	signal tx_buffer_read_address                  : std_logic_vector(10 downto 0) := (others => '0');
	signal tx_buffer_read_data                     : std_logic_vector(64 downto 0);
	signal tx_buffer_read_data_R                   : std_logic_vector(64 downto 0);
	signal tx_buffer_read_address_minusthree         : std_logic_vector(10 downto 0);
	signal tx_buffer_read_address_minusthree_retimed : std_logic_vector(10 downto 0);
	signal tx_buffer_new_read_address              : std_logic;
	signal tx_buffer_full                          : std_logic;
	signal tx_addrfifo_read_en                     : std_logic;
	signal tx_addrfifo_read_data                   : std_logic_vector(63 downto 0);
	signal tx_addrfifo_valid                       : std_logic;
	signal tx_addrfifo_empty                       : std_logic;
	signal tx_addrfifo_we                          : std_logic;
	signal tx_addrfifo_full                        : std_logic;
	signal tx_addrfifo_write_data                  : std_logic_vector(63 downto 0);
	signal tx_data_count                           : std_logic_vector(15 downto 0) := (others => '0');
	signal tx_ip_length                            : std_logic_vector(15 downto 0) := (others => '0');
	signal tx_udp_length                           : std_logic_vector(15 downto 0) := (others => '0');
	signal tx_ip_checksum_0                        : std_logic_vector(17 downto 0) := (others => '0');
	signal tx_ip_checksum_1                        : std_logic_vector(16 downto 0) := (others => '0');
	signal tx_ip_checksum                          : std_logic_vector(15 downto 0) := (others => '0');
	signal tx_ip_checksum_fixed_0                  : std_logic_vector(17 downto 0);
	signal tx_ip_checksum_fixed_1                  : std_logic_vector(16 downto 0);
	signal tx_ip_checksum_fixed                    : std_logic_vector(15 downto 0);
	signal tx_buffer_cpu_read_address              : std_logic_vector( 7 downto 0);
	signal tx_buffer_cpu_read_address_complete     : std_logic_vector( 8 downto 0);
	signal tx_buffer_cpu_read_address_sequential   : std_logic_vector( 7 downto 0);
	signal tx_buffer_cpu_read_data                 : std_logic_vector(63 downto 0);
	signal tx_cpu_free_buffer                      : std_logic;
	signal tx_cpu_buffer_filled                    : std_logic;
	signal tx_cpu_buffer_filled_pre                : std_logic;
	signal tx_cpu_got_ack                          : std_logic;
	signal tx_arp_cache_address                    : std_logic_vector( 7 downto 0);
	signal tx_arp_cache_read_data                  : std_logic_vector(47 downto 0);
	signal tx_cpu_buffer_sizes                     : size_array := (0=> X"00", 1=> X"00");
	signal tx_cpu_buffer_size                      : std_logic_vector( 7 downto 0) := (others => '0');
	signal tx_cpu_buffer_current                   : std_logic;
	signal tx_cpu_buffer_next                      : std_logic := '0';
	signal tx_cpu_buffer_valid                     : std_logic_vector( 1 downto 0) := "00";

	-- RX controller signals
	signal rx_state                                : rx_fsm_state := IDLE;
	signal rx_buffer_write_data                    : std_logic_vector(64 downto 0);
	signal rx_buffer_write_address                 : std_logic_vector(10 downto 0) := (others => '0');
	signal rx_buffer_write_address_R               : std_logic_vector(10 downto 0) := (others => '0');
	signal rx_buffer_write_address_snapshot        : std_logic_vector(10 downto 0) := (others => '0');
	signal rx_buffer_we                            : std_logic_vector(0  downto 0);
	signal rx_buffer_read_address                  : std_logic_vector(10 downto 0) := (others => '0');
	signal rx_buffer_read_address_sequential       : std_logic_vector(10 downto 0) := (others => '0');
	signal rx_buffer_read_data                     : std_logic_vector(64 downto 0);
	signal rx_buffer_read_address_minusone         : std_logic_vector(10 downto 0);
	signal rx_buffer_read_address_minusone_retimed : std_logic_vector(10 downto 0);
	signal rx_buffer_full                          : std_logic;
	signal rx_addrfifo_read_en                     : std_logic;
	signal rx_addrfifo_read_data                   : std_logic_vector(63 downto 0);
	signal rx_addrfifo_valid                       : std_logic;
	signal rx_addrfifo_we                          : std_logic;
	signal rx_addrfifo_full                        : std_logic;
	signal rx_addrfifo_write_data                  : std_logic_vector(63 downto 0) := (others => '0');
	signal rx_frame_valid_for_hardware             : std_logic := '0';
	signal rx_frame_valid_for_cpu                  : std_logic := '0';
	signal rx_valid_ack                            : std_logic;
	signal rx_destination_mac                      : std_logic_vector(47 downto 0);
	signal rx_destination_ip                       : std_logic_vector(31 downto 0);
	signal rx_destination_port                     : std_logic_vector(15 downto 0);
	signal rx_buffer_cpu_write_data                : std_logic_vector(63 downto 0);
	signal rx_buffer_cpu_write_address             : std_logic_vector(7 downto 0) := (others => '0');
	signal rx_buffer_cpu_write_address_complete    : std_logic_vector(8 downto 0);
	signal rx_buffer_cpu_we                        : std_logic_vector(0 downto 0);
	signal rx_cpu_buffer_cleared                   : std_logic;
	signal rx_cpu_buffer_cleared_pre               : std_logic;
	signal rx_cpu_new_buffer                       : std_logic;
	signal rx_cpu_buffer_sizes                     : size_array := (0=> X"00", 1=> X"00");
	signal rx_cpu_buffer_size                      : std_logic_vector( 7 downto 0) := (others => '0');
	signal rx_cpu_buffer_current                   : std_logic;
	signal rx_cpu_buffer_last                      : std_logic := '0';
	signal rx_cpu_buffer_valid                     : std_logic_vector(1 downto 0) := "00";
  signal rx_got_prefetch                         : std_logic;
  signal rx_buffer_read_dataR                    : std_logic_vector(64 downto 0);
  signal rx_addrfifo_read_dataR                  : std_logic_vector(63 downto 0);

	-- CPU signals
	signal local_mac                               : std_logic_vector(47 downto 0);
	signal local_ip                                : std_logic_vector(31 downto 0);
	signal local_gateway                           : std_logic_vector( 7 downto 0);
	signal local_port                              : std_logic_vector(15 downto 0);
	signal local_valid                             : std_logic;
	signal local_valid_retimed                     : std_logic;
	signal cpu_tx_buffer_data_in                   : std_logic_vector(63 downto 0);
	signal cpu_tx_buffer_address                   : std_logic_vector( 8 downto 0);
	signal cpu_tx_buffer_we                        : std_logic_vector( 0 downto 0);
	signal cpu_tx_buffer_data_out                  : std_logic_vector(63 downto 0);
	signal cpu_tx_cpu_free_buffer                  : std_logic;
	signal cpu_tx_cpu_free_buffer_pre              : std_logic;
	signal cpu_tx_cpu_buffer_size                  : std_logic_vector(7 downto 0);
	signal cpu_tx_cpu_buffer_filled                : std_logic;
	signal cpu_tx_cpu_buffer_select                : std_logic;
	signal cpu_rx_buffer_data_in                   : std_logic_vector(63 downto 0);
	signal cpu_rx_buffer_address                   : std_logic_vector( 8 downto 0);
	signal cpu_rx_buffer_we                        : std_logic_vector( 0 downto 0);
	signal cpu_rx_buffer_data_out                  : std_logic_vector(63 downto 0);
	signal cpu_rx_cpu_new_buffer                   : std_logic;
	signal cpu_rx_cpu_new_buffer_pre               : std_logic;
	signal cpu_rx_cpu_buffer_size                  : std_logic_vector(7 downto 0) := (others => '0');
	signal cpu_rx_cpu_buffer_cleared               : std_logic;
	signal cpu_rx_cpu_buffer_select                : std_logic;
	signal cpu_arp_cache_data_in                   : std_logic_vector(47 downto 0);
	signal cpu_arp_cache_address                   : std_logic_vector( 7 downto 0); 
	signal cpu_arp_cache_we                        : std_logic_vector( 0 downto 0);                    
	signal cpu_arp_cache_data_out                  : std_logic_vector(47 downto 0);


	-- LEDs signals
	signal led_rx_count                            : std_logic_vector(23 downto 0) := (others => '0');
	signal led_tx_count                            : std_logic_vector(23 downto 0) := (others => '0');
	signal led_rx_1                                : std_logic := '0';
	signal led_tx_1                                : std_logic := '0';

	-- constraints
	attribute keep                                 : string;
	attribute keep of rx_cpu_buffer_cleared_pre    : signal is "true";
	attribute keep of cpu_rx_cpu_new_buffer_pre    : signal is "true";
	attribute keep of tx_cpu_buffer_filled_pre     : signal is "true";
	attribute keep of cpu_tx_cpu_free_buffer_pre   : signal is "true";

begin
 
-- #####   ######   ####   ######   #####
-- #    #  #       #       #          #
-- #    #  #####    ####   #####      #
-- #####   #            #  #          #
-- #   #   #       #    #  #          #
-- #    #  ######   ####   ######     #

-- generate an internal version of the reset

usr_reset_proc: process(clk)
begin
	if clk'event and clk = '1' then
    if rst = '1' then
    	usr_reset_stretch <= X"FF";
    else
    	usr_reset_stretch <= usr_reset_stretch(6 downto 0) & '0' ;
    end if;
  end if;
end process;

reset_proc: process(xaui_clk)
begin
	if xaui_clk'event and xaui_clk = '1' then
		if usr_reset_stretch(7) = '1' then
			xaui_reset_int <= '1';
			xaui_reset_0   <= '1';
			xaui_reset_1   <= '1';
			xaui_reset_2   <= '1';
			xaui_reset_3   <= '1';
		else
			xaui_reset_int <= xaui_reset_0;
			xaui_reset_0   <= xaui_reset_1;
			xaui_reset_1   <= xaui_reset_2;
			xaui_reset_2   <= xaui_reset_3;
			xaui_reset_3   <= '0';
		end if;
	end if;
end process;
xaui_reset <= xaui_reset_int;

--  #####  #    #           ####    #####  #####   #
--    #     #  #           #    #     #    #    #  #
--    #      ##            #          #    #    #  #
--    #      ##            #          #    #####   #
--    #     #  #           #    #     #    #   #   #
--    #    #    #           ####      #    #    #  ######

-- transmit data buffer
tx_buffer: packet_buffer
	port map (
		clka     => clk,
		dina     => tx_buffer_write_data,
		addra    => tx_buffer_write_address,
		wea      => tx_buffer_we,
		
		clkb     => xaui_clk,
		addrb    => tx_buffer_read_address,
		doutb    => tx_buffer_read_data
	);

-- transmit CPU data buffer
tx_buffer_cpu: packet_buffer_cpu
	port map (
		clka     => OPB_Clk,
		dina     => cpu_tx_buffer_data_in,
		addra    => cpu_tx_buffer_address,
		wea      => cpu_tx_buffer_we,
		douta    => cpu_tx_buffer_data_out,
		
		clkb     => xaui_clk,
		dinb     => X"0000000000000000",
		addrb    => tx_buffer_cpu_read_address_complete,
		web      => "0",
		doutb    => tx_buffer_cpu_read_data
	);

-- transmit address fifo
tx_address_fifo: address_fifo
	port map (
		rst      => rst,

		rd_clk   => xaui_clk,
		rd_en    => tx_addrfifo_read_en,
		dout     => tx_addrfifo_read_data,
		valid    => tx_addrfifo_valid,
		empty    => tx_addrfifo_empty,
		
		wr_clk   => clk,
		wr_en    => tx_addrfifo_we,
		full     => tx_addrfifo_full,
		din      => tx_addrfifo_write_data
	);

-- read address retimer
tx_read_address_retimer: retimer
	generic map (
		WIDTH     => 11
	)
	port map (
		src_clk       => xaui_clk,
		src_data      => tx_buffer_read_address_minusthree,
		dest_clk      => clk,
		dest_data     => tx_buffer_read_address_minusthree_retimed,
		dest_new_data => tx_buffer_new_read_address
	);

-- ARP cache
tx_arp_cache: arp_cache
	port map (
		clka      => OPB_Clk,
		dina      => cpu_arp_cache_data_in,
		addra     => cpu_arp_cache_address,
		wea       => cpu_arp_cache_we,
		douta     => cpu_arp_cache_data_out,
		
		clkb      => xaui_clk,
		dinb      => X"000000000000",
		addrb     => tx_arp_cache_address,
		web       => "0",
		doutb     => tx_arp_cache_read_data
	);

-- *
-- * USER side
-- *

-- transmit user clock controller process

tx_user_proc: process(clk)
begin
	if clk'event and clk = '1' then
    if tx_buffer_write_address = tx_buffer_read_address_minusthree_retimed then
      tx_buffer_full_pre <= '1';
    else
      tx_buffer_full_pre <= '0';
    end if;
		if rst = '1' then
			tx_buffer_write_address          <= (others => '0');
			tx_buffer_write_address_snapshot <= (others => '0');
			tx_data_count                    <= (0 => '1', others => '0');
			tx_buffer_full                   <= '0';
		else
			-- the read counter advanced, so we can bring the full bit back to 0
			if tx_buffer_new_read_address = '1' then
				tx_buffer_full <= '0';
			end if;
			-- a valid write was issued
			if tx_valid = '1' and tx_buffer_full = '0' and tx_discard = '0' then
--			if tx_valid = '1' and tx_addrfifo_full = '0' and tx_buffer_full = '0' and tx_discard = '0' then
				-- increment the write counter
				tx_buffer_write_address <= tx_buffer_write_address + 1;
				-- the transmit buffer will be full on the next cycle whenever the write address is two slots behind the read address
				if tx_buffer_full_pre = '1' then
					tx_buffer_full <= '1';
				end if;
				-- increment the data count
				tx_data_count <= tx_data_count + 1;				
				-- a request to send the packet was issued
				if tx_end_of_frame = '1' then
					-- reset the data count
					tx_data_count <= (0 => '1', others => '0');
					-- snapshot the write address to be able to cancel the next packet
					tx_buffer_write_address_snapshot <= tx_buffer_write_address + 1;
				end if;
			end if;
			-- a packet was discarded
			if tx_discard = '1' then
					tx_buffer_write_address          <= tx_buffer_write_address_snapshot;
					tx_data_count                    <= (0=> '1', others => '0');
			end if;
		end if;
	end if;
end process;

-- the data we write to the buffer is directly the data given by the user plus the end of frame bit
tx_buffer_write_data                <= tx_end_of_frame & tx_data;
-- the transmit buffer can always be written as the write address always points to an empty slot
tx_buffer_we                        <= "1";
-- we ack the data whenever neither the address fifo nor the buffer is full and we received valid data
tx_ack                              <= '1' when tx_addrfifo_full = '0' and tx_buffer_full = '0' and tx_valid = '1' else '0';
-- complete cpu buffer address with buffer selection
tx_buffer_cpu_read_address_complete <= tx_cpu_buffer_current & tx_buffer_cpu_read_address;
-- we write data in the address fifo whenever we get a valid end of frame write
tx_addrfifo_we                      <= '1' when tx_addrfifo_full = '0' and tx_buffer_full = '0' and tx_end_of_frame = '1' and tx_discard = '0' and tx_valid = '1' else '0';
-- address and port are packed in the address fifo
tx_addrfifo_write_data              <= tx_data_count & tx_dest_port & tx_dest_ip;

-- *
-- * MAC side
-- *

-- transmit xgmii clock controller process
tx_xgmii_proc: process(xaui_clk)
begin
	if xaui_clk'event and xaui_clk = '1' then
		-- register the data signals coming from the packet buffer
		tx_buffer_read_data_R <= tx_buffer_read_data;
		-- state machine		
		if xaui_reset_int = '1' then
			tx_state                              <= IDLE;
			mac_tx_data_valid                     <= (others => '0');
			tx_buffer_read_address                <= (others => '0');
			tx_buffer_cpu_read_address_sequential <= (others => '0');
			tx_ip_length                          <= (others => '0');
			tx_ip_checksum                        <= (others => '0');
			tx_ip_checksum_0                      <= (others => '0');
			tx_udp_length                         <= (others => '0');
			tx_cpu_free_buffer                    <= '0';
			tx_cpu_buffer_current                 <= '0';
			tx_cpu_got_ack                        <= '0';
		else

			-- *
			-- * CPU Handshake			
			-- *
			-- 4-way handshake with the OPB interface
			-- if the current buffer is empty, we can swap the buffers and notify the CPU
			if tx_cpu_free_buffer = '0' and tx_cpu_buffer_filled = '0' and tx_cpu_buffer_valid(CONV_INTEGER(tx_cpu_buffer_current)) = '0' then
				tx_cpu_free_buffer        <= '1';
				tx_cpu_buffer_current     <= not tx_cpu_buffer_current;
				tx_cpu_buffer_next        <= tx_cpu_buffer_current;
			end if;
			-- if the CPU tells us that it is done with the buffer that it was filling then we flag it as valid
			if tx_cpu_free_buffer = '1' and tx_cpu_buffer_filled = '1' then
				tx_cpu_free_buffer        <= '0';
				tx_cpu_buffer_sizes(CONV_INTEGER(not tx_cpu_buffer_current)) <= tx_cpu_buffer_size;
				tx_cpu_buffer_valid(CONV_INTEGER(not tx_cpu_buffer_current)) <= '1';
			end if;

			-- *
			-- * Buffer control/packetization state machine
			-- *
			case tx_state is
				when IDLE            =>
					-- if the address fifo has anything for us and the local parameters are valid, we can safely assume that there is also data in the buffer and start a frame transmission
--					if tx_addrfifo_valid = '1' and local_valid_retimed = '1' then
					if tx_addrfifo_empty = '0' and local_valid_retimed = '1' then
						-- the request for the MAC is done by combinatorial logic
						tx_state          <= SEND_HDR_WORD_1;							
						mac_tx_data_valid <= "11111111";
					end if;
					-- if the current cpu buffer is valid, we can start a frame transmission
					if tx_cpu_buffer_valid(CONV_INTEGER(tx_cpu_buffer_current)) = '1' then
						-- the request for the MAC is done by combinatorial logic
						tx_state          <= SEND_CPU_DATA;			
						mac_tx_data_valid <= "11111111";
					end if;
				when SEND_HDR_WORD_1 =>
					-- if the MAC is ready then we can send the rest of the header and the data
					if mac_tx_ack = '1' then
						tx_state          <= SEND_HDR_WORD_2;
					end if;
				when SEND_HDR_WORD_2 =>
					-- we can automatically jump to the next state
					tx_state          <= SEND_HDR_WORD_3;
				when SEND_HDR_WORD_3 =>
					-- we can automatically jump to the next state
					tx_state          <= SEND_HDR_WORD_4;
				when SEND_HDR_WORD_4 =>
					-- we can automatically jump to the next state
					tx_state          <= SEND_HDR_WORD_5;
				when SEND_HDR_WORD_5 =>
					-- we can automatically jump to the next state
					tx_state          <= SEND_HDR_WORD_6;
					-- we can start incrementing the packet buffer address
					tx_buffer_read_address  <= tx_buffer_read_address + 1;
				when SEND_HDR_WORD_6 =>
					-- we can automatically jump to the next state
					tx_state          <= SEND_DATA;
					-- if we reach the end of the frame then we send the last bytes and then we go back to idle
					if tx_buffer_read_data(64) = '1' then
						tx_state          <= SEND_LAST;
						mac_tx_data_valid <= "00000011";
					else
						-- increment the packet buffer address
						tx_buffer_read_address  <= tx_buffer_read_address + 1;
					end if;
				when SEND_DATA =>
					-- if we reach the end of the frame then we send the last bytes and then we go back to idle
					if tx_buffer_read_data(64) = '1' then
						tx_state          <= SEND_LAST;
						mac_tx_data_valid <= "00000011";
					else
						-- increment the packet buffer address
						tx_buffer_read_address  <= tx_buffer_read_address + 1;
					end if;
				when SEND_LAST =>
					-- we can automatically jump back to the IDLE state
					tx_state          <= IDLE;
					mac_tx_data_valid <= "00000000";
				when SEND_CPU_DATA =>
					if mac_tx_ack = '1' or tx_cpu_got_ack = '1' then
						if tx_buffer_cpu_read_address /= tx_cpu_buffer_size then
							tx_cpu_got_ack     <= '1';
							tx_buffer_cpu_read_address_sequential <= tx_buffer_cpu_read_address;
						else
							tx_cpu_got_ack        <= '0';
							tx_state              <= IDLE;
							mac_tx_data_valid     <= "00000000";
							tx_cpu_buffer_valid(CONV_INTEGER(tx_cpu_buffer_current)) <= '0';
							tx_buffer_cpu_read_address_sequential <= (others => '0');
						end if;
					end if;
			end case;
			-- compute the ip length
			tx_ip_length <= (tx_addrfifo_read_data(60 downto 48) & "000") + 28;
			-- compute the udp length
			tx_udp_length <= (tx_addrfifo_read_data(60 downto 48) & "000") + 8;
			-- compute the ip checksum (1's complement logic)
			tx_ip_checksum_0 <= ("00" & tx_ip_checksum_fixed                        )+
			                    ("00" & tx_ip_length                                )+
			                    ("00" & tx_addrfifo_read_data(31 downto 16)         )+
			                    ("00" & tx_addrfifo_read_data(15 downto 0)          );
			tx_ip_checksum_1 <= ("0"  & tx_ip_checksum_0(15 downto 0)               )+
			                    ("000000000000000" & tx_ip_checksum_0(17 downto 16) );
			tx_ip_checksum   <= not (
			                    (tx_ip_checksum_1(15 downto 0)                      )+
			                    ("000000000000000" & tx_ip_checksum_1(16)           ));

		end if;
	end if;
end process;

-- if we are IDLE and the address fifo has anything in stock we can issue a request for frame transmission to the MAC
mac_tx_start          <= '1' when tx_state = IDLE and ((tx_addrfifo_empty = '0' and local_valid_retimed = '1') or (tx_cpu_buffer_valid(CONV_INTEGER(tx_cpu_buffer_current)) = '1')) else '0';
-- ath the end of a frame transmission, we can ack the adress from the address fifo
tx_addrfifo_read_en   <= '1' when tx_state = SEND_LAST else '0';
-- substracts 2 to the read address before sending it to the retimer
tx_buffer_read_address_minusthree <= tx_buffer_read_address - 3;
-- selects what should be sent to the mac depending on the controller state
with tx_state select mac_tx_data <= 
		local_mac(39 downto 32) & local_mac(47 downto 40) &
                tx_arp_cache_read_data(7 downto 0) & tx_arp_cache_read_data(15 downto 8) &
                tx_arp_cache_read_data(23 downto 16) & tx_arp_cache_read_data(31 downto 24) &
                tx_arp_cache_read_data(39 downto 32) & tx_arp_cache_read_data(47 downto 40)
                       when SEND_HDR_WORD_1,
		X"00" & X"45" &
                X"00" & X"08" &
                local_mac(7 downto 0) & local_mac(15 downto 8) &
                local_mac(23 downto 16) & local_mac(31 downto 24) 
                        when SEND_HDR_WORD_2,
		X"11" & X"FF" &
                X"00" & X"40" &
                X"00" & X"00" &
                tx_ip_length(7 downto 0) & tx_ip_length(15 downto 8)
                        when SEND_HDR_WORD_3,
		tx_addrfifo_read_data(23 downto 16) & tx_addrfifo_read_data(31 downto 24) &
                local_ip(7 downto 0) & local_ip(15 downto 8) &
                local_ip(23 downto 16) & local_ip(31 downto 24) &
                tx_ip_checksum(7 downto 0) & tx_ip_checksum(15 downto 8)
                        when SEND_HDR_WORD_4,
		tx_udp_length(7 downto 0) & tx_udp_length(15 downto 8) &
                tx_addrfifo_read_data(39 downto 32) & tx_addrfifo_read_data(47 downto 40) &
                local_port(7 downto 0) & local_port(15 downto 8) &
                tx_addrfifo_read_data(7 downto 0) & tx_addrfifo_read_data(15 downto 8)
                        when SEND_HDR_WORD_5,
		tx_buffer_read_data(23 downto 16) & tx_buffer_read_data(31 downto 24) &
                tx_buffer_read_data(39 downto 32) & tx_buffer_read_data(47 downto 40) &
                tx_buffer_read_data(55 downto 48) & tx_buffer_read_data(63 downto 56) &
                X"00" & X"00"
                        when SEND_HDR_WORD_6,
		tx_buffer_read_data(23 downto 16) & tx_buffer_read_data(31 downto 24) &
                tx_buffer_read_data(39 downto 32) & tx_buffer_read_data(47 downto 40) &
                tx_buffer_read_data(55 downto 48) & tx_buffer_read_data(63 downto 56) &
                tx_buffer_read_data_R(7 downto 0) & tx_buffer_read_data_R(15 downto 8)   
                        when SEND_DATA,
		X"00" & X"00" &
                X"00" & X"00" &
                X"00" & X"00" &
                tx_buffer_read_data_R(7 downto 0) & tx_buffer_read_data_R(15 downto 8)
                        when SEND_LAST,
		tx_buffer_cpu_read_data(7 downto 0) & tx_buffer_cpu_read_data(15 downto 8) &
                tx_buffer_cpu_read_data(23 downto 16) & tx_buffer_cpu_read_data(31 downto 24) &
                tx_buffer_cpu_read_data(39 downto 32) & tx_buffer_cpu_read_data(47 downto 40) &
                tx_buffer_cpu_read_data(55 downto 48) & tx_buffer_cpu_read_data(63 downto 56) 
                        when SEND_CPU_DATA,
		(others => '0')
                        when others;
-- compute the fixed part of the ip checksum (1's complement logic)
tx_ip_checksum_fixed_0 <= ("00" & X"8412"                                           )+ 
                          ("00" & local_ip(31 downto 16)                            )+ 
                          ("00" & local_ip(15 downto 0)                             );
tx_ip_checksum_fixed_1 <= ("0" & tx_ip_checksum_fixed_0(15 downto 0)                )+
                          ("000000000000000" & tx_ip_checksum_fixed_0(17 downto 16) );
tx_ip_checksum_fixed   <= (tx_ip_checksum_fixed_1(15 downto 0)                      )+
                          ("000000000000000" & tx_ip_checksum_fixed_1(16)           );
-- compute the cpu buffer read address using combinatorial logic to be able to increment it within the cycle where the first data gets acked
tx_buffer_cpu_read_address <= tx_buffer_cpu_read_address_sequential + 1 when (mac_tx_ack = '1' or tx_cpu_got_ack = '1') else tx_buffer_cpu_read_address_sequential;
-- if the address is not part of the subnet (255.255.255.0), then we use the gateway address for the ARP request, otherwise, we use the last bits of the destination address.
tx_arp_cache_address <= local_gateway when tx_addrfifo_read_data(31 downto 8) /= local_ip(31 downto 8) else tx_addrfifo_read_data(7 downto 0);

-- #####   #    #           ####    #####  #####   #
-- #    #   #  #           #    #     #    #    #  #
-- #    #    ##            #          #    #    #  #
-- #####     ##            #          #    #####   #
-- #   #    #  #           #    #     #    #   #   #
-- #    #  #    #           ####      #    #    #  ######

-- receive data buffer
rx_buffer: packet_buffer
	port map (
		clka     => xaui_clk,
		dina     => rx_buffer_write_data,
		addra    => rx_buffer_write_address_R,
		wea      => rx_buffer_we,
		
		clkb     => clk,
		addrb    => rx_buffer_read_address,
		doutb    => rx_buffer_read_data
	);

---- receive CPU data buffer
rx_buffer_cpu: packet_buffer_cpu
	port map (
		clka     => xaui_clk,
		dina     => rx_buffer_cpu_write_data,
		addra    => rx_buffer_cpu_write_address_complete,
		wea      => rx_buffer_cpu_we,
		douta    => open,

		clkb     => OPB_Clk,
		dinb     => cpu_rx_buffer_data_in,
		addrb    => cpu_rx_buffer_address,
		web      => cpu_rx_buffer_we,
		doutb    => cpu_rx_buffer_data_out
	);

-- receive address fifos
rx_address_fifo: address_fifo
	port map (
		rst      => rst,

		rd_clk   => clk,
		rd_en    => rx_addrfifo_read_en,
		dout     => rx_addrfifo_read_data,
		valid    => rx_addrfifo_valid,
		
		wr_clk   => xaui_clk,
		wr_en    => rx_addrfifo_we,
		full     => rx_addrfifo_full,
		din      => rx_addrfifo_write_data

	);

-- read address retimer
rx_read_address_retimer: retimer
	generic map (
		WIDTH     => 11
	)
	port map (
		src_clk       => clk,
		src_data      => rx_buffer_read_address_minusone,
		dest_clk      => xaui_clk,
		dest_data     => rx_buffer_read_address_minusone_retimed,
		dest_new_data => open
	);

-- *
-- * USER side
-- *

-- receive user clock controller process
rx_user_proc: process(clk)
begin
	if clk'event and clk = '1' then
		if rst = '1' then
			rx_buffer_read_address_sequential <= (others => '0');
      rx_got_prefetch <= '0';
		else
			-- increment the read counter
			rx_buffer_read_address_sequential <= rx_buffer_read_address;

      if rx_got_prefetch = '0' then
        if rx_addrfifo_valid = '1' then
          rx_got_prefetch <= '1';
          rx_buffer_read_dataR <= rx_buffer_read_data;
          rx_addrfifo_read_dataR <= rx_addrfifo_read_data;
        end if;
      else -- if rx_got_prefetch = '1'
        if rx_ack = '1' then
          rx_buffer_read_dataR <= rx_buffer_read_data;
        end if;
        if rx_ack = '1' and rx_buffer_read_dataR(64) = '1' then
          if rx_addrfifo_valid = '0' then
            rx_got_prefetch <= '0';
          else
            rx_addrfifo_read_dataR <= rx_addrfifo_read_data;
          end if;
        end if;
      end if;
		end if;
	end if;
end process;

-- the read address is computed using combinatorial logic to implement first-word-fall-through
rx_valid_ack           <= '1' when (rx_got_prefetch = '0' and rx_addrfifo_valid = '1') or
                                   (rx_got_prefetch = '1' and rx_ack = '1' and (rx_buffer_read_dataR(64) = '0' or rx_addrfifo_valid = '1'))
                              else '0';
rx_buffer_read_address <= rx_buffer_read_address_sequential + ("0000000000" & rx_valid_ack);
-- the data we read from the buffer contains the data going to the user plus the start of frame bit
rx_data                         <= rx_buffer_read_dataR(63 downto 0);
rx_end_of_frame                 <= rx_buffer_read_dataR(64);
-- the interface is empty whenever the address fifo is empty
rx_valid                        <= '1' when rx_got_prefetch = '1' else '0';

-- we ack data from the address fifo whenever we get a valid end of frame read
rx_addrfifo_read_en             <= '1' when (rx_addrfifo_valid = '1' and rx_got_prefetch = '0') or
                                            (rx_addrfifo_valid = '1' and rx_got_prefetch = '1' and rx_buffer_read_dataR(64) = '1' and rx_ack = '1') 
                                       else '0';
-- we get both address and type from the address fifo
rx_size                         <= rx_addrfifo_read_dataR(63 downto 48);
rx_source_port                  <= rx_addrfifo_read_dataR(47 downto 32);
rx_source_ip                    <= rx_addrfifo_read_dataR(31 downto  0);

-- substracts 1 to the read address before sending it to the retimer
rx_buffer_read_address_minusone <= rx_buffer_read_address - 2;

-- *
-- * MAC side
-- *

-- receive xgmii clock controller process
rx_xgmii_proc: process(xaui_clk)
begin
	if xaui_clk'event and xaui_clk = '1' then
		-- register the data signals coming from the MAC
		mac_rx_data_R       <= mac_rx_data;
		mac_rx_data_valid_R <= mac_rx_data_valid;
		-- register the write buffer address
		rx_buffer_write_address_R <= rx_buffer_write_address;
		-- make sure the fifo write enable is default low
		rx_addrfifo_we <= '0';
		-- state machine		
		if xaui_reset_int = '1' then
			rx_state                         <= IDLE;
			rx_buffer_write_address          <= (others => '0');
			rx_buffer_write_address_R        <= (others => '0');
			rx_addrfifo_we                   <= '0';
			rx_cpu_buffer_current            <= '0';
			rx_buffer_cpu_write_address      <= (others => '0');
			rx_cpu_new_buffer                <= '0';
		else
			-- *
			-- * CPU Handshake			
			-- *
			-- 4-way handshake with the CPU interface
			-- if the current buffer is valid and the CPU is done working with its buffer, then we can swap the buffers and tell the CPU
			if rx_cpu_new_buffer = '0' and rx_cpu_buffer_cleared = '0' and rx_cpu_buffer_valid(CONV_INTEGER(rx_cpu_buffer_current)) = '1' then
				rx_cpu_new_buffer         <= '1';
				rx_cpu_buffer_size        <= rx_cpu_buffer_sizes(CONV_INTEGER(rx_cpu_buffer_current));
				rx_cpu_buffer_last        <= rx_cpu_buffer_current;
				rx_cpu_buffer_current     <= not rx_cpu_buffer_current;
			end if;
			-- if the CPU tells us that it is done with the buffer it was processing then we can flag it as unvalid
			if rx_cpu_new_buffer = '1' and rx_cpu_buffer_cleared = '1' then
				rx_cpu_new_buffer         <= '0';
				rx_cpu_buffer_valid(CONV_INTEGER(not rx_cpu_buffer_current)) <= '0';
			end if;
			-- *
			-- * CPU Buffer control state machine			
			-- *
			if mac_rx_data_valid /= "00000000" then
				-- if we reach the ethernet MTU (1500 bytes + 14 bytes header), we stop recording and corrupt the frame
				if rx_buffer_cpu_write_address = X"BE" then
					rx_frame_valid_for_cpu <= '0';					
				else
					-- increment the address counter
					rx_buffer_cpu_write_address <= rx_buffer_cpu_write_address + 1;		
				end if;
				-- if we skipped any data then we corrupt the frame
				if rx_buffer_cpu_we = "0" then
					rx_frame_valid_for_cpu <= '0';
				end if;
			end if;
			if mac_rx_good_frame = '1' and rx_frame_valid_for_cpu = '1' and rx_frame_valid_for_hardware = '0' then
				-- ok, this frame is good, we can flag it as valid
				rx_cpu_buffer_valid(CONV_INTEGER(rx_cpu_buffer_current)) <= '1';
				-- store the size for this buffer, we need to make sure we account for a possible partial word on this cycle
				if mac_rx_data_valid /= "00000000" then
					rx_cpu_buffer_sizes(CONV_INTEGER(rx_cpu_buffer_current)) <= rx_buffer_cpu_write_address + 1;
				else
					rx_cpu_buffer_sizes(CONV_INTEGER(rx_cpu_buffer_current)) <= rx_buffer_cpu_write_address;				
				end if;
			end if;
			if (mac_rx_good_frame = '1' or mac_rx_bad_frame = '1') then
				-- zero the reception address to prepare it for the next frame
				rx_buffer_cpu_write_address <= (others => '0');
			end if;
			-- *
			-- * Hardware Buffer control/depacketization state machine			
			-- *
			case rx_state is
				when IDLE            =>
					-- at first we assume that the frame will be acceptable by both the CPU and the hardware
					rx_frame_valid_for_cpu         <= '1';
					rx_frame_valid_for_hardware    <= '1';
					-- if we receive a valid word from the mac we start a frame reception
					if mac_rx_data_valid = "11111111" and phy_rx_up = '1' then
						rx_state                             <= RECEIVE_HDR_WORD_2;
						-- store the source address
						rx_addrfifo_write_data(47 downto 40) <= mac_rx_data(55 downto 48);
						rx_addrfifo_write_data(39 downto 32) <= mac_rx_data(63 downto 56);
						-- we snapshot the write address to make sure we can rollback to it in case the frame is corrupted
						rx_buffer_write_address_snapshot     <= rx_buffer_write_address;
					end if;
				when RECEIVE_HDR_WORD_2 =>
					-- check that this is an IPv4 frame, with no options or padding
					if (mac_rx_data(39 downto 32) & mac_rx_data(47 downto 40)) /= X"0800" or mac_rx_data(55 downto 48) /= X"45" then
						rx_frame_valid_for_hardware <= '0';
						rx_state                    <= RECEIVE_DATA;
					else
						rx_state                    <= RECEIVE_HDR_WORD_3;
					end if;						
					-- check if the frame has the right destination MAC
					if rx_destination_mac /= local_mac and rx_destination_mac /= X"FFFFFFFFFFFF" then
						rx_frame_valid_for_hardware <= '0';
						rx_frame_valid_for_cpu      <= '0';
						rx_state                    <= RECEIVE_DATA;
					end if;
				when RECEIVE_HDR_WORD_3 =>
					-- check that this is a UDP packet
					if mac_rx_data(63 downto 56) /= X"11" then
						rx_frame_valid_for_hardware <= '0';
						rx_state                    <= RECEIVE_DATA;
					else
						rx_state                    <= RECEIVE_HDR_WORD_4;
					end if;						
				when RECEIVE_HDR_WORD_4 =>
					-- go to the next stage
					rx_state                        <= RECEIVE_HDR_WORD_5;
					-- no IP checksum checking
					-- store the source address
					rx_addrfifo_write_data(31 downto 24) <= mac_rx_data(23 downto 16);
					rx_addrfifo_write_data(23 downto 16) <= mac_rx_data(31 downto 24);					
					rx_addrfifo_write_data(15 downto  8) <= mac_rx_data(39 downto 32);
					rx_addrfifo_write_data( 7 downto  0) <= mac_rx_data(47 downto 40);					
				when RECEIVE_HDR_WORD_5 =>
					-- go to the next stage
					rx_state                        <= RECEIVE_HDR_WORD_6;
					-- store the source port
					rx_addrfifo_write_data(47 downto 40) <= mac_rx_data(23 downto 16);
					rx_addrfifo_write_data(39 downto 32) <= mac_rx_data(31 downto 24);
					-- store the size (minus 8 to get the payload only size)
					rx_addrfifo_write_data(63 downto 48) <= (mac_rx_data(55 downto 48) & mac_rx_data(63 downto 56)) - 8;
					-- check the destination port
					if rx_destination_port /= local_port then
						rx_frame_valid_for_hardware <= '0';
						rx_state                    <= RECEIVE_DATA;						
					end if;
					-- check the destination IP
					if rx_destination_ip /= local_ip then
						rx_frame_valid_for_hardware <= '0';
						rx_state                    <= RECEIVE_DATA;
					end if;
				when RECEIVE_HDR_WORD_6 =>
					-- go to the next stage
					rx_state           <= RECEIVE_DATA;
					-- no UDP checksum checking
					-- increment the buffer address
					if rx_buffer_full = '0' then
						rx_buffer_write_address  <= rx_buffer_write_address + 1;
					end if;
				when RECEIVE_DATA =>
					if mac_rx_good_frame = '1' then
						if rx_frame_valid_for_hardware = '1' and rx_buffer_full = '0' and rx_addrfifo_full = '0' then
							-- write the address and the protocol in the address fifo
							rx_addrfifo_we            <= '1';
							rx_state                  <= IDLE;
						else
							-- rollback the buffer address and go back to idle
							rx_buffer_write_address   <= rx_buffer_write_address_snapshot;
							rx_buffer_write_address_R <= rx_buffer_write_address_snapshot;
							rx_state                  <= IDLE;
						end if;
					end if;
					if mac_rx_bad_frame = '1' then
						-- rollback the buffer address and go back to idle
						rx_buffer_write_address   <= rx_buffer_write_address_snapshot;
						rx_buffer_write_address_R <= rx_buffer_write_address_snapshot;
						rx_state                  <= IDLE;
					end if;
					if mac_rx_data_valid(2) = '1' and rx_buffer_full = '0' then
						-- increment the write address
						rx_buffer_write_address  <= rx_buffer_write_address + 1;
					end if;
			end case;
			-- if the buffer gets full at any time or the local parameters become invalid then we corrupt the frame
			if rx_buffer_full = '1' or local_valid_retimed = '0' then
				rx_frame_valid_for_hardware <= '0';
			end if;
		end if;
	end if;
end process;


-- data to be written in the buffer
rx_buffer_write_data(64)           <= '1' when mac_rx_data_valid(2) = '0' else '0';
rx_buffer_write_data(63 downto 56) <= mac_rx_data_R(23 downto 16) when mac_rx_data_valid_R(2) = '1' else X"00";
rx_buffer_write_data(55 downto 48) <= mac_rx_data_R(31 downto 24) when mac_rx_data_valid_R(3) = '1' else X"00";
rx_buffer_write_data(47 downto 40) <= mac_rx_data_R(39 downto 32) when mac_rx_data_valid_R(4) = '1' else X"00";
rx_buffer_write_data(39 downto 32) <= mac_rx_data_R(47 downto 40) when mac_rx_data_valid_R(5) = '1' else X"00";
rx_buffer_write_data(31 downto 24) <= mac_rx_data_R(55 downto 48) when mac_rx_data_valid_R(6) = '1' else X"00";
rx_buffer_write_data(23 downto 16) <= mac_rx_data_R(63 downto 56) when mac_rx_data_valid_R(7) = '1' else X"00";
rx_buffer_write_data(15 downto  8) <= mac_rx_data( 7 downto  0)   when mac_rx_data_valid(0)   = '1' else X"00";
rx_buffer_write_data( 7 downto  0) <= mac_rx_data(15 downto  8)   when mac_rx_data_valid(1)   = '1' else X"00";
-- data to be written in the cpu buffer
rx_buffer_cpu_write_data           <= mac_rx_data(7 downto 0) & mac_rx_data(15 downto 8) & mac_rx_data(23 downto 16) & mac_rx_data(31 downto 24) & mac_rx_data(39 downto 32) & mac_rx_data(47 downto 40) & mac_rx_data(55 downto 48) & mac_rx_data(63 downto 56);
-- if the current buffer is already valid, we disable writing to make sure we don't overwrite anything
rx_buffer_cpu_we                   <= "1" when rx_cpu_buffer_valid(CONV_INTEGER(rx_cpu_buffer_current)) = '0' else "0";
-- the receive buffers can always be written as the write address always points to an empty slot
rx_buffer_we                       <= "1";
-- the receive buffer is full whenever the write address is right behind the read address
rx_buffer_full                     <= '1' when rx_buffer_write_address     = rx_buffer_read_address_minusone_retimed     else '0';
-- destination addresses
rx_destination_mac                 <= mac_rx_data_R( 7 downto  0) & mac_rx_data_R(15 downto  8) & mac_rx_data_R(23 downto 16) & mac_rx_data_R(31 downto 24) & mac_rx_data_R(39 downto 32) & mac_rx_data_R(47 downto 40);
rx_destination_ip                  <= mac_rx_data_R(55 downto 48) & mac_rx_data_R(63 downto 56) & mac_rx_data  ( 7 downto  0) & mac_rx_data  (15 downto  8) ;
rx_destination_port                <= mac_rx_data(39 downto 32) & mac_rx_data(47 downto 40);
-- complete cpu buffer address with buffer selection
rx_buffer_cpu_write_address_complete <= rx_cpu_buffer_current & rx_buffer_cpu_write_address;

-- unused and constant signals
-- we don't gather any statistics on the MAC
	-- mac_rx_statistics_vector
	-- mac_rx_statistics_valid


--  ####   #####   #    #
-- #    #  #    #  #    #
-- #       #    #  #    #
-- #       #####   #    #
-- #    #  #       #    #
--  ####   #        ####

-- cpu interface
-- retime/delay signals between the cpu clock and the xgmii clock
cpu_xgmii_retime_proc: process(xaui_clk)
begin
	if xaui_clk'event and xaui_clk = '1' then
		-- To spare ressources, we only retime the valid signal, and not the other parameters signals.
		-- The software is responsible for making sure that local_valid is deasserted when parameters are updated
		local_valid_retimed        <= local_valid;
		-- rx CPU handshake
		-- we add two stages of delay on the synchronization signal to prevent incorrect sampling of the size and the buffer select bits
		rx_cpu_buffer_cleared_pre  <= cpu_rx_cpu_buffer_cleared;
		rx_cpu_buffer_cleared      <= rx_cpu_buffer_cleared_pre;
		-- tx CPU handshake
		-- we add two stages of delay on the synchronization signal to prevent incorrect sampling of the size and the buffer select bits
		tx_cpu_buffer_filled_pre   <= cpu_tx_cpu_buffer_filled;
		tx_cpu_buffer_filled       <= tx_cpu_buffer_filled_pre;

	end if;
end process;
-- retime/delay signals between the xgmii clock and the cpu clock
xgmii_cpu_retime_proc: process(OPB_Clk)
begin
	if OPB_Clk'event and OPB_Clk = '1' then
		-- rx cpu handshake
		-- we add two stages of delay on the synchronization signal to prevent incorrect sampling of the size and the buffer select bits
		cpu_rx_cpu_new_buffer_pre  <= rx_cpu_new_buffer;
		cpu_rx_cpu_new_buffer      <= cpu_rx_cpu_new_buffer_pre;
		-- tx cpu handshake
		-- we add two stages of delay on the synchronization signal to prevent incorrect sampling of the size and the buffer select bits
		cpu_tx_cpu_free_buffer_pre <= tx_cpu_free_buffer;
		cpu_tx_cpu_free_buffer     <= cpu_tx_cpu_free_buffer_pre;
	end if;
end process;

-- the sizes and buffer select bits are transmitted with no delay to allow them to stabilize before they are resample by the CPU attachment
cpu_rx_cpu_buffer_size          <= rx_cpu_buffer_size;
cpu_rx_cpu_buffer_select        <= rx_cpu_buffer_last;
tx_cpu_buffer_size              <= cpu_tx_cpu_buffer_size;
cpu_tx_cpu_buffer_select        <= tx_cpu_buffer_next;


-- opb attachment
opb_attach_inst : opb_attach
	generic map (
		C_BASEADDR             => C_BASEADDR,
		C_HIGHADDR             => C_HIGHADDR,
    DEFAULT_FABRIC_MAC     => DEFAULT_FABRIC_MAC,
    DEFAULT_FABRIC_IP      => DEFAULT_FABRIC_IP,
    DEFAULT_FABRIC_GATEWAY => DEFAULT_FABRIC_GATEWAY,
    DEFAULT_FABRIC_PORT    => DEFAULT_FABRIC_PORT,
    FABRIC_RUN_ON_STARTUP  => FABRIC_RUN_ON_STARTUP
	)
	port map (
		-- local configuration
		local_mac             => local_mac              ,
		local_ip              => local_ip               ,
		local_gateway         => local_gateway          ,
		local_port            => local_port             ,
		local_valid           => local_valid            ,

		-- tx buffer
		tx_buffer_data_in     => cpu_tx_buffer_data_in  ,
		tx_buffer_address     => cpu_tx_buffer_address  ,
		tx_buffer_we          => cpu_tx_buffer_we(0)    ,
		tx_buffer_data_out    => cpu_tx_buffer_data_out ,
		tx_cpu_buffer_size    => cpu_tx_cpu_buffer_size ,
		tx_cpu_free_buffer    => cpu_tx_cpu_free_buffer ,
		tx_cpu_buffer_filled  => cpu_tx_cpu_buffer_filled,
		tx_cpu_buffer_select  => cpu_tx_cpu_buffer_select,

		-- rx buffer
		rx_buffer_data_in     => cpu_rx_buffer_data_in  ,
		rx_buffer_address     => cpu_rx_buffer_address  ,
		rx_buffer_we          => cpu_rx_buffer_we(0)    ,
		rx_buffer_data_out    => cpu_rx_buffer_data_out ,
		rx_cpu_buffer_size    => cpu_rx_cpu_buffer_size ,
		rx_cpu_new_buffer     => cpu_rx_cpu_new_buffer  ,
		rx_cpu_buffer_cleared => cpu_rx_cpu_buffer_cleared ,
		rx_cpu_buffer_select  => cpu_rx_cpu_buffer_select,

		-- ARP cache
		arp_cache_data_in     => cpu_arp_cache_data_in  ,
		arp_cache_address     => cpu_arp_cache_address  ,
		arp_cache_we          => cpu_arp_cache_we(0)    ,
		arp_cache_data_out    => cpu_arp_cache_data_out ,

    -- phy status
		phy_status            => xaui_status,

    --MGT/GTP PMA Config
    mgt_rxeqmix           => mgt_rxeqmix,
    mgt_rxeqpole          => mgt_rxeqpole,
    mgt_txpreemphasis     => mgt_txpreemphasis,
    mgt_txdiffctrl        => mgt_txdiffctrl,

		-- OPB attachment
	  OPB_Clk               => OPB_Clk,
	  OPB_Rst               => OPB_Rst,
	  Sl_DBus               => Sl_DBus,
	  Sl_errAck             => Sl_errAck,
	  Sl_retry              => Sl_retry,
	  Sl_toutSup	          => Sl_toutSup,
	  Sl_xferAck	          => Sl_xferAck,
	  OPB_ABus	            => OPB_ABus,
	  OPB_BE	              => OPB_BE,
	  OPB_DBus              => OPB_DBus,
	  OPB_RNW               => OPB_RNW,
	  OPB_select            => OPB_select,
	  OPB_seqAddr           => OPB_seqAddr
	);


-- #       ######  #####    ####
-- #       #       #    #  #
-- #       #####   #    #   ####
-- #       #       #    #       #
-- #       #       #    #  #    #
-- ######  ######  #####    ####

-- extends LEDs light-up on transmit and receive events, and register LED signals
led_proc: process(xaui_clk)
begin
	if xaui_clk'event and xaui_clk = '1' then
		-- register led outputs to help timing closure
		led_up <= phy_rx_up;
		led_rx <= led_rx_1;
		led_tx <= led_tx_1;
		-- extend rx LED pulses
		if led_rx_count = X"200000" then
			led_rx_1 <= '0';
		else
			led_rx_count <= led_rx_count + 1;
		end if;
		if mac_rx_good_frame = '1' then
			led_rx_1     <= '1';
			led_rx_count <= (others => '0');
		end if;
		-- extend tx LED pulses
		if led_tx_count = X"200000" then
			led_tx_1 <= '0';
		else
			led_tx_count <= led_tx_count + 1;
		end if;
		if mac_tx_ack = '1' then
			led_tx_1     <= '1';
			led_tx_count <= (others => '0');
		end if;
	end if;
end process;

-- #    #    ##     ####
-- ##  ##   #  #   #    #
-- # ## #  #    #  #
-- #    #  ######  #
-- #    #  #    #  #    #
-- #    #  #    #   ####

-- configuration vector
mac_configuration_vector <=
	'0'           & -- Discard preamble when receiving frames
	'0'           & -- Use 802.3 standard preamble when transmitting frames
	'0'           & -- Allow transmission/reception of ordered fault sets to deal with link resynchronization in case of a link down event
	'0'           & -- Reserved, must be 0
	'0'           & -- Do not resize inter-frame gap, use aligned start
	'0'           & -- Do not send any flow control frame
	'0'           & -- Listen to flow control and stop operation when receiving a pause frame
	'0'           & -- No transmitter reset
	'1'           & -- Allow transmission of jumbo-frames
	'0'           & -- Checksum computed and added to the frame by the MAC
	'1'           & -- Enable transmitter
	'0'           & -- VLAN transmission disabled
	'0'           & -- Use minimum interframe gap
	'0'           & -- Do not use WAN rate emulation
	'0'           & -- No receiver reset
	'1'           & -- Allow reception of jumbo-frames
	'0'           & -- Checksum verified by the MAC
	'1'           & -- Enable the receiver
	'0'           & -- VLAN reception disabled
	local_mac;    -- mac address to use for flow control frames

-- flow control (disabled)
mac_flow_pause_val   <= (others => '0');
mac_flow_pause_req   <= '0';

-- unused and constant signals
-- we don't use underrun capability of the MAC because we can ensure that the packet is in the buffer before we start sending it
mac_tx_underrun      <= '0';
-- we use minimum interframe gap and don't need to indicate any delay to the MAC
mac_tx_ifg_delay     <= (others => '0');
-- we don't gather any statistics on the MAC
	-- mac_tx_statistics_vector
	-- mac_tx_statistics_valid

	-- 10 Gb Ethernet MAC -- UCB MAC
	mac : ten_gig_eth_mac_UCB
		port map (
			-- reset
			reset                 => rst,
			-- clocks
			tx_clk0               => xaui_clk,
			tx_dcm_lock           => '1',
			rx_clk0               => xaui_clk,
			rx_dcm_lock           => '1',
			-- transmit interface
			tx_underrun           => mac_tx_underrun          ,
			tx_data               => mac_tx_data              ,
			tx_data_valid         => mac_tx_data_valid        ,
			tx_start              => mac_tx_start             ,
			tx_ack                => mac_tx_ack               ,
			tx_ifg_delay          => mac_tx_ifg_delay         ,
			tx_statistics_vector  => mac_tx_statistics_vector ,
			tx_statistics_valid   => mac_tx_statistics_valid  ,
			-- receive interface
			rx_data               => mac_rx_data              ,
			rx_data_valid         => mac_rx_data_valid        ,
			rx_good_frame         => mac_rx_good_frame        ,
			rx_bad_frame          => mac_rx_bad_frame         ,
			rx_statistics_vector  => mac_rx_statistics_vector ,
			rx_statistics_valid   => mac_rx_statistics_valid  ,
			-- flow_control interface
			pause_val             => mac_flow_pause_val       ,
			pause_req             => mac_flow_pause_req       ,
			-- configuraion
			configuration_vector  => mac_configuration_vector ,
			-- phy interface
			xgmii_txd             => xgmii_txd,
			xgmii_txc             => xgmii_txc,
			xgmii_rxd             => xgmii_rxd,
			xgmii_rxc             => xgmii_rxc
		);


-- status_vector
phy_rx_up <= xaui_status(6);

end architecture ten_gb_eth_arch;
