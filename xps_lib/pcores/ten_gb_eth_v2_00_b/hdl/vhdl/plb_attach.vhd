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


-- 10GbEthernet core PLB attachment

-- created by Pierre-Yves Droz 2006
-- modified by David George 2007

------------------------------------------------------------------------------
-- plb_attach.vhd
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v1_00_b;
use proc_common_v1_00_b.proc_common_pkg.all;

library ipif_common_v1_00_b;
use ipif_common_v1_00_b.ipif_pkg.all;
library plb_ipif_v1_00_e;
use plb_ipif_v1_00_e.all;

entity plb_attach is
	generic(
		C_BASEADDR             : std_logic_vector     := X"FFFFFFFF";
		C_HIGHADDR             : std_logic_vector     := X"00000000";
		C_PLB_AWIDTH           : integer              := 32;
		C_PLB_DWIDTH           : integer              := 64;
		C_PLB_NUM_MASTERS      : integer              := 8;
		C_PLB_MID_WIDTH        : integer              := 3;
		C_FAMILY               : string               := "virtex2p";
    DEFAULT_FABRIC_MAC     : std_logic_vector     := X"FFFFFFFFFFFF";
    DEFAULT_FABRIC_IP      : std_logic_vector     := X"FFFFFFFF";
    DEFAULT_FABRIC_GATEWAY : std_logic_vector     := X"FFFF";
    DEFAULT_FABRIC_PORT    : std_logic_vector     := X"FF";
    FABRIC_RUN_ON_STARTUP  : integer              := 0
	);
	port (
		-- local configuration
		local_mac             : out std_logic_vector(47 downto 0);
		local_ip              : out std_logic_vector(31 downto 0);
		local_gateway         : out std_logic_vector(7 downto 0);
		local_port            : out std_logic_vector(15 downto 0);
		local_valid           : out std_logic := '0';

		-- tx buffer
		tx_buffer_data_in     : out std_logic_vector(63 downto 0);
		tx_buffer_address     : out std_logic_vector(8 downto 0) := (others => '0');
		tx_buffer_we          : out std_logic;
		tx_buffer_data_out    : in  std_logic_vector(63 downto 0);
		tx_cpu_buffer_size    : out std_logic_vector(7 downto 0) := (others => '0');
		tx_cpu_free_buffer    : in  std_logic := '0';
		tx_cpu_buffer_filled  : out std_logic;
		tx_cpu_buffer_select  : in  std_logic := '0';

		-- rx buffer
		rx_buffer_data_in     : out std_logic_vector(63 downto 0);
		rx_buffer_address     : out std_logic_vector(8 downto 0);
		rx_buffer_we          : out std_logic;
		rx_buffer_data_out    : in  std_logic_vector(63 downto 0);
		rx_cpu_buffer_size    : in  std_logic_vector(7 downto 0);
		rx_cpu_new_buffer     : in  std_logic;
		rx_cpu_buffer_cleared : out std_logic;
		rx_cpu_buffer_select  : in  std_logic;

		-- ARP cache
		arp_cache_data_in     : out std_logic_vector(47 downto 0);
		arp_cache_address     : out std_logic_vector( 7 downto 0);
		arp_cache_we          : out std_logic;
		arp_cache_data_out    : in  std_logic_vector(47 downto 0);

		-- PLB attachment
		PLB_Clk               : in  std_logic;
		PLB_Rst               : in  std_logic;
		Sl_addrAck            : out std_logic;
		Sl_MBusy              : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
		Sl_MErr               : out std_logic_vector(0 to C_PLB_NUM_MASTERS-1);
		Sl_rdBTerm            : out std_logic;
		Sl_rdComp             : out std_logic;
		Sl_rdDAck             : out std_logic;
		Sl_rdDBus             : out std_logic_vector(0 to C_PLB_DWIDTH-1);
		Sl_rdWdAddr           : out std_logic_vector(0 to 3);
		Sl_rearbitrate        : out std_logic;
		Sl_SSize              : out std_logic_vector(0 to 1);
		Sl_wait               : out std_logic;
		Sl_wrBTerm            : out std_logic;
		Sl_wrComp             : out std_logic;
		Sl_wrDAck             : out std_logic;
		PLB_abort             : in  std_logic;
		PLB_ABus              : in  std_logic_vector(0 to C_PLB_AWIDTH-1);
		PLB_BE                : in  std_logic_vector(0 to C_PLB_DWIDTH/8-1);
		PLB_busLock           : in  std_logic;
		PLB_compress          : in  std_logic;
		PLB_guarded           : in  std_logic;
		PLB_lockErr           : in  std_logic;
		PLB_masterID          : in  std_logic_vector(0 to C_PLB_MID_WIDTH-1);
		PLB_MSize             : in  std_logic_vector(0 to 1);
		PLB_ordered           : in  std_logic;
		PLB_PAValid           : in  std_logic;
		PLB_pendPri           : in  std_logic_vector(0 to 1);
		PLB_pendReq           : in  std_logic;
		PLB_rdBurst           : in  std_logic;
		PLB_rdPrim            : in  std_logic;
		PLB_reqPri            : in  std_logic_vector(0 to 1);
		PLB_RNW               : in  std_logic;
		PLB_SAValid           : in  std_logic;
		PLB_size              : in  std_logic_vector(0 to 3);
		PLB_type              : in  std_logic_vector(0 to 2);
		PLB_wrBurst           : in  std_logic;
		PLB_wrDBus            : in  std_logic_vector(0 to C_PLB_DWIDTH-1);
		PLB_wrPrim            : in  std_logic;
		phy_status            : in  std_logic_vector(7 downto 0)
	);
