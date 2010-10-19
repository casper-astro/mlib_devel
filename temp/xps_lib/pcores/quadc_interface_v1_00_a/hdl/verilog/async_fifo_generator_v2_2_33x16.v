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

// You must compile the wrapper file async_fifo_generator_v2_2_33x16.v when simulating
// the core, async_fifo_generator_v2_2_33x16. When compiling the wrapper file, be sure to
// reference the XilinxCoreLib Verilog simulation library. For detailed
// instructions, please refer to the "CORE Generator Help".

`timescale 1ns/1ps

module async_fifo_generator_v2_2_33x16(
	din,
	rd_clk,
	rd_en,
	rst,
	wr_clk,
	wr_en,
	dout,
	empty,
	full,
	valid);


input [32 : 0] din;
input rd_clk;
input rd_en;
input rst;
input wr_clk;
input wr_en;
output [32 : 0] dout;
output empty;
output full;
output valid;

// synopsys translate_off

      FIFO_GENERATOR_V2_2 #(
		0,	// c_common_clock
		0,	// c_count_type
		2,	// c_data_count_width
		"BlankString",	// c_default_value
		33,	// c_din_width
		"0",	// c_dout_rst_val
		33,	// c_dout_width
		0,	// c_enable_rlocs
		"virtex2p",	// c_family
		0,	// c_has_almost_empty
		0,	// c_has_almost_full
		0,	// c_has_backup
		0,	// c_has_data_count
		0,	// c_has_meminit_file
		0,	// c_has_overflow
		0,	// c_has_rd_data_count
		0,	// c_has_rd_rst
		1,	// c_has_rst
		0,	// c_has_underflow
		1,	// c_has_valid
		0,	// c_has_wr_ack
		0,	// c_has_wr_data_count
		0,	// c_has_wr_rst
		2,	// c_implementation_type
		0,	// c_init_wr_pntr_val
		2,	// c_memory_type
		"BlankString",	// c_mif_file_name
		0,	// c_optimization_mode
		0,	// c_overflow_low
		1,	// c_preload_latency
		0,	// c_preload_regs
		512,	// c_prim_fifo_type
		4,	// c_prog_empty_thresh_assert_val
		4,	// c_prog_empty_thresh_negate_val
		0,	// c_prog_empty_type
		12,	// c_prog_full_thresh_assert_val
		12,	// c_prog_full_thresh_negate_val
		0,	// c_prog_full_type
		2,	// c_rd_data_count_width
		16,	// c_rd_depth
		4,	// c_rd_pntr_width
		0,	// c_underflow_low
		0,	// c_use_fifo16_flags
		0,	// c_valid_low
		0,	// c_wr_ack_low
		2,	// c_wr_data_count_width
		16,	// c_wr_depth
		4,	// c_wr_pntr_width
		1)	// c_wr_response_latency
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
		.VALID(valid),
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
		.PROG_FULL(),
		.RD_DATA_COUNT(),
		.UNDERFLOW(),
		.WR_ACK(),
		.WR_DATA_COUNT());


// synopsys translate_on

// FPGA Express black box declaration
// synopsys attribute fpga_dont_touch "true"
// synthesis attribute fpga_dont_touch of async_fifo_generator_v2_2_33x16 is "true"

// XST black box declaration
// box_type "black_box"
// synthesis attribute box_type of async_fifo_generator_v2_2_33x16 is "black_box"

endmodule

