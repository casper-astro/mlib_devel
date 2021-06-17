`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2020 07:50:02 AM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module gty_12chan #(
    parameter N_REFCLOCKS = 3,
    parameter REFCLOCK_0 = 0,
    parameter REFCLOCK_1 = 1,
    parameter REFCLOCK_2 = 2,
    parameter INSTANCE_NUMBER = 0
  ) (
    input [11:0] rx_p,
    input [11:0] rx_n,
    input [11:0] induce_error,
    output [11:0] tx_p,
    output [11:0] tx_n,
    input [N_REFCLOCKS-1:0] mgtrefclk_p,
    input [N_REFCLOCKS-1:0] mgtrefclk_n,
    input clk50,
    input rst,
    input [11:0] gearbox_slip,
    
    output clkout,
    output [12*160 - 1 : 0] dout

    //output [63:0] status
    );
    
  wire clkout_a;
  wire clkout_b;

  wire [N_REFCLOCKS-1:0] mgtrefclk;

  reg [11:0] gearbox_slipR;
  wire [11:0] gearbox_slip_strobe = gearbox_slip & ~gearbox_slipR;
  reg gearbox_slip_strobeR;
  always @(posedge clkout) begin
    gearbox_slipR <= gearbox_slip;
    gearbox_slip_strobeR <= gearbox_slip_strobe;
  end
  
  IBUFDS_GTE4 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE4_MGTREFCLK[N_REFCLOCKS-1:0](
    .I     (mgtrefclk_p),
    .IB    (mgtrefclk_n),
    .CEB   (1'b0),
    .O     (mgtrefclk),
    .ODIV2 ()
  );

  wire [2:0] refclk_int;
  assign refclk_int[0] = mgtrefclk[REFCLOCK_0];
  assign refclk_int[1] = mgtrefclk[REFCLOCK_1];
  assign refclk_int[2] = mgtrefclk[REFCLOCK_2];
  
  (* mark_debug = "true" *) wire [63:0] status_int_a;
  (* mark_debug = "true" *) wire [63:0] status_int_b;
  
  (* mark_debug = "true" *) wire [160 - 1:0] dout_a0;
  (* mark_debug = "true" *) wire [160 - 1:0] dout_b0;
  (* mark_debug = "true" *) wire [160 - 1:0] dout_a1;
  (* mark_debug = "true" *) wire [160 - 1:0] dout_b1;
  (* mark_debug = "true" *) wire [160 - 1:0] dout_a2;
  (* mark_debug = "true" *) wire [160 - 1:0] dout_b2;
  (* mark_debug = "true" *) wire [160 - 1:0] dout_a3;
  (* mark_debug = "true" *) wire [160 - 1:0] dout_b3;
  
  wire [160 - 1:0] dout_c3;
  wire [160 - 1:0] dout_c2;
  wire [160 - 1:0] dout_c1;
  wire [160 - 1:0] dout_c0;

  assign clkout = clkout_a;
  wire txclkout_a;
  wire txclkout_b;


  reg [7:0] tx_a_ctr;
  always @(posedge txclkout_a) begin
    tx_a_ctr <= tx_a_ctr + 1'b1;
  end
  
  reg [7:0] tx_b_ctr;
  always @(posedge txclkout_b) begin
    tx_b_ctr <= tx_b_ctr - 1'b1;
  end
  
  reg [31:0] pps_ctr_reg = 32'b0;
  reg [31:0] pps_ctr_regR;
  reg ready = 1'b0;
  wire pps = pps_ctr_reg == 32'b0;
  always @(posedge clk50) begin
    pps_ctr_reg <= pps_ctr_reg == 49999999 ? 32'b0 : pps_ctr_reg + 1'b1;
    if (pps) begin
      pps_ctr_regR <= pps_ctr_reg;
      ready <= ~ready;
    end
  end
  
  (* async_reg = "true" *) reg ready_aR;
  (* async_reg = "true" *) reg ready_aRR;
  reg ready_aRRR;
  wire ready_a_strobe = ready_aRR != ready_aRRR;
  (* mark_debug = "true" *) reg [31:0] ctr_a;
  (* mark_debug = "true" *) reg [31:0] ctr_a_reg;
  always @(posedge clkout_a) begin
    ctr_a <= ctr_a + 1'b1;
  end
  
  (* async_reg = "true" *) reg ready_bR;
  (* async_reg = "true" *) reg ready_bRR;
  reg ready_bRRR;
  wire ready_b_strobe = ready_bRR != ready_bRRR;
  (* mark_debug = "true" *) reg [31:0] ctr_b;
  (* mark_debug = "true" *) reg [31:0] ctr_b_reg;
  always @(posedge clkout_b) begin
    ctr_b <= ctr_b + 1'b1;
  end
  

  wire [11:0] bitslip_signal = gearbox_slip_strobeR | gearbox_slip_strobe;

  case(INSTANCE_NUMBER)
    0 : begin
      gtwizard_dts_gtyx12_0 dty_gty_inst (
        .gtwiz_userclk_tx_reset_in(1'b0),              // input wire [0 : 0] gtwiz_userclk_tx_reset_in
        .gtwiz_userclk_tx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_srcclk_out
        .gtwiz_userclk_tx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_usrclk_out
        .gtwiz_userclk_tx_usrclk2_out(txclkout_a),     // output wire [0 : 0] gtwiz_userclk_tx_usrclk2_out
        .gtwiz_userclk_tx_active_out(),                // output wire [0 : 0] gtwiz_userclk_tx_active_out
        .gtwiz_userclk_rx_reset_in(1'b0),              // input wire [0 : 0] gtwiz_userclk_rx_reset_in
        .gtwiz_userclk_rx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_srcclk_out
        .gtwiz_userclk_rx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_usrclk_out
        .gtwiz_userclk_rx_usrclk2_out(clkout_a),       // output wire [0 : 0] gtwiz_userclk_rx_usrclk2_out
        .gtwiz_userclk_rx_active_out(status_int_a[0]), // output wire [0 : 0] gtwiz_userclk_rx_active_out
        .gtwiz_reset_clk_freerun_in(clk50),            // input wire [0 : 0] gtwiz_reset_clk_freerun_in
        .gtwiz_reset_all_in(rst),                      // input wire [0 : 0] gtwiz_reset_all_in
        .gtwiz_reset_tx_pll_and_datapath_in(1'b0),     // input wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in
        .gtwiz_reset_tx_datapath_in(1'b0),             // input wire [0 : 0] gtwiz_reset_tx_datapath_in
        .gtwiz_reset_rx_pll_and_datapath_in(1'b0),     // input wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in
        .gtwiz_reset_rx_datapath_in(1'b0),             // input wire [0 : 0] gtwiz_reset_rx_datapath_in
        .gtwiz_reset_rx_cdr_stable_out(status_int_a[1]),  // output wire [0 : 0] gtwiz_reset_rx_cdr_stable_out
        .gtwiz_reset_tx_done_out(status_int_a[2]),        // output wire [0 : 0] gtwiz_reset_tx_done_out
        .gtwiz_reset_rx_done_out(status_int_a[3]),        // output wire [0 : 0] gtwiz_reset_rx_done_out
        .gtwiz_userdata_tx_in(1920'b0),                   // input wire [1919 : 0] gtwiz_userdata_tx_in
        .gtwiz_userdata_rx_out({dout_c3, dout_c2, dout_c1, dout_c0, dout_b3, dout_b2, dout_b1, dout_b0, dout_a3, dout_a2, dout_a1, dout_a0}), // output wire [1919 : 0] gtwiz_userdata_rx_out
        .gtrefclk00_in(refclk_int),                       // input wire [2 : 0] gtrefclk00_in
        .qpll0outclk_out(),                               // output wire [2 : 0] qpll0outclk_out
        .qpll0outrefclk_out(),                            // output wire [2 : 0] qpll0outrefclk_out
        .gtyrxn_in(rx_n[11:0]),                           // input wire [11 : 0] gtyrxn_in
        .gtyrxp_in(rx_p[11:0]),                           // input wire [11 : 0] gtyrxp_in
        .rxslide_in(bitslip_signal),                      // input wire [11 : 0] rxgearboxslip_in
        .txpd_in({23{1'b1}}),                             // input wire [23 : 0] txpd_in
        .gtpowergood_out(status_int_a[12+4-1:4]),         // output wire [11 : 0] gtpowergood_out
        .gtytxn_out(tx_n[11:0]),                          // output wire [11 : 0] gtytxn_out
        .gtytxp_out(tx_p[11:0]),                          // output wire [11 : 0] gtytxp_out
        .rxcdrlock_out(status_int_a[12+24-1:24]),         // output wire [11 : 0] rxcdrlock_out
        .rxpmaresetdone_out(status_int_a[12+36-1:36]),    // output wire [11 : 0] rxpmaresetdone_out
        .txpmaresetdone_out(status_int_a[12+48-1:48])     // output wire [11 : 0] txpmaresetdone_out
      );
    end
    1 : begin
      gtwizard_dts_gtyx12_1 dty_gty_inst (
        .gtwiz_userclk_tx_reset_in(1'b0),              // input wire [0 : 0] gtwiz_userclk_tx_reset_in
        .gtwiz_userclk_tx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_srcclk_out
        .gtwiz_userclk_tx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_usrclk_out
        .gtwiz_userclk_tx_usrclk2_out(txclkout_a),     // output wire [0 : 0] gtwiz_userclk_tx_usrclk2_out
        .gtwiz_userclk_tx_active_out(),                // output wire [0 : 0] gtwiz_userclk_tx_active_out
        .gtwiz_userclk_rx_reset_in(1'b0),              // input wire [0 : 0] gtwiz_userclk_rx_reset_in
        .gtwiz_userclk_rx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_srcclk_out
        .gtwiz_userclk_rx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_usrclk_out
        .gtwiz_userclk_rx_usrclk2_out(clkout_a),       // output wire [0 : 0] gtwiz_userclk_rx_usrclk2_out
        .gtwiz_userclk_rx_active_out(status_int_a[0]), // output wire [0 : 0] gtwiz_userclk_rx_active_out
        .gtwiz_reset_clk_freerun_in(clk50),            // input wire [0 : 0] gtwiz_reset_clk_freerun_in
        .gtwiz_reset_all_in(rst),                      // input wire [0 : 0] gtwiz_reset_all_in
        .gtwiz_reset_tx_pll_and_datapath_in(1'b0),     // input wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in
        .gtwiz_reset_tx_datapath_in(1'b0),             // input wire [0 : 0] gtwiz_reset_tx_datapath_in
        .gtwiz_reset_rx_pll_and_datapath_in(1'b0),     // input wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in
        .gtwiz_reset_rx_datapath_in(1'b0),             // input wire [0 : 0] gtwiz_reset_rx_datapath_in
        .gtwiz_reset_rx_cdr_stable_out(status_int_a[1]),  // output wire [0 : 0] gtwiz_reset_rx_cdr_stable_out
        .gtwiz_reset_tx_done_out(status_int_a[2]),        // output wire [0 : 0] gtwiz_reset_tx_done_out
        .gtwiz_reset_rx_done_out(status_int_a[3]),        // output wire [0 : 0] gtwiz_reset_rx_done_out
        .gtwiz_userdata_tx_in(1920'b0),                   // input wire [1919 : 0] gtwiz_userdata_tx_in
        .gtwiz_userdata_rx_out({dout_c3, dout_c2, dout_c1, dout_c0, dout_b3, dout_b2, dout_b1, dout_b0, dout_a3, dout_a2, dout_a1, dout_a0}), // output wire [1919 : 0] gtwiz_userdata_rx_out
        .gtrefclk00_in(refclk_int),                       // input wire [2 : 0] gtrefclk00_in
        .qpll0outclk_out(),                               // output wire [2 : 0] qpll0outclk_out
        .qpll0outrefclk_out(),                            // output wire [2 : 0] qpll0outrefclk_out
        .gtyrxn_in(rx_n[11:0]),                           // input wire [11 : 0] gtyrxn_in
        .gtyrxp_in(rx_p[11:0]),                           // input wire [11 : 0] gtyrxp_in
        .rxslide_in(bitslip_signal),                      // input wire [11 : 0] rxgearboxslip_in
        .txpd_in({23{1'b1}}),                             // input wire [23 : 0] txpd_in
        .gtpowergood_out(status_int_a[12+4-1:4]),         // output wire [11 : 0] gtpowergood_out
        .gtytxn_out(tx_n[11:0]),                          // output wire [11 : 0] gtytxn_out
        .gtytxp_out(tx_p[11:0]),                          // output wire [11 : 0] gtytxp_out
        .rxcdrlock_out(status_int_a[12+24-1:24]),         // output wire [11 : 0] rxcdrlock_out
        .rxpmaresetdone_out(status_int_a[12+36-1:36]),    // output wire [11 : 0] rxpmaresetdone_out
        .txpmaresetdone_out(status_int_a[12+48-1:48])     // output wire [11 : 0] txpmaresetdone_out
      );
    end
  endcase


// Bit cludgy
wire [159:0] douta0_reverse;
wire [159:0] douta1_reverse;
wire [159:0] douta2_reverse;
wire [159:0] douta3_reverse;
wire [159:0] doutb0_reverse;
wire [159:0] doutb1_reverse;
wire [159:0] doutb2_reverse;
wire [159:0] doutb3_reverse;
wire [159:0] doutc0_reverse;
wire [159:0] doutc1_reverse;
wire [159:0] doutc2_reverse;
wire [159:0] doutc3_reverse;

wire [159:0] douta0_err;
wire [159:0] douta1_err;
wire [159:0] douta2_err;
wire [159:0] douta3_err;
wire [159:0] doutb0_err;
wire [159:0] doutb1_err;
wire [159:0] doutb2_err;
wire [159:0] doutb3_err;
wire [159:0] doutc0_err;
wire [159:0] doutc1_err;
wire [159:0] doutc2_err;
wire [159:0] doutc3_err;

assign douta0_err = induce_error[0] ?  {dout_a0[159:30], ~dout_a0[29], dout_a0[28:0]} : dout_a0;
assign douta1_err = induce_error[1] ?  {dout_a1[159:30], ~dout_a1[29], dout_a1[28:0]} : dout_a1;
assign douta2_err = induce_error[2] ?  {dout_a2[159:30], ~dout_a2[29], dout_a2[28:0]} : dout_a2;
assign douta3_err = induce_error[3] ?  {dout_a3[159:30], ~dout_a3[29], dout_a3[28:0]} : dout_a3;
assign doutb0_err = induce_error[4] ?  {dout_b0[159:30], ~dout_b0[29], dout_b0[28:0]} : dout_b0;
assign doutb1_err = induce_error[5] ?  {dout_b1[159:30], ~dout_b1[29], dout_b1[28:0]} : dout_b1;
assign doutb2_err = induce_error[6] ?  {dout_b2[159:30], ~dout_b2[29], dout_b2[28:0]} : dout_b2;
assign doutb3_err = induce_error[7] ?  {dout_b3[159:30], ~dout_b3[29], dout_b3[28:0]} : dout_b3;
assign doutc0_err = induce_error[8] ?  {dout_c0[159:30], ~dout_c0[29], dout_c0[28:0]} : dout_c0;
assign doutc1_err = induce_error[9] ?  {dout_c1[159:30], ~dout_c1[29], dout_c1[28:0]} : dout_c1;
assign doutc2_err = induce_error[10] ? {dout_c2[159:30], ~dout_c2[29], dout_c2[28:0]} : dout_c2;
assign doutc3_err = induce_error[11] ? {dout_c3[159:30], ~dout_c3[29], dout_c3[28:0]} : dout_c3;

generate
for (genvar i=0; i<160; i=i+1) begin
  assign douta0_reverse[i] = douta0_err[159-i];
  assign douta1_reverse[i] = douta1_err[159-i];
  assign douta2_reverse[i] = douta2_err[159-i];
  assign douta3_reverse[i] = douta3_err[159-i];
  assign doutb0_reverse[i] = doutb0_err[159-i];
  assign doutb1_reverse[i] = doutb1_err[159-i];
  assign doutb2_reverse[i] = doutb2_err[159-i];
  assign doutb3_reverse[i] = doutb3_err[159-i];
  assign doutc0_reverse[i] = doutc0_err[159-i];
  assign doutc1_reverse[i] = doutc1_err[159-i];
  assign doutc2_reverse[i] = doutc2_err[159-i];
  assign doutc3_reverse[i] = doutc3_err[159-i];
end
endgenerate

assign dout = {doutc3_reverse, doutc2_reverse, doutc1_reverse, doutc0_reverse,
               doutb3_reverse, doutb2_reverse, doutb1_reverse, doutb0_reverse,
               douta3_reverse, douta2_reverse, douta1_reverse, douta0_reverse};
               
assign clkout = clkout_a;

endmodule