end entity plb_attach;

architecture plb_attach_arch of plb_attach is

--  ####    ####   #    #   ####    #####
-- #    #  #    #  ##   #  #          #
-- #       #    #  # #  #   ####      #
-- #       #    #  #  # #       #     #
-- #    #  #    #  #   ##  #    #     #
--  ####    ####   #    #   ####      #

	-- *
	-- * Type definitions
	-- *
	type size_array is array (1 downto 0) of std_logic_vector(7 downto 0);

	-- *
	-- * PLB IPIF configuration constants
	-- *
	-- address ranges identifiers
	constant ARD_ID_ARRAY                   : INTEGER_ARRAY_TYPE                       :=
	(
		0  => USER_00,
		1  => USER_01,
		2  => USER_02,
		3  => USER_03
	);
	-- address pairs for each address range
	constant ZERO_ADDR_PAD                  : std_logic_vector(0 to 64-C_PLB_AWIDTH-1) := (others => '0');
	constant USER_BASEADDR                  : std_logic_vector                         := C_BASEADDR;
	constant USER_HIGHADDR                  : std_logic_vector                         := C_HIGHADDR;
	constant ARD_ADDR_RANGE_ARRAY           : SLV64_ARRAY_TYPE                         :=
	(
		ZERO_ADDR_PAD & (USER_BASEADDR + X"00000000") ,ZERO_ADDR_PAD & (USER_BASEADDR + X"000000FF"), -- configuration/status
		ZERO_ADDR_PAD & (USER_BASEADDR + X"00001000") ,ZERO_ADDR_PAD & (USER_BASEADDR + X"000017FF"), -- transmit buffer
		ZERO_ADDR_PAD & (USER_BASEADDR + X"00002000") ,ZERO_ADDR_PAD & (USER_BASEADDR + X"000027FF"), -- receive buffer
		ZERO_ADDR_PAD & (USER_BASEADDR + X"00003000") ,ZERO_ADDR_PAD & (USER_BASEADDR + X"000037FF")  -- arp cache
	);
	-- data widths
	constant USER_DWIDTH                    : integer                                  := C_PLB_DWIDTH;
	constant ARD_DWIDTH_ARRAY               : INTEGER_ARRAY_TYPE                       :=
	(
		0  => USER_DWIDTH,
		1  => USER_DWIDTH,
		2  => USER_DWIDTH,
		3  => USER_DWIDTH
	);
	-- number of chip enables
	constant ARD_NUM_CE_ARRAY               : INTEGER_ARRAY_TYPE                       :=
	(
		0  => 1,
		1  => 1,
		2  => 1,
		3  => 1
    );
	-- user core ID code
	constant DEV_BLK_ID                     : integer                                  := 0;
	-- enable MIR/Reset register
	constant DEV_MIR_ENABLE                 : boolean                                  := false;
	-- enable burst support
	constant DEV_BURST_ENABLE               : boolean                                  := false;
	-- use fast transfer protocol for burst and cacheline
	constant DEV_FAST_DATA_XFER             : boolean                                  := false;
	-- max burst size in bytes - reserved
	constant DEV_MAX_BURST_SIZE             : integer                                  := 64;
	-- size of the largest target burstable memory space in bytes - reserved
	constant DEV_BURST_PAGE_SIZE            : integer                                  := 1024;
	-- dataphase timeout value for IPIF
	constant DEV_DPHASE_TIMEOUT             : integer                                  := 64;
	-- include device interrupt source controller
	constant INCLUDE_DEV_ISC                : boolean                                  := false;
	-- include IPIF ISC priority encoder
	constant INCLUDE_DEV_PENCODER           : boolean                                  := false;
	-- IP interrupt mode
	constant IP_INTR_MODE_ARRAY             : INTEGER_ARRAY_TYPE                       := (0  => 0);
	-- include PLB master service - reserved
	constant IP_MASTER_PRESENT              : boolean                                  := false;
	-- write FIFO depth
	constant WRFIFO_DEPTH                   : integer                                  := 512;
	-- include write FIFO packet mode service
	constant WRFIFO_INCLUDE_PACKET_MODE     : boolean                                  := false;
	-- include write FIFO vacancy status
	constant WRFIFO_INCLUDE_VACANCY         : boolean                                  := true;
	-- read FIFO depth
	constant RDFIFO_DEPTH                   : integer                                  := 512;
	-- include read FIFO packet mode service
	constant RDFIFO_INCLUDE_PACKET_MODE     : boolean                                  := false;
	-- include read FIFO vacancy status
	constant RDFIFO_INCLUDE_VACANCY         : boolean                                  := true;
	-- PLB clock period in ps - reserved
	constant PLB_CLK_PERIOD_PS              : integer                                  := 10000;



