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
-- Module Name      : gmacqsfp1top - rtl                                       -
-- Project Name     : SKARAB2                                                  -
-- Target Devices   : N/A                                                      -
-- Tool Versions    : N/A                                                      -
-- Description      : This module instantiates one QSFP28+ ports with CMACs.   -
--                    TODO                                                     -
--                    Enable AXI Lite bus for statistics collection.           - 
-- Dependencies     : EthMACPHY100GQSFP14x                                     -
-- Revision History : V1.0 - Initial design                                    -
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity gmacqsfp1top is
    port(
        -- Reference clock to generate 100MHz from
        Clk100MHz        : in  STD_LOGIC;
        -- Global System Enable
        Enable           : in  STD_LOGIC;
        Reset            : in  STD_LOGIC;
        -- Ethernet reference clock for 156.25MHz
        -- QSFP+ 
        mgt_qsfp_clock_p : in  STD_LOGIC;
        mgt_qsfp_clock_n : in  STD_LOGIC;
        --RX     
        qsfp_mgt_rx0_p   : in  STD_LOGIC;
        qsfp_mgt_rx0_n   : in  STD_LOGIC;
        qsfp_mgt_rx1_p   : in  STD_LOGIC;
        qsfp_mgt_rx1_n   : in  STD_LOGIC;
        qsfp_mgt_rx2_p   : in  STD_LOGIC;
        qsfp_mgt_rx2_n   : in  STD_LOGIC;
        qsfp_mgt_rx3_p   : in  STD_LOGIC;
        qsfp_mgt_rx3_n   : in  STD_LOGIC;
        -- TX
        qsfp_mgt_tx0_p   : out STD_LOGIC;
        qsfp_mgt_tx0_n   : out STD_LOGIC;
        qsfp_mgt_tx1_p   : out STD_LOGIC;
        qsfp_mgt_tx1_n   : out STD_LOGIC;
        qsfp_mgt_tx2_p   : out STD_LOGIC;
        qsfp_mgt_tx2_n   : out STD_LOGIC;
        qsfp_mgt_tx3_p   : out STD_LOGIC;
        qsfp_mgt_tx3_n   : out STD_LOGIC;
        -- Lbus and AXIS
        -- This bus runs at 322.265625MHz
        lbus_reset       : in  STD_LOGIC;
        -- Overflow signal
        lbus_tx_ovfout   : out STD_LOGIC;
        -- Underflow signal
        lbus_tx_unfout   : out STD_LOGIC;
        -- AXIS Bus
        -- RX Bus
        axis_rx_clkin    : in  STD_LOGIC;
        axis_rx_tdata    : in  STD_LOGIC_VECTOR(511 downto 0);
        axis_rx_tvalid   : in  STD_LOGIC;
        axis_rx_tready   : out STD_LOGIC;
        axis_rx_tkeep    : in  STD_LOGIC_VECTOR(63 downto 0);
        axis_rx_tlast    : in  STD_LOGIC;
        axis_rx_tuser    : in  STD_LOGIC;
        -- TX Bus
        axis_tx_clkout   : out STD_LOGIC;
        axis_tx_tdata    : out STD_LOGIC_VECTOR(511 downto 0);
        axis_tx_tvalid   : out STD_LOGIC;
        axis_tx_tkeep    : out STD_LOGIC_VECTOR(63 downto 0);
        axis_tx_tlast    : out STD_LOGIC;
        -- User signal for errors and dropping of packets
        axis_tx_tuser    : out STD_LOGIC
    );
end entity gmacqsfp1top;

