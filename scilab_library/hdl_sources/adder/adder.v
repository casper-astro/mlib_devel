module adder(
    input clk,
    input [63:0] in0,
    input [63:0] in1,
    output reg [63:0] out0
);

always @(posedge clk) begin
    out0 <= in0 + in1;
end

endmodule
