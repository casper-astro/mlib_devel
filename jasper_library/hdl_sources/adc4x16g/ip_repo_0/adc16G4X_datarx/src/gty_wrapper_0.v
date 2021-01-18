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
    input clk_freerun,
    input gtwiz_reset_all_in,
    input [1:0] chan_sel,
    input [3:0] gtyrxp_in,
    input [3:0] gtyrxn_in,
    input rxcdrhold,
    input gearbox_slip,
    input rxslide,
    input XOR_ON,
    input [31:0] match_pattern,
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
    output gtwiz_reset_rx_cdr_stable_out,
    output gtwiz_userclk_rx_active_out,
    output clkout,
    input fifo_reset,
    input fifo_read,
    output fifo_full,
    output fifo_empty,
    output [31:0]data_out,
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
reg gearbox_slip_reg;
always @ (posedge clk100)gearbox_slip_reg <= gearbox_slip;
wire gearbox_slip_sync;
sync_it S0(
    .data_in(gearbox_slip_reg),
    .clk(rxclk),
    .data_out(gearbox_slip_sync)
    );

reg rxslide_reg;
always @ (posedge clk100)rxslide_reg <= rxslide;
wire rxslide_sync;
sync_it S1(
    .data_in(rxslide_reg),
    .clk(rxclk),
    .data_out(rxslide_sync)
    );
//Then differentiate them both to make a rising-edge pulse
reg gearbox_slip_d1;
wire gearbox_slip_RE;
reg rxslide_d1;
reg rxslide_d2;
//rxslide needs to be 2 rxclk cycles wide
wire rxslide_pulse;
always @ (posedge rxclk) begin
    gearbox_slip_d1 <= gearbox_slip_sync;
    rxslide_d1 <= rxslide_sync;
    rxslide_d2 <= rxslide_d1;
