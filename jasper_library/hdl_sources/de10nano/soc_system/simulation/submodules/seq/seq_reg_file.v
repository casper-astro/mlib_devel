// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1 ps / 1 ps

// ******
// reg_file
// ******
//
// Register file
//
// General Description
// -------------------
//
// This component stores all configuration/parameterization information
// that other components need to calibrate.
//
// Architecture
// ------------
//
// The PHY Manager is organized as an 
//    - Avalon Interface: it's a Memory-Mapped interface to the Avalon
//      Bus.
//    - Register File: The "register file" of read/write registers
//

module seq_reg_file (
	// Avalon Interface
	
	avl_clk,
	avl_reset_n,
	avl_address,
	avl_write,
	avl_writedata,
	avl_read,
	avl_readdata,
	avl_waitrequest,
	avl_be,
	
	//debug signals
	debug_hphy_reg,
	debug_hphy_comb

);

parameter AVL_DATA_WIDTH = 32;
parameter AVL_ADDR_WIDTH = 13;
parameter AVL_NUM_SYMBOLS = 4;
parameter AVL_SYMBOL_WIDTH = 8;
parameter REGISTER_RDATA   = 0;
parameter NUM_REGFILE_WORDS = 16;
parameter DEBUG_REG_FILE_WORD = 2;

input avl_clk;
input avl_reset_n;
input [AVL_ADDR_WIDTH - 1:0] avl_address;
input avl_write;
input [AVL_DATA_WIDTH - 1:0] avl_writedata;
input [AVL_NUM_SYMBOLS - 1:0] avl_be;
input avl_read;
output [AVL_DATA_WIDTH - 1:0] avl_readdata;
output avl_waitrequest;

//debug signals
output wire [2:0] debug_hphy_reg;
output wire       debug_hphy_comb;



reg [AVL_ADDR_WIDTH-1 : 0] int_addr;
reg [AVL_NUM_SYMBOLS - 1 : 0] int_be;
reg [AVL_DATA_WIDTH - 1 : 0] int_rdata;
reg [AVL_DATA_WIDTH - 1 : 0] int_rdata_reg;
wire int_waitrequest;		//*** SV-to-V: 'logic=>reg ??? fixed/wire
reg [AVL_DATA_WIDTH - 1 : 0] int_wdata;
reg [AVL_DATA_WIDTH - 1 : 0] int_wdata_wire;		//*** SV-to-V: 'logic=>reg ??? fixme?

reg [AVL_DATA_WIDTH-1 : 0] reg_file [0 : NUM_REGFILE_WORDS-1] /* synthesis syn_ramstyle = "reg" */;		//*** SV-to-V: 'logic=>reg ??? fixme? 

integer i, b;

//*** typedef enum int unsigned {		//*** SV-to-V: typedef begin 
	localparam INIT = 0;	//*** 	INIT,		//*** SV-to-V: Found INIT, using val 0
	localparam IDLE = 1;	//*** 	IDLE,		//*** SV-to-V: Found IDLE, using val 1
	localparam WRITE2 = 2;	//*** 	WRITE2,		//*** SV-to-V: Found WRITE2, using val 2
	localparam READ2 = 3;	//*** 	READ2,		//*** SV-to-V: Found READ2, using val 3
	localparam READ3 = 4;	//*** 	READ3,		//*** SV-to-V: Found READ3, using val 4
	localparam READ4 = 5;	//*** 	READ4		//*** SV-to-V: Found READ4, using val 5
//*** } avalon_state_t;		//*** SV-to-V: typedef avalon_state_t end 

 integer state;		//*** SV-to-V: typedef avalon_state_t=>integer

always @ (posedge avl_clk or negedge avl_reset_n) begin		//*** SV-to-V: always_ff=>always 
	if (~avl_reset_n)
		state <= INIT;
	else begin
		if (state == READ2)
			state <= READ3;
		else if ((state == READ3) && (REGISTER_RDATA)) 
			state <= READ4;
		else if (state == IDLE) 
			if (avl_read)
				state <= READ2;
			else if (avl_write)
				state <= WRITE2;
			else
				state <= IDLE;
		else 
			state <= IDLE;
	end
end