architecture rtl of gmacqsfp1top is
    component EthMACPHY100GQSFP14x is
        port(
            gt0_txp_out                     : OUT STD_LOGIC;
            gt0_txn_out                     : OUT STD_LOGIC;
            gt1_txp_out                     : OUT STD_LOGIC;
            gt1_txn_out                     : OUT STD_LOGIC;
            gt2_txp_out                     : OUT STD_LOGIC;
            gt2_txn_out                     : OUT STD_LOGIC;
            gt3_txp_out                     : OUT STD_LOGIC;
            gt3_txn_out                     : OUT STD_LOGIC;
            gt0_rxp_in                      : IN  STD_LOGIC;
            gt0_rxn_in                      : IN  STD_LOGIC;
            gt1_rxp_in                      : IN  STD_LOGIC;
            gt1_rxn_in                      : IN  STD_LOGIC;
            gt2_rxp_in                      : IN  STD_LOGIC;
            gt2_rxn_in                      : IN  STD_LOGIC;
            gt3_rxp_in                      : IN  STD_LOGIC;
            gt3_rxn_in                      : IN  STD_LOGIC;
            gt_txusrclk2                   : OUT STD_LOGIC;
            gt_loopback_in                 : IN  STD_LOGIC_VECTOR(11 DOWNTO 0);
            gt_ref_clk_out                 : OUT STD_LOGIC;
            gt_rxrecclkout                 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            gt_powergoodout                : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            gtwiz_reset_tx_datapath        : IN  STD_LOGIC;
            gtwiz_reset_rx_datapath        : IN  STD_LOGIC;
            sys_reset                      : IN  STD_LOGIC;
            gt_ref_clk_p                   : IN  STD_LOGIC;
            gt_ref_clk_n                   : IN  STD_LOGIC;
            init_clk                       : IN  STD_LOGIC;
            rx_dataout0                    : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
            rx_dataout1                    : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
            rx_dataout2                    : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
            rx_dataout3                    : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
            rx_enaout0                     : OUT STD_LOGIC;
            rx_enaout1                     : OUT STD_LOGIC;
            rx_enaout2                     : OUT STD_LOGIC;
            rx_enaout3                     : OUT STD_LOGIC;
            rx_eopout0                     : OUT STD_LOGIC;
            rx_eopout1                     : OUT STD_LOGIC;
            rx_eopout2                     : OUT STD_LOGIC;
            rx_eopout3                     : OUT STD_LOGIC;
            rx_errout0                     : OUT STD_LOGIC;
            rx_errout1                     : OUT STD_LOGIC;
            rx_errout2                     : OUT STD_LOGIC;
            rx_errout3                     : OUT STD_LOGIC;
            rx_mtyout0                     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            rx_mtyout1                     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            rx_mtyout2                     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            rx_mtyout3                     : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            rx_sopout0                     : OUT STD_LOGIC;
            rx_sopout1                     : OUT STD_LOGIC;
            rx_sopout2                     : OUT STD_LOGIC;
            rx_sopout3                     : OUT STD_LOGIC;
            rx_otn_bip8_0                  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            rx_otn_bip8_1                  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            rx_otn_bip8_2                  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            rx_otn_bip8_3                  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            rx_otn_bip8_4                  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            rx_otn_data_0                  : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
            rx_otn_data_1                  : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
            rx_otn_data_2                  : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
            rx_otn_data_3                  : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
            rx_otn_data_4                  : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
            rx_otn_ena                     : OUT STD_LOGIC;
            rx_otn_lane0                   : OUT STD_LOGIC;
            rx_otn_vlmarker                : OUT STD_LOGIC;
            rx_preambleout                 : OUT STD_LOGIC_VECTOR(55 DOWNTO 0);
            usr_rx_reset                   : OUT STD_LOGIC;
            gt_rxusrclk2                   : OUT STD_LOGIC;            
            stat_rx_aligned                : OUT STD_LOGIC;
            stat_rx_aligned_err            : OUT STD_LOGIC;
            stat_rx_bad_code               : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            stat_rx_bad_fcs                : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            stat_rx_bad_preamble           : OUT STD_LOGIC;
            stat_rx_bad_sfd                : OUT STD_LOGIC;
            stat_rx_bip_err_0              : OUT STD_LOGIC;
            stat_rx_bip_err_1              : OUT STD_LOGIC;
            stat_rx_bip_err_10             : OUT STD_LOGIC;
            stat_rx_bip_err_11             : OUT STD_LOGIC;
            stat_rx_bip_err_12             : OUT STD_LOGIC;
            stat_rx_bip_err_13             : OUT STD_LOGIC;
            stat_rx_bip_err_14             : OUT STD_LOGIC;
            stat_rx_bip_err_15             : OUT STD_LOGIC;
            stat_rx_bip_err_16             : OUT STD_LOGIC;
            stat_rx_bip_err_17             : OUT STD_LOGIC;
            stat_rx_bip_err_18             : OUT STD_LOGIC;
            stat_rx_bip_err_19             : OUT STD_LOGIC;
            stat_rx_bip_err_2              : OUT STD_LOGIC;
            stat_rx_bip_err_3              : OUT STD_LOGIC;
            stat_rx_bip_err_4              : OUT STD_LOGIC;
            stat_rx_bip_err_5              : OUT STD_LOGIC;
            stat_rx_bip_err_6              : OUT STD_LOGIC;
            stat_rx_bip_err_7              : OUT STD_LOGIC;
            stat_rx_bip_err_8              : OUT STD_LOGIC;
            stat_rx_bip_err_9              : OUT STD_LOGIC;
            stat_rx_block_lock             : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
            stat_rx_broadcast              : OUT STD_LOGIC;
            stat_rx_fragment               : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            stat_rx_framing_err_0          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_1          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_10         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_11         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_12         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_13         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_14         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_15         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_16         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_17         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_18         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_19         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_2          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_3          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_4          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_5          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_6          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_7          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_8          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_9          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            stat_rx_framing_err_valid_0    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_1    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_10   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_11   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_12   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_13   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_14   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_15   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_16   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_17   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_18   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_19   : OUT STD_LOGIC;
            stat_rx_framing_err_valid_2    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_3    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_4    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_5    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_6    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_7    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_8    : OUT STD_LOGIC;
            stat_rx_framing_err_valid_9    : OUT STD_LOGIC;
            stat_rx_got_signal_os          : OUT STD_LOGIC;
            stat_rx_hi_ber                 : OUT STD_LOGIC;
            stat_rx_inrangeerr             : OUT STD_LOGIC;
            stat_rx_internal_local_fault   : OUT STD_LOGIC;
            stat_rx_jabber                 : OUT STD_LOGIC;
            stat_rx_local_fault            : OUT STD_LOGIC;
            stat_rx_mf_err                 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
            stat_rx_mf_len_err             : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
            stat_rx_mf_repeat_err          : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
            stat_rx_misaligned             : OUT STD_LOGIC;
            stat_rx_multicast              : OUT STD_LOGIC;
            stat_rx_oversize               : OUT STD_LOGIC;
            stat_rx_packet_1024_1518_bytes : OUT STD_LOGIC;
            stat_rx_packet_128_255_bytes   : OUT STD_LOGIC;
            stat_rx_packet_1519_1522_bytes : OUT STD_LOGIC;
            stat_rx_packet_1523_1548_bytes : OUT STD_LOGIC;
            stat_rx_packet_1549_2047_bytes : OUT STD_LOGIC;
            stat_rx_packet_2048_4095_bytes : OUT STD_LOGIC;
            stat_rx_packet_256_511_bytes   : OUT STD_LOGIC;
            stat_rx_packet_4096_8191_bytes : OUT STD_LOGIC;
            stat_rx_packet_512_1023_bytes  : OUT STD_LOGIC;
            stat_rx_packet_64_bytes        : OUT STD_LOGIC;
            stat_rx_packet_65_127_bytes    : OUT STD_LOGIC;
            stat_rx_packet_8192_9215_bytes : OUT STD_LOGIC;
            stat_rx_packet_bad_fcs         : OUT STD_LOGIC;
            stat_rx_packet_large           : OUT STD_LOGIC;
            stat_rx_packet_small           : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            ctl_rx_enable                  : IN  STD_LOGIC;
            ctl_rx_force_resync            : IN  STD_LOGIC;
            ctl_rx_test_pattern            : IN  STD_LOGIC;
            core_rx_reset                  : IN  STD_LOGIC;
            rx_clk                         : IN  STD_LOGIC;
            stat_rx_received_local_fault   : OUT STD_LOGIC;
            stat_rx_remote_fault           : OUT STD_LOGIC;
            stat_rx_status                 : OUT STD_LOGIC;
            stat_rx_stomped_fcs            : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            stat_rx_synced                 : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
            stat_rx_synced_err             : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
            stat_rx_test_pattern_mismatch  : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            stat_rx_toolong                : OUT STD_LOGIC;
            stat_rx_total_bytes            : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
            stat_rx_total_good_bytes       : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
            stat_rx_total_good_packets     : OUT STD_LOGIC;
            stat_rx_total_packets          : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            stat_rx_truncated              : OUT STD_LOGIC;
            stat_rx_undersize              : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
            stat_rx_unicast                : OUT STD_LOGIC;
            stat_rx_vlan                   : OUT STD_LOGIC;
            stat_rx_pcsl_demuxed           : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
            stat_rx_pcsl_number_0          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_1          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_10         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_11         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_12         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_13         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_14         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_15         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_16         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_17         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_18         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_19         : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_2          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_3          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_4          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_5          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_6          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_7          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_8          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_rx_pcsl_number_9          : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
            stat_tx_bad_fcs                : OUT STD_LOGIC;
            stat_tx_broadcast              : OUT STD_LOGIC;
            stat_tx_frame_error            : OUT STD_LOGIC;
            stat_tx_local_fault            : OUT STD_LOGIC;
            stat_tx_multicast              : OUT STD_LOGIC;
            stat_tx_packet_1024_1518_bytes : OUT STD_LOGIC;
            stat_tx_packet_128_255_bytes   : OUT STD_LOGIC;
            stat_tx_packet_1519_1522_bytes : OUT STD_LOGIC;
            stat_tx_packet_1523_1548_bytes : OUT STD_LOGIC;
            stat_tx_packet_1549_2047_bytes : OUT STD_LOGIC;
            stat_tx_packet_2048_4095_bytes : OUT STD_LOGIC;
            stat_tx_packet_256_511_bytes   : OUT STD_LOGIC;
            stat_tx_packet_4096_8191_bytes : OUT STD_LOGIC;
            stat_tx_packet_512_1023_bytes  : OUT STD_LOGIC;
            stat_tx_packet_64_bytes        : OUT STD_LOGIC;
            stat_tx_packet_65_127_bytes    : OUT STD_LOGIC;
            stat_tx_packet_8192_9215_bytes : OUT STD_LOGIC;
            stat_tx_packet_large           : OUT STD_LOGIC;
            stat_tx_packet_small           : OUT STD_LOGIC;
            stat_tx_total_bytes            : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            stat_tx_total_good_bytes       : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
            stat_tx_total_good_packets     : OUT STD_LOGIC;
            stat_tx_total_packets          : OUT STD_LOGIC;
            stat_tx_unicast                : OUT STD_LOGIC;
            stat_tx_vlan                   : OUT STD_LOGIC;
            ctl_tx_enable                  : IN  STD_LOGIC;
            ctl_tx_send_idle               : IN  STD_LOGIC;
            ctl_tx_send_rfi                : IN  STD_LOGIC;
            ctl_tx_send_lfi                : IN  STD_LOGIC;
            ctl_tx_test_pattern            : IN  STD_LOGIC;
            core_tx_reset                  : IN  STD_LOGIC;
            tx_ovfout                      : OUT STD_LOGIC;
            tx_rdyout                      : OUT STD_LOGIC;
            tx_unfout                      : OUT STD_LOGIC;
            tx_datain0                     : IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
            tx_datain1                     : IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
            tx_datain2                     : IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
            tx_datain3                     : IN  STD_LOGIC_VECTOR(127 DOWNTO 0);
            tx_enain0                      : IN  STD_LOGIC;
            tx_enain1                      : IN  STD_LOGIC;
            tx_enain2                      : IN  STD_LOGIC;
            tx_enain3                      : IN  STD_LOGIC;
            tx_eopin0                      : IN  STD_LOGIC;
            tx_eopin1                      : IN  STD_LOGIC;
            tx_eopin2                      : IN  STD_LOGIC;
            tx_eopin3                      : IN  STD_LOGIC;
            tx_errin0                      : IN  STD_LOGIC;
            tx_errin1                      : IN  STD_LOGIC;
            tx_errin2                      : IN  STD_LOGIC;
            tx_errin3                      : IN  STD_LOGIC;
            tx_mtyin0                      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            tx_mtyin1                      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            tx_mtyin2                      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            tx_mtyin3                      : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
            tx_sopin0                      : IN  STD_LOGIC;
            tx_sopin1                      : IN  STD_LOGIC;
            tx_sopin2                      : IN  STD_LOGIC;
            tx_sopin3                      : IN  STD_LOGIC;
            tx_preamblein                  : IN  STD_LOGIC_VECTOR(55 DOWNTO 0);
            usr_tx_reset                   : OUT STD_LOGIC;
            core_drp_reset                 : IN  STD_LOGIC;
            drp_clk                        : IN  STD_LOGIC;
            drp_addr                       : IN  STD_LOGIC_VECTOR(9 DOWNTO 0);
            drp_di                         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            drp_en                         : IN  STD_LOGIC;
            drp_do                         : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
            drp_rdy                        : OUT STD_LOGIC;
            drp_we                         : IN  STD_LOGIC
        );
    end component EthMACPHY100GQSFP14x;

    component lbustoaxis is
        port(
            lbus_rxclk      : in  STD_LOGIC;
            lbus_txclk      : in  STD_LOGIC;
            lbus_rxreset    : in  STD_LOGIC;
            lbus_txreset    : in  STD_LOGIC;
            --Inputs from AXIS bus 
            axis_rx_tdata   : in  STD_LOGIC_VECTOR(511 downto 0);
            axis_rx_tvalid  : in  STD_LOGIC;
            axis_rx_tready  : out STD_LOGIC;
            axis_rx_tkeep   : in  STD_LOGIC_VECTOR(63 downto 0);
            axis_rx_tlast   : in  STD_LOGIC;
            axis_rx_tuser   : in  STD_LOGIC;
            -- Outputs to AXIS bus
            axis_tx_tdata   : out STD_LOGIC_VECTOR(511 downto 0);
            axis_tx_tvalid  : out STD_LOGIC;
            axis_tx_tkeep   : out STD_LOGIC_VECTOR(63 downto 0);
            axis_tx_tlast   : out STD_LOGIC;
            axis_tx_tuser   : out STD_LOGIC;
            --Outputs to L-BUS interface
            lbus_tx_rdyout  : in  STD_LOGIC;
            -- Segment 0
            lbus_txdataout0 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout0  : out STD_LOGIC;
            lbus_txsopout0  : out STD_LOGIC;
            lbus_txeopout0  : out STD_LOGIC;
            lbus_txerrout0  : out STD_LOGIC;
            lbus_txmtyout0  : out STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 1
            lbus_txdataout1 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout1  : out STD_LOGIC;
            lbus_txsopout1  : out STD_LOGIC;
            lbus_txeopout1  : out STD_LOGIC;
            lbus_txerrout1  : out STD_LOGIC;
            lbus_txmtyout1  : out STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 2
            lbus_txdataout2 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout2  : out STD_LOGIC;
            lbus_txsopout2  : out STD_LOGIC;
            lbus_txeopout2  : out STD_LOGIC;
            lbus_txerrout2  : out STD_LOGIC;
            lbus_txmtyout2  : out STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 3		
            lbus_txdataout3 : out STD_LOGIC_VECTOR(127 downto 0);
            lbus_txenaout3  : out STD_LOGIC;
            lbus_txsopout3  : out STD_LOGIC;
            lbus_txeopout3  : out STD_LOGIC;
            lbus_txerrout3  : out STD_LOGIC;
            lbus_txmtyout3  : out STD_LOGIC_VECTOR(3 downto 0);
            -- Inputs from L-BUS interface
            -- Segment 0		
            lbus_rxdatain0  : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain0   : in  STD_LOGIC;
            lbus_rxsopin0   : in  STD_LOGIC;
            lbus_rxeopin0   : in  STD_LOGIC;
            lbus_rxerrin0   : in  STD_LOGIC;
            lbus_rxmtyin0   : in  STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 1		
            lbus_rxdatain1  : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain1   : in  STD_LOGIC;
            lbus_rxsopin1   : in  STD_LOGIC;
            lbus_rxeopin1   : in  STD_LOGIC;
            lbus_rxerrin1   : in  STD_LOGIC;
            lbus_rxmtyin1   : in  STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 2		
            lbus_rxdatain2  : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain2   : in  STD_LOGIC;
            lbus_rxsopin2   : in  STD_LOGIC;
            lbus_rxeopin2   : in  STD_LOGIC;
            lbus_rxerrin2   : in  STD_LOGIC;
            lbus_rxmtyin2   : in  STD_LOGIC_VECTOR(3 downto 0);
            -- Segment 3		
            lbus_rxdatain3  : in  STD_LOGIC_VECTOR(127 downto 0);
            lbus_rxenain3   : in  STD_LOGIC;
            lbus_rxsopin3   : in  STD_LOGIC;
            lbus_rxeopin3   : in  STD_LOGIC;
            lbus_rxerrin3   : in  STD_LOGIC;
            lbus_rxmtyin3   : in  STD_LOGIC_VECTOR(3 downto 0)
        );
    end component lbustoaxis;

    signal lbus_rx_clk         : STD_LOGIC;
    signal lbus_tx_clk         : STD_LOGIC;
    signal lbus_rx_reset       : STD_LOGIC;
    signal lbus_tx_reset       : STD_LOGIC;
    signal lbus_tx_rdyout      : STD_LOGIC;
    signal lbus_txdataout0     : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout0      : STD_LOGIC;
    signal lbus_txsopout0      : STD_LOGIC;
    signal lbus_txeopout0      : STD_LOGIC;
    signal lbus_txerrout0      : STD_LOGIC;
    signal lbus_txmtyout0      : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_txdataout1     : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout1      : STD_LOGIC;
    signal lbus_txsopout1      : STD_LOGIC;
    signal lbus_txeopout1      : STD_LOGIC;
    signal lbus_txerrout1      : STD_LOGIC;
    signal lbus_txmtyout1      : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_txdataout2     : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout2      : STD_LOGIC;
    signal lbus_txsopout2      : STD_LOGIC;
    signal lbus_txeopout2      : STD_LOGIC;
    signal lbus_txerrout2      : STD_LOGIC;
    signal lbus_txmtyout2      : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_txdataout3     : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_txenaout3      : STD_LOGIC;
    signal lbus_txsopout3      : STD_LOGIC;
    signal lbus_txeopout3      : STD_LOGIC;
    signal lbus_txerrout3      : STD_LOGIC;
    signal lbus_txmtyout3      : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_rxdatain0      : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_rxenain0       : STD_LOGIC;
    signal lbus_rxsopin0       : STD_LOGIC;
    signal lbus_rxeopin0       : STD_LOGIC;
    signal lbus_rxerrin0       : STD_LOGIC;
    signal lbus_rxmtyin0       : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_rxdatain1      : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_rxenain1       : STD_LOGIC;
    signal lbus_rxsopin1       : STD_LOGIC;
    signal lbus_rxeopin1       : STD_LOGIC;
    signal lbus_rxerrin1       : STD_LOGIC;
    signal lbus_rxmtyin1       : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_rxdatain2      : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_rxenain2       : STD_LOGIC;
    signal lbus_rxsopin2       : STD_LOGIC;
    signal lbus_rxeopin2       : STD_LOGIC;
    signal lbus_rxerrin2       : STD_LOGIC;
    signal lbus_rxmtyin2       : STD_LOGIC_VECTOR(3 downto 0);
    signal lbus_rxdatain3      : STD_LOGIC_VECTOR(127 downto 0);
    signal lbus_rxenain3       : STD_LOGIC;
    signal lbus_rxsopin3       : STD_LOGIC;
    signal lbus_rxeopin3       : STD_LOGIC;
    signal lbus_rxerrin3       : STD_LOGIC;
    signal lbus_rxmtyin3       : STD_LOGIC_VECTOR(3 downto 0);
    signal ctl_tx_send_idle    : STD_LOGIC;
    signal ctl_tx_send_rfi     : STD_LOGIC;
    signal ctl_tx_send_lfi     : STD_LOGIC;
    signal ctl_tx_test_pattern : STD_LOGIC;
    signal ctl_rx_force_resync : STD_LOGIC;
    signal ctl_rx_test_pattern : STD_LOGIC;
    signal gt_loopback_in      : STD_LOGIC_VECTOR(11 DOWNTO 0);
    signal tx_preamblein       : STD_LOGIC_VECTOR(55 DOWNTO 0);
    signal drp_clk             : STD_LOGIC;
    signal drp_addr            : STD_LOGIC_VECTOR(9 DOWNTO 0);
    signal drp_di              : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal drp_en              : STD_LOGIC;
    signal drp_we              : STD_LOGIC;

