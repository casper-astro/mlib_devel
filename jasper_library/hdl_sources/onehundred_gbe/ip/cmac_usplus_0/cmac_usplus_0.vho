-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:cmac_usplus:2.4
-- IP Revision: 1

-- The following code must appear in the VHDL architecture header.

------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
COMPONENT cmac_usplus_0
  PORT (
    txdata_in : OUT STD_LOGIC_VECTOR(511 DOWNTO 0);
    txctrl0_in : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    txctrl1_in : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    rxdata_out : IN STD_LOGIC_VECTOR(511 DOWNTO 0);
    rxctrl0_out : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    rxctrl1_out : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    ctl_tx_rsfec_enable : IN STD_LOGIC;
    ctl_rx_rsfec_enable : IN STD_LOGIC;
    ctl_rsfec_ieee_error_indication_mode : IN STD_LOGIC;
    ctl_rx_rsfec_enable_correction : IN STD_LOGIC;
    ctl_rx_rsfec_enable_indication : IN STD_LOGIC;
    stat_rx_rsfec_am_lock0 : OUT STD_LOGIC;
    stat_rx_rsfec_am_lock1 : OUT STD_LOGIC;
    stat_rx_rsfec_am_lock2 : OUT STD_LOGIC;
    stat_rx_rsfec_am_lock3 : OUT STD_LOGIC;
    stat_rx_rsfec_corrected_cw_inc : OUT STD_LOGIC;
    stat_rx_rsfec_cw_inc : OUT STD_LOGIC;
    stat_rx_rsfec_err_count0_inc : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_rsfec_err_count1_inc : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_rsfec_err_count2_inc : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_rsfec_err_count3_inc : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_rsfec_hi_ser : OUT STD_LOGIC;
    stat_rx_rsfec_lane_alignment_status : OUT STD_LOGIC;
    stat_rx_rsfec_lane_fill_0 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    stat_rx_rsfec_lane_fill_1 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    stat_rx_rsfec_lane_fill_2 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    stat_rx_rsfec_lane_fill_3 : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    stat_rx_rsfec_lane_mapping : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    stat_rx_rsfec_uncorrected_cw_inc : OUT STD_LOGIC;
    rx_dataout0 : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    rx_dataout1 : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    rx_dataout2 : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    rx_dataout3 : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    rx_enaout0 : OUT STD_LOGIC;
    rx_enaout1 : OUT STD_LOGIC;
    rx_enaout2 : OUT STD_LOGIC;
    rx_enaout3 : OUT STD_LOGIC;
    rx_eopout0 : OUT STD_LOGIC;
    rx_eopout1 : OUT STD_LOGIC;
    rx_eopout2 : OUT STD_LOGIC;
    rx_eopout3 : OUT STD_LOGIC;
    rx_errout0 : OUT STD_LOGIC;
    rx_errout1 : OUT STD_LOGIC;
    rx_errout2 : OUT STD_LOGIC;
    rx_errout3 : OUT STD_LOGIC;
    rx_mtyout0 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rx_mtyout1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rx_mtyout2 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rx_mtyout3 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    rx_sopout0 : OUT STD_LOGIC;
    rx_sopout1 : OUT STD_LOGIC;
    rx_sopout2 : OUT STD_LOGIC;
    rx_sopout3 : OUT STD_LOGIC;
    rx_otn_bip8_0 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_otn_bip8_1 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_otn_bip8_2 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_otn_bip8_3 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_otn_bip8_4 : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    rx_otn_data_0 : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
    rx_otn_data_1 : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
    rx_otn_data_2 : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
    rx_otn_data_3 : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
    rx_otn_data_4 : OUT STD_LOGIC_VECTOR(65 DOWNTO 0);
    rx_otn_ena : OUT STD_LOGIC;
    rx_otn_lane0 : OUT STD_LOGIC;
    rx_otn_vlmarker : OUT STD_LOGIC;
    rx_preambleout : OUT STD_LOGIC_VECTOR(55 DOWNTO 0);
    stat_rx_aligned : OUT STD_LOGIC;
    stat_rx_aligned_err : OUT STD_LOGIC;
    stat_rx_bad_code : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_bad_fcs : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_bad_preamble : OUT STD_LOGIC;
    stat_rx_bad_sfd : OUT STD_LOGIC;
    stat_rx_bip_err_0 : OUT STD_LOGIC;
    stat_rx_bip_err_1 : OUT STD_LOGIC;
    stat_rx_bip_err_10 : OUT STD_LOGIC;
    stat_rx_bip_err_11 : OUT STD_LOGIC;
    stat_rx_bip_err_12 : OUT STD_LOGIC;
    stat_rx_bip_err_13 : OUT STD_LOGIC;
    stat_rx_bip_err_14 : OUT STD_LOGIC;
    stat_rx_bip_err_15 : OUT STD_LOGIC;
    stat_rx_bip_err_16 : OUT STD_LOGIC;
    stat_rx_bip_err_17 : OUT STD_LOGIC;
    stat_rx_bip_err_18 : OUT STD_LOGIC;
    stat_rx_bip_err_19 : OUT STD_LOGIC;
    stat_rx_bip_err_2 : OUT STD_LOGIC;
    stat_rx_bip_err_3 : OUT STD_LOGIC;
    stat_rx_bip_err_4 : OUT STD_LOGIC;
    stat_rx_bip_err_5 : OUT STD_LOGIC;
    stat_rx_bip_err_6 : OUT STD_LOGIC;
    stat_rx_bip_err_7 : OUT STD_LOGIC;
    stat_rx_bip_err_8 : OUT STD_LOGIC;
    stat_rx_bip_err_9 : OUT STD_LOGIC;
    stat_rx_block_lock : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    stat_rx_broadcast : OUT STD_LOGIC;
    stat_rx_fragment : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_framing_err_0 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_1 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_10 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_11 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_12 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_13 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_14 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_15 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_16 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_17 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_18 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_19 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_3 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_4 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_5 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_6 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_7 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_8 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_9 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    stat_rx_framing_err_valid_0 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_1 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_10 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_11 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_12 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_13 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_14 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_15 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_16 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_17 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_18 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_19 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_2 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_3 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_4 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_5 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_6 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_7 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_8 : OUT STD_LOGIC;
    stat_rx_framing_err_valid_9 : OUT STD_LOGIC;
    stat_rx_got_signal_os : OUT STD_LOGIC;
    stat_rx_hi_ber : OUT STD_LOGIC;
    stat_rx_inrangeerr : OUT STD_LOGIC;
    stat_rx_internal_local_fault : OUT STD_LOGIC;
    stat_rx_jabber : OUT STD_LOGIC;
    stat_rx_local_fault : OUT STD_LOGIC;
    stat_rx_mf_err : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    stat_rx_mf_len_err : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    stat_rx_mf_repeat_err : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    stat_rx_misaligned : OUT STD_LOGIC;
    stat_rx_multicast : OUT STD_LOGIC;
    stat_rx_oversize : OUT STD_LOGIC;
    stat_rx_packet_1024_1518_bytes : OUT STD_LOGIC;
    stat_rx_packet_128_255_bytes : OUT STD_LOGIC;
    stat_rx_packet_1519_1522_bytes : OUT STD_LOGIC;
    stat_rx_packet_1523_1548_bytes : OUT STD_LOGIC;
    stat_rx_packet_1549_2047_bytes : OUT STD_LOGIC;
    stat_rx_packet_2048_4095_bytes : OUT STD_LOGIC;
    stat_rx_packet_256_511_bytes : OUT STD_LOGIC;
    stat_rx_packet_4096_8191_bytes : OUT STD_LOGIC;
    stat_rx_packet_512_1023_bytes : OUT STD_LOGIC;
    stat_rx_packet_64_bytes : OUT STD_LOGIC;
    stat_rx_packet_65_127_bytes : OUT STD_LOGIC;
    stat_rx_packet_8192_9215_bytes : OUT STD_LOGIC;
    stat_rx_packet_bad_fcs : OUT STD_LOGIC;
    stat_rx_packet_large : OUT STD_LOGIC;
    stat_rx_packet_small : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_pause : OUT STD_LOGIC;
    stat_rx_pause_quanta0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta1 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta2 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta3 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta4 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta5 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta6 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta7 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_quanta8 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    stat_rx_pause_req : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    stat_rx_pause_valid : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    stat_rx_user_pause : OUT STD_LOGIC;
    ctl_rx_check_etype_gcp : IN STD_LOGIC;
    ctl_rx_check_etype_gpp : IN STD_LOGIC;
    ctl_rx_check_etype_pcp : IN STD_LOGIC;
    ctl_rx_check_etype_ppp : IN STD_LOGIC;
    ctl_rx_check_mcast_gcp : IN STD_LOGIC;
    ctl_rx_check_mcast_gpp : IN STD_LOGIC;
    ctl_rx_check_mcast_pcp : IN STD_LOGIC;
    ctl_rx_check_mcast_ppp : IN STD_LOGIC;
    ctl_rx_check_opcode_gcp : IN STD_LOGIC;
    ctl_rx_check_opcode_gpp : IN STD_LOGIC;
    ctl_rx_check_opcode_pcp : IN STD_LOGIC;
    ctl_rx_check_opcode_ppp : IN STD_LOGIC;
    ctl_rx_check_sa_gcp : IN STD_LOGIC;
    ctl_rx_check_sa_gpp : IN STD_LOGIC;
    ctl_rx_check_sa_pcp : IN STD_LOGIC;
    ctl_rx_check_sa_ppp : IN STD_LOGIC;
    ctl_rx_check_ucast_gcp : IN STD_LOGIC;
    ctl_rx_check_ucast_gpp : IN STD_LOGIC;
    ctl_rx_check_ucast_pcp : IN STD_LOGIC;
    ctl_rx_check_ucast_ppp : IN STD_LOGIC;
    ctl_rx_enable_gcp : IN STD_LOGIC;
    ctl_rx_enable_gpp : IN STD_LOGIC;
    ctl_rx_enable_pcp : IN STD_LOGIC;
    ctl_rx_enable_ppp : IN STD_LOGIC;
    ctl_rx_pause_ack : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    ctl_rx_pause_enable : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    ctl_rx_enable : IN STD_LOGIC;
    ctl_rx_force_resync : IN STD_LOGIC;
    ctl_rx_test_pattern : IN STD_LOGIC;
    rx_clk : IN STD_LOGIC;
    stat_rx_received_local_fault : OUT STD_LOGIC;
    stat_rx_remote_fault : OUT STD_LOGIC;
    stat_rx_status : OUT STD_LOGIC;
    stat_rx_stomped_fcs : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_synced : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    stat_rx_synced_err : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    stat_rx_test_pattern_mismatch : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_toolong : OUT STD_LOGIC;
    stat_rx_total_bytes : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
    stat_rx_total_good_bytes : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    stat_rx_total_good_packets : OUT STD_LOGIC;
    stat_rx_total_packets : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_truncated : OUT STD_LOGIC;
    stat_rx_undersize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    stat_rx_unicast : OUT STD_LOGIC;
    stat_rx_vlan : OUT STD_LOGIC;
    stat_rx_pcsl_demuxed : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    stat_rx_pcsl_number_0 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_1 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_10 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_11 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_12 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_13 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_14 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_15 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_16 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_17 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_18 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_19 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_2 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_3 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_4 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_5 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_6 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_7 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_8 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_rx_pcsl_number_9 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    stat_tx_bad_fcs : OUT STD_LOGIC;
    stat_tx_broadcast : OUT STD_LOGIC;
    stat_tx_frame_error : OUT STD_LOGIC;
    stat_tx_local_fault : OUT STD_LOGIC;
    stat_tx_multicast : OUT STD_LOGIC;
    stat_tx_packet_1024_1518_bytes : OUT STD_LOGIC;
    stat_tx_packet_128_255_bytes : OUT STD_LOGIC;
    stat_tx_packet_1519_1522_bytes : OUT STD_LOGIC;
    stat_tx_packet_1523_1548_bytes : OUT STD_LOGIC;
    stat_tx_packet_1549_2047_bytes : OUT STD_LOGIC;
    stat_tx_packet_2048_4095_bytes : OUT STD_LOGIC;
    stat_tx_packet_256_511_bytes : OUT STD_LOGIC;
    stat_tx_packet_4096_8191_bytes : OUT STD_LOGIC;
    stat_tx_packet_512_1023_bytes : OUT STD_LOGIC;
    stat_tx_packet_64_bytes : OUT STD_LOGIC;
    stat_tx_packet_65_127_bytes : OUT STD_LOGIC;
    stat_tx_packet_8192_9215_bytes : OUT STD_LOGIC;
    stat_tx_packet_large : OUT STD_LOGIC;
    stat_tx_packet_small : OUT STD_LOGIC;
    stat_tx_total_bytes : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
    stat_tx_total_good_bytes : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
    stat_tx_total_good_packets : OUT STD_LOGIC;
    stat_tx_total_packets : OUT STD_LOGIC;
    stat_tx_unicast : OUT STD_LOGIC;
    stat_tx_vlan : OUT STD_LOGIC;
    ctl_tx_enable : IN STD_LOGIC;
    ctl_tx_send_idle : IN STD_LOGIC;
    ctl_tx_send_rfi : IN STD_LOGIC;
    ctl_tx_send_lfi : IN STD_LOGIC;
    ctl_tx_test_pattern : IN STD_LOGIC;
    tx_clk : IN STD_LOGIC;
    stat_tx_pause_valid : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
    stat_tx_pause : OUT STD_LOGIC;
    stat_tx_user_pause : OUT STD_LOGIC;
    ctl_tx_pause_enable : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    ctl_tx_pause_quanta0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta4 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta5 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta6 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta7 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_quanta8 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer1 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer2 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer3 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer4 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer5 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer6 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer7 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_refresh_timer8 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    ctl_tx_pause_req : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    ctl_tx_resend_pause : IN STD_LOGIC;
    tx_ovfout : OUT STD_LOGIC;
    tx_rdyout : OUT STD_LOGIC;
    tx_unfout : OUT STD_LOGIC;
    tx_datain0 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    tx_datain1 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    tx_datain2 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    tx_datain3 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    tx_enain0 : IN STD_LOGIC;
    tx_enain1 : IN STD_LOGIC;
    tx_enain2 : IN STD_LOGIC;
    tx_enain3 : IN STD_LOGIC;
    tx_eopin0 : IN STD_LOGIC;
    tx_eopin1 : IN STD_LOGIC;
    tx_eopin2 : IN STD_LOGIC;
    tx_eopin3 : IN STD_LOGIC;
    tx_errin0 : IN STD_LOGIC;
    tx_errin1 : IN STD_LOGIC;
    tx_errin2 : IN STD_LOGIC;
    tx_errin3 : IN STD_LOGIC;
    tx_mtyin0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    tx_mtyin1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    tx_mtyin2 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    tx_mtyin3 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    tx_sopin0 : IN STD_LOGIC;
    tx_sopin1 : IN STD_LOGIC;
    tx_sopin2 : IN STD_LOGIC;
    tx_sopin3 : IN STD_LOGIC;
    tx_preamblein : IN STD_LOGIC_VECTOR(55 DOWNTO 0);
    tx_reset_done : IN STD_LOGIC;
    rx_reset_done : IN STD_LOGIC;
    rx_serdes_reset_done : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    rx_serdes_clk_in : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    drp_clk : IN STD_LOGIC;
    drp_addr : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    drp_di : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    drp_en : IN STD_LOGIC;
    drp_do : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    drp_rdy : OUT STD_LOGIC;
    drp_we : IN STD_LOGIC
  );
