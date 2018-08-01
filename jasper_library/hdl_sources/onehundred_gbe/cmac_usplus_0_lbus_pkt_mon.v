 
 
////------------------------------------------------------------------------------
////  (c) Copyright 2013 Xilinx, Inc. All rights reserved.
////
////  This file contains confidential and proprietary information
////  of Xilinx, Inc. and is protected under U.S. and
////  international copyright and other intellectual property
////  laws.
////
////  DISCLAIMER
////  This disclaimer is not a license and does not grant any
////  rights to the materials distributed herewith. Except as
////  otherwise provided in a valid license issued to you by
////  Xilinx, and to the maximum extent permitted by applicable
////  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
////  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
////  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
////  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
////  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
////  (2) Xilinx shall not be liable (whether in contract or tort,
////  including negligence, or under any other theory of
////  liability) for any loss or damage of any kind or nature
////  related to, arising under or in connection with these
////  materials, including for any direct, or any indirect,
////  special, incidental, or consequential loss or damage
////  (including loss of data, profits, goodwill, or any type of
////  loss or damage suffered as a result of any action brought
////  by a third party) even if such damage or loss was
////  reasonably foreseeable or Xilinx had been advised of the
////  possibility of the same.
////
////  CRITICAL APPLICATIONS
////  Xilinx products are not designed or intended to be fail-
////  safe, or for use in any application requiring fail-safe
////  performance, such as life-support or safety devices or
////  systems, Class III medical devices, nuclear facilities,
////  applications related to the deployment of airbags, or any
////  other applications that could lead to death, personal
////  injury, or severe property or environmental damage
////  (individually and collectively, "Critical
////  Applications"). Customer assumes the sole risk and
////  liability of any use of Xilinx products in Critical
////  Applications, subject only to applicable laws and
////  regulations governing limitations on product liability.
////
////  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
////  PART OF THIS FILE AT ALL TIMES.
////------------------------------------------------------------------------------

