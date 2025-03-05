module delay # (
    parameter D 		= 1,
	parameter BITWIDTH 	= 1
)(
    input clk,
	input [(BITWIDTH-1):0]din,
	output [(BITWIDTH-1):0]dout
);

reg [(BITWIDTH-1):0] d [(D-1):0];
integer i;
always @(posedge clk)
	begin
		d[0][(BITWIDTH-1):0]	<= din;

		for(i = 1; i< D ;i = i+1)
			d[i][(BITWIDTH-1):0] <= d[i-1][(BITWIDTH-1):0]; 
	end
assign dout = d[D-1][(BITWIDTH-1):0]; 

endmodule