`timescale 1ns / 1ps

module mux8x(
  input wire [127:0] din,
  input wire fast_clock,
  output wire [15:0] dout,
  // misc inputs to pull into a common clock domain
  input wire index,
  input wire one_sec,
  input wire ten_sec,
  input wire locked,
  output reg index4x,
  output reg one_sec4x,
  output reg ten_sec4x,
  output reg locked4x
  );

  reg [2:0] count = 3'b0;
  reg [127:0] dout_reg;
  assign dout = dout_reg[15:0];

  always @(posedge fast_clock) begin
    if (count  == 3'b0) begin
      dout_reg <= din;
    end else begin
      dout_reg <= {16'b0, dout_reg[127:16]};
    end
    count <= count + 1'b1;
    index4x <= index;
    one_sec4x <= one_sec;
    ten_sec4x <= ten_sec;
    locked4x <= locked;
  end

endmodule
