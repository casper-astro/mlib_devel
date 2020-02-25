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
-- Module Name      : casperpcievethernetblock - rtl                           -
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
library unisim;
use unisim.vcomponents.all;

entity casperpcievethernetblock is
    generic(
        -- The defaul MAC address fort he Virtual Ethernet MAC
        G_VMAC_ADDRESS               : STD_LOGIC_VECTOR(47 downto 0) := X"000A_3502_4199";
        -- Boolean to include or not include ICAP for partial reconfiguration
        G_INCLUDE_ICAP               : boolean              := false;
        -- Streaming data size (must be 512)
        G_AXIS_DATA_WIDTH            : natural              := 512;
        -- Number of UDP Streaming Data Server Modules 
        G_NUM_STREAMING_DATA_SERVERS : natural range 1 to 4 := 1
    );
    port(
        -- Axis clock for the PCIe data interface
        -- Usually 325MHz 
        axis_clk                                    : in  STD_LOGIC;
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
        -- PCIe Reference System Clock
        sys_clk_p                                   : in  STD_LOGIC;
        sys_clk_n                                   : in  STD_LOGIC;
        -- PCIe Reference System Reset
        sys_rst_n                                   : in  STD_LOGIC;
        -- PCIe Data signals
        -- The PCIe Interface varies from 8 lane to 16 lane
        -- 16 lane is preferable.
        pci_exp_txp                                 : out STD_LOGIC_VECTOR(7 downto 0);
        pci_exp_txn                                 : out STD_LOGIC_VECTOR(7 downto 0);
        pci_exp_rxp                                 : in  STD_LOGIC_VECTOR(7 downto 0);
        pci_exp_rxn                                 : in  STD_LOGIC_VECTOR(7 downto 0);
        -- UART I/O
        rs232_uart_rxd                              : in  STD_LOGIC;
        rs232_uart_txd                              : out STD_LOGIC;
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
end entity casperpcievethernetblock;

architecture rtl of casperpcievethernetblock is
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
            axis_streaming_data_rx_packet_length         : out STD_LOGIC_VECTOR((16 * G_NUM_STREAMING_DATA_SERVERS) - 1 downto 0);                             
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

    component pciexdma_refbd_wrapper is
        port(
            mm_data_out      : out STD_LOGIC_VECTOR(31 downto 0);
            mm_data_in       : in  STD_LOGIC_VECTOR(31 downto 0);
            mm_address       : out STD_LOGIC_VECTOR(3 downto 0);
            mm_control       : out STD_LOGIC_VECTOR(1 downto 0);
            S_AXIS_0_tdata   : in  STD_LOGIC_VECTOR(511 downto 0);
            S_AXIS_0_tkeep   : in  STD_LOGIC_VECTOR(63 downto 0);
            S_AXIS_0_tlast   : in  STD_LOGIC;
            S_AXIS_0_tready  : out STD_LOGIC;
            S_AXIS_0_tvalid  : in  STD_LOGIC;
            s_axis_aclk_0    : in  STD_LOGIC;
            s_axis_aresetn_0 : in  STD_LOGIC;
            M_AXIS_0_tdata   : out STD_LOGIC_VECTOR(511 downto 0);
            M_AXIS_0_tkeep   : out STD_LOGIC_VECTOR(63 downto 0);
            M_AXIS_0_tlast   : out STD_LOGIC;
            M_AXIS_0_tready  : in  STD_LOGIC;
            M_AXIS_0_tvalid  : out STD_LOGIC;
            m_axis_aclk_0    : in  STD_LOGIC;
            m_axis_aresetn_0 : in  STD_LOGIC;
            pcie_mgt_0_rxn   : in  STD_LOGIC_VECTOR(7 downto 0);
            pcie_mgt_0_rxp   : in  STD_LOGIC_VECTOR(7 downto 0);
            pcie_mgt_0_txn   : out STD_LOGIC_VECTOR(7 downto 0);
            pcie_mgt_0_txp   : out STD_LOGIC_VECTOR(7 downto 0);
            sys_clk_0        : in  STD_LOGIC;
            sys_clk_gt_0     : in  STD_LOGIC;
            sys_rst_n_0      : in  STD_LOGIC;
            user_lnk_up_0    : out STD_LOGIC
        );
    end component pciexdma_refbd_wrapper;

    component vethernetmac is
        generic(
            C_VMAC_ADDRESS : STD_LOGIC_VECTOR(47 downto 0)
        );
        port(
            ------------------------------------------------------------------------
            -- These signals/busses run at 322.265625MHz clock domain              -
            ------------------------------------------------------------------------
            -- Global System Enable
            Enable                       : in  STD_LOGIC;
            Reset                        : in  STD_LOGIC;
            vmac_register_data_out       : in  STD_LOGIC_VECTOR(31 downto 0);
            vmac_register_data_in        : out STD_LOGIC_VECTOR(31 downto 0);
            vmac_register_address        : out STD_LOGIC_VECTOR(3 downto 0);
            vmac_register_control        : out STD_LOGIC_VECTOR(1 downto 0);
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
            pcie_axis_rx_tdata           : in  STD_LOGIC_VECTOR(511 downto 0);
            pcie_axis_rx_tvalid          : in  STD_LOGIC;
            pcie_axis_rx_tready          : out STD_LOGIC;
            pcie_axis_rx_tkeep           : in  STD_LOGIC_VECTOR(63 downto 0);
            pcie_axis_rx_tlast           : in  STD_LOGIC;
            pcie_axis_tx_tdata           : out STD_LOGIC_VECTOR(511 downto 0);
            pcie_axis_tx_tvalid          : out STD_LOGIC;
            pcie_axis_tx_tready          : in  STD_LOGIC;
            pcie_axis_tx_tkeep           : out STD_LOGIC_VECTOR(63 downto 0);
            pcie_axis_tx_tlast           : out STD_LOGIC;
            -- AXIS Bus
            -- RX Bus
            ethernet_axis_rx_tdata       : in  STD_LOGIC_VECTOR(511 downto 0);
            ethernet_axis_rx_tvalid      : in  STD_LOGIC;
            ethernet_axis_rx_tready      : out STD_LOGIC;
            ethernet_axis_rx_tkeep       : in  STD_LOGIC_VECTOR(63 downto 0);
            ethernet_axis_rx_tlast       : in  STD_LOGIC;
            ethernet_axis_rx_tuser       : in  STD_LOGIC;
            -- TX Bus
            ethernet_axis_tx_tdata       : out STD_LOGIC_VECTOR(511 downto 0);
            ethernet_axis_tx_tvalid      : out STD_LOGIC;
            ethernet_axis_tx_tkeep       : out STD_LOGIC_VECTOR(63 downto 0);
            ethernet_axis_tx_tlast       : out STD_LOGIC;
            -- User signal for errors and dropping of packets
            ethernet_axis_tx_tuser       : out STD_LOGIC
        );
    end component vethernetmac;

    component microblaze_axi_us_plus_wrapper is
        generic(
            -- Users to add parameters here
            C_ARP_CACHE_ASIZE          : natural := 10;
            C_CPU_TX_DATA_BUFFER_ASIZE : natural := 11;
            C_CPU_RX_DATA_BUFFER_ASIZE : natural := 11;
            C_SLOT_WIDTH               : natural := 4
        );
        port(
            ------------------------------------------------------------------------
            -- MAC PHY Register Interface according to EthernetCore Memory MAP    --
            ------------------------------------------------------------------------ 
            gmac_reg_phy_control_h                 : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_control_l                 : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_mac_address                   : out STD_LOGIC_VECTOR(47 downto 0);
            gmac_reg_local_ip_address              : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_gateway_ip_address            : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_multicast_ip_address          : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_multicast_ip_mask             : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_udp_port                      : out STD_LOGIC_VECTOR(15 downto 0);
            gmac_reg_udp_port_mask                 : out STD_LOGIC_VECTOR(15 downto 0);
            gmac_reg_mac_enable                    : out STD_LOGIC;
            gmac_reg_mac_promiscous_mode           : out STD_LOGIC;
            gmac_reg_counters_reset                : out STD_LOGIC;
            gmac_reg_core_type                     : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_h                  : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_phy_status_l                  : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_rate                : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_packet_count               : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_rate                 : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_valid_count                : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_overflow_count             : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_afull_count                : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_rate                : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_packet_count               : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_rate                 : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_valid_count                : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_overflow_count             : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_almost_full_count          : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_rx_bad_packet_count           : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_arp_size                      : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_reg_tx_word_size                  : in  STD_LOGIC_VECTOR(15 downto 0);
            gmac_reg_rx_word_size                  : in  STD_LOGIC_VECTOR(15 downto 0);
            gmac_reg_tx_buffer_max_size            : in  STD_LOGIC_VECTOR(15 downto 0);
            gmac_reg_rx_buffer_max_size            : in  STD_LOGIC_VECTOR(15 downto 0);
            gmac_arp_cache_write_enable            : out STD_LOGIC;
            gmac_arp_cache_read_enable             : out STD_LOGIC;
            gmac_arp_cache_write_data              : out STD_LOGIC_VECTOR(31 downto 0);
            gmac_arp_cache_read_data               : in  STD_LOGIC_VECTOR(31 downto 0);
            gmac_arp_cache_write_address           : out STD_LOGIC_VECTOR(C_ARP_CACHE_ASIZE - 1 downto 0);
            gmac_arp_cache_read_address            : out STD_LOGIC_VECTOR(C_ARP_CACHE_ASIZE - 1 downto 0);
            gmac_tx_data_write_enable              : out STD_LOGIC;
            gmac_tx_data_read_enable               : out STD_LOGIC;
            gmac_tx_data_write_data                : out STD_LOGIC_VECTOR(7 downto 0);
            gmac_tx_data_write_byte_enable         : out STD_LOGIC_VECTOR(1 downto 0);
            gmac_tx_data_read_data                 : in  STD_LOGIC_VECTOR(7 downto 0);
            gmac_tx_data_read_byte_enable          : in  STD_LOGIC_VECTOR(1 downto 0);
            gmac_tx_data_write_address             : out STD_LOGIC_VECTOR(C_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
            gmac_tx_data_read_address              : out STD_LOGIC_VECTOR(C_CPU_TX_DATA_BUFFER_ASIZE - 1 downto 0);
            gmac_tx_ringbuffer_slot_id             : out STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
            gmac_tx_ringbuffer_slot_set            : out STD_LOGIC;
            gmac_tx_ringbuffer_slot_status         : in  STD_LOGIC;
            gmac_tx_ringbuffer_number_slots_filled : in  STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
            gmac_rx_data_read_enable               : out STD_LOGIC;
            gmac_rx_data_read_data                 : in  STD_LOGIC_VECTOR(7 downto 0);
            gmac_rx_data_read_byte_enable          : in  STD_LOGIC_VECTOR(1 downto 0);
            gmac_rx_data_read_address              : out STD_LOGIC_VECTOR(C_CPU_RX_DATA_BUFFER_ASIZE - 1 downto 0);
            gmac_rx_ringbuffer_slot_id             : out STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
            gmac_rx_ringbuffer_slot_clear          : out STD_LOGIC;
            gmac_rx_ringbuffer_slot_status         : in  STD_LOGIC;
            gmac_rx_ringbuffer_number_slots_filled : in  STD_LOGIC_VECTOR(C_SLOT_WIDTH - 1 downto 0);
            ClockStable                            : in  STD_LOGIC;
            PSClock                                : in  STD_LOGIC;
            PSReset                                : in  STD_LOGIC;
            rs232_uart_rxd                         : in  STD_LOGIC;
            rs232_uart_txd                         : out STD_LOGIC
        );
    end component microblaze_axi_us_plus_wrapper;

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

    signal Reset : std_logic;

    signal sys_rst_n_c : std_logic;
    signal sys_clk_gt  : std_logic;
    signal sys_clk     : std_logic;

    signal pcie_axis_rx_tdata      : STD_LOGIC_VECTOR(511 downto 0);
    signal pcie_axis_rx_tvalid     : STD_LOGIC;
    signal pcie_axis_rx_tready     : STD_LOGIC;
    signal pcie_axis_rx_tkeep      : STD_LOGIC_VECTOR(63 downto 0);
    signal pcie_axis_rx_tlast      : STD_LOGIC;
    signal pcie_axis_tx_tdata      : STD_LOGIC_VECTOR(511 downto 0);
    signal pcie_axis_tx_tvalid     : STD_LOGIC;
    signal pcie_axis_tx_tready     : STD_LOGIC;
    signal pcie_axis_tx_tkeep      : STD_LOGIC_VECTOR(63 downto 0);
    signal pcie_axis_tx_tlast      : STD_LOGIC;
    signal ethernet_axis_rx_tdata  : STD_LOGIC_VECTOR(511 downto 0);
    signal ethernet_axis_rx_tvalid : STD_LOGIC;
    signal ethernet_axis_rx_tkeep  : STD_LOGIC_VECTOR(63 downto 0);
    signal ethernet_axis_rx_tlast  : STD_LOGIC;
    signal ethernet_axis_rx_tuser  : STD_LOGIC;

    signal ethernet_axis_tx_tdata  : STD_LOGIC_VECTOR(511 downto 0);
    signal ethernet_axis_tx_tvalid : STD_LOGIC;
    signal ethernet_axis_tx_tkeep  : STD_LOGIC_VECTOR(63 downto 0);
    signal ethernet_axis_tx_tlast  : STD_LOGIC;
    signal ethernet_axis_tx_tready : STD_LOGIC;
    signal ethernet_axis_tx_tuser  : STD_LOGIC;

    signal mm_data_out : STD_LOGIC_VECTOR(31 downto 0);
    signal mm_data_in  : STD_LOGIC_VECTOR(31 downto 0);
    signal mm_address  : STD_LOGIC_VECTOR(3 downto 0);
    signal mm_control  : STD_LOGIC_VECTOR(1 downto 0);

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
    signal pcielinkup                       : std_logic;
    signal axis_resetn                      : std_logic;
begin
    Reset       <= (not RefClkLocked) or axis_reset;
    axis_resetn <= not Reset;
    ----------------------------------------------------------------------------
    --                    PCIe sub system instantiation                       --
    -- The PCIe sub system with its QDMA engine is instantiated here.         --
    -- This module resides on the static portion of the design.               --
    -- This code must boot first on a minimal tandem bitstream to meet PCIe   --
    -- system bus enumeration and meet the full line sync of less than 10ms   --
    -- for successful device enumeration,else the FPGA wont be recognized on  --
    -- the system PCIe bus.                                                   --
    ----------------------------------------------------------------------------   

    -- PCIe Refference clock buffer for PCI Express clocking
    refclk_ibuf : IBUFDS_GTE4
        generic map(
            REFCLK_HROW_CK_SEL => "00"
        )
        port map(
            O     => sys_clk_gt,
            ODIV2 => sys_clk,
            CEB   => '0',
            I     => sys_clk_p,
            IB    => sys_clk_n
        );

    -- PCIe reset buffer for PCI Express card reset
    sys_reset_n_ibuf : IBUF
        port map(
            O => sys_rst_n_c,
            I => sys_rst_n
        );

    PCIE_i : pciexdma_refbd_wrapper
        port map(
            mm_data_out      => mm_data_out,
            mm_data_in       => mm_data_in,
            mm_address       => mm_address,
            mm_control       => mm_control,
            M_AXIS_0_tdata   => pcie_axis_rx_tdata,
            M_AXIS_0_tkeep   => pcie_axis_rx_tkeep,
            M_AXIS_0_tlast   => pcie_axis_rx_tlast,
            M_AXIS_0_tready  => pcie_axis_rx_tready,
            M_AXIS_0_tvalid  => pcie_axis_rx_tvalid,
            m_axis_aclk_0    => axis_clk,
            S_AXIS_0_tdata   => pcie_axis_tx_tdata,
            S_AXIS_0_tkeep   => pcie_axis_tx_tkeep,
            S_AXIS_0_tlast   => pcie_axis_tx_tlast,
            S_AXIS_0_tready  => pcie_axis_tx_tready,
            S_AXIS_0_tvalid  => pcie_axis_tx_tvalid,
            s_axis_aclk_0    => axis_clk,
            m_axis_aresetn_0 => axis_resetn,
            s_axis_aresetn_0 => axis_resetn,
            pcie_mgt_0_rxn   => pci_exp_rxn,
            pcie_mgt_0_rxp   => pci_exp_rxp,
            pcie_mgt_0_txn   => pci_exp_txn,
            pcie_mgt_0_txp   => pci_exp_txp,
            sys_clk_0        => sys_clk,
            sys_clk_gt_0     => sys_clk_gt,
            sys_rst_n_0      => sys_rst_n_c,
            user_lnk_up_0    => pcielinkup
        );
    ----------------------------------------------------------------------------
    --                     Virtual Ethernet MAC                               --
    -- The VMAC resides in the static partition of the design.                --
    -- This is the main data port on the design.                              --
    -- TODO                                                                   --
    --     Connect PCIe streaming RX,TX also VMAC register interfaces         --
    --     Implement the VMAC module                                          --
    ----------------------------------------------------------------------------
    VMAC_i : vethernetmac
        generic map(
            C_VMAC_ADDRESS => G_VMAC_ADDRESS
        )
        port map(
            Enable                       => udp_gmac_reg_mac_enable,
            Reset                        => Reset,
            vmac_register_data_out       => mm_data_in,
            vmac_register_data_in        => mm_data_out,
            vmac_register_address        => mm_address,
            vmac_register_control        => mm_control,
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
            -- Down stream PCIe DMA raw data as per PCIe EP MPS
            pcie_axis_rx_tdata           => pcie_axis_rx_tdata,
            pcie_axis_rx_tvalid          => pcie_axis_rx_tvalid,
            pcie_axis_rx_tready          => pcie_axis_rx_tready,
            pcie_axis_rx_tkeep           => pcie_axis_rx_tkeep,
            pcie_axis_rx_tlast           => pcie_axis_rx_tlast,
            pcie_axis_tx_tdata           => pcie_axis_tx_tdata,
            pcie_axis_tx_tvalid          => pcie_axis_tx_tvalid,
            pcie_axis_tx_tready          => pcie_axis_tx_tready,
            pcie_axis_tx_tkeep           => pcie_axis_tx_tkeep,
            pcie_axis_tx_tlast           => pcie_axis_tx_tlast,
            -- Up stream ethernet packetised data 
            ethernet_axis_rx_tdata       => ethernet_axis_tx_tdata,
            ethernet_axis_rx_tvalid      => ethernet_axis_tx_tvalid,
            ethernet_axis_rx_tready      => ethernet_axis_tx_tready,
            ethernet_axis_rx_tkeep       => ethernet_axis_tx_tkeep,
            ethernet_axis_rx_tlast       => ethernet_axis_tx_tlast,
            ethernet_axis_rx_tuser       => ethernet_axis_tx_tuser,
            ethernet_axis_tx_tdata       => ethernet_axis_rx_tdata,
            ethernet_axis_tx_tvalid      => ethernet_axis_rx_tvalid,
            ethernet_axis_tx_tkeep       => ethernet_axis_rx_tkeep,
            ethernet_axis_tx_tlast       => ethernet_axis_rx_tlast,
            ethernet_axis_tx_tuser       => ethernet_axis_rx_tuser
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
            axis_clk                                     => axis_clk,
            -- Running Microblaze at 125MHz used for ICAP Clocking
            aximm_clk                                    => aximm_clk,
            icap_clk                                     => icap_clk,
            axis_reset                                   => Reset,
            aximm_gmac_reg_phy_control_h                 => gmac_reg_phy_control_h,
            aximm_gmac_reg_phy_control_l                 => gmac_reg_phy_control_l,
            aximm_gmac_reg_mac_address                   => gmac_reg_mac_address,
            aximm_gmac_reg_local_ip_address              => gmac_reg_local_ip_address,
            aximm_gmac_reg_gateway_ip_address            => gmac_reg_gateway_ip_address,
            aximm_gmac_reg_multicast_ip_address          => gmac_reg_multicast_ip_address,
            aximm_gmac_reg_multicast_ip_mask             => gmac_reg_multicast_ip_mask,
            aximm_gmac_reg_udp_port                      => gmac_reg_udp_port,
            aximm_gmac_reg_udp_port_mask                 => gmac_reg_udp_port_mask,
            aximm_gmac_reg_mac_enable                    => gmac_reg_mac_enable,
            aximm_gmac_reg_mac_promiscous_mode           => gmac_reg_mac_promiscous_mode,
            aximm_gmac_reg_counters_reset                => gmac_reg_counters_reset,
            aximm_gmac_reg_core_type                     => gmac_reg_core_type,
            aximm_gmac_reg_phy_status_h                  => gmac_reg_phy_status_h,
            aximm_gmac_reg_phy_status_l                  => gmac_reg_phy_status_l,
            aximm_gmac_reg_tx_packet_rate                => gmac_reg_tx_packet_rate,
            aximm_gmac_reg_tx_packet_count               => gmac_reg_tx_packet_count,
            aximm_gmac_reg_tx_valid_rate                 => gmac_reg_tx_valid_rate,
            aximm_gmac_reg_tx_valid_count                => gmac_reg_tx_valid_count,
            aximm_gmac_reg_tx_overflow_count             => gmac_reg_tx_overflow_count,
            aximm_gmac_reg_tx_afull_count                => gmac_reg_tx_afull_count,
            aximm_gmac_reg_rx_packet_rate                => gmac_reg_rx_packet_rate,
            aximm_gmac_reg_rx_packet_count               => gmac_reg_rx_packet_count,
            aximm_gmac_reg_rx_valid_rate                 => gmac_reg_rx_valid_rate,
            aximm_gmac_reg_rx_valid_count                => gmac_reg_rx_valid_count,
            aximm_gmac_reg_rx_overflow_count             => gmac_reg_rx_overflow_count,
            aximm_gmac_reg_rx_almost_full_count          => gmac_reg_rx_almost_full_count,
            aximm_gmac_reg_rx_bad_packet_count           => gmac_reg_rx_bad_packet_count,
            aximm_gmac_reg_arp_size                      => gmac_reg_arp_size,
            aximm_gmac_reg_tx_word_size                  => gmac_reg_tx_word_size,
            aximm_gmac_reg_rx_word_size                  => gmac_reg_rx_word_size,
            aximm_gmac_reg_tx_buffer_max_size            => gmac_reg_tx_buffer_max_size,
            aximm_gmac_reg_rx_buffer_max_size            => gmac_reg_rx_buffer_max_size,
            aximm_gmac_arp_cache_write_enable            => gmac_arp_cache_write_enable,
            aximm_gmac_arp_cache_read_enable             => gmac_arp_cache_read_enable,
            aximm_gmac_arp_cache_write_data              => gmac_arp_cache_write_data,
            aximm_gmac_arp_cache_read_data               => gmac_arp_cache_read_data,
            aximm_gmac_arp_cache_write_address           => gmac_arp_cache_write_address,
            aximm_gmac_arp_cache_read_address            => gmac_arp_cache_read_address,
            aximm_gmac_tx_data_write_enable              => gmac_tx_data_write_enable,
            aximm_gmac_tx_data_read_enable               => gmac_tx_data_read_enable,
            aximm_gmac_tx_data_write_data                => gmac_tx_data_write_data,
            aximm_gmac_tx_data_write_byte_enable         => gmac_tx_data_write_byte_enable,
            aximm_gmac_tx_data_read_data                 => gmac_tx_data_read_data,
            aximm_gmac_tx_data_read_byte_enable          => gmac_tx_data_read_byte_enable,
            aximm_gmac_tx_data_write_address             => gmac_tx_data_write_address,
            aximm_gmac_tx_data_read_address              => gmac_tx_data_read_address,
            aximm_gmac_tx_ringbuffer_slot_id             => gmac_tx_ringbuffer_slot_id,
            aximm_gmac_tx_ringbuffer_slot_set            => gmac_tx_ringbuffer_slot_set,
            aximm_gmac_tx_ringbuffer_slot_status         => gmac_tx_ringbuffer_slot_status,
            aximm_gmac_tx_ringbuffer_number_slots_filled => gmac_tx_ringbuffer_number_slots_filled,
            aximm_gmac_rx_data_read_enable               => gmac_rx_data_read_enable,
            aximm_gmac_rx_data_read_data                 => gmac_rx_data_read_data,
            aximm_gmac_rx_data_read_byte_enable          => gmac_rx_data_read_byte_enable,
            aximm_gmac_rx_data_read_address              => gmac_rx_data_read_address,
            aximm_gmac_rx_ringbuffer_slot_id             => gmac_rx_ringbuffer_slot_id,
            aximm_gmac_rx_ringbuffer_slot_clear          => gmac_rx_ringbuffer_slot_clear,
            aximm_gmac_rx_ringbuffer_slot_status         => gmac_rx_ringbuffer_slot_status,
            aximm_gmac_rx_ringbuffer_number_slots_filled => gmac_rx_ringbuffer_number_slots_filled,
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
            axis_tx_tdata                                => ethernet_axis_tx_tdata,
            axis_tx_tvalid                               => ethernet_axis_tx_tvalid,
            axis_tx_tready                               => ethernet_axis_tx_tready,
            axis_tx_tkeep                                => ethernet_axis_tx_tkeep,
            axis_tx_tlast                                => ethernet_axis_tx_tlast,
            axis_tx_tuser                                => ethernet_axis_tx_tuser,
            axis_rx_tdata                                => ethernet_axis_rx_tdata,
            axis_rx_tvalid                               => ethernet_axis_rx_tvalid,
            axis_rx_tuser                                => ethernet_axis_rx_tuser,
            axis_rx_tkeep                                => ethernet_axis_rx_tkeep,
            axis_rx_tlast                                => ethernet_axis_rx_tlast
        );

    ----------------------------------------------------------------------------
    --                   Microblaze CPU Instance                              --
    -- The CPU resides in the static partition of the design.                 --
    -- The CPU implements CASPER FPGA communication functions over the CMAC.  --
    -- The CPU can only send and receive 1520 MTU Ethernet packets.           --
    -- The CPU runs at 125MHz clock                                           --
    -- Inside the CPU BD {n} ethernet memory map core(s) is/are instantiated. --
    ----------------------------------------------------------------------------
    MicroblazeSys_i : microblaze_axi_us_plus_wrapper
        generic map(
            C_ARP_CACHE_ASIZE          => C_ARP_CACHE_ASIZE,
            C_CPU_TX_DATA_BUFFER_ASIZE => C_CPU_TX_DATA_BUFFER_ASIZE,
            C_CPU_RX_DATA_BUFFER_ASIZE => C_CPU_RX_DATA_BUFFER_ASIZE,
            C_SLOT_WIDTH               => C_SLOT_WIDTH
        )
        port map(
            gmac_reg_phy_control_h                 => gmac_reg_phy_control_h,
            gmac_reg_phy_control_l                 => gmac_reg_phy_control_l,
            gmac_reg_mac_address                   => gmac_reg_mac_address,
            gmac_reg_local_ip_address              => gmac_reg_local_ip_address,
            gmac_reg_gateway_ip_address            => gmac_reg_gateway_ip_address,
            gmac_reg_multicast_ip_address          => gmac_reg_multicast_ip_address,
            gmac_reg_multicast_ip_mask             => gmac_reg_multicast_ip_mask,
            gmac_reg_udp_port                      => gmac_reg_udp_port,
            gmac_reg_udp_port_mask                 => gmac_reg_udp_port_mask,
            gmac_reg_mac_enable                    => gmac_reg_mac_enable,
            gmac_reg_mac_promiscous_mode           => gmac_reg_mac_promiscous_mode,
            gmac_reg_counters_reset                => gmac_reg_counters_reset,
            gmac_reg_core_type                     => gmac_reg_core_type,
            gmac_reg_phy_status_h                  => gmac_reg_phy_status_h,
            gmac_reg_phy_status_l                  => gmac_reg_phy_status_l,
            gmac_reg_tx_packet_rate                => gmac_reg_tx_packet_rate,
            gmac_reg_tx_packet_count               => gmac_reg_tx_packet_count,
            gmac_reg_tx_valid_rate                 => gmac_reg_tx_valid_rate,
            gmac_reg_tx_valid_count                => gmac_reg_tx_valid_count,
            gmac_reg_tx_overflow_count             => gmac_reg_tx_overflow_count,
            gmac_reg_tx_afull_count                => gmac_reg_tx_afull_count,
            gmac_reg_rx_packet_rate                => gmac_reg_rx_packet_rate,
            gmac_reg_rx_packet_count               => gmac_reg_rx_packet_count,
            gmac_reg_rx_valid_rate                 => gmac_reg_rx_valid_rate,
            gmac_reg_rx_valid_count                => gmac_reg_rx_valid_count,
            gmac_reg_rx_overflow_count             => gmac_reg_rx_overflow_count,
            gmac_reg_rx_almost_full_count          => gmac_reg_rx_almost_full_count,
            gmac_reg_rx_bad_packet_count           => gmac_reg_rx_bad_packet_count,
            gmac_reg_arp_size                      => gmac_reg_arp_size,
            gmac_reg_tx_word_size                  => gmac_reg_tx_word_size,
            gmac_reg_rx_word_size                  => gmac_reg_rx_word_size,
            gmac_reg_tx_buffer_max_size            => gmac_reg_tx_buffer_max_size,
            gmac_reg_rx_buffer_max_size            => gmac_reg_rx_buffer_max_size,
            gmac_arp_cache_write_enable            => gmac_arp_cache_write_enable,
            gmac_arp_cache_read_enable             => gmac_arp_cache_read_enable,
            gmac_arp_cache_write_data              => gmac_arp_cache_write_data,
            gmac_arp_cache_read_data               => gmac_arp_cache_read_data,
            gmac_arp_cache_write_address           => gmac_arp_cache_write_address,
            gmac_arp_cache_read_address            => gmac_arp_cache_read_address,
            gmac_tx_data_write_enable              => gmac_tx_data_write_enable,
            gmac_tx_data_read_enable               => gmac_tx_data_read_enable,
            gmac_tx_data_write_data                => gmac_tx_data_write_data,
            gmac_tx_data_write_byte_enable         => gmac_tx_data_write_byte_enable,
            gmac_tx_data_read_data                 => gmac_tx_data_read_data,
            gmac_tx_data_read_byte_enable          => gmac_tx_data_read_byte_enable,
            gmac_tx_data_write_address             => gmac_tx_data_write_address,
            gmac_tx_data_read_address              => gmac_tx_data_read_address,
            gmac_tx_ringbuffer_slot_id             => gmac_tx_ringbuffer_slot_id,
            gmac_tx_ringbuffer_slot_set            => gmac_tx_ringbuffer_slot_set,
            gmac_tx_ringbuffer_slot_status         => gmac_tx_ringbuffer_slot_status,
            gmac_tx_ringbuffer_number_slots_filled => gmac_tx_ringbuffer_number_slots_filled,
            gmac_rx_data_read_enable               => gmac_rx_data_read_enable,
            gmac_rx_data_read_data                 => gmac_rx_data_read_data,
            gmac_rx_data_read_byte_enable          => gmac_rx_data_read_byte_enable,
            gmac_rx_data_read_address              => gmac_rx_data_read_address,
            gmac_rx_ringbuffer_slot_id             => gmac_rx_ringbuffer_slot_id,
            gmac_rx_ringbuffer_slot_clear          => gmac_rx_ringbuffer_slot_clear,
            gmac_rx_ringbuffer_slot_status         => gmac_rx_ringbuffer_slot_status,
            gmac_rx_ringbuffer_number_slots_filled => gmac_rx_ringbuffer_number_slots_filled,
            ClockStable                            => RefClkLocked,
            PSClock                                => aximm_clk,
            PSReset                                => Reset,
            rs232_uart_rxd                         => rs232_uart_rxd,
            rs232_uart_txd                         => rs232_uart_txd
        );

    MAINAXIS_i : axisila
        port map(
            clk        => axis_clk,
            probe0     => ethernet_axis_rx_tdata,
            probe1(0)  => ethernet_axis_rx_tvalid,
            probe2(0)  => ethernet_axis_rx_tuser,
            probe3     => ethernet_axis_rx_tkeep,
            probe4(0)  => ethernet_axis_rx_tlast,
            probe5     => ethernet_axis_tx_tdata,
            probe6(0)  => ethernet_axis_tx_tvalid,
            probe7     => ethernet_axis_tx_tkeep,
            probe8(0)  => ethernet_axis_tx_tlast,
            probe9(0)  => ethernet_axis_tx_tready,
            probe10(0) => udp_gmac_reg_mac_enable,
            probe11(0) => pcielinkup,
            probe12(0) => pcielinkup,
            probe13(0) => RefClkLocked,
            probe14(0) => Reset,
            probe15(0) => pcielinkup
        );

end architecture rtl;

