--------------------------------------------------------------------------------
-- Legal & Copyright:   (c) 2018 Kutleng Engineering Technologies (Pty) Ltd    - 
--                                                                             -
-- This program is the proprietary software of Kutleng Engineering Technologies-
-- and/or its licensors, and may only be used, duplicated, modified or         -
-- distributed pursuant to the terms and conditions of a separate, written     -
-- license agreement executed between you and Kutleng (an "Authorized License")-
-- Except as set forth in an Authorized License, Kutleng grants no license     -
-- (express or implied), right to use, or waiver of any kind with respect to   -
-- the Software, and Kutleng expressly reserves all rights in and to the       -
-- Software and all intellectual property rights therein.  IF YOU HAVE NO      -
-- AUTHORIZED LICENSE, THEN YOU HAVE NO RIGHT TO USE THIS SOFTWARE IN ANY WAY, -
-- AND SHOULD IMMEDIATELY NOTIFY KUTLENG AND DISCONTINUE ALL USE OF THE        -
-- SOFTWARE.                                                                   -
--                                                                             -
-- Except as expressly set forth in the Authorized License,                    -
--                                                                             -
-- 1.     This program, including its structure, sequence and organization,    -
-- constitutes the valuable trade secrets of Kutleng, and you shall use all    -
-- reasonable efforts to protect the confidentiality thereof,and to use this   -
-- information only in connection with South African Radio Astronomy           -
-- Observatory (SARAO) products.                                               -
--                                                                             -
-- 2.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, THE SOFTWARE IS PROVIDED     -
-- "AS IS" AND WITH ALL FAULTS AND KUTLENG MAKES NO PROMISES, REPRESENTATIONS  -
-- OR WARRANTIES, EITHER EXPRESS, IMPLIED, STATUTORY, OR OTHERWISE, WITH       -
-- RESPECT TO THE SOFTWARE.  KUTLENG SPECIFICALLY DISCLAIMS ANY AND ALL IMPLIED-
-- WARRANTIES OF TITLE, MERCHANTABILITY, NONINFRINGEMENT, FITNESS FOR A        -
-- PARTICULAR PURPOSE, LACK OF VIRUSES, ACCURACY OR COMPLETENESS, QUIET        -
-- ENJOYMENT, QUIET POSSESSION OR CORRESPONDENCE TO DESCRIPTION. YOU ASSUME THE-
-- ENJOYMENT, QUIET POSSESSION USE OR PERFORMANCE OF THE SOFTWARE.             -
--                                                                             -
-- 3.     TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL KUTLENG OR -
-- ITS LICENSORS BE LIABLE FOR (i) CONSEQUENTIAL, INCIDENTAL, SPECIAL, INDIRECT-
-- , OR EXEMPLARY DAMAGES WHATSOEVER ARISING OUT OF OR IN ANY WAY RELATING TO  -
-- YOUR USE OF OR INABILITY TO USE THE SOFTWARE EVEN IF KUTLENG HAS BEEN       -
-- ADVISED OF THE POSSIBILITY OF SUCH DAMAGES; OR (ii) ANY AMOUNT IN EXCESS OF -
-- THE AMOUNT ACTUALLY PAID FOR THE SOFTWARE ITSELF OR ZAR R1, WHICHEVER IS    -
-- GREATER. THESE LIMITATIONS SHALL APPLY NOTWITHSTANDING ANY FAILURE OF       -
-- ESSENTIAL PURPOSE OF ANY LIMITED REMEDY.                                    -
-- --------------------------------------------------------------------------- -
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS                    -
-- PART OF THIS FILE AT ALL TIMES.                                             -
--=============================================================================-
-- Company          : Kutleng Dynamic Electronics Systems (Pty) Ltd            -
-- Engineer         : Benjamin Hector Hlophe                                   -
--                                                                             -
-- Design Name      : CASPER BSP                                               -
-- Module Name      : udpdatastripper_tb - rtl                                 -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module test the udpdatastripper statemachine        -
--                                                                             -
-- Dependencies     : udpdatastripper                                          -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udpdatastripperpacker_tb is
end entity udpdatastripperpacker_tb;

