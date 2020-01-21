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


module gty_12chan(
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
    

  wire mgtrefclk0;

  IBUFDS_GTE4 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE4_MGTREFCLK0(
    .I     (mgtrefclk0_p),
    .IB    (mgtrefclk0_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0),
    .ODIV2 ()
  );

  // Differential reference clock buffer for MGTREFCLK0_X0Y2
  wire mgtrefclk1;

  IBUFDS_GTE4 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE4_MGTREFCLK1(
    .I     (mgtrefclk1_p),
    .IB    (mgtrefclk1_n),
    .CEB   (1'b0),
    .O     (mgtrefclk1),
    .ODIV2 ()
  );

  wire [2:0] refclk_int;
  assign refclk_int[0] = mgtrefclk0;
  assign refclk_int[1] = mgtrefclk0;
  assign refclk_int[2] = mgtrefclk1;
  
  wire [63:0] status_int;
  reg [63:0] status_reg;
  assign status = status_reg;
  always @(posedge clkout) begin
      status_reg <= status_int;
  end    

  gty_12chan_10g_66_64 gty_inst(
    .gtyrxn_in                               (rx_n)
   ,.gtyrxp_in                               (rx_p)
   ,.gtytxn_out                              (tx_n)
   ,.gtytxp_out                              (tx_p)
   ,.gtwiz_userclk_tx_reset_in               (1'b0)
   ,.gtwiz_userclk_tx_srcclk_out             ()
   ,.gtwiz_userclk_tx_usrclk_out             ()
   ,.gtwiz_userclk_tx_usrclk2_out            ()
   ,.gtwiz_userclk_tx_active_out             ()
   ,.gtwiz_userclk_rx_reset_in               (rst)
   ,.gtwiz_userclk_rx_srcclk_out             ()
   ,.gtwiz_userclk_rx_usrclk_out             ()
   ,.gtwiz_userclk_rx_usrclk2_out            (clkout)
   ,.gtwiz_userclk_rx_active_out             (status[0])
   ,.gtwiz_reset_clk_freerun_in              (clk100)
   ,.gtwiz_reset_all_in                      (1'b0)
   ,.gtwiz_reset_tx_pll_and_datapath_in      (1'b0)
   ,.gtwiz_reset_tx_datapath_in              (1'b0)
   ,.gtwiz_reset_rx_pll_and_datapath_in      (1'b0)
   ,.gtwiz_reset_rx_datapath_in              (1'b0)
   ,.gtwiz_reset_rx_cdr_stable_out           () // PG182 says "Reserved; do not use"
   ,.gtwiz_reset_tx_done_out                 ()
   ,.gtwiz_reset_rx_done_out                 (status_int[1])
   ,.gtwiz_userdata_tx_in                    ()
   ,.gtwiz_userdata_rx_out                   (dout)
   ,.gtrefclk00_in                           (refclk_int)
   ,.qpll0outclk_out                         ()
   ,.qpll0outrefclk_out                      ()
   ,.rxcdrhold_in                            ({12{1'b0}}) // Used for SATA only
   ,.rxgearboxslip_in                        (gearbox_slip)
   ,.txheader_in                             ({12{5'b0}})
   ,.txpd_in                                 ({12{2'b11}}) // Power Down TX side
   ,.txsequence_in                           ({12{7'b0}})
   ,.gtpowergood_out                         (status_int[12+2-1:2]) // async
   ,.rxdatavalid_out                         (dvld)
   ,.rxheader_out                            (hdr)
   ,.rxheadervalid_out                       (hdrvld)
   ,.rxpmaresetdone_out                      (status_int[12+14-1:14])
   ,.rxprgdivresetdone_out                   (status_int[12+26-1:26])
   ,.rxstartofseq_out                        (status_int[(2*12)+38-1:38])
   ,.txpmaresetdone_out                      ()
   ,.txprgdivresetdone_out                   ()
);



endmodule
