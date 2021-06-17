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


module dts_gty_rx #(
    parameter N_REFCLOCKS = 3,
    parameter REFCLOCK_0 = 0,
    parameter REFCLOCK_1 = 1,
    parameter REFCLOCK_2 = 2,
    parameter INSTANCE_NUMBER = 0,
    parameter MUX_FACTOR_BITS = 0
  ) (

    input         wb_clk_i,
    input         wb_rst_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    input  [31:0] wb_adr_i,
    input  [3:0]  wb_sel_i,
    input  [31:0] wb_dat_i,
    input         wb_we_i,
    input         wb_cyc_i,
    input         wb_stb_i,


    input [11:0] rx_p,
    input [11:0] rx_n,
    output [11:0] tx_p,
    output [11:0] tx_n,
    input [N_REFCLOCKS-1:0] mgtrefclk_p,
    input [N_REFCLOCKS-1:0] mgtrefclk_n,
    input clk_50,
    input rst,
    input [2:0] qsfp_modprsl,
    
    input  clkout,
    output [((12*128) >> MUX_FACTOR_BITS) - 1 : 0] dout,
    output [12*2 - 1 : 0] dvld,
    output [12 - 1 : 0] locked,
    output [12 - 1 : 0] one_sec,
    output [12 - 1 : 0] ten_sec,
    output [12 - 1 : 0] index,
    output [12 - 1 : 0] sync,
    output [63:0] status,
    output clk_mux_0,
    output clk_mux_90,
    output clk_mux_180,
    output clk_mux_270
  );
  
  localparam N_INPUTS = 12; 
  localparam INPUT_DWIDTH = 160;
  localparam OUTPUT_DWIDTH = 128;
  localparam POST_MUX_OUTPUT_DWIDTH = (OUTPUT_DWIDTH >> MUX_FACTOR_BITS);
    
  wire [N_INPUTS*INPUT_DWIDTH - 1 : 0] gt_dout;
  wire gt_clkout;
  (* mark_debug = "true" *) wire [2:0] qsfp_modprsl_debug = qsfp_modprsl;
  (* mark_debug = "true" *) wire all_qsfp_present = ~|qsfp_modprsl;
  
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] bitslip_int;
  wire [11:0] induce_error;
  gty_12chan #(
    .N_REFCLOCKS(N_REFCLOCKS),
    .REFCLOCK_0(REFCLOCK_0),
    .REFCLOCK_1(REFCLOCK_1),
    .REFCLOCK_2(REFCLOCK_2),
    .INSTANCE_NUMBER(INSTANCE_NUMBER)
  ) gty_inst (
    .rx_p(rx_p),
    .rx_n(rx_n),
    .tx_p(tx_p),
    .tx_n(tx_n),
    .mgtrefclk_p(mgtrefclk_p),
    .mgtrefclk_n(mgtrefclk_n),
    .induce_error(induce_error),
    .clk50(clk_50),
    .rst(rst),
    .gearbox_slip(bitslip_int),
   
    .clkout(gt_clkout),
    .dout(gt_dout)
  );
  
  wire clk_fb_int, clk_fb;
  wire clk_mux_0_int;
  wire clk_mux_90_int;
  wire clk_mux_180_int;
  wire clk_mux_270_int;
  (* mark_debug = "true" *) wire mmcm_locked;
  
    MMCM_BASE #(
   .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
   .CLKFBOUT_MULT_F    (24), // Multiply value for all CLKOUT (5.0-64.0).
   .CLKFBOUT_PHASE     (0.0),
   .CLKIN1_PERIOD      (16), // 62.5 MHz clock from GT
   .CLKOUT0_DIVIDE_F   (24.0), // 500M: overall * 8, Divide amount for CLKOUT0 (1.000-128.000).
   .CLKOUT0_DUTY_CYCLE (0.5),
   .CLKOUT1_DUTY_CYCLE (0.5),
   .CLKOUT2_DUTY_CYCLE (0.5),
   .CLKOUT3_DUTY_CYCLE (0.5),
   .CLKOUT4_DUTY_CYCLE (0.5),
   .CLKOUT5_DUTY_CYCLE (0.5),
   .CLKOUT6_DUTY_CYCLE (0.5),
   .CLKOUT0_PHASE      (0.0),
   .CLKOUT1_PHASE      (90.0),
   .CLKOUT2_PHASE      (180.0),
   .CLKOUT3_PHASE      (270.0),
   .CLKOUT4_PHASE      (0.0),
   .CLKOUT5_PHASE      (0.0),
   .CLKOUT6_PHASE      (0.0),
   .CLKOUT1_DIVIDE     (24>>MUX_FACTOR_BITS),
   .CLKOUT2_DIVIDE     (24>>MUX_FACTOR_BITS),
   .CLKOUT3_DIVIDE     (1),
   .CLKOUT4_DIVIDE     (1),
   .CLKOUT5_DIVIDE     (1),
   .CLKOUT6_DIVIDE     (1),
   .CLKOUT4_CASCADE    ("FALSE"),
   .CLOCK_HOLD         ("FALSE"),
   .DIVCLK_DIVIDE      (1),
   .REF_JITTER1        (0.0),
   .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_inst (
   .CLKIN1   (gt_clkout),
   .CLKFBIN  (clk_fb),
   .CLKFBOUT  (clk_fb_int),
   .CLKFBOUTB (),

   .CLKOUT0  (),
   .CLKOUT0B (),
   .CLKOUT1  (clk_mux_0_int),
   .CLKOUT1B (clk_mux_180_int),
   .CLKOUT2  (clk_mux_90_int),
   .CLKOUT2B (clk_mux_270_int),
   .CLKOUT3  (),
   .CLKOUT3B (),
   .CLKOUT4  (),
   .CLKOUT5  (),
   .CLKOUT6  (),
   .LOCKED   (mmcm_locked),

   .PWRDWN   (1'b0),
   .RST      (1'b0)//(~rx_clk_ok)

  );
  
  BUFG bufg_inst[4:0](
    .I({clk_fb_int, clk_mux_0_int, clk_mux_90_int, clk_mux_180_int, clk_mux_270_int}),
    .O({clk_fb, clk_mux_0, clk_mux_90, clk_mux_180, clk_mux_270})
  );
  
  
  wire [7:0] mc_data;
  wire [N_INPUTS*8 - 1 : 0] mc_sel;
  wire [N_INPUTS-1:0] mc_cs, mc_wrstb, mc_rdstb;
  wire [N_INPUTS-1:0] unmute;

  (* mark_debug = "true" *) wire [OUTPUT_DWIDTH-1:0] deformat_out0;
  (* mark_debug = "true" *) wire [OUTPUT_DWIDTH-1:0] deformat_out1;
  (* mark_debug = "true" *) wire [OUTPUT_DWIDTH-1:0] deformat_out2;
  
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] def_index_out;
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] def_one_sec_out;
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] def_ten_sec_out;
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] f_clock;
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] def_locked_out;
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] time_mode;
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] def_sync_out;
  (* mark_debug = "true" *) wire [N_INPUTS-1:0] data_source;

