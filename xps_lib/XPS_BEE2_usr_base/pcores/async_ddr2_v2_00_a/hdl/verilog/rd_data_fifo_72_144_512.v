/*******************************************************************************
*     This file is owned and controlled by Xilinx and must be used             *
*     solely for design, simulation, implementation and creation of            *
*     design files limited to Xilinx devices or technologies. Use              *
*     with non-Xilinx devices or technologies is expressly prohibited          *
*     and immediately terminates your license.                                 *
*                                                                              *
*     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"            *
*     SOLELY FOR USE IN DEVELOPING PROGRAMS AND SOLUTIONS FOR                  *
*     XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION          *
*     AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE, APPLICATION              *
*     OR STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS                *
*     IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,                  *
*     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE         *
*     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY                 *
*     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE                  *
*     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR           *
*     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF          *
*     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS          *
*     FOR A PARTICULAR PURPOSE.                                                *
*                                                                              *
*     Xilinx products are not intended for use in life support                 *
*     appliances, devices, or systems. Use in such applications are            *
*     expressly prohibited.                                                    *
*                                                                              *
*     (c) Copyright 1995-2005 Xilinx, Inc.                                     *
*     All rights reserved.                                                     *
*******************************************************************************/
// The synopsys directives "translate_off/translate_on" specified below are
// supported by XST, FPGA Compiler II, Mentor Graphics and Synplicity synthesis
// tools. Ensure they are correct for your synthesis tool(s).

// You must compile the wrapper file rd_data_fifo_72_144_512.v when simulating
// the core, rd_data_fifo_72_144_512. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Help".

`timescale 1ns/1ps

module rd_data_fifo_72_144_512(
	din,
	rd_clk,
	rd_en,
	rst,
	wr_clk,
	wr_en,
	dout,
	empty,
	full,
	prog_full);


input [71 : 0] din;
input rd_clk;
input rd_en;
input rst;
input wr_clk;
input wr_en;
output [143 : 0] dout;
output empty;
output full;
output prog_full;

// synopsys translate_off

      FIFO_GENERATOR_V2_2 #(
		.c_common_clock( 0 ),
		.c_count_type( 0 ),
		.c_data_count_width( 2 ),
		.c_default_value( "BlankString" ),
		.c_din_width( 72 ),
		.c_dout_rst_val( "0" ),
		.c_dout_width( 144 ),
		.c_enable_rlocs( 0 ),
		.c_family( "virtex2p" ),
		.c_has_almost_empty( 0 ),
		.c_has_almost_full( 0 ),
		.c_has_backup( 0 ),
		.c_has_data_count( 0 ),
		.c_has_meminit_file( 0 ),
		.c_has_overflow( 0 ),
		.c_has_rd_data_count( 0 ),
		.c_has_rd_rst( 0 ),
		.c_has_rst( 1 ),
		.c_has_underflow( 0 ),
		.c_has_valid( 0 ),
		.c_has_wr_ack( 0 ),
		.c_has_wr_data_count( 0 ),
		.c_has_wr_rst( 0 ),
		.c_implementation_type( 2 ),
		.c_init_wr_pntr_val( 0 ),
		.c_memory_type( 1 ),
		.c_mif_file_name( "BlankString" ),
		.c_optimization_mode( 0 ),
		.c_overflow_low( 0 ),
		.c_preload_latency( 0 ),
		.c_preload_regs( 1 ),
		.c_prim_fifo_type( 512 ),
		.c_prog_empty_thresh_assert_val( 128 ),
		.c_prog_empty_thresh_negate_val( 128 ),
		.c_prog_empty_type( 0 ),
		.c_prog_full_thresh_assert_val( 980 ),
		.c_prog_full_thresh_negate_val( 768 ),
		.c_prog_full_type( 1 ),
		.c_rd_data_count_width( 2 ),
		.c_rd_depth( 512 ),
		.c_rd_pntr_width( 9 ),
		.c_underflow_low( 0 ),
		.c_use_fifo16_flags( 0 ),
		.c_valid_low( 0 ),
		.c_wr_ack_low( 0 ),
		.c_wr_data_count_width( 2 ),
		.c_wr_depth( 1024 ),
		.c_wr_pntr_width( 10 ),
		.c_wr_response_latency( 1 ) )
	inst (
		.DIN(din),
		.RD_CLK(rd_clk),
		.RD_EN(rd_en),
		.RST(rst),
		.WR_CLK(wr_clk),
		.WR_EN(wr_en),
		.DOUT(dout),
		.EMPTY(empty),
		.FULL(full),
		.PROG_FULL(prog_full),
		.CLK(),
		.BACKUP(),
		.BACKUP_MARKER(),
		.PROG_EMPTY_THRESH(),
		.PROG_EMPTY_THRESH_ASSERT(),
		.PROG_EMPTY_THRESH_NEGATE(),
		.PROG_FULL_THRESH(),
		.PROG_FULL_THRESH_ASSERT(),
		.PROG_FULL_THRESH_NEGATE(),
		.RD_RST(),
		.WR_RST(),
		.ALMOST_EMPTY(),
		.ALMOST_FULL(),
		.DATA_COUNT(),
		.OVERFLOW(),
		.PROG_EMPTY(),
		.VALID(),
		.RD_DATA_COUNT(),
		.UNDERFLOW(),
		.WR_ACK(),
		.WR_DATA_COUNT());


// synopsys translate_on

endmodule

