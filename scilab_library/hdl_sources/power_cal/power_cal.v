module power_cal#(
    parameter integer BIT_WIDTH = 16
)(
    input clk,
    input  wire [BIT_WIDTH-1:0] re,
    input  wire [BIT_WIDTH-1:0] im,
    output wire [2*BIT_WIDTH : 0] pwr
);

reg [2*BIT_WIDTH : 0] r;
// this introduces one cycle delay
always @(posedge clk)
begin
    r <= re * re + im * im;
end
assign pwr = r;

endmodule