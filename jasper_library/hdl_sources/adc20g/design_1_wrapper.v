//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (lin64) Build 1071353 Tue Nov 18 16:47:07 MST 2014
//Date        : Tue Jul  7 14:28:26 2015
//Host        : simech1 running 64-bit Ubuntu 12.04.4 LTS
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (FLASH1,
    FLASH2,
    Q8_CLK1_GTREFCLK_PAD_N_IN,
    Q8_CLK1_GTREFCLK_PAD_P_IN,
    RXN_IN,
    RXP_IN,
    TRACK_DATA_OUT,
    TXN_OUT,
    TXP_OUT,
    diff_clock_rtl_clk_n,
    diff_clock_rtl_clk_p,
    dout,
    gpio_adc_control_tri_o,
    iic_scl_io,
    iic_sda_io,
    reset_rtl,
    adc_clk_out,
    uart_rxd,
    uart_txd);
  output FLASH1;
  output FLASH2;
  input Q8_CLK1_GTREFCLK_PAD_N_IN;
  input Q8_CLK1_GTREFCLK_PAD_P_IN;
  input [7:0]RXN_IN;
  input [7:0]RXP_IN;
  output TRACK_DATA_OUT;
  output [7:0]TXN_OUT;
  output [7:0]TXP_OUT;
  input diff_clock_rtl_clk_n;
  input diff_clock_rtl_clk_p;
  output [327:0]dout;
  output [5:0]gpio_adc_control_tri_o;
  inout iic_scl_io;
  inout iic_sda_io;
  input reset_rtl;
  input uart_rxd;
  output uart_txd;
  output adc_clk_out;

  wire FLASH1;
  wire FLASH2;
  wire Q8_CLK1_GTREFCLK_PAD_N_IN;
  wire Q8_CLK1_GTREFCLK_PAD_P_IN;
  wire [7:0]RXN_IN;
  wire [7:0]RXP_IN;
  wire TRACK_DATA_OUT;
  wire [7:0]TXN_OUT;
  wire [7:0]TXP_OUT;
  wire diff_clock_rtl_clk_n;
  wire diff_clock_rtl_clk_p;
  wire [327:0]dout;
  wire [5:0]gpio_adc_control_tri_o;
  wire iic_scl_i;
  wire iic_scl_io;
  wire iic_scl_o;
  wire iic_scl_t;
  wire iic_sda_i;
  wire iic_sda_io;
  wire iic_sda_o;
  wire iic_sda_t;
  wire reset_rtl;
  wire uart_rxd;
  wire uart_txd;

design_1 design_1_i
       (.FLASH1(FLASH1),
        .FLASH2(FLASH2),
        .Q8_CLK1_GTREFCLK_PAD_N_IN(Q8_CLK1_GTREFCLK_PAD_N_IN),
        .Q8_CLK1_GTREFCLK_PAD_P_IN(Q8_CLK1_GTREFCLK_PAD_P_IN),
        .RXN_IN(RXN_IN),
        .RXP_IN(RXP_IN),
        .TRACK_DATA_OUT(TRACK_DATA_OUT),
        .TXN_OUT(TXN_OUT),
        .TXP_OUT(TXP_OUT),
        .diff_clock_rtl_clk_n(diff_clock_rtl_clk_n),
        .diff_clock_rtl_clk_p(diff_clock_rtl_clk_p),
        .dout(dout),
        .gpio_adc_control_tri_o(gpio_adc_control_tri_o),
        .iic_scl_i(iic_scl_i),
        .iic_scl_o(iic_scl_o),
        .iic_scl_t(iic_scl_t),
        .iic_sda_i(iic_sda_i),
        .iic_sda_o(iic_sda_o),
        .iic_sda_t(iic_sda_t),
        .reset_rtl(reset_rtl),
        .adc_clk_out(adc_clk_out),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));

IOBUF iic_scl_iobuf
       (.I(iic_scl_o),
        .IO(iic_scl_io),
        .O(iic_scl_i),
        .T(iic_scl_t));

IOBUF iic_sda_iobuf
       (.I(iic_sda_o),
        .IO(iic_sda_io),
        .O(iic_sda_i),
        .T(iic_sda_t));
endmodule
