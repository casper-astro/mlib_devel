`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/24/2019 03:16:57 PM
// Design Name: 
// Module Name: gty_wrapper_0
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


module gty_wrapper_0(
    input refclk_p,
    input refclk_n,
    input clk100,
    input gtwiz_reset_all_in,
    input [1:0] chan_sel,
    input [3:0] gtyrxp_in,
    input [3:0] gtyrxn_in,
    input rx_polarity,
    input gearbox_slip,
    input rxslide,
    output [63:0] gtyrx_dout0,
    output [63:0] gtyrx_dout1,
    output [63:0] gtyrx_dout2,
    output [63:0] gtyrx_dout3,
    output [3:0] rxprbserr,
    output [3:0] rxprbslocked,
    output [3:0] rx_dav,
    output [3:0] gt_powergood, 
    output [3:0] rx_pmareset_done,
    output gtwiz_reset_rx_done,
    output [3:0] gtwiz_reset_rx_cdr_stable_out,
    output [3:0]  gtwiz_userclk_rx_active_out,
    output clkout,
    output test_out
    );

wire gty_refclk;
wire gty_refclk_int;
   IBUFDS_GTE4 #(
      .REFCLK_EN_TX_PATH(1'b0),   // Refer to Transceiver User Guide
      .REFCLK_HROW_CK_SEL(2'b00), // Refer to Transceiver User Guide
      .REFCLK_ICNTL_RX(2'b00)     // Refer to Transceiver User Guide
   )
   IBUFDS_GTE4_0 (
      .O(gty_refclk),         // 1-bit output: Refer to Transceiver User Guide
      .ODIV2(gty_refclk_int), // 1-bit output: Refer to Transceiver User Guide
      .CEB(1'b0),     // 1-bit input: Refer to Transceiver User Guide
      .I(refclk_p),         // 1-bit input: Refer to Transceiver User Guide
      .IB(refclk_n)        // 1-bit input: Refer to Transceiver User Guide
   );

//Sync the two control inputs to the clock from the transceiver
wire gearbox_slip_sync;
sync_it S0(
    .data_in(gearbox_slip),
    .clk(clkout),
    .data_out(gearbox_slip_sync)
    );

wire rxslide_sync;
sync_it S1(
    .data_in(rxslide),
    .clk(clkout),
    .data_out(rxslide_sync)
    );
//Then differentiate them both to make a rising-edge pulse
reg gearbox_slip_d1;
wire gearbox_slip_RE;
reg rxslide_d1;
wire rxslide_RE;
always @ (posedge clkout) begin
    gearbox_slip_d1 <= gearbox_slip_sync;
    rxslide_d1 <= rxslide_sync;
end
assign gearbox_slip_RE = gearbox_slip_sync && !gearbox_slip_d1;
assign rxslide_RE = rxslide_sync && !rxslide_d1;
wire [3:0] rxslide_vector = {
            rxslide_RE && (chan_sel == 2'b11),
            rxslide_RE && (chan_sel == 2'b10),
            rxslide_RE && (chan_sel == 2'b01),
            rxslide_RE && (chan_sel == 2'b00)};

wire [3:0] gearbox_slip_vector = {
            gearbox_slip_RE && (chan_sel == 2'b11),
            gearbox_slip_RE && (chan_sel == 2'b10),
            gearbox_slip_RE && (chan_sel == 2'b01),
            gearbox_slip_RE && (chan_sel == 2'b00)};

wire [255:0] gtwiz_userdata_rx_out;    
gtwizard_ultrascale_0 GTY_quad_0 (
  .gtwiz_userclk_tx_active_in(1'b0),                  // input wire [0 : 0] gtwiz_userclk_tx_active_in
  .gtwiz_userclk_rx_reset_in(1'b0),                    // input wire [0 : 0] gtwiz_userclk_rx_reset_in
  .gtwiz_userclk_rx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_srcclk_out
  .gtwiz_userclk_rx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_usrclk_out
  .gtwiz_userclk_rx_usrclk2_out(clkout),              // output wire [0 : 0] gtwiz_userclk_rx_usrclk2_out
  .gtwiz_userclk_rx_active_out(gtwiz_userclk_rx_active_out),                // output wire [0 : 0] gtwiz_userclk_rx_active_out
  .gtwiz_reset_clk_freerun_in(clk100),                  // input wire [0 : 0] gtwiz_reset_clk_freerun_in
  .gtwiz_reset_all_in(gtwiz_reset_all_in),                                  // input wire [0 : 0] gtwiz_reset_all_in
  .gtwiz_reset_tx_pll_and_datapath_in(1'b0),  // input wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in
  .gtwiz_reset_tx_datapath_in(1'b0),                  // input wire [0 : 0] gtwiz_reset_tx_datapath_in
  .gtwiz_reset_rx_pll_and_datapath_in(1'b0),  // input wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in
  .gtwiz_reset_rx_datapath_in(1'b0),                  // input wire [0 : 0] gtwiz_reset_rx_datapath_in
  .gtwiz_reset_rx_cdr_stable_out(gtwiz_reset_rx_cdr_stable_out),            // output wire [0 : 0] gtwiz_reset_rx_cdr_stable_out
  .gtwiz_reset_tx_done_out(),                        // output wire [0 : 0] gtwiz_reset_tx_done_out
  .gtwiz_reset_rx_done_out(gtwiz_reset_rx_done),                        // output wire [0 : 0] gtwiz_reset_rx_done_out
  .gtwiz_userdata_tx_in(256'h0),                              // input wire [255 : 0] gtwiz_userdata_tx_in
  .gtwiz_userdata_rx_out(gtwiz_userdata_rx_out),                            // output wire [255 : 0] gtwiz_userdata_rx_out
  .gtrefclk00_in(gty_refclk),                                            // input wire [0 : 0] gtrefclk00_in
  .qpll0outclk_out(),                                        // output wire [0 : 0] qpll0outclk_out
  .qpll0outrefclk_out(),                                  // output wire [0 : 0] qpll0outrefclk_out
  .gtyrxn_in(gtyrxn_in),                                                    // input wire [3 : 0] gtyrxn_in
  .gtyrxp_in(gtyrxp_in),                                                    // input wire [3 : 0] gtyrxp_in
  .rxgearboxslip_in(gearbox_slip_vector),                                      // input wire [3 : 0] rxgearboxslip_in
  .rxpolarity_in(rx_polarity),                                            // input wire [3 : 0] rxpolarity_in
  .rxprbscntreset_in(1'b0),                                    // input wire [3 : 0] rxprbscntreset_in
  .rxprbssel_in(16'h3333),                                              // input wire [15 : 0] rxprbssel_in
  .rxslide_in(rxslide_vector),                                                  // input wire [3 : 0] rxslide_in
  .txusrclk_in(4'h0),                                                // input wire [3 : 0] txusrclk_in
  .txusrclk2_in(4'h0),                                              // input wire [3 : 0] txusrclk2_in
  .gtpowergood_out(gt_powergood),                                        // output wire [3 : 0] gtpowergood_out
  .gtytxn_out(),                                                  // output wire [3 : 0] gtytxn_out
  .gtytxp_out(),                                                  // output wire [3 : 0] gtytxp_out
  .rxdatavalid_out(rx_dav),                                        // output wire [7 : 0] rxdatavalid_out
  .rxpmaresetdone_out(rx_pmareset_done),                                  // output wire [3 : 0] rxpmaresetdone_out
  .rxprbserr_out(rxprbserr),                                            // output wire [3 : 0] rxprbserr_out
  .rxprbslocked_out(rxprbslocked),                                      // output wire [3 : 0] rxprbslocked_out
  .txoutclk_out(),                                              // output wire [3 : 0] txoutclk_out
  .txpmaresetdone_out()                                  // output wire [3 : 0] txpmaresetdone_out
);
    
assign gtyrx_dout0 = gtwiz_userdata_rx_out[63:0];    
assign gtyrx_dout1 = gtwiz_userdata_rx_out[127:64];    
assign gtyrx_dout2 = gtwiz_userdata_rx_out[191:128];    
assign gtyrx_dout3 = gtwiz_userdata_rx_out[255:192];    

wire gty_refclk_int_buf;
  BUFG_GT BUFG_GT_REFCLK (
      .O(gty_refclk_int_buf),             // 1-bit output: Buffer
      .CE(1'b1),           // 1-bit input: Buffer enable
      .CEMASK(1'b0),   // 1-bit input: CE Mask
      .CLR(1'b0),         // 1-bit input: Asynchronous clear
      .CLRMASK(1'b0), // 1-bit input: CLR Mask
      .DIV(3'b000),         // 3-bit input: Dynamic divide Value
      .I(gty_refclk_int)              // 1-bit input: Buffer
   );

reg testflop = 0;
always @(posedge gty_refclk_int_buf)  testflop <= !testflop;
assign test_out = testflop;
   
endmodule
