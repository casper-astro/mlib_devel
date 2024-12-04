module edge_det#(
    parameter EDGE = "rising"
)(
    input clk,
    input in,
    output out
);

reg in_delay;
always @(posedge clk)
begin
    in_delay <= in;    
end

generate
    if (EDGE == "rising") 
        begin
            assign out = in & in_delay;
        end 
    else if(EDGE == "falling")
        begin
            assign out = ~in & in_delay;
        end
endgenerate

endmodule