/* Generate bitslip trigger from active low resync trigger.
 * Use a shift register to make it appear that the input data
 * stream is unlocked for 128 clocks after a bitslip.
 * This prevents multiple bitslips within this period, to
 * comply with GTY RXSLIDE port rules.
 */
wire [N_INPUTS-1:0] def_resync;
assign bitslip_int = ~def_resync;

wire [N_INPUTS-1:0] faux_lock;
reg [N_INPUTS*OUTPUT_DWIDTH - 1 : 0] bitslip_delay;
generate
for (genvar i=0; i<12; i=i+1) begin
  always @(posedge gt_clkout) begin
    bitslip_delay[OUTPUT_DWIDTH*(i+1) - 1 : OUTPUT_DWIDTH*i] <= {bitslip_delay[128*(i+1) - 2 : 128*i], bitslip_int[i]};
  end
  assign faux_lock[i] = bitslip_delay[OUTPUT_DWIDTH*(i+1) - 1 : OUTPUT_DWIDTH*i] == {OUTPUT_DWIDTH{1'b0}};
end
endgenerate

(* mark_debug = "true" *) wire [7:0] def_data;
(* mark_debug = "true" *) wire [7:0] def_addr;
(* mark_debug = "true" *) wire [N_INPUTS-1:0] def_cs;
(* mark_debug = "true" *) wire def_wrst;
(* mark_debug = "true" *) wire def_rdst;
(* mark_debug = "true" *) wire def_unmute;
wire [7:0] def_data_int;

wire [7:0] def_data_in;
wire [7:0] def_data_out;

assign def_data = def_data_out;

wire [N_INPUTS-1:0] shift_advance;
wire [N_INPUTS-1:0] shift_delay;
wire shift_rst;
wire [N_INPUTS*4-1:0] mux_control;
wire is_three_bit;
wb_dts_attach wb_dts_attach_inst(
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wb_dat_o(wb_dat_o),
    .wb_err_o(wb_err_o),
    .wb_ack_o(wb_ack_o),
    .wb_adr_i(wb_adr_i),
    .wb_sel_i(wb_sel_i),
    .wb_dat_i(wb_dat_i),
    .wb_we_i(wb_we_i),
    .wb_cyc_i(wb_cyc_i),
    .wb_stb_i(wb_stb_i),
    .user_clk(gt_clkout),
    .data_in(def_data_out),
    .data_out(def_data_in),
    .addr_out(def_addr),
    .cs_out(def_cs),
    .wrst_out(def_wrst),
    .rdst_out(def_rdst),
    .unmute_out(def_unmute),
    .locked({9'b0, def_locked_out}),
    .shift_advance(shift_advance),
    .shift_delay(shift_delay),
    .shift_rst(shift_rst),
    .mux_control(mux_control),
    .induce_error(induce_error),
    .is_three_bit(is_three_bit)
  );

  
  wire [N_INPUTS*8 - 1 : 0] def_data_out_multi;
  wire [N_INPUTS*OUTPUT_DWIDTH-1:0] def_frame_out;
  deformatter_seti #(
  ) deformatter_inst[N_INPUTS-1:0] (
    .rx_in(gt_dout),           // 160-bit demuxed data
    .rx_inclock(gt_clkout),    // clock at 10.24GHz/160 (64 MHz)
    .rx_locked(faux_lock),     // Receiver locked
    .lockdet(1'b1),            // (non-existent) demux chip locked.
    .def_out(def_frame_out),   // one 128-bit frame of data
    .index(def_index_out),     // 10 ms metaframe index
    .one_sec(def_one_sec_out), //  1 pps
    .ten_sec(def_ten_sec_out), // .1 pps
    .f_clock(f_clock),         // Frame clock derived from input. This is just rx_inclock
    .locked(def_locked_out),       // deformatter has locked

    // Monitor and control related ports
    .din(def_data_in),
    .dout(def_data_out_multi),
    .sel(def_addr),
    .cs(~def_cs),
    .wrstb(def_wrst),
    .rdstb(def_rdst),
    .unmute(def_unmute),
    // Resync goes low to indicate we should relock the (non-existant) demux chip.
    // I.e., bitslip on low.
    .resync(def_resync),
    .time_mode(time_mode),
    .sync(def_sync_out),
    .data_source(data_source)
  );
  
  
  //TODO: Figure out the generate math
  assign def_data_out = def_data_out_multi[1*8-1:0*8] |
                        def_data_out_multi[2*8-1:1*8] |
                        def_data_out_multi[3*8-1:2*8] |
                        def_data_out_multi[4*8-1:3*8] |
                        def_data_out_multi[5*8-1:4*8] |
                        def_data_out_multi[6*8-1:5*8] |
                        def_data_out_multi[7*8-1:6*8] |
                        def_data_out_multi[8*8-1:7*8] |
                        def_data_out_multi[9*8-1:8*8] |
                        def_data_out_multi[10*8-1:9*8] |
                        def_data_out_multi[11*8-1:10*8];

  wire [N_INPUTS*OUTPUT_DWIDTH-1:0] reorder_frame_out;
  wire [N_INPUTS-1:0] reorder_one_sec_out;
  wire [N_INPUTS-1:0] reorder_ten_sec_out;
  wire [N_INPUTS-1:0] reorder_index_out;
  wire [N_INPUTS-1:0] reorder_sync_out;
  wire [N_INPUTS-1:0] reorder_locked_out;

  dts_reorder #(
    .N_INPUTS(N_INPUTS),
    .INPUT_WIDTH(OUTPUT_DWIDTH),
    .SELECT_WIDTH(4)
  ) dts_reorder_inst[N_INPUTS-1:0] (
    .clk(gt_clkout),
    .sel(mux_control),
    .din(def_frame_out),
    .din_locked(def_locked_out),
    .din_one_sec(def_one_sec_out),
    .din_ten_sec(def_ten_sec_out),
    .din_index(def_index_out),
    .din_sync(def_sync_out),
    .dout(reorder_frame_out),
    .dout_locked(reorder_locked_out),
    .dout_one_sec(reorder_one_sec_out),
    .dout_ten_sec(reorder_ten_sec_out),
    .dout_index(reorder_index_out),
    .dout_sync(reorder_sync_out)
  );


  wire [N_INPUTS*POST_MUX_OUTPUT_DWIDTH-1:0] offsetter_dout;

  dts_offsetter #(
     .MUX_FACTOR_BITS(MUX_FACTOR_BITS)
  ) dts_offseter_inst[N_INPUTS-1:0] (
    .clk_in(gt_clkout),
    .clk_out(clk_mux_0),
    .rst(shift_rst),
    .din(reorder_frame_out),
    .din_one_sec(reorder_one_sec_out),
    .din_ten_sec(reorder_ten_sec_out),
    .din_index(reorder_index_out),
    .din_sync(reorder_sync_out),
    .advance(shift_advance),
    .delay(shift_delay),
    .almost_full(),
    .almost_empty(),
    .overflow(),
    .underflow(),
    .dout(offsetter_dout),
    .dout_one_sec(one_sec),
    .dout_ten_sec(ten_sec),
    .dout_index(index),
    .dout_sync(sync)
  );

  dts_build_samples #(
    .INPUT_WIDTH(POST_MUX_OUTPUT_DWIDTH)
  ) dts_build_samples_inst[3:0] (
    .is_three_bit(is_three_bit),
    .din(offsetter_dout),
    .dout(dout)
  );
  
  assign locked = reorder_locked_out;

endmodule
