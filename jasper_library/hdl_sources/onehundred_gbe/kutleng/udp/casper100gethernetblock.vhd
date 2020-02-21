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
-- Module Name      : casper100gethernetblock - rtl                            -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module instantiates two QSFP28+ ports with CMACs.   -
--                    The udpipinterfacepr module is instantiated to connect   -
--                    UDP functionality on QSFP28+[1].                         -
--                    To test bandwidth the testcomms module is instantiated on-
--                    QSFP28+[2].                                              -
-- Dependencies     : mac100gphy,microblaze_axi_us_plus_wrapper,clockgen100mhz,-
--                    testcomms,udpipinterfacepr,pciexdma_refbd_wrapper.       -
--                    partialblinker,ledflasher,ICAP3E                         -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity casper100gethernetblock is
    generic(
        -- Boolean to include or not include ICAP for partial reconfiguration
        G_INCLUDE_ICAP               : boolean              := false;
        -- Streaming data size (must be 512)
        G_AXIS_DATA_WIDTH            : natural              := 512;
        -- Number of UDP Streaming Data Server Modules 
        G_NUM_STREAMING_DATA_SERVERS : natural range 1 to 4 := 1
    );
    port(
        -- 100MHz reference clock needed by 100G Ethernet PHY
        -- This must be a stable 100MHz clock as per the 100G PHY requirements 
        RefClk100MHz                                : in  std_logic;
        -- Clock locked signal to control operations to be halted until clocks 
        -- are stable.  
        RefClkLocked                                : in  std_logic;
        -- Aximm clock is the AXI Lite MM clock for the gmac register interface
        -- Usually 125MHz 
        aximm_clk                                   : in  STD_LOGIC;
        -- ICAP is the 125MHz ICAP clock used for PR
        icap_clk                                    : in  STD_LOGIC;
        -- Axis reset is the global synchronous reset to the highest clock
        axis_reset                                  : in  STD_LOGIC;
        -- Ethernet reference clock for 156.25MHz
        -- QSFP+ 1
        mgt_qsfp_clock_p                            : in  STD_LOGIC;
        mgt_qsfp_clock_n                            : in  STD_LOGIC;
        --RX     
        qsfp_mgt_rx_p                               : in  STD_LOGIC_VECTOR(3 downto 0);
        qsfp_mgt_rx_n                               : in  STD_LOGIC_VECTOR(3 downto 0);
        -- TX
        qsfp_mgt_tx_p                               : out STD_LOGIC_VECTOR(3 downto 0);
        qsfp_mgt_tx_n                               : out STD_LOGIC_VECTOR(3 downto 0);
        -- Settings
        qsfp_modsell_ls                             : out STD_LOGIC;
        qsfp_resetl_ls                              : out STD_LOGIC;
        qsfp_modprsl_ls                             : in  STD_LOGIC;
        qsfp_intl_ls                                : in  STD_LOGIC;
        qsfp_lpmode_ls                              : out STD_LOGIC;
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
        axis_streaming_data_tx_tready               : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0)
    );
end entity casper100gethernetblock;

