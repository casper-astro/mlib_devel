module operation#(
    parameter OP = "and"
)(
    input clk,
    input in0,
    input in1,
    output out
);

reg out_reg = 0;

generate
    if (OP == "and") begin
        always @(posedge clk)
            out_reg <= in0 & in1;
        assign out = out_reg;
    end else if (OP == "or") begin
        always @(posedge clk)
            out_reg <= in0 | in1;
        assign out = out_reg;
    end else if (OP == "xor") begin
        always @(posedge clk)
            out_reg <= in0 ^ in1;
        assign out = out_reg;
    end else if (OP == "or_comb") begin
        assign out = in0 | in1;
    end
endgenerate

endmodule
