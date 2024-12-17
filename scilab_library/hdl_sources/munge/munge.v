module munge#(
    parameter g_total_bits = 128,
    parameter g_number_of_divisions = 4,
    parameter g_division_size_bits = 32,
    parameter [15:0] g_packing_order = {4'd3, 4'd2, 4'd1, 4'd0}
)(
    input clk,
    input ce,
    input [g_total_bits - 1 : 0] in,
    output [g_total_bits - 1 : 0] out
);

assign out = {in[31:0], in[63:32], in[95:64], in[127:96]};

endmodule