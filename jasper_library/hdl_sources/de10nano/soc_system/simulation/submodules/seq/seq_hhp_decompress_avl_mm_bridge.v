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

// `define CHECK_FOR_ERRORS

`timescale 1ps/1ps

module seq_hhp_decompress_avl_mm_bridge (
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
	m0_readdatavalid,
	debug_hphy_comb
);

	parameter DATA_WIDTH    = 32;
	parameter SYMBOL_WIDTH  = 8;
	parameter ADDRESS_WIDTH = 32;

`ifdef CHECK_FOR_ERRORS
	parameter BASE_APB_ADDR     = 32'hFFC20000;
	parameter BASE_MASK_ADDR    = 32'hFFFF0000;
`else
	parameter BASE_APB_ADDR     = 32'h0;
	parameter BASE_MASK_ADDR    = 32'h0;
`endif

	parameter APB_BASE_SCC_MGR  = 32'h0000;
	parameter APB_MASK_SCC_MGR  = 32'hF000;

	parameter APB_BASE_PHY_MGR  = 32'h1000;
	parameter APB_MASK_PHY_MGR  = 32'hF000;

	parameter APB_BASE_RW_MGR   = 32'h2000;
	parameter APB_MASK_RW_MGR   = 32'hE000; // range includes 2000-3ffff, so don't check the lower bit

	parameter APB_BASE_DATA_MGR = 32'h4000;
	parameter APB_MASK_DATA_MGR = 32'hF800;

	parameter APB_BASE_REG_FILE = 32'h4800;
	parameter APB_MASK_REG_FILE = 32'hF800;

	parameter APB_BASE_MMR      = 32'h5000;
	parameter APB_MASK_MMR      = 32'hF000;

	parameter AVL_BASE_PHY_MGR  = 32'h88000;
	parameter AVL_BASE_RW_MGR   = 32'h90000;
	parameter AVL_BASE_DATA_MGR = 32'h98000;
	parameter AVL_BASE_SCC_MGR  = 32'h58000;
	parameter AVL_BASE_REG_FILE = 32'h70000;
	parameter AVL_BASE_MMR      = 32'hC0000;


	// --------------------------------------
	// Derived parameters
	// --------------------------------------
	localparam BYTEEN_WIDTH = DATA_WIDTH / SYMBOL_WIDTH;

	localparam APB_SCC_MGR  = BASE_APB_ADDR + APB_BASE_SCC_MGR;
	localparam APB_PHY_MGR  = BASE_APB_ADDR + APB_BASE_PHY_MGR;
	localparam APB_RW_MGR   = BASE_APB_ADDR + APB_BASE_RW_MGR;
	localparam APB_DATA_MGR = BASE_APB_ADDR + APB_BASE_DATA_MGR;
	localparam APB_REG_FILE = BASE_APB_ADDR + APB_BASE_REG_FILE;
	localparam APB_MMR      = BASE_APB_ADDR + APB_BASE_MMR;

	localparam MASK_SCC_MGR  = BASE_MASK_ADDR | APB_MASK_SCC_MGR;
	localparam MASK_PHY_MGR  = BASE_MASK_ADDR | APB_MASK_PHY_MGR;
	localparam MASK_RW_MGR   = BASE_MASK_ADDR | APB_MASK_RW_MGR;
	localparam MASK_DATA_MGR = BASE_MASK_ADDR | APB_MASK_DATA_MGR;
	localparam MASK_REG_FILE = BASE_MASK_ADDR | APB_MASK_REG_FILE;
	localparam MASK_MMR      = BASE_MASK_ADDR | APB_MASK_MMR;


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
	
	//debug signals
	output wire [18:0] debug_hphy_comb;


	wire [ADDRESS_WIDTH-1:0] phy_addr;
	wire [ADDRESS_WIDTH-1:0] rw_addr;
	wire [ADDRESS_WIDTH-1:0] data_addr;
	wire [ADDRESS_WIDTH-1:0] scc_addr;
	wire [ADDRESS_WIDTH-1:0] reg_addr;
	wire [ADDRESS_WIDTH-1:0] mmr_addr;

	assign phy_addr  = AVL_BASE_PHY_MGR  | ((s0_address & (1<<6)) << (14-6)) | (s0_address & 14'h3f);
	assign rw_addr   = AVL_BASE_RW_MGR   | (s0_address & 14'h1fff);
	assign data_addr = AVL_BASE_DATA_MGR | (s0_address & 14'h7ff);
	assign scc_addr  = AVL_BASE_SCC_MGR  | (s0_address & 14'hfff);
	assign reg_addr  = AVL_BASE_REG_FILE | (s0_address & 14'h7ff);
	assign mmr_addr  = AVL_BASE_MMR      | (s0_address & 14'hfff);

	assign m0_address = ((s0_address & MASK_PHY_MGR)  == APB_PHY_MGR)  ? phy_addr  :
			    ((s0_address & MASK_RW_MGR)   == APB_RW_MGR)   ? rw_addr   :
			    ((s0_address & MASK_DATA_MGR) == APB_DATA_MGR) ? data_addr :
			    ((s0_address & MASK_SCC_MGR)  == APB_SCC_MGR)  ? scc_addr  :
			    ((s0_address & MASK_REG_FILE) == APB_REG_FILE) ? reg_addr  :
			    ((s0_address & MASK_MMR)      == APB_MMR)      ? mmr_addr  :
			    32'hFFFFFFFF;

	assign s0_readdata = m0_readdata;
	assign m0_write = s0_write;
	assign m0_read = s0_read;
	assign m0_writedata = s0_writedata;
	assign s0_waitrequest = m0_waitrequest;
	assign m0_byteenable = s0_byteenable;
	assign s0_readdatavalid = m0_readdatavalid;


	always @(m0_address)
	begin
		$display("[%0t] DECOMPRESS: %0h => %0h", $time, s0_address, m0_address);
`ifdef CHECK_FOR_ERRORS
		if (m0_address == 32'hFFFFFFFF) 
		begin
			$display("[%0t] BAD ADDRESS", $time);
			$finish;
		end
`endif			
	end

//debug signals
assign debug_hphy_comb = {s0_address[19:11],m0_address[19:11],m0_waitrequest};

endmodule
