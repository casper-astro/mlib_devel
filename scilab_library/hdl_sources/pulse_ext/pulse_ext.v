module pulse_ext#(
    parameter LEN = 1024
)(
    input clk,
    input in,
    output out
);

function integer     logb2;
    input integer     depth ;
    for(logb2=0; depth>1; logb2=logb2+1) begin
        depth = depth >> 1 ;
    end
endfunction

reg [logb2(LEN)-1: 0] counter = 0;
reg en = 0;
always @(posedge clk)
begin
    if(in == 1)
        en <= 1;
    else if(counter == LEN - 1)
        en <= 0;
    else
        en <= en;
end

always @(posedge clk)
begin
    if(en)
        counter <= counter + 1;
    else
        counter <= 0;
end

assign out = en;

endmodule