--  ####      #     ####   #    #    ##    #        ####
-- #          #    #    #  ##   #   #  #   #       #
--  ####      #    #       # #  #  #    #  #        ####
--      #     #    #  ###  #  # #  ######  #            #
-- #    #     #    #    #  #   ##  #    #  #       #    #
--  ####      #     ####   #    #  #    #  ######   ####


	-- IPIF signals
	signal Bus2IP_Clk                       : std_logic;
	signal Bus2IP_Reset                     : std_logic;
	signal IP2Bus_Data                      : std_logic_vector(C_PLB_DWIDTH-1 downto 0) := (others => '0');
	signal IP2Bus_WrAck                     : std_logic                                 := '0';
	signal IP2Bus_RdAck                     : std_logic                                 := '0';
	signal IP2Bus_Retry                     : std_logic                                 := '0';
	signal IP2Bus_Error                     : std_logic                                 := '0';
	signal IP2Bus_ToutSup                   : std_logic                                 := '0';
	signal IP2Bus_Busy                      : std_logic                                 := '0';
	signal Bus2IP_Addr                      : std_logic_vector(C_PLB_AWIDTH - 1 downto 0);
	signal Bus2IP_Data                      : std_logic_vector(C_PLB_DWIDTH - 1 downto 0);
	signal Bus2IP_BE                        : std_logic_vector((C_PLB_DWIDTH/8) - 1 downto 0);
	signal Bus2IP_WrReq                     : std_logic;
	signal Bus2IP_RdReq                     : std_logic;
	signal Bus2IP_RNW                       : std_logic;
	signal Bus2IP_CS                        : std_logic_vector(((ARD_ADDR_RANGE_ARRAY'LENGTH)/2)-1 downto 0);

	signal local_mac_int                    : std_logic_vector(47 downto 0);
	signal local_ip_int                     : std_logic_vector(31 downto 0);
	signal local_gateway_int                : std_logic_vector(7 downto 0);
	signal local_port_int                   : std_logic_vector(15 downto 0);
	signal local_valid_int                  : std_logic := '0';
	signal rx_cpu_buffer_cleared_int        : std_logic := '0';
	signal tx_cpu_buffer_filled_int         : std_logic := '0';
	signal rx_cpu_buffer_select_int         : std_logic := '0';
	signal tx_cpu_buffer_select_int         : std_logic := '0';

	signal use_arp_data                     : std_logic;
	signal use_tx_data                      : std_logic;
	signal use_rx_data                      : std_logic;
	signal conf_read_reg                    : std_logic_vector(63 downto 0);

	signal tx_size                          : std_logic_vector(7 downto 0);
	signal rx_size                          : std_logic_vector(7 downto 0);

	signal tx_cpu_free_buffer_R             : std_logic;
	signal rx_cpu_new_buffer_R              : std_logic;

begin

--    #    #####      #    ######
--    #    #    #     #    #
--    #    #    #     #    #####
--    #    #####      #    #
--    #    #          #    #
--    #    #          #    #


	-- PLB IPIF
	plb_ipif : entity plb_ipif_v1_00_e.plb_ipif
	generic map
	(
		C_ARD_ID_ARRAY                 => ARD_ID_ARRAY,
		C_ARD_ADDR_RANGE_ARRAY         => ARD_ADDR_RANGE_ARRAY,
		C_ARD_DWIDTH_ARRAY             => ARD_DWIDTH_ARRAY,
		C_ARD_NUM_CE_ARRAY             => ARD_NUM_CE_ARRAY,
		C_DEV_BLK_ID                   => DEV_BLK_ID,
		C_DEV_MIR_ENABLE               => DEV_MIR_ENABLE,
		C_DEV_BURST_ENABLE             => DEV_BURST_ENABLE,
		C_DEV_FAST_DATA_XFER           => DEV_FAST_DATA_XFER,
		C_DEV_MAX_BURST_SIZE           => DEV_MAX_BURST_SIZE,
		C_DEV_BURST_PAGE_SIZE          => DEV_BURST_PAGE_SIZE,
		C_DEV_DPHASE_TIMEOUT           => DEV_DPHASE_TIMEOUT,
		C_INCLUDE_DEV_ISC              => INCLUDE_DEV_ISC,
		C_INCLUDE_DEV_PENCODER         => INCLUDE_DEV_PENCODER,
		C_IP_INTR_MODE_ARRAY           => IP_INTR_MODE_ARRAY,
		C_IP_MASTER_PRESENT            => IP_MASTER_PRESENT,
		C_WRFIFO_DEPTH                 => WRFIFO_DEPTH,
		C_WRFIFO_INCLUDE_PACKET_MODE   => WRFIFO_INCLUDE_PACKET_MODE,
		C_WRFIFO_INCLUDE_VACANCY       => WRFIFO_INCLUDE_VACANCY,
		C_RDFIFO_DEPTH                 => RDFIFO_DEPTH,
		C_RDFIFO_INCLUDE_PACKET_MODE   => RDFIFO_INCLUDE_PACKET_MODE,
		C_RDFIFO_INCLUDE_VACANCY       => RDFIFO_INCLUDE_VACANCY,
		C_PLB_MID_WIDTH                => C_PLB_MID_WIDTH,
		C_PLB_NUM_MASTERS              => C_PLB_NUM_MASTERS,
		C_PLB_AWIDTH                   => C_PLB_AWIDTH,
		C_PLB_DWIDTH                   => C_PLB_DWIDTH,
		C_PLB_CLK_PERIOD_PS            => PLB_CLK_PERIOD_PS,
		C_IPIF_DWIDTH                  => C_PLB_DWIDTH,
		C_IPIF_AWIDTH                  => C_PLB_AWIDTH,
		C_FAMILY                       => C_FAMILY
	)
	port map
	(
		PLB_clk                        => PLB_Clk,
		Reset                          => PLB_Rst,
		Freeze                         => '0',
		IP2INTC_Irpt                   => open,
		PLB_ABus                       => PLB_ABus,
		PLB_PAValid                    => PLB_PAValid,
		PLB_SAValid                    => PLB_SAValid,
		PLB_rdPrim                     => PLB_rdPrim,
		PLB_wrPrim                     => PLB_wrPrim,
		PLB_masterID                   => PLB_masterID,
		PLB_abort                      => PLB_abort,
		PLB_busLock                    => PLB_busLock,
		PLB_RNW                        => PLB_RNW,
		PLB_BE                         => PLB_BE,
		PLB_MSize                      => PLB_MSize,
		PLB_size                       => PLB_size,
		PLB_type                       => PLB_type,
		PLB_compress                   => PLB_compress,
		PLB_guarded                    => PLB_guarded,
		PLB_ordered                    => PLB_ordered,
		PLB_lockErr                    => PLB_lockErr,
		PLB_wrDBus                     => PLB_wrDBus,
		PLB_wrBurst                    => PLB_wrBurst,
		PLB_rdBurst                    => PLB_rdBurst,
		PLB_pendReq                    => PLB_pendReq,
		PLB_pendPri                    => PLB_pendPri,
		PLB_reqPri                     => PLB_reqPri,
		Sl_addrAck                     => Sl_addrAck,
		Sl_SSize                       => Sl_SSize,
		Sl_wait                        => Sl_wait,
		Sl_rearbitrate                 => Sl_rearbitrate,
		Sl_wrDAck                      => Sl_wrDAck,
		Sl_wrComp                      => Sl_wrComp,
		Sl_wrBTerm                     => Sl_wrBTerm,
		Sl_rdDBus                      => Sl_rdDBus,
		Sl_rdWdAddr                    => Sl_rdWdAddr,
		Sl_rdDAck                      => Sl_rdDAck,
		Sl_rdComp                      => Sl_rdComp,
		Sl_rdBTerm                     => Sl_rdBTerm,
		Sl_MBusy                       => Sl_MBusy,
		Sl_MErr                        => Sl_MErr,
		PLB_MAddrAck                   => '0',
		PLB_MSSize                     => "00",
		PLB_MRearbitrate               => '0',
		PLB_MBusy                      => '0',
		PLB_MErr                       => '0',
		PLB_MWrDAck                    => '0',
		PLB_MRdDBus                    => X"0000000000000000",
		PLB_MRdWdAddr                  => "0000",
		PLB_MRdDAck                    => '0',
		PLB_MRdBTerm                   => '0',
		PLB_MWrBTerm                   => '0',
		M_request                      => open,
		M_priority                     => open,
		M_busLock                      => open,
		M_RNW                          => open,
		M_BE                           => open,
		M_MSize                        => open,
		M_size                         => open,
		M_type                         => open,
		M_compress                     => open,
		M_guarded                      => open,
		M_ordered                      => open,
		M_lockErr                      => open,
		M_abort                        => open,
		M_ABus                         => open,
		M_wrDBus                       => open,
		M_wrBurst                      => open,
		M_rdBurst                      => open,
		IP2Bus_Clk                     => '0',
		Bus2IP_Clk                     => Bus2IP_Clk,
		Bus2IP_Reset                   => Bus2IP_Reset,
		Bus2IP_Freeze                  => open,
		IP2Bus_IntrEvent               => "0",
		IP2Bus_Data                    => IP2Bus_Data,
		IP2Bus_WrAck                   => IP2Bus_WrAck,
		IP2Bus_RdAck                   => IP2Bus_RdAck,
		IP2Bus_Retry                   => IP2Bus_Retry,
		IP2Bus_Error                   => IP2Bus_Error,
		IP2Bus_ToutSup                 => IP2Bus_ToutSup,
		IP2Bus_PostedWrInh             => '0',
		IP2Bus_Busy                    => IP2Bus_Busy,
		IP2Bus_AddrAck                 => '0',
		IP2Bus_BTerm                   => '0',
		Bus2IP_Addr                    => Bus2IP_Addr,
		Bus2IP_Data                    => Bus2IP_Data,
		Bus2IP_RNW                     => Bus2IP_RNW,
		Bus2IP_BE                      => Bus2IP_BE,
		Bus2IP_Burst                   => open,
		Bus2IP_IBurst                  => open,
		Bus2IP_WrReq                   => Bus2IP_WrReq,
		Bus2IP_RdReq                   => Bus2IP_RdReq,
		Bus2IP_RNW_Early               => open,
		Bus2IP_PselHit                 => open,
		Bus2IP_CS                      => Bus2IP_CS,
		Bus2IP_CE                      => open,
		Bus2IP_RdCE                    => open,
		Bus2IP_WrCE                    => open,
		IP2DMA_RxLength_Empty          => '0',
		IP2DMA_RxStatus_Empty          => '0',
		IP2DMA_TxLength_Full           => '0',
		IP2DMA_TxStatus_Empty          => '0',
		IP2Bus_Addr                    => X"00000000",
		IP2Bus_MstBE                   => "00000000",
		IP2IP_Addr                     => X"00000000",
		IP2Bus_MstWrReq                => '0',
		IP2Bus_MstRdReq                => '0',
		IP2Bus_MstBurst                => '0',
		IP2Bus_MstBusLock              => '0',
		Bus2IP_MstWrAck                => open,
		Bus2IP_MstRdAck                => open,
		Bus2IP_MstRetry                => open,
		Bus2IP_MstError                => open,
		Bus2IP_MstTimeOut              => open,
		Bus2IP_MstLastAck              => open,
		IP2RFIFO_WrReq                 => '0',
		IP2RFIFO_Data                  => X"0000000000000000",
		IP2RFIFO_WrMark                => '0',
		IP2RFIFO_WrRelease             => '0',
		IP2RFIFO_WrRestore             => '0',
		RFIFO2IP_WrAck                 => open,
		RFIFO2IP_AlmostFull            => open,
		RFIFO2IP_Full                  => open,
		RFIFO2IP_Vacancy               => open,
		IP2WFIFO_RdReq                 => '0',
		IP2WFIFO_RdMark                => '0',
		IP2WFIFO_RdRelease             => '0',
		IP2WFIFO_RdRestore             => '0',
		WFIFO2IP_Data                  => open,
		WFIFO2IP_RdAck                 => open,
		WFIFO2IP_AlmostEmpty           => open,
		WFIFO2IP_Empty                 => open,
		WFIFO2IP_Occupancy             => open,
		IP2Bus_DMA_Req                 => '0',
		Bus2IP_DMA_Ack                 => open
	);


-- *
-- * Main state machine
-- *

plb_fsm: process(Bus2IP_Clk)
begin
	if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
		if Bus2IP_Reset = '1' then
			IP2Bus_WrAck              <= '0';
			IP2Bus_RdAck              <= '0';
			rx_cpu_buffer_cleared_int <= '0';
			tx_cpu_buffer_filled_int  <= '0';
			tx_size                   <= (others => '0');
			rx_size                   <= (others => '0');
			tx_cpu_free_buffer_R      <= '0';
			rx_cpu_new_buffer_R       <= '0';
	    local_mac_int             <= DEFAULT_FABRIC_MAC;
	    local_ip_int              <= DEFAULT_FABRIC_IP;
	    local_gateway_int         <= DEFAULT_FABRIC_GATEWAY;
	    local_port_int            <= DEFAULT_FABRIC_PORT;
      if FABRIC_RUN_ON_STARTUP = 1 then
	      local_valid_int         <= '1';
      else
	      local_valid_int         <= '0';
      end if;
		else
			-- single cycle activation signals
			IP2Bus_WrAck <= '0';
			IP2Bus_RdAck <= '0';
			use_arp_data <= '0';
			use_tx_data  <= '0';
			use_rx_data  <= '0';
			arp_cache_we <= '0';
			rx_buffer_we <= '0';
			tx_buffer_we <= '0';

			-- delayed signals
			tx_cpu_free_buffer_R <= tx_cpu_free_buffer;
			rx_cpu_new_buffer_R  <= rx_cpu_new_buffer;

			-- #    #    ##    #    #  #####    ####   #    #    ##    #    #  ######
			-- #    #   #  #   ##   #  #    #  #       #    #   #  #   #   #   #
			-- ######  #    #  # #  #  #    #   ####   ######  #    #  ####    #####
			-- #    #  ######  #  # #  #    #       #  #    #  ######  #  #    #
			-- #    #  #    #  #   ##  #    #  #    #  #    #  #    #  #   #   #
			-- #    #  #    #  #    #  #####    ####   #    #  #    #  #    #  ######

			-- rx handshake
			if rx_cpu_buffer_cleared_int = '0' and rx_cpu_new_buffer = '1' and rx_cpu_new_buffer_R = '0' then
				rx_size                   <= rx_cpu_buffer_size;
				rx_cpu_buffer_select_int  <= rx_cpu_buffer_select;
			end if;
			if rx_cpu_buffer_cleared_int = '0' and rx_cpu_new_buffer = '1' and rx_cpu_new_buffer_R = '1' and rx_size = X"00" then
				rx_cpu_buffer_cleared_int <= '1';
			end if;
			if rx_cpu_buffer_cleared_int = '1' and rx_cpu_new_buffer = '0' then
				rx_cpu_buffer_cleared_int <= '0';
			end if;

			-- tx handshake
			if tx_cpu_buffer_filled_int = '0' and tx_cpu_free_buffer = '1' and tx_cpu_free_buffer_R = '0' then
				tx_size                   <= X"00";
				tx_cpu_buffer_select_int  <= tx_cpu_buffer_select;
			end if;
			if tx_cpu_buffer_filled_int = '0' and tx_cpu_free_buffer = '1' and tx_cpu_free_buffer_R = '1' and tx_size /= X"00" then
				tx_cpu_buffer_filled_int  <= '1';
				tx_cpu_buffer_size        <= tx_size;
			end if;
			if tx_cpu_buffer_filled_int = '1' and tx_cpu_free_buffer = '0' then
				tx_cpu_buffer_filled_int  <= '0';
			end if;

			--   ##    #####   #####            ####     ##     ####   #    #  ######
			--  #  #   #    #  #    #          #    #   #  #   #    #  #    #  #
			-- #    #  #    #  #    #          #       #    #  #       ######  #####
			-- ######  #####   #####           #       ######  #       #    #  #
			-- #    #  #   #   #               #    #  #    #  #    #  #    #  #
			-- #    #  #    #  #                ####   #    #   ####   #    #  ######

			-- READ
			if Bus2IP_CS(0) = '1' and Bus2IP_RdReq = '1' then
				-- for a read we can directly put the data from the bram onto the bus
				IP2Bus_RdAck   <= '1';
				use_arp_data   <= '1';
			end if;
			-- WRITE
			if Bus2IP_CS(0) = '1' and Bus2IP_WrReq = '1' then
				-- for a write we can write the modified data in the next cycle
				IP2Bus_WrAck   <= '1';
				arp_cache_we   <= '1';
			end if;

			-- #####   #    #          #####   #    #  ######  ######  ######  #####
			-- #    #   #  #           #    #  #    #  #       #       #       #    #
			-- #    #    ##            #####   #    #  #####   #####   #####   #    #
			-- #####     ##            #    #  #    #  #       #       #       #####
			-- #   #    #  #           #    #  #    #  #       #       #       #   #
			-- #    #  #    #          #####    ####   #       #       ######  #    #

			-- READ
			if Bus2IP_CS(1) = '1' and Bus2IP_RdReq = '1' then
				-- for a read we can directly put the data from the bram onto the bus
				IP2Bus_RdAck   <= '1';
				use_rx_data    <= '1';
			end if;
			-- WRITE
			if Bus2IP_CS(1) = '1' and Bus2IP_WrReq = '1' then
				-- for a write we can write the modified data in the next cycle
				IP2Bus_WrAck   <= '1';
				rx_buffer_we   <= '1';
			end if;

			--  #####  #    #          #####   #    #  ######  ######  ######  #####
			--    #     #  #           #    #  #    #  #       #       #       #    #
			--    #      ##            #####   #    #  #####   #####   #####   #    #
			--    #      ##            #    #  #    #  #       #       #       #####
			--    #     #  #           #    #  #    #  #       #       #       #   #
			--    #    #    #          #####    ####   #       #       ######  #    #

			-- READ
			if Bus2IP_CS(2) = '1' and Bus2IP_RdReq = '1' then
				-- for a read we can directly put the data from the bram onto the bus
				IP2Bus_RdAck   <= '1';
				use_tx_data    <= '1';
			end if;
			-- WRITE
			if Bus2IP_CS(2) = '1' and Bus2IP_WrReq = '1' then
				-- for a write we can write the modified data in the next cycle
				IP2Bus_WrAck   <= '1';
				tx_buffer_we   <= '1';
			end if;

			--  ####    ####   #    #  ######      #    ####    #####    ##     #####  #    #   ####
			-- #    #  #    #  ##   #  #          #    #          #     #  #      #    #    #  #
			-- #       #    #  # #  #  #####     #      ####      #    #    #     #    #    #   ####
			-- #       #    #  #  # #  #        #           #     #    ######     #    #    #       #
			-- #    #  #    #  #   ##  #       #       #    #     #    #    #     #    #    #  #    #
			--  ####    ####   #    #  #      #         ####      #    #    #     #     ####    ####

			-- register map :
			--                63                                                             0
			-- 0x00 -> 0x07 : 0000000000000000MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
			--                                |<------------ local MAC address ------------->|

			--                63                                                             0
			-- 0x08 -> 0x0F : 000000000000000000000000GGGGGGGGIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
			--                |<---- gateway IP address ---->||<----- local IP address ----->|

			--                63                                                             0
			-- 0x10 -> 0x17 : 00000000TTTTTTTT00000000RRRRRRRR000000000000000VPPPPPPPPPPPPPPPP
			--                |<- tx size  ->||<- rx size  ->|  local_valid->||<- UDP port ->|

			-- READ
			if Bus2IP_CS(3) = '1' and Bus2IP_RdReq = '1' then
				case Bus2IP_Addr(5 downto 3) is
					when "000" =>
						conf_read_reg <= X"0000" & local_mac_int;
					when "001" =>
						conf_read_reg <= X"000000" & local_gateway_int & local_ip_int;
					when "010" =>
						conf_read_reg <= X"00" & tx_size & X"00" & rx_size & "000000000000000" & local_valid_int & local_port_int;
					when "011" =>
                                                conf_read_reg <= X"00000000000000" & phy_status;
					when others =>
						conf_read_reg <= (others => '0');
				end case;
				IP2Bus_RdAck   <= '1';
			end if;
			-- WRITE
			if Bus2IP_CS(3) = '1' and Bus2IP_WrReq = '1' then
				case Bus2IP_Addr(4 downto 3) is
					when "00" =>
						if Bus2IP_BE(0) = '1' then local_mac_int( 7 downto  0)  <= Bus2IP_Data( 7 downto  0); end if;
						if Bus2IP_BE(1) = '1' then local_mac_int(15 downto  8)  <= Bus2IP_Data(15 downto  8); end if;
						if Bus2IP_BE(2) = '1' then local_mac_int(23 downto 16)  <= Bus2IP_Data(23 downto 16); end if;
						if Bus2IP_BE(3) = '1' then local_mac_int(31 downto 24)  <= Bus2IP_Data(31 downto 24); end if;
						if Bus2IP_BE(4) = '1' then local_mac_int(39 downto 32)  <= Bus2IP_Data(39 downto 32); end if;
						if Bus2IP_BE(5) = '1' then local_mac_int(47 downto 40)  <= Bus2IP_Data(47 downto 40); end if;
					when "01" =>
						if Bus2IP_BE(0) = '1' then local_ip_int( 7 downto  0)   <= Bus2IP_Data( 7 downto  0); end if;
						if Bus2IP_BE(1) = '1' then local_ip_int(15 downto  8)   <= Bus2IP_Data(15 downto  8); end if;
						if Bus2IP_BE(2) = '1' then local_ip_int(23 downto 16)   <= Bus2IP_Data(23 downto 16); end if;
						if Bus2IP_BE(3) = '1' then local_ip_int(31 downto 24)   <= Bus2IP_Data(31 downto 24); end if;
						if Bus2IP_BE(4) = '1' then local_gateway_int            <= Bus2IP_Data(39 downto 32); end if;
					when "10" =>
						if Bus2IP_BE(0) = '1' then local_port_int( 7 downto  0) <= Bus2IP_Data( 7 downto  0); end if;
						if Bus2IP_BE(1) = '1' then local_port_int(15 downto  8) <= Bus2IP_Data(15 downto  8); end if;
						if Bus2IP_BE(2) = '1' then local_valid_int              <= Bus2IP_Data(16)          ; end if;
						if Bus2IP_BE(4) = '1' then rx_size( 7 downto 0)         <= Bus2IP_Data(39 downto 32); end if;
						if Bus2IP_BE(6) = '1' then tx_size( 7 downto 0)         <= Bus2IP_Data(55 downto 48); end if;
					when others =>
				end case;
				IP2Bus_WrAck   <= '1';
			end if;

		end if;
	end if;
end process;

-- *
-- * combinatorial signal assignments
-- *

-- assign external signals
local_mac             <= local_mac_int;
local_ip              <= local_ip_int;
local_gateway         <= local_gateway_int;
local_port            <= local_port_int;
local_valid           <= local_valid_int;
rx_cpu_buffer_cleared <= rx_cpu_buffer_cleared_int;
tx_cpu_buffer_filled  <= tx_cpu_buffer_filled_int;

-- we use directly the address from the bus to address the receive and transmit buffers and the ARP cache
tx_buffer_address     <= tx_cpu_buffer_select_int & Bus2IP_Addr(10 downto 3);
rx_buffer_address     <= rx_cpu_buffer_select_int & Bus2IP_Addr(10 downto 3);
arp_cache_address     <= Bus2IP_Addr(10 downto 3);

-- select what data to put on the bus
IP2Bus_Data           <= arp_cache_data_out when use_arp_data = '1' else
                         tx_buffer_data_out when use_tx_data  = '1' else
                         rx_buffer_data_out when use_rx_data  = '1' else
                         conf_read_reg;

-- data read/modify/write logic
tx_buffer_data_in( 7 downto  0) <= tx_buffer_data_out( 7 downto  0) when Bus2IP_BE(0) = '0' else Bus2IP_Data( 7 downto  0);
tx_buffer_data_in(15 downto  8) <= tx_buffer_data_out(15 downto  8) when Bus2IP_BE(1) = '0' else Bus2IP_Data(15 downto  8);
tx_buffer_data_in(23 downto 16) <= tx_buffer_data_out(23 downto 16) when Bus2IP_BE(2) = '0' else Bus2IP_Data(23 downto 16);
tx_buffer_data_in(31 downto 24) <= tx_buffer_data_out(31 downto 24) when Bus2IP_BE(3) = '0' else Bus2IP_Data(31 downto 24);
tx_buffer_data_in(39 downto 32) <= tx_buffer_data_out(39 downto 32) when Bus2IP_BE(4) = '0' else Bus2IP_Data(39 downto 32);
tx_buffer_data_in(47 downto 40) <= tx_buffer_data_out(47 downto 40) when Bus2IP_BE(5) = '0' else Bus2IP_Data(47 downto 40);
tx_buffer_data_in(55 downto 48) <= tx_buffer_data_out(55 downto 48) when Bus2IP_BE(6) = '0' else Bus2IP_Data(55 downto 48);
tx_buffer_data_in(63 downto 56) <= tx_buffer_data_out(63 downto 56) when Bus2IP_BE(7) = '0' else Bus2IP_Data(63 downto 56);

rx_buffer_data_in( 7 downto  0) <= rx_buffer_data_out( 7 downto  0) when Bus2IP_BE(0) = '0' else Bus2IP_Data( 7 downto  0);
rx_buffer_data_in(15 downto  8) <= rx_buffer_data_out(15 downto  8) when Bus2IP_BE(1) = '0' else Bus2IP_Data(15 downto  8);
rx_buffer_data_in(23 downto 16) <= rx_buffer_data_out(23 downto 16) when Bus2IP_BE(2) = '0' else Bus2IP_Data(23 downto 16);
rx_buffer_data_in(31 downto 24) <= rx_buffer_data_out(31 downto 24) when Bus2IP_BE(3) = '0' else Bus2IP_Data(31 downto 24);
rx_buffer_data_in(39 downto 32) <= rx_buffer_data_out(39 downto 32) when Bus2IP_BE(4) = '0' else Bus2IP_Data(39 downto 32);
rx_buffer_data_in(47 downto 40) <= rx_buffer_data_out(47 downto 40) when Bus2IP_BE(5) = '0' else Bus2IP_Data(47 downto 40);
rx_buffer_data_in(55 downto 48) <= rx_buffer_data_out(55 downto 48) when Bus2IP_BE(6) = '0' else Bus2IP_Data(55 downto 48);
rx_buffer_data_in(63 downto 56) <= rx_buffer_data_out(63 downto 56) when Bus2IP_BE(7) = '0' else Bus2IP_Data(63 downto 56);

arp_cache_data_in( 7 downto  0) <= arp_cache_data_out( 7 downto  0) when Bus2IP_BE(0) = '0' else Bus2IP_Data( 7 downto  0);
arp_cache_data_in(15 downto  8) <= arp_cache_data_out(15 downto  8) when Bus2IP_BE(1) = '0' else Bus2IP_Data(15 downto  8);
arp_cache_data_in(23 downto 16) <= arp_cache_data_out(23 downto 16) when Bus2IP_BE(2) = '0' else Bus2IP_Data(23 downto 16);
arp_cache_data_in(31 downto 24) <= arp_cache_data_out(31 downto 24) when Bus2IP_BE(3) = '0' else Bus2IP_Data(31 downto 24);
arp_cache_data_in(39 downto 32) <= arp_cache_data_out(39 downto 32) when Bus2IP_BE(4) = '0' else Bus2IP_Data(39 downto 32);
arp_cache_data_in(47 downto 40) <= arp_cache_data_out(47 downto 40) when Bus2IP_BE(5) = '0' else Bus2IP_Data(47 downto 40);

end architecture;



