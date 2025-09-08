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


// altera message_off 10230

`timescale 1 ps / 1 ps

module seq_scc_hhp_wrapper
    # (parameter
    
    DATAWIDTH               =   24,
    IO_SDATA_BITS           =   11,
    DQS_SDATA_BITS          =   46,
    AVL_DATA_WIDTH          =   32,
    DLL_DELAY_CHAIN_LENGTH  =   6
        
    )
    (
	
	reset_n_scc_clk,	
	scc_clk,
	scc_dataout,
        hhp_extras,
        hhp_dqse_map,
	scc_io_cfg,
	scc_dqs_cfg
);

	input  scc_clk;
	input  reset_n_scc_clk;
	input  [DATAWIDTH-1:0] scc_dataout;
	input  [AVL_DATA_WIDTH-1:0] hhp_extras;
	input  [32-1:0] hhp_dqse_map;
	output [IO_SDATA_BITS - 1:0] scc_io_cfg;
	output [DQS_SDATA_BITS - 1:0] scc_dqs_cfg;
	
	//*** typedef enum integer {		//*** SV-to-V: typedef begin 
	localparam SCC_ADDR_DQS_IN_DELAY = 'b0001;	//*** 		SCC_ADDR_DQS_IN_DELAY	= 'b0001, 		//*** SV-to-V: Found SCC_ADDR_DQS_IN_DELAY = 'b0001 
	localparam SCC_ADDR_DQS_EN_PHASE = 'b0010;	//*** 		SCC_ADDR_DQS_EN_PHASE	= 'b0010, 		//*** SV-to-V: Found SCC_ADDR_DQS_EN_PHASE = 'b0010 
	localparam SCC_ADDR_DQS_EN_DELAY = 'b0011;	//*** 		SCC_ADDR_DQS_EN_DELAY	= 'b0011, 		//*** SV-to-V: Found SCC_ADDR_DQS_EN_DELAY = 'b0011 
	localparam SCC_ADDR_DQDQS_OUT_PHASE = 'b0100;	//*** 		SCC_ADDR_DQDQS_OUT_PHASE= 'b0100, 		//*** SV-to-V: Found SCC_ADDR_DQDQS_OUT_PHASE = 'b0100 
	localparam SCC_ADDR_OCT_OUT1_DELAY = 'b0101;	//*** 		SCC_ADDR_OCT_OUT1_DELAY	= 'b0101, 		//*** SV-to-V: Found SCC_ADDR_OCT_OUT1_DELAY = 'b0101 
	localparam SCC_ADDR_DQS_EN_DELAY_GATE = 'b0110;	//*** 		SCC_ADDR_DQS_EN_DELAY_GATE = 'b0110, 		//*** SV-to-V: Found SCC_ADDR_DQS_EN_DELAY_GATE = 'b0110 
	localparam SCC_ADDR_IO_OUT1_DELAY = 'b0111;	//*** 		SCC_ADDR_IO_OUT1_DELAY	= 'b0111, 		//*** SV-to-V: Found SCC_ADDR_IO_OUT1_DELAY = 'b0111 
	localparam SCC_ADDR_IO_OE_DELAY = 'b1000;	//*** 		SCC_ADDR_IO_OE_DELAY	= 'b1000, 		//*** SV-to-V: Found SCC_ADDR_IO_OE_DELAY = 'b1000 
	localparam SCC_ADDR_IO_IN_DELAY = 'b1001;	//*** 		SCC_ADDR_IO_IN_DELAY	= 'b1001, 		//*** SV-to-V: Found SCC_ADDR_IO_IN_DELAY = 'b1001 
	localparam SCC_ADDR_GLOBALS = 'b1010;	//*** 	        SCC_ADDR_GLOBALS        = 'b1010, 		//*** SV-to-V: Found SCC_ADDR_GLOBALS = 'b1010 
	localparam SCC_ADDR_RFILE = 'b1011;	//*** 	        SCC_ADDR_RFILE          = 'b1011  		//*** SV-to-V: Found SCC_ADDR_RFILE = 'b1011 
//*** 	} sdata_addr_t;		//*** SV-to-V: typedef sdata_addr_t end 
	
	wire    [DATAWIDTH-1:0] scc_dataout;
	reg     [IO_SDATA_BITS - 1:0] scc_io_cfg;
	reg     [DQS_SDATA_BITS - 1:0] scc_dqs_cfg;
	
	wire    [3:0] dqse_phase;
	
	//typedef bit [6:0] t_setting_mask;		//*** SV-to-V: 'typedef=>??? FIXED 

	//integer  setting_offsets[1:9] = '{ 'd0, 'd5, 'd8, 'd13, 'd13, 'd18, 'd0, 'd5, 'd10 };		//*** SV-to-V: 'integer unsigned=>integer 
        wire [31:0] setting_offsets[9:0];							//PN  --change from SV to Verilog							
	assign setting_offsets[1] = 'd0;
	assign setting_offsets[2] = 'd5;
	assign setting_offsets[3] = 'd8;
	assign setting_offsets[4] = 'd13;
	assign setting_offsets[5] = 'd13;
	assign setting_offsets[6] = 'd18;
	assign setting_offsets[7] = 'd0;
	assign setting_offsets[8] = 'd5;
	assign setting_offsets[9] = 'd10;
	
	//t_setting_mask setting_masks [1:9] = '{ 'b011111, 'b0111, 'b011111, 'b0, 'b011111, 'b011111, 'b011111, 'b011111, 'b011111 };
	wire [6:0] setting_masks [1:9];

	assign setting_masks[1] = 'b011111;
	assign setting_masks[2] = 'b0111;
	assign setting_masks[3] = 'b011111;
	assign setting_masks[4] = 'b0;
	assign setting_masks[5] = 'b011111;
	assign setting_masks[6] = 'b011111;
	assign setting_masks[7] = 'b011111;
	assign setting_masks[8] = 'b011111;
	assign setting_masks[9] = 'b011111;

	// decode phases
	
	seq_scc_hhp_phase_decode  # (
		.AVL_DATA_WIDTH         (AVL_DATA_WIDTH         ),
		.DLL_DELAY_CHAIN_LENGTH (DLL_DELAY_CHAIN_LENGTH )
	) seq_scc_phase_decode_dqe_inst (
		.avl_writedata          ({{('d32 - DATAWIDTH){1'b0}},((scc_dataout >> setting_offsets[SCC_ADDR_DQS_EN_PHASE]) & setting_masks[SCC_ADDR_DQS_EN_PHASE])}),			//PN  --change from SV to Verilog
		.dqse_phase             (dqse_phase             ),
		.dqse_map               (hhp_dqse_map           )
	);

	always @ (posedge scc_clk or negedge reset_n_scc_clk) begin		//*** SV-to-V: always_ff=>always 
		if (~reset_n_scc_clk) begin
			scc_io_cfg <= 0;		//*** SV-to-V: '0=>0 
			scc_dqs_cfg <= 0;		//*** SV-to-V: '0=>0 
		end
		else begin
			scc_io_cfg <= 0;		//*** SV-to-V: '0=>0 
			scc_dqs_cfg <= 0;		//*** SV-to-V: '0=>0 


			// DQS

			// T11 Ungating
			scc_dqs_cfg[4:0] <= (scc_dataout >> setting_offsets[SCC_ADDR_DQS_EN_DELAY]) & setting_masks[SCC_ADDR_DQS_EN_DELAY];
			
			// T11 Gating
			// If flag is set, use separate gating setting, otherwise use same as ungating
			if (hhp_extras[7]) 
				scc_dqs_cfg[9:5] <= (scc_dataout >> setting_offsets[SCC_ADDR_DQS_EN_DELAY_GATE]) & setting_masks[SCC_ADDR_DQS_EN_DELAY_GATE];
			else
				scc_dqs_cfg[9:5] <= (scc_dataout >> setting_offsets[SCC_ADDR_DQS_EN_DELAY]) & setting_masks[SCC_ADDR_DQS_EN_DELAY];

			scc_dqs_cfg[10] <= dqse_phase[3];  //enadqsenablephasetransferreg
			
			scc_dqs_cfg[15:11] <= (scc_dataout >> setting_offsets[SCC_ADDR_OCT_OUT1_DELAY]) & setting_masks[SCC_ADDR_OCT_OUT1_DELAY];
			
			// Bypass DQS Logic half-rate (0 engage, 1 bypass)
			scc_dqs_cfg[16] <= hhp_extras[0];

			scc_dqs_cfg[21:17] <= (scc_dataout >> setting_offsets[SCC_ADDR_DQS_IN_DELAY]) & setting_masks[SCC_ADDR_DQS_IN_DELAY];

			scc_dqs_cfg[22] <= dqse_phase[2]; //dqsenablectrlphaseinvert 
			
			scc_dqs_cfg[24:23] <= dqse_phase[1:0];  //dqsenablectrlphasesetting 


			// I/O
			
			scc_io_cfg[4:0] <= (scc_dataout >> setting_offsets[SCC_ADDR_IO_IN_DELAY]) & setting_masks[SCC_ADDR_IO_IN_DELAY];
			
			
			// T9 OE (using same as T9 output)
			if (hhp_extras[8]) 
				scc_io_cfg[9:5] <= (scc_dataout >> setting_offsets[SCC_ADDR_IO_OE_DELAY]) & setting_masks[SCC_ADDR_IO_OE_DELAY];
			else
				scc_io_cfg[9:5] <= (scc_dataout >> setting_offsets[SCC_ADDR_IO_OUT1_DELAY]) & setting_masks[SCC_ADDR_IO_OUT1_DELAY];

			// T9 output (using same as T9 OE)
			scc_io_cfg[14:10] <= (scc_dataout >> setting_offsets[SCC_ADDR_IO_OUT1_DELAY]) & setting_masks[SCC_ADDR_IO_OUT1_DELAY];

			// Input register Read Fifo mode:
			//   000: half-rate read fifo
			//   001: full-rate read fifo
			//   010: deserializer bit slip
			//   011: deserializer with input from bit-slip
			//   100: deserializer with input from IO
			//   101: serializer mode
			scc_io_cfg[17:15] <= hhp_extras[4:2];

			// Read FIFO Read Clock Source Select
			//   00: Select core CLKIN1
			//   01: Select DQS_CLK (PHY_CLK)
			//   10: Select SEQ_HR_CLK (PHY_CLK)
			//   11: Select VCC (Disabled)
			//scc_io_cfg[19:18] <= 2'b10;
			scc_io_cfg[19:18] <= hhp_extras[6:5];


			// bypass IOE Register half-rate register
			//   0: engage half-rate register
			//   1: bypass half-rate register
			scc_io_cfg[20] <= hhp_extras[1];
		end
	end
	
endmodule
