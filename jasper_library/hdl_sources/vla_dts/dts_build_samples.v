`timescale 1ns / 1ps

module dts_build_samples #(
    INPUT_WIDTH = 128
  ) (
    input is_three_bit,
    input [3*INPUT_WIDTH-1 : 0] din,
    output [3*INPUT_WIDTH-1 : 0] dout
  );

  wire [INPUT_WIDTH-1:0] din0 = din[1*INPUT_WIDTH-1:0*INPUT_WIDTH];
  wire [INPUT_WIDTH-1:0] din1 = din[2*INPUT_WIDTH-1:1*INPUT_WIDTH];
  wire [INPUT_WIDTH-1:0] din2 = din[3*INPUT_WIDTH-1:2*INPUT_WIDTH];

  wire [3*INPUT_WIDTH-1:0] dout_3bit;
  wire [3*INPUT_WIDTH-1:0] dout_12bit;

  generate
  for (genvar i=0; i<INPUT_WIDTH; i=i+1) begin
    assign dout_3bit[3*i + 0] = din0[i];
    assign dout_3bit[3*i + 1] = din1[i];
    assign dout_3bit[3*i + 2] = din2[i];
  end
  endgenerate

  generate
  for (genvar i=0; i<INPUT_WIDTH; i=i+4) begin
    assign dout_12bit[3*i + 0]  = din0[i+0];
    assign dout_12bit[3*i + 1]  = din0[i+1];
    assign dout_12bit[3*i + 2]  = din0[i+2];
    assign dout_12bit[3*i + 3]  = din0[i+3];
    assign dout_12bit[3*i + 4]  = din1[i+0];
    assign dout_12bit[3*i + 5]  = din1[i+1];
    assign dout_12bit[3*i + 6]  = din1[i+2];
    assign dout_12bit[3*i + 7]  = din1[i+3];
    assign dout_12bit[3*i + 8]  = din2[i+0];
    assign dout_12bit[3*i + 9]  = din2[i+1];
    assign dout_12bit[3*i + 10] = din2[i+2];
    assign dout_12bit[3*i + 11] = din2[i+3];
  end
  endgenerate

  assign dout = is_three_bit ? dout_3bit : dout_12bit;


endmodule