end
assign gearbox_slip_RE = gearbox_slip_sync && !gearbox_slip_d1;
assign rxslide_pulse = rxslide_sync && !rxslide_d2;
reg [1:0] chan_sel_reg;
always @ (posedge clk100) chan_sel_reg <= chan_sel;
wire [3:0] rxslide_vector = {
            rxslide_pulse && (chan_sel_reg == 2'b11),
            rxslide_pulse && (chan_sel_reg == 2'b10),
            rxslide_pulse && (chan_sel_reg == 2'b01),
            rxslide_pulse && (chan_sel_reg == 2'b00)};

wire [3:0] gearbox_slip_vector = {
            gearbox_slip_RE && (chan_sel_reg == 2'b11),
            gearbox_slip_RE && (chan_sel_reg == 2'b10),
            gearbox_slip_RE && (chan_sel_reg == 2'b01),
            gearbox_slip_RE && (chan_sel_reg == 2'b00)};
wire [3:0] rxcdrhold_in = {rxcdrhold, rxcdrhold, rxcdrhold, rxcdrhold};

//We'll sync a PRBS generator to one of the data streams and align the other streams to 
// that stream.  Then we'll XOR all streams with the PRBS
wire [63:0] prbs_data;
wire [255:0] gty_out;    
wire [255:0] gty_out_XOR = XOR_ON ? {
                            gty_out[255:192] ^ prbs_data,
                            gty_out[191:128] ^ prbs_data,
                            gty_out[127:64] ^ prbs_data,
                            gty_out[63:0] ^ prbs_data} :
                            gty_out;
(* keep = "true" *) wire [63:0] debug_gty_rx_data3 = gty_out[255:192];
gtwizard_ultrascale_0 GTY_quad_0 (
  .gtwiz_userclk_tx_reset_in(1'b0),                    // input wire [0 : 0] gtwiz_userclk_tx_reset_in
  .gtwiz_userclk_tx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_srcclk_out
  .gtwiz_userclk_tx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_usrclk_out
  .gtwiz_userclk_tx_usrclk2_out(),              // output wire [0 : 0] gtwiz_userclk_tx_usrclk2_out
  .gtwiz_userclk_tx_active_out(),                // output wire [0 : 0] gtwiz_userclk_tx_active_out
  .gtwiz_userclk_rx_reset_in(1'b0),                    // input wire [0 : 0] gtwiz_userclk_rx_reset_in
  .gtwiz_userclk_rx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_srcclk_out
  .gtwiz_userclk_rx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_usrclk_out
  .gtwiz_userclk_rx_usrclk2_out(rxclk),              // output wire [0 : 0] gtwiz_userclk_rx_usrclk2_out
  .gtwiz_userclk_rx_active_out(gtwiz_userclk_rx_active_out),                // output wire [0 : 0] gtwiz_userclk_rx_active_out
  .gtwiz_reset_clk_freerun_in(clk_freerun),                  // input wire [0 : 0] gtwiz_reset_clk_freerun_in
  .gtwiz_reset_all_in(gtwiz_reset_all_in),                                  // input wire [0 : 0] gtwiz_reset_all_in
  .gtwiz_reset_tx_pll_and_datapath_in(1'b0),  // input wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in
  .gtwiz_reset_tx_datapath_in(1'b0),                  // input wire [0 : 0] gtwiz_reset_tx_datapath_in
  .gtwiz_reset_rx_pll_and_datapath_in(1'b0),  // input wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in
  .gtwiz_reset_rx_datapath_in(1'b0),                  // input wire [0 : 0] gtwiz_reset_rx_datapath_in
  .gtwiz_reset_rx_cdr_stable_out(gtwiz_reset_rx_cdr_stable_out),            // output wire [0 : 0] gtwiz_reset_rx_cdr_stable_out
  .gtwiz_reset_tx_done_out(),                        // output wire [0 : 0] gtwiz_reset_tx_done_out
  .gtwiz_reset_rx_done_out(gtwiz_reset_rx_done),                        // output wire [0 : 0] gtwiz_reset_rx_done_out
  .gtwiz_userdata_tx_in(256'h0),                              // input wire [255 : 0] gtwiz_userdata_tx_in
  .gtwiz_userdata_rx_out(gty_out),                            // output wire [255 : 0] gtwiz_userdata_rx_out
  .gtrefclk00_in(gty_refclk),                                            // input wire [0 : 0] gtrefclk00_in
  .qpll0outclk_out(),                                        // output wire [0 : 0] qpll0outclk_out
  .qpll0outrefclk_out(),                                  // output wire [0 : 0] qpll0outrefclk_out
  .gtyrxn_in(gtyrxn_in),                                                    // input wire [3 : 0] gtyrxn_in
  .gtyrxp_in(gtyrxp_in),                                                    // input wire [3 : 0] gtyrxp_in
  .rxgearboxslip_in(gearbox_slip_vector),                                      // input wire [3 : 0] rxgearboxslip_in
  .rxpolarity_in(4'h0),                                            // input wire [3 : 0] rxpolarity_in
  .rxcdrhold_in(rxcdrhold_in),
  .rxprbscntreset_in(1'b0),                                    // input wire [3 : 0] rxprbscntreset_in
  .rxprbssel_in(16'h3333),                                              // input wire [15 : 0] rxprbssel_in
  .rxslide_in(rxslide_vector),                                                  // input wire [3 : 0] rxslide_in
  .gtpowergood_out(gt_powergood),                                        // output wire [3 : 0] gtpowergood_out
  .gtytxn_out(),                                                  // output wire [3 : 0] gtytxn_out
  .gtytxp_out(),                                                  // output wire [3 : 0] gtytxp_out
  .rxdatavalid_out(rx_dav),                                        // output wire [7 : 0] rxdatavalid_out
  .rxpmaresetdone_out(rx_pmareset_done),                                  // output wire [3 : 0] rxpmaresetdone_out
  .rxprbserr_out(rxprbserr),                                            // output wire [3 : 0] rxprbserr_out
  .rxprbslocked_out(rxprbslocked),                                      // output wire [3 : 0] rxprbslocked_out
  .txpmaresetdone_out()                                  // output wire [3 : 0] txpmaresetdone_out
);


//Not clear what order the bits are in.  Think it's 3, 2, 0, 1, so 255:192 are bit 3, etc
wire [3:0] samples [63:0];
genvar gg;
 generate
      for (gg=0; gg < 64; gg=gg+1)
      begin: map_bits1
         assign samples[gg] = {gty_out_XOR[192+gg],gty_out_XOR[128+gg],gty_out_XOR[gg],gty_out_XOR[64+gg]};
      end
   endgenerate
   
(*keep = "true"*)wire [255:0] fifo_in;	
//The 256-in, 32-out FIFO delivers the MS word first when reading, so arrange the samples accordingly
assign fifo_in = {
    samples[7], samples[6], samples[5], samples[4], samples[3], samples[2], samples[1], samples[0], 
    samples[15], samples[14], samples[13], samples[12], samples[11], samples[10], samples[9], samples[8], 
    samples[23], samples[22], samples[21], samples[20], samples[19], samples[18], samples[17], samples[16], 
    samples[31], samples[30], samples[29], samples[28], samples[27], samples[26], samples[25], samples[24], 
    samples[39], samples[38], samples[37], samples[36], samples[35], samples[34], samples[33], samples[32], 
    samples[47], samples[46], samples[45], samples[44], samples[43], samples[42], samples[41], samples[40], 
    samples[55], samples[54], samples[53], samples[52], samples[51], samples[50], samples[49], samples[48], 
    samples[63], samples[62], samples[61], samples[60], samples[59], samples[58], samples[57], samples[56]};

wire fifo_reset_sync;
reg fifo_wr;
wire [31:0] fifo_out;
wire wr_rst_busy;
wire fifo_read_pulse;
reg fifo_read_d1;
always @ (posedge clk100)fifo_read_d1 <= fifo_read;
assign fifo_read_pulse = fifo_read && !fifo_read_d1;

fifo_256in_32out FIFO_ADC (
  .srst(fifo_reset_sync),                // input wire srst
  .wr_clk(rxclk),            // input wire wr_clk
  .rd_clk(clk100),            // input wire rd_clk
  .din(fifo_in),                  // input wire [255 : 0] din
  .wr_en(fifo_wr && !fifo_full),  // input wire wr_en
  .rd_en(fifo_read_pulse),              // input wire rd_en
  .dout(fifo_out),                // output wire [31 : 0] dout
  .full(fifo_full),                // output wire full
  .empty(fifo_empty),              // output wire empty
  .wr_rst_busy(wr_rst_busy),  // output wire wr_rst_busy
  .rd_rst_busy()  // output wire rd_rst_busy
);

//The sync reset must be sync'ed to the write clock
sync_it S2(
    .data_in(fifo_reset),
    .clk(rxclk),
    .data_out(fifo_reset_sync)
    );

always @ (posedge rxclk) begin
    if (wr_rst_busy) fifo_wr <= 0;
    else fifo_wr <= 1;
end

assign data_out = fifo_out;
assign clkout = rxclk;

    
assign gtyrx_dout0 = gty_out[63:0];    
assign gtyrx_dout1 = gty_out[127:64];    
assign gtyrx_dout2 = gty_out[191:128];    
assign gtyrx_dout3 = gty_out[255:192];    

//PRBS generator that we can sync to one of the data streams
(* keep = "true" *)wire prbs_reset = (gtyrx_dout3[31:0] == match_pattern);
gtwizard_ultrascale_0_prbs_any #(.CHK_MODE(0),
        .INV_PATTERN(0),
        .POLY_LENGHT(15),
        .POLY_TAP(14),
        .NBITS(64)        
        )
    PRBS_GEN(
    .RST(prbs_reset), 
    .CLK(rxclk), 
    .DATA_IN(64'h0), 
    .EN(1'b1), 
    .DATA_OUT(prbs_data));


wire gty_refclk_int_buf;
  BUFG_GT BUFG_GT_REFCLK (
      .O(gty_refclk_int_buf),             // 1-bit output: Buffer
      .I(gty_refclk_int)              // 1-bit input: Buffer
   );


reg testflop = 0;
always @(posedge gty_refclk_int_buf)  testflop <= !testflop;
assign test_out = testflop;
   
endmodule
