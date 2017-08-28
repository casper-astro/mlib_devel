`timescale 1ns/1ps

// This testbench is for understanding the interface between
// adc16_interface and wb_bram.
module testbench;

	// Change LOG_USER_WIDTH to see simulations under
	// differnt bit-width of adc_channel/user_din
	// LOG_USER_WIDTH = 5 ==> 08-bit adc_channel x 4 or 032-bit user_din
	// LOG_USER_WIDTH = 6 ==> 16-bit adc_channel x 4 or 064-bit user_din
	// LOG_USER_WIDTH = 7 ==> 32-bit adc_channel x 4 or 128-bit user_din

	parameter LOG_USER_WIDTH = 5;
	parameter USER_ADDR_BITS = 10;
	parameter N_REGISTERS = 1;

	localparam USER_WIDTH = 1 << (LOG_USER_WIDTH-2);

	reg		wb_clk_i;
	reg		wb_rst_i;
	reg	[31:0]	wb_adr_i;
	reg	[3:0]	wb_sel_i;
	reg	[31:0]	wb_dat_i;
	reg		wb_we_i;
	reg		wb_cyc_i;
	reg		wb_stb_i;
	wire	[31:0]	wb_dat_o;
	wire		wb_err_o;
	wire		wb_ack_o;

	reg					user_clk;
	reg	[USER_ADDR_BITS-1:0]		user_addr;
	reg	[USER_WIDTH-1:0]	a1;
	reg	[USER_WIDTH-1:0]	a2;
	reg	[USER_WIDTH-1:0]	a3;
	reg	[USER_WIDTH-1:0]	a4;
	reg					    user_we;
	
	integer i;

	// Clock gen
	initial begin
		// 200MHz
		wb_clk_i = 1'b0;
		forever wb_clk_i = #2.5 ~wb_clk_i;
	end
	initial begin
		// 100MHz
		user_clk = 1'b0;
		forever user_clk = #5 ~user_clk;
	end

	initial begin

		wb_rst_i = 1'b1;

		wb_adr_i = 32'h0;
		wb_sel_i = 4'h0;
		wb_dat_i = 32'h0;
		wb_we_i  = 0;
		wb_cyc_i = 0;
		wb_stb_i = 0;

		user_addr = 10'h0;
		a1 = 'h0;
		a2 = 'h0;
		a3 = 'h0;
		a4 = 'h0;
		user_we = 0;

		#5 wb_rst_i = 1'b0;

		@(negedge user_clk);
		user_addr = 10'h0;
		a1 = 'h11001101;
		a2 = 'h22002202;
		a3 = 'h33003303;
		a4 = 'h44004404;
		user_we = 1;
		$strobe("@ %0t: \t user_addr:%h, a1:%h, a2:%h, a3:%h, a4:%h", $time, user_addr, a1, a2, a3, a4 );

		@(negedge user_clk);
		user_addr = 10'h1;
		a1 = 'h55005505;
		a2 = 'h66006606;
		a3 = 'h77007707;
		a4 = 'h88008808;
		user_we = 1;
		$strobe("@ %0t: \t user_addr:%h, a1:%h, a2:%h, a3:%h, a4:%h", $time, user_addr, a1, a2, a3, a4 );

		@(negedge user_clk);
		user_addr = 10'h0;
		a1 = 'h0;
		a2 = 'h0;
		a3 = 'h0;
		a4 = 'h0;
		user_we = 0;

		@(negedge user_clk);

        for (i=0; i<2**(LOG_USER_WIDTH-2); i=i+4) begin
		@(negedge wb_clk_i);
		wb_adr_i = i;
		wb_we_i  = 0;
		wb_sel_i = 4'hf;
		wb_cyc_i = 1;
		wb_stb_i = 1;

        	@(wb_ack_o);
		$strobe("@ %0t: \t wb_adr_i:%h, wb_dat_o:%h", $time, wb_adr_i, wb_dat_o);
		@(negedge wb_clk_i);
		wb_adr_i = 32'h0;
		wb_we_i  = 0;
		wb_sel_i = 4'h0;
		wb_cyc_i = 0;
		wb_stb_i = 0;
		end

		
		repeat(10) @(negedge wb_clk_i);
		$finish;
		
	end

	wb_bram #(
		.LOG_USER_WIDTH(LOG_USER_WIDTH),
		.USER_ADDR_BITS(USER_ADDR_BITS),
		.N_REGISTERS(N_REGISTERS)
	) dut (
		.wb_clk_i(wb_clk_i),
		.wb_rst_i(wb_rst_i),
		.wb_dat_o(wb_dat_o),
		.wb_err_o(wb_err_o),
		.wb_ack_o(wb_ack_o),
		.wb_adr_i(wb_adr_i),
		.wb_sel_i(wb_sel_i),
		.wb_dat_i(wb_dat_i),
		.wb_we_i (wb_we_i),
		.wb_cyc_i(wb_cyc_i),
		.wb_stb_i(wb_stb_i),

		.user_clk(user_clk),
		.user_addr(user_addr),
		.user_din({a1,a2,a3,a4}),
		.user_we(user_we),
		.user_dout()
	);

endmodule // testbench
