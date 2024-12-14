module munge#(
    parameter total_bits = 128,
    parameter g_number_of_divisions = 4,
    parameter g_division_size_bits = 32,
    parameter [15:0] g_packing_order = {4'd3, 4'd2, 4'd1, 4'd0}
)(
    input clk,
    input ce,
    input [total_bits - 1 : 0] din,
    output [total_bits - 1 : 0] dout
);

assign dout = {din[31:0], din[63:32], din[95:64], din[127:96]};

endmodule