END COMPONENT;
-- COMP_TAG_END ------ End COMPONENT Declaration ------------

-- The following code must appear in the VHDL architecture
-- body. Substitute your own instance name and net names.

------------- Begin Cut here for INSTANTIATION Template ----- INST_TAG
your_instance_name : cmac_usplus_0
  PORT MAP (
    txdata_in => txdata_in,
    txctrl0_in => txctrl0_in,
    txctrl1_in => txctrl1_in,
    rxdata_out => rxdata_out,
    rxctrl0_out => rxctrl0_out,
    rxctrl1_out => rxctrl1_out,
    ctl_tx_rsfec_enable => ctl_tx_rsfec_enable,
    ctl_rx_rsfec_enable => ctl_rx_rsfec_enable,
    ctl_rsfec_ieee_error_indication_mode => ctl_rsfec_ieee_error_indication_mode,
    ctl_rx_rsfec_enable_correction => ctl_rx_rsfec_enable_correction,
    ctl_rx_rsfec_enable_indication => ctl_rx_rsfec_enable_indication,
    stat_rx_rsfec_am_lock0 => stat_rx_rsfec_am_lock0,
    stat_rx_rsfec_am_lock1 => stat_rx_rsfec_am_lock1,
    stat_rx_rsfec_am_lock2 => stat_rx_rsfec_am_lock2,
    stat_rx_rsfec_am_lock3 => stat_rx_rsfec_am_lock3,
    stat_rx_rsfec_corrected_cw_inc => stat_rx_rsfec_corrected_cw_inc,
    stat_rx_rsfec_cw_inc => stat_rx_rsfec_cw_inc,
    stat_rx_rsfec_err_count0_inc => stat_rx_rsfec_err_count0_inc,
    stat_rx_rsfec_err_count1_inc => stat_rx_rsfec_err_count1_inc,
    stat_rx_rsfec_err_count2_inc => stat_rx_rsfec_err_count2_inc,
    stat_rx_rsfec_err_count3_inc => stat_rx_rsfec_err_count3_inc,
    stat_rx_rsfec_hi_ser => stat_rx_rsfec_hi_ser,
    stat_rx_rsfec_lane_alignment_status => stat_rx_rsfec_lane_alignment_status,
    stat_rx_rsfec_lane_fill_0 => stat_rx_rsfec_lane_fill_0,
    stat_rx_rsfec_lane_fill_1 => stat_rx_rsfec_lane_fill_1,
    stat_rx_rsfec_lane_fill_2 => stat_rx_rsfec_lane_fill_2,
    stat_rx_rsfec_lane_fill_3 => stat_rx_rsfec_lane_fill_3,
    stat_rx_rsfec_lane_mapping => stat_rx_rsfec_lane_mapping,
    stat_rx_rsfec_uncorrected_cw_inc => stat_rx_rsfec_uncorrected_cw_inc,
    rx_dataout0 => rx_dataout0,
    rx_dataout1 => rx_dataout1,
    rx_dataout2 => rx_dataout2,
    rx_dataout3 => rx_dataout3,
    rx_enaout0 => rx_enaout0,
    rx_enaout1 => rx_enaout1,
    rx_enaout2 => rx_enaout2,
    rx_enaout3 => rx_enaout3,
    rx_eopout0 => rx_eopout0,
    rx_eopout1 => rx_eopout1,
    rx_eopout2 => rx_eopout2,
    rx_eopout3 => rx_eopout3,
    rx_errout0 => rx_errout0,
    rx_errout1 => rx_errout1,
    rx_errout2 => rx_errout2,
    rx_errout3 => rx_errout3,
    rx_mtyout0 => rx_mtyout0,
    rx_mtyout1 => rx_mtyout1,
    rx_mtyout2 => rx_mtyout2,
    rx_mtyout3 => rx_mtyout3,
    rx_sopout0 => rx_sopout0,
    rx_sopout1 => rx_sopout1,
    rx_sopout2 => rx_sopout2,
    rx_sopout3 => rx_sopout3,
    rx_otn_bip8_0 => rx_otn_bip8_0,
    rx_otn_bip8_1 => rx_otn_bip8_1,
    rx_otn_bip8_2 => rx_otn_bip8_2,
    rx_otn_bip8_3 => rx_otn_bip8_3,
    rx_otn_bip8_4 => rx_otn_bip8_4,
    rx_otn_data_0 => rx_otn_data_0,
    rx_otn_data_1 => rx_otn_data_1,
    rx_otn_data_2 => rx_otn_data_2,
    rx_otn_data_3 => rx_otn_data_3,
    rx_otn_data_4 => rx_otn_data_4,
    rx_otn_ena => rx_otn_ena,
    rx_otn_lane0 => rx_otn_lane0,
    rx_otn_vlmarker => rx_otn_vlmarker,
    rx_preambleout => rx_preambleout,
    stat_rx_aligned => stat_rx_aligned,
    stat_rx_aligned_err => stat_rx_aligned_err,
    stat_rx_bad_code => stat_rx_bad_code,
    stat_rx_bad_fcs => stat_rx_bad_fcs,
    stat_rx_bad_preamble => stat_rx_bad_preamble,
    stat_rx_bad_sfd => stat_rx_bad_sfd,
    stat_rx_bip_err_0 => stat_rx_bip_err_0,
    stat_rx_bip_err_1 => stat_rx_bip_err_1,
    stat_rx_bip_err_10 => stat_rx_bip_err_10,
    stat_rx_bip_err_11 => stat_rx_bip_err_11,
    stat_rx_bip_err_12 => stat_rx_bip_err_12,
    stat_rx_bip_err_13 => stat_rx_bip_err_13,
    stat_rx_bip_err_14 => stat_rx_bip_err_14,
    stat_rx_bip_err_15 => stat_rx_bip_err_15,
    stat_rx_bip_err_16 => stat_rx_bip_err_16,
    stat_rx_bip_err_17 => stat_rx_bip_err_17,
    stat_rx_bip_err_18 => stat_rx_bip_err_18,
    stat_rx_bip_err_19 => stat_rx_bip_err_19,
    stat_rx_bip_err_2 => stat_rx_bip_err_2,
    stat_rx_bip_err_3 => stat_rx_bip_err_3,
    stat_rx_bip_err_4 => stat_rx_bip_err_4,
    stat_rx_bip_err_5 => stat_rx_bip_err_5,
    stat_rx_bip_err_6 => stat_rx_bip_err_6,
    stat_rx_bip_err_7 => stat_rx_bip_err_7,
    stat_rx_bip_err_8 => stat_rx_bip_err_8,
    stat_rx_bip_err_9 => stat_rx_bip_err_9,
    stat_rx_block_lock => stat_rx_block_lock,
    stat_rx_broadcast => stat_rx_broadcast,
    stat_rx_fragment => stat_rx_fragment,
    stat_rx_framing_err_0 => stat_rx_framing_err_0,
    stat_rx_framing_err_1 => stat_rx_framing_err_1,
    stat_rx_framing_err_10 => stat_rx_framing_err_10,
    stat_rx_framing_err_11 => stat_rx_framing_err_11,
    stat_rx_framing_err_12 => stat_rx_framing_err_12,
    stat_rx_framing_err_13 => stat_rx_framing_err_13,
    stat_rx_framing_err_14 => stat_rx_framing_err_14,
    stat_rx_framing_err_15 => stat_rx_framing_err_15,
    stat_rx_framing_err_16 => stat_rx_framing_err_16,
    stat_rx_framing_err_17 => stat_rx_framing_err_17,
    stat_rx_framing_err_18 => stat_rx_framing_err_18,
    stat_rx_framing_err_19 => stat_rx_framing_err_19,
    stat_rx_framing_err_2 => stat_rx_framing_err_2,
    stat_rx_framing_err_3 => stat_rx_framing_err_3,
    stat_rx_framing_err_4 => stat_rx_framing_err_4,
    stat_rx_framing_err_5 => stat_rx_framing_err_5,
    stat_rx_framing_err_6 => stat_rx_framing_err_6,
    stat_rx_framing_err_7 => stat_rx_framing_err_7,
    stat_rx_framing_err_8 => stat_rx_framing_err_8,
    stat_rx_framing_err_9 => stat_rx_framing_err_9,
    stat_rx_framing_err_valid_0 => stat_rx_framing_err_valid_0,
    stat_rx_framing_err_valid_1 => stat_rx_framing_err_valid_1,
    stat_rx_framing_err_valid_10 => stat_rx_framing_err_valid_10,
    stat_rx_framing_err_valid_11 => stat_rx_framing_err_valid_11,
    stat_rx_framing_err_valid_12 => stat_rx_framing_err_valid_12,
    stat_rx_framing_err_valid_13 => stat_rx_framing_err_valid_13,
    stat_rx_framing_err_valid_14 => stat_rx_framing_err_valid_14,
    stat_rx_framing_err_valid_15 => stat_rx_framing_err_valid_15,
    stat_rx_framing_err_valid_16 => stat_rx_framing_err_valid_16,
    stat_rx_framing_err_valid_17 => stat_rx_framing_err_valid_17,
    stat_rx_framing_err_valid_18 => stat_rx_framing_err_valid_18,
    stat_rx_framing_err_valid_19 => stat_rx_framing_err_valid_19,
    stat_rx_framing_err_valid_2 => stat_rx_framing_err_valid_2,
    stat_rx_framing_err_valid_3 => stat_rx_framing_err_valid_3,
    stat_rx_framing_err_valid_4 => stat_rx_framing_err_valid_4,
    stat_rx_framing_err_valid_5 => stat_rx_framing_err_valid_5,
    stat_rx_framing_err_valid_6 => stat_rx_framing_err_valid_6,
    stat_rx_framing_err_valid_7 => stat_rx_framing_err_valid_7,
    stat_rx_framing_err_valid_8 => stat_rx_framing_err_valid_8,
    stat_rx_framing_err_valid_9 => stat_rx_framing_err_valid_9,
    stat_rx_got_signal_os => stat_rx_got_signal_os,
    stat_rx_hi_ber => stat_rx_hi_ber,
    stat_rx_inrangeerr => stat_rx_inrangeerr,
    stat_rx_internal_local_fault => stat_rx_internal_local_fault,
    stat_rx_jabber => stat_rx_jabber,
    stat_rx_local_fault => stat_rx_local_fault,
    stat_rx_mf_err => stat_rx_mf_err,
    stat_rx_mf_len_err => stat_rx_mf_len_err,
    stat_rx_mf_repeat_err => stat_rx_mf_repeat_err,
    stat_rx_misaligned => stat_rx_misaligned,
    stat_rx_multicast => stat_rx_multicast,
    stat_rx_oversize => stat_rx_oversize,
    stat_rx_packet_1024_1518_bytes => stat_rx_packet_1024_1518_bytes,
    stat_rx_packet_128_255_bytes => stat_rx_packet_128_255_bytes,
    stat_rx_packet_1519_1522_bytes => stat_rx_packet_1519_1522_bytes,
    stat_rx_packet_1523_1548_bytes => stat_rx_packet_1523_1548_bytes,
    stat_rx_packet_1549_2047_bytes => stat_rx_packet_1549_2047_bytes,
    stat_rx_packet_2048_4095_bytes => stat_rx_packet_2048_4095_bytes,
    stat_rx_packet_256_511_bytes => stat_rx_packet_256_511_bytes,
    stat_rx_packet_4096_8191_bytes => stat_rx_packet_4096_8191_bytes,
    stat_rx_packet_512_1023_bytes => stat_rx_packet_512_1023_bytes,
    stat_rx_packet_64_bytes => stat_rx_packet_64_bytes,
    stat_rx_packet_65_127_bytes => stat_rx_packet_65_127_bytes,
    stat_rx_packet_8192_9215_bytes => stat_rx_packet_8192_9215_bytes,
    stat_rx_packet_bad_fcs => stat_rx_packet_bad_fcs,
    stat_rx_packet_large => stat_rx_packet_large,
    stat_rx_packet_small => stat_rx_packet_small,
    stat_rx_pause => stat_rx_pause,
    stat_rx_pause_quanta0 => stat_rx_pause_quanta0,
    stat_rx_pause_quanta1 => stat_rx_pause_quanta1,
    stat_rx_pause_quanta2 => stat_rx_pause_quanta2,
    stat_rx_pause_quanta3 => stat_rx_pause_quanta3,
    stat_rx_pause_quanta4 => stat_rx_pause_quanta4,
    stat_rx_pause_quanta5 => stat_rx_pause_quanta5,
    stat_rx_pause_quanta6 => stat_rx_pause_quanta6,
    stat_rx_pause_quanta7 => stat_rx_pause_quanta7,
    stat_rx_pause_quanta8 => stat_rx_pause_quanta8,
    stat_rx_pause_req => stat_rx_pause_req,
    stat_rx_pause_valid => stat_rx_pause_valid,
    stat_rx_user_pause => stat_rx_user_pause,
    ctl_rx_check_etype_gcp => ctl_rx_check_etype_gcp,
    ctl_rx_check_etype_gpp => ctl_rx_check_etype_gpp,
    ctl_rx_check_etype_pcp => ctl_rx_check_etype_pcp,
    ctl_rx_check_etype_ppp => ctl_rx_check_etype_ppp,
    ctl_rx_check_mcast_gcp => ctl_rx_check_mcast_gcp,
    ctl_rx_check_mcast_gpp => ctl_rx_check_mcast_gpp,
    ctl_rx_check_mcast_pcp => ctl_rx_check_mcast_pcp,
    ctl_rx_check_mcast_ppp => ctl_rx_check_mcast_ppp,
    ctl_rx_check_opcode_gcp => ctl_rx_check_opcode_gcp,
    ctl_rx_check_opcode_gpp => ctl_rx_check_opcode_gpp,
    ctl_rx_check_opcode_pcp => ctl_rx_check_opcode_pcp,
    ctl_rx_check_opcode_ppp => ctl_rx_check_opcode_ppp,
    ctl_rx_check_sa_gcp => ctl_rx_check_sa_gcp,
    ctl_rx_check_sa_gpp => ctl_rx_check_sa_gpp,
    ctl_rx_check_sa_pcp => ctl_rx_check_sa_pcp,
    ctl_rx_check_sa_ppp => ctl_rx_check_sa_ppp,
    ctl_rx_check_ucast_gcp => ctl_rx_check_ucast_gcp,
    ctl_rx_check_ucast_gpp => ctl_rx_check_ucast_gpp,
    ctl_rx_check_ucast_pcp => ctl_rx_check_ucast_pcp,
    ctl_rx_check_ucast_ppp => ctl_rx_check_ucast_ppp,
    ctl_rx_enable_gcp => ctl_rx_enable_gcp,
    ctl_rx_enable_gpp => ctl_rx_enable_gpp,
    ctl_rx_enable_pcp => ctl_rx_enable_pcp,
    ctl_rx_enable_ppp => ctl_rx_enable_ppp,
    ctl_rx_pause_ack => ctl_rx_pause_ack,
    ctl_rx_pause_enable => ctl_rx_pause_enable,
    ctl_rx_enable => ctl_rx_enable,
    ctl_rx_force_resync => ctl_rx_force_resync,
    ctl_rx_test_pattern => ctl_rx_test_pattern,
    rx_clk => rx_clk,
    stat_rx_received_local_fault => stat_rx_received_local_fault,
    stat_rx_remote_fault => stat_rx_remote_fault,
    stat_rx_status => stat_rx_status,
    stat_rx_stomped_fcs => stat_rx_stomped_fcs,
    stat_rx_synced => stat_rx_synced,
    stat_rx_synced_err => stat_rx_synced_err,
    stat_rx_test_pattern_mismatch => stat_rx_test_pattern_mismatch,
    stat_rx_toolong => stat_rx_toolong,
    stat_rx_total_bytes => stat_rx_total_bytes,
    stat_rx_total_good_bytes => stat_rx_total_good_bytes,
    stat_rx_total_good_packets => stat_rx_total_good_packets,
    stat_rx_total_packets => stat_rx_total_packets,
    stat_rx_truncated => stat_rx_truncated,
    stat_rx_undersize => stat_rx_undersize,
    stat_rx_unicast => stat_rx_unicast,
    stat_rx_vlan => stat_rx_vlan,
    stat_rx_pcsl_demuxed => stat_rx_pcsl_demuxed,
    stat_rx_pcsl_number_0 => stat_rx_pcsl_number_0,
    stat_rx_pcsl_number_1 => stat_rx_pcsl_number_1,
    stat_rx_pcsl_number_10 => stat_rx_pcsl_number_10,
    stat_rx_pcsl_number_11 => stat_rx_pcsl_number_11,
    stat_rx_pcsl_number_12 => stat_rx_pcsl_number_12,
    stat_rx_pcsl_number_13 => stat_rx_pcsl_number_13,
    stat_rx_pcsl_number_14 => stat_rx_pcsl_number_14,
    stat_rx_pcsl_number_15 => stat_rx_pcsl_number_15,
    stat_rx_pcsl_number_16 => stat_rx_pcsl_number_16,
    stat_rx_pcsl_number_17 => stat_rx_pcsl_number_17,
    stat_rx_pcsl_number_18 => stat_rx_pcsl_number_18,
    stat_rx_pcsl_number_19 => stat_rx_pcsl_number_19,
    stat_rx_pcsl_number_2 => stat_rx_pcsl_number_2,
    stat_rx_pcsl_number_3 => stat_rx_pcsl_number_3,
    stat_rx_pcsl_number_4 => stat_rx_pcsl_number_4,
    stat_rx_pcsl_number_5 => stat_rx_pcsl_number_5,
    stat_rx_pcsl_number_6 => stat_rx_pcsl_number_6,
    stat_rx_pcsl_number_7 => stat_rx_pcsl_number_7,
    stat_rx_pcsl_number_8 => stat_rx_pcsl_number_8,
    stat_rx_pcsl_number_9 => stat_rx_pcsl_number_9,
    stat_tx_bad_fcs => stat_tx_bad_fcs,
    stat_tx_broadcast => stat_tx_broadcast,
    stat_tx_frame_error => stat_tx_frame_error,
    stat_tx_local_fault => stat_tx_local_fault,
    stat_tx_multicast => stat_tx_multicast,
    stat_tx_packet_1024_1518_bytes => stat_tx_packet_1024_1518_bytes,
    stat_tx_packet_128_255_bytes => stat_tx_packet_128_255_bytes,
    stat_tx_packet_1519_1522_bytes => stat_tx_packet_1519_1522_bytes,
    stat_tx_packet_1523_1548_bytes => stat_tx_packet_1523_1548_bytes,
    stat_tx_packet_1549_2047_bytes => stat_tx_packet_1549_2047_bytes,
    stat_tx_packet_2048_4095_bytes => stat_tx_packet_2048_4095_bytes,
    stat_tx_packet_256_511_bytes => stat_tx_packet_256_511_bytes,
    stat_tx_packet_4096_8191_bytes => stat_tx_packet_4096_8191_bytes,
    stat_tx_packet_512_1023_bytes => stat_tx_packet_512_1023_bytes,
    stat_tx_packet_64_bytes => stat_tx_packet_64_bytes,
    stat_tx_packet_65_127_bytes => stat_tx_packet_65_127_bytes,
    stat_tx_packet_8192_9215_bytes => stat_tx_packet_8192_9215_bytes,
    stat_tx_packet_large => stat_tx_packet_large,
    stat_tx_packet_small => stat_tx_packet_small,
    stat_tx_total_bytes => stat_tx_total_bytes,
    stat_tx_total_good_bytes => stat_tx_total_good_bytes,
    stat_tx_total_good_packets => stat_tx_total_good_packets,
    stat_tx_total_packets => stat_tx_total_packets,
    stat_tx_unicast => stat_tx_unicast,
    stat_tx_vlan => stat_tx_vlan,
    ctl_tx_enable => ctl_tx_enable,
    ctl_tx_send_idle => ctl_tx_send_idle,
    ctl_tx_send_rfi => ctl_tx_send_rfi,
    ctl_tx_send_lfi => ctl_tx_send_lfi,
    ctl_tx_test_pattern => ctl_tx_test_pattern,
    tx_clk => tx_clk,
    stat_tx_pause_valid => stat_tx_pause_valid,
    stat_tx_pause => stat_tx_pause,
    stat_tx_user_pause => stat_tx_user_pause,
    ctl_tx_pause_enable => ctl_tx_pause_enable,
    ctl_tx_pause_quanta0 => ctl_tx_pause_quanta0,
    ctl_tx_pause_quanta1 => ctl_tx_pause_quanta1,
    ctl_tx_pause_quanta2 => ctl_tx_pause_quanta2,
    ctl_tx_pause_quanta3 => ctl_tx_pause_quanta3,
    ctl_tx_pause_quanta4 => ctl_tx_pause_quanta4,
    ctl_tx_pause_quanta5 => ctl_tx_pause_quanta5,
    ctl_tx_pause_quanta6 => ctl_tx_pause_quanta6,
    ctl_tx_pause_quanta7 => ctl_tx_pause_quanta7,
    ctl_tx_pause_quanta8 => ctl_tx_pause_quanta8,
    ctl_tx_pause_refresh_timer0 => ctl_tx_pause_refresh_timer0,
    ctl_tx_pause_refresh_timer1 => ctl_tx_pause_refresh_timer1,
    ctl_tx_pause_refresh_timer2 => ctl_tx_pause_refresh_timer2,
    ctl_tx_pause_refresh_timer3 => ctl_tx_pause_refresh_timer3,
    ctl_tx_pause_refresh_timer4 => ctl_tx_pause_refresh_timer4,
    ctl_tx_pause_refresh_timer5 => ctl_tx_pause_refresh_timer5,
    ctl_tx_pause_refresh_timer6 => ctl_tx_pause_refresh_timer6,
    ctl_tx_pause_refresh_timer7 => ctl_tx_pause_refresh_timer7,
    ctl_tx_pause_refresh_timer8 => ctl_tx_pause_refresh_timer8,
    ctl_tx_pause_req => ctl_tx_pause_req,
    ctl_tx_resend_pause => ctl_tx_resend_pause,
    tx_ovfout => tx_ovfout,
    tx_rdyout => tx_rdyout,
    tx_unfout => tx_unfout,
    tx_datain0 => tx_datain0,
    tx_datain1 => tx_datain1,
    tx_datain2 => tx_datain2,
    tx_datain3 => tx_datain3,
    tx_enain0 => tx_enain0,
    tx_enain1 => tx_enain1,
    tx_enain2 => tx_enain2,
    tx_enain3 => tx_enain3,
    tx_eopin0 => tx_eopin0,
    tx_eopin1 => tx_eopin1,
    tx_eopin2 => tx_eopin2,
    tx_eopin3 => tx_eopin3,
    tx_errin0 => tx_errin0,
    tx_errin1 => tx_errin1,
    tx_errin2 => tx_errin2,
    tx_errin3 => tx_errin3,
    tx_mtyin0 => tx_mtyin0,
    tx_mtyin1 => tx_mtyin1,
    tx_mtyin2 => tx_mtyin2,
    tx_mtyin3 => tx_mtyin3,
    tx_sopin0 => tx_sopin0,
    tx_sopin1 => tx_sopin1,
    tx_sopin2 => tx_sopin2,
    tx_sopin3 => tx_sopin3,
    tx_preamblein => tx_preamblein,
    tx_reset_done => tx_reset_done,
    rx_reset_done => rx_reset_done,
    rx_serdes_reset_done => rx_serdes_reset_done,
    rx_serdes_clk_in => rx_serdes_clk_in,
    drp_clk => drp_clk,
    drp_addr => drp_addr,
    drp_di => drp_di,
    drp_en => drp_en,
    drp_do => drp_do,
    drp_rdy => drp_rdy,
    drp_we => drp_we
  );
-- INST_TAG_END ------ End INSTANTIATION Template ---------

-- You must compile the wrapper file cmac_usplus_0.vhd when simulating
-- the core, cmac_usplus_0. When compiling the wrapper file, be sure to
-- reference the VHDL simulation library.