architecture rtl of udpdatastripperpacker_tb is
    component udpdatapacker is
        generic(
            G_SLOT_WIDTH      : natural := 4;
            G_AXIS_DATA_WIDTH : natural := 512;
            G_ARP_CACHE_ASIZE : natural := 9;
            G_ARP_DATA_WIDTH  : natural := 32;
            G_ADDR_WIDTH      : natural := 5
        );
        port(
            axis_clk                       : in  STD_LOGIC;
            axis_app_clk                   : in  STD_LOGIC;
            axis_reset                     : in  STD_LOGIC;
            EthernetMACAddress             : in  STD_LOGIC_VECTOR(47 downto 0);
            LocalIPAddress                 : in  STD_LOGIC_VECTOR(31 downto 0);
            LocalIPNetmask                 : in  STD_LOGIC_VECTOR(31 downto 0);
            GatewayIPAddress               : in  STD_LOGIC_VECTOR(31 downto 0);
            MulticastIPAddress             : in  STD_LOGIC_VECTOR(31 downto 0);
            MulticastIPNetmask             : in  STD_LOGIC_VECTOR(31 downto 0);
            EthernetMACEnable              : in  STD_LOGIC;
            TXOverflowCount                : out STD_LOGIC_VECTOR(31 downto 0);
            TXAFullCount                   : out STD_LOGIC_VECTOR(31 downto 0);
            ServerUDPPort                  : in  STD_LOGIC_VECTOR(15 downto 0);
            ARPReadDataEnable              : out STD_LOGIC;
            ARPReadData                    : in  STD_LOGIC_VECTOR((G_ARP_DATA_WIDTH * 2) - 1 downto 0);
            ARPReadAddress                 : out STD_LOGIC_VECTOR(G_ARP_CACHE_ASIZE - 1 downto 0);
            -- Packet Readout in addressed bus format
            SenderRingBufferSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            SenderRingBufferSlotClear      : in  STD_LOGIC;
            SenderRingBufferSlotStatus     : out STD_LOGIC;
            SenderRingBufferSlotTypeStatus : out STD_LOGIC;
            SenderRingBufferSlotsFilled    : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            SenderRingBufferDataRead       : in  STD_LOGIC;
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            SenderRingBufferDataEnable     : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
            SenderRingBufferData           : out STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            SenderRingBufferAddress        : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            -- 
            ClientIPAddress                : in  STD_LOGIC_VECTOR(31 downto 0);
            ClientUDPPort                  : in  STD_LOGIC_VECTOR(15 downto 0);
            UDPPacketLength                : in  STD_LOGIC_VECTOR(15 downto 0);
            axis_tuser                     : in  STD_LOGIC;
            axis_tdata                     : in  STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            axis_tvalid                    : in  STD_LOGIC;
            axis_tready                    : out STD_LOGIC;
            axis_tkeep                     : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
            axis_tlast                     : in  STD_LOGIC
        );
    end component udpdatapacker;

    component udpdatastripper is
	generic(
		G_SLOT_WIDTH : natural := 4;
		G_ADDR_WIDTH : natural := 5
	);
	port(
		axis_clk                 : in  STD_LOGIC;
		axis_reset               : in  STD_LOGIC;
		EthernetMACEnable        : in  STD_LOGIC;
		-- Packet Readout in addressed bus format
		RecvRingBufferSlotID     : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
		RecvRingBufferSlotClear  : out STD_LOGIC;
		RecvRingBufferSlotStatus : in  STD_LOGIC;
		RecvRingBufferDataRead   : out STD_LOGIC;
		-- Enable[0] is a special bit (we assume always 1 when packet is valid)
		-- we use it to save TLAST
		RecvRingBufferDataEnable : in  STD_LOGIC_VECTOR(63 downto 0);
		RecvRingBufferDataOut    : in  STD_LOGIC_VECTOR(511 downto 0);
		RecvRingBufferAddress    : out STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
		--
		UDPPacketLength          : out STD_LOGIC_VECTOR(15 downto 0);
        --
		axis_tuser               : out STD_LOGIC;
		axis_tdata               : out STD_LOGIC_VECTOR(511 downto 0);
		axis_tvalid              : out STD_LOGIC;
		axis_tready              : in  STD_LOGIC;
		axis_tkeep               : out STD_LOGIC_VECTOR(63 downto 0);
		axis_tlast               : out STD_LOGIC
	);
    end component udpdatastripper;
	component dualportpacketringbuffer is
		generic(
		    G_SLOT_WIDTH : natural := 4;
		    G_ADDR_WIDTH : natural := 8;
		    G_DATA_WIDTH : natural := 64
		);
		port(
		    RxClk                  : in  STD_LOGIC;
		    TxClk                  : in  STD_LOGIC;
		    -- Transmission port
		    TxPacketByteEnable     : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
		    TxPacketDataRead       : in  STD_LOGIC;
		    TxPacketData           : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
		    TxPacketAddress        : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
		    TxPacketSlotClear      : in  STD_LOGIC;
		    TxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
		    TxPacketSlotStatus     : out STD_LOGIC;
		    TxPacketSlotTypeStatus : out STD_LOGIC;
		    -- Reception port
		    RxPacketByteEnable     : in  STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
		    RxPacketDataWrite      : in  STD_LOGIC;
		    RxPacketData           : in  STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
		    RxPacketAddress        : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
		    RxPacketSlotSet        : in  STD_LOGIC;
		    RxPacketSlotID         : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
		    RxPacketSlotType       : in  STD_LOGIC;
		    RxPacketSlotStatus     : out STD_LOGIC;
		    RxPacketSlotTypeStatus : out STD_LOGIC
		);
	end component dualportpacketringbuffer;
    constant G_SLOT_WIDTH      : natural := 4;
    constant G_ADDR_WIDTH      : natural := 5;
	constant G_DATA_WIDTH      : natural := 512;
    constant G_AXIS_DATA_WIDTH : natural := 512;
    constant G_ARP_CACHE_ASIZE : natural := 9;
    constant G_ARP_DATA_WIDTH  : natural := 32;

    signal axis_clk                       : STD_LOGIC                                              := '0';
    signal axis_reset                     : STD_LOGIC                                              := '0';
    signal EthernetMACEnable              : STD_LOGIC                                              := '1';
	signal RecvRingBufferSlotID           : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
	signal RecvRingBufferSlotClear        : STD_LOGIC;
	signal RecvRingBufferSlotStatus       : STD_LOGIC := '0';
	signal RecvRingBufferDataRead   	  : STD_LOGIC;
	signal RecvRingBufferDataEnable 	  : STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0) := (others => '0');
	signal RecvRingBufferDataOut    	  : STD_LOGIC_VECTOR(G_DATA_WIDTH-1 downto 0) := (others => '0');
	signal RecvRingBufferAddress    	  : STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
    signal UDPPacketLength                : STD_LOGIC_VECTOR(15 downto 0);
    signal axis_tuser                     : STD_LOGIC;
    signal axis_tdata                     : STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
    signal axis_tvalid                    : STD_LOGIC;
    signal axis_tready                    : STD_LOGIC := '0';
    signal axis_tkeep                     : STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
    signal axis_tlast                     : STD_LOGIC;
	signal RxPacketByteEnable     		  : STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0) := (others => '0');
	signal RxPacketDataWrite      		  : STD_LOGIC := '0';
	signal RxPacketData           		  : STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0) := (others => '0');
	signal RxPacketAddress        		  : STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0) := (others => '0');
	signal RxPacketSlotSet        		  : STD_LOGIC := '0';
	signal RxPacketSlotID         		  : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0) := (others => '0');
	signal RxPacketSlotType       		  : STD_LOGIC := '0';

    signal EthernetMACAddress             : STD_LOGIC_VECTOR(47 downto 0)                          := (others => '0');
    signal LocalIPAddress                 : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal LocalIPNetmask                 : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal GatewayIPAddress               : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal MulticastIPAddress             : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal MulticastIPNetmask             : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal TXOverflowCount                : STD_LOGIC_VECTOR(31 downto 0);
    signal TXAFullCount                   : STD_LOGIC_VECTOR(31 downto 0);
    signal ServerUDPPort                  : STD_LOGIC_VECTOR(15 downto 0)                          := (others => '0');
    signal ARPReadDataEnable              : STD_LOGIC;
    signal ARPReadData                    : STD_LOGIC_VECTOR((G_ARP_DATA_WIDTH * 2) - 1 downto 0)  := (others => '0');
    signal ARPReadAddress                 : STD_LOGIC_VECTOR(G_ARP_CACHE_ASIZE - 1 downto 0);
    signal SenderRingBufferSlotID         : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0)            := (others => '0');
    signal SenderRingBufferSlotClear      : STD_LOGIC                                              := '0';
    signal SenderRingBufferSlotStatus     : STD_LOGIC;
    signal SenderRingBufferSlotTypeStatus : STD_LOGIC;
    signal SenderRingBufferSlotsFilled    : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
    signal SenderRingBufferDataRead       : STD_LOGIC                                              := '0';
    signal SenderRingBufferDataEnable     : STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
    signal SenderRingBufferData           : STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
    signal SenderRingBufferAddress        : STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0)            := (others => '0');
    signal ClientIPAddress                : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal ClientUDPPort                  : STD_LOGIC_VECTOR(15 downto 0)                          := (others => '0');


    constant C_CLK_PERIOD                 : time                                                   := 10 ns;
