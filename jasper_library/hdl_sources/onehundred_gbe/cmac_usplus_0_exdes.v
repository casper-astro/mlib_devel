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
module cmac_usplus_0_exdes
(
    input  [3 :0] gt_rxp_in,
    input  [3 :0] gt_rxn_in,
    output [3 :0] gt_txp_out,
    output [3 :0] gt_txn_out,

    input  wire     lbus_tx_rx_restart_in,
    output wire     tx_done_led,
    output wire     tx_busy_led,

    output wire     rx_gt_locked_led,
    output wire     rx_aligned_led,
    output wire     rx_done_led,
    output wire     rx_data_fail_led,
    output wire     rx_busy_led,

    input           sys_reset,

    input           gt_ref_clk_p,
    input           gt_ref_clk_n,
    input           init_clk_p,
    input           init_clk_n,
    
    input wire[15:0]Dest_port,
    input wire[15:0]Source_port,
    input wire[31:0]Dest_Ip,
    input wire[175:0]Data_input,
    input wire[47:0]Dest_Mac,
    input wire[47:0]Source_Mac,
    input wire[31:0]Source_Ip
);

  parameter PKT_NUM      = 100;    //// 1 to 65535 (Number of packets)
  parameter PKT_SIZE     = 64;     //// 64 to 16383 (Each Packet Size)

  wire [11 :0]    gt_loopback_in;

  //// For other GT loopback options please change the value appropriately
  //// For example, for Near End PMA loopback for 4 Lanes update the gt_loopback_in = {4{3'b010}};
  //// For more information and settings on loopback, refer GT Transceivers user guide

  assign gt_loopback_in  = {4{3'b000}};

  wire            init_clk;
  wire            gt_ref_clk_out;
  wire            usr_rx_reset;
  wire [128-1:0]  rx_dataout0;
  wire            rx_enaout0;
  wire            rx_sopout0;
  wire            rx_eopout0;
  wire            rx_errout0;
  wire [4-1:0]    rx_mtyout0;
  wire [128-1:0]  rx_dataout1;
  wire            rx_enaout1;
  wire            rx_sopout1;
  wire            rx_eopout1;
  wire            rx_errout1;
  wire [4-1:0]    rx_mtyout1;
  wire [128-1:0]  rx_dataout2;
  wire            rx_enaout2;
  wire            rx_sopout2;
  wire            rx_eopout2;
  wire            rx_errout2;
  wire [4-1:0]    rx_mtyout2;
  wire [128-1:0]  rx_dataout3;
  wire            rx_enaout3;
  wire            rx_sopout3;
  wire            rx_eopout3;
  wire            rx_errout3;
  wire [4-1:0]    rx_mtyout3;

  wire            tx_rdyout;
  wire [128-1:0]  tx_datain0;
  wire            tx_enain0;
  wire            tx_sopin0;
  wire            tx_eopin0;
  wire            tx_errin0;
  wire [4-1:0]    tx_mtyin0;
  wire [128-1:0]  tx_datain1;
  wire            tx_enain1;
  wire            tx_sopin1;
  wire            tx_eopin1;
  wire            tx_errin1;
  wire [4-1:0]    tx_mtyin1;
  wire [128-1:0]  tx_datain2;
  wire            tx_enain2;
  wire            tx_sopin2;
  wire            tx_eopin2;
  wire            tx_errin2;
  wire [4-1:0]    tx_mtyin2;
  wire [128-1:0]  tx_datain3;
  wire            tx_enain3;
  wire            tx_sopin3;
  wire            tx_eopin3;
  wire            tx_errin3;
  wire [4-1:0]    tx_mtyin3;
  wire            tx_ovfout;
  wire            tx_unfout;
  wire [55:0]     tx_preamblein;
  wire            usr_tx_reset;
  wire            gt_rxusrclk2;
  wire [8:0]      stat_tx_pause_valid;
  wire            stat_tx_pause;
  wire            stat_tx_user_pause;
  wire [8:0]      ctl_tx_pause_enable;
  wire [15:0]     ctl_tx_pause_quanta0;
  wire [15:0]     ctl_tx_pause_quanta1;
  wire [15:0]     ctl_tx_pause_quanta2;
  wire [15:0]     ctl_tx_pause_quanta3;
  wire [15:0]     ctl_tx_pause_quanta4;
  wire [15:0]     ctl_tx_pause_quanta5;
  wire [15:0]     ctl_tx_pause_quanta6;
  wire [15:0]     ctl_tx_pause_quanta7;
  wire [15:0]     ctl_tx_pause_quanta8;
  wire [15:0]     ctl_tx_pause_refresh_timer0;
  wire [15:0]     ctl_tx_pause_refresh_timer1;
  wire [15:0]     ctl_tx_pause_refresh_timer2;
  wire [15:0]     ctl_tx_pause_refresh_timer3;
  wire [15:0]     ctl_tx_pause_refresh_timer4;
  wire [15:0]     ctl_tx_pause_refresh_timer5;
  wire [15:0]     ctl_tx_pause_refresh_timer6;
  wire [15:0]     ctl_tx_pause_refresh_timer7;
  wire [15:0]     ctl_tx_pause_refresh_timer8;
  wire [8:0]      ctl_tx_pause_req;
  wire            ctl_tx_resend_pause;
  wire            stat_rx_pause;
  wire [15:0]     stat_rx_pause_quanta0;
  wire [15:0]     stat_rx_pause_quanta1;
  wire [15:0]     stat_rx_pause_quanta2;
  wire [15:0]     stat_rx_pause_quanta3;
  wire [15:0]     stat_rx_pause_quanta4;
  wire [15:0]     stat_rx_pause_quanta5;
  wire [15:0]     stat_rx_pause_quanta6;
  wire [15:0]     stat_rx_pause_quanta7;
  wire [15:0]     stat_rx_pause_quanta8;
  wire [8:0]      stat_rx_pause_req;
  wire [8:0]      stat_rx_pause_valid;
  wire            stat_rx_user_pause;
  wire            ctl_rx_check_etype_gcp;
  wire            ctl_rx_check_etype_gpp;
  wire            ctl_rx_check_etype_pcp;
  wire            ctl_rx_check_etype_ppp;
  wire            ctl_rx_check_mcast_gcp;
  wire            ctl_rx_check_mcast_gpp;
  wire            ctl_rx_check_mcast_pcp;
  wire            ctl_rx_check_mcast_ppp;
  wire            ctl_rx_check_opcode_gcp;
  wire            ctl_rx_check_opcode_gpp;
  wire            ctl_rx_check_opcode_pcp;
  wire            ctl_rx_check_opcode_ppp;
  wire            ctl_rx_check_sa_gcp;
  wire            ctl_rx_check_sa_gpp;
  wire            ctl_rx_check_sa_pcp;
  wire            ctl_rx_check_sa_ppp;
  wire            ctl_rx_check_ucast_gcp;
  wire            ctl_rx_check_ucast_gpp;
  wire            ctl_rx_check_ucast_pcp;
  wire            ctl_rx_check_ucast_ppp;
  wire            ctl_rx_enable_gcp;
  wire            ctl_rx_enable_gpp;
  wire            ctl_rx_enable_pcp;
  wire            ctl_rx_enable_ppp;
  wire [8:0]      ctl_rx_pause_ack;
  wire [8:0]      ctl_rx_pause_enable;
  wire            stat_rx_aligned;
  wire            stat_rx_aligned_err;
  wire [2:0]      stat_rx_bad_code;
  wire [2:0]      stat_rx_bad_fcs;
  wire            stat_rx_bad_preamble;
  wire            stat_rx_bad_sfd;
  wire            stat_rx_bip_err_0;
  wire            stat_rx_bip_err_1;
  wire            stat_rx_bip_err_10;
  wire            stat_rx_bip_err_11;
  wire            stat_rx_bip_err_12;
  wire            stat_rx_bip_err_13;
  wire            stat_rx_bip_err_14;
  wire            stat_rx_bip_err_15;
  wire            stat_rx_bip_err_16;
  wire            stat_rx_bip_err_17;
  wire            stat_rx_bip_err_18;
  wire            stat_rx_bip_err_19;
  wire            stat_rx_bip_err_2;
  wire            stat_rx_bip_err_3;
  wire            stat_rx_bip_err_4;
  wire            stat_rx_bip_err_5;
  wire            stat_rx_bip_err_6;
  wire            stat_rx_bip_err_7;
  wire            stat_rx_bip_err_8;
  wire            stat_rx_bip_err_9;
  wire [19:0]     stat_rx_block_lock;
  wire            stat_rx_broadcast;
  wire [2:0]      stat_rx_fragment;
  wire [1:0]      stat_rx_framing_err_0;
  wire [1:0]      stat_rx_framing_err_1;
  wire [1:0]      stat_rx_framing_err_10;
  wire [1:0]      stat_rx_framing_err_11;
  wire [1:0]      stat_rx_framing_err_12;
  wire [1:0]      stat_rx_framing_err_13;
  wire [1:0]      stat_rx_framing_err_14;
  wire [1:0]      stat_rx_framing_err_15;
  wire [1:0]      stat_rx_framing_err_16;
  wire [1:0]      stat_rx_framing_err_17;
  wire [1:0]      stat_rx_framing_err_18;
  wire [1:0]      stat_rx_framing_err_19;
  wire [1:0]      stat_rx_framing_err_2;
  wire [1:0]      stat_rx_framing_err_3;
  wire [1:0]      stat_rx_framing_err_4;
  wire [1:0]      stat_rx_framing_err_5;
  wire [1:0]      stat_rx_framing_err_6;
  wire [1:0]      stat_rx_framing_err_7;
  wire [1:0]      stat_rx_framing_err_8;
  wire [1:0]      stat_rx_framing_err_9;
  wire            stat_rx_framing_err_valid_0;
  wire            stat_rx_framing_err_valid_1;
  wire            stat_rx_framing_err_valid_10;
  wire            stat_rx_framing_err_valid_11;
  wire            stat_rx_framing_err_valid_12;
  wire            stat_rx_framing_err_valid_13;
  wire            stat_rx_framing_err_valid_14;
  wire            stat_rx_framing_err_valid_15;
  wire            stat_rx_framing_err_valid_16;
  wire            stat_rx_framing_err_valid_17;
  wire            stat_rx_framing_err_valid_18;
  wire            stat_rx_framing_err_valid_19;
  wire            stat_rx_framing_err_valid_2;
  wire            stat_rx_framing_err_valid_3;
  wire            stat_rx_framing_err_valid_4;
  wire            stat_rx_framing_err_valid_5;
  wire            stat_rx_framing_err_valid_6;
  wire            stat_rx_framing_err_valid_7;
  wire            stat_rx_framing_err_valid_8;
  wire            stat_rx_framing_err_valid_9;
  wire            stat_rx_got_signal_os;
  wire            stat_rx_hi_ber;
  wire            stat_rx_inrangeerr;
  wire            stat_rx_internal_local_fault;
  wire            stat_rx_jabber;
  wire            stat_rx_local_fault;
  wire [19:0]     stat_rx_mf_err;
  wire [19:0]     stat_rx_mf_len_err;
  wire [19:0]     stat_rx_mf_repeat_err;
  wire            stat_rx_misaligned;
  wire            stat_rx_multicast;
  wire            stat_rx_oversize;
  wire            stat_rx_packet_1024_1518_bytes;
  wire            stat_rx_packet_128_255_bytes;
  wire            stat_rx_packet_1519_1522_bytes;
  wire            stat_rx_packet_1523_1548_bytes;
  wire            stat_rx_packet_1549_2047_bytes;
  wire            stat_rx_packet_2048_4095_bytes;
  wire            stat_rx_packet_256_511_bytes;
  wire            stat_rx_packet_4096_8191_bytes;
  wire            stat_rx_packet_512_1023_bytes;
  wire            stat_rx_packet_64_bytes;
  wire            stat_rx_packet_65_127_bytes;
  wire            stat_rx_packet_8192_9215_bytes;
  wire            stat_rx_packet_bad_fcs;
  wire            stat_rx_packet_large;
  wire [2:0]      stat_rx_packet_small;
  wire            stat_rx_received_local_fault;
  wire            stat_rx_remote_fault;
  wire            stat_rx_status;
  wire [2:0]      stat_rx_stomped_fcs;
  wire [19:0]     stat_rx_synced;
  wire [19:0]     stat_rx_synced_err;
  wire [2:0]      stat_rx_test_pattern_mismatch;
  wire            stat_rx_toolong;
  wire [6:0]      stat_rx_total_bytes;
  wire [13:0]     stat_rx_total_good_bytes;
  wire            stat_rx_total_good_packets;
  wire [2:0]      stat_rx_total_packets;
  wire            stat_rx_truncated;
  wire [2:0]      stat_rx_undersize;
  wire            stat_rx_unicast;
  wire            stat_rx_vlan;
  wire [19:0]     stat_rx_pcsl_demuxed;
  wire [4:0]      stat_rx_pcsl_number_0;
  wire [4:0]      stat_rx_pcsl_number_1;
  wire [4:0]      stat_rx_pcsl_number_10;
  wire [4:0]      stat_rx_pcsl_number_11;
  wire [4:0]      stat_rx_pcsl_number_12;
  wire [4:0]      stat_rx_pcsl_number_13;
  wire [4:0]      stat_rx_pcsl_number_14;
  wire [4:0]      stat_rx_pcsl_number_15;
  wire [4:0]      stat_rx_pcsl_number_16;
  wire [4:0]      stat_rx_pcsl_number_17;
  wire [4:0]      stat_rx_pcsl_number_18;
  wire [4:0]      stat_rx_pcsl_number_19;
  wire [4:0]      stat_rx_pcsl_number_2;
  wire [4:0]      stat_rx_pcsl_number_3;
  wire [4:0]      stat_rx_pcsl_number_4;
  wire [4:0]      stat_rx_pcsl_number_5;
  wire [4:0]      stat_rx_pcsl_number_6;
  wire [4:0]      stat_rx_pcsl_number_7;
  wire [4:0]      stat_rx_pcsl_number_8;
  wire [4:0]      stat_rx_pcsl_number_9;
  wire            stat_rx_rsfec_am_lock0;
  wire            stat_rx_rsfec_am_lock1;
  wire            stat_rx_rsfec_am_lock2;
  wire            stat_rx_rsfec_am_lock3;
  wire            stat_rx_rsfec_corrected_cw_inc;
  wire            stat_rx_rsfec_cw_inc;
  wire [2:0]      stat_rx_rsfec_err_count0_inc;
  wire [2:0]      stat_rx_rsfec_err_count1_inc;
  wire [2:0]      stat_rx_rsfec_err_count2_inc;
  wire [2:0]      stat_rx_rsfec_err_count3_inc;
  wire            stat_rx_rsfec_hi_ser;
  wire            stat_rx_rsfec_lane_alignment_status;
  wire [13:0]     stat_rx_rsfec_lane_fill_0;
  wire [13:0]     stat_rx_rsfec_lane_fill_1;
  wire [13:0]     stat_rx_rsfec_lane_fill_2;
  wire [13:0]     stat_rx_rsfec_lane_fill_3;
  wire [7:0]      stat_rx_rsfec_lane_mapping;
  wire            stat_rx_rsfec_uncorrected_cw_inc;
  wire            stat_tx_bad_fcs;
  wire            stat_tx_broadcast;
  wire            stat_tx_frame_error;
  wire            stat_tx_local_fault;
  wire            stat_tx_multicast;
  wire            stat_tx_packet_1024_1518_bytes;
  wire            stat_tx_packet_128_255_bytes;
  wire            stat_tx_packet_1519_1522_bytes;
  wire            stat_tx_packet_1523_1548_bytes;
  wire            stat_tx_packet_1549_2047_bytes;
  wire            stat_tx_packet_2048_4095_bytes;
  wire            stat_tx_packet_256_511_bytes;
  wire            stat_tx_packet_4096_8191_bytes;
  wire            stat_tx_packet_512_1023_bytes;
  wire            stat_tx_packet_64_bytes;
  wire            stat_tx_packet_65_127_bytes;
  wire            stat_tx_packet_8192_9215_bytes;
  wire            stat_tx_packet_large;
  wire            stat_tx_packet_small;
  wire [5:0]      stat_tx_total_bytes;
  wire [13:0]     stat_tx_total_good_bytes;
  wire            stat_tx_total_good_packets;
  wire            stat_tx_total_packets;
  wire            stat_tx_unicast;
  wire            stat_tx_vlan;

  wire [7:0]      rx_otn_bip8_0;
  wire [7:0]      rx_otn_bip8_1;
  wire [7:0]      rx_otn_bip8_2;
  wire [7:0]      rx_otn_bip8_3;
  wire [7:0]      rx_otn_bip8_4;
  wire [65:0]     rx_otn_data_0;
  wire [65:0]     rx_otn_data_1;
  wire [65:0]     rx_otn_data_2;
  wire [65:0]     rx_otn_data_3;
  wire [65:0]     rx_otn_data_4;
  wire            rx_otn_ena;
  wire            rx_otn_lane0;
  wire            rx_otn_vlmarker;
  wire [55:0]     rx_preambleout;


  wire            ctl_rx_enable;
  wire            ctl_rx_force_resync;
  wire            ctl_rx_test_pattern;
  wire            ctl_tx_enable;
  wire            ctl_tx_send_idle;
  wire            ctl_tx_send_rfi;
  wire            ctl_tx_send_lfi;
  wire            ctl_tx_test_pattern;
  wire            ctl_rsfec_ieee_error_indication_mode;
  wire            ctl_rsfec_ieee_error_indication_mode_int;
  wire            ctl_rx_rsfec_enable;
  wire            ctl_rx_rsfec_enable_int;
  wire            ctl_rx_rsfec_enable_correction;
  wire            ctl_rx_rsfec_enable_correction_int;
  wire            ctl_rx_rsfec_enable_indication;
  wire            ctl_rx_rsfec_enable_indication_int;
  wire            ctl_tx_rsfec_enable;
  wire            ctl_tx_rsfec_enable_int;
  wire            rx_reset;
  wire            tx_reset;
  wire [3 :0]     gt_rxrecclkout;
  wire [3 :0]     gt_powergoodout;
  wire            gtwiz_reset_tx_datapath;
  wire            gtwiz_reset_rx_datapath;
  wire            txusrclk2;

  wire [3 :0]     gt_eyescanreset;
  wire [3 :0]     gt_eyescantrigger;
  wire [3 :0]     gt_rxcdrhold;
  wire [3 :0]     gt_rxpolarity;
  wire [11 :0]    gt_rxrate;
  wire [19 :0]    gt_txdiffctrl;
  wire [3 :0]     gt_txpolarity;
  wire [3 :0]     gt_txinhibit;
  wire [19 :0]    gt_txpostcursor;
  wire [3 :0]     gt_txprbsforceerr;
  wire [19 :0]    gt_txprecursor;
  wire [3 :0]     gt_eyescandataerror;
  wire [7 :0]    gt_txbufstatus;
  wire [3 :0]     gt_rxdfelpmreset;
  wire [3 :0]     gt_rxlpmen;
  wire [3 :0]     gt_rxprbscntreset;
  wire [3 :0]     gt_rxprbserr;
  wire [15 :0]    gt_rxprbssel;
  wire [3 :0]     gt_rxresetdone;
  wire [15 :0]    gt_txprbssel;
  wire [3 :0]     gt_txresetdone;
  wire [11 :0]    gt_rxbufstatus;
  wire [9:0]      gt0_drpaddr;
  wire            gt0_drpen;
  wire [15:0]     gt0_drpdi;
  wire [15:0]     gt0_drpdo;
  wire            gt0_drprdy;
  wire            gt0_drpwe;
  wire [9:0]      gt1_drpaddr;
  wire            gt1_drpen;
  wire [15:0]     gt1_drpdi;
  wire [15:0]     gt1_drpdo;
  wire            gt1_drprdy;
  wire            gt1_drpwe;
  wire [9:0]      gt2_drpaddr;
  wire            gt2_drpen;
  wire [15:0]     gt2_drpdi;
  wire [15:0]     gt2_drpdo;
  wire            gt2_drprdy;
  wire            gt2_drpwe;
  wire [9:0]      gt3_drpaddr;
  wire            gt3_drpen;
  wire [15:0]     gt3_drpdi;
  wire [15:0]     gt3_drpdo;
  wire            gt3_drprdy;
  wire            gt3_drpwe;
  wire [15:0]     common0_drpaddr;
  wire [15:0]     common0_drpdi;
  wire            common0_drpwe;
  wire            common0_drpen;
  wire            common0_drprdy;
  wire [15:0]     common0_drpdo;
  wire [511:0]    Data_link;
  
  wire [15:0]     Header_checksum_seg0, Header_checksum_seg1, Header_checksum_seg2,Header_checksum_seg3,Header_checksum_seg4, Header_checksum;
  wire [15:0]     Carryon;

  assign gtwiz_reset_tx_datapath    = 1'b0;
  assign gtwiz_reset_rx_datapath    = 1'b0;

IBUFDS IBUFDS_ins(
.I (init_clk_p),
.IB (init_clk_n),
.O (init_clk)
);

    
  assign Header_checksum_seg0 = 16'h4500;
  assign Header_checksum_seg1 = 16'h0032;
  assign Header_checksum_seg2 = 16'h0000;
  assign Header_checksum_seg3 = 16'h4000;
  assign Header_checksum_seg4 = 16'hff11;

  assign {Carryon, Header_checksum} = Header_checksum_seg0 + Header_checksum_seg1+ Header_checksum_seg2 + Header_checksum_seg3 + Header_checksum_seg4
                                        + Source_Ip[31:16] + Source_Ip[15:0] + Dest_Ip[31:16] + Dest_Ip[15:0];


  assign Data_link       = {Dest_Mac, Source_Mac ,16'h0800    //Ethernet Frame
                           ,16'h4500, 32'h00320000, 32'h4000ff11, ~(Header_checksum + Carryon), Source_Ip, Dest_Ip    //Ipv4 Frame
                           ,Source_port , Dest_port, 16'h001e, 16'h0000 // UDP Frame
                           ,Data_input };


cmac_usplus_0_core_support i_cmac_usplus_0_core_support
(
    .gt_rxp_in                            (gt_rxp_in),
    .gt_rxn_in                            (gt_rxn_in),
    .gt_txp_out                           (gt_txp_out),
    .gt_txn_out                           (gt_txn_out),
    .gt_txusrclk2                         (txusrclk2),
    .gt_loopback_in                       (gt_loopback_in),
    .gt_rxrecclkout                       (gt_rxrecclkout),
    .gt_powergoodout                      (gt_powergoodout),
    .gtwiz_reset_tx_datapath              (gtwiz_reset_tx_datapath),
    .gtwiz_reset_rx_datapath              (gtwiz_reset_rx_datapath),
    .gt_eyescanreset                      (gt_eyescanreset),
    .gt_eyescantrigger                    (gt_eyescantrigger),
    .gt_rxcdrhold                         (gt_rxcdrhold),
    .gt_rxpolarity                        (gt_rxpolarity),
    .gt_rxrate                            (gt_rxrate),
    .gt_txdiffctrl                        (gt_txdiffctrl),
    .gt_txpolarity                        (gt_txpolarity),
    .gt_txinhibit                         (gt_txinhibit),
    .gt_txpostcursor                      (gt_txpostcursor),
    .gt_txprbsforceerr                    (gt_txprbsforceerr),
    .gt_txprecursor                       (gt_txprecursor),
    .gt_eyescandataerror                  (gt_eyescandataerror),
    .gt_txbufstatus                       (gt_txbufstatus),
    .gt_rxdfelpmreset                     (gt_rxdfelpmreset),
    .gt_rxlpmen                           (gt_rxlpmen),
    .gt_rxprbscntreset                    (gt_rxprbscntreset),
    .gt_rxprbserr                         (gt_rxprbserr),
    .gt_rxprbssel                         (gt_rxprbssel),
    .gt_rxresetdone                       (gt_rxresetdone),
    .gt_txprbssel                         (gt_txprbssel),
    .gt_txresetdone                       (gt_txresetdone),
    .gt_rxbufstatus                       (gt_rxbufstatus),
    .gt_drpclk                            (init_clk),
    .gt0_drpdo                            (gt0_drpdo),
    .gt0_drprdy                           (gt0_drprdy),
    .gt0_drpen                            (gt0_drpen),
    .gt0_drpwe                            (gt0_drpwe),
    .gt0_drpaddr                          (gt0_drpaddr),
    .gt0_drpdi                            (gt0_drpdi),
    .gt1_drpdo                            (gt1_drpdo),
    .gt1_drprdy                           (gt1_drprdy),
    .gt1_drpen                            (gt1_drpen),
    .gt1_drpwe                            (gt1_drpwe),
    .gt1_drpaddr                          (gt1_drpaddr),
    .gt1_drpdi                            (gt1_drpdi),
    .gt2_drpdo                            (gt2_drpdo),
    .gt2_drprdy                           (gt2_drprdy),
    .gt2_drpen                            (gt2_drpen),
    .gt2_drpwe                            (gt2_drpwe),
    .gt2_drpaddr                          (gt2_drpaddr),
    .gt2_drpdi                            (gt2_drpdi),
    .gt3_drpdo                            (gt3_drpdo),
    .gt3_drprdy                           (gt3_drprdy),
    .gt3_drpen                            (gt3_drpen),
    .gt3_drpwe                            (gt3_drpwe),
    .gt3_drpaddr                          (gt3_drpaddr),
    .gt3_drpdi                            (gt3_drpdi),
    .common0_drpaddr                      (common0_drpaddr),
    .common0_drpdi                        (common0_drpdi),
    .common0_drpwe                        (common0_drpwe),
    .common0_drpen                        (common0_drpen),
    .common0_drprdy                       (common0_drprdy),
    .common0_drpdo                        (common0_drpdo),
    .sys_reset                            (sys_reset),
    .gt_ref_clk_p                         (gt_ref_clk_p),
    .gt_ref_clk_n                         (gt_ref_clk_n),
    .init_clk                             (init_clk),
    .gt_ref_clk_out                       (gt_ref_clk_out),

    .rx_dataout0                          (rx_dataout0),
    .rx_dataout1                          (rx_dataout1),
    .rx_dataout2                          (rx_dataout2),
    .rx_dataout3                          (rx_dataout3),
    .rx_enaout0                           (rx_enaout0),
    .rx_enaout1                           (rx_enaout1),
    .rx_enaout2                           (rx_enaout2),
    .rx_enaout3                           (rx_enaout3),
    .rx_eopout0                           (rx_eopout0),
    .rx_eopout1                           (rx_eopout1),
    .rx_eopout2                           (rx_eopout2),
    .rx_eopout3                           (rx_eopout3),
    .rx_errout0                           (rx_errout0),
    .rx_errout1                           (rx_errout1),
    .rx_errout2                           (rx_errout2),
    .rx_errout3                           (rx_errout3),
    .rx_mtyout0                           (rx_mtyout0),
    .rx_mtyout1                           (rx_mtyout1),
    .rx_mtyout2                           (rx_mtyout2),
    .rx_mtyout3                           (rx_mtyout3),
    .rx_sopout0                           (rx_sopout0),
    .rx_sopout1                           (rx_sopout1),
    .rx_sopout2                           (rx_sopout2),
    .rx_sopout3                           (rx_sopout3),
    .rx_otn_bip8_0                        (rx_otn_bip8_0),
    .rx_otn_bip8_1                        (rx_otn_bip8_1),
    .rx_otn_bip8_2                        (rx_otn_bip8_2),
    .rx_otn_bip8_3                        (rx_otn_bip8_3),
    .rx_otn_bip8_4                        (rx_otn_bip8_4),
    .rx_otn_data_0                        (rx_otn_data_0),
    .rx_otn_data_1                        (rx_otn_data_1),
    .rx_otn_data_2                        (rx_otn_data_2),
    .rx_otn_data_3                        (rx_otn_data_3),
    .rx_otn_data_4                        (rx_otn_data_4),
    .rx_otn_ena                           (rx_otn_ena),
    .rx_otn_lane0                         (rx_otn_lane0),
    .rx_otn_vlmarker                      (rx_otn_vlmarker),
    .rx_preambleout                       (rx_preambleout),
    .usr_rx_reset                         (usr_rx_reset),
    .gt_rxusrclk2                         (gt_rxusrclk2),
    .stat_rx_aligned                      (stat_rx_aligned),
    .stat_rx_aligned_err                  (stat_rx_aligned_err),
    .stat_rx_bad_code                     (stat_rx_bad_code),
    .stat_rx_bad_fcs                      (stat_rx_bad_fcs),
    .stat_rx_bad_preamble                 (stat_rx_bad_preamble),
    .stat_rx_bad_sfd                      (stat_rx_bad_sfd),
    .stat_rx_bip_err_0                    (stat_rx_bip_err_0),
    .stat_rx_bip_err_1                    (stat_rx_bip_err_1),
    .stat_rx_bip_err_10                   (stat_rx_bip_err_10),
    .stat_rx_bip_err_11                   (stat_rx_bip_err_11),
    .stat_rx_bip_err_12                   (stat_rx_bip_err_12),
    .stat_rx_bip_err_13                   (stat_rx_bip_err_13),
    .stat_rx_bip_err_14                   (stat_rx_bip_err_14),
    .stat_rx_bip_err_15                   (stat_rx_bip_err_15),
    .stat_rx_bip_err_16                   (stat_rx_bip_err_16),
    .stat_rx_bip_err_17                   (stat_rx_bip_err_17),
    .stat_rx_bip_err_18                   (stat_rx_bip_err_18),
    .stat_rx_bip_err_19                   (stat_rx_bip_err_19),
    .stat_rx_bip_err_2                    (stat_rx_bip_err_2),
    .stat_rx_bip_err_3                    (stat_rx_bip_err_3),
    .stat_rx_bip_err_4                    (stat_rx_bip_err_4),
    .stat_rx_bip_err_5                    (stat_rx_bip_err_5),
    .stat_rx_bip_err_6                    (stat_rx_bip_err_6),
    .stat_rx_bip_err_7                    (stat_rx_bip_err_7),
    .stat_rx_bip_err_8                    (stat_rx_bip_err_8),
    .stat_rx_bip_err_9                    (stat_rx_bip_err_9),
    .stat_rx_block_lock                   (stat_rx_block_lock),
    .stat_rx_broadcast                    (stat_rx_broadcast),
    .stat_rx_fragment                     (stat_rx_fragment),
    .stat_rx_framing_err_0                (stat_rx_framing_err_0),
    .stat_rx_framing_err_1                (stat_rx_framing_err_1),
    .stat_rx_framing_err_10               (stat_rx_framing_err_10),
    .stat_rx_framing_err_11               (stat_rx_framing_err_11),
    .stat_rx_framing_err_12               (stat_rx_framing_err_12),
    .stat_rx_framing_err_13               (stat_rx_framing_err_13),
    .stat_rx_framing_err_14               (stat_rx_framing_err_14),
    .stat_rx_framing_err_15               (stat_rx_framing_err_15),
    .stat_rx_framing_err_16               (stat_rx_framing_err_16),
    .stat_rx_framing_err_17               (stat_rx_framing_err_17),
    .stat_rx_framing_err_18               (stat_rx_framing_err_18),
    .stat_rx_framing_err_19               (stat_rx_framing_err_19),
    .stat_rx_framing_err_2                (stat_rx_framing_err_2),
    .stat_rx_framing_err_3                (stat_rx_framing_err_3),
    .stat_rx_framing_err_4                (stat_rx_framing_err_4),
    .stat_rx_framing_err_5                (stat_rx_framing_err_5),
    .stat_rx_framing_err_6                (stat_rx_framing_err_6),
    .stat_rx_framing_err_7                (stat_rx_framing_err_7),
    .stat_rx_framing_err_8                (stat_rx_framing_err_8),
    .stat_rx_framing_err_9                (stat_rx_framing_err_9),
    .stat_rx_framing_err_valid_0          (stat_rx_framing_err_valid_0),
    .stat_rx_framing_err_valid_1          (stat_rx_framing_err_valid_1),
    .stat_rx_framing_err_valid_10         (stat_rx_framing_err_valid_10),
    .stat_rx_framing_err_valid_11         (stat_rx_framing_err_valid_11),
    .stat_rx_framing_err_valid_12         (stat_rx_framing_err_valid_12),
    .stat_rx_framing_err_valid_13         (stat_rx_framing_err_valid_13),
    .stat_rx_framing_err_valid_14         (stat_rx_framing_err_valid_14),
    .stat_rx_framing_err_valid_15         (stat_rx_framing_err_valid_15),
    .stat_rx_framing_err_valid_16         (stat_rx_framing_err_valid_16),
    .stat_rx_framing_err_valid_17         (stat_rx_framing_err_valid_17),
    .stat_rx_framing_err_valid_18         (stat_rx_framing_err_valid_18),
    .stat_rx_framing_err_valid_19         (stat_rx_framing_err_valid_19),
    .stat_rx_framing_err_valid_2          (stat_rx_framing_err_valid_2),
    .stat_rx_framing_err_valid_3          (stat_rx_framing_err_valid_3),
    .stat_rx_framing_err_valid_4          (stat_rx_framing_err_valid_4),
    .stat_rx_framing_err_valid_5          (stat_rx_framing_err_valid_5),
    .stat_rx_framing_err_valid_6          (stat_rx_framing_err_valid_6),
    .stat_rx_framing_err_valid_7          (stat_rx_framing_err_valid_7),
    .stat_rx_framing_err_valid_8          (stat_rx_framing_err_valid_8),
    .stat_rx_framing_err_valid_9          (stat_rx_framing_err_valid_9),
    .stat_rx_got_signal_os                (stat_rx_got_signal_os),
    .stat_rx_hi_ber                       (stat_rx_hi_ber),
    .stat_rx_inrangeerr                   (stat_rx_inrangeerr),
    .stat_rx_internal_local_fault         (stat_rx_internal_local_fault),
    .stat_rx_jabber                       (stat_rx_jabber),
    .stat_rx_local_fault                  (stat_rx_local_fault),
    .stat_rx_mf_err                       (stat_rx_mf_err),
    .stat_rx_mf_len_err                   (stat_rx_mf_len_err),
    .stat_rx_mf_repeat_err                (stat_rx_mf_repeat_err),
    .stat_rx_misaligned                   (stat_rx_misaligned),
    .stat_rx_multicast                    (stat_rx_multicast),
    .stat_rx_oversize                     (stat_rx_oversize),
    .stat_rx_packet_1024_1518_bytes       (stat_rx_packet_1024_1518_bytes),
    .stat_rx_packet_128_255_bytes         (stat_rx_packet_128_255_bytes),
    .stat_rx_packet_1519_1522_bytes       (stat_rx_packet_1519_1522_bytes),
    .stat_rx_packet_1523_1548_bytes       (stat_rx_packet_1523_1548_bytes),
    .stat_rx_packet_1549_2047_bytes       (stat_rx_packet_1549_2047_bytes),
    .stat_rx_packet_2048_4095_bytes       (stat_rx_packet_2048_4095_bytes),
    .stat_rx_packet_256_511_bytes         (stat_rx_packet_256_511_bytes),
    .stat_rx_packet_4096_8191_bytes       (stat_rx_packet_4096_8191_bytes),
    .stat_rx_packet_512_1023_bytes        (stat_rx_packet_512_1023_bytes),
    .stat_rx_packet_64_bytes              (stat_rx_packet_64_bytes),
    .stat_rx_packet_65_127_bytes          (stat_rx_packet_65_127_bytes),
    .stat_rx_packet_8192_9215_bytes       (stat_rx_packet_8192_9215_bytes),
    .stat_rx_packet_bad_fcs               (stat_rx_packet_bad_fcs),
    .stat_rx_packet_large                 (stat_rx_packet_large),
    .stat_rx_packet_small                 (stat_rx_packet_small),
    .stat_rx_pause                        (stat_rx_pause),
    .stat_rx_pause_quanta0                (stat_rx_pause_quanta0),
    .stat_rx_pause_quanta1                (stat_rx_pause_quanta1),
    .stat_rx_pause_quanta2                (stat_rx_pause_quanta2),
    .stat_rx_pause_quanta3                (stat_rx_pause_quanta3),
    .stat_rx_pause_quanta4                (stat_rx_pause_quanta4),
    .stat_rx_pause_quanta5                (stat_rx_pause_quanta5),
    .stat_rx_pause_quanta6                (stat_rx_pause_quanta6),
    .stat_rx_pause_quanta7                (stat_rx_pause_quanta7),
    .stat_rx_pause_quanta8                (stat_rx_pause_quanta8),
    .stat_rx_pause_req                    (stat_rx_pause_req),
    .stat_rx_pause_valid                  (stat_rx_pause_valid),
    .stat_rx_user_pause                   (stat_rx_user_pause),
    .ctl_rx_check_etype_gcp               (ctl_rx_check_etype_gcp),
    .ctl_rx_check_etype_gpp               (ctl_rx_check_etype_gpp),
    .ctl_rx_check_etype_pcp               (ctl_rx_check_etype_pcp),
    .ctl_rx_check_etype_ppp               (ctl_rx_check_etype_ppp),
    .ctl_rx_check_mcast_gcp               (ctl_rx_check_mcast_gcp),
    .ctl_rx_check_mcast_gpp               (ctl_rx_check_mcast_gpp),
    .ctl_rx_check_mcast_pcp               (ctl_rx_check_mcast_pcp),
    .ctl_rx_check_mcast_ppp               (ctl_rx_check_mcast_ppp),
    .ctl_rx_check_opcode_gcp              (ctl_rx_check_opcode_gcp),
    .ctl_rx_check_opcode_gpp              (ctl_rx_check_opcode_gpp),
    .ctl_rx_check_opcode_pcp              (ctl_rx_check_opcode_pcp),
    .ctl_rx_check_opcode_ppp              (ctl_rx_check_opcode_ppp),
    .ctl_rx_check_sa_gcp                  (ctl_rx_check_sa_gcp),
    .ctl_rx_check_sa_gpp                  (ctl_rx_check_sa_gpp),
    .ctl_rx_check_sa_pcp                  (ctl_rx_check_sa_pcp),
    .ctl_rx_check_sa_ppp                  (ctl_rx_check_sa_ppp),
    .ctl_rx_check_ucast_gcp               (ctl_rx_check_ucast_gcp),
    .ctl_rx_check_ucast_gpp               (ctl_rx_check_ucast_gpp),
    .ctl_rx_check_ucast_pcp               (ctl_rx_check_ucast_pcp),
    .ctl_rx_check_ucast_ppp               (ctl_rx_check_ucast_ppp),
    .ctl_rx_enable_gcp                    (ctl_rx_enable_gcp),
    .ctl_rx_enable_gpp                    (ctl_rx_enable_gpp),
    .ctl_rx_enable_pcp                    (ctl_rx_enable_pcp),
    .ctl_rx_enable_ppp                    (ctl_rx_enable_ppp),
    .ctl_rx_pause_ack                     (ctl_rx_pause_ack),
    .ctl_rx_pause_enable                  (ctl_rx_pause_enable),
    .ctl_rx_enable                        (ctl_rx_enable),
    .ctl_rx_force_resync                  (ctl_rx_force_resync),
    .ctl_rx_test_pattern                  (ctl_rx_test_pattern),
    .ctl_rsfec_ieee_error_indication_mode (ctl_rsfec_ieee_error_indication_mode_int),
    .ctl_rx_rsfec_enable                  (ctl_rx_rsfec_enable_int),
    .ctl_rx_rsfec_enable_correction       (ctl_rx_rsfec_enable_correction_int),
    .ctl_rx_rsfec_enable_indication       (ctl_rx_rsfec_enable_indication_int),
    .core_rx_reset                        (1'b0),
    .rx_clk                               (txusrclk2),
    .stat_rx_received_local_fault         (stat_rx_received_local_fault),
    .stat_rx_remote_fault                 (stat_rx_remote_fault),
    .stat_rx_status                       (stat_rx_status),
    .stat_rx_stomped_fcs                  (stat_rx_stomped_fcs),
    .stat_rx_synced                       (stat_rx_synced),
    .stat_rx_synced_err                   (stat_rx_synced_err),
    .stat_rx_test_pattern_mismatch        (stat_rx_test_pattern_mismatch),
    .stat_rx_toolong                      (stat_rx_toolong),
    .stat_rx_total_bytes                  (stat_rx_total_bytes),
    .stat_rx_total_good_bytes             (stat_rx_total_good_bytes),
    .stat_rx_total_good_packets           (stat_rx_total_good_packets),
    .stat_rx_total_packets                (stat_rx_total_packets),
    .stat_rx_truncated                    (stat_rx_truncated),
    .stat_rx_undersize                    (stat_rx_undersize),
    .stat_rx_unicast                      (stat_rx_unicast),
    .stat_rx_vlan                         (stat_rx_vlan),
    .stat_rx_pcsl_demuxed                 (stat_rx_pcsl_demuxed),
    .stat_rx_pcsl_number_0                (stat_rx_pcsl_number_0),
    .stat_rx_pcsl_number_1                (stat_rx_pcsl_number_1),
    .stat_rx_pcsl_number_10               (stat_rx_pcsl_number_10),
    .stat_rx_pcsl_number_11               (stat_rx_pcsl_number_11),
    .stat_rx_pcsl_number_12               (stat_rx_pcsl_number_12),
    .stat_rx_pcsl_number_13               (stat_rx_pcsl_number_13),
    .stat_rx_pcsl_number_14               (stat_rx_pcsl_number_14),
    .stat_rx_pcsl_number_15               (stat_rx_pcsl_number_15),
    .stat_rx_pcsl_number_16               (stat_rx_pcsl_number_16),
    .stat_rx_pcsl_number_17               (stat_rx_pcsl_number_17),
    .stat_rx_pcsl_number_18               (stat_rx_pcsl_number_18),
    .stat_rx_pcsl_number_19               (stat_rx_pcsl_number_19),
    .stat_rx_pcsl_number_2                (stat_rx_pcsl_number_2),
    .stat_rx_pcsl_number_3                (stat_rx_pcsl_number_3),
    .stat_rx_pcsl_number_4                (stat_rx_pcsl_number_4),
    .stat_rx_pcsl_number_5                (stat_rx_pcsl_number_5),
    .stat_rx_pcsl_number_6                (stat_rx_pcsl_number_6),
    .stat_rx_pcsl_number_7                (stat_rx_pcsl_number_7),
    .stat_rx_pcsl_number_8                (stat_rx_pcsl_number_8),
    .stat_rx_pcsl_number_9                (stat_rx_pcsl_number_9),
    .stat_rx_rsfec_am_lock0               (stat_rx_rsfec_am_lock0),
    .stat_rx_rsfec_am_lock1               (stat_rx_rsfec_am_lock1),
    .stat_rx_rsfec_am_lock2               (stat_rx_rsfec_am_lock2),
    .stat_rx_rsfec_am_lock3               (stat_rx_rsfec_am_lock3),
    .stat_rx_rsfec_corrected_cw_inc       (stat_rx_rsfec_corrected_cw_inc),
    .stat_rx_rsfec_cw_inc                 (stat_rx_rsfec_cw_inc),
    .stat_rx_rsfec_err_count0_inc         (stat_rx_rsfec_err_count0_inc),
    .stat_rx_rsfec_err_count1_inc         (stat_rx_rsfec_err_count1_inc),
    .stat_rx_rsfec_err_count2_inc         (stat_rx_rsfec_err_count2_inc),
    .stat_rx_rsfec_err_count3_inc         (stat_rx_rsfec_err_count3_inc),
    .stat_rx_rsfec_hi_ser                 (stat_rx_rsfec_hi_ser),
    .stat_rx_rsfec_lane_alignment_status  (stat_rx_rsfec_lane_alignment_status),
    .stat_rx_rsfec_lane_fill_0            (stat_rx_rsfec_lane_fill_0),
    .stat_rx_rsfec_lane_fill_1            (stat_rx_rsfec_lane_fill_1),
    .stat_rx_rsfec_lane_fill_2            (stat_rx_rsfec_lane_fill_2),
    .stat_rx_rsfec_lane_fill_3            (stat_rx_rsfec_lane_fill_3),
    .stat_rx_rsfec_lane_mapping           (stat_rx_rsfec_lane_mapping),
    .stat_rx_rsfec_uncorrected_cw_inc     (stat_rx_rsfec_uncorrected_cw_inc),
    .stat_tx_bad_fcs                      (stat_tx_bad_fcs),
    .stat_tx_broadcast                    (stat_tx_broadcast),
    .stat_tx_frame_error                  (stat_tx_frame_error),
    .stat_tx_local_fault                  (stat_tx_local_fault),
    .stat_tx_multicast                    (stat_tx_multicast),
    .stat_tx_packet_1024_1518_bytes       (stat_tx_packet_1024_1518_bytes),
    .stat_tx_packet_128_255_bytes         (stat_tx_packet_128_255_bytes),
    .stat_tx_packet_1519_1522_bytes       (stat_tx_packet_1519_1522_bytes),
    .stat_tx_packet_1523_1548_bytes       (stat_tx_packet_1523_1548_bytes),
    .stat_tx_packet_1549_2047_bytes       (stat_tx_packet_1549_2047_bytes),
    .stat_tx_packet_2048_4095_bytes       (stat_tx_packet_2048_4095_bytes),
    .stat_tx_packet_256_511_bytes         (stat_tx_packet_256_511_bytes),
    .stat_tx_packet_4096_8191_bytes       (stat_tx_packet_4096_8191_bytes),
    .stat_tx_packet_512_1023_bytes        (stat_tx_packet_512_1023_bytes),
    .stat_tx_packet_64_bytes              (stat_tx_packet_64_bytes),
    .stat_tx_packet_65_127_bytes          (stat_tx_packet_65_127_bytes),
    .stat_tx_packet_8192_9215_bytes       (stat_tx_packet_8192_9215_bytes),
    .stat_tx_packet_large                 (stat_tx_packet_large),
    .stat_tx_packet_small                 (stat_tx_packet_small),
    .stat_tx_total_bytes                  (stat_tx_total_bytes),
    .stat_tx_total_good_bytes             (stat_tx_total_good_bytes),
    .stat_tx_total_good_packets           (stat_tx_total_good_packets),
    .stat_tx_total_packets                (stat_tx_total_packets),
    .stat_tx_unicast                      (stat_tx_unicast),
    .stat_tx_vlan                         (stat_tx_vlan),


    .ctl_tx_enable                        (ctl_tx_enable),
    .ctl_tx_send_idle                     (ctl_tx_send_idle),
    .ctl_tx_send_rfi                      (ctl_tx_send_rfi),
    .ctl_tx_send_lfi                      (ctl_tx_send_lfi),
    .ctl_tx_test_pattern                  (ctl_tx_test_pattern),
    .ctl_tx_rsfec_enable                  (ctl_tx_rsfec_enable_int),
    .core_tx_reset                        (1'b0),
    .stat_tx_pause_valid                  (stat_tx_pause_valid),
    .stat_tx_pause                        (stat_tx_pause),
    .stat_tx_user_pause                   (stat_tx_user_pause),
    .ctl_tx_pause_enable                  (ctl_tx_pause_enable),
    .ctl_tx_pause_quanta0                 (ctl_tx_pause_quanta0),
    .ctl_tx_pause_quanta1                 (ctl_tx_pause_quanta1),
    .ctl_tx_pause_quanta2                 (ctl_tx_pause_quanta2),
    .ctl_tx_pause_quanta3                 (ctl_tx_pause_quanta3),
    .ctl_tx_pause_quanta4                 (ctl_tx_pause_quanta4),
    .ctl_tx_pause_quanta5                 (ctl_tx_pause_quanta5),
    .ctl_tx_pause_quanta6                 (ctl_tx_pause_quanta6),
    .ctl_tx_pause_quanta7                 (ctl_tx_pause_quanta7),
    .ctl_tx_pause_quanta8                 (ctl_tx_pause_quanta8),
    .ctl_tx_pause_refresh_timer0          (ctl_tx_pause_refresh_timer0),
    .ctl_tx_pause_refresh_timer1          (ctl_tx_pause_refresh_timer1),
    .ctl_tx_pause_refresh_timer2          (ctl_tx_pause_refresh_timer2),
    .ctl_tx_pause_refresh_timer3          (ctl_tx_pause_refresh_timer3),
    .ctl_tx_pause_refresh_timer4          (ctl_tx_pause_refresh_timer4),
    .ctl_tx_pause_refresh_timer5          (ctl_tx_pause_refresh_timer5),
    .ctl_tx_pause_refresh_timer6          (ctl_tx_pause_refresh_timer6),
    .ctl_tx_pause_refresh_timer7          (ctl_tx_pause_refresh_timer7),
    .ctl_tx_pause_refresh_timer8          (ctl_tx_pause_refresh_timer8),
    .ctl_tx_pause_req                     (ctl_tx_pause_req),
    .ctl_tx_resend_pause                  (ctl_tx_resend_pause),
    .tx_ovfout                            (tx_ovfout),
    .tx_rdyout                            (tx_rdyout),
    .tx_unfout                            (tx_unfout),
    .tx_datain0                           (tx_datain0),
    .tx_datain1                           (tx_datain1),
    .tx_datain2                           (tx_datain2),
    .tx_datain3                           (tx_datain3),
    .tx_enain0                            (tx_enain0),
    .tx_enain1                            (tx_enain1),
    .tx_enain2                            (tx_enain2),
    .tx_enain3                            (tx_enain3),
    .tx_eopin0                            (tx_eopin0),
    .tx_eopin1                            (tx_eopin1),
    .tx_eopin2                            (tx_eopin2),
    .tx_eopin3                            (tx_eopin3),
    .tx_errin0                            (tx_errin0),
    .tx_errin1                            (tx_errin1),
    .tx_errin2                            (tx_errin2),
    .tx_errin3                            (tx_errin3),
    .tx_mtyin0                            (tx_mtyin0),
    .tx_mtyin1                            (tx_mtyin1),
    .tx_mtyin2                            (tx_mtyin2),
    .tx_mtyin3                            (tx_mtyin3),
    .tx_sopin0                            (tx_sopin0),
    .tx_sopin1                            (tx_sopin1),
    .tx_sopin2                            (tx_sopin2),
    .tx_sopin3                            (tx_sopin3),
    .tx_preamblein                        (tx_preamblein),
    .usr_tx_reset                         (usr_tx_reset),


    .core_drp_reset                       (1'b0),
    .drp_clk                              (1'b0),
    .drp_addr                             (10'b0),
    .drp_di                               (16'b0),
    .drp_en                               (1'b0),
    .drp_do                               (),
    .drp_rdy                              (),
    .drp_we                               (1'b0)
);

cmac_usplus_0_pkt_gen_mon
#(
    .PKT_NUM                              (PKT_NUM),
    .PKT_SIZE                             (PKT_SIZE)
) i_cmac_usplus_0_pkt_gen_mon  
(
    .gen_mon_clk                          (txusrclk2),
    .usr_tx_reset                         (usr_tx_reset),
    .usr_rx_reset                         (usr_rx_reset),
    .sys_reset                            (sys_reset),
    .send_continuous_pkts                 (send_continuous_pkts),
    .lbus_tx_rx_restart_in                (lbus_tx_rx_restart_in),
    .tx_rdyout                            (tx_rdyout),
    .tx_datain0                           (tx_datain0),
    .tx_enain0                            (tx_enain0),
    .tx_sopin0                            (tx_sopin0),
    .tx_eopin0                            (tx_eopin0),
    .tx_errin0                            (tx_errin0),
    .tx_mtyin0                            (tx_mtyin0),
    .tx_datain1                           (tx_datain1),
    .tx_enain1                            (tx_enain1),
    .tx_sopin1                            (tx_sopin1),
    .tx_eopin1                            (tx_eopin1),
    .tx_errin1                            (tx_errin1),
    .tx_mtyin1                            (tx_mtyin1),
    .tx_datain2                           (tx_datain2),
    .tx_enain2                            (tx_enain2),
    .tx_sopin2                            (tx_sopin2),
    .tx_eopin2                            (tx_eopin2),
    .tx_errin2                            (tx_errin2),
    .tx_mtyin2                            (tx_mtyin2),
    .tx_datain3                           (tx_datain3),
    .tx_enain3                            (tx_enain3),
    .tx_sopin3                            (tx_sopin3),
    .tx_eopin3                            (tx_eopin3),
    .tx_errin3                            (tx_errin3),
    .tx_mtyin3                            (tx_mtyin3),
    .tx_ovfout                            (tx_ovfout),
    .tx_unfout                            (tx_unfout),
    .rx_dataout0                          (rx_dataout0),
    .rx_enaout0                           (rx_enaout0),
    .rx_sopout0                           (rx_sopout0),
    .rx_eopout0                           (rx_eopout0),
    .rx_errout0                           (rx_errout0),
    .rx_mtyout0                           (rx_mtyout0),
    .rx_dataout1                          (rx_dataout1),
    .rx_enaout1                           (rx_enaout1),
    .rx_sopout1                           (rx_sopout1),
    .rx_eopout1                           (rx_eopout1),
    .rx_errout1                           (rx_errout1),
    .rx_mtyout1                           (rx_mtyout1),
    .rx_dataout2                          (rx_dataout2),
    .rx_enaout2                           (rx_enaout2),
    .rx_sopout2                           (rx_sopout2),
    .rx_eopout2                           (rx_eopout2),
    .rx_errout2                           (rx_errout2),
    .rx_mtyout2                           (rx_mtyout2),
    .rx_dataout3                          (rx_dataout3),
    .rx_enaout3                           (rx_enaout3),
    .rx_sopout3                           (rx_sopout3),
    .rx_eopout3                           (rx_eopout3),
    .rx_errout3                           (rx_errout3),
    .rx_mtyout3                           (rx_mtyout3),
    .tx_preamblein                        (tx_preamblein),
    .rx_preambleout                       (rx_preambleout),
    .common0_drpaddr                      (common0_drpaddr),
    .common0_drpdi                        (common0_drpdi),
    .common0_drpwe                        (common0_drpwe),
    .common0_drpen                        (common0_drpen),
    .common0_drprdy                       (common0_drprdy),
    .common0_drpdo                        (common0_drpdo),
    .gt_eyescanreset                      (gt_eyescanreset),
    .gt_eyescantrigger                    (gt_eyescantrigger),
    .gt_rxcdrhold                         (gt_rxcdrhold),
    .gt_rxpolarity                        (gt_rxpolarity),
    .gt_rxrate                            (gt_rxrate),
    .gt_txdiffctrl                        (gt_txdiffctrl),
    .gt_txpolarity                        (gt_txpolarity),
    .gt_txinhibit                         (gt_txinhibit),
    .gt_txpostcursor                      (gt_txpostcursor),
    .gt_txprbsforceerr                    (gt_txprbsforceerr),
    .gt_txprecursor                       (gt_txprecursor),
    .gt_eyescandataerror                  (gt_eyescandataerror),
    .gt_txbufstatus                       (gt_txbufstatus),
    .gt_rxdfelpmreset                     (gt_rxdfelpmreset),
    .gt_rxlpmen                           (gt_rxlpmen),
    .gt_rxprbscntreset                    (gt_rxprbscntreset),
    .gt_rxprbserr                         (gt_rxprbserr),
    .gt_rxprbssel                         (gt_rxprbssel),
    .gt_rxresetdone                       (gt_rxresetdone),
    .gt_txprbssel                         (gt_txprbssel),
    .gt_txresetdone                       (gt_txresetdone),
    .gt_rxbufstatus                       (gt_rxbufstatus),
    .gt0_drpaddr                    (gt0_drpaddr),
    .gt0_drpen                      (gt0_drpen),
    .gt0_drpdi                      (gt0_drpdi),
    .gt0_drpdo                      (gt0_drpdo),
    .gt0_drprdy                     (gt0_drprdy),
    .gt0_drpwe                      (gt0_drpwe),
    .gt1_drpaddr                    (gt1_drpaddr),
    .gt1_drpen                      (gt1_drpen),
    .gt1_drpdi                      (gt1_drpdi),
    .gt1_drpdo                      (gt1_drpdo),
    .gt1_drprdy                     (gt1_drprdy),
    .gt1_drpwe                      (gt1_drpwe),
    .gt2_drpaddr                    (gt2_drpaddr),
    .gt2_drpen                      (gt2_drpen),
    .gt2_drpdi                      (gt2_drpdi),
    .gt2_drpdo                      (gt2_drpdo),
    .gt2_drprdy                     (gt2_drprdy),
    .gt2_drpwe                      (gt2_drpwe),
    .gt3_drpaddr                    (gt3_drpaddr),
    .gt3_drpen                      (gt3_drpen),
    .gt3_drpdi                      (gt3_drpdi),
    .gt3_drpdo                      (gt3_drpdo),
    .gt3_drprdy                     (gt3_drprdy),
    .gt3_drpwe                      (gt3_drpwe),
    .drp_clk                              (init_clk),
    .ctl_tx_enable                        (ctl_tx_enable),
    .stat_tx_pause_valid                  (stat_tx_pause_valid),
    .stat_tx_pause                        (stat_tx_pause),
    .stat_tx_user_pause                   (stat_tx_user_pause),
    .ctl_tx_pause_enable                  (ctl_tx_pause_enable),
    .ctl_tx_pause_quanta0                 (ctl_tx_pause_quanta0),
    .ctl_tx_pause_quanta1                 (ctl_tx_pause_quanta1),
    .ctl_tx_pause_quanta2                 (ctl_tx_pause_quanta2),
    .ctl_tx_pause_quanta3                 (ctl_tx_pause_quanta3),
    .ctl_tx_pause_quanta4                 (ctl_tx_pause_quanta4),
    .ctl_tx_pause_quanta5                 (ctl_tx_pause_quanta5),
    .ctl_tx_pause_quanta6                 (ctl_tx_pause_quanta6),
    .ctl_tx_pause_quanta7                 (ctl_tx_pause_quanta7),
    .ctl_tx_pause_quanta8                 (ctl_tx_pause_quanta8),
    .ctl_tx_pause_refresh_timer0          (ctl_tx_pause_refresh_timer0),
    .ctl_tx_pause_refresh_timer1          (ctl_tx_pause_refresh_timer1),
    .ctl_tx_pause_refresh_timer2          (ctl_tx_pause_refresh_timer2),
    .ctl_tx_pause_refresh_timer3          (ctl_tx_pause_refresh_timer3),
    .ctl_tx_pause_refresh_timer4          (ctl_tx_pause_refresh_timer4),
    .ctl_tx_pause_refresh_timer5          (ctl_tx_pause_refresh_timer5),
    .ctl_tx_pause_refresh_timer6          (ctl_tx_pause_refresh_timer6),
    .ctl_tx_pause_refresh_timer7          (ctl_tx_pause_refresh_timer7),
    .ctl_tx_pause_refresh_timer8          (ctl_tx_pause_refresh_timer8),
    .ctl_tx_pause_req                     (ctl_tx_pause_req),
    .ctl_tx_resend_pause                  (ctl_tx_resend_pause),
    .stat_rx_pause                        (stat_rx_pause),
    .stat_rx_pause_quanta0                (stat_rx_pause_quanta0),
    .stat_rx_pause_quanta1                (stat_rx_pause_quanta1),
    .stat_rx_pause_quanta2                (stat_rx_pause_quanta2),
    .stat_rx_pause_quanta3                (stat_rx_pause_quanta3),
    .stat_rx_pause_quanta4                (stat_rx_pause_quanta4),
    .stat_rx_pause_quanta5                (stat_rx_pause_quanta5),
    .stat_rx_pause_quanta6                (stat_rx_pause_quanta6),
    .stat_rx_pause_quanta7                (stat_rx_pause_quanta7),
    .stat_rx_pause_quanta8                (stat_rx_pause_quanta8),
    .stat_rx_pause_req                    (stat_rx_pause_req),
    .stat_rx_pause_valid                  (stat_rx_pause_valid),
    .stat_rx_user_pause                   (stat_rx_user_pause),
    .ctl_rx_check_etype_gcp               (ctl_rx_check_etype_gcp),
    .ctl_rx_check_etype_gpp               (ctl_rx_check_etype_gpp),
    .ctl_rx_check_etype_pcp               (ctl_rx_check_etype_pcp),
    .ctl_rx_check_etype_ppp               (ctl_rx_check_etype_ppp),
    .ctl_rx_check_mcast_gcp               (ctl_rx_check_mcast_gcp),
    .ctl_rx_check_mcast_gpp               (ctl_rx_check_mcast_gpp),
    .ctl_rx_check_mcast_pcp               (ctl_rx_check_mcast_pcp),
    .ctl_rx_check_mcast_ppp               (ctl_rx_check_mcast_ppp),
    .ctl_rx_check_opcode_gcp              (ctl_rx_check_opcode_gcp),
    .ctl_rx_check_opcode_gpp              (ctl_rx_check_opcode_gpp),
    .ctl_rx_check_opcode_pcp              (ctl_rx_check_opcode_pcp),
    .ctl_rx_check_opcode_ppp              (ctl_rx_check_opcode_ppp),
    .ctl_rx_check_sa_gcp                  (ctl_rx_check_sa_gcp),
    .ctl_rx_check_sa_gpp                  (ctl_rx_check_sa_gpp),
    .ctl_rx_check_sa_pcp                  (ctl_rx_check_sa_pcp),
    .ctl_rx_check_sa_ppp                  (ctl_rx_check_sa_ppp),
    .ctl_rx_check_ucast_gcp               (ctl_rx_check_ucast_gcp),
    .ctl_rx_check_ucast_gpp               (ctl_rx_check_ucast_gpp),
    .ctl_rx_check_ucast_pcp               (ctl_rx_check_ucast_pcp),
    .ctl_rx_check_ucast_ppp               (ctl_rx_check_ucast_ppp),
    .ctl_rx_enable_gcp                    (ctl_rx_enable_gcp),
    .ctl_rx_enable_gpp                    (ctl_rx_enable_gpp),
    .ctl_rx_enable_pcp                    (ctl_rx_enable_pcp),
    .ctl_rx_enable_ppp                    (ctl_rx_enable_ppp),
    .ctl_rx_pause_ack                     (ctl_rx_pause_ack),
    .ctl_rx_pause_enable                  (ctl_rx_pause_enable),
    .stat_rx_aligned_err                  (stat_rx_aligned_err),
    .stat_rx_bad_code                     (stat_rx_bad_code),
    .stat_rx_bad_fcs                      (stat_rx_bad_fcs),
    .stat_rx_bad_preamble                 (stat_rx_bad_preamble),
    .stat_rx_bad_sfd                      (stat_rx_bad_sfd),
    .stat_rx_bip_err_0                    (stat_rx_bip_err_0),
    .stat_rx_bip_err_1                    (stat_rx_bip_err_1),
    .stat_rx_bip_err_10                   (stat_rx_bip_err_10),
    .stat_rx_bip_err_11                   (stat_rx_bip_err_11),
    .stat_rx_bip_err_12                   (stat_rx_bip_err_12),
    .stat_rx_bip_err_13                   (stat_rx_bip_err_13),
    .stat_rx_bip_err_14                   (stat_rx_bip_err_14),
    .stat_rx_bip_err_15                   (stat_rx_bip_err_15),
    .stat_rx_bip_err_16                   (stat_rx_bip_err_16),
    .stat_rx_bip_err_17                   (stat_rx_bip_err_17),
    .stat_rx_bip_err_18                   (stat_rx_bip_err_18),
    .stat_rx_bip_err_19                   (stat_rx_bip_err_19),
    .stat_rx_bip_err_2                    (stat_rx_bip_err_2),
    .stat_rx_bip_err_3                    (stat_rx_bip_err_3),
    .stat_rx_bip_err_4                    (stat_rx_bip_err_4),
    .stat_rx_bip_err_5                    (stat_rx_bip_err_5),
    .stat_rx_bip_err_6                    (stat_rx_bip_err_6),
    .stat_rx_bip_err_7                    (stat_rx_bip_err_7),
    .stat_rx_bip_err_8                    (stat_rx_bip_err_8),
    .stat_rx_bip_err_9                    (stat_rx_bip_err_9),
    .stat_rx_block_lock                   (stat_rx_block_lock),
    .stat_rx_broadcast                    (stat_rx_broadcast),
    .stat_rx_fragment                     (stat_rx_fragment),
    .stat_rx_framing_err_0                (stat_rx_framing_err_0),
    .stat_rx_framing_err_1                (stat_rx_framing_err_1),
    .stat_rx_framing_err_10               (stat_rx_framing_err_10),
    .stat_rx_framing_err_11               (stat_rx_framing_err_11),
    .stat_rx_framing_err_12               (stat_rx_framing_err_12),
    .stat_rx_framing_err_13               (stat_rx_framing_err_13),
    .stat_rx_framing_err_14               (stat_rx_framing_err_14),
    .stat_rx_framing_err_15               (stat_rx_framing_err_15),
    .stat_rx_framing_err_16               (stat_rx_framing_err_16),
    .stat_rx_framing_err_17               (stat_rx_framing_err_17),
    .stat_rx_framing_err_18               (stat_rx_framing_err_18),
    .stat_rx_framing_err_19               (stat_rx_framing_err_19),
    .stat_rx_framing_err_2                (stat_rx_framing_err_2),
    .stat_rx_framing_err_3                (stat_rx_framing_err_3),
    .stat_rx_framing_err_4                (stat_rx_framing_err_4),
    .stat_rx_framing_err_5                (stat_rx_framing_err_5),
    .stat_rx_framing_err_6                (stat_rx_framing_err_6),
    .stat_rx_framing_err_7                (stat_rx_framing_err_7),
    .stat_rx_framing_err_8                (stat_rx_framing_err_8),
    .stat_rx_framing_err_9                (stat_rx_framing_err_9),
    .stat_rx_framing_err_valid_0          (stat_rx_framing_err_valid_0),
    .stat_rx_framing_err_valid_1          (stat_rx_framing_err_valid_1),
    .stat_rx_framing_err_valid_10         (stat_rx_framing_err_valid_10),
    .stat_rx_framing_err_valid_11         (stat_rx_framing_err_valid_11),
    .stat_rx_framing_err_valid_12         (stat_rx_framing_err_valid_12),
    .stat_rx_framing_err_valid_13         (stat_rx_framing_err_valid_13),
    .stat_rx_framing_err_valid_14         (stat_rx_framing_err_valid_14),
    .stat_rx_framing_err_valid_15         (stat_rx_framing_err_valid_15),
    .stat_rx_framing_err_valid_16         (stat_rx_framing_err_valid_16),
    .stat_rx_framing_err_valid_17         (stat_rx_framing_err_valid_17),
    .stat_rx_framing_err_valid_18         (stat_rx_framing_err_valid_18),
    .stat_rx_framing_err_valid_19         (stat_rx_framing_err_valid_19),
    .stat_rx_framing_err_valid_2          (stat_rx_framing_err_valid_2),
    .stat_rx_framing_err_valid_3          (stat_rx_framing_err_valid_3),
    .stat_rx_framing_err_valid_4          (stat_rx_framing_err_valid_4),
    .stat_rx_framing_err_valid_5          (stat_rx_framing_err_valid_5),
    .stat_rx_framing_err_valid_6          (stat_rx_framing_err_valid_6),
    .stat_rx_framing_err_valid_7          (stat_rx_framing_err_valid_7),
    .stat_rx_framing_err_valid_8          (stat_rx_framing_err_valid_8),
    .stat_rx_framing_err_valid_9          (stat_rx_framing_err_valid_9),
    .stat_rx_got_signal_os                (stat_rx_got_signal_os),
    .stat_rx_hi_ber                       (stat_rx_hi_ber),
    .stat_rx_inrangeerr                   (stat_rx_inrangeerr),
    .stat_rx_internal_local_fault         (stat_rx_internal_local_fault),
    .stat_rx_jabber                       (stat_rx_jabber),
    .stat_rx_local_fault                  (stat_rx_local_fault),
    .stat_rx_mf_err                       (stat_rx_mf_err),
    .stat_rx_mf_len_err                   (stat_rx_mf_len_err),
    .stat_rx_mf_repeat_err                (stat_rx_mf_repeat_err),
    .stat_rx_misaligned                   (stat_rx_misaligned),
    .stat_rx_multicast                    (stat_rx_multicast),
    .stat_rx_oversize                     (stat_rx_oversize),
    .stat_rx_packet_1024_1518_bytes       (stat_rx_packet_1024_1518_bytes),
    .stat_rx_packet_128_255_bytes         (stat_rx_packet_128_255_bytes),
    .stat_rx_packet_1519_1522_bytes       (stat_rx_packet_1519_1522_bytes),
    .stat_rx_packet_1523_1548_bytes       (stat_rx_packet_1523_1548_bytes),
    .stat_rx_packet_1549_2047_bytes       (stat_rx_packet_1549_2047_bytes),
    .stat_rx_packet_2048_4095_bytes       (stat_rx_packet_2048_4095_bytes),
    .stat_rx_packet_256_511_bytes         (stat_rx_packet_256_511_bytes),
    .stat_rx_packet_4096_8191_bytes       (stat_rx_packet_4096_8191_bytes),
    .stat_rx_packet_512_1023_bytes        (stat_rx_packet_512_1023_bytes),
    .stat_rx_packet_64_bytes              (stat_rx_packet_64_bytes),
    .stat_rx_packet_65_127_bytes          (stat_rx_packet_65_127_bytes),
    .stat_rx_packet_8192_9215_bytes       (stat_rx_packet_8192_9215_bytes),
    .stat_rx_packet_bad_fcs               (stat_rx_packet_bad_fcs),
    .stat_rx_packet_large                 (stat_rx_packet_large),
    .stat_rx_packet_small                 (stat_rx_packet_small),
    .stat_rx_received_local_fault         (stat_rx_received_local_fault),
    .stat_rx_remote_fault                 (stat_rx_remote_fault),
    .stat_rx_status                       (stat_rx_status),
    .stat_rx_stomped_fcs                  (stat_rx_stomped_fcs),
    .stat_rx_synced                       (stat_rx_synced),
    .stat_rx_synced_err                   (stat_rx_synced_err),
    .stat_rx_test_pattern_mismatch        (stat_rx_test_pattern_mismatch),
    .stat_rx_toolong                      (stat_rx_toolong),
    .stat_rx_total_bytes                  (stat_rx_total_bytes),
    .stat_rx_total_good_bytes             (stat_rx_total_good_bytes),
    .stat_rx_total_good_packets           (stat_rx_total_good_packets),
    .stat_rx_total_packets                (stat_rx_total_packets),
    .stat_rx_truncated                    (stat_rx_truncated),
    .stat_rx_undersize                    (stat_rx_undersize),
    .stat_rx_unicast                      (stat_rx_unicast),
    .stat_rx_vlan                         (stat_rx_vlan),
    .stat_rx_pcsl_demuxed                 (stat_rx_pcsl_demuxed),
    .stat_rx_pcsl_number_0                (stat_rx_pcsl_number_0),
    .stat_rx_pcsl_number_1                (stat_rx_pcsl_number_1),
    .stat_rx_pcsl_number_10               (stat_rx_pcsl_number_10),
    .stat_rx_pcsl_number_11               (stat_rx_pcsl_number_11),
    .stat_rx_pcsl_number_12               (stat_rx_pcsl_number_12),
    .stat_rx_pcsl_number_13               (stat_rx_pcsl_number_13),
    .stat_rx_pcsl_number_14               (stat_rx_pcsl_number_14),
    .stat_rx_pcsl_number_15               (stat_rx_pcsl_number_15),
    .stat_rx_pcsl_number_16               (stat_rx_pcsl_number_16),
    .stat_rx_pcsl_number_17               (stat_rx_pcsl_number_17),
    .stat_rx_pcsl_number_18               (stat_rx_pcsl_number_18),
    .stat_rx_pcsl_number_19               (stat_rx_pcsl_number_19),
    .stat_rx_pcsl_number_2                (stat_rx_pcsl_number_2),
    .stat_rx_pcsl_number_3                (stat_rx_pcsl_number_3),
    .stat_rx_pcsl_number_4                (stat_rx_pcsl_number_4),
    .stat_rx_pcsl_number_5                (stat_rx_pcsl_number_5),
    .stat_rx_pcsl_number_6                (stat_rx_pcsl_number_6),
    .stat_rx_pcsl_number_7                (stat_rx_pcsl_number_7),
    .stat_rx_pcsl_number_8                (stat_rx_pcsl_number_8),
    .stat_rx_pcsl_number_9                (stat_rx_pcsl_number_9),
    .stat_rx_rsfec_am_lock0               (stat_rx_rsfec_am_lock0),
    .stat_rx_rsfec_am_lock1               (stat_rx_rsfec_am_lock1),
    .stat_rx_rsfec_am_lock2               (stat_rx_rsfec_am_lock2),
    .stat_rx_rsfec_am_lock3               (stat_rx_rsfec_am_lock3),
    .stat_rx_rsfec_corrected_cw_inc       (stat_rx_rsfec_corrected_cw_inc),
    .stat_rx_rsfec_cw_inc                 (stat_rx_rsfec_cw_inc),
    .stat_rx_rsfec_err_count0_inc         (stat_rx_rsfec_err_count0_inc),
    .stat_rx_rsfec_err_count1_inc         (stat_rx_rsfec_err_count1_inc),
    .stat_rx_rsfec_err_count2_inc         (stat_rx_rsfec_err_count2_inc),
    .stat_rx_rsfec_err_count3_inc         (stat_rx_rsfec_err_count3_inc),
    .stat_rx_rsfec_hi_ser                 (stat_rx_rsfec_hi_ser),
    .stat_rx_rsfec_lane_alignment_status  (stat_rx_rsfec_lane_alignment_status),
    .stat_rx_rsfec_lane_fill_0            (stat_rx_rsfec_lane_fill_0),
    .stat_rx_rsfec_lane_fill_1            (stat_rx_rsfec_lane_fill_1),
    .stat_rx_rsfec_lane_fill_2            (stat_rx_rsfec_lane_fill_2),
    .stat_rx_rsfec_lane_fill_3            (stat_rx_rsfec_lane_fill_3),
    .stat_rx_rsfec_lane_mapping           (stat_rx_rsfec_lane_mapping),
    .stat_rx_rsfec_uncorrected_cw_inc     (stat_rx_rsfec_uncorrected_cw_inc),
    .stat_tx_bad_fcs                      (stat_tx_bad_fcs),
    .stat_rx_aligned                      (stat_rx_aligned),
    .stat_tx_broadcast                    (stat_tx_broadcast),
    .stat_tx_frame_error                  (stat_tx_frame_error),
    .stat_tx_local_fault                  (stat_tx_local_fault),
    .stat_tx_multicast                    (stat_tx_multicast),
    .stat_tx_packet_1024_1518_bytes       (stat_tx_packet_1024_1518_bytes),
    .stat_tx_packet_128_255_bytes         (stat_tx_packet_128_255_bytes),
    .stat_tx_packet_1519_1522_bytes       (stat_tx_packet_1519_1522_bytes),
    .stat_tx_packet_1523_1548_bytes       (stat_tx_packet_1523_1548_bytes),
    .stat_tx_packet_1549_2047_bytes       (stat_tx_packet_1549_2047_bytes),
    .stat_tx_packet_2048_4095_bytes       (stat_tx_packet_2048_4095_bytes),
    .stat_tx_packet_256_511_bytes         (stat_tx_packet_256_511_bytes),
    .stat_tx_packet_4096_8191_bytes       (stat_tx_packet_4096_8191_bytes),
    .stat_tx_packet_512_1023_bytes        (stat_tx_packet_512_1023_bytes),
    .stat_tx_packet_64_bytes              (stat_tx_packet_64_bytes),
    .stat_tx_packet_65_127_bytes          (stat_tx_packet_65_127_bytes),
    .stat_tx_packet_8192_9215_bytes       (stat_tx_packet_8192_9215_bytes),
    .stat_tx_packet_large                 (stat_tx_packet_large),
    .stat_tx_packet_small                 (stat_tx_packet_small),
    .stat_tx_total_bytes                  (stat_tx_total_bytes),
    .stat_tx_total_good_bytes             (stat_tx_total_good_bytes),
    .stat_tx_total_good_packets           (stat_tx_total_good_packets),
    .stat_tx_total_packets                (stat_tx_total_packets),
    .stat_tx_unicast                      (stat_tx_unicast),
    .stat_tx_vlan                         (stat_tx_vlan),
    .ctl_rx_enable                        (ctl_rx_enable),
    .ctl_rx_force_resync                  (ctl_rx_force_resync),
    .ctl_rx_test_pattern                  (ctl_rx_test_pattern),
    .ctl_tx_send_idle                     (ctl_tx_send_idle),
    .ctl_tx_send_rfi                      (ctl_tx_send_rfi),
    .ctl_tx_send_lfi                      (ctl_tx_send_lfi),
    .ctl_tx_test_pattern                  (ctl_tx_test_pattern),
    .ctl_rsfec_ieee_error_indication_mode (ctl_rsfec_ieee_error_indication_mode),
    .ctl_rx_rsfec_enable                  (ctl_rx_rsfec_enable),
    .ctl_rx_rsfec_enable_correction       (ctl_rx_rsfec_enable_correction),
    .ctl_rx_rsfec_enable_indication       (ctl_rx_rsfec_enable_indication),
    .ctl_tx_rsfec_enable                  (ctl_tx_rsfec_enable),
    .rx_reset                             (rx_reset),
    .tx_reset                             (tx_reset),
    .gt_rxrecclkout                       (gt_rxrecclkout),
    .tx_done_led                          (tx_done_led),
    .tx_busy_led                          (tx_busy_led),
    .rx_gt_locked_led                     (rx_gt_locked_led),
    .rx_aligned_led                       (rx_aligned_led),
    .rx_done_led                          (rx_done_led),
    .rx_data_fail_led                     (rx_data_fail_led),
    .rx_busy_led                          (rx_busy_led)
);



  assign ctl_tx_rsfec_enable_int = ctl_tx_rsfec_enable;
  assign ctl_rsfec_ieee_error_indication_mode_int = ctl_rsfec_ieee_error_indication_mode;
  assign ctl_rx_rsfec_enable_int = ctl_rx_rsfec_enable;
  assign ctl_rx_rsfec_enable_correction_int = ctl_rx_rsfec_enable_correction;
  assign ctl_rx_rsfec_enable_indication_int = ctl_rx_rsfec_enable_indication;

endmodule


