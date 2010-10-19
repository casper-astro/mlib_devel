//*****************************************************************************
// DISCLAIMER OF LIABILITY
// 
// This text/file contains proprietary, confidential
// information of Xilinx, Inc., is distributed under license
// from Xilinx, Inc., and may be used, copied and/or
// disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc. Xilinx hereby grants you a 
// license to use this text/file solely for design, simulation, 
// implementation and creation of design files limited 
// to Xilinx devices or technologies. Use with non-Xilinx 
// devices or technologies is expressly prohibited and 
// immediately terminates your license unless covered by
// a separate agreement.
//
// Xilinx is providing this design, code, or information 
// "as-is" solely for use in developing programs and 
// solutions for Xilinx devices, with no obligation on the 
// part of Xilinx to provide support. By providing this design, 
// code, or information as one possible implementation of 
// this feature, application or standard, Xilinx is making no 
// representation that this implementation is free from any 
// claims of infringement. You are responsible for 
// obtaining any rights you may require for your implementation. 
// Xilinx expressly disclaims any warranty whatsoever with 
// respect to the adequacy of the implementation, including 
// but not limited to any warranties or representations that this
// implementation is free from claims of infringement, implied 
// warranties of merchantability or fitness for a particular 
// purpose.
//
// Xilinx products are not intended for use in life support
// appliances, devices, or systems. Use in such applications is
// expressly prohibited.
//
// Any modifications that are made to the Source Code are 
// done at the users sole risk and will be unsupported.
//
// Copyright (c) 2006-2007 Xilinx, Inc. All rights reserved.
//
// This copyright and support notice must be retained as part 
// of this text at all times. 
//*****************************************************************************
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version: 2.3
//  \   \         Application: MIG
//  /   /         Filename: ddr2_usr_rd.v
// /___/   /\     Date Last Modified: $Date: 2008/07/02 14:03:08 $
// \   \  /  \    Date Created: Tue Aug 29 2006
//  \___\/\___\
//
//Device: Virtex-5
//Design Name: DDR2
//Purpose:
//   The delay between the read data with respect to the command issued is
//   calculted in terms of no. of clocks. This data is then stored into the
//   FIFOs and then read back and given as the ouput for comparison.
//Reference:
//Revision History:
//*****************************************************************************

