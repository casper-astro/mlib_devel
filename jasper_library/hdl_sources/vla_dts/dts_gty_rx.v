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


module dts_gty_rx(
    input [11:0] rx_p,
    input [11:0] rx_n,
    output [11:0] tx_p,
    output [11:0] tx_n,
    input mgtrefclk0_p,
    input mgtrefclk0_n,
    input mgtrefclk1_p,
    input mgtrefclk1_n,
    input clk100,
    input rst,
    input [11:0] gearbox_slip,
    input [2:0] qsfp_modprsl,
    
    output clkout,
    output [12*16 - 1 : 0] dout,
    output [12*2 - 1 : 0] dvld,
    output [12*6 - 1 : 0] hdr,
    output [12*2 - 1 : 0] hdrvld,
    output [12 - 1 : 0] locked,
    output [12 - 1 : 0] one_sec,
    output [12 - 1 : 0] ten_sec,
    output [12 - 1 : 0] index,
    output [63:0] status,
    output clk_500_0,
    output clk_500_90,
    output clk_500_180,
    output clk_500_270
  );
    
    
  wire [12*32 - 1 : 0] gt_dout;
  wire [12*2 - 1 : 0] gt_dvld;
  wire gt_clkout;

  wire all_qsfp_present = ~|qsfp_modprsl;
  
  gty_12chan gty_inst (
    .rx_p(rx_p),
    .rx_n(rx_n),
    .tx_p(tx_p),
    .tx_n(tx_n),
    .mgtrefclk0_p(mgtrefclk0_p),
    .mgtrefclk0_n(mgtrefclk0_n),
    .mgtrefclk1_p(mgtrefclk1_p),
    .mgtrefclk1_n(mgtrefclk1_n),
    .clk100(clk100),
    .rst(rst & (~all_qsfp_present)),
    .gearbox_slip(gearbox_slip),
    
    .clkout(gt_clkout),
    .dout(gt_dout),
    .dvld(gt_dvld),
    .hdr(hdr),
    .hdrvld(hdrvld),
    .status(status)
  );
  wire rx_clk_ok = status[0];
  
  wire clk_fb;
  wire clk_div5_int, clk_div5;
  wire clk_500_0_int;
  wire clk_500_90_int;
  wire clk_500_180_int;
  wire clk_500_270_int;
  wire mmcm_locked;
  
    MMCM_BASE #(
   .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
   .CLKFBOUT_MULT_F    (24), // Multiply value for all CLKOUT (5.0-64.0).
   .CLKFBOUT_PHASE     (0.0),
   .CLKIN1_PERIOD      (3.2), // 312 MHz clock from GT
   .CLKOUT0_DIVIDE_F   (3.0), // Divide amount for CLKOUT0 (1.000-128.000).
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
   .CLKOUT1_DIVIDE     (3), // overall * 8/5
   .CLKOUT2_DIVIDE     (3), // overall * 8/5
   .CLKOUT3_DIVIDE     (3), // overall * 8/5
   .CLKOUT4_DIVIDE     (24), // overall /5
   .CLKOUT5_DIVIDE     (1),
   .CLKOUT6_DIVIDE     (1),
   .CLKOUT4_CASCADE    ("FALSE"),
   .CLOCK_HOLD         ("FALSE"),
   .DIVCLK_DIVIDE      (5), // Master division value (1-80)
   .REF_JITTER1        (0.0),
   .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_inst (
   .CLKIN1   (gt_clkout),
   .CLKFBIN  (clk_fb),
   .CLKFBOUT  (clk_fb),
   .CLKFBOUTB (),

   .CLKOUT0  (clk_500_0_int),
   .CLKOUT0B (clk_500_180_int),
   .CLKOUT1  (clk_500_90_int),
   .CLKOUT1B (clk_500_270_int),
   .CLKOUT2  (),
   .CLKOUT2B (),
   .CLKOUT3  (),
   .CLKOUT3B (),
   .CLKOUT4  (clk_div5_int),
   .CLKOUT5  (),
   .CLKOUT6  (),
   .LOCKED   (mmcm_locked),

   .PWRDWN   (1'b0),
   .RST      (~rx_clock_ok)

  );
  
  BUFG bufg_inst[4:0](
    .I({clk_div5_int, clk_500_0_int, clk_500_90_int, clk_500_180_int, clk_500_270_int}),
    .O({clk_div5, clk_500_0, clk_500_90, clk_500_180, clk_500_270})
  );
  
  wire [12*160 - 1 : 0] demux_dout;
  demux_5x demuxer[11:0] (
    .clk(gt_clkout),
    .vld(1'b1),
    .din(gt_dout),
    .dout(demux_dout)
  );
  
  wire [7:0] mc_data;
  wire [12*8 - 1 : 0] mc_sel;
  wire [11:0] mc_cs, mc_wrstb, mc_rdstb;
  wire [11:0] unmute;
 
  wire [12*128 - 1 : 0] data_slow;
  wire [11:0] index_slow;
  wire [11:0] one_sec_slow;
  wire [11:0] ten_sec_slow;
  wire [11:0] locked_slow;
  deformatter_seti deformatter_inst[11:0] (
    .rx_in(demux_dout),
    .frame_clock(clk_div5),
    .rx_locked(mmcm_locked),
    .lockdet(1'b1),
    // Outputs
    .def_out(data_slow),
    .index(index_slow),
    .one_sec(one_sec_slow),
    .ten_sec(ten_sec_slow),
    .f_clock(), // This is just clk_div5
    .locked(locked_slow),
    // M&C ports
    .data(mc_data),
    .sel(mc_sel),
    .cs(mc_cs),
    .wrstb(mc_wrstb),
    .rdstb(mc_rdstb),
    .unmute(unmute), // ??
    .resync(),
    .time_mode(),
    .sync(),
    .data_source()
  );

  mux8x muxer[11:0] (
    .din(data_slow),
    .fast_clock(clk_500_0),
    .dout(dout),
    .index(index_slow),
    .one_sec(one_sec_slow),
    .ten_sec(ten_sec_slow),
    .locked(locked_slow),
    .index4x(index),
    .one_sec4x(one_sec),
    .ten_sec4x(ten_sec),
    .locked4x(locked)
  );
  
  
endmodule
