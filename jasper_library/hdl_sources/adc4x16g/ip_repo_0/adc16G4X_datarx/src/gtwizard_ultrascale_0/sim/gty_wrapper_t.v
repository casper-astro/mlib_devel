`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/30/2019 08:59:40 PM
// Design Name: 
// Module Name: gty_wrapper_t
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


module gty_wrapper_t;
reg refclk;
wire refclk_p = refclk;
wire refclk_n = !refclk;
reg clk100;
reg gtwiz_reset_all_in;
reg gty_data;
wire [3:0] gtyrxp_in = {gty_data, gty_data, gty_data, gty_data};
wire [3:0] gtyrxn_in = {!gty_data, !gty_data, !gty_data, !gty_data};
reg gearbox_slip;
reg rxslide;

 gty_wrapper_0 UUT(
    .refclk_p(refclk_p),
    .refclk_n(refclk_n),
    .clk100(clk100),
    .gtwiz_reset_all_in(gtwiz_reset_all_in),
    .chan_sel(2'b00),
    .gtyrxp_in(gtyrxp_in),
    .gtyrxn_in(gtyrxn_in),
    .rx_polarity(1'b0),
    .gearbox_slip(gearbox_slip),
    .rxslide(rxslide),
    .gtyrx_dout0(),
    .gtyrx_dout1(),
    .gtyrx_dout2(),
    .gtyrx_dout3(),
    .rxprbserr(),
    .rxprbslocked(),
    .rx_dav(),
    .gt_powergood(), 
    .rx_pmareset_done(),
    .gtwiz_reset_rx_done(),
    .gtwiz_reset_rx_cdr_stable_out(),
    .gtwiz_userclk_rx_active_out(),
    .clkout()
        );
   always begin
      refclk = 1'b0;
      #1.0 refclk = 1'b1;
      #1.0;
   end
   always begin
      clk100 = 1'b0;
      #5.0 clk100 = 1'b1;
      #5.0;
   end
initial begin
    gtwiz_reset_all_in = 0;
    gty_data = 0;
    gearbox_slip = 0;
    rxslide = 0;
    #100;
    gtwiz_reset_all_in = 1;
    #100;
    gtwiz_reset_all_in = 0;
end

endmodule
