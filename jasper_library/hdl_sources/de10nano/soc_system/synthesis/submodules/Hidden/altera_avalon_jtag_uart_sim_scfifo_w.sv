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

module altera_avalon_jtag_uart_sim_scfifo_w #(
  parameter FIFO_WIDTH = 8,
  parameter WR_WIDTHU = 6,
  parameter printingMethod = 0
  ) (
  // inputs:
   clk,
   fifo_wdata,
   fifo_wr,
   rst_n,

  // outputs:
   fifo_FF,
   r_dat,
   wfifo_empty,
   wfifo_used
    )
;

  output                    fifo_FF;
  output  [FIFO_WIDTH-1: 0] r_dat;
  output                    wfifo_empty;
  output  [WR_WIDTHU-1: 0]  wfifo_used;
  input                     clk;
  input   [FIFO_WIDTH-1: 0] fifo_wdata;
  input                     fifo_wr;
  input                     rst_n;


wire                            fifo_FF;
wire  [FIFO_WIDTH-1: 0]         r_dat;
wire                            wfifo_empty;
wire  [WR_WIDTHU-1: 0]          wfifo_used;


`ifndef QUARTUS_CDC
//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  altera_avalon_jtag_uart_log_module
    #(
      .FIFO_WIDTH (FIFO_WIDTH)
     )

altera_avalon_jtag_uart_log
    (
      .clk    (clk),
      .data   (fifo_wdata),
      .strobe (fifo_wr),
      .valid  (fifo_wr)
    );

string str_buf = "";

generate
  if (printingMethod == 0)
  begin
    always @(posedge clk)
      begin
        if (fifo_wr)
          $write("%c", fifo_wdata);
      end
    end

  else if (printingMethod == 1)
  begin
    always @(posedge clk or negedge rst_n)
      begin
        if (rst_n == 0)
          begin
            str_buf = "";
          end
        else if (fifo_wr)
          begin
            str_buf = $sformatf("%s%c", str_buf, fifo_wdata);
            if (fifo_wdata == "\n")
              begin
                #2 $write("%s", str_buf);
                str_buf = "";
              end
          end
      end
  end
endgenerate

  assign wfifo_used = {WR_WIDTHU{1'b0}};
  assign r_dat = {FIFO_WIDTH{1'b0}};
  assign fifo_FF = 1'b0;
  assign wfifo_empty = 1'b1;

//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on
`endif

endmodule