begin
    axis_tx_clkout <= lbus_tx_clk;
    lbus_rx_clk    <= axis_rx_clkin;
    lbus_rx_reset  <= Reset or lbus_reset;
    lbus_tx_reset  <= Reset or lbus_reset;

    -- Don't send idle frames 
    ctl_tx_send_idle    <= '0';
    -- Don't send remote fault indicators 
    ctl_tx_send_rfi     <= '0';
    -- Don't send local fault indicators 	   
    ctl_tx_send_lfi     <= '0';
    -- Don't set transmitter to send test patterns 
    ctl_tx_test_pattern <= '0';
    -- Don't force resynchronizations 	
    ctl_rx_force_resync <= '0';
    -- Don't set receiver to test patterns
    ctl_rx_test_pattern <= '0';
    -- Set loop back to normal operation for all 4 MGTs
    gt_loopback_in      <= X"000";
    -- We are not using the custom preamble
    tx_preamblein       <= (others => '0');
    -- Tie down DRP as it is not used
    drp_clk             <= '0';
    drp_addr            <= (others => '0');
    drp_di              <= (others => '0');
    drp_en              <= '0';
    drp_we              <= '0';

    LBUSAXIS_QSFP1_i : lbustoaxis
        port map(
            lbus_rxclk      => lbus_rx_clk,
            lbus_txclk      => lbus_tx_clk,
            lbus_rxreset    => lbus_rx_reset,
            lbus_txreset    => lbus_tx_reset,
            axis_rx_tdata   => axis_rx_tdata,
            axis_rx_tvalid  => axis_rx_tvalid,
            axis_rx_tready  => axis_rx_tready,
            axis_rx_tkeep   => axis_rx_tkeep,
            axis_rx_tlast   => axis_rx_tlast,
            axis_rx_tuser   => axis_rx_tuser,
            axis_tx_tdata   => axis_tx_tdata,
            axis_tx_tvalid  => axis_tx_tvalid,
            axis_tx_tkeep   => axis_tx_tkeep,
            axis_tx_tlast   => axis_tx_tlast,
            axis_tx_tuser   => axis_tx_tuser,
            -- TX
            lbus_tx_rdyout  => lbus_tx_rdyout,
            lbus_txdataout0 => lbus_txdataout0,
            lbus_txenaout0  => lbus_txenaout0,
            lbus_txsopout0  => lbus_txsopout0,
            lbus_txeopout0  => lbus_txeopout0,
            lbus_txerrout0  => lbus_txerrout0,
            lbus_txmtyout0  => lbus_txmtyout0,
            lbus_txdataout1 => lbus_txdataout1,
            lbus_txenaout1  => lbus_txenaout1,
            lbus_txsopout1  => lbus_txsopout1,
            lbus_txeopout1  => lbus_txeopout1,
            lbus_txerrout1  => lbus_txerrout1,
            lbus_txmtyout1  => lbus_txmtyout1,
            lbus_txdataout2 => lbus_txdataout2,
            lbus_txenaout2  => lbus_txenaout2,
            lbus_txsopout2  => lbus_txsopout2,
            lbus_txeopout2  => lbus_txeopout2,
            lbus_txerrout2  => lbus_txerrout2,
            lbus_txmtyout2  => lbus_txmtyout2,
            lbus_txdataout3 => lbus_txdataout3,
            lbus_txenaout3  => lbus_txenaout3,
            lbus_txsopout3  => lbus_txsopout3,
            lbus_txeopout3  => lbus_txeopout3,
            lbus_txerrout3  => lbus_txerrout3,
            lbus_txmtyout3  => lbus_txmtyout3,
            --RX
            lbus_rxdatain0  => lbus_rxdatain0,
            lbus_rxenain0   => lbus_rxenain0,
            lbus_rxsopin0   => lbus_rxsopin0,
            lbus_rxeopin0   => lbus_rxeopin0,
            lbus_rxerrin0   => lbus_rxerrin0,
            lbus_rxmtyin0   => lbus_rxmtyin0,
            lbus_rxdatain1  => lbus_rxdatain1,
            lbus_rxenain1   => lbus_rxenain1,
            lbus_rxsopin1   => lbus_rxsopin1,
            lbus_rxeopin1   => lbus_rxeopin1,
            lbus_rxerrin1   => lbus_rxerrin1,
            lbus_rxmtyin1   => lbus_rxmtyin1,
            lbus_rxdatain2  => lbus_rxdatain2,
            lbus_rxenain2   => lbus_rxenain2,
            lbus_rxsopin2   => lbus_rxsopin2,
            lbus_rxeopin2   => lbus_rxeopin2,
            lbus_rxerrin2   => lbus_rxerrin2,
            lbus_rxmtyin2   => lbus_rxmtyin2,
            lbus_rxdatain3  => lbus_rxdatain3,
            lbus_rxenain3   => lbus_rxenain3,
            lbus_rxsopin3   => lbus_rxsopin3,
            lbus_rxeopin3   => lbus_rxeopin3,
            lbus_rxerrin3   => lbus_rxerrin3,
            lbus_rxmtyin3   => lbus_rxmtyin3
        );

    MACPHY_QSFP1_i : EthMACPHY100GQSFP14x
        port map(
            gt0_txp_out                  => qsfp_mgt_tx0_p,
            gt1_txp_out                  => qsfp_mgt_tx1_p,
            gt2_txp_out                  => qsfp_mgt_tx2_p,
            gt3_txp_out                  => qsfp_mgt_tx3_p,
            gt0_txn_out                  => qsfp_mgt_tx0_n,
            gt1_txn_out                  => qsfp_mgt_tx1_n,
            gt2_txn_out                  => qsfp_mgt_tx2_n,
            gt3_txn_out                  => qsfp_mgt_tx3_n,
            gt0_rxp_in                   => qsfp_mgt_rx0_p,
            gt1_rxp_in                   => qsfp_mgt_rx1_p,
            gt2_rxp_in                   => qsfp_mgt_rx2_p,
            gt3_rxp_in                   => qsfp_mgt_rx3_p,
            gt0_rxn_in                   => qsfp_mgt_rx0_n,
            gt1_rxn_in                   => qsfp_mgt_rx1_n,
            gt2_rxn_in                   => qsfp_mgt_rx2_n,
            gt3_rxn_in                   => qsfp_mgt_rx3_n,
            gt_txusrclk2                   => lbus_tx_clk,
            gt_loopback_in                 => gt_loopback_in,
            gt_ref_clk_out                 => open,
            gt_rxrecclkout                 => open,
            gt_powergoodout                => open,
            gtwiz_reset_tx_datapath        => lbus_tx_reset,
            gtwiz_reset_rx_datapath        => lbus_rx_reset,
            sys_reset                      => Reset,
            gt_ref_clk_p                   => mgt_qsfp_clock_p,
            gt_ref_clk_n                   => mgt_qsfp_clock_n,
            init_clk                       => Clk100MHz,
            rx_dataout0                    => lbus_rxdatain0,
            rx_dataout1                    => lbus_rxdatain1,
            rx_dataout2                    => lbus_rxdatain2,
            rx_dataout3                    => lbus_rxdatain3,
            rx_enaout0                     => lbus_rxenain0,
            rx_enaout1                     => lbus_rxenain1,
            rx_enaout2                     => lbus_rxenain2,
            rx_enaout3                     => lbus_rxenain3,
            rx_eopout0                     => lbus_rxeopin0,
            rx_eopout1                     => lbus_rxeopin1,
            rx_eopout2                     => lbus_rxeopin2,
            rx_eopout3                     => lbus_rxeopin3,
            rx_errout0                     => lbus_rxerrin0,
            rx_errout1                     => lbus_rxerrin1,
            rx_errout2                     => lbus_rxerrin2,
            rx_errout3                     => lbus_rxerrin3,
            rx_mtyout0                     => lbus_rxmtyin0,
            rx_mtyout1                     => lbus_rxmtyin1,
            rx_mtyout2                     => lbus_rxmtyin2,
            rx_mtyout3                     => lbus_rxmtyin3,
            rx_sopout0                     => lbus_rxsopin0,
            rx_sopout1                     => lbus_rxsopin1,
            rx_sopout2                     => lbus_rxsopin2,
            rx_sopout3                     => lbus_rxsopin3,
            rx_otn_bip8_0                  => open,
            rx_otn_bip8_1                  => open,
            rx_otn_bip8_2                  => open,
            rx_otn_bip8_3                  => open,
            rx_otn_bip8_4                  => open,
            rx_otn_data_0                  => open,
            rx_otn_data_1                  => open,
            rx_otn_data_2                  => open,
            rx_otn_data_3                  => open,
            rx_otn_data_4                  => open,
            rx_otn_ena                     => open,
            rx_otn_lane0                   => open,
            rx_otn_vlmarker                => open,
            rx_preambleout                 => open,
            usr_rx_reset                   => open,
            gt_rxusrclk2                   => open,
            stat_rx_aligned                => open,
            stat_rx_aligned_err            => open,
            stat_rx_bad_code               => open,
            stat_rx_bad_fcs                => open,
            stat_rx_bad_preamble           => open,
            stat_rx_bad_sfd                => open,
            stat_rx_bip_err_0              => open,
            stat_rx_bip_err_1              => open,
            stat_rx_bip_err_10             => open,
            stat_rx_bip_err_11             => open,
            stat_rx_bip_err_12             => open,
            stat_rx_bip_err_13             => open,
            stat_rx_bip_err_14             => open,
            stat_rx_bip_err_15             => open,
            stat_rx_bip_err_16             => open,
            stat_rx_bip_err_17             => open,
            stat_rx_bip_err_18             => open,
            stat_rx_bip_err_19             => open,
            stat_rx_bip_err_2              => open,
            stat_rx_bip_err_3              => open,
            stat_rx_bip_err_4              => open,
            stat_rx_bip_err_5              => open,
            stat_rx_bip_err_6              => open,
            stat_rx_bip_err_7              => open,
            stat_rx_bip_err_8              => open,
            stat_rx_bip_err_9              => open,
            stat_rx_block_lock             => open,
            stat_rx_broadcast              => open,
            stat_rx_fragment               => open,
            stat_rx_framing_err_0          => open,
            stat_rx_framing_err_1          => open,
            stat_rx_framing_err_10         => open,
            stat_rx_framing_err_11         => open,
            stat_rx_framing_err_12         => open,
            stat_rx_framing_err_13         => open,
            stat_rx_framing_err_14         => open,
            stat_rx_framing_err_15         => open,
            stat_rx_framing_err_16         => open,
            stat_rx_framing_err_17         => open,
            stat_rx_framing_err_18         => open,
            stat_rx_framing_err_19         => open,
            stat_rx_framing_err_2          => open,
            stat_rx_framing_err_3          => open,
            stat_rx_framing_err_4          => open,
            stat_rx_framing_err_5          => open,
            stat_rx_framing_err_6          => open,
            stat_rx_framing_err_7          => open,
            stat_rx_framing_err_8          => open,
            stat_rx_framing_err_9          => open,
            stat_rx_framing_err_valid_0    => open,
            stat_rx_framing_err_valid_1    => open,
            stat_rx_framing_err_valid_10   => open,
            stat_rx_framing_err_valid_11   => open,
            stat_rx_framing_err_valid_12   => open,
            stat_rx_framing_err_valid_13   => open,
            stat_rx_framing_err_valid_14   => open,
            stat_rx_framing_err_valid_15   => open,
            stat_rx_framing_err_valid_16   => open,
            stat_rx_framing_err_valid_17   => open,
            stat_rx_framing_err_valid_18   => open,
            stat_rx_framing_err_valid_19   => open,
            stat_rx_framing_err_valid_2    => open,
            stat_rx_framing_err_valid_3    => open,
            stat_rx_framing_err_valid_4    => open,
            stat_rx_framing_err_valid_5    => open,
            stat_rx_framing_err_valid_6    => open,
            stat_rx_framing_err_valid_7    => open,
            stat_rx_framing_err_valid_8    => open,
            stat_rx_framing_err_valid_9    => open,
            stat_rx_got_signal_os          => open,
            stat_rx_hi_ber                 => open,
            stat_rx_inrangeerr             => open,
            stat_rx_internal_local_fault   => open,
            stat_rx_jabber                 => open,
            stat_rx_local_fault            => open,
            stat_rx_mf_err                 => open,
            stat_rx_mf_len_err             => open,
            stat_rx_mf_repeat_err          => open,
            stat_rx_misaligned             => open,
            stat_rx_multicast              => open,
            stat_rx_oversize               => open,
            stat_rx_packet_1024_1518_bytes => open,
            stat_rx_packet_128_255_bytes   => open,
            stat_rx_packet_1519_1522_bytes => open,
            stat_rx_packet_1523_1548_bytes => open,
            stat_rx_packet_1549_2047_bytes => open,
            stat_rx_packet_2048_4095_bytes => open,
            stat_rx_packet_256_511_bytes   => open,
            stat_rx_packet_4096_8191_bytes => open,
            stat_rx_packet_512_1023_bytes  => open,
            stat_rx_packet_64_bytes        => open,
            stat_rx_packet_65_127_bytes    => open,
            stat_rx_packet_8192_9215_bytes => open,
            stat_rx_packet_bad_fcs         => open,
            stat_rx_packet_large           => open,
            stat_rx_packet_small           => open,
            ctl_rx_enable                  => Enable,
            ctl_rx_force_resync            => ctl_rx_force_resync,
            ctl_rx_test_pattern            => ctl_rx_test_pattern,
            core_rx_reset                  => lbus_rx_reset,
            rx_clk                         => lbus_rx_clk,
            stat_rx_received_local_fault   => open,
            stat_rx_remote_fault           => open,
            stat_rx_status                 => open,
            stat_rx_stomped_fcs            => open,
            stat_rx_synced                 => open,
            stat_rx_synced_err             => open,
            stat_rx_test_pattern_mismatch  => open,
            stat_rx_toolong                => open,
            stat_rx_total_bytes            => open,
            stat_rx_total_good_bytes       => open,
            stat_rx_total_good_packets     => open,
            stat_rx_total_packets          => open,
            stat_rx_truncated              => open,
            stat_rx_undersize              => open,
            stat_rx_unicast                => open,
            stat_rx_vlan                   => open,
            stat_rx_pcsl_demuxed           => open,
            stat_rx_pcsl_number_0          => open,
            stat_rx_pcsl_number_1          => open,
            stat_rx_pcsl_number_10         => open,
            stat_rx_pcsl_number_11         => open,
            stat_rx_pcsl_number_12         => open,
            stat_rx_pcsl_number_13         => open,
            stat_rx_pcsl_number_14         => open,
            stat_rx_pcsl_number_15         => open,
            stat_rx_pcsl_number_16         => open,
            stat_rx_pcsl_number_17         => open,
            stat_rx_pcsl_number_18         => open,
            stat_rx_pcsl_number_19         => open,
            stat_rx_pcsl_number_2          => open,
            stat_rx_pcsl_number_3          => open,
            stat_rx_pcsl_number_4          => open,
            stat_rx_pcsl_number_5          => open,
            stat_rx_pcsl_number_6          => open,
            stat_rx_pcsl_number_7          => open,
            stat_rx_pcsl_number_8          => open,
            stat_rx_pcsl_number_9          => open,
            stat_tx_bad_fcs                => open,
            stat_tx_broadcast              => open,
            stat_tx_frame_error            => open,
            stat_tx_local_fault            => open,
            stat_tx_multicast              => open,
            stat_tx_packet_1024_1518_bytes => open,
            stat_tx_packet_128_255_bytes   => open,
            stat_tx_packet_1519_1522_bytes => open,
            stat_tx_packet_1523_1548_bytes => open,
            stat_tx_packet_1549_2047_bytes => open,
            stat_tx_packet_2048_4095_bytes => open,
            stat_tx_packet_256_511_bytes   => open,
            stat_tx_packet_4096_8191_bytes => open,
            stat_tx_packet_512_1023_bytes  => open,
            stat_tx_packet_64_bytes        => open,
            stat_tx_packet_65_127_bytes    => open,
            stat_tx_packet_8192_9215_bytes => open,
            stat_tx_packet_large           => open,
            stat_tx_packet_small           => open,
            stat_tx_total_bytes            => open,
            stat_tx_total_good_bytes       => open,
            stat_tx_total_good_packets     => open,
            stat_tx_total_packets          => open,
            stat_tx_unicast                => open,
            stat_tx_vlan                   => open,
            ctl_tx_enable                  => Enable,
            ctl_tx_send_idle               => ctl_tx_send_idle,
            ctl_tx_send_rfi                => ctl_tx_send_rfi,
            ctl_tx_send_lfi                => ctl_tx_send_lfi,
            ctl_tx_test_pattern            => ctl_tx_test_pattern,
            core_tx_reset                  => lbus_tx_reset,
            tx_ovfout                      => lbus_tx_ovfout,
            tx_rdyout                      => lbus_tx_rdyout,
            tx_unfout                      => lbus_tx_unfout,
            tx_datain0                     => lbus_txdataout0,
            tx_datain1                     => lbus_txdataout1,
            tx_datain2                     => lbus_txdataout2,
            tx_datain3                     => lbus_txdataout3,
            tx_enain0                      => lbus_txenaout0,
            tx_enain1                      => lbus_txenaout1,
            tx_enain2                      => lbus_txenaout2,
            tx_enain3                      => lbus_txenaout3,
            tx_eopin0                      => lbus_txeopout0,
            tx_eopin1                      => lbus_txeopout1,
            tx_eopin2                      => lbus_txeopout2,
            tx_eopin3                      => lbus_txeopout3,
            tx_errin0                      => lbus_txerrout0,
            tx_errin1                      => lbus_txerrout1,
            tx_errin2                      => lbus_txerrout2,
            tx_errin3                      => lbus_txerrout3,
            tx_mtyin0                      => lbus_txmtyout0,
            tx_mtyin1                      => lbus_txmtyout1,
            tx_mtyin2                      => lbus_txmtyout2,
            tx_mtyin3                      => lbus_txmtyout3,
            tx_sopin0                      => lbus_txsopout0,
            tx_sopin1                      => lbus_txsopout1,
            tx_sopin2                      => lbus_txsopout2,
            tx_sopin3                      => lbus_txsopout3,
            tx_preamblein                  => tx_preamblein,
            usr_tx_reset                   => open,
            core_drp_reset                 => Reset,
            drp_clk                        => drp_clk,
            drp_addr                       => drp_addr,
            drp_di                         => drp_di,
            drp_en                         => drp_en,
            drp_do                         => open,
            drp_rdy                        => open,
            drp_we                         => drp_we
        );

end architecture rtl;
