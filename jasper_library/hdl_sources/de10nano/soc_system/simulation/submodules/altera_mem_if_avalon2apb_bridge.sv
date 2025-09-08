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



`timescale 1 ps / 1 ps

module altera_mem_if_avalon2apb_bridge #(
  parameter DWIDTH = 32,              
  parameter AWIDTH = 10,              
  parameter BYTEENABLE_WIDTH = 4      
)(

input wire pclk,
input wire sp_reset_n,

output reg [DWIDTH-1:0] pwdata,
output reg [32-1:0] paddr,	
output reg psel,
output reg penable,
output reg pwrite,

input wire pslverr,
input wire pready,
input wire [DWIDTH-1:0] prdata,

output reg [DWIDTH-1:0] av_readdata,
output reg av_waitrequest,

input wire [AWIDTH-1:0] av_addr,
input wire av_write,
input wire av_read,
input wire [BYTEENABLE_WIDTH-1:0] av_byteenable,
input wire [DWIDTH-1:0] av_writedata

);

typedef enum int unsigned {
	IDLE,
	SETUP,
	ACCESS,
	POST_ACCESS
} STATE;
	     
reg [5:0] state;


always @ (posedge pclk or negedge sp_reset_n)
begin
	if (!sp_reset_n) begin
		state <= IDLE;

		psel <= 1'b0;
		penable <= 1'b0;
		paddr <= 'x;
		pwrite <= 1'bx;
		pwdata <= 'x;

		av_waitrequest <= 1'b1;
		av_readdata <= 'x;

	end else begin

		case(state)
		IDLE: begin
			penable <= 1'b0;
			av_waitrequest <= 1'b1;
			av_readdata <= 'x;
			
			if (av_read || av_write) begin
				psel <= 1'b1;
				paddr <= av_addr;
				pwrite <= av_write;
				pwdata <= av_write ? av_writedata : 'x;
				state <= SETUP;
			end else begin
				psel <= 1'b0;
				penable <= 1'b0;
				paddr <= 'x;
				pwrite <= 1'bx;
				pwdata <= 'x;
				state <= IDLE;
			end
		end
            
		SETUP: begin
			penable <= 1'b1;
			state <= ACCESS;
		end

		ACCESS: begin
			if (pready) begin
				psel <= 1'b0;
				penable <= 1'b0;
				paddr <= 'x;
				pwrite <= 1'bx;
				pwdata <= 'x;
				if (av_read) begin
					av_readdata <= prdata;
				end
				av_waitrequest <= 1'b0;
				state <= POST_ACCESS;
			end else begin
				state <= ACCESS;
			end
		end

		POST_ACCESS: begin
			state <= IDLE;
		end
		
		endcase
	end
end

endmodule
