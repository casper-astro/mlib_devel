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
-- Module Name      : udpdatapacker_tb - rtl                                   -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module test the udpdatapacker statemachine          -
--                                                                             -
-- Dependencies     : udpdatapacker                                            -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udpdatapacker_tb is
end entity udpdatapacker_tb;

architecture rtl of udpdatapacker_tb is
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
    constant G_SLOT_WIDTH      : natural := 4;
    constant G_AXIS_DATA_WIDTH : natural := 512;
    constant G_ARP_CACHE_ASIZE : natural := 9;
    constant G_ARP_DATA_WIDTH  : natural := 32;
    constant G_ADDR_WIDTH      : natural := 5;

    signal axis_clk                       : STD_LOGIC                                              := '0';
    signal axis_reset                     : STD_LOGIC                                              := '0';
    signal EthernetMACAddress             : STD_LOGIC_VECTOR(47 downto 0)                          := (others => '0');
    signal LocalIPAddress                 : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal LocalIPNetmask                 : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal GatewayIPAddress               : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal MulticastIPAddress             : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal MulticastIPNetmask             : STD_LOGIC_VECTOR(31 downto 0)                          := (others => '0');
    signal EthernetMACEnable              : STD_LOGIC                                              := '0';
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
    signal UDPPacketLength                : STD_LOGIC_VECTOR(15 downto 0)                          := (others => '0');
    signal axis_tuser                     : STD_LOGIC                                              := '0';
    signal axis_tdata                     : STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0)       := (others => '0');
    signal axis_tvalid                    : STD_LOGIC                                              := '0';
    signal axis_tready                    : STD_LOGIC;
    signal axis_tkeep                     : STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0) := (others => '0');
    signal axis_tlast                     : STD_LOGIC                                              := '0';
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
    DSRBi : udpdatapacker
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

    SimProcProc : process
    begin
        wait until axis_tready = '1';
        axis_tdata  <= (others => '0');
        axis_tkeep  <= (others => '0');
        axis_tuser  <= '0';
        axis_tvalid <= '0';
        axis_tlast  <= '0';
        wait for C_CLK_PERIOD * 100;
        -- Packet to send 10 bytes (The Ethernet MAC will zeropad the 10byte data to make the packet 64 bytes)
        --        ClientUDPPort   <= X"d6a6";
        --        ServerUDPPort   <= X"2710";
        --        UDPPacketLength <= X"000A";--                                                                        CKSM PR TL FOSS  IDE LEN DSC VIHL                       
        --        axis_tdata      <= X"883be4970000000000000000ffffffff0000000001ad_200b_1200_a6d6_1027_9664a8c0_0a64a8c0_3d0e_11_40_0040_98e2_2600_00_45_0008924102350a00acfbc34b6b50";
        --        axis_tkeep      <= X"0fffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '1';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;

        --        wait until axis_tready = '1';
        -- Packet to send 978 bytes
        ClientUDPPort   <= X"ba49";
        ServerUDPPort   <= X"2710";
        --UDPPacketLength <= X"03da";--                                                                         CKSM PR TL FOSS  IDE LEN DSC VIHL
        UDPPacketLength <= X"03d2";--                                                                       CKSM PR TL FOSS  IDE LEN DSC VIHL
        axis_tdata    <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0_fc68_11_40_0040_1184_ee03_00_45_0008924102350a00acfbc34b6b50";       
        --axis_tdata      <= X"0000000000000000000000000000000002000000f5ad_bbd2_e203_49ba_1027_9664a8c00a64a8c0_f268_11_40_0040_1384_f603_00_45_0008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000aa0200000000003000000000012000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"eaae00003000000100000004580d0000300020010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000040000000000000004000000000000000000040000000003000405d000000045a0d000030002001000020000000000000000001000030008001000078ce";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000004000000000000000400000000000000000004000000000000000400000000000000000004000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"000044040000000004040000000000000000000000000000000000000000000000000d5a00000000003000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000200000000adf500000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"0000000000000000000000000000000000000000000002aa00003000000000000000000000000000200100000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000891272630000000000000000000000000000000000000000000000000000000000000000000000008912726300000000";
        axis_tkeep      <= X"000000000000000f";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        wait for C_CLK_PERIOD * 10;




        -- Packet to send 10 bytes (The Ethernet MAC will zeropad the 10byte data to make the packet 64 bytes)
        --        ClientUDPPort   <= X"d6a6";
        --        ServerUDPPort   <= X"2710";
        --        UDPPacketLength <= X"000A";--                                                                        CKSM PR TL FOSS  IDE LEN DSC VIHL                       
        --        axis_tdata      <= X"883be4970000000000000000ffffffff0000000001ad_200b_1200_a6d6_1027_9664a8c0_0a64a8c0_3d0e_11_40_0040_98e2_2600_00_45_0008924102350a00acfbc34b6b50";
        --        axis_tkeep      <= X"0fffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '1';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;

        --        wait until axis_tready = '1';
        -- Packet to send 978 bytes
        --ClientUDPPort   <= X"ba49";
        --ServerUDPPort   <= X"2710";
        --UDPPacketLength <= X"03da";--                                                                         CKSM PR TL FOSS  IDE LEN DSC VIHL
        --UDPPacketLength <= X"03d2";--                                                                       CKSM PR TL FOSS  IDE LEN DSC VIHL
        axis_tdata    <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0_fc68_11_40_0040_1184_ee03_00_45_0008924102350a00acfbc34b6b50";       
        --axis_tdata      <= X"0000000000000000000000000000000002000000f5ad_bbd2_e203_49ba_1027_9664a8c00a64a8c0_f268_11_40_0040_1384_f603_00_45_0008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000aa0200000000003000000000012000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"eaae00003000000100000004580d0000300020010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000040000000000000004000000000000000000040000000003000405d000000045a0d000030002001000020000000000000000001000030008001000078ce";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000000000400000000000000040000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000004000000000000000400000000000000000004000000000000000400000000000000000004000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"000044040000000004040000000000000000000000000000000000000000000000000d5a00000000003000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000200000000adf500000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"0000000000000000000000000000000000000000000002aa00003000000000000000000000000000200100000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '0';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --wait until axis_tready = '1';
        axis_tdata      <= X"00000000000000000000000000000000891272630000000000000000000000000000000000000000000000000000000000000000000000008912726300000000";
        axis_tkeep      <= X"000000000000000f";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        wait for C_CLK_PERIOD * 10;
        -- Send 8 back to back 64 byte transfers
        axis_tdata    <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0_fc68_11_40_0040_1184_ee03_00_45_0008924102350a00acfbc34b6b50";       
        --axis_tdata      <= X"0000000000000000000000000000000002000000f5ad_bbd2_e203_49ba_1027_9664a8c00a64a8c0_f268_11_40_0040_1384_f603_00_45_0008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD*8;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        wait for C_CLK_PERIOD * 10;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        wait for C_CLK_PERIOD * 10;
        -- Send a 64 byte transfer
        axis_tdata    <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0_fc68_11_40_0040_1184_ee03_00_45_0008924102350a00acfbc34b6b50";       
        --axis_tdata      <= X"0000000000000000000000000000000002000000f5ad_bbd2_e203_49ba_1027_9664a8c00a64a8c0_f268_11_40_0040_1384_f603_00_45_0008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        wait for C_CLK_PERIOD * 10;        
        -- Send a 64 byte transfer
        axis_tdata    <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0_fc68_11_40_0040_1184_ee03_00_45_0008924102350a00acfbc34b6b50";       
        --axis_tdata      <= X"0000000000000000000000000000000002000000f5ad_bbd2_e203_49ba_1027_9664a8c00a64a8c0_f268_11_40_0040_1384_f603_00_45_0008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        wait for C_CLK_PERIOD * 10;        
        -- Send a 64 byte transfer
        axis_tdata    <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0_fc68_11_40_0040_1184_ee03_00_45_0008924102350a00acfbc34b6b50";       
        --axis_tdata      <= X"0000000000000000000000000000000002000000f5ad_bbd2_e203_49ba_1027_9664a8c00a64a8c0_f268_11_40_0040_1384_f603_00_45_0008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"ffffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        wait for C_CLK_PERIOD * 10;        


        --        
        --        
        --        
        --        wait until axis_tready = '1';
        --        -- Packet to send 978 bytes
        --        ClientUDPPort   <= X"ba49";
        --        ServerUDPPort   <= X"2710";
        --        UDPPacketLength <= X"03d2";--                                                                       CKSM PR TL FOSS  IDE LEN DSC VIHL
        --        axis_tdata      <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0_fc68_11_40_0040_1184_ee03_00_45_0008924102350a00acfbc34b6b50";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"ffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0020200000000000200000000020200000000000aa9955660020ffffffff0000ffffffff0020112200440000000000bb0020ffffffff0000ffffffff0020ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000002020000000070020000000003020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff2000000000c0";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"002020000000000020000000002020000000000020000000002020000000000020000000002020000000ffff20000000ffff20000000bb0020000000ffff2000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf300000000200000000000200000000000200000000000200000000000200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf300000000200000000000200000000000200000000000200000000000200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000000000002000bb000000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000000000000020000000200000000020000000000000000020000099aa00000000200066550000ffffffff0000ffff000000002000ffff0000440022110000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"243a993e00000000002000000020ffff0000ffff000000000000002000000020c000000020000000000000000020000000200007000030000000000000000020";
        --        axis_tkeep      <= X"0fffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '1';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        axis_tdata      <= (others => '0');
        --        axis_tkeep      <= (others => '0');
        --        axis_tuser      <= '0';
        --        axis_tvalid     <= '0';
        --        axis_tlast      <= '0';
        --        wait for C_CLK_PERIOD * 10;
        --        

        -- Send 4 back to back 64byte packets
        wait until axis_tready = '1';
        -- Packet to send 10 bytes (The Ethernet MAC will zeropad the 10byte data to make the packet 64 bytes)
        ClientUDPPort   <= X"d6a6";
        ServerUDPPort   <= X"2710";
        UDPPacketLength <= X"000A";
        axis_tdata      <= X"883be4970000000000000000ffffffff0000000001ad_200b_1200_a6d6_1027_9664a8c00a64a8c03d0e1140004098e2260000450008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"0fffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        wait until axis_tready = '1';
        -- Packet to send 10 bytes (The Ethernet MAC will zeropad the 10byte data to make the packet 64 bytes)
        ClientUDPPort   <= X"d6a6";
        ServerUDPPort   <= X"2710";
        UDPPacketLength <= X"000A";
        axis_tdata      <= X"883be4970000000000000000ffffffff0000000001ad_200b_1200_a6d6_1027_9664a8c00a64a8c03d0e1140004098e2260000450008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"0fffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        wait until axis_tready = '1';
        -- Packet to send 10 bytes (The Ethernet MAC will zeropad the 10byte data to make the packet 64 bytes)
        ClientUDPPort   <= X"d6a6";
        ServerUDPPort   <= X"2710";
        UDPPacketLength <= X"000A";
        axis_tdata      <= X"883be4970000000000000000ffffffff0000000001ad_200b_1200_a6d6_1027_9664a8c00a64a8c03d0e1140004098e2260000450008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"0fffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        wait until axis_tready = '1';
        -- Packet to send 10 bytes (The Ethernet MAC will zeropad the 10byte data to make the packet 64 bytes)
        ClientUDPPort   <= X"d6a6";
        ServerUDPPort   <= X"2710";
        UDPPacketLength <= X"000A";
        axis_tdata      <= X"883be4970000000000000000ffffffff0000000001ad_200b_1200_a6d6_1027_9664a8c00a64a8c03d0e1140004098e2260000450008924102350a00acfbc34b6b50";
        axis_tkeep      <= X"0fffffffffffffff";
        axis_tvalid     <= '1';
        axis_tlast      <= '1';
        axis_tuser      <= '0';
        wait for C_CLK_PERIOD;
        --        
        --        wait until axis_tready = '1';
        --        -- Send back to back 978 bytes also
        --        -- Packet to send 978 bytes
        --        ClientUDPPort   <= X"ba49";
        --        ServerUDPPort   <= X"2710";
        --        UDPPacketLength <= X"03d2";
        --        axis_tdata      <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0fc68114000401184ee0300450008924102350a00acfbc34b6b50";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"ffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0020200000000000200000000020200000000000aa9955660020ffffffff0000ffffffff0020112200440000000000bb0020ffffffff0000ffffffff0020ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000002020000000070020000000003020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff2000000000c0";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"002020000000000020000000002020000000000020000000002020000000000020000000002020000000ffff20000000ffff20000000bb0020000000ffff2000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf300000000200000000000200000000000200000000000200000000000200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf300000000200000000000200000000000200000000000200000000000200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000000000002000bb000000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000000000000020000000200000000020000000000000000020000099aa00000000200066550000ffffffff0000ffff000000002000ffff0000440022110000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"243a993e00000000002000000020ffff0000ffff000000000000002000000020c000000020000000000000000020000000200007000030000000000000000020";
        --        axis_tkeep      <= X"0fffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '1';
        --        axis_tuser      <= '0';
        --        wait until axis_tready = '1';
        --        -- Packet to send 978 bytes
        --        ClientUDPPort   <= X"ba49";
        --        ServerUDPPort   <= X"2710";
        --        UDPPacketLength <= X"03d2";
        --        axis_tdata      <= X"ffffffff0020ffffffff0000ffffffff00000000f3ad_0033_da03_49ba_1027_9664a8c00a64a8c0fc68114000401184ee0300450008924102350a00acfbc34b6b50";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"ffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000ffffffff0020ffffffff0000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0020200000000000200000000020200000000000aa9955660020ffffffff0000ffffffff0020112200440000000000bb0020ffffffff0000ffffffff0020ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000002020000000070020000000003020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff20000000ffff2000000000c0";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"002020000000000020000000002020000000000020000000002020000000000020000000002020000000ffff20000000ffff20000000bb0020000000ffff2000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000200000000020200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000000000002000000000202000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"20000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000000020000000002020000000000020000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf300000000200000000000200000000000200000000000200000000000200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"000000002000ffff0000ffffffff0000ffff000000000000ffff0000adf300000000200000000000200000000000200000000000200000000000200000000000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000000000002000bb000000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff0000ffffffff0000ffff000000002000ffff";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"0000000000000020000000200000000020000000000000000020000099aa00000000200066550000ffffffff0000ffff000000002000ffff0000440022110000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"00000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000000000000000002000000020000000002000";
        --        axis_tkeep      <= X"ffffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '0';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        --        wait until axis_tready = '1';
        --        axis_tdata      <= X"243a993e00000000002000000020ffff0000ffff000000000000002000000020c000000020000000000000000020000000200007000030000000000000000020";
        --        axis_tkeep      <= X"0fffffffffffffff";
        --        axis_tvalid     <= '1';
        --        axis_tlast      <= '1';
        --        axis_tuser      <= '0';
        --        wait for C_CLK_PERIOD;
        axis_tdata      <= (others => '0');
        axis_tkeep      <= (others => '0');
        axis_tuser      <= '0';
        axis_tvalid     <= '0';
        axis_tlast      <= '0';
        -- Terminate the simulation
        wait;
    end process SimProcProc;

end architecture rtl;
