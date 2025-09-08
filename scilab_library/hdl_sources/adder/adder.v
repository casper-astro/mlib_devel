module adder(
    input clk,
    input [31:0] in0,
    input [31:0] in1,
    output reg [31:0] out0
);

always @(posedge clk) begin
    out0 <= in0 + in1;
end

endmodule
