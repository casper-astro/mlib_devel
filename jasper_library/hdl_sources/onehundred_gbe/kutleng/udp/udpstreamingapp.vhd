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
-- Module Name      : udpstreamingapp - rtl                                    -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module performs data streaming over UDP             -
--                                                                             -
-- Dependencies     : macifudpserver,udpdatastripper,udpdatapacker             -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udpstreamingapp is
    generic(
        G_AXIS_DATA_WIDTH : natural := 512;
        G_SLOT_WIDTH      : natural := 4;
        G_ARP_CACHE_ASIZE : natural := 9;
        G_ARP_DATA_WIDTH  : natural := 32
    );
    port(
        -- Axis clock is the Ethernet module clock running at 322.625MHz
        axis_clk                                    : in  STD_LOGIC;
        -- Axis reset is the global synchronous reset to the highest clock
        axis_reset                                  : in  STD_LOGIC;
        ------------------------------------------------------------------------
        -- AXILite slave Interface                                            --
        -- This interface is for register access as the the Ethernet Core     --
        -- memory map, this core has mac & phy registers, arp cache and also  --
        -- cpu transmit and receive buffers                                   --
        ------------------------------------------------------------------------
        aximm_gmac_reg_mac_address                  : in  STD_LOGIC_VECTOR(47 downto 0);
        aximm_gmac_reg_local_ip_address             : in  STD_LOGIC_VECTOR(31 downto 0);
        aximm_gmac_reg_gateway_ip_address           : in  STD_LOGIC_VECTOR(31 downto 0);
        aximm_gmac_reg_multicast_ip_address         : in  STD_LOGIC_VECTOR(31 downto 0);
        aximm_gmac_reg_multicast_ip_mask            : in  STD_LOGIC_VECTOR(31 downto 0);
        aximm_gmac_reg_mac_enable                   : in  STD_LOGIC;
        aximm_gmac_reg_tx_overflow_count            : out STD_LOGIC_VECTOR(31 downto 0);
        aximm_gmac_reg_tx_afull_count               : out STD_LOGIC_VECTOR(31 downto 0);
        aximm_gmac_reg_rx_overflow_count            : out STD_LOGIC_VECTOR(31 downto 0);
        aximm_gmac_reg_rx_almost_full_count         : out STD_LOGIC_VECTOR(31 downto 0);
        -- ARP Cache Read Interface for IP transmit mapping                   --
        ------------------------------------------------------------------------ 
        ARPReadDataEnable                           : out STD_LOGIC;
        ARPReadData                                 : in  STD_LOGIC_VECTOR((G_ARP_DATA_WIDTH * 2) - 1 downto 0);
        ARPReadAddress                              : out STD_LOGIC_VECTOR(G_ARP_CACHE_ASIZE - 1 downto 0);
        ------------------------------------------------------------------------
        -- Yellow Block Data Interface                                        --
        ------------------------------------------------------------------------
        -- Streaming data clock 
        axis_streaming_data_clk                     : in  STD_LOGIC;
        -- Received data packet length 
        axis_streaming_data_rx_packet_length        : out STD_LOGIC_VECTOR(15 downto 0);        
        -- Streaming data outputs to AXIS of the Yellow Blocks
        axis_streaming_data_rx_tdata                : out STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
        axis_streaming_data_rx_tvalid               : out STD_LOGIC;
        axis_streaming_data_rx_tready               : in  STD_LOGIC;
        axis_streaming_data_rx_tkeep                : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
        axis_streaming_data_rx_tlast                : out STD_LOGIC;
        axis_streaming_data_rx_tuser                : out STD_LOGIC;
        --Data inputs from AXIS bus of the Yellow Blocks
        -- The destination IP is used as follows:
        -- If it is within the local range 
        --    then the destination_ip and  local_ip are used
        -- If it is outside of the network range
        --    then the gateway_ip and local_ip are used
        -- If is is a multicast ip within the multicast group range
        --    then the destination_ip and multicast_ip are used  
        axis_streaming_data_tx_destination_ip       : in  STD_LOGIC_VECTOR(31 downto 0);
        -- The destination IP port
        axis_streaming_data_tx_destination_udp_port : in  STD_LOGIC_VECTOR(15 downto 0);
        -- The source server port (must be unique for each and every streaming app
        -- unless it is a bandwidth agregation app
        axis_streaming_data_tx_source_udp_port      : in  STD_LOGIC_VECTOR(15 downto 0);
        axis_streaming_data_tx_packet_length        : in  STD_LOGIC_VECTOR(15 downto 0);
        axis_streaming_data_tx_tdata                : in  STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
        axis_streaming_data_tx_tvalid               : in  STD_LOGIC;
        -- TUSER(0) is for dropping an error packet
        -- TSUER(1) functions like Start of Frame to load
        -- IP addressing
        axis_streaming_data_tx_tuser                : in  STD_LOGIC;
        axis_streaming_data_tx_tkeep                : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
        axis_streaming_data_tx_tlast                : in  STD_LOGIC;
        axis_streaming_data_tx_tready               : out STD_LOGIC;
        ------------------------------------------------------------------------
        -- Ethernet MAC Streaming Interface                                   --
        ------------------------------------------------------------------------
        -- Outputs to AXIS bus MAC side 
        axis_tx_tpriority                           : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
        axis_tx_tdata                               : out STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
        axis_tx_tvalid                              : out STD_LOGIC;
        axis_tx_tready                              : in  STD_LOGIC;
        axis_tx_tkeep                               : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
        axis_tx_tlast                               : out STD_LOGIC;
        --Inputs from AXIS bus of the MAC side
        axis_rx_tdata                               : in  STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
        axis_rx_tvalid                              : in  STD_LOGIC;
        axis_rx_tuser                               : in  STD_LOGIC;
        axis_rx_tkeep                               : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
        axis_rx_tlast                               : in  STD_LOGIC
    );
end entity udpstreamingapp;

architecture rtl of udpstreamingapp is

    component macifudpserver is
        generic(
            G_SLOT_WIDTH : natural := 4;
            -- The address width is log2(2048/(512/8))=5 bits wide
            G_ADDR_WIDTH : natural := 5
        );
        port(
            axis_clk                       : in  STD_LOGIC;
            axis_app_clk                   : in  STD_LOGIC;            
            axis_reset                     : in  STD_LOGIC;
            -- Setup information
            ServerMACAddress               : in  STD_LOGIC_VECTOR(47 downto 0);
            ServerIPAddress                : in  STD_LOGIC_VECTOR(31 downto 0);
            ServerUDPPort                  : in  STD_LOGIC_VECTOR(15 downto 0);
            -- MAC Statistics
            RXOverFlowCount                : out STD_LOGIC_VECTOR(31 downto 0);
            RXAlmostFullCount              : out STD_LOGIC_VECTOR(31 downto 0);
            -- Packet Readout in addressed bus format
            RecvRingBufferSlotID           : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            RecvRingBufferSlotClear        : in  STD_LOGIC;
            RecvRingBufferSlotStatus       : out STD_LOGIC;
            RecvRingBufferSlotTypeStatus   : out STD_LOGIC;
            RecvRingBufferSlotsFilled      : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            RecvRingBufferDataRead         : in  STD_LOGIC;
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            RecvRingBufferDataEnable       : out STD_LOGIC_VECTOR(63 downto 0);
            RecvRingBufferDataOut          : out STD_LOGIC_VECTOR(511 downto 0);
            RecvRingBufferAddress          : in  STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            -- Packet Readout in addressed bus format
            SenderRingBufferSlotID         : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            SenderRingBufferSlotClear      : out STD_LOGIC;
            SenderRingBufferSlotStatus     : in  STD_LOGIC;
            SenderRingBufferSlotTypeStatus : in  STD_LOGIC;
            SenderRingBufferSlotsFilled    : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            SenderRingBufferDataRead       : out STD_LOGIC;
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            SenderRingBufferDataEnable     : in  STD_LOGIC_VECTOR(63 downto 0);
            SenderRingBufferDataIn         : in  STD_LOGIC_VECTOR(511 downto 0);
            SenderRingBufferAddress        : out STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            --Inputs from AXIS bus of the MAC side
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority              : out STD_LOGIC_VECTOR(3 downto 0);
            axis_tx_tdata                  : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tx_tvalid                 : out STD_LOGIC;
            axis_tx_tready                 : in  STD_LOGIC;
            axis_tx_tkeep                  : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tx_tlast                  : out STD_LOGIC;
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata                  : in  STD_LOGIC_VECTOR(511 downto 0);
            axis_rx_tvalid                 : in  STD_LOGIC;
            axis_rx_tuser                  : in  STD_LOGIC;
            axis_rx_tkeep                  : in  STD_LOGIC_VECTOR(63 downto 0);
            axis_rx_tlast                  : in  STD_LOGIC
        );
    end component macifudpserver;

    component udpdatastripper is
        generic(
            G_SLOT_WIDTH : natural := 4;
            G_ADDR_WIDTH : natural := 5
        );
        port(
            axis_clk                     : in  STD_LOGIC;
            axis_reset                   : in  STD_LOGIC;
            EthernetMACEnable            : in  STD_LOGIC;
            -- Packet Readout in addressed bus format
            RecvRingBufferSlotID         : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            RecvRingBufferSlotClear      : out STD_LOGIC;
            RecvRingBufferSlotStatus     : in  STD_LOGIC;
            RecvRingBufferDataRead       : out STD_LOGIC;
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            RecvRingBufferDataEnable     : in  STD_LOGIC_VECTOR(63 downto 0);
            RecvRingBufferDataOut        : in  STD_LOGIC_VECTOR(511 downto 0);
            RecvRingBufferAddress        : out STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
            --
            UDPPacketLength              : out STD_LOGIC_VECTOR(15 downto 0);
            --
            axis_tuser                   : out STD_LOGIC;
            axis_tdata                   : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tvalid                  : out STD_LOGIC;
            axis_tready                  : in  STD_LOGIC;
            axis_tkeep                   : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tlast                   : out STD_LOGIC
        );
    end component udpdatastripper;

    component udpdatapacker is
        generic(
            G_SLOT_WIDTH      : natural := 4;
            G_ARP_CACHE_ASIZE : natural := 13;
            G_ARP_DATA_WIDTH  : natural := 32; -- The address width is log2(2048/(512/8))=5 bits wide
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
    constant G_ADDR_WIDTH                : natural := 5;
    signal UDPRXRingBufferSlotID         : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
    signal UDPRXRingBufferSlotClear      : STD_LOGIC;
    signal UDPRXRingBufferSlotStatus     : STD_LOGIC;
    signal UDPRXRingBufferDataRead       : STD_LOGIC;
    signal UDPRXRingBufferDataEnable     : STD_LOGIC_VECTOR(63 downto 0);
    signal UDPRXRingBufferData           : STD_LOGIC_VECTOR(511 downto 0);
    signal UDPRXRingBufferAddress        : STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
    signal UDPTXRingBufferSlotID         : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
    signal UDPTXRingBufferSlotClear      : STD_LOGIC;
    signal UDPTXRingBufferSlotStatus     : STD_LOGIC;
    signal UDPTXRingBufferSlotTypeStatus : STD_LOGIC;
    signal UDPTXRingBufferSlotsFilled    : STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
    signal UDPTXRingBufferDataRead       : STD_LOGIC;
    signal UDPTXRingBufferDataEnable     : STD_LOGIC_VECTOR(63 downto 0);
    signal UDPTXRingBufferData           : STD_LOGIC_VECTOR(511 downto 0);
    signal UDPTXRingBufferAddress        : STD_LOGIC_VECTOR(G_ADDR_WIDTH - 1 downto 0);
begin

    UDPRECEIVER_i : udpdatastripper
        generic map(
            G_SLOT_WIDTH => G_SLOT_WIDTH,
            G_ADDR_WIDTH => G_ADDR_WIDTH
        )
        port map(
            axis_clk                     => axis_streaming_data_clk,
            axis_reset                   => axis_reset,
            EthernetMACEnable            => aximm_gmac_reg_mac_enable,
            -- Packet Readout in addressed bus format
            RecvRingBufferSlotID         => UDPRXRingBufferSlotID,
            RecvRingBufferSlotClear      => UDPRXRingBufferSlotClear,
            RecvRingBufferSlotStatus     => UDPRXRingBufferSlotStatus,
            RecvRingBufferDataRead       => UDPRXRingBufferDataRead,
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            RecvRingBufferDataEnable     => UDPRXRingBufferDataEnable,
            RecvRingBufferDataOut        => UDPRXRingBufferData,
            RecvRingBufferAddress        => UDPRXRingBufferAddress,
            UDPPacketLength              => axis_streaming_data_rx_packet_length,            
            -- Receive AXIS interface
            axis_tuser                   => axis_streaming_data_rx_tuser,
            axis_tdata                   => axis_streaming_data_rx_tdata,
            axis_tvalid                  => axis_streaming_data_rx_tvalid,
            axis_tready                  => axis_streaming_data_rx_tready,
            axis_tkeep                   => axis_streaming_data_rx_tkeep,
            axis_tlast                   => axis_streaming_data_rx_tlast
        );

    UDPAPPSENDER_i : udpdatapacker
        generic map(
            G_SLOT_WIDTH      => G_SLOT_WIDTH,
            G_ARP_CACHE_ASIZE => G_ARP_CACHE_ASIZE,
            G_ARP_DATA_WIDTH  => G_ARP_DATA_WIDTH,
            G_ADDR_WIDTH      => G_ADDR_WIDTH
        )
        port map(
            axis_clk                       => axis_clk,
            axis_app_clk                   => axis_streaming_data_clk,
            axis_reset                     => axis_reset,
            EthernetMACAddress             => aximm_gmac_reg_mac_address,
            LocalIPAddress                 => aximm_gmac_reg_local_ip_address,
            LocalIPNetmask                 => aximm_gmac_reg_multicast_ip_mask,
            GatewayIPAddress               => aximm_gmac_reg_gateway_ip_address,
            MulticastIPAddress             => aximm_gmac_reg_multicast_ip_address,
            MulticastIPNetmask             => aximm_gmac_reg_multicast_ip_mask,
            EthernetMACEnable              => aximm_gmac_reg_mac_enable,
            TXOverflowCount                => aximm_gmac_reg_tx_overflow_count,
            TXAFullCount                   => aximm_gmac_reg_tx_afull_count,
            ARPReadDataEnable              => ARPReadDataEnable,
            ARPReadData                    => ARPReadData,
            ARPReadAddress                 => ARPReadAddress,
            -- Packet Readout in addressed bus format
            SenderRingBufferSlotID         => UDPTXRingBufferSlotID,
            SenderRingBufferSlotClear      => UDPTXRingBufferSlotClear,
            SenderRingBufferSlotStatus     => UDPTXRingBufferSlotStatus,
            SenderRingBufferSlotTypeStatus => UDPTXRingBufferSlotTypeStatus,
            SenderRingBufferSlotsFilled    => UDPTXRingBufferSlotsFilled,
            SenderRingBufferDataRead       => UDPTXRingBufferDataRead,
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST                                 
            SenderRingBufferDataEnable     => UDPTXRingBufferDataEnable,
            SenderRingBufferData           => UDPTXRingBufferData,
            SenderRingBufferAddress        => UDPTXRingBufferAddress,
            ClientIPAddress                => axis_streaming_data_tx_destination_ip,
            ClientUDPPort                  => axis_streaming_data_tx_destination_udp_port,
            ServerUDPPort                  => axis_streaming_data_tx_source_udp_port,
            UDPPacketLength                => axis_streaming_data_tx_packet_length,
            axis_tuser                     => axis_streaming_data_tx_tuser,
            axis_tdata                     => axis_streaming_data_tx_tdata,
            axis_tvalid                    => axis_streaming_data_tx_tvalid,
            axis_tready                    => axis_streaming_data_tx_tready,
            axis_tkeep                     => axis_streaming_data_tx_tkeep,
            axis_tlast                     => axis_streaming_data_tx_tlast
        );
    UDPDATAApp_i : macifudpserver
        generic map(
            G_SLOT_WIDTH => G_SLOT_WIDTH,
            G_ADDR_WIDTH => G_ADDR_WIDTH
        )
        port map(
            axis_clk                       => axis_clk,
            axis_app_clk                   => axis_streaming_data_clk,
            axis_reset                     => axis_reset,
            -- Setup information
            ServerMACAddress               => aximm_gmac_reg_mac_address,
            ServerIPAddress                => aximm_gmac_reg_local_ip_address,
            ServerUDPPort                  => axis_streaming_data_tx_source_udp_port,
            -- MAC Statistics
            RXOverFlowCount                => aximm_gmac_reg_rx_overflow_count,
            RXAlmostFullCount              => aximm_gmac_reg_rx_almost_full_count,
            -- Packet Readout in addressed bus format
            RecvRingBufferSlotID           => UDPRXRingBufferSlotID,
            RecvRingBufferSlotClear        => UDPRXRingBufferSlotClear,
            RecvRingBufferSlotStatus       => UDPRXRingBufferSlotStatus,
            RecvRingBufferSlotTypeStatus   => open,
            RecvRingBufferSlotsFilled      => open,
            RecvRingBufferDataRead         => UDPRXRingBufferDataRead,
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST
            RecvRingBufferDataEnable       => UDPRXRingBufferDataEnable,
            RecvRingBufferDataOut          => UDPRXRingBufferData,
            RecvRingBufferAddress          => UDPRXRingBufferAddress,
            -- Packet Readout in addressed bus format
            SenderRingBufferSlotID         => UDPTXRingBufferSlotID,
            SenderRingBufferSlotClear      => UDPTXRingBufferSlotClear,
            SenderRingBufferSlotStatus     => UDPTXRingBufferSlotStatus,
            SenderRingBufferSlotTypeStatus => UDPTXRingBufferSlotTypeStatus,
            SenderRingBufferSlotsFilled    => UDPTXRingBufferSlotsFilled,
            SenderRingBufferDataRead       => UDPTXRingBufferDataRead,
            -- Enable[0] is a special bit (we assume always 1 when packet is valid)
            -- we use it to save TLAST                                 
            SenderRingBufferDataEnable     => UDPTXRingBufferDataEnable,
            SenderRingBufferDataIn         => UDPTXRingBufferData,
            SenderRingBufferAddress        => UDPTXRingBufferAddress,
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority              => axis_tx_tpriority,
            axis_tx_tdata                  => axis_tx_tdata,
            axis_tx_tvalid                 => axis_tx_tvalid,
            axis_tx_tready                 => axis_tx_tready,
            axis_tx_tkeep                  => axis_tx_tkeep,
            axis_tx_tlast                  => axis_tx_tlast,
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata                  => axis_rx_tdata,
            axis_rx_tvalid                 => axis_rx_tvalid,
            axis_rx_tuser                  => axis_rx_tuser,
            axis_rx_tkeep                  => axis_rx_tkeep,
            axis_rx_tlast                  => axis_rx_tlast
        );

end architecture rtl;
