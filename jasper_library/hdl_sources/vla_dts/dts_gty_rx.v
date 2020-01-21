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
    
    output clkout,
    output [12*32 - 1 : 0] dout,
    output [12*2 - 1 : 0] dvld,
    output [12*6 - 1 : 0] hdr,
    output [12*2 - 1 : 0] hdrvld,
    output [63:0] status
  );
    
    
  wire [12*32 - 1 : 0] gt_dout;
  wire [12*2 - 1 : 0] gt_dvld;
  wire gt_clkout;
  
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
    .rst(rst),
    .gearbox_slip(gearbox_slip),
    
    .clkout(gt_clkout),
    .dout(gt_dout),
    .dvld(gt_dvld),
    .hdr(hdr),
    .hdrvld(hdrvld),
    .status(status)
  );
  
  wire clk_fb;
  wire clk_div5_int, clk_div5;
  wire clk_mult2_int, clk_mult2;
  
    MMCM_BASE #(
   .BANDWIDTH          ("OPTIMIZED"), // Jitter programming ("HIGH","LOW","OPTIMIZED")
   .CLKFBOUT_MULT_F    (4), // Multiply value for all CLKOUT (5.0-64.0).
   .CLKFBOUT_PHASE     (0.0),
   .CLKIN1_PERIOD      (3.2), // 312 MHz clock from GT
   .CLKOUT0_DIVIDE_F   (1.0), // Divide amount for CLKOUT0 (1.000-128.000).
   .CLKOUT0_DUTY_CYCLE (0.5),
   .CLKOUT1_DUTY_CYCLE (0.5),
   .CLKOUT2_DUTY_CYCLE (0.5),
   .CLKOUT3_DUTY_CYCLE (0.5),
   .CLKOUT4_DUTY_CYCLE (0.5),
   .CLKOUT5_DUTY_CYCLE (0.5),
   .CLKOUT6_DUTY_CYCLE (0.5),
   .CLKOUT0_PHASE      (0.0),
   .CLKOUT1_PHASE      (0.0),
   .CLKOUT2_PHASE      (0.0),
   .CLKOUT3_PHASE      (0.0),
   .CLKOUT4_PHASE      (0.0),
   .CLKOUT5_PHASE      (0.0),
   .CLKOUT6_PHASE      (0.0),
   .CLKOUT1_DIVIDE     (20), // overall /5
   .CLKOUT2_DIVIDE     (2),  // overall x 2
   .CLKOUT3_DIVIDE     (1),
   .CLKOUT4_DIVIDE     (1),
   .CLKOUT5_DIVIDE     (1),
   .CLKOUT6_DIVIDE     (1),
   .CLKOUT4_CASCADE    ("FALSE"),
   .CLOCK_HOLD         ("FALSE"),
   .DIVCLK_DIVIDE      (1), // Master division value (1-80)
   .REF_JITTER1        (0.0),
   .STARTUP_WAIT       ("FALSE")
  ) MMCM_BASE_inst (
   .CLKIN1   (gt_clkout),
   .CLKFBIN  (clk_fb),
   .CLKFBOUT  (clk_fb),
   .CLKFBOUTB (),

   .CLKOUT0  (clk_div5_int),
   .CLKOUT0B (),
   .CLKOUT1  (clk_mult2_int),
   .CLKOUT1B (),
   .CLKOUT2  (),
   .CLKOUT2B (),
   .CLKOUT3  (),
   .CLKOUT3B (),
   .CLKOUT4  (),
   .CLKOUT5  (),
   .CLKOUT6  (),
   .LOCKED   (),

   .PWRDWN   (1'b0),
   .RST      (1'b0)

  );
  
  BUFG bufg_inst[1:0](
    .I({clk_div5_int, clk_mult2_int}),
    .O({clk_div5, clk_mult2})
  );
  
  wire [12*160 - 1 : 0] demux_dout;
  demux_5x demuxer[11:0] (
    .clk(gt_clkout),
    .vld(1'b1),
    .din(gt_dout),
    .dout(demux_dout)
  );
  
  wire [7:0] mc_data;
  wire [11:0] mc_sel, mc_cs, mc_wrstb, mc_rdstb;
  wire [11:0] unmute;
 
  deformatter_seti deformatter_inst[11:0] (
    .rx_in(demux_dout),
    .frame_clock(clk_div5),
    .rx_locked(1'b1),
    .lockdet(1'b1),
    // Outputs
    .def_out(),
    .index(),
    .one_sec(),
    .ten_sec(),
    .f_clock(), // This is just clk_div5
    .locked(),
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
  
  
endmodule
