module slice#(
    parameter INPUT_WIDTH = 32,
    parameter OUTPUT_WIDTH = 1,
    parameter SLICE_START = 0
)(
    input clk,
    input [INPUT_WIDTH - 1:0] in,
    output  [OUTPUT_WIDTH - 1:0] out
);

assign out = in[SLICE_START +: OUTPUT_WIDTH];

endmodule