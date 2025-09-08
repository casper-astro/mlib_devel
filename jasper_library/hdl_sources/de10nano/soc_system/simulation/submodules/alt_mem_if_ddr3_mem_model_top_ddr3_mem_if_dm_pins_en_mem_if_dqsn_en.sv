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

module alt_mem_if_ddr3_mem_model_top_ddr3_mem_if_dm_pins_en_mem_if_dqsn_en 
    # (parameter MEM_IF_CLK_EN_WIDTH = 1,
		MEM_IF_CK_WIDTH = 1,
		MEM_IF_BANKADDR_WIDTH = 3,
		MEM_IF_ADDR_WIDTH = 15,
		MEM_IF_ROW_ADDR_WIDTH = 15,
		MEM_IF_COL_ADDR_WIDTH = 10,
		MEM_IF_CS_WIDTH = 1,
		MEM_IF_CONTROL_WIDTH = 1,
		MEM_IF_ODT_WIDTH = 1,
		DEVICE_DEPTH = 1,
		DEVICE_WIDTH = 1,
		MEM_IF_DQS_WIDTH = 1,
		MEM_IF_DQ_WIDTH = 8,
		MEM_MIRROR_ADDRESSING_DEC = 0,
		MEM_TRTP = 8,
		MEM_TRCD = 8,
		MEM_DQS_TO_CLK_CAPTURE_DELAY = 100,
		MEM_CLK_TO_DQS_CAPTURE_DELAY = 100000,
		MEM_REGDIMM_ENABLED = 0,
		MEM_LRDIMM_ENABLED = 0,
		MEM_RANK_MULTIPLICATION_FACTOR = 0, 
		MEM_IF_LRDIMM_RM = 0,
		MEM_NUMBER_OF_RANKS_PER_DIMM = 0,
		MEM_NUMBER_OF_DIMMS = 0,
		MEM_INIT_EN = 0,
		MEM_INIT_FILE = "",
	        MEM_GUARANTEED_WRITE_INIT = 0,
		DAT_DATA_WIDTH = 32,
       		MEM_VERBOSE = 1,
		REFRESH_BURST_VALIDATION = 0,
		AP_MODE_EN = 2'b00
	)                    
	(
	mem_a,
	mem_ba,
	mem_ck,
	mem_ck_n,
	mem_cke,
	mem_cs_n,
	mem_ras_n,
	mem_cas_n,
	mem_we_n,
	mem_reset_n,
	mem_dm,
	mem_dq,
	mem_dqs,
	mem_dqs_n,
	mem_odt
);

input	[MEM_IF_ADDR_WIDTH - 1:0]	mem_a;
input	[MEM_IF_BANKADDR_WIDTH - 1:0]	mem_ba;
input	[MEM_IF_CK_WIDTH - 1:0]	mem_ck;
input	[MEM_IF_CK_WIDTH - 1:0]	mem_ck_n;
input	[MEM_IF_CLK_EN_WIDTH - 1:0] mem_cke;
input	[MEM_IF_CS_WIDTH - 1:0] mem_cs_n;
input	[MEM_IF_CONTROL_WIDTH - 1:0] mem_ras_n;
input	[MEM_IF_CONTROL_WIDTH - 1:0] mem_cas_n;
input	[MEM_IF_CONTROL_WIDTH - 1:0] mem_we_n;
input	mem_reset_n;
input	[MEM_IF_DQS_WIDTH - 1:0] mem_dm;
inout   [MEM_IF_DQ_WIDTH - 1:0]	mem_dq;
inout   [MEM_IF_DQS_WIDTH - 1:0]	mem_dqs;
inout   [MEM_IF_DQS_WIDTH - 1:0]	mem_dqs_n;
input 	[MEM_IF_ODT_WIDTH - 1:0] mem_odt;


//synthesis translate_off

localparam MEM_MODEL_DEVICE_DEPTH = DEVICE_DEPTH;

