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


// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030

module altera_avalon_jtag_uart_log_module #(
  parameter FIFO_WIDTH = 8
  ) (
  // inputs:
   clk,
   data,
   strobe,
   valid
    )
;

  input                     clk;
  input   [FIFO_WIDTH-1: 0] data;
  input                     strobe;
  input                     valid;



//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
   reg [31:0] text_handle; // for $fopen
   initial text_handle = $fopen ("altera_avalon_jtag_uart_output_stream.dat");

   always @(posedge clk) begin
      if (valid && strobe) begin
	 // Send \n (linefeed) instead of \r (^M, Carriage Return)...
         $fwrite (text_handle, "%s", ((data == 8'hd) ? 8'ha : data));
	 // non-standard; poorly documented; required to get real data stream.
	 $fflush (text_handle);
      end
   end // clk


//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule
