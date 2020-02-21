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
-- Module Name      : udpstreamingapps - rtl                                   -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module instantiates data streaming apps over UDP    -
--                                                                             -
-- Dependencies     : udpstreamingapp,axisfabricmultiplexer                    -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity udpstreamingapps is
    generic(
        G_AXIS_DATA_WIDTH            : natural              := 512;
        G_SLOT_WIDTH                 : natural              := 4;
        -- Number of UDP Streaming Data Server Modules 
        G_NUM_STREAMING_DATA_SERVERS : natural range 1 to 4 := 1;
        G_ARP_CACHE_ASIZE            : natural              := 9;
        G_ARP_DATA_WIDTH             : natural              := 32
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
        ARPReadDataEnable                           : out  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        ARPReadData                                 : in STD_LOGIC_VECTOR((G_NUM_STREAMING_DATA_SERVERS * (G_ARP_DATA_WIDTH * 2)) - 1 downto 0);
        ARPReadAddress                              : out  STD_LOGIC_VECTOR((G_NUM_STREAMING_DATA_SERVERS * G_ARP_CACHE_ASIZE) - 1 downto 0);
        ------------------------------------------------------------------------
        -- Yellow Block Data Interface                                        --
        -- These can be many AXIS interfaces denoted by axis_data{n}_tx/rx    --
        -- where {n} = G_NUM_STREAMING_DATA_SERVERS.                          --
        -- Each of them run on their own clock.                               --
        -- Aggregate data rate for all modules combined must be less than 100G--                                --
        -- Each module in a PR configuration makes a PR boundary.             --
        ------------------------------------------------------------------------
        -- Streaming data clocks 
        axis_streaming_data_clk                     : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        axis_streaming_data_rx_packet_length        : out STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);                             
        -- Streaming data outputs to AXIS of the Yellow Blocks
        axis_streaming_data_rx_tdata                : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_rx_tvalid               : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        axis_streaming_data_rx_tready               : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        axis_streaming_data_rx_tkeep                : out STD_LOGIC_VECTOR(((G_AXIS_DATA_WIDTH / 8) * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_rx_tlast                : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        axis_streaming_data_rx_tuser                : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        --Data inputs from AXIS bus of the Yellow Blocks
        axis_streaming_data_tx_destination_ip       : in  STD_LOGIC_VECTOR((32 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_tx_destination_udp_port : in  STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_tx_source_udp_port      : in  STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_tx_packet_length        : in  STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);                             
        axis_streaming_data_tx_tdata                : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_tx_tvalid               : in  STD_LOGIC_VECTOR((G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_tx_tuser                : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        axis_streaming_data_tx_tkeep                : in  STD_LOGIC_VECTOR(((G_AXIS_DATA_WIDTH / 8) * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
        axis_streaming_data_tx_tlast                : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
        axis_streaming_data_tx_tready               : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
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
end entity udpstreamingapps;

architecture rtl of udpstreamingapps is

    component udpstreamingapp is
        generic(
            G_AXIS_DATA_WIDTH : natural := 512;
            G_SLOT_WIDTH      : natural := 4;
            G_ARP_CACHE_ASIZE : natural := 13;
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
            axis_streaming_data_rx_packet_length        : out STD_LOGIC_VECTOR(15 downto 0);                                 
            -- Streaming data outputs to AXIS of the Yellow Blocks
            axis_streaming_data_rx_tdata                : out STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            axis_streaming_data_rx_tvalid               : out STD_LOGIC;
            axis_streaming_data_rx_tready               : in  STD_LOGIC;
            axis_streaming_data_rx_tkeep                : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
            axis_streaming_data_rx_tlast                : out STD_LOGIC;
            axis_streaming_data_rx_tuser                : out STD_LOGIC;
            --Data inputs from AXIS bus of the Yellow Blocks
            axis_streaming_data_tx_destination_ip       : in  STD_LOGIC_VECTOR(31 downto 0);
            axis_streaming_data_tx_destination_udp_port : in  STD_LOGIC_VECTOR(15 downto 0);
            axis_streaming_data_tx_source_udp_port      : in  STD_LOGIC_VECTOR(15 downto 0);
            axis_streaming_data_tx_packet_length        : in  STD_LOGIC_VECTOR(15 downto 0);                                 
            axis_streaming_data_tx_tdata                : in  STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            axis_streaming_data_tx_tvalid               : in  STD_LOGIC;
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
    end component udpstreamingapp;

    component axisfabricmultiplexer is
        generic(
            G_MUX_PORTS              : natural := 4;
            G_MAX_PACKET_BLOCKS_SIZE : natural := 64;
            G_PRIORITY_WIDTH         : natural := 4;
            G_DATA_WIDTH             : natural := 8
        );
        port(
            axis_clk          : in  STD_LOGIC;
            axis_reset        : in  STD_LOGIC;
            --Inputs from AXIS bus of the MAC side
            --Outputs to AXIS bus MAC side 
            axis_tx_tpriority : out STD_LOGIC_VECTOR(G_PRIORITY_WIDTH - 1 downto 0);
            axis_tx_tdata     : out STD_LOGIC_VECTOR(G_DATA_WIDTH - 1 downto 0);
            axis_tx_tvalid    : out STD_LOGIC;
            axis_tx_tready    : in  STD_LOGIC;
            axis_tx_tkeep     : out STD_LOGIC_VECTOR((G_DATA_WIDTH / 8) - 1 downto 0);
            axis_tx_tlast     : out STD_LOGIC;
            -- Port N
            axis_rx_tpriority : in  STD_LOGIC_VECTOR((G_MUX_PORTS * G_PRIORITY_WIDTH) - 1 downto 0);
            axis_rx_tdata     : in  STD_LOGIC_VECTOR((G_MUX_PORTS * G_DATA_WIDTH) - 1 downto 0);
            axis_rx_tvalid    : in  STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0);
            axis_rx_tready    : out STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0);
            axis_rx_tkeep     : in  STD_LOGIC_VECTOR((G_MUX_PORTS * (G_DATA_WIDTH / 8)) - 1 downto 0);
            axis_rx_tlast     : in  STD_LOGIC_VECTOR(G_MUX_PORTS - 1 downto 0)
        );
    end component axisfabricmultiplexer;
    type dwordarray_t is array (0 to (G_NUM_STREAMING_DATA_SERVERS - 1)) of std_logic_vector(31 downto 0);

    signal gmac_reg_tx_overflow_count    : dwordarray_t;
    signal gmac_reg_tx_afull_count       : dwordarray_t;
    signal gmac_reg_rx_overflow_count    : dwordarray_t;
    signal gmac_reg_rx_almost_full_count : dwordarray_t;
    signal gmac_reg_tx_overflow_sum      : std_logic_vector(31 downto 0);
    signal gmac_reg_tx_afull_sum         : std_logic_vector(31 downto 0);
    signal gmac_reg_rx_overflow_sum      : std_logic_vector(31 downto 0);
    signal gmac_reg_rx_almost_full_sum   : std_logic_vector(31 downto 0);
    signal axis_mux_tpriority            : STD_LOGIC_VECTOR((G_NUM_STREAMING_DATA_SERVERS * G_SLOT_WIDTH) - 1 downto 0);
    signal axis_mux_tdata                : STD_LOGIC_VECTOR((G_NUM_STREAMING_DATA_SERVERS * G_AXIS_DATA_WIDTH) - 1 downto 0);
    signal axis_mux_tvalid               : STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
    signal axis_mux_tready               : STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
    signal axis_mux_tkeep                : STD_LOGIC_VECTOR((G_NUM_STREAMING_DATA_SERVERS * (G_AXIS_DATA_WIDTH / 8)) - 1 downto 0);
    signal axis_mux_tlast                : STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);

begin
    aximm_gmac_reg_tx_overflow_count    <= gmac_reg_tx_overflow_sum;
    aximm_gmac_reg_tx_afull_count       <= gmac_reg_tx_afull_sum;
    aximm_gmac_reg_rx_overflow_count    <= gmac_reg_rx_overflow_sum;
    aximm_gmac_reg_rx_almost_full_count <= gmac_reg_rx_almost_full_sum;

    SumProc : process(axis_clk)
    begin
        -- Add the different counter channels to produce a sum value of the 
        -- channel statistics. 
        if rising_edge(axis_clk) then
            if (axis_reset = '1') then
                gmac_reg_tx_overflow_sum    <= (others => '0');
                gmac_reg_tx_afull_sum       <= (others => '0');
                gmac_reg_rx_overflow_sum    <= (others => '0');
                gmac_reg_rx_almost_full_sum <= (others => '0');
            else
                for i in 0 to (G_NUM_STREAMING_DATA_SERVERS - 1) loop
                    gmac_reg_tx_overflow_sum    <= std_logic_vector(unsigned(gmac_reg_tx_overflow_sum) + unsigned(gmac_reg_tx_overflow_count(i)));
                    gmac_reg_tx_afull_sum       <= std_logic_vector(unsigned(gmac_reg_tx_afull_sum) + unsigned(gmac_reg_tx_afull_count(i)));
                    gmac_reg_rx_overflow_sum    <= std_logic_vector(unsigned(gmac_reg_rx_overflow_sum) + unsigned(gmac_reg_rx_overflow_count(i)));
                    gmac_reg_rx_almost_full_sum <= std_logic_vector(unsigned(gmac_reg_rx_almost_full_sum) + unsigned(gmac_reg_rx_almost_full_count(i)));

                end loop;
            end if;
        end if;
    end process SumProc;

    UDPAPPSi : for i in 0 to G_NUM_STREAMING_DATA_SERVERS - 1 generate
    begin
        UDPAPPi : udpstreamingapp
            generic map(
                G_AXIS_DATA_WIDTH => G_AXIS_DATA_WIDTH,
                G_SLOT_WIDTH      => G_SLOT_WIDTH,
                G_ARP_CACHE_ASIZE => G_ARP_CACHE_ASIZE,
                G_ARP_DATA_WIDTH  => G_ARP_DATA_WIDTH
            )
            port map(
                -- Axis clock is the Ethernet module clock running at 322.625MHz
                axis_clk                                    => axis_clk,
                -- Axis reset is the global synchronous reset to the highest clock
                axis_reset                                  => axis_reset,
                ------------------------------------------------------------------------
                -- AXILite slave Interface                                            --
                -- This interface is for register access as the the Ethernet Core     --
                -- memory map, this core has mac & phy registers, arp cache and also  --
                -- cpu transmit and receive buffers                                   --
                ------------------------------------------------------------------------
                aximm_gmac_reg_mac_address                  => aximm_gmac_reg_mac_address,
                aximm_gmac_reg_local_ip_address             => aximm_gmac_reg_local_ip_address,
                aximm_gmac_reg_gateway_ip_address           => aximm_gmac_reg_gateway_ip_address,
                aximm_gmac_reg_multicast_ip_address         => aximm_gmac_reg_multicast_ip_address,
                aximm_gmac_reg_multicast_ip_mask            => aximm_gmac_reg_multicast_ip_mask,
                aximm_gmac_reg_mac_enable                   => aximm_gmac_reg_mac_enable,
                aximm_gmac_reg_tx_overflow_count            => gmac_reg_tx_overflow_count(i),
                aximm_gmac_reg_tx_afull_count               => gmac_reg_tx_afull_count(i),
                aximm_gmac_reg_rx_overflow_count            => gmac_reg_rx_overflow_count(i),
                aximm_gmac_reg_rx_almost_full_count         => gmac_reg_rx_almost_full_count(i),
                -- ARP Cache Read Interface for IP transmit mapping                   --
                ------------------------------------------------------------------------ 
                ARPReadDataEnable                           => ARPReadDataEnable(i),
                ARPReadData                                 => ARPReadData(((i + 1) * (G_ARP_DATA_WIDTH * 2)) - 1 downto ((i) * (G_ARP_DATA_WIDTH * 2))),
                ARPReadAddress                              => ARPReadAddress(((i + 1) * (G_ARP_CACHE_ASIZE)) - 1 downto ((i) * (G_ARP_CACHE_ASIZE))),
                ------------------------------------------------------------------------
                -- Yellow Block Data Interface                                        --
                ------------------------------------------------------------------------
                -- Streaming data clock 
                axis_streaming_data_clk                     => axis_streaming_data_clk(i),
                axis_streaming_data_rx_packet_length        => axis_streaming_data_rx_packet_length(((i + 1) * 16) - 1 downto ((i) * 16)),                                 
                -- Streaming data outputs to AXIS of the Yellow Blocks
                axis_streaming_data_rx_tdata                => axis_streaming_data_rx_tdata(((i + 1) * G_AXIS_DATA_WIDTH) - 1 downto ((i) * G_AXIS_DATA_WIDTH)),
                axis_streaming_data_rx_tvalid               => axis_streaming_data_rx_tvalid(i),
                axis_streaming_data_rx_tready               => axis_streaming_data_rx_tready(i),
                axis_streaming_data_rx_tkeep                => axis_streaming_data_rx_tkeep(((i + 1) * (G_AXIS_DATA_WIDTH / 8)) - 1 downto ((i) * (G_AXIS_DATA_WIDTH / 8))),
                axis_streaming_data_rx_tlast                => axis_streaming_data_rx_tlast(i),
                axis_streaming_data_rx_tuser                => axis_streaming_data_rx_tuser(i),
                --Data inputs from AXIS bus of the Yellow Blocks
                axis_streaming_data_tx_destination_ip       => axis_streaming_data_tx_destination_ip(((i + 1) * 32) - 1 downto ((i) * 32)),
                axis_streaming_data_tx_destination_udp_port => axis_streaming_data_tx_destination_udp_port(((i + 1) * 16) - 1 downto ((i) * 16)),
                axis_streaming_data_tx_source_udp_port      => axis_streaming_data_tx_source_udp_port(((i + 1) * 16) - 1 downto ((i) * 16)),
                axis_streaming_data_tx_packet_length        => axis_streaming_data_tx_packet_length(((i + 1) * 16) - 1 downto ((i) * 16)),                                
                axis_streaming_data_tx_tdata                => axis_streaming_data_tx_tdata(((i + 1) * G_AXIS_DATA_WIDTH) - 1 downto ((i) * G_AXIS_DATA_WIDTH)),
                axis_streaming_data_tx_tvalid               => axis_streaming_data_tx_tvalid(i),
                axis_streaming_data_tx_tuser                => axis_streaming_data_tx_tuser(i),
                axis_streaming_data_tx_tkeep                => axis_streaming_data_tx_tkeep(((i + 1) * (G_AXIS_DATA_WIDTH / 8)) - 1 downto ((i) * (G_AXIS_DATA_WIDTH / 8))),
                axis_streaming_data_tx_tlast                => axis_streaming_data_tx_tlast(i),
                axis_streaming_data_tx_tready               => axis_streaming_data_tx_tready(i),
                ------------------------------------------------------------------------
                -- Ethernet MAC Streaming Interface                                   --
                ------------------------------------------------------------------------
                -- Outputs to AXIS bus MAC side 
                axis_tx_tpriority                           => axis_mux_tpriority(((i + 1) * G_SLOT_WIDTH) - 1 downto ((i) * G_SLOT_WIDTH)),
                axis_tx_tdata                               => axis_mux_tdata(((i + 1) * G_AXIS_DATA_WIDTH) - 1 downto ((i) * G_AXIS_DATA_WIDTH)),
                axis_tx_tvalid                              => axis_mux_tvalid(i),
                axis_tx_tready                              => axis_mux_tready(i),
                axis_tx_tkeep                               => axis_mux_tkeep(((i + 1) * (G_AXIS_DATA_WIDTH / 8)) - 1 downto ((i) * (G_AXIS_DATA_WIDTH / 8))),
                axis_tx_tlast                               => axis_mux_tlast(i),
                --Inputs from AXIS bus of the MAC side
                axis_rx_tdata                               => axis_rx_tdata,
                axis_rx_tvalid                              => axis_rx_tvalid,
                axis_rx_tuser                               => axis_rx_tuser,
                axis_rx_tkeep                               => axis_rx_tkeep,
                axis_rx_tlast                               => axis_rx_tlast
            );
    end generate UDPAPPSi;

    MUXGEN : if G_NUM_STREAMING_DATA_SERVERS > 1 generate
    begin
        -- Multiplex all data into 
        FABMUXi : axisfabricmultiplexer
            generic map(
                G_MUX_PORTS              => G_NUM_STREAMING_DATA_SERVERS,
                G_MAX_PACKET_BLOCKS_SIZE => 64,
                G_PRIORITY_WIDTH         => G_SLOT_WIDTH,
                G_DATA_WIDTH             => G_AXIS_DATA_WIDTH
            )
            port map(
                axis_clk          => axis_clk,
                axis_reset        => axis_reset,
                --Inputs from AXIS bus of the MAC side
                --Outputs to AXIS bus MAC side 
                axis_tx_tpriority => axis_tx_tpriority,
                axis_tx_tdata     => axis_tx_tdata,
                axis_tx_tvalid    => axis_tx_tvalid,
                axis_tx_tready    => axis_tx_tready,
                axis_tx_tkeep     => axis_tx_tkeep,
                axis_tx_tlast     => axis_tx_tlast,
                -- Port N
                axis_rx_tpriority => axis_mux_tpriority,
                axis_rx_tdata     => axis_mux_tdata,
                axis_rx_tvalid    => axis_mux_tvalid,
                axis_rx_tready    => axis_mux_tready,
                axis_rx_tkeep     => axis_mux_tkeep,
                axis_rx_tlast     => axis_mux_tlast
            );
    end generate MUXGEN;

    THRUGEN : if G_NUM_STREAMING_DATA_SERVERS = 1 generate
    begin
        -- Pass data as is 
        -- Port N
        axis_tx_tpriority  <= axis_mux_tpriority;
        axis_tx_tdata      <= axis_mux_tdata;
        axis_tx_tvalid     <= axis_mux_tvalid(0);
        axis_mux_tready(0) <= axis_tx_tready;
        axis_tx_tkeep      <= axis_mux_tkeep;
        axis_tx_tlast      <= axis_mux_tlast(0);
    end generate THRUGEN;

end architecture rtl;
