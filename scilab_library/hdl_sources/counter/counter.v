module counter#(
    parameter BIT_WIDTH = 32
)(
    input clk,
    input rst,
    input en,
    output  [BIT_WIDTH - 1:0] out
);

// TODO: add more parameters, like step, initial value, etc.
reg [BIT_WIDTH - 1:0] counter;
always @(posedge clk)
begin
    if (rst)
        counter <= 0;
    else if (en)
        counter <= counter + 1;
end

assign out = counter;

endmodule