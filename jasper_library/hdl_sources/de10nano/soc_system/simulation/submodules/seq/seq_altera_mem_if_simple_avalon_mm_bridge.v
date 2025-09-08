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


// (C) 2001-2012 Altera Corporation. All rights reserved.
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




`timescale 1ps/1ps

module seq_altera_mem_if_simple_avalon_mm_bridge (
	clk,
	reset_n,
	s0_address,
	s0_read,
	s0_readdata,
	s0_write,
	s0_writedata,
	s0_waitrequest,
	s0_byteenable,
	s0_readdatavalid,
	m0_address,
	m0_read,
	m0_readdata,
	m0_write,
	m0_writedata,
	m0_waitrequest,
	m0_byteenable,
	m0_readdatavalid
);

    parameter DATA_WIDTH    = 32;
    parameter SYMBOL_WIDTH  = 8;
	parameter ADDRESS_WIDTH = 10;

    localparam BYTEEN_WIDTH = DATA_WIDTH / SYMBOL_WIDTH;

	input clk;
	input reset_n;

	input  [ADDRESS_WIDTH-1:0]  s0_address;
	input                       s0_read;
	output [DATA_WIDTH-1:0]     s0_readdata;
	input                       s0_write;
	input  [DATA_WIDTH-1:0]     s0_writedata;
	output                      s0_waitrequest;
	input  [BYTEEN_WIDTH-1:0]   s0_byteenable;
	output                      s0_readdatavalid;

	output [ADDRESS_WIDTH-1:0]  m0_address;
	output                      m0_read;
	input  [DATA_WIDTH-1:0]     m0_readdata;
	output                      m0_write;
	output [DATA_WIDTH-1:0]     m0_writedata;
	input                       m0_waitrequest;
	output [BYTEEN_WIDTH-1:0]   m0_byteenable;
	input                       m0_readdatavalid;

	reg  [ADDRESS_WIDTH-1:0]    s0_address_r;
	reg                         s0_read_r;
	reg                         s0_write_r;
	reg  [DATA_WIDTH-1:0]       s0_writedata_r;
	reg  [BYTEEN_WIDTH-1:0]     s0_byteenable_r;

	reg                         m0_waitrequest_r;

	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n) begin
			s0_address_r <= 0;
			s0_read_r <= 0;
			s0_write_r <= 0;
			s0_writedata_r <= 0;
			s0_byteenable_r <= 0;
			
			m0_waitrequest_r <= 0;
		end
		else begin
			s0_address_r <= s0_address;

			s0_read_r <= s0_read & (~s0_read_r | m0_waitrequest);
			s0_write_r <= s0_write & (~s0_write_r | m0_waitrequest);

			s0_writedata_r <= s0_writedata;
			s0_byteenable_r <= s0_byteenable;
			
			m0_waitrequest_r <= m0_waitrequest;
		end
	end

	assign m0_address = s0_address_r;
	assign m0_read = s0_read_r;
	assign m0_write = s0_write_r;
	assign m0_writedata = s0_writedata_r;
	assign m0_byteenable = s0_byteenable_r;



	assign s0_waitrequest = m0_waitrequest | ((s0_read | s0_write) & ~m0_waitrequest_r);
	assign s0_readdata = m0_readdata;
	assign s0_readdatavalid = m0_readdatavalid;
endmodule