assign int_waitrequest = (state == IDLE) || (state == WRITE2) || ((state == READ4) && (REGISTER_RDATA)) || ((state == READ3) && (REGISTER_RDATA == 0)) ? 1'b0 : 1'b1;

always @ (posedge avl_clk or negedge avl_reset_n) begin		//*** SV-to-V: always_ff=>always 
	if (~avl_reset_n) begin
		int_addr <= 0;
		int_wdata <= 0;
		int_be <= 0;
	end
	else if (int_waitrequest == 0) begin
		int_addr  <= avl_address;
		int_wdata <= avl_writedata;
		int_be    <= avl_be;
	end
end

always @ (posedge avl_clk or negedge avl_reset_n) begin		//*** SV-to-V: always_ff=>always 
	if (~avl_reset_n) begin
		int_rdata <= 0;
	end
	else begin
		if (state == READ2) 
			if (int_addr < NUM_REGFILE_WORDS) begin
				int_rdata <= reg_file[int_addr];
			end
			else begin
				int_rdata <= 0;
			end
		else
			int_rdata <= 0;
	end
end
// synthesis translate_off
//*** property p_illegal_read_addr;		//*** SV-to-V: property begin 
//*** 	@(posedge avl_clk)
//*** 	disable iff (!avl_reset_n)
//*** 	(state == READ2) |-> (int_addr < NUM_REGFILE_WORDS);
//*** endproperty		//*** SV-to-V: property end 

//*** a_illegal_read_addr : assert property (p_illegal_read_addr);		//*** SV-to-V: assert 
// synthesis translate_on


always @* begin		//*** SV-to-V: always_comb=>always @*
	int_wdata_wire = reg_file[int_addr];
	for (b=0; b < AVL_NUM_SYMBOLS; b=b+1)		//*** SV-to-V: 'b++=>b=b+1 
		if (int_be[b])
			int_wdata_wire[(b+1)*AVL_SYMBOL_WIDTH-1-:AVL_SYMBOL_WIDTH] = int_wdata[(b+1)*AVL_SYMBOL_WIDTH-1-:AVL_SYMBOL_WIDTH];
end

always @ (posedge avl_clk or negedge avl_reset_n) begin		//*** SV-to-V: always_ff=>always 
	if (~avl_reset_n) begin
		for (i=0; i < NUM_REGFILE_WORDS; i=i+1)		//*** SV-to-V: 'i++=>i=i+1 
			reg_file[i] <= 0;
	end
	else begin
		i = 0;
		if (state == WRITE2) 
			if (int_addr < NUM_REGFILE_WORDS) begin
				reg_file[int_addr] <= int_wdata_wire;
			end
			else begin
			end
	end
end
// synthesis translate_off
//*** property p_illegal_write_addr;		//*** SV-to-V: property begin 
//*** 	@(posedge avl_clk)
//*** 	disable iff (!avl_reset_n)
//*** 	(state == WRITE2) |-> (int_addr < NUM_REGFILE_WORDS);
//*** endproperty		//*** SV-to-V: property end 

//*** a_illegal_write_addr : assert property (p_illegal_write_addr);		//*** SV-to-V: assert 
// synthesis translate_on

generate
	if (REGISTER_RDATA) begin
		
		always @ (posedge avl_clk or negedge avl_reset_n) begin		//*** SV-to-V: always_ff=>always 
			if (~avl_reset_n)
				int_rdata_reg <= 0;
			else
				int_rdata_reg <= int_rdata;
		end

		assign avl_readdata = int_rdata_reg;
	end
	else
		assign avl_readdata = int_rdata;
endgenerate

assign avl_waitrequest = (state == IDLE) ? 1'b1 : int_waitrequest;



// synthesis translate_off
//The register file has a specific word which is expected to be the current
wire [15:0] current_seq_stage;
wire [15:0] current_seq_group;

assign current_seq_stage = reg_file[DEBUG_REG_FILE_WORD][15:0];
assign current_seq_group = reg_file[DEBUG_REG_FILE_WORD][31:16];

// synthesis translate_on

//debug signals
assign debug_hphy_reg  = {state[2:0]};
assign debug_hphy_comb = {avl_waitrequest};

endmodule
