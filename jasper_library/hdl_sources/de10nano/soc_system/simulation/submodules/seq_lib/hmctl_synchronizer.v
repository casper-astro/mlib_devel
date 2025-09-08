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

`define RTL_SIMULATION_ONLY

module hmctl_synchronizer
			#(
				parameter FIFO_ADDR_BITS = 'd4
			)(
				// clocks
				input clk,					// input clock to sync

				//resets
				input aclr_n,					// reset
				
				//boot time option
				input cfg_inc_sync,				// cfg param to unc sync length
				input cfg_sync_mode,				// cfg param to bypass this sync chain
				
				//async input
				input [FIFO_ADDR_BITS - 1 : 0]async_input,	// async input
				
				//sync output
				output [FIFO_ADDR_BITS -1 : 0]sync_output	// synchronized output
			);


`ifdef RTL_SIMULATION_ONLY

reg [FIFO_ADDR_BITS - 1 : 0] sync1, sync2, sync3;

always @(posedge clk, negedge aclr_n)
  begin
	if(aclr_n == 1'b0)
	begin
		sync3 <= {FIFO_ADDR_BITS{1'b0}};
		sync2 <= {FIFO_ADDR_BITS{1'b0}};
		sync1 <= {FIFO_ADDR_BITS{1'b0}};
	end
	else
		{sync3,sync2,sync1} <= {sync2,sync1,async_input};
  end
  
assign sync_output  = (cfg_sync_mode == 1'b0)? ((cfg_inc_sync == 1'b1)? sync3 : sync2) : async_input;

`else

wire [FIFO_ADDR_BITS - 1 : 0] sync2, sync3, sync_2_3;

generate
  genvar i;
  
  for (i=0; i< FIFO_ADDR_BITS; i=i+1)
  begin:sync
      SSYNC2DFCCNQD1BWP35LVT bit_sync_2
        (
         .SI  (1'b0),
         .D   (async_input[i]),
         .SE  (1'b0),	 	 
         .CP  (clk),
         .CDN (aclr_n),	 
         .Q   (sync2[i])
        );
     
      SMETADFCNQD1BWP35LVT   bit_sync_3
        (
         .SI  (1'b0),
         .D   (sync2[i]),
         .SE  (1'b0),	 	 
         .CP  (clk),
         .CDN (aclr_n),	 
         .Q   (sync3[i])
        );
  
      MUX2D1BWP35LVT         mux_2_3
        (
	 .I0(sync2[i]),
	 .I1(sync3[i]),
	 .S(cfg_inc_sync),
	 .Z(sync_2_3[i])
	);
	
      MUX2D1BWP35LVT         mux_bypass
        (
	 .I0(sync_2_3[i]),
	 .I1(async_input[i]),
	 .S(cfg_sync_mode),
	 .Z(sync_output[i])
	);
  end
endgenerate

`endif
  
endmodule