architecture rtl of casper100gethernetblock is
    constant C_PR_SERVER_PORT           : natural range 0 to ((2**16) - 1) := 20000;
    constant C_ARP_CACHE_ASIZE          : natural                          := 10;
    constant C_CPU_TX_DATA_BUFFER_ASIZE : natural                          := 11;
    constant C_CPU_RX_DATA_BUFFER_ASIZE : natural                          := 11;
    constant C_SLOT_WIDTH               : natural                          := 4;
    constant C_ARP_DATA_WIDTH           : natural                          := 32;

    component udpipinterfacepr is
        generic(
            G_INCLUDE_ICAP               : boolean                          := false;
            G_AXIS_DATA_WIDTH            : natural                          := 512;
            G_SLOT_WIDTH                 : natural                          := 4;
            -- Number of UDP Streaming Data Server Modules 
            G_NUM_STREAMING_DATA_SERVERS : natural range 1 to 4             := 1;
            G_ARP_CACHE_ASIZE            : natural                          := 10;
            G_ARP_DATA_WIDTH             : natural                          := 32;
            G_CPU_TX_DATA_BUFFER_ASIZE   : natural                          := 11;
            G_CPU_RX_DATA_BUFFER_ASIZE   : natural                          := 11;
            G_PR_SERVER_PORT             : natural range 0 to ((2**16) - 1) := 5
        );
        port(
            -- Axis clock is the Ethernet module clock running at 322.625MHz
            axis_clk                                     : in  STD_LOGIC;
            -- Aximm clock is the AXI Lite MM clock for the gmac register interface
            -- Usually 50MHz 
            aximm_clk                                    : in  STD_LOGIC;
            -- ICAP is the 125MHz ICAP clock used for PR
            icap_clk                                     : in  STD_LOGIC;
            -- Axis reset is the global synchronous reset to the highest clock
            axis_reset                                   : in  STD_LOGIC;
            ------------------------------------------------------------------------
            -- AXILite slave Interface                                            --
            -- This interface is for register access as per CASPER Ethernet Core  --
            -- memory map, this core has mac & phy registers, arp cache and also  --
            -- cpu transmit and receive buffers                                   --
            ------------------------------------------------------------------------
            aximm_gmac_reg_phy_control_h                 : in  STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_phy_control_l                 : in  STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_mac_address                   : in  STD_LOGIC_VECTOR(47 downto 0);
            aximm_gmac_reg_local_ip_address              : in  STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_gateway_ip_address            : in  STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_multicast_ip_address          : in  STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_multicast_ip_mask             : in  STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_udp_port                      : in  STD_LOGIC_VECTOR(15 downto 0);
            aximm_gmac_reg_udp_port_mask                 : in  STD_LOGIC_VECTOR(15 downto 0);
            aximm_gmac_reg_mac_enable                    : in  STD_LOGIC;
            aximm_gmac_reg_mac_promiscous_mode           : in  STD_LOGIC;
            aximm_gmac_reg_counters_reset                : in  STD_LOGIC;
            aximm_gmac_reg_core_type                     : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_phy_status_h                  : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_phy_status_l                  : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_tx_packet_rate                : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_tx_packet_count               : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_tx_valid_rate                 : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_tx_valid_count                : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_tx_overflow_count             : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_tx_afull_count                : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_rx_packet_rate                : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_rx_packet_count               : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_rx_valid_rate                 : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_rx_valid_count                : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_rx_overflow_count             : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_rx_almost_full_count          : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_rx_bad_packet_count           : out STD_LOGIC_VECTOR(31 downto 0);
            --
            aximm_gmac_reg_arp_size                      : out STD_LOGIC_VECTOR(31 downto 0);
            aximm_gmac_reg_tx_word_size                  : out STD_LOGIC_VECTOR(15 downto 0);
            aximm_gmac_reg_rx_word_size                  : out STD_LOGIC_VECTOR(15 downto 0);
            aximm_gmac_reg_tx_buffer_max_size            : out STD_LOGIC_VECTOR(15 downto 0);
            aximm_gmac_reg_rx_buffer_max_size            : out STD_LOGIC_VECTOR(15 downto 0);
            ------------------------------------------------------------------------
            -- ARP Cache Write Interface according to EthernetCore Memory MAP     --
            ------------------------------------------------------------------------ 
            aximm_gmac_arp_cache_write_enable            : in  STD_LOGIC;
            aximm_gmac_arp_cache_read_enable             : in  STD_LOGIC;
            aximm_gmac_arp_cache_write_data              : in  STD_LOGIC_VECTOR(G_ARP_DATA_WIDTH - 1 downto 0);
            aximm_gmac_arp_cache_read_data               : out STD_LOGIC_VECTOR(G_ARP_DATA_WIDTH - 1 downto 0);
            aximm_gmac_arp_cache_write_address           : in  STD_LOGIC_VECTOR(G_ARP_CACHE_ASIZE - 1 downto 0);
            aximm_gmac_arp_cache_read_address            : in  STD_LOGIC_VECTOR(G_ARP_CACHE_ASIZE - 1 downto 0);
            ------------------------------------------------------------------------
            -- Transmit Ring Buffer Interface according to EthernetCore Memory MAP--
            ------------------------------------------------------------------------ 
            aximm_gmac_tx_data_write_enable              : in  STD_LOGIC;
            aximm_gmac_tx_data_read_enable               : in  STD_LOGIC;
            aximm_gmac_tx_data_write_data                : in  STD_LOGIC_VECTOR(7 downto 0);
            -- The Byte Enable is as follows
            -- Bit (0-1) Byte Enables
            -- Bit (2) Maps to TLAST (To terminate the data stream).
            aximm_gmac_tx_data_write_byte_enable         : in  STD_LOGIC_VECTOR(1 downto 0);
            aximm_gmac_tx_data_read_data                 : out STD_LOGIC_VECTOR(7 downto 0);
            -- The Byte Enable is as follows
            -- Bit (0-1) Byte Enables
            -- Bit (2) Maps to TLAST (To terminate the data stream).
            aximm_gmac_tx_data_read_byte_enable          : out STD_LOGIC_VECTOR(1 downto 0);
            aximm_gmac_tx_data_write_address             : in  STD_LOGIC_VECTOR(G_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
            aximm_gmac_tx_data_read_address              : in  STD_LOGIC_VECTOR(G_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
            aximm_gmac_tx_ringbuffer_slot_id             : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            aximm_gmac_tx_ringbuffer_slot_set            : in  STD_LOGIC;
            aximm_gmac_tx_ringbuffer_slot_status         : out STD_LOGIC;
            aximm_gmac_tx_ringbuffer_number_slots_filled : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            ------------------------------------------------------------------------
            -- Receive Ring Buffer Interface according to EthernetCore Memory MAP --
            ------------------------------------------------------------------------ 
            aximm_gmac_rx_data_read_enable               : in  STD_LOGIC;
            aximm_gmac_rx_data_read_data                 : out STD_LOGIC_VECTOR(7 downto 0);
            -- The Byte Enable is as follows
            -- Bit (0-1) Byte Enables
            -- Bit (2) Maps to TLAST (To terminate the data stream).        
            aximm_gmac_rx_data_read_byte_enable          : out STD_LOGIC_VECTOR(1 downto 0);
            aximm_gmac_rx_data_read_address              : in  STD_LOGIC_VECTOR(G_CPU_RX_DATA_BUFFER_ASIZE - 1 downto 0);
            aximm_gmac_rx_ringbuffer_slot_id             : in  STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            aximm_gmac_rx_ringbuffer_slot_clear          : in  STD_LOGIC;
            aximm_gmac_rx_ringbuffer_slot_status         : out STD_LOGIC;
            aximm_gmac_rx_ringbuffer_number_slots_filled : out STD_LOGIC_VECTOR(G_SLOT_WIDTH - 1 downto 0);
            ------------------------------------------------------------------------
            -- Yellow Block Data Interface                                        --
            -- These can be many AXIS interfaces denoted by axis_data{n}_tx/rx    --
            -- where {n} = G_NUM_STREAMING_DATA_SERVERS.                          --
            -- Each of them run on their own clock.                               --
            -- Aggregate data rate for all modules combined must be less than 100G--                                --
            -- Each module in a PR configuration makes a PR boundary.             --
            ------------------------------------------------------------------------
            -- Streaming data clocks 
            axis_streaming_data_clk                      : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            axis_streaming_data_rx_packet_length        : out STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);         
            -- Streaming data outputs to AXIS of the Yellow Blocks
            axis_streaming_data_rx_tdata                 : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_rx_tvalid                : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            axis_streaming_data_rx_tready                : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            axis_streaming_data_rx_tkeep                 : out STD_LOGIC_VECTOR(((G_AXIS_DATA_WIDTH / 8) * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_rx_tlast                 : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            axis_streaming_data_rx_tuser                 : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            --Data inputs from AXIS bus of the Yellow Blocks
            axis_streaming_data_tx_destination_ip        : in  STD_LOGIC_VECTOR((32 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_tx_destination_udp_port  : in  STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_tx_source_udp_port       : in  STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_tx_packet_length         : in  STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);                             
            axis_streaming_data_tx_tdata                 : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_tx_tvalid                : in  STD_LOGIC_VECTOR((G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_tx_tuser                 : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            axis_streaming_data_tx_tkeep                 : in  STD_LOGIC_VECTOR(((G_AXIS_DATA_WIDTH / 8) * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);
            axis_streaming_data_tx_tlast                 : in  STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            axis_streaming_data_tx_tready                : out STD_LOGIC_VECTOR(G_NUM_STREAMING_DATA_SERVERS - 1 downto 0);
            ------------------------------------------------------------------------
            -- Ethernet MAC/PHY Control and Statistics Interface                  --
            ------------------------------------------------------------------------
            gmac_reg_core_type                           : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_h                        : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_l                        : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_control_h                       : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_control_l                       : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_rate                      : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_count                     : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_rate                       : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_count                      : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_rate                      : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_count                     : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_rate                       : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_count                      : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_bad_packet_count                 : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_counters_reset                      : out STD_LOGIC;
            gmac_reg_mac_enable                          : out STD_LOGIC;
            ------------------------------------------------------------------------
            -- Ethernet MAC Streaming Interface                                   --
            ------------------------------------------------------------------------
            -- Outputs to AXIS bus MAC side 
            axis_tx_tdata                                : out STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            axis_tx_tvalid                               : out STD_LOGIC;
            axis_tx_tready                               : in  STD_LOGIC;
            axis_tx_tkeep                                : out STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
            axis_tx_tlast                                : out STD_LOGIC;
            axis_tx_tuser                                : out STD_LOGIC;
            --Inputs from AXIS bus of the MAC side
            axis_rx_tdata                                : in  STD_LOGIC_VECTOR(G_AXIS_DATA_WIDTH - 1 downto 0);
            axis_rx_tvalid                               : in  STD_LOGIC;
            axis_rx_tuser                                : in  STD_LOGIC;
            axis_rx_tkeep                                : in  STD_LOGIC_VECTOR((G_AXIS_DATA_WIDTH / 8) - 1 downto 0);
            axis_rx_tlast                                : in  STD_LOGIC
        );
    end component udpipinterfacepr;

    component mac100gphy is
        generic(
            C_MAC_INSTANCE : natural range 0 to 1 := 0
        );
        port(
            -- Ethernet reference clock for 156.25MHz
            -- QSFP+ 
            mgt_qsfp_clock_p             : in  STD_LOGIC;
            mgt_qsfp_clock_n             : in  STD_LOGIC;
            --RX     
            qsfp_mgt_rx_p                : in  STD_LOGIC_VECTOR(3 downto 0);
            qsfp_mgt_rx_n                : in  STD_LOGIC_VECTOR(3 downto 0);
            -- TX
            qsfp_mgt_tx_p                : out STD_LOGIC_VECTOR(3 downto 0);
            qsfp_mgt_tx_n                : out STD_LOGIC_VECTOR(3 downto 0);
            -- Reference clock to generate 100MHz from
            Clk100MHz                    : in  STD_LOGIC;
            ------------------------------------------------------------------------
            -- These signals/busses run at 322.265625MHz clock domain              -
            ------------------------------------------------------------------------
            -- Global System Enable
            Enable                       : in  STD_LOGIC;
            Reset                        : in  STD_LOGIC;
            -- Statistics interface
            gmac_reg_core_type           : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_h        : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_l        : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_control_h       : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_control_l       : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_rate      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_count     : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_rate       : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_count      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_rate      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_count     : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_rate       : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_count      : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_bad_packet_count : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_counters_reset      : in  STD_LOGIC;
            -- Lbus and AXIS
            lbus_reset                   : in  STD_LOGIC;
            -- Overflow signal
            lbus_tx_ovfout               : out STD_LOGIC;
            -- Underflow signal
            lbus_tx_unfout               : out STD_LOGIC;
            -- AXIS Bus
            -- RX Bus
            axis_rx_clkin                : in  STD_LOGIC;
            axis_rx_tdata                : in  STD_LOGIC_VECTOR(511 downto 0);
            axis_rx_tvalid               : in  STD_LOGIC;
            axis_rx_tready               : out STD_LOGIC;
            axis_rx_tkeep                : in  STD_LOGIC_VECTOR(63 downto 0);
            axis_rx_tlast                : in  STD_LOGIC;
            axis_rx_tuser                : in  STD_LOGIC;
            -- TX Bus
            axis_tx_clkout               : out STD_LOGIC;
            axis_tx_tdata                : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tx_tvalid               : out STD_LOGIC;
            axis_tx_tkeep                : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tx_tlast                : out STD_LOGIC;
            -- User signal for errors and dropping of packets
            axis_tx_tuser                : out STD_LOGIC
        );
    end component mac100gphy;

    ----------------------------------------------------------------------------
    --                 Vivado logic analyser test modules                     --
    -- TODO                                                                   --
    -- Remove these for production designs                                    --
    -- They are only here for debug purposes                                  --
    ----------------------------------------------------------------------------
    component axisila is
        port(
            clk     : IN STD_LOGIC;
            probe0  : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
            probe1  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe2  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe3  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            probe4  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe5  : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
            probe6  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe7  : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
            probe8  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe9  : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe10 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe11 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe12 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe13 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe14 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            probe15 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
        );
    end component axisila;

    signal Reset          : std_logic;
    signal lbus_tx_ovfout : std_logic;
    signal lbus_tx_unfout : std_logic;

    signal ClkQSFP : std_logic;

    signal axis_rx_tdata  : STD_LOGIC_VECTOR(511 downto 0);
    signal axis_rx_tvalid : STD_LOGIC;
    signal axis_rx_tkeep  : STD_LOGIC_VECTOR(63 downto 0);
    signal axis_rx_tlast  : STD_LOGIC;
    signal axis_rx_tuser  : STD_LOGIC;

    signal axis_tx_tdata  : STD_LOGIC_VECTOR(511 downto 0);
    signal axis_tx_tvalid : STD_LOGIC;
    signal axis_tx_tkeep  : STD_LOGIC_VECTOR(63 downto 0);
    signal axis_tx_tlast  : STD_LOGIC;
    signal axis_tx_tready : STD_LOGIC;
    signal axis_tx_tuser  : STD_LOGIC;

    signal gmac_reg_phy_control_h                 : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_phy_control_l                 : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_mac_address                   : STD_LOGIC_VECTOR(47 downto 0);
    signal gmac_reg_local_ip_address              : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_gateway_ip_address            : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_multicast_ip_address          : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_multicast_ip_mask             : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_udp_port                      : STD_LOGIC_VECTOR(15 downto 0);
    signal gmac_reg_udp_port_mask                 : STD_LOGIC_VECTOR(15 downto 0);
    signal gmac_reg_mac_enable                    : STD_LOGIC;
    signal gmac_reg_mac_promiscous_mode           : STD_LOGIC;
    signal gmac_reg_counters_reset                : STD_LOGIC;
    signal gmac_reg_core_type                     : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_phy_status_h                  : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_phy_status_l                  : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_tx_packet_rate                : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_tx_packet_count               : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_tx_valid_rate                 : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_tx_valid_count                : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_tx_overflow_count             : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_tx_afull_count                : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_rx_packet_rate                : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_rx_packet_count               : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_rx_valid_rate                 : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_rx_valid_count                : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_rx_overflow_count             : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_rx_almost_full_count          : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_rx_bad_packet_count           : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_arp_size                      : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_reg_tx_word_size                  : STD_LOGIC_VECTOR(15 downto 0);
    signal gmac_reg_rx_word_size                  : STD_LOGIC_VECTOR(15 downto 0);
    signal gmac_reg_tx_buffer_max_size            : STD_LOGIC_VECTOR(15 downto 0);
    signal gmac_reg_rx_buffer_max_size            : STD_LOGIC_VECTOR(15 downto 0);
    signal gmac_arp_cache_write_enable            : STD_LOGIC;
    signal gmac_arp_cache_read_enable             : STD_LOGIC;
    signal gmac_arp_cache_write_data              : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_arp_cache_read_data               : STD_LOGIC_VECTOR(31 downto 0);
    signal gmac_arp_cache_write_address           : STD_LOGIC_VECTOR(C_ARP_CACHE_ASIZE - 1 downto 0);
    signal gmac_arp_cache_read_address            : STD_LOGIC_VECTOR(C_ARP_CACHE_ASIZE - 1 downto 0);
    signal gmac_tx_data_write_enable              : STD_LOGIC;
    signal gmac_tx_data_read_enable               : STD_LOGIC;
    signal gmac_tx_data_write_data                : STD_LOGIC_VECTOR(7 downto 0);
    signal gmac_tx_data_write_byte_enable         : STD_LOGIC_VECTOR(1 downto 0);
    signal gmac_tx_data_read_data                 : STD_LOGIC_VECTOR(7 downto 0);
    signal gmac_tx_data_read_byte_enable          : STD_LOGIC_VECTOR(1 downto 0);
    signal gmac_tx_data_write_address             : STD_LOGIC_VECTOR(C_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
    signal gmac_tx_data_read_address              : STD_LOGIC_VECTOR(C_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
    signal gmac_tx_ringbuffer_slot_id             : STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
    signal gmac_tx_ringbuffer_slot_set            : STD_LOGIC;
    signal gmac_tx_ringbuffer_slot_status         : STD_LOGIC;
    signal gmac_tx_ringbuffer_number_slots_filled : STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
    signal gmac_rx_data_read_enable               : STD_LOGIC;
    signal gmac_rx_data_read_data                 : STD_LOGIC_VECTOR(7 downto 0);
    signal gmac_rx_data_read_byte_enable          : STD_LOGIC_VECTOR(1 downto 0);
    signal gmac_rx_data_read_address              : STD_LOGIC_VECTOR(C_CPU_RX_DATA_BUFFER_ASIZE - 1 downto 0);
    signal gmac_rx_ringbuffer_slot_id             : STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
    signal gmac_rx_ringbuffer_slot_clear          : STD_LOGIC;
    signal gmac_rx_ringbuffer_slot_status         : STD_LOGIC;
    signal gmac_rx_ringbuffer_number_slots_filled : STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);

    signal udp_gmac_reg_core_type           : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_phy_status_h        : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_phy_status_l        : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_phy_control_h       : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_phy_control_l       : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_tx_packet_rate      : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_tx_packet_count     : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_tx_valid_rate       : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_tx_valid_count      : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_rx_packet_rate      : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_rx_packet_count     : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_rx_valid_rate       : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_rx_valid_count      : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_rx_bad_packet_count : STD_LOGIC_VECTOR(31 downto 0);
    signal udp_gmac_reg_counters_reset      : STD_LOGIC;
    signal udp_gmac_reg_mac_enable          : STD_LOGIC;

begin
    Reset <= (not RefClkLocked) or axis_reset;

    ----------------------------------------------------------------------------
    --             Generic QSFP28+ port configuration settings.               --
    ----------------------------------------------------------------------------
    --                             QSFP28+ port 1                             --       
    -- This port is used for all Ethernet communications and is the main port.--       
    ----------------------------------------------------------------------------    
    -- Dont set module to low power mode
    qsfp_lpmode_ls  <= '0';
    -- Dont select the module
    qsfp_modsell_ls <= '1';
    -- Keep the module out of reset    
    qsfp_resetl_ls  <= (not Reset);
    ----------------------------------------------------------------------------
    --          QSFP28+ CMAC0 100G MAC Instance (port 1)                      --
    -- The CMAC resides in the static partition of the design.                --
    -- This is the main data port on the design.                              --
    -- On the VCU118 this is mapped to the top port on the board.             -- 
    ----------------------------------------------------------------------------
    GMAC_i : mac100gphy
        generic map(
            C_MAC_INSTANCE => 0         -- Instantiate CMAC0 QSFP1
        )
        port map(
            Clk100MHz                    => RefClk100MHz,
            Enable                       => udp_gmac_reg_mac_enable,
            Reset                        => Reset,
            gmac_reg_core_type           => udp_gmac_reg_core_type,
            gmac_reg_phy_status_h        => udp_gmac_reg_phy_status_h,
            gmac_reg_phy_status_l        => udp_gmac_reg_phy_status_l,
            gmac_reg_phy_control_h       => udp_gmac_reg_phy_control_h,
            gmac_reg_phy_control_l       => udp_gmac_reg_phy_control_l,
            gmac_reg_tx_packet_rate      => udp_gmac_reg_tx_packet_rate,
            gmac_reg_tx_packet_count     => udp_gmac_reg_tx_packet_count,
            gmac_reg_tx_valid_rate       => udp_gmac_reg_tx_valid_rate,
            gmac_reg_tx_valid_count      => udp_gmac_reg_tx_valid_count,
            gmac_reg_rx_packet_rate      => udp_gmac_reg_rx_packet_rate,
            gmac_reg_rx_packet_count     => udp_gmac_reg_rx_packet_count,
            gmac_reg_rx_valid_rate       => udp_gmac_reg_rx_valid_rate,
            gmac_reg_rx_valid_count      => udp_gmac_reg_rx_valid_count,
            gmac_reg_rx_bad_packet_count => udp_gmac_reg_rx_bad_packet_count,
            gmac_reg_counters_reset      => udp_gmac_reg_counters_reset,
            mgt_qsfp_clock_p             => mgt_qsfp_clock_p,
            mgt_qsfp_clock_n             => mgt_qsfp_clock_n,
            qsfp_mgt_rx_p                => qsfp_mgt_rx_p,
            qsfp_mgt_rx_n                => qsfp_mgt_rx_n,
            qsfp_mgt_tx_p                => qsfp_mgt_tx_p,
            qsfp_mgt_tx_n                => qsfp_mgt_tx_n,
            axis_tx_clkout               => ClkQSFP,
            axis_rx_clkin                => ClkQSFP,
            lbus_tx_ovfout               => lbus_tx_ovfout,
            lbus_tx_unfout               => lbus_tx_unfout,
            lbus_reset                   => Reset,
            axis_rx_tdata                => axis_tx_tdata,
            axis_rx_tvalid               => axis_tx_tvalid,
            axis_rx_tready               => axis_tx_tready,
            axis_rx_tkeep                => axis_tx_tkeep,
            axis_rx_tlast                => axis_tx_tlast,
            axis_rx_tuser                => axis_tx_tuser,
            axis_tx_tdata                => axis_rx_tdata,
            axis_tx_tvalid               => axis_rx_tvalid,
            axis_tx_tkeep                => axis_rx_tkeep,
            axis_tx_tlast                => axis_rx_tlast,
            axis_tx_tuser                => axis_rx_tuser
        );

    ----------------------------------------------------------------------------
    --                 Ethernet UDP/IP Communications module                  --
    -- The UDP/IP module resides in the static partition of the design.       --
    -- This module implements all UDP/IP  communications.                     --
    -- This module supports 9600 jumbo frame packets.                         --
    -- The  module depends on CPU for configuration settings and 100gmac      --    
    -- When C_INCLUDE_ICAP = true partial reconfiguration over UDP is enabled.--
    -- The module gets and sends streaming data using the module apps.        --
    -- All DSP high speed streaming data is connected to this module.         --
    -- To facilitate reaching maximum bandwidth several streaming apps can be --
    -- connected to the module as data sources/sinks.                         --     
    ----------------------------------------------------------------------------
    UDPIPIFFi : udpipinterfacepr
        generic map(
            G_INCLUDE_ICAP               => G_INCLUDE_ICAP,
            G_AXIS_DATA_WIDTH            => G_AXIS_DATA_WIDTH,
            G_SLOT_WIDTH                 => C_SLOT_WIDTH,
            -- Number of UDP Streaming Data Server Modules 
            G_NUM_STREAMING_DATA_SERVERS => G_NUM_STREAMING_DATA_SERVERS,
            G_ARP_CACHE_ASIZE            => C_ARP_CACHE_ASIZE,
            G_ARP_DATA_WIDTH             => C_ARP_DATA_WIDTH,
            G_CPU_TX_DATA_BUFFER_ASIZE   => C_CPU_TX_DATA_BUFFER_ASIZE,
            G_CPU_RX_DATA_BUFFER_ASIZE   => C_CPU_RX_DATA_BUFFER_ASIZE,
            G_PR_SERVER_PORT             => C_PR_SERVER_PORT
        )
        port map(
            axis_clk                                     => ClkQSFP,
            -- Running Microblaze at 125MHz used for ICAP Clocking
            aximm_clk                                    => aximm_clk,
            icap_clk                                     => icap_clk,
            axis_reset                                   => Reset,
            aximm_gmac_reg_phy_control_h                 => x"00000000", --gmac_reg_phy_control_h,
            aximm_gmac_reg_phy_control_l                 => x"00000000", --gmac_reg_phy_control_l,
            aximm_gmac_reg_mac_address                   => x"000000000000", --gmac_reg_mac_address,
            aximm_gmac_reg_local_ip_address              => x"00000000", --gmac_reg_local_ip_address,
            aximm_gmac_reg_gateway_ip_address            => x"00000000", --gmac_reg_gateway_ip_address,
            aximm_gmac_reg_multicast_ip_address          => x"00000000", --gmac_reg_multicast_ip_address,
            aximm_gmac_reg_multicast_ip_mask             => x"00000000", --gmac_reg_multicast_ip_mask,
            aximm_gmac_reg_udp_port                      => x"0000", --gmac_reg_udp_port,
            aximm_gmac_reg_udp_port_mask                 => x"0000", --gmac_reg_udp_port_mask,
            aximm_gmac_reg_mac_enable                    => '1', --gmac_reg_mac_enable,
            aximm_gmac_reg_mac_promiscous_mode           => '1', --gmac_reg_mac_promiscous_mode,
            aximm_gmac_reg_counters_reset                => '0', --gmac_reg_counters_reset,
            aximm_gmac_reg_core_type                     => open, --gmac_reg_core_type,
            aximm_gmac_reg_phy_status_h                  => open, --gmac_reg_phy_status_h,
            aximm_gmac_reg_phy_status_l                  => open, --gmac_reg_phy_status_l,
            aximm_gmac_reg_tx_packet_rate                => open, --gmac_reg_tx_packet_rate,
            aximm_gmac_reg_tx_packet_count               => open, --gmac_reg_tx_packet_count,
            aximm_gmac_reg_tx_valid_rate                 => open, --gmac_reg_tx_valid_rate,
            aximm_gmac_reg_tx_valid_count                => open, --gmac_reg_tx_valid_count,
            aximm_gmac_reg_tx_overflow_count             => open, --gmac_reg_tx_overflow_count,
            aximm_gmac_reg_tx_afull_count                => open, --gmac_reg_tx_afull_count,
            aximm_gmac_reg_rx_packet_rate                => open, --gmac_reg_rx_packet_rate,
            aximm_gmac_reg_rx_packet_count               => open, --gmac_reg_rx_packet_count,
            aximm_gmac_reg_rx_valid_rate                 => open, --gmac_reg_rx_valid_rate,
            aximm_gmac_reg_rx_valid_count                => open, --gmac_reg_rx_valid_count,
            aximm_gmac_reg_rx_overflow_count             => open, --gmac_reg_rx_overflow_count,
            aximm_gmac_reg_rx_almost_full_count          => open, --gmac_reg_rx_almost_full_count,
            aximm_gmac_reg_rx_bad_packet_count           => open, --gmac_reg_rx_bad_packet_count,
            aximm_gmac_reg_arp_size                      => open, --gmac_reg_arp_size,
            aximm_gmac_reg_tx_word_size                  => open, --gmac_reg_tx_word_size,
            aximm_gmac_reg_rx_word_size                  => open, --gmac_reg_rx_word_size,
            aximm_gmac_reg_tx_buffer_max_size            => open, --gmac_reg_tx_buffer_max_size,
            aximm_gmac_reg_rx_buffer_max_size            => open, --gmac_reg_rx_buffer_max_size,
            aximm_gmac_arp_cache_write_enable            => '0', --gmac_arp_cache_write_enable,
            aximm_gmac_arp_cache_read_enable             => '0', --gmac_arp_cache_read_enable,
            aximm_gmac_arp_cache_write_data              => "", --gmac_arp_cache_write_data,
            aximm_gmac_arp_cache_read_data               => open, --gmac_arp_cache_read_data,
            aximm_gmac_arp_cache_write_address           => "", --gmac_arp_cache_write_address,
            aximm_gmac_arp_cache_read_address            => "", --gmac_arp_cache_read_address,
            aximm_gmac_tx_data_write_enable              => '0', --gmac_tx_data_write_enable,
            aximm_gmac_tx_data_read_enable               => '0', --gmac_tx_data_read_enable,
            aximm_gmac_tx_data_write_data                => x"00", --gmac_tx_data_write_data,
            aximm_gmac_tx_data_write_byte_enable         => b"00", --gmac_tx_data_write_byte_enable,
            aximm_gmac_tx_data_read_data                 => open, --gmac_tx_data_read_data,
            aximm_gmac_tx_data_read_byte_enable          => open, --gmac_tx_data_read_byte_enable,
            aximm_gmac_tx_data_write_address             => "", --gmac_tx_data_write_address,
            aximm_gmac_tx_data_read_address              => "", --gmac_tx_data_read_address,
            aximm_gmac_tx_ringbuffer_slot_id             => "", --gmac_tx_ringbuffer_slot_id,
            aximm_gmac_tx_ringbuffer_slot_set            => '0', --gmac_tx_ringbuffer_slot_set,
            aximm_gmac_tx_ringbuffer_slot_status         => open, --gmac_tx_ringbuffer_slot_status,
            aximm_gmac_tx_ringbuffer_number_slots_filled => open, --gmac_tx_ringbuffer_number_slots_filled,
            aximm_gmac_rx_data_read_enable               => '1', --gmac_rx_data_read_enable,
            aximm_gmac_rx_data_read_data                 => open, --gmac_rx_data_read_data,
            aximm_gmac_rx_data_read_byte_enable          => open, --gmac_rx_data_read_byte_enable,
            aximm_gmac_rx_data_read_address              => "", --gmac_rx_data_read_address,
            aximm_gmac_rx_ringbuffer_slot_id             => "", --gmac_rx_ringbuffer_slot_id,
            aximm_gmac_rx_ringbuffer_slot_clear          => '0', --gmac_rx_ringbuffer_slot_clear,
            aximm_gmac_rx_ringbuffer_slot_status         => open, --gmac_rx_ringbuffer_slot_status,
            aximm_gmac_rx_ringbuffer_number_slots_filled => open, --gmac_rx_ringbuffer_number_slots_filled,
            axis_streaming_data_clk                      => axis_streaming_data_clk,
            axis_streaming_data_rx_packet_length         => axis_streaming_data_rx_packet_length,                 
            axis_streaming_data_rx_tdata                 => axis_streaming_data_rx_tdata,
            axis_streaming_data_rx_tvalid                => axis_streaming_data_rx_tvalid,
            axis_streaming_data_rx_tready                => axis_streaming_data_rx_tready,
            axis_streaming_data_rx_tkeep                 => axis_streaming_data_rx_tkeep,
            axis_streaming_data_rx_tlast                 => axis_streaming_data_rx_tlast,
            axis_streaming_data_rx_tuser                 => axis_streaming_data_rx_tuser,
            axis_streaming_data_tx_destination_ip        => axis_streaming_data_tx_destination_ip,
            axis_streaming_data_tx_destination_udp_port  => axis_streaming_data_tx_destination_udp_port,
            axis_streaming_data_tx_source_udp_port       => axis_streaming_data_tx_source_udp_port,
            axis_streaming_data_tx_packet_length         => axis_streaming_data_tx_packet_length,                 
            axis_streaming_data_tx_tdata                 => axis_streaming_data_tx_tdata,
            axis_streaming_data_tx_tvalid                => axis_streaming_data_tx_tvalid,
            axis_streaming_data_tx_tuser                 => axis_streaming_data_tx_tuser,
            axis_streaming_data_tx_tkeep                 => axis_streaming_data_tx_tkeep,
            axis_streaming_data_tx_tlast                 => axis_streaming_data_tx_tlast,
            axis_streaming_data_tx_tready                => axis_streaming_data_tx_tready,
            gmac_reg_core_type                           => udp_gmac_reg_core_type,
            gmac_reg_phy_status_h                        => udp_gmac_reg_phy_status_h,
            gmac_reg_phy_status_l                        => udp_gmac_reg_phy_status_l,
            gmac_reg_phy_control_h                       => udp_gmac_reg_phy_control_h,
            gmac_reg_phy_control_l                       => udp_gmac_reg_phy_control_l,
            gmac_reg_tx_packet_rate                      => udp_gmac_reg_tx_packet_rate,
            gmac_reg_tx_packet_count                     => udp_gmac_reg_tx_packet_count,
            gmac_reg_tx_valid_rate                       => udp_gmac_reg_tx_valid_rate,
            gmac_reg_tx_valid_count                      => udp_gmac_reg_tx_valid_count,
            gmac_reg_rx_packet_rate                      => udp_gmac_reg_rx_packet_rate,
            gmac_reg_rx_packet_count                     => udp_gmac_reg_rx_packet_count,
            gmac_reg_rx_valid_rate                       => udp_gmac_reg_rx_valid_rate,
            gmac_reg_rx_valid_count                      => udp_gmac_reg_rx_valid_count,
            gmac_reg_rx_bad_packet_count                 => udp_gmac_reg_rx_bad_packet_count,
            gmac_reg_counters_reset                      => udp_gmac_reg_counters_reset,
            gmac_reg_mac_enable                          => udp_gmac_reg_mac_enable,
            axis_tx_tdata                                => axis_tx_tdata,
            axis_tx_tvalid                               => axis_tx_tvalid,
            axis_tx_tready                               => axis_tx_tready,
            axis_tx_tkeep                                => axis_tx_tkeep,
            axis_tx_tlast                                => axis_tx_tlast,
            axis_tx_tuser                                => axis_tx_tuser,
            axis_rx_tdata                                => axis_rx_tdata,
            axis_rx_tvalid                               => axis_rx_tvalid,
            axis_rx_tuser                                => axis_rx_tuser,
            axis_rx_tkeep                                => axis_rx_tkeep,
            axis_rx_tlast                                => axis_rx_tlast
        );

    MAINAXIS_i : axisila
        port map(
            clk        => ClkQSFP,
            probe0     => axis_rx_tdata,
            probe1(0)  => axis_rx_tvalid,
            probe2(0)  => axis_rx_tuser,
            probe3     => axis_rx_tkeep,
            probe4(0)  => axis_rx_tlast,
            probe5     => axis_tx_tdata,
            probe6(0)  => axis_tx_tvalid,
            probe7     => axis_tx_tkeep,
            probe8(0)  => axis_tx_tlast,
            probe9(0)  => axis_tx_tready,
            probe10(0) => udp_gmac_reg_mac_enable,
            probe11(0) => lbus_tx_ovfout,
            probe12(0) => lbus_tx_unfout,
            probe13(0) => RefClkLocked,
            probe14(0) => Reset,
            probe15(0) => qsfp_intl_ls
        );

end architecture rtl;