begin
    axis_clk           <= not axis_clk after C_CLK_PERIOD / 2;
    axis_reset         <= '1', '0' after C_CLK_PERIOD * 10;
    LocalIPAddress     <= X"C0A8_640A"; --192.168.100.10/24
    LocalIPNetmask     <= X"FFFF_FF00"; --255.255.255.0
    GatewayIPAddress   <= X"C0A8_6401"; --192.168.100.1
    MulticastIPAddress <= X"EFA8_640A"; --239.168.100.10/16
    MulticastIPNetmask <= X"FFFF_0000"; --255.255.0.0
    EthernetMACAddress <= X"000A_3502_4192";
    EthernetMACEnable  <= '1';
    ARPReadData        <= X"0000_506b_4bc3_fbac";
    ClientIPAddress    <= X"C0A8_6496"; --192.168.100.150 (within netmask)

    DPRBi : udpdatapacker
        generic map(
            G_SLOT_WIDTH      => G_SLOT_WIDTH,
            G_AXIS_DATA_WIDTH => G_AXIS_DATA_WIDTH,
            G_ARP_CACHE_ASIZE => G_ARP_CACHE_ASIZE,
            G_ARP_DATA_WIDTH  => G_ARP_DATA_WIDTH,
            G_ADDR_WIDTH      => G_ADDR_WIDTH
        )
        port map(
            axis_clk                       => axis_clk,
            axis_app_clk                   => axis_clk,
            axis_reset                     => axis_reset,
            EthernetMACAddress             => EthernetMACAddress,
            LocalIPAddress                 => LocalIPAddress,
            LocalIPNetmask                 => LocalIPNetmask,
            GatewayIPAddress               => GatewayIPAddress,
            MulticastIPAddress             => MulticastIPAddress,
            MulticastIPNetmask             => MulticastIPNetmask,
            EthernetMACEnable              => EthernetMACEnable,
            TXOverflowCount                => TXOverflowCount,
            TXAFullCount                   => TXAFullCount,
            ServerUDPPort                  => ServerUDPPort,
            ARPReadDataEnable              => ARPReadDataEnable,
            ARPReadData                    => ARPReadData,
            ARPReadAddress                 => ARPReadAddress,
            SenderRingBufferSlotID         => SenderRingBufferSlotID,
            SenderRingBufferSlotClear      => SenderRingBufferSlotClear,
            SenderRingBufferSlotStatus     => SenderRingBufferSlotStatus,
            SenderRingBufferSlotTypeStatus => SenderRingBufferSlotTypeStatus,
            SenderRingBufferSlotsFilled    => SenderRingBufferSlotsFilled,
            SenderRingBufferDataRead       => SenderRingBufferDataRead,
            SenderRingBufferDataEnable     => SenderRingBufferDataEnable,
            SenderRingBufferData           => SenderRingBufferData,
            SenderRingBufferAddress        => SenderRingBufferAddress,
            ClientIPAddress                => ClientIPAddress,
            ClientUDPPort                  => ClientUDPPort,
            UDPPacketLength                => UDPPacketLength,
            axis_tuser                     => axis_tuser,
            axis_tdata                     => axis_tdata,
            axis_tready                    => axis_tready,
            axis_tkeep                     => axis_tkeep,
            axis_tvalid                    => axis_tvalid,
            axis_tlast                     => axis_tlast
        );

	RBi:dualportpacketringbuffer 
		generic map(
		    G_SLOT_WIDTH => G_SLOT_WIDTH,
		    G_ADDR_WIDTH => G_ADDR_WIDTH,
		    G_DATA_WIDTH => G_DATA_WIDTH
		)
		port map(
		    RxClk                  => axis_clk,
		    TxClk                  => axis_clk,
		    TxPacketByteEnable     => RecvRingBufferDataEnable,
		    TxPacketDataRead       => RecvRingBufferDataRead,
		    TxPacketData           => RecvRingBufferDataOut,
		    TxPacketAddress        => RecvRingBufferAddress,
		    TxPacketSlotClear      => RecvRingBufferSlotClear,
		    TxPacketSlotID         => RecvRingBufferSlotID,
		    TxPacketSlotStatus     => RecvRingBufferSlotStatus,
		    TxPacketSlotTypeStatus => open,
		    -- Reception port
		    RxPacketByteEnable     => RxPacketByteEnable,
		    RxPacketDataWrite      => RxPacketDataWrite,
		    RxPacketData           => RxPacketData,
		    RxPacketAddress        => RxPacketAddress,
		    RxPacketSlotSet        => RxPacketSlotSet,
		    RxPacketSlotID         => RxPacketSlotID,
		    RxPacketSlotType       => RxPacketSlotType,
		    RxPacketSlotStatus     => open,
		    RxPacketSlotTypeStatus => open
		);
    DSRBi : udpdatastripper
        generic map(
            G_SLOT_WIDTH      => G_SLOT_WIDTH,
            G_ADDR_WIDTH      => G_ADDR_WIDTH
        )
        port map(
            axis_clk                       => axis_clk,
            axis_reset                     => axis_reset,
            UDPPacketLength                => UDPPacketLength,
			EthernetMACEnable			   => EthernetMACEnable,
			RecvRingBufferSlotID     	   => RecvRingBufferSlotID,
	 		RecvRingBufferSlotClear   	   => RecvRingBufferSlotClear,
	 		RecvRingBufferSlotStatus       => RecvRingBufferSlotStatus,
	 		RecvRingBufferDataRead         => RecvRingBufferDataRead,
	 		RecvRingBufferDataEnable       => RecvRingBufferDataEnable,
	 		RecvRingBufferDataOut          => RecvRingBufferDataOut,
	 		RecvRingBufferAddress          => RecvRingBufferAddress,
            axis_tuser                     => axis_tuser,
            axis_tdata                     => axis_tdata,
            axis_tready                    => axis_tready,
            axis_tkeep                     => axis_tkeep,
            axis_tvalid                    => axis_tvalid,
            axis_tlast                     => axis_tlast
        );

    SimProcProc : process
    begin
        RxPacketDataWrite     	<= '0';
		RxPacketAddress         <= B"00000";
		wait for C_CLK_PERIOD*5;
        RxPacketData      		<= X"ffffffff0020ffffffff0000ffffffff00000000f4ad87f2de03b8d910279664a8c00a64a8c05f1b11400040aad1f20300450008924102350a00acfbc34b6b50";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00000";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"ffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00001";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"0020200000000000200000000020200000000000aa9955660020ffffffff0000ffffffff0020112200440000000000bb0020ffffffff0000ffffffff0020ffff";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00010";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"20000000002020000000070020000000003020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00011";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"0000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff2000000000c0";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00100";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"002020000000000020000000002020000000000020000000002020000000000020000000002020000000ffff20000000ffff20000000bb0020000000ffff2000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00101";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"20000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00110";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"00000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"00111";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"00202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01000";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000002020000000000020000000002020000000000020000000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01001";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf400000000200000000000200000000000200000000000200000000000200000000000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01010";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01011";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"0000000000002000bb000000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01100";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"0000000000000020000000200000000020000000000000000020000099aa00000000200066550000ffffffff0000ffff000000002000ffff0000440022110000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01101";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"00000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000";
        RxPacketByteEnable      <= X"fffffffffffffffe";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01110";
		wait for C_CLK_PERIOD;
        RxPacketData      		<= X"ffff000000000000002000000020ffff0000ffff000000000000002000000020c000000020000000000000000020000000200007000030000000000000000020";
        RxPacketByteEnable      <= X"ffffffffffffffff";
        RxPacketDataWrite     	<= '1';
		RxPacketAddress         <= B"01111";
		wait for C_CLK_PERIOD;
        RxPacketSlotID      	<= B"0000";
        RxPacketSlotSet      	<= '1';
		wait for C_CLK_PERIOD;
        RxPacketSlotSet      	<= '0';
		wait for 400 ns;
		-- Terminate the simulation
		std.env.finish;		
    end process SimProcProc;

end architecture rtl;
