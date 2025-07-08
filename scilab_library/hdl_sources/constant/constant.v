module constant#(
    parameter OUT = 1023,
    parameter BIT_WIDTH = 64
)(
    output  [BIT_WIDTH - 1:0] out
);

assign out = OUT;

endmodule
