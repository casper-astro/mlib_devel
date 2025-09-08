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


`timescale 1 ns / 1 ns

module seq_id_router_default_decode
  #(
     parameter DEFAULT_CHANNEL = 0,
               DEFAULT_DESTID = 0 
   )
  (output [71 - 70 : 0] default_destination_id,
   output [4-1 : 0] default_src_channel
  );

  assign default_destination_id = 
    DEFAULT_DESTID[71 - 70 : 0];
  generate begin : default_decode
    if (DEFAULT_CHANNEL == -1)
      assign default_src_channel = 0;		//*** SV-to-V: '0=>0 
    else
      assign default_src_channel = 4'b1 << DEFAULT_CHANNEL;
  end endgenerate

endmodule