`timescale 1ns/1ps

module ddr2_usr_rd #
  (
   // Following parameters are for 72-bit RDIMM design (for ML561 Reference 
   // board design). Actual values may be different. Actual parameters values 
   // are passed from design top module ddr2_sdram module. Please refer to
   // the ddr2_sdram module for actual values.
   parameter DQ_PER_DQS    = 8,
   parameter DQS_WIDTH     = 9,
   parameter APPDATA_WIDTH = 144,
   parameter ECC_WIDTH     = 72,
   parameter ECC_ENABLE    = 0
   )
  (
   input                                    clk0,
   input                                    rst0,
   input [(DQS_WIDTH*DQ_PER_DQS)-1:0]       rd_data_in_rise,
   input [(DQS_WIDTH*DQ_PER_DQS)-1:0]       rd_data_in_fall,
   input [DQS_WIDTH-1:0]                    ctrl_rden,
   input [DQS_WIDTH-1:0]                    ctrl_rden_sel,
   output reg [1:0]                         rd_ecc_error,
   output                                   rd_data_valid,
   output reg [(APPDATA_WIDTH/2)-1:0]       rd_data_out_rise,
   output reg [(APPDATA_WIDTH/2)-1:0]       rd_data_out_fall
   );

  // determine number of FIFO72's to use based on data width
  localparam RDF_FIFO_NUM = ((APPDATA_WIDTH/2)+63)/64;

  reg [DQS_WIDTH-1:0]               ctrl_rden_r;
  wire [(DQS_WIDTH*DQ_PER_DQS)-1:0] fall_data;
  reg [(DQS_WIDTH*DQ_PER_DQS)-1:0]  rd_data_in_fall_r;
  reg [(DQS_WIDTH*DQ_PER_DQS)-1:0]  rd_data_in_rise_r;
  wire                              rden;
  reg [DQS_WIDTH-1:0]               rden_sel_r
                                    /* synthesis syn_preserve=1 */;
  wire [DQS_WIDTH-1:0]              rden_sel_mux;
  wire [(DQS_WIDTH*DQ_PER_DQS)-1:0] rise_data;

  // ECC specific signals
  wire [((RDF_FIFO_NUM -1) *2)+1:0] db_ecc_error;
  reg [(DQS_WIDTH*DQ_PER_DQS)-1:0]  fall_data_r;
  reg                               fifo_rden_r0;
  reg                               fifo_rden_r1;
  reg                               fifo_rden_r2;
  reg                               fifo_rden_r3;
  reg                               fifo_rden_r4;
  reg                               fifo_rden_r5;
  reg                               fifo_rden_r6;
  wire [(APPDATA_WIDTH/2)-1:0]      rd_data_out_fall_temp;
  wire [(APPDATA_WIDTH/2)-1:0]      rd_data_out_rise_temp;
  reg                               rst_r;
  reg [(DQS_WIDTH*DQ_PER_DQS)-1:0]  rise_data_r;
  wire [((RDF_FIFO_NUM -1) *2)+1:0] sb_ecc_error;


  //***************************************************************************

  always @(posedge clk0) begin
    rden_sel_r        <= ctrl_rden_sel;
    ctrl_rden_r       <= ctrl_rden;
    rd_data_in_rise_r <= rd_data_in_rise;
    rd_data_in_fall_r <= rd_data_in_fall;
  end

  // Instantiate primitive to allow this flop to be attached to multicycle
  // path constraint in UCF. Multicycle path allowed for data from read FIFO.
  // This is the same signal as RDEN_SEL_R, but is only used to select data
  // (does not affect control signals)
  genvar rd_i;
  generate
    for (rd_i = 0; rd_i < DQS_WIDTH; rd_i = rd_i+1) begin: gen_rden_sel_mux
      FDRSE u_ff_rden_sel_mux
        (
         .Q   (rden_sel_mux[rd_i]),
         .C   (clk0),
         .CE  (1'b1),
         .D   (ctrl_rden_sel[rd_i]),
         .R   (1'b0),
         .S   (1'b0)
         ) /* synthesis syn_preserve=1 */;
    end
  endgenerate

  // determine correct read data valid signal timing
  assign rden = (rden_sel_r[0]) ? ctrl_rden[0] : ctrl_rden_r[0];

  // assign data based on the skew
  genvar data_i;
  generate
    for(data_i = 0; data_i < DQS_WIDTH; data_i = data_i+1) begin: gen_data
      assign rise_data[(data_i*DQ_PER_DQS)+(DQ_PER_DQS-1):
                       (data_i*DQ_PER_DQS)]
               = (rden_sel_mux[data_i]) ?
                 rd_data_in_rise[(data_i*DQ_PER_DQS)+(DQ_PER_DQS-1) :
                                 (data_i*DQ_PER_DQS)] :
                 rd_data_in_rise_r[(data_i*DQ_PER_DQS)+(DQ_PER_DQS-1):
                                   (data_i*DQ_PER_DQS)];
       assign fall_data[(data_i*DQ_PER_DQS)+(DQ_PER_DQS-1):
                        (data_i*DQ_PER_DQS)]
                = (rden_sel_mux[data_i]) ?
                  rd_data_in_fall[(data_i*DQ_PER_DQS)+(DQ_PER_DQS-1):
                                  (data_i*DQ_PER_DQS)] :
                  rd_data_in_fall_r[(data_i*DQ_PER_DQS)+(DQ_PER_DQS-1):
                                    (data_i*DQ_PER_DQS)];
    end
  endgenerate

  // Generate RST for FIFO reset AND for read/write enable:
  // ECC FIFO always being read from and written to
  always @(posedge clk0)
    rst_r <= rst0;

  genvar rdf_i;
  generate
    if (ECC_ENABLE) begin
      always @(posedge clk0) begin
        rd_ecc_error[0]   <= (|sb_ecc_error) & fifo_rden_r5;
        rd_ecc_error[1]   <= (|db_ecc_error) & fifo_rden_r5;
        rd_data_out_rise  <= rd_data_out_rise_temp;
        rd_data_out_fall  <= rd_data_out_fall_temp;
        rise_data_r       <= rise_data;
        fall_data_r       <= fall_data;
      end

      // can use any of the read valids, they're all delayed by same amount
      assign rd_data_valid = fifo_rden_r6;

      // delay read valid to take into account max delay difference btw
      // the read enable coming from the different DQS groups
      always @(posedge clk0) begin
        if (rst0) begin
          fifo_rden_r0 <= 1'b0;
          fifo_rden_r1 <= 1'b0;
          fifo_rden_r2 <= 1'b0;
          fifo_rden_r3 <= 1'b0;
          fifo_rden_r4 <= 1'b0;
          fifo_rden_r5 <= 1'b0;
          fifo_rden_r6 <= 1'b0;
        end else begin
          fifo_rden_r0 <= rden;
          fifo_rden_r1 <= fifo_rden_r0;
          fifo_rden_r2 <= fifo_rden_r1;
          fifo_rden_r3 <= fifo_rden_r2;
          fifo_rden_r4 <= fifo_rden_r3;
          fifo_rden_r5 <= fifo_rden_r4;
          fifo_rden_r6 <= fifo_rden_r5;
        end
      end

      for (rdf_i = 0; rdf_i < RDF_FIFO_NUM; rdf_i = rdf_i + 1) begin: gen_rdf

        FIFO36_72  # // rise fifo
          (
           .ALMOST_EMPTY_OFFSET     (9'h007),
           .ALMOST_FULL_OFFSET      (9'h00F),
           .DO_REG                  (1),          // extra CC output delay
           .EN_ECC_WRITE            ("FALSE"),
           .EN_ECC_READ             ("TRUE"),
           .EN_SYN                  ("FALSE"),
           .FIRST_WORD_FALL_THROUGH ("FALSE")
           )
          u_rdf
            (
             .ALMOSTEMPTY (),
             .ALMOSTFULL  (),
             .DBITERR     (db_ecc_error[rdf_i + rdf_i]),
             .DO          (rd_data_out_rise_temp[(64*(rdf_i+1))-1:
                                                 (64 *rdf_i)]),
             .DOP         (),
             .ECCPARITY   (),
             .EMPTY       (),
             .FULL        (),
             .RDCOUNT     (),
             .RDERR       (),
             .SBITERR     (sb_ecc_error[rdf_i + rdf_i]),
             .WRCOUNT     (),
             .WRERR       (),
             .DI          (rise_data_r[((64*(rdf_i+1)) + (rdf_i*8))-1:
                                       (64 *rdf_i)+(rdf_i*8)]),
             .DIP         (rise_data_r[(72*(rdf_i+1))-1:
                                       (64*(rdf_i+1))+ (8*rdf_i)]),
             .RDCLK       (clk0),
             .RDEN        (~rst_r),
             .RST         (rst_r),
             .WRCLK       (clk0),
             .WREN        (~rst_r)
             );

        FIFO36_72  # // fall_fifo
          (
           .ALMOST_EMPTY_OFFSET     (9'h007),
           .ALMOST_FULL_OFFSET      (9'h00F),
           .DO_REG                  (1),          // extra CC output delay
           .EN_ECC_WRITE            ("FALSE"),
           .EN_ECC_READ             ("TRUE"),
           .EN_SYN                  ("FALSE"),
           .FIRST_WORD_FALL_THROUGH ("FALSE")
           )
          u_rdf1
            (
             .ALMOSTEMPTY (),
             .ALMOSTFULL  (),
             .DBITERR     (db_ecc_error[(rdf_i+1) + rdf_i]),
             .DO          (rd_data_out_fall_temp[(64*(rdf_i+1))-1:
                                                 (64 *rdf_i)]),
             .DOP         (),
             .ECCPARITY   (),
             .EMPTY       (),
             .FULL        (),
             .RDCOUNT     (),
             .RDERR       (),
             .SBITERR     (sb_ecc_error[(rdf_i+1) + rdf_i]),
             .WRCOUNT     (),
             .WRERR       (),
             .DI          (fall_data_r[((64*(rdf_i+1)) + (rdf_i*8))-1:
                                       (64*rdf_i)+(rdf_i*8)]),
             .DIP         (fall_data_r[(72*(rdf_i+1))-1:
                                       (64*(rdf_i+1))+ (8*rdf_i)]),
             .RDCLK       (clk0),
             .RDEN        (~rst_r),
             .RST         (rst_r),          // or can use rst0
             .WRCLK       (clk0),
             .WREN        (~rst_r)
             );
      end
    end else begin
      assign rd_data_valid = fifo_rden_r0;
      always @(posedge clk0) begin
        rd_data_out_rise <= rise_data;
        rd_data_out_fall <= fall_data;
        fifo_rden_r0 <= rden;
      end
    end
  endgenerate

endmodule
