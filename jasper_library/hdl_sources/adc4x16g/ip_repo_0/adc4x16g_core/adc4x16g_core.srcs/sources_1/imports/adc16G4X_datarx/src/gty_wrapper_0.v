`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//Core for four channel ADC4X16G-4 board, four channels of ASNT7123 ADC
//  capturing 16GSPS at 4-bit resolution
//////////////////////////////////////////////////////////////////////////////////

module gty_wrapper_0#(
    parameter [1:0]CHANNEL_SEL = 0
)(
    input refclk0_p,
    input refclk0_n,
    input clk100,
    input clk_freerun,
    input gtwiz_reset_all_in,
    input [1:0] bit_sel,
    input [3:0] gty0rxp_in,
    input [3:0] gty0rxn_in,
    input rxcdrhold,
    input rxslide,
    input XOR_ON,
    input [31:0] match_pattern,
    input pattern_match_enable,
    output [3:0] rxprbserr_out,
    output reg rxprbslocked,
    input fifo_reset,
    input fifo_read,
    output reg fifo_full,
    output reg fifo_empty,
    output reg [255:0]data_out,
    input prbs_error_count_reset,
    //DRP Port Interface
    input [9:0] drp_addr,
    input drp_reset,
    input drp_read,
    output reg [15:0] drp_data,
    input [7:0] write_interval,
    output adc_clk
        );

//This parameter is set to 1 to compile for the rev1 board whose pairs are
// not swapped between ADC B and C.

//We'll mux one of these at a time to rxprbslocked
wire [15:0] rxprbslocked_vec;
//For the DRP, we need to send a single-cycle pulse to the enable of all
// the GTY channels, then register the data output on drp_ready
//We'll then MUX the output from one of 16 channels to the 16b output port
wire [3:0] drpclk_in = {clk100, clk100, clk100, clk100};
wire [3:0] drprst_in = {drp_reset, drp_reset, drp_reset, drp_reset};
wire [3:0] drp_ready;
reg drp_read_d1;
wire drp_enable_pulse = drp_read & !drp_read_d1;
wire [3:0] drp_enable_pulse_vec = {drp_enable_pulse, drp_enable_pulse, drp_enable_pulse, drp_enable_pulse};
//These go to the GTY quads
wire [3:0] drp_out [15:0];
//These are the registered versions
reg [3:0] drp_out_reg [15:0];
//Mux for the output- PCB rev 0
//      ADC Chan    Bit     RxBank  bank      Bit
//      A           0       126     0           1
//      A           1       126     0           0
//      A           2       126     0           2
//      A           3       126     0           3
//      B           0       125     1           3
//      B           1       125     1           0
//      B           2       127*    2           0 
//      B           3       125     1           2   
//      C           0       127     2           1
//      C           1       125*    1           1
//      C           2       127     2           2
//      C           3       127     2           3
//      D           0       128     3           0
//      D           1       128     3           1
//      D           2       128     3           2
//      D           3       128     3           3
//Mux for the output- PCB rev 1
//      ADC Chan    Bit     RxBank  bank      Bit
//      A           0       126     0           1
//      A           1       126     0           0
//      A           2       126     0           2
//      A           3       126     0           3
//      B           0       125     1           3
//      B           1       125     1           0
//      B           2       125     1           1 
//      B           3       125     1           2   
//      C           0       127     2           1
//      C           1       127     2           0
//      C           2       127     2           2
//      C           3       127     2           3
//      D           0       128     3           0
//      D           1       128     3           1
//      D           2       128     3           2
//      D           3       128     3           3

generate
if(CHANNEL_SEL == 0)begin: DRP_OUT_RXPRBSLOCKED0
always @(*)
    case(bit_sel)
        4'h0: drp_data = drp_out_reg[1];
        4'h1: drp_data = drp_out_reg[0];
        4'h2: drp_data = drp_out_reg[2];
        4'h3: drp_data = drp_out_reg[3];
    endcase
always @(*)
    case(bit_sel)
        4'h0: rxprbslocked = rxprbslocked_vec[1];
        4'h1: rxprbslocked = rxprbslocked_vec[0];
        4'h2: rxprbslocked = rxprbslocked_vec[2];
        4'h3: rxprbslocked = rxprbslocked_vec[3];
    endcase
                    end
else if(CHANNEL_SEL == 1)begin: DRP_OUT_RXPRBSLOCKED1
always @(*)
    case(bit_sel)
        4'h0: drp_data = drp_out_reg[3];
        4'h1: drp_data = drp_out_reg[0];
        4'h2: drp_data = drp_out_reg[1];
        4'h3: drp_data = drp_out_reg[2];
    endcase
always @(*)
    case(bit_sel)
        4'h0: rxprbslocked = rxprbslocked_vec[3];
        4'h1: rxprbslocked = rxprbslocked_vec[0];
        4'h2: rxprbslocked = rxprbslocked_vec[1];
        4'h3: rxprbslocked = rxprbslocked_vec[2];
    endcase
                    end
else if(CHANNEL_SEL == 2)begin: DRP_OUT_RXPRBSLOCKED2
always @(*)
    case(bit_sel)
        4'h0: drp_data = drp_out_reg[1];
        4'h1: drp_data = drp_out_reg[0];
        4'h2: drp_data = drp_out_reg[2];
        4'h3: drp_data = drp_out_reg[3];
    endcase
always @(*)
    case(bit_sel)
        4'h0: rxprbslocked = rxprbslocked_vec[1];
        4'h1: rxprbslocked = rxprbslocked_vec[0];
        4'h2: rxprbslocked = rxprbslocked_vec[2];
        4'h3: rxprbslocked = rxprbslocked_vec[3];
    endcase
                    end
else if(CHANNEL_SEL == 3)begin: DRP_OUT_RXPRBSLOCKED3
always @(*)
    case(bit_sel)
        4'h0: drp_data = drp_out_reg[0];
        4'h1: drp_data = drp_out_reg[1];
        4'h2: drp_data = drp_out_reg[2];
        4'h3: drp_data = drp_out_reg[3];
    endcase
always @(*)
    case(bit_sel)
        4'h0: rxprbslocked = rxprbslocked_vec[0];
        4'h1: rxprbslocked = rxprbslocked_vec[1];
        4'h2: rxprbslocked = rxprbslocked_vec[2];
        4'h3: rxprbslocked = rxprbslocked_vec[3];
    endcase
                    end
endgenerate


integer ii;
always @ (posedge clk100) begin
    for (ii = 0; ii < 3; ii = ii + 1) if (drp_ready[ii]) drp_out_reg[ii] <= drp_out[ii];
    drp_read_d1 <= drp_read;
end

//We need to sync the prbs_error_counter_reset to each rxclk
wire rxclk0;

wire prbs_error_count_reset_sync0;

wire [3:0] error_count_vec0 = {prbs_error_count_reset_sync0, prbs_error_count_reset_sync0, prbs_error_count_reset_sync0, prbs_error_count_reset_sync0};

sync_it S12(
    .data_in(prbs_error_count_reset),
    .clk(rxclk0),
    .data_out(prbs_error_count_reset_sync0)
    );

//Instantiate four refclk buffers; these connect to the transceivers       
wire gty_refclk0;
wire gty_refclk_odiv2;
   IBUFDS_GTE4 #(
      .REFCLK_EN_TX_PATH(1'b0),   // Refer to Transceiver User Guide
      .REFCLK_HROW_CK_SEL(2'b00), // Refer to Transceiver User Guide
      .REFCLK_ICNTL_RX(2'b00)     // Refer to Transceiver User Guide
   )
   IBUFDS_GTE4_0 (
      .O(gty_refclk0),         // 1-bit output: Refer to Transceiver User Guide
      .ODIV2(gty_refclk_odiv2), // 1-bit output: Refer to Transceiver User Guide
      .CEB(1'b0),     // 1-bit input: Refer to Transceiver User Guide
      .I(refclk0_p),         // 1-bit input: Refer to Transceiver User Guide
      .IB(refclk0_n)        // 1-bit input: Refer to Transceiver User Guide
   );

wire adc_clk_tmp;
BUFG_GT BUFG_GT_inst (
      .O(adc_clk_tmp),             // 1-bit output: Buffer
      .CE(1'b1),           // 1-bit input: Buffer enable
      .CEMASK(1'b0),   // 1-bit input: CE Mask
      .CLR(1'b0),         // 1-bit input: Asynchronous clear
      .CLRMASK(1'b0), // 1-bit input: CLR Mask
      .DIV(3'b001),         // 3-bit input: Dynamic divide Value
      .I(gty_refclk_odiv2)              // 1-bit input: Buffer
   );

BUFG BUFG_inst(
    .I(adc_clk_tmp),
    .O(adc_clk)
);

//assign adc_clk = rxclk0;
/*
BUFG BUFG_inst(
    .I(rxclk0),
    .O(adc_clk)
);
*/
//Sync the rxslide input to the axi clock
reg rxslide_reg;
always @ (posedge clk100)rxslide_reg <= rxslide;
//Then sync it to each of the clocks recovered from the transceivers
wire rxslide_sync0;
wire rxslide_sync1;
wire rxslide_sync2;
wire rxslide_sync3;
sync_it S0(
    .data_in(rxslide_reg),
    .clk(rxclk0),
    .data_out(rxslide_sync0)
    );
//Each rxslide pulse needs to be two rxclk's wide
reg rxslide0_d1, rxslide0_d2;
wire rxslide0_pulse;
always @ (posedge rxclk0) begin
    rxslide0_d1 <= rxslide_sync0;
    rxslide0_d2 <= rxslide0_d1;
end

assign rxslide0_pulse = rxslide_sync0 && !rxslide0_d2;

//We combine bit_sel and chan_sel here to make an rxslide pulse that can be applied to one of 16 channels
reg [3:0] all_chan_sel_reg;
always @ (posedge clk100) all_chan_sel_reg <= {CHANNEL_SEL, bit_sel};
//The Channel mapping is as follows- PCB REV 0
//      ADC Chan    Bit     RxBank  bank      Lane
//      A           0       126     0           1
//      A           1       126     0           0
//      A           2       126     0           2
//      A           3       126     0           3
//      B           0       125     1           3
//      B           1       125     1           0
//      B           2       127*    2           0 
//      B           3       125     1           2   
//      C           0       127     2           1
//      C           1       125*    1           1
//      C           2       127     2           2
//      C           3       127     2           3
//      D           0       128     3           0
//      D           1       128     3           1
//      D           2       128     3           2
//      D           3       128     3           3
// * because of this error in assigning bits to banks, we'll remap the bits after the FIFOs
//  (since each fifo has its own wr_clk)
//For PCB rev 1
//      ADC Chan    Bit     RxBank  bank      Bit
//      A           0       126     0           1
//      A           1       126     0           0
//      A           2       126     0           2
//      A           3       126     0           3
//      B           0       125     1           3
//      B           1       125     1           0
//      B           2       125     1           1 
//      B           3       125     1           2   
//      C           0       127     2           1
//      C           1       127     2           0
//      C           2       127     2           2
//      C           3       127     2           3
//      D           0       128     3           0
//      D           1       128     3           1
//      D           2       128     3           2
//      D           3       128     3           3

//Rearrange these so that they are in the order of the ADC bits
wire [3:0] rxslide_vector;
generate
if(CHANNEL_SEL == 0) begin: RXSLIDE_CH0
assign rxslide_vector = {
            rxslide0_pulse && (all_chan_sel_reg == 4'h3),  //bank 0 lane 3  ADC A   bit 3
            rxslide0_pulse && (all_chan_sel_reg == 4'h2),  //bank 0 lane 2  ADC A   bit 2
            rxslide0_pulse && (all_chan_sel_reg == 4'h0),  //bank 0 lane 1  ADC A   bit 0
            rxslide0_pulse && (all_chan_sel_reg == 4'h1)   //bank 0 lane 0  ADC A   bit 1
};
                     end
else if(CHANNEL_SEL == 1)begin: RXSLIDE_CH1
assign rxslide_vector = {
            rxslide0_pulse && (all_chan_sel_reg == 4'h4),  //bank 1 lane 3  ADC B   bit 0
            rxslide0_pulse && (all_chan_sel_reg == 4'h7),  //bank 1 lane 2  ADC B   bit 3
            rxslide0_pulse && (all_chan_sel_reg == 4'h6),  //bank 1 lane 1  ADC B   bit 2
            rxslide0_pulse && (all_chan_sel_reg == 4'h5)   //bank 1 lane 0  ADC B   bit 1
};
                     end
else if(CHANNEL_SEL == 2)begin: RXSLIDE_CH2
assign rxslide_vector = {
            rxslide0_pulse && (all_chan_sel_reg == 4'hb),  //bank 2 lane 3  ADC C   bit 3
            rxslide0_pulse && (all_chan_sel_reg == 4'ha),  //bank 2 lane 2  ADC C   bit 2
            rxslide0_pulse && (all_chan_sel_reg == 4'h8),  //bank 2 lane 1  ADC C   bit 0
            rxslide0_pulse && (all_chan_sel_reg == 4'h9)   //bank 2 lane 0  ADC C   bit 1
};
                     end
else if(CHANNEL_SEL == 3)begin: RXSLIDE_CH3
assign rxslide_vector = {
            rxslide0_pulse && (all_chan_sel_reg == 4'hf),  //bank 3 lane 3  ADC D   bit 3
            rxslide0_pulse && (all_chan_sel_reg == 4'he),  //bank 3 lane 2  ADC D   bit 2
            rxslide0_pulse && (all_chan_sel_reg == 4'hd),  //bank 3 lane 1  ADC D   bit 1
            rxslide0_pulse && (all_chan_sel_reg == 4'hc)  //bank 3 lane 0  ADC D   bit 0
};
                     end
endgenerate

wire [3:0] rxprbserr0;
generate
if(CHANNEL_SEL == 0) begin: RXPRBSERR0
assign rxprbserr_out = {rxprbserr0[3], rxprbserr0[2], rxprbserr0[0], rxprbserr0[1]};
                     end
else if(CHANNEL_SEL == 1)begin: RXPRBSERR1
assign rxprbserr_out = {rxprbserr0[2], rxprbserr0[1], rxprbserr0[0], rxprbserr0[3]};
                     end              
else if(CHANNEL_SEL == 2)begin: RXPRBSERR2
assign rxprbserr_out = {rxprbserr0[3], rxprbserr0[2], rxprbserr0[0], rxprbserr0[1]};
                     end
else if(CHANNEL_SEL == 3)begin: RXPRBSERR3
assign rxprbserr_out = {rxprbserr0};
                     end
endgenerate
                        
//CDRHOLD may be useful to freeze the CDR phase when edge rate is not sufficient.  It's an asynch input
//A single control for all 16 channels; could have individual controls if necessary
wire [3:0] rxcdrhold_in = {rxcdrhold, rxcdrhold, rxcdrhold, rxcdrhold};

//We'll sync a prbs generator to one of the data streams of each channel and align the other streams to 
// that stream.  Then we'll XOR all streams with the PRBS
//But because of the pinout swap between ADC B and ADC C, we need two more prbs generators,
// one for each of the swapped lanes.  Each of these will be clocked by the rxclk from the
// GTY quad that receives the lane (different from the one that receives the other three lanes
// from that ADC) but sync'ed to the data in that lane. The two extra prbs generators are necessary for the rev0 board only
wire [63:0] prbs2_lane0_data;  //This one is bit 2 of ADC B
wire [63:0] prbs1_lane1_data;  //This one is bit 1 of ADC C

wire [63:0] prbs0_data;

wire [255:0] gty0_out;  

wire [255:0] gty0_out_XOR;  

generate
if(CHANNEL_SEL == 0) begin: GTY_OUT_XOR_CH0
assign gty0_out_XOR = XOR_ON ? {
                            gty0_out[255:192] ^ prbs0_data,
                            gty0_out[191:128] ^ prbs0_data,
                            gty0_out[127:64] ^ prbs0_data,
                            gty0_out[63:0] ^ prbs0_data} :
                            gty0_out;
                     end
else if(CHANNEL_SEL == 1) begin: GTY_OUT_XOR_CH1
assign gty0_out_XOR = XOR_ON ? {
                            gty0_out[255:192] ^ prbs0_data,
                            gty0_out[191:128] ^ prbs0_data,
                            gty0_out[127:64] ^ prbs0_data,
                            gty0_out[63:0] ^ prbs0_data} :
                            gty0_out;
                           end 
else if(CHANNEL_SEL == 2) begin: GTY_OUT_XOR_CH2
assign gty0_out_XOR = XOR_ON ? {
                            gty0_out[255:192] ^ prbs0_data,
                            gty0_out[191:128] ^ prbs0_data,
                            gty0_out[127:64] ^ prbs0_data,
                            gty0_out[63:0] ^ prbs0_data} :
                            gty0_out;
                           end
else if(CHANNEL_SEL == 3) begin: GTY_OUT_XOR_CH3
assign gty0_out_XOR = XOR_ON ? {
                            gty0_out[255:192] ^ prbs0_data,
                            gty0_out[191:128] ^ prbs0_data,
                            gty0_out[127:64] ^ prbs0_data,
                            gty0_out[63:0] ^ prbs0_data} :
                            gty0_out;
                           end
endgenerate

wire pattern_match_enable_sync0;

sync_it S8(
    .data_in(pattern_match_enable),
    .clk(rxclk0),
    .data_out(pattern_match_enable_sync0)
    );


//PRBS generator for each Rx Bank.  We'll sync each one to an arbitrarily-chosen 
//  32-bit sequence from one of the lanes
//(* keep = "true" *)wire prbs0_reset = pattern_match_enable_sync0 ? (gty0_out[31:0] == match_pattern) : 1'b0;
//(* keep = "true" *)wire prbs1_reset = pattern_match_enable_sync1 ? (gty1_out[31:0] == match_pattern) : 1'b0;
//(* keep = "true" *)wire prbs2_reset = pattern_match_enable_sync2 ? (gty2_out[31:0] == match_pattern) : 1'b0;
//(* keep = "true" *)wire prbs3_reset = pattern_match_enable_sync3 ? (gty3_out[31:0] == match_pattern) : 1'b0;
//Sync each prbs generator to the LSB of each ADC:
(* keep = "true" *)wire prbs0_reset = pattern_match_enable_sync0 ? (gty0_out[95:64] == match_pattern) : 1'b0;
gtwizard_ultrascale_0_prbs_any #(.CHK_MODE(0),
        .INV_PATTERN(0),
        .POLY_LENGHT(15),
        .POLY_TAP(14),
        .NBITS(64)        
        )
    PRBS_GEN0(
    .RST(prbs0_reset), 
    .CLK(rxclk0), 
    .DATA_IN(64'h0), 
    .EN(1'b1), 
    .DATA_OUT(prbs0_data));
    
gtwizard_ultrascale_0 GTY_quad0 (
  .gtwiz_userclk_tx_reset_in(1'b0),                    // input wire [0 : 0] gtwiz_userclk_tx_reset_in
  .gtwiz_userclk_tx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_srcclk_out
  .gtwiz_userclk_tx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_tx_usrclk_out
  .gtwiz_userclk_tx_usrclk2_out(),              // output wire [0 : 0] gtwiz_userclk_tx_usrclk2_out
  .gtwiz_userclk_tx_active_out(),                // output wire [0 : 0] gtwiz_userclk_tx_active_out
  .gtwiz_userclk_rx_reset_in(1'b0),                    // input wire [0 : 0] gtwiz_userclk_rx_reset_in
  .gtwiz_userclk_rx_srcclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_srcclk_out
  .gtwiz_userclk_rx_usrclk_out(),                // output wire [0 : 0] gtwiz_userclk_rx_usrclk_out
  .gtwiz_userclk_rx_usrclk2_out(rxclk0),              // output wire [0 : 0] gtwiz_userclk_rx_usrclk2_out
  .gtwiz_userclk_rx_active_out(),                // output wire [0 : 0] gtwiz_userclk_rx_active_out
  .gtwiz_reset_clk_freerun_in(clk_freerun),                  // input wire [0 : 0] gtwiz_reset_clk_freerun_in
  .gtwiz_reset_all_in(gtwiz_reset_all_in),                                  // input wire [0 : 0] gtwiz_reset_all_in
  .gtwiz_reset_tx_pll_and_datapath_in(1'b0),  // input wire [0 : 0] gtwiz_reset_tx_pll_and_datapath_in
  .gtwiz_reset_tx_datapath_in(1'b0),                  // input wire [0 : 0] gtwiz_reset_tx_datapath_in
  .gtwiz_reset_rx_pll_and_datapath_in(1'b0),  // input wire [0 : 0] gtwiz_reset_rx_pll_and_datapath_in
  .gtwiz_reset_rx_datapath_in(1'b0),                  // input wire [0 : 0] gtwiz_reset_rx_datapath_in
  .gtwiz_reset_rx_cdr_stable_out(),            // output wire [0 : 0] gtwiz_reset_rx_cdr_stable_out
  .gtwiz_reset_tx_done_out(),                        // output wire [0 : 0] gtwiz_reset_tx_done_out
  .gtwiz_reset_rx_done_out(),                        // output wire [0 : 0] gtwiz_reset_rx_done_out
  .gtwiz_userdata_tx_in(256'h0),                              // input wire [255 : 0] gtwiz_userdata_tx_in
  .gtwiz_userdata_rx_out(gty0_out),                            // output wire [255 : 0] gtwiz_userdata_rx_out
  .gtrefclk00_in(gty_refclk0),                                            // input wire [0 : 0] gtrefclk00_in
  .qpll0outclk_out(),                                        // output wire [0 : 0] qpll0outclk_out
  .qpll0outrefclk_out(),                                  // output wire [0 : 0] qpll0outrefclk_out
  .gtyrxn_in(gty0rxn_in),                                                    // input wire [3 : 0] gtyrxn_in
  .gtyrxp_in(gty0rxp_in),                                                    // input wire [3 : 0] gtyrxp_in
  .rxgearboxslip_in(4'b0),                                      // input wire [3 : 0] rxgearboxslip_in
  .rxpolarity_in(4'h0),                                            // input wire [3 : 0] rxpolarity_in
  .rxcdrhold_in(rxcdrhold_in),
  .rxprbscntreset_in(error_count_vec0),                                    // input wire [3 : 0] rxprbscntreset_in
  .rxprbssel_in(16'h3333),                                              // input wire [15 : 0] rxprbssel_in
  .rxslide_in(rxslide_vector[3:0]),                                                  // input wire [3 : 0] rxslide_in
  .gtpowergood_out(),                                        // output wire [3 : 0] gtpowergood_out
  .gtytxn_out(),                                                  // output wire [3 : 0] gtytxn_out
  .gtytxp_out(),                                                  // output wire [3 : 0] gtytxp_out
  .rxdatavalid_out(),                                        // output wire [7 : 0] rxdatavalid_out
  .rxpmaresetdone_out(),                                  // output wire [3 : 0] rxpmaresetdone_out
  .rxprbserr_out(rxprbserr0),                                            // output wire [3 : 0] rxprbserr_out
  .rxprbslocked_out(rxprbslocked_vec[3:0]),                                      // output wire [3 : 0] rxprbslocked_out
  .txpmaresetdone_out(),                                  // output wire [3 : 0] txpmaresetdone_out
  .drpaddr_in({drp_addr, drp_addr, drp_addr, drp_addr}),                                                  // input wire [39 : 0] drpaddr_in
  .drprst_in(drprst_in),                                  // input wire [3 : 0] drprst_in
  .drpclk_in(drpclk_in),                                                    // input wire [3 : 0] drpclk_in
  .drpen_in(drp_enable_pulse_vec),                                                      // input wire [3 : 0] drpen_in
  .drpdo_out({drp_out[3], drp_out[2], drp_out[1], drp_out[0]}),    // output wire [63 : 0] drpdo_out
  .drprdy_out(drp_ready[3:0])                                                  // output wire [3 : 0] drprdy_out
);
 


//Reorganize the parallel data out of the GTY receivers into 4-bit samples
//Don't reorganize the bits here, since there is a crossover between 2 banks and each needs to
//   go to the FIFO with the correct write_clock
wire [3:0] bank0_samples [63:0];
genvar gg;
 generate
      for (gg=0; gg < 64; gg=gg+1)
      begin: map_bits
         assign bank0_samples[gg] = {gty0_out_XOR[192+gg],gty0_out_XOR[128+gg],gty0_out_XOR[64+gg],gty0_out_XOR[gg]};
      end
   endgenerate
   
(*keep = "true"*)wire [255:0] fifo0_in;	
//The 256-in, 32-out FIFO delivers the MS word first when reading, so arrange the bank0_samples accordingly
assign fifo0_in = {
    bank0_samples[63], bank0_samples[62], bank0_samples[61], bank0_samples[60], bank0_samples[59], bank0_samples[58], bank0_samples[57], bank0_samples[56],
    bank0_samples[55], bank0_samples[54], bank0_samples[53], bank0_samples[52], bank0_samples[51], bank0_samples[50], bank0_samples[49], bank0_samples[48], 
    bank0_samples[47], bank0_samples[46], bank0_samples[45], bank0_samples[44], bank0_samples[43], bank0_samples[42], bank0_samples[41], bank0_samples[40],
    bank0_samples[39], bank0_samples[38], bank0_samples[37], bank0_samples[36], bank0_samples[35], bank0_samples[34], bank0_samples[33], bank0_samples[32],
    bank0_samples[31], bank0_samples[30], bank0_samples[29], bank0_samples[28], bank0_samples[27], bank0_samples[26], bank0_samples[25], bank0_samples[24],
    bank0_samples[23], bank0_samples[22], bank0_samples[21], bank0_samples[20], bank0_samples[19], bank0_samples[18], bank0_samples[17], bank0_samples[16],
    bank0_samples[15], bank0_samples[14], bank0_samples[13], bank0_samples[12], bank0_samples[11], bank0_samples[10], bank0_samples[9], bank0_samples[8], 
    bank0_samples[7], bank0_samples[6], bank0_samples[5], bank0_samples[4], bank0_samples[3], bank0_samples[2], bank0_samples[1], bank0_samples[0]
    };

//A read pulse for all the FIFOs
wire fifo_read_pulse;
reg fifo_read_d1;
always @ (posedge clk100)fifo_read_d1 <= fifo_read;
assign fifo_read_pulse = fifo_read && !fifo_read_d1;


//A 256-in, 32-out FIFO for each bank, to cross the clock domain boundary
//After a reset, we just write the FIFO until it's full
wire wr_rst_busy0;

//Register these for speed
reg wr_rst_busy_reg0;

always @ (posedge rxclk0) wr_rst_busy_reg0 <= wr_rst_busy0;

wire wr_rst_busy_all = wr_rst_busy_reg0;

//Rather than rely on this ORed signal from four clock domains, we will use it to start a timer in 
// rxclk0 domain; when this times out we'll sync the result to each domain and use these signals
// to assert each fifo_write.  That way, even if the various wr_reset_busy signals are asserted for different
// times on each reset, the signal used to assert fifo_write will always be launched by the same clock


//v21: To enable taking data records at a multiple of a specific interval, we'll make an 8-bit counter
// for write_clock0, and make it count-to-N and repeat, where N is software settable.
//the fifo_wr signal will only be asserted on the count=0 cycle.  For N=0, the functionality will be unchanged
reg [7:0] sync_count = 0;
reg reset_hold;
always @ (posedge rxclk0) begin
    if (sync_count == write_interval) sync_count <= 0;
    else sync_count <= sync_count + 1;
    if (wr_rst_busy_all) begin
        reset_hold <= 1;
    end
    else if (sync_count == write_interval) reset_hold <= 0;
end


wire fifo0_reset_sync;
reg fifo0_wr;
reg fifo0_wr_reg;
wire [255:0] fifo0_out;
wire fifo0_full;
wire fifo0_empty;
//The sync reset must be sync'ed to the write clock
sync_it S4(
    .data_in(fifo_reset),
    .clk(rxclk0),
    .data_out(fifo0_reset_sync)
    );
//Register this on the negative edge, then the positive edge, to eliminate uncertainty between channels
always @ (negedge rxclk0) begin
    if (reset_hold) fifo0_wr <= 0;
    else fifo0_wr <= 1;
end
//the output of this fifo is changed to 256 instead of 32
always @ (posedge rxclk0) fifo0_wr_reg <= fifo0_wr;
/*
fifo_256in_32out FIFO0_ADC (
  .srst(fifo0_reset_sync),                // input wire srst
  .wr_clk(rxclk0),            // input wire wr_clk
  .rd_clk(clk100),            // input wire rd_clk
  .din(fifo0_in),                  // input wire [255 : 0] din
  .wr_en(fifo0_wr_reg && !fifo0_full),  // input wire wr_en
  //.rd_en(fifo_read_pulse),              // input wire rd_en
  .rd_en(fifo_read_d1),
  .dout(fifo0_out),                // output wire [31 : 0] dout
  .full(fifo0_full),                // output wire full
  .empty(fifo0_empty),              // output wire empty
  .wr_rst_busy(wr_rst_busy0),  // output wire wr_rst_busy
  .rd_rst_busy()  // output wire rd_rst_busy
);
*/

fifo_256in_32out FIFO0_ADC (
  .srst(fifo0_reset_sync),                // input wire srst
  .clk(rxclk0),            // input wire wr_clk
  //.rd_clk(clk100),            // input wire rd_clk
  .din(fifo0_in),                  // input wire [255 : 0] din
  .wr_en(fifo0_wr_reg && !fifo0_full),  // input wire wr_en
  //.rd_en(fifo_read_pulse),              // input wire rd_en
  .rd_en(fifo_read_d1),
  .dout(fifo0_out),                // output wire [31 : 0] dout
  .full(fifo0_full),                // output wire full
  .empty(fifo0_empty),              // output wire empty
  .wr_rst_busy(wr_rst_busy0),  // output wire wr_rst_busy
  .rd_rst_busy()  // output wire rd_rst_busy
);

//Now we can remap the FIFO output data so that the ADC bits appear in the correct order
//The Channel mapping is as follows
//      ADC Chan    Bit     RxBank  bank      Bit
//      A           0       126     0           1
//      A           1       126     0           0
//      A           2       126     0           2
//      A           3       126     0           3
//      B           0       125     1           3
//      B           1       125     1           0
//      B           2       127*    2           0 
//      B           3       125     1           2   
//      C           0       127     2           1
//      C           1       125*    1           1
//      C           2       127     2           2
//      C           3       127     2           3
//      D           0       128     3           0
//      D           1       128     3           1
//      D           2       128     3           2
//      D           3       128     3           3
// * because of this error in assigning bits to banks, we'll remap the bits after the FIFOs
//  (since each fifo has its own wr_clk)
//For PCB rev 1
//      ADC Chan    Bit     RxBank  bank      Bit
//      A           0       126     0           1
//      A           1       126     0           0
//      A           2       126     0           2
//      A           3       126     0           3
//      B           0       125     1           3
//      B           1       125     1           0
//      B           2       125     1           1 
//      B           3       125     1           2   
//      C           0       127     2           1
//      C           1       127     2           0
//      C           2       127     2           2
//      C           3       127     2           3
//      D           0       128     3           0
//      D           1       128     3           1
//      D           2       128     3           2
//      D           3       128     3           3

//Each 32b fifo_out bus consists of 8 4-bit samples, but the bits are not in the correct order,
//  AND one bit from bank 1 is swapped with 1 bit from bank 2.  Reassign these in the correct order for the ADC channels here
wire [255:0] ADC_A_out;

generate
if(CHANNEL_SEL == 0) begin: FIFO_CH0
//For ADC A, the bits are all from bank 0, but bits 1 and 0 are swapped
assign ADC_A_out = {
                    fifo0_out[255],fifo0_out[254],fifo0_out[252],fifo0_out[253],
                    fifo0_out[251],fifo0_out[250],fifo0_out[248],fifo0_out[249],
                    fifo0_out[247],fifo0_out[246],fifo0_out[244],fifo0_out[245],
                    fifo0_out[243],fifo0_out[242],fifo0_out[240],fifo0_out[241],
                    fifo0_out[239],fifo0_out[238],fifo0_out[236],fifo0_out[237],
                    fifo0_out[235],fifo0_out[234],fifo0_out[232],fifo0_out[233],
                    fifo0_out[231],fifo0_out[230],fifo0_out[228],fifo0_out[229],
                    fifo0_out[227],fifo0_out[226],fifo0_out[224],fifo0_out[225],
                    fifo0_out[223],fifo0_out[222],fifo0_out[220],fifo0_out[221],
                    fifo0_out[219],fifo0_out[218],fifo0_out[216],fifo0_out[217],
                    fifo0_out[215],fifo0_out[214],fifo0_out[212],fifo0_out[213],
                    fifo0_out[211],fifo0_out[210],fifo0_out[208],fifo0_out[209],
                    fifo0_out[207],fifo0_out[206],fifo0_out[204],fifo0_out[205],
                    fifo0_out[203],fifo0_out[202],fifo0_out[200],fifo0_out[201],
                    fifo0_out[199],fifo0_out[198],fifo0_out[196],fifo0_out[197],
                    fifo0_out[195],fifo0_out[194],fifo0_out[192],fifo0_out[193],
                    fifo0_out[191],fifo0_out[190],fifo0_out[188],fifo0_out[189],
                    fifo0_out[187],fifo0_out[186],fifo0_out[184],fifo0_out[185],
                    fifo0_out[183],fifo0_out[182],fifo0_out[180],fifo0_out[181],
                    fifo0_out[179],fifo0_out[178],fifo0_out[176],fifo0_out[177],
                    fifo0_out[175],fifo0_out[174],fifo0_out[172],fifo0_out[173],
                    fifo0_out[171],fifo0_out[170],fifo0_out[168],fifo0_out[169],
                    fifo0_out[167],fifo0_out[166],fifo0_out[164],fifo0_out[165],
                    fifo0_out[163],fifo0_out[162],fifo0_out[160],fifo0_out[161],
                    fifo0_out[159],fifo0_out[158],fifo0_out[156],fifo0_out[157],
                    fifo0_out[155],fifo0_out[154],fifo0_out[152],fifo0_out[153],
                    fifo0_out[151],fifo0_out[150],fifo0_out[148],fifo0_out[149],
                    fifo0_out[147],fifo0_out[146],fifo0_out[144],fifo0_out[145],
                    fifo0_out[143],fifo0_out[142],fifo0_out[140],fifo0_out[141],
                    fifo0_out[139],fifo0_out[138],fifo0_out[136],fifo0_out[137],
                    fifo0_out[135],fifo0_out[134],fifo0_out[132],fifo0_out[133],
                    fifo0_out[131],fifo0_out[130],fifo0_out[128],fifo0_out[129],
                    fifo0_out[127],fifo0_out[126],fifo0_out[124],fifo0_out[125],
                    fifo0_out[123],fifo0_out[122],fifo0_out[120],fifo0_out[121],
                    fifo0_out[119],fifo0_out[118],fifo0_out[116],fifo0_out[117],
                    fifo0_out[115],fifo0_out[114],fifo0_out[112],fifo0_out[113],
                    fifo0_out[111],fifo0_out[110],fifo0_out[108],fifo0_out[109],
                    fifo0_out[107],fifo0_out[106],fifo0_out[104],fifo0_out[105],
                    fifo0_out[103],fifo0_out[102],fifo0_out[100],fifo0_out[101],
                    fifo0_out[99],fifo0_out[98],fifo0_out[96],fifo0_out[97],
                    fifo0_out[95],fifo0_out[94],fifo0_out[92],fifo0_out[93],
                    fifo0_out[91],fifo0_out[90],fifo0_out[88],fifo0_out[89],
                    fifo0_out[87],fifo0_out[86],fifo0_out[84],fifo0_out[85],
                    fifo0_out[83],fifo0_out[82],fifo0_out[80],fifo0_out[81],
                    fifo0_out[79],fifo0_out[78],fifo0_out[76],fifo0_out[77],
                    fifo0_out[75],fifo0_out[74],fifo0_out[72],fifo0_out[73],
                    fifo0_out[71],fifo0_out[70],fifo0_out[68],fifo0_out[69],
                    fifo0_out[67],fifo0_out[66],fifo0_out[64],fifo0_out[65],
                    fifo0_out[63],fifo0_out[62],fifo0_out[60],fifo0_out[61],
                    fifo0_out[59],fifo0_out[58],fifo0_out[56],fifo0_out[57],
                    fifo0_out[55],fifo0_out[54],fifo0_out[52],fifo0_out[53],
                    fifo0_out[51],fifo0_out[50],fifo0_out[48],fifo0_out[49],
                    fifo0_out[47],fifo0_out[46],fifo0_out[44],fifo0_out[45],
                    fifo0_out[43],fifo0_out[42],fifo0_out[40],fifo0_out[41],
                    fifo0_out[39],fifo0_out[38],fifo0_out[36],fifo0_out[37],
                    fifo0_out[35],fifo0_out[34],fifo0_out[32],fifo0_out[33],
                    fifo0_out[31],fifo0_out[30],fifo0_out[28],fifo0_out[29],
                    fifo0_out[27],fifo0_out[26],fifo0_out[24],fifo0_out[25],
                    fifo0_out[23],fifo0_out[22],fifo0_out[20],fifo0_out[21],
                    fifo0_out[19],fifo0_out[18],fifo0_out[16],fifo0_out[17],
                    fifo0_out[15],fifo0_out[14],fifo0_out[12],fifo0_out[13],
                    fifo0_out[11],fifo0_out[10],fifo0_out[8],fifo0_out[9],
                    fifo0_out[7],fifo0_out[6],fifo0_out[4],fifo0_out[5],
                    fifo0_out[3],fifo0_out[2],fifo0_out[0],fifo0_out[1]};
end
else if(CHANNEL_SEL == 1) begin: FIFO_CH1          
//For ADC B, need to reorder the bits and swap one bit from fifo2
 assign ADC_A_out = {
                    fifo0_out[254],fifo0_out[253],fifo0_out[252],fifo0_out[255],
                    fifo0_out[250],fifo0_out[249],fifo0_out[248],fifo0_out[251],
                    fifo0_out[246],fifo0_out[245],fifo0_out[244],fifo0_out[247],
                    fifo0_out[242],fifo0_out[241],fifo0_out[240],fifo0_out[243],
                    fifo0_out[238],fifo0_out[237],fifo0_out[236],fifo0_out[239],
                    fifo0_out[234],fifo0_out[233],fifo0_out[232],fifo0_out[235],
                    fifo0_out[230],fifo0_out[229],fifo0_out[228],fifo0_out[231],
                    fifo0_out[226],fifo0_out[225],fifo0_out[224],fifo0_out[227],
                    fifo0_out[222],fifo0_out[221],fifo0_out[220],fifo0_out[223],
                    fifo0_out[218],fifo0_out[217],fifo0_out[216],fifo0_out[219],
                    fifo0_out[214],fifo0_out[213],fifo0_out[212],fifo0_out[215],
                    fifo0_out[210],fifo0_out[209],fifo0_out[208],fifo0_out[211],
                    fifo0_out[206],fifo0_out[205],fifo0_out[204],fifo0_out[207],
                    fifo0_out[202],fifo0_out[201],fifo0_out[200],fifo0_out[203],
                    fifo0_out[198],fifo0_out[197],fifo0_out[196],fifo0_out[199],
                    fifo0_out[194],fifo0_out[193],fifo0_out[192],fifo0_out[195],
                    fifo0_out[190],fifo0_out[189],fifo0_out[188],fifo0_out[191],
                    fifo0_out[186],fifo0_out[185],fifo0_out[184],fifo0_out[187],
                    fifo0_out[182],fifo0_out[181],fifo0_out[180],fifo0_out[183],
                    fifo0_out[178],fifo0_out[177],fifo0_out[176],fifo0_out[179],
                    fifo0_out[174],fifo0_out[173],fifo0_out[172],fifo0_out[175],
                    fifo0_out[170],fifo0_out[169],fifo0_out[168],fifo0_out[171],
                    fifo0_out[166],fifo0_out[165],fifo0_out[164],fifo0_out[167],
                    fifo0_out[162],fifo0_out[161],fifo0_out[160],fifo0_out[163],
                    fifo0_out[158],fifo0_out[157],fifo0_out[156],fifo0_out[159],
                    fifo0_out[154],fifo0_out[153],fifo0_out[152],fifo0_out[155],
                    fifo0_out[150],fifo0_out[149],fifo0_out[148],fifo0_out[151],
                    fifo0_out[146],fifo0_out[145],fifo0_out[144],fifo0_out[147],
                    fifo0_out[142],fifo0_out[141],fifo0_out[140],fifo0_out[143],
                    fifo0_out[138],fifo0_out[137],fifo0_out[136],fifo0_out[139],
                    fifo0_out[134],fifo0_out[133],fifo0_out[132],fifo0_out[135],
                    fifo0_out[130],fifo0_out[129],fifo0_out[128],fifo0_out[131],
                    fifo0_out[126],fifo0_out[125],fifo0_out[124],fifo0_out[127],
                    fifo0_out[122],fifo0_out[121],fifo0_out[120],fifo0_out[123],
                    fifo0_out[118],fifo0_out[117],fifo0_out[116],fifo0_out[119],
                    fifo0_out[114],fifo0_out[113],fifo0_out[112],fifo0_out[115],
                    fifo0_out[110],fifo0_out[109],fifo0_out[108],fifo0_out[111],
                    fifo0_out[106],fifo0_out[105],fifo0_out[104],fifo0_out[107],
                    fifo0_out[102],fifo0_out[101],fifo0_out[100],fifo0_out[103],
                    fifo0_out[98],fifo0_out[97],fifo0_out[96],fifo0_out[99],
                    fifo0_out[94],fifo0_out[93],fifo0_out[92],fifo0_out[95],
                    fifo0_out[90],fifo0_out[89],fifo0_out[88],fifo0_out[91],
                    fifo0_out[86],fifo0_out[85],fifo0_out[84],fifo0_out[87],
                    fifo0_out[82],fifo0_out[81],fifo0_out[80],fifo0_out[83],
                    fifo0_out[78],fifo0_out[77],fifo0_out[76],fifo0_out[79],
                    fifo0_out[74],fifo0_out[73],fifo0_out[72],fifo0_out[75],
                    fifo0_out[70],fifo0_out[69],fifo0_out[68],fifo0_out[71],
                    fifo0_out[66],fifo0_out[65],fifo0_out[64],fifo0_out[67],
                    fifo0_out[62],fifo0_out[61],fifo0_out[60],fifo0_out[63],
                    fifo0_out[58],fifo0_out[57],fifo0_out[56],fifo0_out[59],
                    fifo0_out[54],fifo0_out[53],fifo0_out[52],fifo0_out[55],
                    fifo0_out[50],fifo0_out[49],fifo0_out[48],fifo0_out[51],
                    fifo0_out[46],fifo0_out[45],fifo0_out[44],fifo0_out[47],
                    fifo0_out[42],fifo0_out[41],fifo0_out[40],fifo0_out[43],
                    fifo0_out[38],fifo0_out[37],fifo0_out[36],fifo0_out[39],
                    fifo0_out[34],fifo0_out[33],fifo0_out[32],fifo0_out[35],
                    fifo0_out[30],fifo0_out[29],fifo0_out[28],fifo0_out[31],
                    fifo0_out[26],fifo0_out[25],fifo0_out[24],fifo0_out[27],
                    fifo0_out[22],fifo0_out[21],fifo0_out[20],fifo0_out[23],
                    fifo0_out[18],fifo0_out[17],fifo0_out[16],fifo0_out[19],
                    fifo0_out[14],fifo0_out[13],fifo0_out[12],fifo0_out[15],
                    fifo0_out[10],fifo0_out[9],fifo0_out[8],fifo0_out[11],
                    fifo0_out[6],fifo0_out[5],fifo0_out[4],fifo0_out[7],
                    fifo0_out[2],fifo0_out[1],fifo0_out[0],fifo0_out[3]};
end
else if(CHANNEL_SEL == 2) begin: FIFO_CH2
//For ADC C, need to reorder the bits
assign ADC_A_out = {
                    fifo0_out[255],fifo0_out[254],fifo0_out[252],fifo0_out[253],
                    fifo0_out[251],fifo0_out[250],fifo0_out[248],fifo0_out[249],
                    fifo0_out[247],fifo0_out[246],fifo0_out[244],fifo0_out[245],
                    fifo0_out[243],fifo0_out[242],fifo0_out[240],fifo0_out[241],
                    fifo0_out[239],fifo0_out[238],fifo0_out[236],fifo0_out[237],
                    fifo0_out[235],fifo0_out[234],fifo0_out[232],fifo0_out[233],
                    fifo0_out[231],fifo0_out[230],fifo0_out[228],fifo0_out[229],
                    fifo0_out[227],fifo0_out[226],fifo0_out[224],fifo0_out[225],
                    fifo0_out[223],fifo0_out[222],fifo0_out[220],fifo0_out[221],
                    fifo0_out[219],fifo0_out[218],fifo0_out[216],fifo0_out[217],
                    fifo0_out[215],fifo0_out[214],fifo0_out[212],fifo0_out[213],
                    fifo0_out[211],fifo0_out[210],fifo0_out[208],fifo0_out[209],
                    fifo0_out[207],fifo0_out[206],fifo0_out[204],fifo0_out[205],
                    fifo0_out[203],fifo0_out[202],fifo0_out[200],fifo0_out[201],
                    fifo0_out[199],fifo0_out[198],fifo0_out[196],fifo0_out[197],
                    fifo0_out[195],fifo0_out[194],fifo0_out[192],fifo0_out[193],
                    fifo0_out[191],fifo0_out[190],fifo0_out[188],fifo0_out[189],
                    fifo0_out[187],fifo0_out[186],fifo0_out[184],fifo0_out[185],
                    fifo0_out[183],fifo0_out[182],fifo0_out[180],fifo0_out[181],
                    fifo0_out[179],fifo0_out[178],fifo0_out[176],fifo0_out[177],
                    fifo0_out[175],fifo0_out[174],fifo0_out[172],fifo0_out[173],
                    fifo0_out[171],fifo0_out[170],fifo0_out[168],fifo0_out[169],
                    fifo0_out[167],fifo0_out[166],fifo0_out[164],fifo0_out[165],
                    fifo0_out[163],fifo0_out[162],fifo0_out[160],fifo0_out[161],
                    fifo0_out[159],fifo0_out[158],fifo0_out[156],fifo0_out[157],
                    fifo0_out[155],fifo0_out[154],fifo0_out[152],fifo0_out[153],
                    fifo0_out[151],fifo0_out[150],fifo0_out[148],fifo0_out[149],
                    fifo0_out[147],fifo0_out[146],fifo0_out[144],fifo0_out[145],
                    fifo0_out[143],fifo0_out[142],fifo0_out[140],fifo0_out[141],
                    fifo0_out[139],fifo0_out[138],fifo0_out[136],fifo0_out[137],
                    fifo0_out[135],fifo0_out[134],fifo0_out[132],fifo0_out[133],
                    fifo0_out[131],fifo0_out[130],fifo0_out[128],fifo0_out[129],
                    fifo0_out[127],fifo0_out[126],fifo0_out[124],fifo0_out[125],
                    fifo0_out[123],fifo0_out[122],fifo0_out[120],fifo0_out[121],
                    fifo0_out[119],fifo0_out[118],fifo0_out[116],fifo0_out[117],
                    fifo0_out[115],fifo0_out[114],fifo0_out[112],fifo0_out[113],
                    fifo0_out[111],fifo0_out[110],fifo0_out[108],fifo0_out[109],
                    fifo0_out[107],fifo0_out[106],fifo0_out[104],fifo0_out[105],
                    fifo0_out[103],fifo0_out[102],fifo0_out[100],fifo0_out[101],
                    fifo0_out[99],fifo0_out[98],fifo0_out[96],fifo0_out[97],
                    fifo0_out[95],fifo0_out[94],fifo0_out[92],fifo0_out[93],
                    fifo0_out[91],fifo0_out[90],fifo0_out[88],fifo0_out[89],
                    fifo0_out[87],fifo0_out[86],fifo0_out[84],fifo0_out[85],
                    fifo0_out[83],fifo0_out[82],fifo0_out[80],fifo0_out[81],
                    fifo0_out[79],fifo0_out[78],fifo0_out[76],fifo0_out[77],
                    fifo0_out[75],fifo0_out[74],fifo0_out[72],fifo0_out[73],
                    fifo0_out[71],fifo0_out[70],fifo0_out[68],fifo0_out[69],
                    fifo0_out[67],fifo0_out[66],fifo0_out[64],fifo0_out[65],
                    fifo0_out[63],fifo0_out[62],fifo0_out[60],fifo0_out[61],
                    fifo0_out[59],fifo0_out[58],fifo0_out[56],fifo0_out[57],
                    fifo0_out[55],fifo0_out[54],fifo0_out[52],fifo0_out[53],
                    fifo0_out[51],fifo0_out[50],fifo0_out[48],fifo0_out[49],
                    fifo0_out[47],fifo0_out[46],fifo0_out[44],fifo0_out[45],
                    fifo0_out[43],fifo0_out[42],fifo0_out[40],fifo0_out[41],
                    fifo0_out[39],fifo0_out[38],fifo0_out[36],fifo0_out[37],
                    fifo0_out[35],fifo0_out[34],fifo0_out[32],fifo0_out[33],
                    fifo0_out[31],fifo0_out[30],fifo0_out[28],fifo0_out[29],
                    fifo0_out[27],fifo0_out[26],fifo0_out[24],fifo0_out[25],
                    fifo0_out[23],fifo0_out[22],fifo0_out[20],fifo0_out[21],
                    fifo0_out[19],fifo0_out[18],fifo0_out[16],fifo0_out[17],
                    fifo0_out[15],fifo0_out[14],fifo0_out[12],fifo0_out[13],
                    fifo0_out[11],fifo0_out[10],fifo0_out[8],fifo0_out[9],
                    fifo0_out[7],fifo0_out[6],fifo0_out[4],fifo0_out[5],
                    fifo0_out[3],fifo0_out[2],fifo0_out[0],fifo0_out[1]};
end
else if(CHANNEL_SEL == 3)begin: FIFO_CHAN3
//For ADC D, the bits are all from bank 3, and in the correct order already
assign ADC_A_out = {
                    fifo0_out[255],fifo0_out[254],fifo0_out[253],fifo0_out[252],
                    fifo0_out[251],fifo0_out[250],fifo0_out[249],fifo0_out[248],
                    fifo0_out[247],fifo0_out[246],fifo0_out[245],fifo0_out[244],
                    fifo0_out[243],fifo0_out[242],fifo0_out[241],fifo0_out[240],
                    fifo0_out[239],fifo0_out[238],fifo0_out[237],fifo0_out[236],
                    fifo0_out[235],fifo0_out[234],fifo0_out[233],fifo0_out[232],
                    fifo0_out[231],fifo0_out[230],fifo0_out[229],fifo0_out[228],
                    fifo0_out[227],fifo0_out[226],fifo0_out[225],fifo0_out[224],
                    fifo0_out[223],fifo0_out[222],fifo0_out[221],fifo0_out[220],
                    fifo0_out[219],fifo0_out[218],fifo0_out[217],fifo0_out[216],
                    fifo0_out[215],fifo0_out[214],fifo0_out[213],fifo0_out[212],
                    fifo0_out[211],fifo0_out[210],fifo0_out[209],fifo0_out[208],
                    fifo0_out[207],fifo0_out[206],fifo0_out[205],fifo0_out[204],
                    fifo0_out[203],fifo0_out[202],fifo0_out[201],fifo0_out[200],
                    fifo0_out[199],fifo0_out[198],fifo0_out[197],fifo0_out[196],
                    fifo0_out[195],fifo0_out[194],fifo0_out[193],fifo0_out[192],
                    fifo0_out[191],fifo0_out[190],fifo0_out[189],fifo0_out[188],
                    fifo0_out[187],fifo0_out[186],fifo0_out[185],fifo0_out[184],
                    fifo0_out[183],fifo0_out[182],fifo0_out[181],fifo0_out[180],
                    fifo0_out[179],fifo0_out[178],fifo0_out[177],fifo0_out[176],
                    fifo0_out[175],fifo0_out[174],fifo0_out[173],fifo0_out[172],
                    fifo0_out[171],fifo0_out[170],fifo0_out[169],fifo0_out[168],
                    fifo0_out[167],fifo0_out[166],fifo0_out[165],fifo0_out[164],
                    fifo0_out[163],fifo0_out[162],fifo0_out[161],fifo0_out[160],
                    fifo0_out[159],fifo0_out[158],fifo0_out[157],fifo0_out[156],
                    fifo0_out[155],fifo0_out[154],fifo0_out[153],fifo0_out[152],
                    fifo0_out[151],fifo0_out[150],fifo0_out[149],fifo0_out[148],
                    fifo0_out[147],fifo0_out[146],fifo0_out[145],fifo0_out[144],
                    fifo0_out[143],fifo0_out[142],fifo0_out[141],fifo0_out[140],
                    fifo0_out[139],fifo0_out[138],fifo0_out[137],fifo0_out[136],
                    fifo0_out[135],fifo0_out[134],fifo0_out[133],fifo0_out[132],
                    fifo0_out[131],fifo0_out[130],fifo0_out[129],fifo0_out[128],
                    fifo0_out[127],fifo0_out[126],fifo0_out[125],fifo0_out[124],
                    fifo0_out[123],fifo0_out[122],fifo0_out[121],fifo0_out[120],
                    fifo0_out[119],fifo0_out[118],fifo0_out[117],fifo0_out[116],
                    fifo0_out[115],fifo0_out[114],fifo0_out[113],fifo0_out[112],
                    fifo0_out[111],fifo0_out[110],fifo0_out[109],fifo0_out[108],
                    fifo0_out[107],fifo0_out[106],fifo0_out[105],fifo0_out[104],
                    fifo0_out[103],fifo0_out[102],fifo0_out[101],fifo0_out[100],
                    fifo0_out[99],fifo0_out[98],fifo0_out[97],fifo0_out[96],
                    fifo0_out[95],fifo0_out[94],fifo0_out[93],fifo0_out[92],
                    fifo0_out[91],fifo0_out[90],fifo0_out[89],fifo0_out[88],
                    fifo0_out[87],fifo0_out[86],fifo0_out[85],fifo0_out[84],
                    fifo0_out[83],fifo0_out[82],fifo0_out[81],fifo0_out[80],
                    fifo0_out[79],fifo0_out[78],fifo0_out[77],fifo0_out[76],
                    fifo0_out[75],fifo0_out[74],fifo0_out[73],fifo0_out[72],
                    fifo0_out[71],fifo0_out[70],fifo0_out[69],fifo0_out[68],
                    fifo0_out[67],fifo0_out[66],fifo0_out[65],fifo0_out[64],
                    fifo0_out[63],fifo0_out[62],fifo0_out[61],fifo0_out[60],
                    fifo0_out[59],fifo0_out[58],fifo0_out[57],fifo0_out[56],
                    fifo0_out[55],fifo0_out[54],fifo0_out[53],fifo0_out[52],
                    fifo0_out[51],fifo0_out[50],fifo0_out[49],fifo0_out[48],
                    fifo0_out[47],fifo0_out[46],fifo0_out[45],fifo0_out[44],
                    fifo0_out[43],fifo0_out[42],fifo0_out[41],fifo0_out[40],
                    fifo0_out[39],fifo0_out[38],fifo0_out[37],fifo0_out[36],
                    fifo0_out[35],fifo0_out[34],fifo0_out[33],fifo0_out[32],
                    fifo0_out[31],fifo0_out[30],fifo0_out[29],fifo0_out[28],
                    fifo0_out[27],fifo0_out[26],fifo0_out[25],fifo0_out[24],
                    fifo0_out[23],fifo0_out[22],fifo0_out[21],fifo0_out[20],
                    fifo0_out[19],fifo0_out[18],fifo0_out[17],fifo0_out[16],
                    fifo0_out[15],fifo0_out[14],fifo0_out[13],fifo0_out[12],
                    fifo0_out[11],fifo0_out[10],fifo0_out[9],fifo0_out[8],
                    fifo0_out[7],fifo0_out[6],fifo0_out[5],fifo0_out[4],
                    fifo0_out[3],fifo0_out[2],fifo0_out[1],fifo0_out[0]};
end
endgenerate
//Now mux these four busses into one 32b output      
             
   always @(ADC_A_out)
         data_out = ADC_A_out;
   always @(fifo0_full)
         fifo_full = fifo0_full;
   always @(fifo0_empty)
         fifo_empty = fifo0_empty;
         
   /* 
   always @(posedge clk100)
         data_out <= ADC_A_out;
   always @(posedge clk100)
         fifo_full <= fifo0_full;
   always @(posedge clk100)
         fifo_empty <= fifo0_empty;   
   */
endmodule
