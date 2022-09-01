`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2016 03:41:38 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
wire [31:0] ADC_data_out;
wire ADC_data_valid;
wire [1:0] ADC_data_sel;
wire next_word;
reg read_clk;
reg fake_enable;
wire DCLK_P;
wire DCLK_N;


ADC_core_block UUT(
    .ADC_data_out(ADC_data_out),
    .ADC_data_valid(ADC_data_valid),
    .ADC_data_sel(ADC_data_sel),
    .next_word(next_word),
    .read_clk(read_clk),
    .fake_enable(fake_enable),
    .DCLK_P(DCLK_P),
    .DCLK_N(DCLK_N)
);
    reg CLK;
  parameter PERIOD = 4.0;
   always begin
      CLK = 1'b0;
      #(PERIOD/2) CLK = 1'b1;
      #(PERIOD/2);
   end
assign DCLK_P = CLK;
assign DCLK_N = !CLK;

  parameter PERIOD2 = 17.0;
   always begin
      read_clk = 1'b0;
      #(PERIOD2/2) read_clk = 1'b1;
      #(PERIOD2/2);
   end
   
reg [75:0] data_out;
reg [1:0] word_count = 0;
always @ (posedge read_clk) begin
    if (!ADC_data_valid) word_count <= 0;
    else word_count <= word_count + 1;   
    if (word_count == 0) data_out[31:0] <= ADC_data_out;     
    if (word_count == 1) data_out[63:32] <= ADC_data_out;     
    if (word_count == 2) data_out[75:64] <= ADC_data_out[11:0];     
end
assign next_word = (word_count == 3);
assign ADC_data_sel = word_count;

initial begin
fake_enable = 1;

end
endmodule
