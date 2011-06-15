module diff_to_se #(
	parameter width = 8
) (
	input [width-1:0]		data_p,
	input [width-1:0]		data_n,
	output [width-1:0]	data
);


genvar i;
generate
	for (i = 0; i < width; i = i +1) begin: se_gen
		// Convert LVDS pair to single-ended
		IBUFGDS #(
			.DIFF_TERM("TRUE"),       	// Differential Termination (Virtex-4/5, Spartan-3E/3A)
			.IOSTANDARD("LVDS_25")    	// Specify the input I/O standard
		) IBUFGDS_data (
			.O(data[i]),  						// Buffer output
			.I(data_p[i]),  						// Diff_p buffer input (connect directly to top-level port)
			.IB(data_n[i]) 						// Diff_n buffer input (connect directly to top-level port)
		);
	end
endgenerate
endmodule
