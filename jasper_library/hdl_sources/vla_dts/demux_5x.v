`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/21/2020 08:30:58 AM
// Design Name: 
// Module Name: demux_5x
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


module demux_5x(
    input clk,
    input vld,
    input [31:0] din,
    output [159:0] dout
    );

reg [159:0] dout_reg_fast;
reg [159:0] dout_reg_slow;
assign dout = dout_reg_slow;

reg [2:0] count;
always @(posedge clk) begin
  if (vld) begin
    count <= count + 1'b1;
    dout_reg_fast[159:32] <= dout_reg_fast[127:0];
    dout_reg_fast[31:0] <= din;
    if (count == 3'd4) begin
      dout_reg_slow <= dout_reg_fast;
      count <= 3'b0;
    end
  end
end


endmodule