`timescale 1ps/1ps
(* DowngradeIPIdentifiedWarnings="yes" *)

module cmac_usplus_0_lbus_pkt_mon
   #(
    parameter PKT_NUM      = 1000     //// 1 to 65535 (Number of packets)
   )
   (
    input  wire            clk,
    input  wire            reset,
    input  wire            sys_reset,

    input  wire            send_continuous_pkts,
    input  wire            stat_rx_aligned,
    input  wire            lbus_tx_rx_restart_in,
    output wire            ctl_rx_enable,
    output wire            ctl_rx_force_resync,
    output wire            ctl_rx_test_pattern,
    output wire            ctl_rsfec_ieee_error_indication_mode,
    output wire            ctl_rx_rsfec_enable,
    output wire            ctl_rx_rsfec_enable_correction,
    output wire            ctl_rx_rsfec_enable_indication,
    output wire            rx_reset,                                       //// Used to Reset the CMAC RX Core
    output reg             rx_gt_locked_led,
    output reg             rx_aligned_led,
    output reg             rx_done_led,
    output reg             rx_data_fail_led,
    output reg             rx_busy_led,
    output wire [8:0]      ctl_rx_pause_enable,
    output wire            ctl_rx_enable_gcp, 
    output wire            ctl_rx_check_mcast_gcp,
    output wire            ctl_rx_check_ucast_gcp,
    output wire            ctl_rx_check_sa_gcp,
    output wire            ctl_rx_check_etype_gcp,
    output wire            ctl_rx_check_opcode_gcp,
    output wire            ctl_rx_enable_pcp,
    output wire            ctl_rx_check_mcast_pcp,
    output wire            ctl_rx_check_ucast_pcp,
    output wire            ctl_rx_check_sa_pcp,
    output wire            ctl_rx_check_etype_pcp,
    output wire            ctl_rx_check_opcode_pcp,
    output wire            ctl_rx_enable_gpp,
    output wire            ctl_rx_check_mcast_gpp,
    output wire            ctl_rx_check_ucast_gpp,
    output wire            ctl_rx_check_sa_gpp,
    output wire            ctl_rx_check_etype_gpp,
    output wire            ctl_rx_check_opcode_gpp,
    output wire            ctl_rx_enable_ppp,
    output wire            ctl_rx_check_mcast_ppp,
    output wire            ctl_rx_check_ucast_ppp,
    output wire            ctl_rx_check_sa_ppp,
    output wire            ctl_rx_check_etype_ppp,
    output wire            ctl_rx_check_opcode_ppp,
    output wire [8:0]      ctl_rx_pause_ack,
    input  wire            stat_rx_pause,
    input  wire            stat_rx_user_pause,
    input  wire [8:0]      stat_rx_pause_req,
    input  wire [8:0]      stat_rx_pause_valid,
    input  wire [15:0]     stat_rx_pause_quanta0,
    input  wire [15:0]     stat_rx_pause_quanta1,
    input  wire [15:0]     stat_rx_pause_quanta2,
    input  wire [15:0]     stat_rx_pause_quanta3,
    input  wire [15:0]     stat_rx_pause_quanta4,
    input  wire [15:0]     stat_rx_pause_quanta5,
    input  wire [15:0]     stat_rx_pause_quanta6,
    input  wire [15:0]     stat_rx_pause_quanta7,
    input  wire [15:0]     stat_rx_pause_quanta8,
    input  wire            stat_rx_aligned_err,
    input  wire [2:0]      stat_rx_bad_code,
    input  wire [2:0]      stat_rx_bad_fcs,
    input  wire            stat_rx_bad_preamble,
    input  wire            stat_rx_bad_sfd,
    input  wire            stat_rx_bip_err_0,
    input  wire            stat_rx_bip_err_1,
    input  wire            stat_rx_bip_err_10,
    input  wire            stat_rx_bip_err_11,
    input  wire            stat_rx_bip_err_12,
    input  wire            stat_rx_bip_err_13,
    input  wire            stat_rx_bip_err_14,
    input  wire            stat_rx_bip_err_15,
    input  wire            stat_rx_bip_err_16,
    input  wire            stat_rx_bip_err_17,
    input  wire            stat_rx_bip_err_18,
    input  wire            stat_rx_bip_err_19,
    input  wire            stat_rx_bip_err_2,
    input  wire            stat_rx_bip_err_3,
    input  wire            stat_rx_bip_err_4,
    input  wire            stat_rx_bip_err_5,
    input  wire            stat_rx_bip_err_6,
    input  wire            stat_rx_bip_err_7,
    input  wire            stat_rx_bip_err_8,
    input  wire            stat_rx_bip_err_9,
    input  wire [19:0]     stat_rx_block_lock,
    input  wire            stat_rx_broadcast,
    input  wire [2:0]      stat_rx_fragment,
    input  wire [1:0]      stat_rx_framing_err_0,
    input  wire [1:0]      stat_rx_framing_err_1,
    input  wire [1:0]      stat_rx_framing_err_10,
    input  wire [1:0]      stat_rx_framing_err_11,
    input  wire [1:0]      stat_rx_framing_err_12,
    input  wire [1:0]      stat_rx_framing_err_13,
    input  wire [1:0]      stat_rx_framing_err_14,
    input  wire [1:0]      stat_rx_framing_err_15,
    input  wire [1:0]      stat_rx_framing_err_16,
    input  wire [1:0]      stat_rx_framing_err_17,
    input  wire [1:0]      stat_rx_framing_err_18,
    input  wire [1:0]      stat_rx_framing_err_19,
    input  wire [1:0]      stat_rx_framing_err_2,
    input  wire [1:0]      stat_rx_framing_err_3,
    input  wire [1:0]      stat_rx_framing_err_4,
    input  wire [1:0]      stat_rx_framing_err_5,
    input  wire [1:0]      stat_rx_framing_err_6,
    input  wire [1:0]      stat_rx_framing_err_7,
    input  wire [1:0]      stat_rx_framing_err_8,
    input  wire [1:0]      stat_rx_framing_err_9,
    input  wire            stat_rx_framing_err_valid_0,
    input  wire            stat_rx_framing_err_valid_1,
    input  wire            stat_rx_framing_err_valid_10,
    input  wire            stat_rx_framing_err_valid_11,
    input  wire            stat_rx_framing_err_valid_12,
    input  wire            stat_rx_framing_err_valid_13,
    input  wire            stat_rx_framing_err_valid_14,
    input  wire            stat_rx_framing_err_valid_15,
    input  wire            stat_rx_framing_err_valid_16,
    input  wire            stat_rx_framing_err_valid_17,
    input  wire            stat_rx_framing_err_valid_18,
    input  wire            stat_rx_framing_err_valid_19,
    input  wire            stat_rx_framing_err_valid_2,
    input  wire            stat_rx_framing_err_valid_3,
    input  wire            stat_rx_framing_err_valid_4,
    input  wire            stat_rx_framing_err_valid_5,
    input  wire            stat_rx_framing_err_valid_6,
    input  wire            stat_rx_framing_err_valid_7,
    input  wire            stat_rx_framing_err_valid_8,
    input  wire            stat_rx_framing_err_valid_9,
    input  wire            stat_rx_got_signal_os,
    input  wire            stat_rx_hi_ber,
    input  wire            stat_rx_inrangeerr,
    input  wire            stat_rx_internal_local_fault,
    input  wire            stat_rx_jabber,
    input  wire            stat_rx_local_fault,
    input  wire [19:0]     stat_rx_mf_err,
    input  wire [19:0]     stat_rx_mf_len_err,
    input  wire [19:0]     stat_rx_mf_repeat_err,
    input  wire            stat_rx_misaligned,
    input  wire            stat_rx_multicast,
    input  wire            stat_rx_oversize,
    input  wire            stat_rx_packet_1024_1518_bytes,
    input  wire            stat_rx_packet_128_255_bytes,
    input  wire            stat_rx_packet_1519_1522_bytes,
    input  wire            stat_rx_packet_1523_1548_bytes,
    input  wire            stat_rx_packet_1549_2047_bytes,
    input  wire            stat_rx_packet_2048_4095_bytes,
    input  wire            stat_rx_packet_256_511_bytes,
    input  wire            stat_rx_packet_4096_8191_bytes,
    input  wire            stat_rx_packet_512_1023_bytes,
    input  wire            stat_rx_packet_64_bytes,
    input  wire            stat_rx_packet_65_127_bytes,
    input  wire            stat_rx_packet_8192_9215_bytes,
    input  wire            stat_rx_packet_bad_fcs,
    input  wire            stat_rx_packet_large,
    input  wire [2:0]      stat_rx_packet_small,
    input  wire            stat_rx_received_local_fault,
    input  wire            stat_rx_remote_fault,
    input  wire            stat_rx_status,
    input  wire [2:0]      stat_rx_stomped_fcs,
    input  wire [19:0]     stat_rx_synced,
    input  wire [19:0]     stat_rx_synced_err,
    input  wire [2:0]      stat_rx_test_pattern_mismatch,
    input  wire            stat_rx_toolong,
    input  wire [6:0]      stat_rx_total_bytes,
    input  wire [13:0]     stat_rx_total_good_bytes,
    input  wire            stat_rx_total_good_packets,
    input  wire [2:0]      stat_rx_total_packets,
    input  wire            stat_rx_truncated,
    input  wire [2:0]      stat_rx_undersize,
    input  wire            stat_rx_unicast,
    input  wire            stat_rx_vlan,
    input  wire [19:0]     stat_rx_pcsl_demuxed,
    input  wire [4:0]      stat_rx_pcsl_number_0,
    input  wire [4:0]      stat_rx_pcsl_number_1,
    input  wire [4:0]      stat_rx_pcsl_number_10,
    input  wire [4:0]      stat_rx_pcsl_number_11,
    input  wire [4:0]      stat_rx_pcsl_number_12,
    input  wire [4:0]      stat_rx_pcsl_number_13,
    input  wire [4:0]      stat_rx_pcsl_number_14,
    input  wire [4:0]      stat_rx_pcsl_number_15,
    input  wire [4:0]      stat_rx_pcsl_number_16,
    input  wire [4:0]      stat_rx_pcsl_number_17,
    input  wire [4:0]      stat_rx_pcsl_number_18,
    input  wire [4:0]      stat_rx_pcsl_number_19,
    input  wire [4:0]      stat_rx_pcsl_number_2,
    input  wire [4:0]      stat_rx_pcsl_number_3,
    input  wire [4:0]      stat_rx_pcsl_number_4,
    input  wire [4:0]      stat_rx_pcsl_number_5,
    input  wire [4:0]      stat_rx_pcsl_number_6,
    input  wire [4:0]      stat_rx_pcsl_number_7,
    input  wire [4:0]      stat_rx_pcsl_number_8,
    input  wire [4:0]      stat_rx_pcsl_number_9,
    input  wire            stat_rx_rsfec_am_lock0,
    input  wire            stat_rx_rsfec_am_lock1,
    input  wire            stat_rx_rsfec_am_lock2,
    input  wire            stat_rx_rsfec_am_lock3,
    input  wire            stat_rx_rsfec_corrected_cw_inc,
    input  wire            stat_rx_rsfec_cw_inc,
    input  wire [2:0]      stat_rx_rsfec_err_count0_inc,
    input  wire [2:0]      stat_rx_rsfec_err_count1_inc,
    input  wire [2:0]      stat_rx_rsfec_err_count2_inc,
    input  wire [2:0]      stat_rx_rsfec_err_count3_inc,
    input  wire            stat_rx_rsfec_hi_ser,
    input  wire            stat_rx_rsfec_lane_alignment_status,
    input  wire [13:0]     stat_rx_rsfec_lane_fill_0,
    input  wire [13:0]     stat_rx_rsfec_lane_fill_1,
    input  wire [13:0]     stat_rx_rsfec_lane_fill_2,
    input  wire [13:0]     stat_rx_rsfec_lane_fill_3,
    input  wire [7:0]      stat_rx_rsfec_lane_mapping,
    input  wire            stat_rx_rsfec_uncorrected_cw_inc,

    input  wire [55:0]     rx_preambleout,
    input  wire [128-1:0]  rx_dataout0,
    input  wire            rx_enaout0,
    input  wire            rx_sopout0,
    input  wire            rx_eopout0,
    input  wire            rx_errout0,
    input  wire [4-1:0]    rx_mtyout0,
    input  wire [128-1:0]  rx_dataout1,
    input  wire            rx_enaout1,
    input  wire            rx_sopout1,
    input  wire            rx_eopout1,
    input  wire            rx_errout1,
    input  wire [4-1:0]    rx_mtyout1,
    input  wire [128-1:0]  rx_dataout2,
    input  wire            rx_enaout2,
    input  wire            rx_sopout2,
    input  wire            rx_eopout2,
    input  wire            rx_errout2,
    input  wire [4-1:0]    rx_mtyout2,
    input  wire [128-1:0]  rx_dataout3,
    input  wire            rx_enaout3,
    input  wire            rx_sopout3,
    input  wire            rx_eopout3,
    input  wire            rx_errout3,
    input  wire [4-1:0]    rx_mtyout3
  );

  //// Parameters Decleration

  //// pkt_mon States
    localparam STATE_RX_IDLE             = 0;
    localparam STATE_GT_LOCKED           = 1;
    localparam STATE_WAIT_RX_ALIGNED     = 2;
    localparam STATE_PKT_TRANSFER_INIT   = 3;
    localparam STATE_LBUS_RX_ENABLE      = 4;
    localparam STATE_LBUS_RX_DONE        = 5;
    localparam STATE_WAIT_FOR_RESTART    = 6;

  ////State Registers for RX
    reg  [3:0]     rx_prestate;
    reg  [128-1:0] rcv_datain0, rcv_datain1, rcv_datain2, rcv_datain3, rcv_data, rcv_data_cmp;
    reg  [128-1:0] exp_datain0, exp_datain1, exp_datain2, exp_datain3, exp_data, exp_data_cmp;
    reg  [128-1:0] rx_dataout0_d, rx_dataout1_d, rx_dataout2_d, rx_dataout3_d;
    reg            rx_enaout0_d, rx_enaout1_d, rx_enaout2_d, rx_enaout3_d;
    reg            rx_sopout0_d, rx_sopout1_d, rx_sopout2_d, rx_sopout3_d;
    reg            rx_eopout0_d, rx_eopout1_d, rx_eopout2_d, rx_eopout3_d;
    reg            rx_errout0_d, rx_errout1_d, rx_errout2_d, rx_errout3_d;
    reg  [4-1:0]   rx_mtyout0_d, rx_mtyout1_d, rx_mtyout2_d, rx_mtyout3_d;

    reg            rx_restart_rise_edge, rx_fsm_en, rx_done_reg, rx_data_fail, wait_to_restart;
    reg            rx_restart_1d, rx_restart_2d, rx_restart_3d, rx_restart_4d ;
    reg            check_seg0, check_seg1, check_seg2, check_seg3;
    reg  [4-1:0]   invalid_lsb_bytes;
    reg  [128-1:0] rx_payload_16byte, rx_payload_16byte_new;
    reg  [ 7:0]    rx_payload_1, rx_payload_2, rx_payload_new;
    reg            rx_data0_chk_fail, rx_data1_chk_fail, rx_data2_chk_fail, rx_data3_chk_fail, byte_cmp_fail;
    reg  [15:0]    number_pkt_rx;

    reg  [15:0]    lbus_number_pkt_proc;
    reg            stat_rx_aligned_1d, reset_done;
    reg            ctl_rx_enable_r, ctl_rx_force_resync_r, ctl_rx_test_pattern_r; 
    reg            ctl_rsfec_ieee_error_indication_mode_r;
    reg            ctl_rx_rsfec_enable_r;
    reg            ctl_rx_rsfec_enable_correction_r;
    reg            ctl_rx_rsfec_enable_indication_r;
    reg            gt_lock_led, rx_aligned_led_c, rx_core_busy_led;
    reg            rx_gt_locked_led_1d, stat_rx_aligned_led_1d, rx_done_led_1d, rx_data_fail_led_1d, rx_core_busy_led_1d;
    reg            rx_gt_locked_led_2d, stat_rx_aligned_led_2d, rx_done_led_2d, rx_data_fail_led_2d, rx_core_busy_led_2d;
    reg            rx_gt_locked_led_3d, stat_rx_aligned_led_3d, rx_done_led_3d, rx_data_fail_led_3d, rx_core_busy_led_3d;
    reg  [8:0]     ctl_rx_pause_enable_r;
    reg            ctl_rx_enable_gcp_r; 
    reg            ctl_rx_check_mcast_gcp_r;
    reg            ctl_rx_check_ucast_gcp_r;
    reg            ctl_rx_check_sa_gcp_r;
    reg            ctl_rx_check_etype_gcp_r;
    reg            ctl_rx_check_opcode_gcp_r;
    reg            ctl_rx_enable_pcp_r;
    reg            ctl_rx_check_mcast_pcp_r;
    reg            ctl_rx_check_ucast_pcp_r;
    reg            ctl_rx_check_sa_pcp_r;
    reg            ctl_rx_check_etype_pcp_r;
    reg            ctl_rx_check_opcode_pcp_r;
    reg            ctl_rx_enable_gpp_r;
    reg            ctl_rx_check_mcast_gpp_r;
    reg            ctl_rx_check_ucast_gpp_r;
    reg            ctl_rx_check_sa_gpp_r;
    reg            ctl_rx_check_etype_gpp_r;
    reg            ctl_rx_check_opcode_gpp_r;
    reg            ctl_rx_enable_ppp_r;
    reg            ctl_rx_check_mcast_ppp_r;
    reg            ctl_rx_check_ucast_ppp_r;
    reg            ctl_rx_check_sa_ppp_r;
    reg            ctl_rx_check_etype_ppp_r;
    reg            ctl_rx_check_opcode_ppp_r;
    reg  [8:0]     ctl_rx_pause_ack_r;
    reg            pause_test_done; 
    reg            stat_rx_pause_r;
    reg            stat_rx_user_pause_r;
    reg  [8:0]     stat_rx_pause_req_r;
    reg  [8:0]     stat_rx_pause_valid_r;
    reg  [15:0]    stat_rx_pause_quanta0_r;
    reg  [15:0]    stat_rx_pause_quanta1_r;
    reg  [15:0]    stat_rx_pause_quanta2_r;
    reg  [15:0]    stat_rx_pause_quanta3_r;
    reg  [15:0]    stat_rx_pause_quanta4_r;
    reg  [15:0]    stat_rx_pause_quanta5_r;
    reg  [15:0]    stat_rx_pause_quanta6_r;
    reg  [15:0]    stat_rx_pause_quanta7_r;
    reg  [15:0]    stat_rx_pause_quanta8_r;
    reg  [8:0]     pause_ppp_rcvd_status;
    reg  [8:0]     init_cntr;
    reg            init_done;
    reg            init_cntr_en;
    reg            send_continuous_pkts_1d, send_continuous_pkts_2d, send_continuous_pkts_3d;

    ////----------------------------------------RX Module -----------------------//
    //////////////////////////////////////////////////
    ////registering input signal generation
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            reset_done             <= 1'b0;
            stat_rx_aligned_1d     <= 1'b0;
            rx_restart_1d          <= 1'b0;
            rx_restart_2d          <= 1'b0;
            rx_restart_3d          <= 1'b0;
            rx_restart_4d          <= 1'b0;
        end
        else
        begin
            reset_done             <= 1'b1;
            stat_rx_aligned_1d     <= stat_rx_aligned;
            rx_restart_1d          <= lbus_tx_rx_restart_in;
            rx_restart_2d          <= rx_restart_1d;
            rx_restart_3d          <= rx_restart_2d;
            rx_restart_4d          <= rx_restart_3d;
        end
    end
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            rx_dataout0_d <= 0;
            rx_dataout1_d <= 0;
            rx_dataout2_d <= 0;
            rx_dataout3_d <= 0;
            rx_enaout0_d  <= 0;
            rx_sopout0_d  <= 0;
            rx_eopout0_d  <= 0;
            rx_errout0_d  <= 0;
            rx_mtyout0_d  <= 0;
            rx_enaout1_d  <= 0;
            rx_sopout1_d  <= 0;
            rx_eopout1_d  <= 0;
            rx_errout1_d  <= 0;
            rx_mtyout1_d  <= 0;
            rx_enaout2_d  <= 0;
            rx_sopout2_d  <= 0;
            rx_eopout2_d  <= 0;
            rx_errout2_d  <= 0;
            rx_mtyout2_d  <= 0;
            rx_enaout3_d  <= 0;
            rx_sopout3_d  <= 0;
            rx_eopout3_d  <= 0;
            rx_errout3_d  <= 0;
            rx_mtyout3_d  <= 0;
        end
        else
        begin
            if (wait_to_restart == 1'b1)
            begin
                rx_dataout0_d <= 0;
                rx_dataout1_d <= 0;
                rx_dataout2_d <= 0;
                rx_dataout3_d <= 0;
                rx_enaout0_d  <= 0;
                rx_sopout0_d  <= 0;
                rx_eopout0_d  <= 0;
                rx_errout0_d  <= 0;
                rx_mtyout0_d  <= 0;
                rx_enaout1_d  <= 0;
                rx_sopout1_d  <= 0;
                rx_eopout1_d  <= 0;
                rx_errout1_d  <= 0;
                rx_mtyout1_d  <= 0;
                rx_enaout2_d  <= 0;
                rx_sopout2_d  <= 0;
                rx_eopout2_d  <= 0;
                rx_errout2_d  <= 0;
                rx_mtyout2_d  <= 0;
                rx_enaout3_d  <= 0;
                rx_sopout3_d  <= 0;
                rx_eopout3_d  <= 0;
                rx_errout3_d  <= 0;
                rx_mtyout3_d  <= 0;
            end
            else
            begin
                rx_enaout0_d  <= rx_enaout0;
                rx_sopout0_d  <= rx_sopout0;
                rx_eopout0_d  <= rx_eopout0;
                rx_errout0_d  <= rx_errout0;
                rx_mtyout0_d  <= rx_mtyout0;
                rx_enaout1_d  <= rx_enaout1;
                rx_sopout1_d  <= rx_sopout1;
                rx_eopout1_d  <= rx_eopout1;
                rx_errout1_d  <= rx_errout1;
                rx_mtyout1_d  <= rx_mtyout1;
                rx_enaout2_d  <= rx_enaout2;
                rx_sopout2_d  <= rx_sopout2;
                rx_eopout2_d  <= rx_eopout2;
                rx_errout2_d  <= rx_errout2;
                rx_mtyout2_d  <= rx_mtyout2;
                rx_enaout3_d  <= rx_enaout3;
                rx_sopout3_d  <= rx_sopout3;
                rx_eopout3_d  <= rx_eopout3;
                rx_errout3_d  <= rx_errout3;
                rx_mtyout3_d  <= rx_mtyout3;
                rx_dataout0_d <= rx_dataout0;
                rx_dataout1_d <= rx_dataout1;
                rx_dataout2_d <= rx_dataout2;
                rx_dataout3_d <= rx_dataout3;
            end
        end
    end

    //////////////////////////////////////////////////
    ////generating the rx_restart_rise_edge signal 
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if  ( reset == 1'b1 )
            rx_restart_rise_edge  <= 1'b0; 
        else
        begin
            if  (( rx_restart_3d == 1'b1) && ( rx_restart_4d == 1'b0))
                rx_restart_rise_edge  <= 1'b1;
            else
                rx_restart_rise_edge  <= 1'b0;
        end
    end    

    //////////////////////////////////////////////////
    ////RX State Machine
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            rx_prestate            <= STATE_RX_IDLE;
            rcv_data               <= 128'd0;
            rcv_datain0            <= 128'd0;
            rcv_datain1            <= 128'd0;
            rcv_datain2            <= 128'd0;
            rcv_datain3            <= 128'd0;
            exp_data               <= 128'd0;
            exp_datain0            <= 128'd0;
            exp_datain1            <= 128'd0;
            exp_datain2            <= 128'd0;
            exp_datain3            <= 128'd0;
            rx_payload_16byte      <= 128'd0;
            rx_payload_16byte_new  <= 128'd0;
            check_seg0             <= 1'b0;
            check_seg1             <= 1'b0;
            check_seg2             <= 1'b0;
            check_seg3             <= 1'b0;
            invalid_lsb_bytes      <= 4'd0;
            number_pkt_rx          <= 16'd0;
            lbus_number_pkt_proc   <= 16'd0;
            rx_payload_1           <= 8'd0;
            rx_payload_2           <= 8'd0;
            rx_payload_new         <= 8'd0;
            rx_fsm_en              <= 1'b0;
            gt_lock_led            <= 1'b0;
            rx_aligned_led_c       <= 1'b0;
            rx_core_busy_led       <= 1'b0;
            ctl_rx_enable_r        <= 1'b0;
            ctl_rx_force_resync_r  <= 1'b0;
            ctl_rx_test_pattern_r  <= 1'b0;
            ctl_rsfec_ieee_error_indication_mode_r     <= 1'b0;
            ctl_rx_rsfec_enable_r             <= 1'b0;
            ctl_rx_rsfec_enable_correction_r  <= 1'b0;
            ctl_rx_rsfec_enable_indication_r  <= 1'b0;
            wait_to_restart        <= 1'b0;
            init_cntr_en           <= 1'b0;
            init_done              <= 1'b0;
        end
        else
        begin
            case (rx_prestate)
                STATE_RX_IDLE            :
                                         begin
                                             rcv_data               <= 128'd0;
                                             rcv_datain0            <= 128'd0;
                                             rcv_datain1            <= 128'd0;
                                             rcv_datain2            <= 128'd0;
                                             rcv_datain3            <= 128'd0;
                                             exp_data               <= 128'd0;
                                             exp_datain0            <= 128'd0;
                                             exp_datain1            <= 128'd0;
                                             exp_datain2            <= 128'd0;
                                             exp_datain3            <= 128'd0;
                                             number_pkt_rx          <= 16'd0;
                                             lbus_number_pkt_proc   <= 16'd0;
                                             check_seg0             <= 1'b0;
                                             check_seg1             <= 1'b0;
                                             check_seg2             <= 1'b0;
                                             check_seg3             <= 1'b0;
                                             invalid_lsb_bytes      <= 4'd0;
                                             rx_fsm_en              <= 1'b0;
                                             gt_lock_led            <= 1'b0;
                                             rx_aligned_led_c       <= 1'b0;
                                             rx_core_busy_led       <= 1'b0;
                                             ctl_rx_enable_r        <= 1'b0;
                                             ctl_rx_force_resync_r  <= 1'b0;
                                             ctl_rx_test_pattern_r  <= 1'b0;
                                             ctl_rsfec_ieee_error_indication_mode_r     <= 1'b0;
                                             ctl_rx_rsfec_enable_r             <= 1'b0;
                                             ctl_rx_rsfec_enable_correction_r  <= 1'b0;
                                             ctl_rx_rsfec_enable_indication_r  <= 1'b0;
                                             wait_to_restart        <= 1'b0;
                                             init_cntr_en           <= 1'b0;
                                             init_done              <= 1'b0;
                                             //// State transition
                                             if  (reset_done == 1'b1)
                                                 rx_prestate <= STATE_GT_LOCKED;
                                             else
                                                 rx_prestate <= STATE_RX_IDLE;
                                         end
                STATE_GT_LOCKED          : 
                                         begin
                                             gt_lock_led            <= 1'b1;
                                             rx_core_busy_led       <= 1'b0;
                                             rx_aligned_led_c       <= 1'b0;
                                             ctl_rx_enable_r        <= 1'b1;
                                             ctl_rx_force_resync_r  <= 1'b0;
                                             ctl_rx_test_pattern_r  <= 1'b0;
                                             ctl_rsfec_ieee_error_indication_mode_r     <= 1'b1;
                                             ctl_rx_rsfec_enable_r             <= 1'b1;
                                             ctl_rx_rsfec_enable_correction_r  <= 1'b1;
                                             ctl_rx_rsfec_enable_indication_r  <= 1'b1;

                                             //// State transition
                                             rx_prestate <= STATE_WAIT_RX_ALIGNED;
                                         end
                STATE_WAIT_RX_ALIGNED    : 
                                         begin
                                             wait_to_restart       <= 1'b0;
                                             rx_aligned_led_c      <= 1'b0;
                                             rx_core_busy_led      <= 1'b0;

                                             //// State transition
                                             if  (stat_rx_aligned_1d == 1'b1)
                                                 rx_prestate <= STATE_PKT_TRANSFER_INIT;
                                             else 
                                                 rx_prestate <= STATE_WAIT_RX_ALIGNED;
                                         end
                STATE_PKT_TRANSFER_INIT  : 
                                         begin
                                             wait_to_restart       <= 1'b0;
                                             rx_aligned_led_c      <= 1'b1;
                                             rx_core_busy_led      <= 1'b1;

                                             rcv_data              <= 128'd0;
                                             rcv_datain0           <= 128'd0;
                                             rcv_datain1           <= 128'd0;
                                             rcv_datain2           <= 128'd0;
                                             rcv_datain3           <= 128'd0;
                                             exp_data              <= 128'd0;
                                             exp_datain0           <= 128'd0;
                                             exp_datain1           <= 128'd0;
                                             exp_datain2           <= 128'd0;
                                             exp_datain3           <= 128'd0;
                                             number_pkt_rx         <= 16'd0;
                                             lbus_number_pkt_proc  <= PKT_NUM;
                                             rx_payload_1          <= 8'd6;
                                             rx_payload_2          <= rx_payload_1 + 8'd1;
                                             rx_payload_new        <= rx_payload_1 + 8'd2;
                                             rx_payload_16byte     <= {rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1,
                                                                       rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1,
                                                                       rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1,
                                                                       rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1 };
                                             rx_payload_16byte_new <= {rx_payload_2, rx_payload_2, rx_payload_2, rx_payload_2,
                                                                       rx_payload_2, rx_payload_2, rx_payload_2, rx_payload_2,
                                                                       rx_payload_2, rx_payload_2, rx_payload_2, rx_payload_2,
                                                                       rx_payload_2, rx_payload_2, rx_payload_2, rx_payload_2 };
                                             check_seg0            <= 1'b0;
                                             check_seg1            <= 1'b0;
                                             check_seg2            <= 1'b0;
                                             check_seg3            <= 1'b0;
                                             invalid_lsb_bytes     <= 4'd0;
                                             rx_fsm_en             <= 1'b0;

                                             //// State transition
                                             if  (stat_rx_aligned_1d == 1'b0)
                                                 rx_prestate <= STATE_RX_IDLE;
                                             else if  ((rx_enaout0 == 1'b1) || (rx_enaout1 == 1'b1) ||
                                                       (rx_enaout2 == 1'b1) || (rx_enaout3 == 1'b1)) 
                                                 rx_prestate <= STATE_LBUS_RX_ENABLE;
                                             else 
                                                 rx_prestate <= STATE_PKT_TRANSFER_INIT;
                                         end
                STATE_LBUS_RX_ENABLE     : 
                                         begin
                                             rx_fsm_en         <= 1'b1;
                                             if((rx_eopout0_d == 1'd1) && (rx_enaout0_d == 1'd1) || (rx_eopout1_d == 1'd1) && (rx_enaout1_d == 1'd1) || 
                                                (rx_eopout2_d == 1'd1) && (rx_enaout2_d == 1'd1) || (rx_eopout3_d == 1'd1) && (rx_enaout3_d == 1'd1))
                                             begin
                                                 number_pkt_rx      <= number_pkt_rx + 16'd1;
                                                 rx_payload_16byte  <= rx_payload_16byte_new;
                                                 if  ( rx_payload_new == 8'd255)
                                                 begin
                                                     rx_payload_new        <= 8'd6;
                                                     rx_payload_16byte_new <= {rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1,
                                                                               rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1,
                                                                               rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1,
                                                                               rx_payload_1, rx_payload_1, rx_payload_1, rx_payload_1 };
                                                 end
                                                 else
                                                 begin
                                                     rx_payload_new        <= rx_payload_new + 8'd1;
                                                     rx_payload_16byte_new <= {rx_payload_new, rx_payload_new, rx_payload_new, rx_payload_new,
                                                                               rx_payload_new, rx_payload_new, rx_payload_new, rx_payload_new,
                                                                               rx_payload_new, rx_payload_new, rx_payload_new, rx_payload_new,
                                                                               rx_payload_new, rx_payload_new, rx_payload_new, rx_payload_new };
                                                 end
                                             end

                                             if((rx_eopout0_d == 1'd1) && (rx_enaout0_d == 1'd1))
                                             begin
                                                 check_seg0         <= 1'b0;
                                                 rcv_data           <= rx_dataout0_d; 
                                                 exp_data           <= rx_payload_16byte; 
                                                 invalid_lsb_bytes  <= rx_mtyout0_d;
                                                 if (rx_sopout1_d == 1'd1)
                                                 begin
                                                     rcv_datain1    <= rx_dataout1_d;
                                                     exp_datain1    <= rx_payload_16byte_new;
                                                     check_seg1     <= 1'b1;
                                                     rcv_datain2    <= rx_dataout2_d;
                                                     exp_datain2    <= rx_payload_16byte_new;
                                                     check_seg2     <= 1'b1;
                                                     rcv_datain3    <= rx_dataout3_d;
                                                     exp_datain3    <= rx_payload_16byte_new;
                                                     check_seg3     <= 1'b1;
                                                 end
                                                 else
                                                 begin
                                                     check_seg1     <= 1'b0;
                                                     check_seg2     <= 1'b0;
                                                     check_seg3     <= 1'b0;
                                                 end
                                             end
                                             else if((rx_eopout1_d == 1'd1) && (rx_enaout1_d == 1'd1))
                                             begin
                                                 rcv_datain0        <= rx_dataout0_d; 
                                                 exp_datain0        <= rx_payload_16byte;
                                                 check_seg0         <= 1'b1;
                                                 check_seg1         <= 1'b0;
                                                 rcv_data           <= rx_dataout1_d;
                                                 exp_data           <= rx_payload_16byte;
                                                 invalid_lsb_bytes  <= rx_mtyout1_d;
                                                 if (rx_sopout2_d == 1'd1)
                                                 begin
                                                     rcv_datain2    <= rx_dataout2_d;
                                                     exp_datain2    <= rx_payload_16byte_new;
                                                     check_seg2     <= 1'b1;
                                                     rcv_datain3    <= rx_dataout3_d;
                                                     exp_datain3    <= rx_payload_16byte_new;
                                                     check_seg3     <= 1'b1;
                                                 end
                                                 else
                                                 begin
                                                     check_seg2     <= 1'b0;
                                                     check_seg3     <= 1'b0;
                                                 end
                                             end
                                             else if((rx_eopout2_d == 1'd1) && (rx_enaout2_d == 1'd1))
                                             begin
                                                 rcv_datain0        <= rx_dataout0_d;
                                                 exp_datain0        <= rx_payload_16byte;
                                                 check_seg0         <= 1'b1;
                                                 rcv_datain1        <= rx_dataout1_d;
                                                 exp_datain1        <= rx_payload_16byte;
                                                 check_seg1         <= 1'b1;
                                                 check_seg2         <= 1'b0;
                                                 rcv_data           <= rx_dataout2_d;
                                                 exp_data           <= rx_payload_16byte;
                                                 invalid_lsb_bytes  <= rx_mtyout2_d;
                                                 if (rx_sopout3_d == 1'd1)
                                                 begin
                                                     rcv_datain3    <= rx_dataout3_d;
                                                     exp_datain3    <= rx_payload_16byte_new;
                                                     check_seg3     <= 1'b1;
                                                 end
                                                 else
                                                 begin
                                                     check_seg3     <= 1'b0;
                                                 end
                                             end
                                             else if((rx_eopout3_d == 1'd1) && (rx_enaout3_d == 1'd1))
                                             begin
                                                 rcv_datain0        <= rx_dataout0_d;
                                                 exp_datain0        <= rx_payload_16byte;
                                                 check_seg0         <= 1'b1;
                                                 rcv_datain1        <= rx_dataout1_d;
                                                 exp_datain1        <= rx_payload_16byte;
                                                 check_seg1         <= 1'b1;
                                                 rcv_datain2        <= rx_dataout2_d;
                                                 exp_datain2        <= rx_payload_16byte;
                                                 check_seg2         <= 1'b1;
                                                 check_seg3         <= 1'b0;
                                                 rcv_data           <= rx_dataout3_d;
                                                 exp_data           <= rx_payload_16byte;
                                                 invalid_lsb_bytes  <= rx_mtyout3_d;
                                             end
                                             else if((rx_enaout0_d == 1'd1) || (rx_enaout1_d == 1'd1) ||
                                                     (rx_enaout2_d == 1'd1) || (rx_enaout3_d == 1'd1))
                                             begin
                                                 rcv_datain0        <= rx_dataout0_d;
                                                 exp_datain0        <= rx_payload_16byte;
                                                 check_seg0         <= 1'b1;
                                                 rcv_datain1        <= rx_dataout1_d;
                                                 exp_datain1        <= rx_payload_16byte;
                                                 check_seg1         <= 1'b1;
                                                 rcv_datain2        <= rx_dataout2_d;
                                                 exp_datain2        <= rx_payload_16byte;
                                                 check_seg2         <= 1'b1;
                                                 rcv_datain3        <= rx_dataout3_d;
                                                 exp_datain3        <= rx_payload_16byte;
                                                 check_seg3         <= 1'b1;
                                             end
                                             else
                                             begin
                                                 check_seg0         <= 1'b0;
                                                 check_seg1         <= 1'b0;
                                                 check_seg2         <= 1'b0;
                                                 check_seg3         <= 1'b0;
                                             end

                                             //// State transition
                                             if  (stat_rx_aligned_1d == 1'b0)
                                                 rx_prestate <= STATE_RX_IDLE;
                                             else if (rx_done_reg== 1'b1 && send_continuous_pkts_3d == 1'b0)
                                                 rx_prestate <= STATE_LBUS_RX_DONE;
                                             else
                                                 rx_prestate <= STATE_LBUS_RX_ENABLE;
                                         end
            STATE_LBUS_RX_DONE           :
                                         begin
                                             wait_to_restart        <= 1'b0;
                                             invalid_lsb_bytes      <= 4'd0;
                                             rx_fsm_en              <= 1'b0;
                                             rcv_data               <= 128'd0;
                                             rcv_datain0            <= 128'd0;
                                             rcv_datain1            <= 128'd0;
                                             rcv_datain2            <= 128'd0;
                                             rcv_datain3            <= 128'd0;
                                             exp_data               <= 128'd0;
                                             exp_datain0            <= 128'd0;
                                             exp_datain1            <= 128'd0;
                                             exp_datain2            <= 128'd0;
                                             exp_datain3            <= 128'd0;
                                             check_seg0             <= 1'b0;
                                             check_seg1             <= 1'b0;
                                             check_seg2             <= 1'b0;
                                             check_seg3             <= 1'b0;
                                             init_cntr_en           <= 1'b0;
                                             init_done              <= 1'b0;

                                             //// State transition
                                             if  (stat_rx_aligned_1d == 1'b0)
                                                 rx_prestate <= STATE_RX_IDLE;
                                             else if (pause_test_done == 1'b1)
                                                 rx_prestate <= STATE_WAIT_FOR_RESTART;
                                             else
                                                 rx_prestate <= STATE_LBUS_RX_DONE;
                                         end
              STATE_WAIT_FOR_RESTART     : 
                                         begin
                                             number_pkt_rx          <= 16'd0;
                                             wait_to_restart        <= 1'b1;
                                             if ( init_done == 1'b1)
                                             begin
                                                 rx_core_busy_led   <= 1'b0;
                                                 init_cntr_en       <= 1'b0;
                                             end
                                             else
                                             begin 
                                                 init_done          <= init_cntr[6];
                                                 init_cntr_en       <= 1'b1;
                                             end


                                             //// State transition
                                             if  ((rx_core_busy_led == 1'b0) && (rx_restart_rise_edge == 1'b1) && (stat_rx_aligned_1d == 1'b1))
                                                 rx_prestate <= STATE_PKT_TRANSFER_INIT;
                                             else if  (stat_rx_aligned_1d == 1'b0)
                                                 rx_prestate <= STATE_RX_IDLE;
                                             else 
                                                 rx_prestate <= STATE_WAIT_FOR_RESTART;
                                         end
              default                    :
                                         begin
                                             wait_to_restart        <= 1'b0;
                                             rx_fsm_en              <= 1'b0;
                                             rcv_data               <= 128'd0;
                                             rcv_datain0            <= 128'd0;
                                             rcv_datain1            <= 128'd0;
                                             rcv_datain2            <= 128'd0;
                                             rcv_datain3            <= 128'd0;
                                             exp_data               <= 128'd0;
                                             exp_datain0            <= 128'd0;
                                             exp_datain1            <= 128'd0;
                                             exp_datain2            <= 128'd0;
                                             exp_datain3            <= 128'd0;
                                             check_seg0             <= 1'b0;
                                             check_seg1             <= 1'b0;
                                             check_seg2             <= 1'b0;
                                             check_seg3             <= 1'b0;
                                             number_pkt_rx          <= 16'd0;
                                             lbus_number_pkt_proc   <= 16'd0;
                                             rx_payload_1           <= 8'd0;
                                             rx_payload_2           <= 8'd0;
                                             rx_payload_new         <= 8'd0;
                                             rx_payload_16byte      <= 128'd0;
                                             gt_lock_led            <= 1'b0;
                                             rx_aligned_led_c       <= 1'b0;
                                             rx_core_busy_led       <= 1'b0;
                                             ctl_rx_enable_r        <= 1'b0;
                                             ctl_rx_force_resync_r  <= 1'b0;
                                             ctl_rx_test_pattern_r  <= 1'b0;
                                             ctl_rsfec_ieee_error_indication_mode_r     <= 1'b0;
                                             ctl_rx_rsfec_enable_r             <= 1'b0;
                                             ctl_rx_rsfec_enable_correction_r  <= 1'b0;
                                             ctl_rx_rsfec_enable_indication_r  <= 1'b0;
                                             init_cntr_en           <= 1'b0;
                                             init_done              <= 1'b0;
                                             rx_prestate            <= STATE_RX_IDLE;
                                         end
            endcase
        end
    end

    //////////////////////////////////////////////////
    ////registering the send_continuous_pkts signal
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            send_continuous_pkts_1d     <= 1'b0;
            send_continuous_pkts_2d     <= 1'b0;
            send_continuous_pkts_3d     <= 1'b0;
        end
        else
        begin
            send_continuous_pkts_1d  <= send_continuous_pkts;
            send_continuous_pkts_2d  <= send_continuous_pkts_1d;
            send_continuous_pkts_3d  <= send_continuous_pkts_2d;
        end
    end

    //////////////////////////////////////////////////
    ////Checker Module
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            rx_data0_chk_fail   <= 1'b0;
            rx_data1_chk_fail   <= 1'b0;
            rx_data2_chk_fail   <= 1'b0;
            rx_data3_chk_fail   <= 1'b0;
        end
        else 
        begin
            if ((check_seg0 == 1'b1) && (rx_done_reg == 1'b0))
                if (rcv_datain0 == exp_datain0)
                    rx_data0_chk_fail <=1'b0;
                else
                    rx_data0_chk_fail <=1'b1;
            if ((check_seg1 == 1'b1) && (rx_done_reg == 1'b0))
                if (rcv_datain1 == exp_datain1)
                    rx_data1_chk_fail <=1'b0;
                else
                    rx_data1_chk_fail <=1'b1;
            if ((check_seg2 == 1'b1) && (rx_done_reg == 1'b0))
                if (rcv_datain2 == exp_datain2)
                    rx_data2_chk_fail <=1'b0;
                else
                    rx_data2_chk_fail <=1'b1;
            if ((check_seg3 == 1'b1) && (rx_done_reg == 1'b0))
                if (rcv_datain3 == exp_datain3)
                    rx_data3_chk_fail <=1'b0;
                else
                    rx_data3_chk_fail <=1'b1;
        end
    end

    //////////////////////////////////////////////////
    ////rx_done_reg signal generation
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            rx_done_reg <= 1'b0;
        end
        else
            if  ( ((rx_restart_rise_edge == 1'b1) && (wait_to_restart == 1'b1)) || (stat_rx_aligned_1d == 1'b0) )
                rx_done_reg <= 1'b0;    
            else if  ((number_pkt_rx == lbus_number_pkt_proc) && (rx_fsm_en == 1'b1))
                rx_done_reg <= 1'b1;
    end
    
    //////////////////////////////////////////////////
    ////rx_data_fail signal generation
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            rx_data_fail <= 1'b0;
        end
        else
        begin
            if  ((rx_restart_rise_edge == 1'b1) && (wait_to_restart == 1'b1))
                 rx_data_fail <= 1'b0;
             else if ((rx_fsm_en ==1'b1) && ((rx_data0_chk_fail == 1'b1) ||  (rx_data1_chk_fail == 1'b1) ||  
                      (rx_data2_chk_fail == 1'b1) || (rx_data3_chk_fail == 1'b1) || (byte_cmp_fail == 1'b1)))
                rx_data_fail <= 1'b1;
        end
    end

    //////////////////////////////////////////////////////////////////////////////
    ////rcv_data_cmp and exp_data_cmp generation according to invalid_lsb_bytes
    //////////////////////////////////////////////////////////////////////////////

    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            rcv_data_cmp <=  128'd0;
            exp_data_cmp <=  128'd0;
        end
        else
        begin
            if ((rx_done_reg == 1'b0) && ( rx_fsm_en == 1'b1 ))
            begin 
                case (invalid_lsb_bytes)
                     4'd0  : begin
                                 rcv_data_cmp <=  rcv_data;
                                 exp_data_cmp <=  exp_data;
                             end
                     4'd1  : begin
                                 rcv_data_cmp <=  {rcv_data[127:8],8'd0};
                                 exp_data_cmp <=  {exp_data[127:8],8'd0};
                             end
                     4'd2  : begin
                                 rcv_data_cmp <=  {rcv_data[127:16],16'd0};
                                 exp_data_cmp <=  {exp_data[127:16],16'd0};
                             end
                     4'd3  : begin
                                 rcv_data_cmp <=  {rcv_data[127:24],24'd0};
                                 exp_data_cmp <=  {exp_data[127:24],24'd0};
                             end
                     4'd4  : begin
                                 rcv_data_cmp <=  {rcv_data[127:32],32'd0};
                                 exp_data_cmp <=  {exp_data[127:32],32'd0};
                             end
                     4'd5  : begin
                                 rcv_data_cmp <=  {rcv_data[127:40],40'd0};
                                 exp_data_cmp <=  {exp_data[127:40],40'd0};
                             end
                     4'd6  : begin
                                 rcv_data_cmp <=  {rcv_data[127:48],48'd0};
                                 exp_data_cmp <=  {exp_data[127:48],48'd0};
                             end
                     4'd7  : begin
                                 rcv_data_cmp <=  {rcv_data[127:56],56'd0};
                                 exp_data_cmp <=  {exp_data[127:56],56'd0};
                             end
                     4'd8  : begin
                                 rcv_data_cmp <=  {rcv_data[127:64],64'd0};
                                 exp_data_cmp <=  {exp_data[127:64],64'd0};
                             end
                     4'd9  : begin
                                 rcv_data_cmp <=  {rcv_data[127:72],72'd0};
                                 exp_data_cmp <=  {exp_data[127:72],72'd0};
                             end
                     4'd10  : begin
                                 rcv_data_cmp <=  {rcv_data[127:80],80'd0};
                                 exp_data_cmp <=  {exp_data[127:80],80'd0};
                             end
                     4'd11  : begin
                                 rcv_data_cmp <=  {rcv_data[127:88],88'd0};
                                 exp_data_cmp <=  {exp_data[127:88],88'd0};
                             end
                     4'd12  : begin
                                 rcv_data_cmp <=  {rcv_data[127:96],96'd0};
                                 exp_data_cmp <=  {exp_data[127:96],96'd0};
                             end
                     4'd13  : begin
                                 rcv_data_cmp <=  {rcv_data[127:104],104'd0};
                                 exp_data_cmp <=  {exp_data[127:104],104'd0};
                             end
                     4'd14  : begin
                                 rcv_data_cmp <=  {rcv_data[127:112],112'd0};
                                 exp_data_cmp <=  {exp_data[127:112],112'd0};
                             end
                     4'd15  : begin
                                 rcv_data_cmp <=  {rcv_data[127:120],120'd0};
                                 exp_data_cmp <=  {exp_data[127:120],120'd0};
                             end
                     default : begin
                                 rcv_data_cmp <=  128'd0;
                                 exp_data_cmp <=  128'd0;
                             end 
                endcase
            end
            else 
            begin 
                rcv_data_cmp <=  128'd0;
                exp_data_cmp <=  128'd0;
            end
        end
    end  

    //////////////////////////////////////////////////
    ////byte_cmp_fail signal generation
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            byte_cmp_fail <= 1'b0;
        end
        else
        begin
            if (rcv_data_cmp == exp_data_cmp)
                byte_cmp_fail <= 1'b0;
            else 
                byte_cmp_fail <= 1'b1;
        end
    end
    
    //////////////////////////////////////////////////
    ////Assign RX LED Output ports with ASYN sys_reset
    //////////////////////////////////////////////////
    always @( posedge clk, posedge sys_reset  )
    begin
        if ( sys_reset == 1'b1 )
        begin
            rx_gt_locked_led     <= 1'b0;
            rx_aligned_led       <= 1'b0;
            rx_done_led          <= 1'b0;
            rx_data_fail_led     <= 1'b0;
            rx_busy_led          <= 1'b0;
        end
        else
        begin
            rx_gt_locked_led     <= rx_gt_locked_led_3d;
            rx_aligned_led       <= stat_rx_aligned_led_3d;
            rx_done_led          <= rx_done_led_3d;
            rx_data_fail_led     <= rx_data_fail_led_3d;
            rx_busy_led          <= rx_core_busy_led_3d;
        end
    end

    //////////////////////////////////////////////////
    ////init_cntr signal generation 
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            init_cntr <= 0;
        end
        else
        begin
            if (init_cntr_en == 1'b1)
               init_cntr <= init_cntr + 1;
            else 
               init_cntr <= 0;
        end
    end

    ////////////////////////////////////////////////////
    ////Monitoring Pause PPP frame received status
    ////////////////////////////////////////////////////
    always  @( posedge clk )
     begin
       if ( reset == 1'b1 )
       begin
           pause_ppp_rcvd_status  <= 9'h0;
       end
       else 
       begin
           if ((rx_restart_rise_edge == 1'b1) && (wait_to_restart == 1'b1))
               pause_ppp_rcvd_status  <= 9'h0;
           else 
               pause_ppp_rcvd_status  <=  pause_ppp_rcvd_status | stat_rx_pause_valid_r;
       end
    end

    ////////////////////////////////////////////////////
    ////Assigning Rx Pause control configuration signal
    ////////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
             ctl_rx_pause_enable_r      <= 9'd0;
             ctl_rx_enable_gcp_r        <= 1'b0; 
             ctl_rx_check_mcast_gcp_r   <= 1'b0;
             ctl_rx_check_ucast_gcp_r   <= 1'b0;
             ctl_rx_check_sa_gcp_r      <= 1'b0;
             ctl_rx_check_etype_gcp_r   <= 1'b0;
             ctl_rx_check_opcode_gcp_r  <= 1'b0;
             ctl_rx_enable_pcp_r        <= 1'b0;
             ctl_rx_check_mcast_pcp_r   <= 1'b0;
             ctl_rx_check_ucast_pcp_r   <= 1'b0;
             ctl_rx_check_sa_pcp_r      <= 1'b0;
             ctl_rx_check_etype_pcp_r   <= 1'b0;
             ctl_rx_check_opcode_pcp_r  <= 1'b0;
             ctl_rx_enable_gpp_r        <= 1'b0;
             ctl_rx_check_mcast_gpp_r   <= 1'b0;
             ctl_rx_check_ucast_gpp_r   <= 1'b0;
             ctl_rx_check_sa_gpp_r      <= 1'b0;
             ctl_rx_check_etype_gpp_r   <= 1'b0;
             ctl_rx_check_opcode_gpp_r  <= 1'b0;
             ctl_rx_enable_ppp_r        <= 1'b0;
             ctl_rx_check_mcast_ppp_r   <= 1'b0;
             ctl_rx_check_ucast_ppp_r   <= 1'b0;
             ctl_rx_check_sa_ppp_r      <= 1'b0;
             ctl_rx_check_etype_ppp_r   <= 1'b0;
             ctl_rx_check_opcode_ppp_r  <= 1'b0;
             ctl_rx_pause_ack_r         <= 9'd0;
             pause_test_done            <= 1'b0;
         end
         else
         begin
             if (pause_ppp_rcvd_status == 9'h1ff) 
             begin
                  ctl_rx_enable_gcp_r        <= 1'b0;
                  ctl_rx_enable_gpp_r        <= 1'b0;
                  ctl_rx_check_opcode_gpp_r  <= 1'b0;
                  ctl_rx_check_opcode_gcp_r  <= 1'b0;
                  ctl_rx_enable_pcp_r        <= 1'b0;
                  ctl_rx_check_opcode_pcp_r  <= 1'b0;
                  ctl_rx_enable_ppp_r        <= 1'b0;
                  ctl_rx_check_opcode_ppp_r  <= 1'b0;
                  ctl_rx_pause_enable_r      <= 9'h0;
                  ctl_rx_check_mcast_gcp_r   <= 1'b0;
                  ctl_rx_check_mcast_pcp_r   <= 1'b0;
                  ctl_rx_check_mcast_gpp_r   <= 1'b0;
                  ctl_rx_check_mcast_ppp_r   <= 1'b0;
                  pause_test_done            <= 1'b1;
             end
             else if (stat_rx_aligned_1d == 1'b1)
             begin
                  ctl_rx_enable_gcp_r        <= 1'b1;
                  ctl_rx_enable_gpp_r        <= 1'b1;
                  ctl_rx_check_opcode_gpp_r  <= 1'b1;
                  ctl_rx_check_opcode_gcp_r  <= 1'b1;
                  ctl_rx_enable_pcp_r        <= 1'b1;
                  ctl_rx_check_opcode_pcp_r  <= 1'b1;
                  ctl_rx_enable_ppp_r        <= 1'b1;
                  ctl_rx_check_opcode_ppp_r  <= 1'b1;
                  ctl_rx_pause_enable_r      <= 9'h1ff;
                  ctl_rx_check_mcast_gcp_r   <= 1'b1;
                  ctl_rx_check_mcast_pcp_r   <= 1'b1;
                  ctl_rx_check_mcast_gpp_r   <= 1'b1;
                  ctl_rx_check_mcast_ppp_r   <= 1'b1;
                  pause_test_done            <= 1'b0;
             end
         end 
    end
 
    //////////////////////////////////////////////////
    ////Registering rx pause input signal
    //////////////////////////////////////////////////
    always @( posedge clk)
    begin
        if ( reset == 1'b1 )
        begin
            stat_rx_pause_r             <= 1'b0;
            stat_rx_user_pause_r        <= 1'b0;
            stat_rx_pause_req_r         <= 8'd0;
            stat_rx_pause_valid_r       <= 8'd0;
            stat_rx_pause_quanta0_r     <= 16'd0;
            stat_rx_pause_quanta1_r     <= 16'd0;
            stat_rx_pause_quanta2_r     <= 16'd0;
            stat_rx_pause_quanta3_r     <= 16'd0;
            stat_rx_pause_quanta4_r     <= 16'd0;
            stat_rx_pause_quanta5_r     <= 16'd0;
            stat_rx_pause_quanta6_r     <= 16'd0;
            stat_rx_pause_quanta7_r     <= 16'd0;
            stat_rx_pause_quanta8_r     <= 16'd0;
        end
        else
        begin
            stat_rx_pause_r             <= stat_rx_pause;
            stat_rx_user_pause_r        <= stat_rx_user_pause;
            stat_rx_pause_req_r         <= stat_rx_pause_req;
            stat_rx_pause_valid_r       <= stat_rx_pause_valid;
            stat_rx_pause_quanta0_r     <= stat_rx_pause_quanta0;
            stat_rx_pause_quanta1_r     <= stat_rx_pause_quanta1;
            stat_rx_pause_quanta2_r     <= stat_rx_pause_quanta2;
            stat_rx_pause_quanta3_r     <= stat_rx_pause_quanta3;
            stat_rx_pause_quanta4_r     <= stat_rx_pause_quanta4;
            stat_rx_pause_quanta5_r     <= stat_rx_pause_quanta5;
            stat_rx_pause_quanta6_r     <= stat_rx_pause_quanta6;
            stat_rx_pause_quanta7_r     <= stat_rx_pause_quanta7;
            stat_rx_pause_quanta8_r     <= stat_rx_pause_quanta8;
        end
    end

    //////////////////////////////////////////////////
    ////Registering the LED ports
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            rx_gt_locked_led_1d     <= 1'b0;
            rx_gt_locked_led_2d     <= 1'b0;
            rx_gt_locked_led_3d     <= 1'b0;
            stat_rx_aligned_led_1d  <= 1'b0;
            stat_rx_aligned_led_2d  <= 1'b0;
            stat_rx_aligned_led_3d  <= 1'b0;
            rx_done_led_1d          <= 1'b0;
            rx_done_led_2d          <= 1'b0;
            rx_done_led_3d          <= 1'b0;
            rx_data_fail_led_1d     <= 1'b0;
            rx_data_fail_led_2d     <= 1'b0;
            rx_data_fail_led_3d     <= 1'b0;
            rx_core_busy_led_1d     <= 1'b0;
            rx_core_busy_led_2d     <= 1'b0;
            rx_core_busy_led_3d     <= 1'b0;
        end
        else
        begin
            rx_gt_locked_led_1d     <= gt_lock_led;
            rx_gt_locked_led_2d     <= rx_gt_locked_led_1d;
            rx_gt_locked_led_3d     <= rx_gt_locked_led_2d;
            stat_rx_aligned_led_1d  <= rx_aligned_led_c;
            stat_rx_aligned_led_2d  <= stat_rx_aligned_led_1d;
            stat_rx_aligned_led_3d  <= stat_rx_aligned_led_2d;
            rx_done_led_1d          <= rx_done_reg & (~send_continuous_pkts_3d);
            rx_done_led_2d          <= rx_done_led_1d;
            rx_done_led_3d          <= rx_done_led_2d;
            rx_data_fail_led_1d     <= rx_data_fail;
            rx_data_fail_led_2d     <= rx_data_fail_led_1d;
            rx_data_fail_led_3d     <= rx_data_fail_led_2d;
            rx_core_busy_led_1d     <= rx_core_busy_led;
            rx_core_busy_led_2d     <= rx_core_busy_led_1d;
            rx_core_busy_led_3d     <= rx_core_busy_led_2d;
        end
    end



assign ctl_rx_enable            = ctl_rx_enable_r;
assign ctl_rx_force_resync      = ctl_rx_force_resync_r;
assign ctl_rx_test_pattern      = ctl_rx_test_pattern_r;
assign ctl_rsfec_ieee_error_indication_mode      = ctl_rsfec_ieee_error_indication_mode_r;
assign ctl_rx_rsfec_enable                       = ctl_rx_rsfec_enable_r;
assign ctl_rx_rsfec_enable_correction            = ctl_rx_rsfec_enable_correction_r;
assign ctl_rx_rsfec_enable_indication            = ctl_rx_rsfec_enable_indication_r;
assign ctl_rx_pause_enable      = ctl_rx_pause_enable_r;
assign ctl_rx_enable_gcp        = ctl_rx_enable_gcp_r;
assign ctl_rx_check_mcast_gcp   = ctl_rx_check_mcast_gcp_r;
assign ctl_rx_check_ucast_gcp   = ctl_rx_check_ucast_gcp_r;
assign ctl_rx_check_sa_gcp      = ctl_rx_check_sa_gcp_r;
assign ctl_rx_check_etype_gcp   = ctl_rx_check_etype_gcp_r;
assign ctl_rx_check_opcode_gcp  = ctl_rx_check_opcode_gcp_r;
assign ctl_rx_enable_pcp        = ctl_rx_enable_pcp_r;
assign ctl_rx_check_mcast_pcp   = ctl_rx_check_mcast_pcp_r;
assign ctl_rx_check_ucast_pcp   = ctl_rx_check_ucast_pcp_r;
assign ctl_rx_check_sa_pcp      = ctl_rx_check_sa_pcp_r;
assign ctl_rx_check_etype_pcp   = ctl_rx_check_etype_pcp_r;
assign ctl_rx_check_opcode_pcp  = ctl_rx_check_opcode_pcp_r;
assign ctl_rx_enable_gpp        = ctl_rx_enable_gpp_r;
assign ctl_rx_check_mcast_gpp   = ctl_rx_check_mcast_gpp_r;
assign ctl_rx_check_ucast_gpp   = ctl_rx_check_ucast_gpp_r;
assign ctl_rx_check_sa_gpp      = ctl_rx_check_sa_gpp_r;
assign ctl_rx_check_etype_gpp   = ctl_rx_check_etype_gpp_r;
assign ctl_rx_check_opcode_gpp  = ctl_rx_check_opcode_gpp_r;
assign ctl_rx_enable_ppp        = ctl_rx_enable_ppp_r;
assign ctl_rx_check_mcast_ppp   = ctl_rx_check_mcast_ppp_r;
assign ctl_rx_check_ucast_ppp   = ctl_rx_check_ucast_ppp_r;
assign ctl_rx_check_sa_ppp      = ctl_rx_check_sa_ppp_r;
assign ctl_rx_check_etype_ppp   = ctl_rx_check_etype_ppp_r;
assign ctl_rx_check_opcode_ppp  = ctl_rx_check_opcode_ppp_r;
assign ctl_rx_pause_ack         = ctl_rx_pause_ack_r;
assign rx_reset                 = 1'b0;                          //// Used to Reset the CMAC RX Core
 ////----------------------------------------END RX Module-----------------------//

endmodule