generate
genvar depth;
genvar width;
for (depth = 0; depth < MEM_MODEL_DEVICE_DEPTH; depth = depth + 1)
begin : depth_gen
	for (width = 0; width < DEVICE_WIDTH; width = width + 1)
	begin : width_gen

				alt_mem_if_common_ddr_mem_model_ddr3_mem_if_dm_pins_en_mem_if_dqsn_en #(


			.MEM_CLK_EN_WIDTH	(MEM_IF_CLK_EN_WIDTH),
			.MEM_IF_BA_WIDTH	(MEM_IF_BANKADDR_WIDTH),
			.MEM_IF_ADDR_WIDTH	(MEM_IF_ADDR_WIDTH),
			.MEM_IF_ROW_WIDTH	(MEM_IF_ROW_ADDR_WIDTH),
			.MEM_IF_COL_WIDTH	(MEM_IF_COL_ADDR_WIDTH),
			.MEM_IF_CS_WIDTH	(MEM_IF_CS_WIDTH / MEM_MODEL_DEVICE_DEPTH),
			.MEM_DQS_WIDTH		(MEM_IF_DQS_WIDTH / DEVICE_WIDTH),
			.MEM_DQ_WIDTH		(MEM_IF_DQ_WIDTH / DEVICE_WIDTH),
			.MEM_MIRROR_ADDRESSING (MEM_MIRROR_ADDRESSING_DEC),
			.MEM_TRTP			(MEM_TRTP),
			.MEM_TRCD			(MEM_TRCD),
			.MEM_DQS_TO_CLK_CAPTURE_DELAY(MEM_DQS_TO_CLK_CAPTURE_DELAY),
			.MEM_CLK_TO_DQS_CAPTURE_DELAY(MEM_CLK_TO_DQS_CAPTURE_DELAY),
			.MEM_DEPTH_IDX		(depth),
			.MEM_WIDTH_IDX		(width),
			.MEM_REGDIMM_ENABLED(MEM_REGDIMM_ENABLED),
			.MEM_LRDIMM_ENABLED(MEM_LRDIMM_ENABLED),
			.MEM_NUMBER_OF_RANKS_PER_DIMM(MEM_NUMBER_OF_RANKS_PER_DIMM),
			.MEM_RANK_MULTIPLICATION_FACTOR(MEM_RANK_MULTIPLICATION_FACTOR), 
			.MEM_IF_LRDIMM_RM(MEM_IF_LRDIMM_RM),
			.MEM_INIT_EN        (MEM_INIT_EN),
			.MEM_INIT_FILE      (MEM_INIT_FILE),
			.MEM_GUARANTEED_WRITE_INIT(MEM_GUARANTEED_WRITE_INIT),
			.DAT_DATA_WIDTH     (DAT_DATA_WIDTH),
			.MEM_VERBOSE		(MEM_VERBOSE),
			.REFRESH_BURST_VALIDATION	(REFRESH_BURST_VALIDATION),
			.AP_MODE_EN	(AP_MODE_EN)
		) mem_inst (
			.mem_a		(mem_a[MEM_IF_ADDR_WIDTH-1:0]),
			.mem_ba		(mem_ba),
			.mem_ck		(mem_ck[0]),
			.mem_ck_n	(mem_ck_n[0]),   
			.mem_cke	(mem_cke),
			.mem_cs_n	(mem_cs_n[MEM_IF_CS_WIDTH/MEM_MODEL_DEVICE_DEPTH*(depth+1)-1:MEM_IF_CS_WIDTH/MEM_MODEL_DEVICE_DEPTH*depth]),
			.mem_ras_n	(mem_ras_n),
			.mem_cas_n	(mem_cas_n),
			.mem_we_n	(mem_we_n),
			.mem_reset_n(mem_reset_n),
			.mem_dm		(mem_dm[MEM_IF_DQS_WIDTH/DEVICE_WIDTH*(width+1)-1:MEM_IF_DQS_WIDTH/DEVICE_WIDTH*width]),
			.mem_dq		(mem_dq[MEM_IF_DQ_WIDTH/DEVICE_WIDTH*(width+1)-1:MEM_IF_DQ_WIDTH/DEVICE_WIDTH*width]),
			.mem_dqs	(mem_dqs[MEM_IF_DQS_WIDTH/DEVICE_WIDTH*(width+1)-1:MEM_IF_DQS_WIDTH/DEVICE_WIDTH*width]),
			.mem_dqs_n	(mem_dqs_n[MEM_IF_DQS_WIDTH/DEVICE_WIDTH*(width+1)-1:MEM_IF_DQS_WIDTH/DEVICE_WIDTH*width]),
			.mem_odt	(mem_odt[0])
		);
	end
end
endgenerate

//synthesis translate_on

endmodule
