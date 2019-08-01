 
 
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

module cmac_usplus_0_lbus_pkt_gen
   (
    input  wire            clk,
    input  wire            reset,
    input  wire            sys_reset,

    input  wire            stat_rx_aligned,
    input  wire            lbus_tx_rx_restart_in,
    output wire            ctl_tx_enable,
    output wire            ctl_tx_send_idle,
    output wire            ctl_tx_send_lfi,
    output wire            ctl_tx_send_rfi,
    output wire            ctl_tx_test_pattern,
    output wire            ctl_tx_rsfec_enable,
    output wire            tx_reset,                                       //// Used to Reset the CMAC TX Core
    input  wire [3 :0]     gt_rxrecclkout,
    output reg             tx_done_led,
    output reg             tx_busy_led,
    input  wire            stat_tx_pause,
    input  wire [8:0]      stat_tx_pause_valid,
    input  wire            stat_tx_user_pause,
    output wire [8:0]      ctl_tx_pause_enable,
    output wire [15:0]     ctl_tx_pause_quanta0,
    output wire [15:0]     ctl_tx_pause_quanta1,
    output wire [15:0]     ctl_tx_pause_quanta2,
    output wire [15:0]     ctl_tx_pause_quanta3,
    output wire [15:0]     ctl_tx_pause_quanta4,
    output wire [15:0]     ctl_tx_pause_quanta5,
    output wire [15:0]     ctl_tx_pause_quanta6,
    output wire [15:0]     ctl_tx_pause_quanta7,
    output wire [15:0]     ctl_tx_pause_quanta8,
    output wire [15:0]     ctl_tx_pause_refresh_timer0,
    output wire [15:0]     ctl_tx_pause_refresh_timer1,
    output wire [15:0]     ctl_tx_pause_refresh_timer2,
    output wire [15:0]     ctl_tx_pause_refresh_timer3,
    output wire [15:0]     ctl_tx_pause_refresh_timer4,
    output wire [15:0]     ctl_tx_pause_refresh_timer5,
    output wire [15:0]     ctl_tx_pause_refresh_timer6,
    output wire [15:0]     ctl_tx_pause_refresh_timer7,
    output wire [15:0]     ctl_tx_pause_refresh_timer8,
    output wire [8:0]      ctl_tx_pause_req,
    output wire            ctl_tx_resend_pause,
    input  wire            stat_tx_bad_fcs,
    input  wire            stat_tx_broadcast,
    input  wire            stat_tx_frame_error,
    input  wire            stat_tx_local_fault,
    input  wire            stat_tx_multicast,
    input  wire            stat_tx_packet_1024_1518_bytes,
    input  wire            stat_tx_packet_128_255_bytes,
    input  wire            stat_tx_packet_1519_1522_bytes,
    input  wire            stat_tx_packet_1523_1548_bytes,
    input  wire            stat_tx_packet_1549_2047_bytes,
    input  wire            stat_tx_packet_2048_4095_bytes,
    input  wire            stat_tx_packet_256_511_bytes,
    input  wire            stat_tx_packet_4096_8191_bytes,
    input  wire            stat_tx_packet_512_1023_bytes,
    input  wire            stat_tx_packet_64_bytes,
    input  wire            stat_tx_packet_65_127_bytes,
    input  wire            stat_tx_packet_8192_9215_bytes,
    input  wire            stat_tx_packet_large,
    input  wire            stat_tx_packet_small,
    input  wire [5:0]      stat_tx_total_bytes,
    input  wire [13:0]     stat_tx_total_good_bytes,
    input  wire            stat_tx_total_good_packets,
    input  wire            stat_tx_total_packets,
    input  wire            stat_tx_unicast,
    input  wire            stat_tx_vlan,
    input  wire [511:0]    data_link_input,

    output wire [55:0]     tx_preamblein,
    input  wire            tx_rdyout,
    output reg  [128-1:0]  tx_datain0,
    output reg             tx_enain0,
    output reg             tx_sopin0,
    output reg             tx_eopin0,
    output reg             tx_errin0,
    output reg  [4-1:0]    tx_mtyin0,
    output reg  [128-1:0]  tx_datain1,
    output reg             tx_enain1,
    output reg             tx_sopin1,
    output reg             tx_eopin1,
    output reg             tx_errin1,
    output reg  [4-1:0]    tx_mtyin1,
    output reg  [128-1:0]  tx_datain2,
    output reg             tx_enain2,
    output reg             tx_sopin2,
    output reg             tx_eopin2,
    output reg             tx_errin2,
    output reg  [4-1:0]    tx_mtyin2,
    output reg  [128-1:0]  tx_datain3,
    output reg             tx_enain3,
    output reg             tx_sopin3,
    output reg             tx_eopin3,
    output reg             tx_errin3,
    output reg  [4-1:0]    tx_mtyin3,
                           
    input  wire            tx_ovfout,
    input  wire            tx_unfout

    );

    //// Parameters Decleration
    localparam TX_FLOW_CONTROL           = 1;

    //// pkt_gen States
    localparam STATE_TX_IDLE             = 0;
    localparam STATE_GT_LOCKED           = 1;
    localparam STATE_WAIT_RX_ALIGNED     = 2;
    localparam STATE_PKT_TRANSFER_INIT   = 3;
    localparam STATE_LBUS_TX_ENABLE      = 4;
    localparam STATE_LBUS_TX_HALT        = 5;
    localparam STATE_LBUS_TX_DONE        = 6;
    localparam STATE_TX_PAUSE_INIT       = 7; 
    localparam STATE_TX_PPP_INIT         = 8;
    localparam STATE_TX_PAUSE_DONE       = 9;
    localparam STATE_WAIT_FOR_RESTART    = 10;

    ////State Registers for TX
    reg  [3:0]     tx_prestate;

    reg  [15:0]    number_pkt_tx, lbus_number_pkt_proc;
    reg  [13:0]    lbus_pkt_size_proc;
    reg  [13:0]    pending_pkt_size;
    reg            tx_restart_rise_edge, first_pkt, pkt_size_64, tx_fsm_en, tx_halt, wait_to_restart;
    reg            tx_done_tmp, tx_done_reg, tx_done_reg_d, tx_fail_reg;
    reg            tx_rdyout_d, tx_ovfout_d, tx_unfout_d;
    reg            tx_restart_1d, tx_restart_2d, tx_restart_3d, tx_restart_4d;

    reg            segment0_eop, segment1_eop, segment2_eop, segment3_eop;
    reg            nxt_enain0, nxt_sopin0, nxt_eopin0, nxt_errin0;
    reg            nxt_enain1, nxt_sopin1, nxt_eopin1, nxt_errin1;
    reg            nxt_enain2, nxt_sopin2, nxt_eopin2, nxt_errin2;
    reg            nxt_enain3, nxt_sopin3, nxt_eopin3, nxt_errin3;
    reg  [ 4-1:0]  nxt_mtyin0, nxt_mtyin1, nxt_mtyin2, nxt_mtyin3;
    reg  [ 7:0]    tx_payload_1, tx_payload_2, tx_payload_new;

    reg  [128-1:0] First_part, Second_part, Third_part, Forth_part;
    reg  [128-1:0] nxt_datain0, nxt_datain1, nxt_datain2, nxt_datain3;

    reg            stat_rx_aligned_1d, reset_done;
    reg            ctl_tx_send_lfi_r;
    reg            ctl_tx_enable_r, ctl_tx_send_idle_r, ctl_tx_send_rfi_r, ctl_tx_test_pattern_r;
    reg            init_done,init_cntr_en;
    reg            gt_lock_led, rx_aligned_led, tx_done, tx_fail, tx_core_busy_led;
    reg            tx_gt_locked_led_1d, tx_done_led_1d, tx_core_busy_led_1d;
    reg            tx_gt_locked_led_2d, tx_done_led_2d, tx_core_busy_led_2d;
    reg            tx_gt_locked_led_3d, tx_done_led_3d, tx_core_busy_led_3d;
    reg  [8:0]     init_cntr;
    reg            ctl_tx_rsfec_enable_r;

    ////internal register declation for pause signals
    reg            ctl_tx_resend_pause_r; 
    reg  [8:0]     ctl_tx_pause_req_r; 
    reg  [8:0]     ctl_tx_pause_enable_r; 
    reg  [15:0]    ctl_tx_pause_quanta0_r;
    reg  [15:0]    ctl_tx_pause_quanta1_r;
    reg  [15:0]    ctl_tx_pause_quanta2_r;
    reg  [15:0]    ctl_tx_pause_quanta3_r;
    reg  [15:0]    ctl_tx_pause_quanta4_r;
    reg  [15:0]    ctl_tx_pause_quanta5_r;
    reg  [15:0]    ctl_tx_pause_quanta6_r;
    reg  [15:0]    ctl_tx_pause_quanta7_r;
    reg  [15:0]    ctl_tx_pause_quanta8_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer0_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer1_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer2_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer3_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer4_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer5_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer6_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer7_r;
    reg  [15:0]    ctl_tx_pause_refresh_timer8_r;

    reg  [8:0]     stat_tx_pause_valid_r;
    reg            stat_tx_pause_r;
    reg            stat_tx_user_pause_r;
    reg            pause_done_led;
    reg  [4:0]     ppp_req_cntr;
    reg            send_continuous_pkts_1d, send_continuous_pkts_2d, send_continuous_pkts_3d;

    ////----------------------------------------TX Module -----------------------//
    //////////////////////////////////////////////////
    ////registering input signal generation
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            stat_rx_aligned_1d     <= 1'b0;
            reset_done             <= 1'b0;
            tx_rdyout_d            <= 1'b0;
            tx_ovfout_d            <= 1'b0;
            tx_unfout_d            <= 1'b0;
            tx_restart_1d          <= 1'b0;
            tx_restart_2d          <= 1'b0;
            tx_restart_3d          <= 1'b0;
            tx_restart_4d          <= 1'b0;
            

        end
        else
        begin
            stat_rx_aligned_1d     <= stat_rx_aligned;
            reset_done             <= 1'b1;
            tx_rdyout_d            <= tx_rdyout;
            tx_ovfout_d            <= tx_ovfout;
            tx_unfout_d            <= tx_unfout;
            tx_restart_1d          <= lbus_tx_rx_restart_in;
            tx_restart_2d          <= tx_restart_1d;
            tx_restart_3d          <= tx_restart_2d;
            tx_restart_4d          <= tx_restart_3d;

        end
    end

    //////////////////////////////////////////////////
    ////generating the tx_restart_rise_edge signal 
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if  ( reset == 1'b1 )
             tx_restart_rise_edge   <= 1'b0;
        else
        begin
            if  (( tx_restart_3d == 1'b1) && ( tx_restart_4d == 1'b0))
                tx_restart_rise_edge  <= 1'b1;
            else 
                tx_restart_rise_edge  <= 1'b0;
        end
    end

    //////////////////////////////////////////////////
    ////State Machine 
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            tx_prestate                       <= STATE_TX_IDLE;
            tx_halt                           <= 1'b0;
            nxt_enain0                        <= 1'b0;
            nxt_sopin0                        <= 1'b0;
            nxt_eopin0                        <= 1'b0;
            nxt_errin0                        <= 1'b0;
            nxt_enain1                        <= 1'b0;
            nxt_sopin1                        <= 1'b0;
            nxt_eopin1                        <= 1'b0;
            nxt_errin1                        <= 1'b0;
            nxt_enain2                        <= 1'b0;
            nxt_sopin2                        <= 1'b0;
            nxt_eopin2                        <= 1'b0;
            nxt_errin2                        <= 1'b0;
            nxt_enain3                        <= 1'b0;
            nxt_sopin3                        <= 1'b0;
            nxt_eopin3                        <= 1'b0;
            nxt_errin3                        <= 1'b0;
            nxt_mtyin0                        <= 4'd0;
            nxt_mtyin1                        <= 4'd0;
            nxt_mtyin2                        <= 4'd0;
            nxt_mtyin3                        <= 4'd0;
            nxt_datain0                       <= 128'd0;
            nxt_datain1                       <= 128'd0;
            nxt_datain2                       <= 128'd0;
            nxt_datain3                       <= 128'd0;
            pending_pkt_size                  <= 16'd0;
            tx_done_reg                       <= 1'b0;
            tx_done_tmp                       <= 1'b0;
            tx_done_reg_d                     <= 1'b0;
            tx_fsm_en                         <= 1'b0;
            tx_payload_1                      <= 8'd0;
            tx_payload_2                      <= 8'd0;
            tx_payload_new                    <= 8'd0;
            number_pkt_tx                     <= 16'd0;
            lbus_number_pkt_proc              <= 16'd0;
            lbus_pkt_size_proc                <= 14'd0;
            segment0_eop                      <= 1'b0;
            segment1_eop                      <= 1'b0;
            segment2_eop                      <= 1'b0;
            segment3_eop                      <= 1'b0;
            first_pkt                         <= 1'b0;
            pkt_size_64                       <= 1'd0;
            tx_fail_reg                       <= 1'b0;
            ctl_tx_enable_r                   <= 1'b0;
            ctl_tx_send_idle_r                <= 1'b0;
            ctl_tx_send_lfi_r                 <= 1'b0;
            ctl_tx_send_rfi_r                 <= 1'b0;
            ctl_tx_test_pattern_r             <= 1'b0;
            init_done                         <= 1'b0;
            gt_lock_led                       <= 1'b0;
            rx_aligned_led                    <= 1'b0;
            tx_core_busy_led                  <= 1'b0;
            wait_to_restart                   <= 1'b0;
            init_cntr_en                      <= 1'b0;
            pause_done_led                    <= 1'b0;
            ctl_tx_resend_pause_r             <= 1'b0;
            ctl_tx_pause_req_r                <= 9'h0;
            ctl_tx_pause_enable_r             <= 9'h0;
            ctl_tx_pause_quanta0_r            <= 16'h0;
            ctl_tx_pause_quanta1_r            <= 16'h0;
            ctl_tx_pause_quanta2_r            <= 16'h0;
            ctl_tx_pause_quanta3_r            <= 16'h0;
            ctl_tx_pause_quanta4_r            <= 16'h0;
            ctl_tx_pause_quanta5_r            <= 16'h0;
            ctl_tx_pause_quanta6_r            <= 16'h0;
            ctl_tx_pause_quanta7_r            <= 16'h0;
            ctl_tx_pause_quanta8_r            <= 16'h0;
            ctl_tx_pause_refresh_timer0_r     <= 16'h0;
            ctl_tx_pause_refresh_timer1_r     <= 16'h0;
            ctl_tx_pause_refresh_timer2_r     <= 16'h0;
            ctl_tx_pause_refresh_timer3_r     <= 16'h0;
            ctl_tx_pause_refresh_timer4_r     <= 16'h0;
            ctl_tx_pause_refresh_timer5_r     <= 16'h0;
            ctl_tx_pause_refresh_timer6_r     <= 16'h0;
            ctl_tx_pause_refresh_timer7_r     <= 16'h0;
            ctl_tx_pause_refresh_timer8_r     <= 16'h0;
            ppp_req_cntr                      <= 5'h0;
            ctl_tx_rsfec_enable_r             <= 1'b0;
        end
        else
        begin
        case (tx_prestate)
            STATE_TX_IDLE            :
                                     begin
                                         ctl_tx_enable_r        <= 1'b0;
                                         ctl_tx_send_idle_r     <= 1'b0;
                                         ctl_tx_send_lfi_r      <= 1'b0;
                                         ctl_tx_send_rfi_r      <= 1'b0;
                                         ctl_tx_test_pattern_r  <= 1'b0;
                                         lbus_pkt_size_proc     <= 14'd0;
                                         number_pkt_tx          <= 16'd0;
                                         lbus_number_pkt_proc   <= 16'd0;
                                         init_done              <= 1'b0;
                                         gt_lock_led            <= 1'b0;
                                         rx_aligned_led         <= 1'b0;
                                         tx_core_busy_led       <= 1'b0;
                                         tx_halt                <= 1'b0;
                                         tx_fail_reg            <= 1'b0;
                                         nxt_enain0             <= 1'b0;
                                         nxt_sopin0             <= 1'b0;
                                         nxt_eopin0             <= 1'b0;
                                         nxt_errin0             <= 1'b0;
                                         nxt_enain1             <= 1'b0;
                                         nxt_sopin1             <= 1'b0;
                                         nxt_eopin1             <= 1'b0;
                                         nxt_errin1             <= 1'b0;
                                         nxt_enain2             <= 1'b0;
                                         nxt_sopin2             <= 1'b0;
                                         nxt_eopin2             <= 1'b0;
                                         nxt_errin2             <= 1'b0;
                                         nxt_enain3             <= 1'b0;
                                         nxt_sopin3             <= 1'b0;
                                         nxt_eopin3             <= 1'b0;
                                         nxt_errin3             <= 1'b0;
                                         nxt_mtyin0             <= 4'd0;
                                         nxt_mtyin1             <= 4'd0;
                                         nxt_mtyin2             <= 4'd0;
                                         nxt_mtyin3             <= 4'd0;
                                         nxt_datain0            <= 128'd0;
                                         nxt_datain1            <= 128'd0;
                                         nxt_datain2            <= 128'd0;
                                         nxt_datain3            <= 128'd0;
                                         tx_fsm_en              <= 1'b0;
                                         segment0_eop           <= 1'b0;
                                         segment1_eop           <= 1'b0;
                                         segment2_eop           <= 1'b0;
                                         segment3_eop           <= 1'b0;
                                         tx_done_reg            <= 1'd0;
                                         tx_done_tmp            <= 1'd0;
                                         tx_done_reg_d          <= 1'b0;
                                         wait_to_restart        <= 1'b0;
                                         init_cntr_en           <= 1'b0;
                                         pause_done_led         <= 1'b0;
                                         ppp_req_cntr           <= 5'h0;
                                         ctl_tx_rsfec_enable_r  <= 1'b0;

                                         //// State transition
                                         if  (reset_done == 1'b1)
                                             tx_prestate <= STATE_GT_LOCKED;
                                         else
                                             tx_prestate <= STATE_TX_IDLE;
                                     end
            STATE_GT_LOCKED          :
                                     begin
                                         gt_lock_led            <= 1'b1;
                                         rx_aligned_led         <= 1'b0;
                                         ctl_tx_enable_r        <= 1'b0;
                                         ctl_tx_send_idle_r     <= 1'b0;
                                         ctl_tx_send_lfi_r      <= 1'b1;
                                         ctl_tx_send_rfi_r      <= 1'b1;
                                         tx_core_busy_led       <= 1'b0;
                                         ctl_tx_rsfec_enable_r  <= 1'b1;

                                         //// State transition
                                         tx_prestate <= STATE_WAIT_RX_ALIGNED;
                                     end
            STATE_WAIT_RX_ALIGNED    :
                                      begin
                                         wait_to_restart        <= 1'b0;
                                         init_cntr_en           <= 1'b0;
                                         init_done              <= 1'b0;
                                         rx_aligned_led         <= 1'b0;
                                         tx_core_busy_led       <= 1'b0;

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b1)
                                         begin
                                            $display("INFO : RS-FEC IS ENABLED");
                                             tx_prestate <= STATE_PKT_TRANSFER_INIT;
                                         end
                                         else
                                             tx_prestate <= STATE_WAIT_RX_ALIGNED;
                                     end
            STATE_PKT_TRANSFER_INIT  : 
                                     begin
                                         wait_to_restart        <= 1'b0;
                                         init_cntr_en           <= 1'b1;
                                         init_done              <= init_cntr[4];
                                         gt_lock_led            <= 1'b1;
                                         rx_aligned_led         <= 1'b1;
                                         tx_core_busy_led       <= 1'b1;
                                         pause_done_led         <= 1'b0;
                                         ppp_req_cntr           <= 5'h0;
                                         ctl_tx_send_idle_r     <= 1'b0;
                                         ctl_tx_send_lfi_r      <= 1'b0;
                                         ctl_tx_send_rfi_r      <= 1'b0;
                                         ctl_tx_enable_r        <= 1'b1;
                                         tx_fsm_en              <= 1'b0;
                                         number_pkt_tx          <= 16'd0;
                                         //lbus_number___pkt_proc   <= PKT_NUM - 16'd1;
                                         lbus_pkt_size_proc     <= 64;
                                         segment0_eop           <= 1'b0;
                                         segment1_eop           <= 1'b0;
                                         segment2_eop           <= 1'b0;
                                         segment3_eop           <= 1'b0;
                                         tx_done_reg            <= 1'd0;
                                         tx_done_tmp            <= 1'd0;
                                         tx_done_reg_d          <= 1'b0;
                                         tx_payload_1           <= 8'd6;
                                         tx_payload_2           <= tx_payload_1 + 8'd1;
                                         tx_payload_new         <= tx_payload_1 + 8'd2;
                                         
                                         {First_part, Second_part , Third_part , Forth_part } <= data_link_input;
                                         
                                         //First_part             <= {32'h248a0791, 32'h68840000,32'h00010000,32'h08004500};
                                         //Second_part            <= {32'h00320000, 32'h4000ff11,32'h63700a02,32'h02320a02};
                                         //Third_part             <= {32'h02150fa0, 32'h9c40001e,32'h94115765,32'h6c636f6d};
                                         //Forth_part             <= {32'h65204472, 32'h2e20526f,32'h67657273,32'h00000000};
                                         //:

                                         //First_part             <= data_link_input[511
                                         //First_part             <= {32'hAAAAAAAA, 32'hAAAAAAAB,32'h248A0791,32'h6884CCCC};
                                         ///Second_part            <= {32'hCCCCCCCC, 32'h08004500,32'h00260000,32'h40008011};
                                         ///Third_part             <= {32'hE27C0A02, 32'h02320A02,32'h02150FA0,32'h9C40001E};
                                         //Forth_part             <= {32'h00000000, 32'h00000000,32'h11000000,32'hC704DD7B};
                                         //ETH2: 24:8a:07:91:68:84
                                         
                                         //First_part             <= {32'h45000200, 32'h00004000,32'h8011E0A2,32'h0A020232};
                                         //Second_part            <= {32'h0A020215, 32'h0FA09C40,32'h002C0000,32'h00000000};
                                         //Third_part             <= {32'h00000000, 32'h00000000,32'h00000000,32'h00000000};
                                         //Forth_part             <= {32'h00000000, 32'h00000000,32'h11000000,32'h11000000};
                                         
                                         //payload_16byte         <= {tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                         //                           tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                         //                           tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                         //                           tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1 };                                         
                                         //payload_16byte_new     <= {tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2,
                                         //                           tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2,
                                         //                           tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2,
                                         //                           tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2 };
                                         
                                         /*payload_16byte         <= {tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                                                    tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                                                    tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                                                    tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1 };                                         
                                         payload_16byte_new     <= {tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2,
                                                                    tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2,
                                                                    tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2,
                                                                    tx_payload_2, tx_payload_2, tx_payload_2, tx_payload_2 };
                                                                    */
                                         pending_pkt_size       <= lbus_pkt_size_proc;

                                         if (lbus_pkt_size_proc == 14'd64)
                                         begin
                                             first_pkt      <= 1'b0;
                                             pkt_size_64    <= 1'd1;
                                         end
                                    

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0) 
                                             tx_prestate <= STATE_TX_IDLE;
                                         else if  ((init_done == 1'b1) && (tx_rdyout_d == 1'b1) && 
                                                   (tx_ovfout_d == 1'b0) && (tx_unfout_d == 1'b0))
                                         begin
                                             if (send_continuous_pkts_3d == 1'b0)
                                             begin
                                                 $display( "           Number of data packets to be transmitted   = %d, each of packet size  = %dBytes, Total bytes: PKT_NUM * (PKT_SIZE + 4[CRC])  = %dBytes", PKT_NUM, PKT_SIZE, PKT_NUM * (PKT_SIZE + 4)); //// packet size = PKT_SIZE + 4[CRC]
                                                 $display( "           Number of pause packets to be transmitted  = %d, each of packet size  = %dBytes, Total bytes: 11 * 64                        = %dBytes", 11, 64, 704);                                 //// 11 * 64 total bytes 
                                             end
                                             if (send_continuous_pkts_3d == 1'b1) begin
                                                 $display( "INFO : Stream continuous packet mode is enabled..."); end
                                             tx_prestate <= STATE_LBUS_TX_ENABLE;
                                         end
                                         else 
                                             tx_prestate <= STATE_PKT_TRANSFER_INIT;
                                     end
            STATE_LBUS_TX_ENABLE     :
                                     begin
                                         init_cntr_en    <= 1'b0;
                                         init_done       <= 1'b0;
                                         tx_halt         <= 1'b0;
                                         /*if (pending_pkt_size <= 14'd64 || pkt_size_64 == 1'b1)
                                         begin
                                             payload_16byte   <= payload_16byte_new;

                                             if ( tx_payload_new == 8'd255)
                                             begin
                                                 tx_payload_new      <= 8'd6;
                                                 payload_16byte_new  <= {tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                                                         tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                                                         tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1,
                                                                         tx_payload_1, tx_payload_1, tx_payload_1, tx_payload_1 };                                         
                                             end
                                             else
                                             begin
                                                 tx_payload_new      <=  tx_payload_new + 8'd1;
                                                 payload_16byte_new  <= {tx_payload_new, tx_payload_new, tx_payload_new, tx_payload_new,
                                                                         tx_payload_new, tx_payload_new, tx_payload_new, tx_payload_new,
                                                                         tx_payload_new, tx_payload_new, tx_payload_new, tx_payload_new,
                                                                         tx_payload_new, tx_payload_new, tx_payload_new, tx_payload_new };
                                             end

                                         end*/
                                         
                                         if (tx_done_reg == 1'b1)
                                         begin
                                             nxt_enain0     <= 1'b0;
                                             nxt_enain1     <= 1'b0;
                                             nxt_enain2     <= 1'b0;
                                             nxt_enain3     <= 1'b0;
                                             nxt_sopin0     <= 1'b0;
                                             nxt_sopin1     <= 1'b0;
                                             nxt_sopin2     <= 1'b0;
                                             nxt_sopin3     <= 1'b0;
                                             nxt_eopin0     <= 1'b0;
                                             nxt_eopin1     <= 1'b0;
                                             nxt_eopin2     <= 1'b0;
                                             nxt_eopin3     <= 1'b0;
                                         end
                                         ////Packet size 64 Byte
                                         else if (pkt_size_64 == 1'b1)
                                         begin
                                             first_pkt      <= 1'b0;
                                             nxt_sopin0     <= 1'b1;
                                             nxt_enain0     <= 1'b1;
                                             nxt_eopin0     <= 1'b0;
                                             nxt_datain0    <= First_part;
                                             nxt_mtyin0     <= 4'd0;

                                             nxt_sopin1     <= 1'b0;
                                             nxt_enain1     <= 1'b1;
                                             nxt_eopin1     <= 1'b0;
                                             nxt_datain1    <= Second_part;
                                             nxt_mtyin1     <= 4'd0;

                                             nxt_sopin2     <= 1'b0;
                                             nxt_enain2     <= 1'b1;
                                             nxt_eopin2     <= 1'b0;
                                             nxt_datain2    <= Third_part;
                                             nxt_mtyin2     <= 4'd0;

                                             nxt_sopin3     <= 1'b0;
                                             nxt_enain3     <= 1'b1;
                                             nxt_eopin3     <= 1'b1;
                                             nxt_datain3    <= Forth_part;
                                             nxt_mtyin3     <= 4'd0;
                                             number_pkt_tx  <= number_pkt_tx + 16'd1;
                                             tx_done_reg    <= tx_done_tmp & ~send_continuous_pkts_3d;
                                         end
                                         
                                         if (number_pkt_tx == lbus_number_pkt_proc)
                                             tx_done_tmp      <= 1'b1;

                                         if (tx_done_reg== 1'b1)
                                             tx_fsm_en <= 1'b0;
                                         else
                                             tx_fsm_en <= 1'b1;

                                         if (send_continuous_pkts_2d == 1'b0 && send_continuous_pkts_3d == 1'b1) begin
                                             $display( "INFO : Stream continuous packet mode disabled"); end

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0) 
                                             tx_prestate <= STATE_TX_IDLE;
                                         else if (tx_done_reg == 1'b1)
                                             tx_prestate <= STATE_LBUS_TX_DONE;
                                         else if ((tx_rdyout_d == 1'b0) || (tx_ovfout_d == 1'b1) || (tx_unfout_d == 1'b1))
                                             tx_prestate <= STATE_LBUS_TX_HALT;
                                         else
                                             tx_prestate <= STATE_LBUS_TX_ENABLE;
                                     end
            STATE_LBUS_TX_HALT       :
                                     begin
                                         tx_halt <= 1'b1;
                                         if  ((tx_ovfout_d == 1'b1) || (tx_unfout_d == 1'b1))
                                             tx_fail_reg <= 1'b1;

                                         if (send_continuous_pkts_2d == 1'b0 && send_continuous_pkts_3d == 1'b1) begin
                                             $display( "INFO : Stream continuous packet mode disabled"); end

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0) 
                                             tx_prestate <= STATE_TX_IDLE;
                                         else if ((tx_rdyout_d == 1'b1) && (tx_ovfout_d == 1'b0) && (tx_unfout_d == 1'b0))
                                             tx_prestate <= STATE_LBUS_TX_ENABLE;
                                         else if ((tx_ovfout_d == 1'b1) || (tx_unfout_d == 1'b1))
                                             tx_prestate <= STATE_LBUS_TX_DONE;
                                         else
                                             tx_prestate <= STATE_LBUS_TX_HALT;
                                     end
            STATE_LBUS_TX_DONE       :
                                     begin
                                         init_cntr_en           <= 1'b0;
                                         wait_to_restart        <= 1'b0;
                                         tx_halt                <= 1'b0;
                                         tx_done_reg_d          <= 1'b1;
                                         tx_fsm_en              <= 1'b0;
                                         tx_fail_reg            <= 1'b0;
                                         first_pkt              <= 1'b0;
                                         pkt_size_64            <= 1'd0;
                                         nxt_enain0             <= 1'b0;
                                         nxt_sopin0             <= 1'b0;
                                         nxt_eopin0             <= 1'b0;
                                         nxt_errin0             <= 1'b0;
                                         nxt_enain1             <= 1'b0;
                                         nxt_sopin1             <= 1'b0;
                                         nxt_eopin1             <= 1'b0;
                                         nxt_errin1             <= 1'b0;
                                         nxt_enain2             <= 1'b0;
                                         nxt_sopin2             <= 1'b0;
                                         nxt_eopin2             <= 1'b0;
                                         nxt_errin2             <= 1'b0;
                                         nxt_enain3             <= 1'b0;
                                         nxt_sopin3             <= 1'b0;
                                         nxt_eopin3             <= 1'b0;
                                         nxt_errin3             <= 1'b0;
                                         nxt_mtyin0             <= 4'd0;
                                         nxt_mtyin1             <= 4'd0;
                                         nxt_mtyin2             <= 4'd0;
                                         nxt_mtyin3             <= 4'd0;
                                         nxt_datain0            <= 128'd0;
                                         nxt_datain1            <= 128'd0;
                                         nxt_datain2            <= 128'd0;
                                         nxt_datain3            <= 128'd0;

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0) 
                                             tx_prestate <= STATE_TX_IDLE;
                                         else if  (TX_FLOW_CONTROL == 1'b1)
                                             tx_prestate <= STATE_TX_PAUSE_INIT;
                                         else
                                             tx_prestate <= STATE_WAIT_FOR_RESTART;
                                     end
           STATE_TX_PAUSE_INIT      :
                                    begin
                                         init_cntr_en                    <= 1'b1;
                                         init_done                       <= init_cntr[8];
                                         tx_done_reg_d                   <= 1'b0;
                                         ctl_tx_pause_enable_r           <= 9'h100;
                                         ctl_tx_pause_quanta8_r          <= 16'hffff;
                                         ctl_tx_pause_refresh_timer8_r   <= 16'hffff;

                                         if (init_done == 1'b1)
                                             ctl_tx_pause_req_r          <= 9'h100;

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0) 
                                             tx_prestate <= STATE_TX_IDLE;
                                         else if  (stat_tx_pause_r == 1'b1)
                                             tx_prestate <= STATE_TX_PPP_INIT;
                                         else
                                             tx_prestate <= STATE_TX_PAUSE_INIT;
                                   end
            STATE_TX_PPP_INIT      :
                                   begin
                                         init_cntr_en                    <= 1'b1;
                                         init_done                       <= 1'b0;
                                         tx_done_reg_d                   <= 1'b0;
                                         ppp_req_cntr                    <= ppp_req_cntr +1;
                                         ctl_tx_pause_enable_r           <= 9'h0ff;
                                         ctl_tx_pause_quanta0_r          <= 16'hffff;
                                         ctl_tx_pause_quanta1_r          <= 16'hffff;
                                         ctl_tx_pause_quanta2_r          <= 16'hffff;
                                         ctl_tx_pause_quanta3_r          <= 16'hffff;
                                         ctl_tx_pause_quanta4_r          <= 16'hffff;
                                         ctl_tx_pause_quanta5_r          <= 16'hffff;
                                         ctl_tx_pause_quanta6_r          <= 16'hffff;
                                         ctl_tx_pause_quanta7_r          <= 16'hffff;
                                         ctl_tx_pause_refresh_timer0_r   <= 16'hffff;
                                         ctl_tx_pause_refresh_timer1_r   <= 16'hffff;
                                         ctl_tx_pause_refresh_timer2_r   <= 16'hffff;
                                         ctl_tx_pause_refresh_timer3_r   <= 16'hffff;
                                         ctl_tx_pause_refresh_timer4_r   <= 16'hffff;
                                         ctl_tx_pause_refresh_timer5_r   <= 16'hffff;
                                         ctl_tx_pause_refresh_timer6_r   <= 16'hffff;
                                         ctl_tx_pause_refresh_timer7_r   <= 16'hffff;
                                         if (ppp_req_cntr == 5'h1f)
                                             ctl_tx_pause_req_r        <=  ctl_tx_pause_req_r>>1 ;

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0) 
                                             tx_prestate <= STATE_TX_IDLE;
                                         else if  (stat_tx_pause_valid_r[0] == 1'b1)
                                             tx_prestate <=  STATE_TX_PAUSE_DONE;
                                         else
                                             tx_prestate <= STATE_TX_PPP_INIT;
                                    end
           STATE_TX_PAUSE_DONE      :
                                    begin
                                         pause_done_led                  <= 1'b1;
                                         init_done                       <= 1'b0;
                                         ctl_tx_pause_enable_r           <= 9'h0;
                                         ctl_tx_pause_req_r              <= 9'h0;
                                         ppp_req_cntr                    <= 5'h0;
                                        
                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0) 
                                             tx_prestate <= STATE_TX_IDLE;
                                         else
                                             tx_prestate <= STATE_WAIT_FOR_RESTART;
                                    end

            STATE_WAIT_FOR_RESTART   : 
                                    begin
                                         tx_core_busy_led                <= 1'b0;
                                         init_cntr_en                    <= 1'b0;
                                         wait_to_restart                 <= 1'b1;
                                         init_done                       <= 1'b0;
                                         tx_done_reg_d                   <= 1'b0;

                                         //// State transition
                                         if  (stat_rx_aligned_1d == 1'b0)
                                             tx_prestate <= STATE_TX_IDLE;
                                         else if (tx_restart_rise_edge == 1'b1)
                                             tx_prestate <= STATE_PKT_TRANSFER_INIT;
                                         else 
                                             tx_prestate <= STATE_WAIT_FOR_RESTART;
                                     end
            default                  :
                                     begin
                                         init_cntr_en                    <= 1'b0;
                                         wait_to_restart                 <= 1'b0;
                                         ctl_tx_enable_r                 <= 1'b0;
                                         ctl_tx_send_idle_r              <= 1'b0;
                                         ctl_tx_send_lfi_r               <= 1'b0;
                                         ctl_tx_send_rfi_r               <= 1'b0;
                                         ctl_tx_test_pattern_r           <= 1'b0;
                                         tx_payload_1                    <= 8'd0;
                                         tx_payload_2                    <= 8'd0;
                                         tx_payload_new                  <= 8'd0;
                                         lbus_pkt_size_proc              <= 14'd0;
                                         number_pkt_tx                   <= 16'd0;
                                         lbus_number_pkt_proc            <= 16'd0;
                                         init_done                       <= 1'b0;
                                         gt_lock_led                     <= 1'b0;
                                         rx_aligned_led                  <= 1'b0;
                                         tx_core_busy_led                <= 1'b0;
                                         first_pkt                       <= 1'b0;
                                         pkt_size_64                     <= 1'd0;
                                         tx_fsm_en                       <= 1'b0;
                                         tx_halt                         <= 1'b0;
                                         tx_fail_reg                     <= 1'b0;
                                         nxt_enain0                      <= 1'b0;
                                         nxt_sopin0                      <= 1'b0;
                                         nxt_eopin0                      <= 1'b0;
                                         nxt_errin0                      <= 1'b0;
                                         nxt_enain1                      <= 1'b0;
                                         nxt_sopin1                      <= 1'b0;
                                         nxt_eopin1                      <= 1'b0;
                                         nxt_errin1                      <= 1'b0;
                                         nxt_enain2                      <= 1'b0;
                                         nxt_sopin2                      <= 1'b0;
                                         nxt_eopin2                      <= 1'b0;
                                         nxt_errin2                      <= 1'b0;
                                         nxt_enain3                      <= 1'b0;
                                         nxt_sopin3                      <= 1'b0;
                                         nxt_eopin3                      <= 1'b0;
                                         nxt_errin3                      <= 1'b0;
                                         nxt_mtyin0                      <= 4'd0;
                                         nxt_mtyin1                      <= 4'd0;
                                         nxt_mtyin2                      <= 4'd0;
                                         nxt_mtyin3                      <= 4'd0;
                                         nxt_datain0                     <= 128'd0;
                                         nxt_datain1                     <= 128'd0;
                                         nxt_datain2                     <= 128'd0;
                                         nxt_datain3                     <= 128'd0;
                                         tx_done_reg                     <= 1'b0;
                                         tx_done_tmp                     <= 1'b0;
                                         segment0_eop                    <= 1'b0;
                                         segment1_eop                    <= 1'b0;
                                         segment2_eop                    <= 1'b0;
                                         segment3_eop                    <= 1'b0;
                                         //payload_16byte                  <= 128'd0;
                                         pause_done_led                  <= 1'b0;
                                         ctl_tx_pause_enable_r           <= 9'h0;
                                         ctl_tx_pause_quanta8_r          <= 16'h0;
                                         ctl_tx_pause_refresh_timer8_r   <= 16'h0;
                                         ctl_tx_pause_quanta0_r          <= 16'h0;
                                         ctl_tx_pause_quanta1_r          <= 16'h0;
                                         ctl_tx_pause_quanta2_r          <= 16'h0;
                                         ctl_tx_pause_quanta3_r          <= 16'h0;
                                         ctl_tx_pause_quanta4_r          <= 16'h0;
                                         ctl_tx_pause_quanta5_r          <= 16'h0;
                                         ctl_tx_pause_quanta6_r          <= 16'h0;
                                         ctl_tx_pause_quanta7_r          <= 16'h0;
                                         ctl_tx_pause_refresh_timer0_r   <= 16'h0;
                                         ctl_tx_pause_refresh_timer1_r   <= 16'h0;
                                         ctl_tx_pause_refresh_timer2_r   <= 16'h0;
                                         ctl_tx_pause_refresh_timer3_r   <= 16'h0;
                                         ctl_tx_pause_refresh_timer4_r   <= 16'h0;
                                         ctl_tx_pause_refresh_timer5_r   <= 16'h0;
                                         ctl_tx_pause_refresh_timer6_r   <= 16'h0;
                                         ctl_tx_pause_refresh_timer7_r   <= 16'h0;
                                         ctl_tx_pause_req_r              <= 9'h0;
                                         ppp_req_cntr                    <= 5'h0; 
                                         ctl_tx_rsfec_enable_r           <= 1'b0;
                                         tx_prestate                     <= STATE_TX_IDLE;
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
            send_continuous_pkts_1d     <= 1'b1;
            send_continuous_pkts_2d     <= 1'b1;
            send_continuous_pkts_3d     <= 1'b1;
        end
    end

    //////////////////////////////////////////////////
    ////tx_done signal generation
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
            tx_done <= 1'b0;
        else
        begin
            if ((tx_restart_rise_edge == 1'b1) && (wait_to_restart == 1'b1))
                tx_done <= 1'b0;
            else if  (tx_done_reg_d == 1'b1)
                tx_done <= 1'b1;
        end
    end    

    //////////////////////////////////////////////////
    ////tx_fail signal generation
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
            tx_fail <= 1'b0;
        else
        begin
            if  ((tx_restart_rise_edge == 1'b1) && (wait_to_restart == 1'b1))
                tx_fail <= 1'b0;
            else if  (tx_fail_reg == 1'b1)
                tx_fail <= 1'b1;
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
     
    //////////////////////////////////////////////////
    ////Assign LBUS TX Output ports
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            tx_datain0 <= 0;
            tx_enain0  <= 0;
            tx_sopin0  <= 0;
            tx_eopin0  <= 0;
            tx_errin0  <= 0;
            tx_mtyin0  <= 0;
            tx_datain1 <= 0;
            tx_enain1  <= 0;
            tx_sopin1  <= 0;
            tx_eopin1  <= 0;
            tx_errin1  <= 0;
            tx_mtyin1  <= 0;
            tx_datain2 <= 0;
            tx_enain2  <= 0;
            tx_sopin2  <= 0;
            tx_eopin2  <= 0;
            tx_errin2  <= 0;
            tx_mtyin2  <= 0;
            tx_datain3 <= 0;
            tx_enain3  <= 0;
            tx_sopin3  <= 0;
            tx_eopin3  <= 0;
            tx_errin3  <= 0;
            tx_mtyin3  <= 0;
        end
        else
        begin
            if ((tx_halt == 1'b0) && (tx_fsm_en == 1'b1))
            begin
                tx_datain0 <= nxt_datain0;
                tx_enain0  <= nxt_enain0;
                tx_sopin0  <= nxt_sopin0;
                tx_eopin0  <= nxt_eopin0;
                tx_errin0  <= nxt_errin0;
                tx_mtyin0  <= nxt_mtyin0;

                tx_datain1 <= nxt_datain1;
                tx_enain1  <= nxt_enain1;
                tx_sopin1  <= nxt_sopin1;
                tx_eopin1  <= nxt_eopin1;
                tx_errin1  <= nxt_errin1;
                tx_mtyin1  <= nxt_mtyin1;

                tx_datain2 <= nxt_datain2;
                tx_enain2  <= nxt_enain2;
                tx_sopin2  <= nxt_sopin2;
                tx_eopin2  <= nxt_eopin2;
                tx_errin2  <= nxt_errin2;
                tx_mtyin2  <= nxt_mtyin2;

                tx_datain3 <= nxt_datain3;
                tx_enain3  <= nxt_enain3;
                tx_sopin3  <= nxt_sopin3;
                tx_eopin3  <= nxt_eopin3;
                tx_errin3  <= nxt_errin3;
                tx_mtyin3  <= nxt_mtyin3;
            end
            else
            begin
                tx_enain0  <= 1'b0;
                tx_enain1  <= 1'b0;
                tx_enain2  <= 1'b0;
                tx_enain3  <= 1'b0;
                tx_sopin0  <= 1'b0;
                tx_sopin1  <= 1'b0;
                tx_sopin2  <= 1'b0;
                tx_sopin3  <= 1'b0;
                tx_eopin0  <= 1'b0;
                tx_eopin1  <= 1'b0;
                tx_eopin2  <= 1'b0;
                tx_eopin3  <= 1'b0;
            end
        end
    end

    //////////////////////////////////////////////////
    ////Assign TX LED Output ports with ASYN sys_reset
    //////////////////////////////////////////////////
    always @( posedge clk, posedge sys_reset )
    begin
        if ( sys_reset == 1'b1 )
        begin
            tx_done_led          <= 1'b0;
            tx_busy_led          <= 1'b0;
        end
        else
        begin
            tx_done_led          <= tx_done_led_3d;
            tx_busy_led          <= tx_core_busy_led_3d;
        end
    end

    //////////////////////////////////////////////////
    ////Registerting pause input signals
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            stat_tx_pause_valid_r  <= 8'd0;  
            stat_tx_pause_r        <= 1'b0;
            stat_tx_user_pause_r   <= 1'b0;
        end
        else
        begin
            stat_tx_pause_valid_r  <= stat_tx_pause_valid;  
            stat_tx_pause_r        <= stat_tx_pause;
            stat_tx_user_pause_r   <= stat_tx_user_pause;
        end
    end

    //////////////////////////////////////////////////
    ////Registering the LED ports
    //////////////////////////////////////////////////
    always @( posedge clk )
    begin
        if ( reset == 1'b1 )
        begin
            tx_gt_locked_led_1d     <= 1'b0;
            tx_gt_locked_led_2d     <= 1'b0;
            tx_gt_locked_led_3d     <= 1'b0;
            tx_done_led_1d          <= 1'b0;
            tx_done_led_2d          <= 1'b0;
            tx_done_led_3d          <= 1'b0;
            tx_core_busy_led_1d     <= 1'b0;
            tx_core_busy_led_2d     <= 1'b0;
            tx_core_busy_led_3d     <= 1'b0;
        end
        else
        begin
            tx_gt_locked_led_1d     <= gt_lock_led;
            tx_gt_locked_led_2d     <= tx_gt_locked_led_1d;
            tx_gt_locked_led_3d     <= tx_gt_locked_led_2d;
            tx_done_led_1d          <= tx_done;
            tx_done_led_2d          <= tx_done_led_1d;
            tx_done_led_3d          <= tx_done_led_2d;
            tx_core_busy_led_1d     <= tx_core_busy_led;
            tx_core_busy_led_2d     <= tx_core_busy_led_1d;
            tx_core_busy_led_3d     <= tx_core_busy_led_2d;
        end
    end



assign tx_preamblein                = 56'd0;     //// tx_preamblein is driven as 0

assign ctl_tx_enable                = ctl_tx_enable_r;
assign ctl_tx_send_idle             = ctl_tx_send_idle_r;
assign ctl_tx_send_lfi              = ctl_tx_send_lfi_r;
assign ctl_tx_send_rfi              = ctl_tx_send_rfi_r;
assign ctl_tx_test_pattern          = ctl_tx_test_pattern_r;
assign ctl_tx_rsfec_enable          = ctl_tx_rsfec_enable_r;
assign ctl_tx_pause_enable          = ctl_tx_pause_enable_r;
assign ctl_tx_pause_quanta0         = ctl_tx_pause_quanta0_r;
assign ctl_tx_pause_quanta1         = ctl_tx_pause_quanta1_r;
assign ctl_tx_pause_quanta2         = ctl_tx_pause_quanta2_r;
assign ctl_tx_pause_quanta3         = ctl_tx_pause_quanta3_r;
assign ctl_tx_pause_quanta4         = ctl_tx_pause_quanta4_r;
assign ctl_tx_pause_quanta5         = ctl_tx_pause_quanta5_r;
assign ctl_tx_pause_quanta6         = ctl_tx_pause_quanta6_r;
assign ctl_tx_pause_quanta7         = ctl_tx_pause_quanta7_r;
assign ctl_tx_pause_quanta8         = ctl_tx_pause_quanta8_r;
assign ctl_tx_pause_refresh_timer0  = ctl_tx_pause_refresh_timer0_r;
assign ctl_tx_pause_refresh_timer1  = ctl_tx_pause_refresh_timer1_r;
assign ctl_tx_pause_refresh_timer2  = ctl_tx_pause_refresh_timer2_r;
assign ctl_tx_pause_refresh_timer3  = ctl_tx_pause_refresh_timer3_r;
assign ctl_tx_pause_refresh_timer4  = ctl_tx_pause_refresh_timer4_r;
assign ctl_tx_pause_refresh_timer5  = ctl_tx_pause_refresh_timer5_r;
assign ctl_tx_pause_refresh_timer6  = ctl_tx_pause_refresh_timer6_r;
assign ctl_tx_pause_refresh_timer7  = ctl_tx_pause_refresh_timer7_r;
assign ctl_tx_pause_refresh_timer8  = ctl_tx_pause_refresh_timer8_r;
assign ctl_tx_pause_req             = ctl_tx_pause_req_r;
assign ctl_tx_resend_pause          = ctl_tx_resend_pause_r;
assign tx_reset                     = 1'b0;                          //// Used to Reset the CMAC TX Core
 
    ////----------------------------------------END TX Module-----------------------//

endmodule



