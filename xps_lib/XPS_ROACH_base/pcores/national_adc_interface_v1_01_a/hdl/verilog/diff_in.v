`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    06:34:57 07/05/2007 
// Design Name: 
// Module Name:    diff_in 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module diff_in(DP, DN, D);
    input [7:0] DP;
    input [7:0] DN;
    output [7:0] D;

IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB0(.I(DP[0]), .IB(DN[0]), .O(D[0]));
				
IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB1(.I(DP[1]), .IB(DN[1]), .O(D[1]));

IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB2(.I(DP[2]), .IB(DN[2]), .O(D[2]));

IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB3(.I(DP[3]), .IB(DN[3]), .O(D[3]));

IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB4(.I(DP[4]), .IB(DN[4]), .O(D[4]));

IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB5(.I(DP[5]), .IB(DN[5]), .O(D[5]));

IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB6(.I(DP[6]), .IB(DN[6]), .O(D[6]));

IBUFDS #(.DIFF_TERM("TRUE"),.IOSTANDARD("LVDS_25"))     
			IB7(.I(DP[7]), .IB(DN[7]), .O(D[7]));

endmodule
