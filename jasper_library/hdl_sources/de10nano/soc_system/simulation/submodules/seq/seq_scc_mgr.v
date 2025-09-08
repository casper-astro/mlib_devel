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


// ******
// scc_mgr
// ******
//
// SCC Manager
//
// General Description
// -------------------
//
// This component allows the NIOS to control the delay chains in the IOs.
//

// altera message_off 10230

`timescale 1 ps / 1 ps

module seq_scc_mgr (
	// Avalon Interface
	
	avl_clk,
	avl_reset_n,
	avl_address,
	avl_write,
	avl_writedata,
	avl_read,
	avl_readdata,
	avl_waitrequest,

	scc_reset_n,
	scc_clk,
	scc_clk_out,
	scc_data,
	scc_dqs_ena,
	scc_dqs_io_ena,
	scc_dq_ena,
	scc_dm_ena,
	scc_upd,
	
	capture_strobe_tracking,
	afi_init_req,
	afi_cal_req,
	debug_hphy_reg,
	debug_hphy_comb
	
);

	parameter AVL_DATA_WIDTH                = 32;
	parameter AVL_ADDR_WIDTH		= 13;

	parameter MEM_IF_READ_DQS_WIDTH	        = 1;
	parameter MEM_IF_WRITE_DQS_WIDTH	= 1;
	parameter MEM_IF_DQ_WIDTH               = 36;
	parameter MEM_IF_DM_WIDTH               = 4;

	parameter DLL_DELAY_CHAIN_LENGTH        = 8;
	parameter HHP_HPS                       = 0;
	parameter DQS_TRK_ENABLED               = 1;
	parameter DUAL_WRITE_CLOCK		= 0;

	localparam HHP_EXTRAS_OFFSET            = 0;
	localparam HHP_DQSE_MAP_OFFSET          = 1;

	localparam DQS_IN_PHASE_MAX = 3;
	localparam DQS_SDATA_BITS   = 30;
	localparam IO_SDATA_BITS    = 25;
	localparam DATAWIDTH        = 24;
	localparam RFILE_LATENCY    = 3;

	localparam MEM_DQ_PER_DQS   = (MEM_IF_DQ_WIDTH / MEM_IF_WRITE_DQS_WIDTH);
	localparam MEM_DM_PER_DQS   = (MEM_IF_DM_WIDTH > MEM_IF_WRITE_DQS_WIDTH) ? (MEM_IF_DM_WIDTH / MEM_IF_WRITE_DQS_WIDTH) : 1;
	localparam MEM_DQS_PER_DM   = (MEM_IF_DM_WIDTH < MEM_IF_WRITE_DQS_WIDTH) ? (MEM_IF_WRITE_DQS_WIDTH / MEM_IF_DM_WIDTH) : 1;

	localparam RFILE_DEPTH      = log2(MEM_DQ_PER_DQS + 1 + MEM_DM_PER_DQS + MEM_IF_READ_DQS_WIDTH - 1) + 1;

	//*** typedef enum integer {		//*** SV-to-V: typedef begin 
	localparam SCC_SCAN_DQS = 'b0000;	//*** 		SCC_SCAN_DQS		= 'b0000,		//*** SV-to-V: Found SCC_SCAN_DQS = 'b0000 
	localparam SCC_SCAN_DQS_IO = 'b0001;	//*** 		SCC_SCAN_DQS_IO		= 'b0001,		//*** SV-to-V: Found SCC_SCAN_DQS_IO = 'b0001 
	localparam SCC_SCAN_DQ_IO = 'b0010;	//*** 		SCC_SCAN_DQ_IO  	= 'b0010,		//*** SV-to-V: Found SCC_SCAN_DQ_IO = 'b0010 
	localparam SCC_SCAN_DM_IO = 'b0011;	//*** 		SCC_SCAN_DM_IO		= 'b0011,		//*** SV-to-V: Found SCC_SCAN_DM_IO = 'b0011 
	localparam SCC_SCAN_UPD = 'b1000;	//*** 		SCC_SCAN_UPD		= 'b1000		//*** SV-to-V: Found SCC_SCAN_UPD = 'b1000 
//*** 	} sdata_scan_t;		//*** SV-to-V: typedef sdata_scan_t end 

	input avl_clk;
	input avl_reset_n;
	input [AVL_ADDR_WIDTH - 1:0] avl_address;
	input avl_write;
	input [AVL_DATA_WIDTH - 1:0] avl_writedata;
	input avl_read;
	output [AVL_DATA_WIDTH - 1:0] avl_readdata;
	output avl_waitrequest;
	
	input scc_clk;
	input scc_reset_n;
	output [MEM_IF_READ_DQS_WIDTH - 1:0] scc_clk_out;				//PN - to support hard scc in HHP
	output scc_data;
	output [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_ena;
	output [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_io_ena;
	output [MEM_IF_DQ_WIDTH - 1:0] scc_dq_ena;
	output [MEM_IF_DM_WIDTH - 1:0] scc_dm_ena;
	output scc_upd;
	
	input [MEM_IF_READ_DQS_WIDTH - 1:0] capture_strobe_tracking;
	
	input afi_init_req;
	input afi_cal_req;

	//debug signals
	output wire [(13 + (DQS_TRK_ENABLED * 5)):0] debug_hphy_reg;
	output wire [12:0] debug_hphy_comb;

	// internal versions of interfacing signals.
	
	reg [AVL_DATA_WIDTH - 1:0] avl_readdata;
	wire  avl_waitrequest;							//PN  --change from SV to Verilog

	reg scc_data;
	reg [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_ena;
	reg [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_io_ena;
	reg [MEM_IF_DQ_WIDTH - 1:0] scc_dq_ena;
	reg [MEM_IF_DM_WIDTH - 1:0] scc_dm_ena;
	reg scc_upd;

	reg scc_data_c;
	reg [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_ena_c;
	reg [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_io_ena_c;
	reg [MEM_IF_DQ_WIDTH - 1:0] scc_dq_ena_c;
	reg [MEM_IF_DM_WIDTH - 1:0] scc_dm_ena_c;
	reg scc_upd_c;	


	reg scc_data_r;
	reg [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_ena_r;
	reg [MEM_IF_READ_DQS_WIDTH - 1:0] scc_dqs_io_ena_r;
	reg [MEM_IF_DQ_WIDTH - 1:0] scc_dq_ena_r;
	reg [MEM_IF_DM_WIDTH - 1:0] scc_dm_ena_r;
	reg scc_upd_r;

	// IO config register
	
	wire [IO_SDATA_BITS - 1:0] scc_io_cfg;					//PN  --change from SV to Verilog
	reg [IO_SDATA_BITS - 1:0] scc_io_cfg_curr;
	reg [IO_SDATA_BITS - 1:0] scc_io_cfg_next;
	
	// DQS config register
	
	wire  [DQS_SDATA_BITS - 1:0] scc_dqs_cfg;				//PN  --change from SV to Verilog
	reg [DQS_SDATA_BITS - 1:0] scc_dqs_cfg_curr;
	reg [DQS_SDATA_BITS - 1:0] scc_dqs_cfg_next;
	
	// is scc manager selected?
	
	wire sel_scc;								//PN  --change from SV to Verilog

	// go signal going to the SCC clock side.
	reg [3:0] scc_go_ena;
	reg [3:0] scc_go_ena_r;
	wire scc_go_group;
	wire scc_go_io;
	wire scc_go_update;
	
	// enable pattern.
	
	reg [7:0] scc_ena_addr;
	reg [255:0] scc_ena_addr_decode;

	// done signal coming back from the scc side.
	
	reg scc_done;
	
	// avalon version of scc done signal
	
	reg avl_done;
	
	// tracking signals
	reg    avl_cmd_trk_afi_end;
	wire   [AVL_DATA_WIDTH - 1:0] read_sample_counter;

	localparam SAMPLE_COUNTER_WIDTH = 16;

	// SCAN state machine

	//*** typedef enum int unsigned {		//*** SV-to-V: typedef begin 
	localparam STATE_SCC_IDLE = 0;	//*** 		STATE_SCC_IDLE,		//*** SV-to-V: Found STATE_SCC_IDLE, using val 0
	localparam STATE_SCC_LOAD = 1;	//*** 		STATE_SCC_LOAD,		//*** SV-to-V: Found STATE_SCC_LOAD, using val 1
	localparam STATE_SCC_DONE = 2;	//*** 		STATE_SCC_DONE		//*** SV-to-V: Found STATE_SCC_DONE, using val 2
//*** 	} STATE_SCC_RAM_T;		//*** SV-to-V: typedef STATE_SCC_RAM_T end 
	
	 integer scc_state_curr, scc_state_next;		//*** SV-to-V: typedef STATE_SCC_RAM_T=>integer
	reg [7:0] scc_shift_cnt_curr;
	reg [7:0] scc_shift_cnt_next;
	
	wire    [DATAWIDTH-1:0]    datain;					//PN  --change from SV to Verilog
	wire    [DATAWIDTH-1:0]    dataout;
	wire   [RFILE_DEPTH-1:0]    write_addr;
	wire   [RFILE_DEPTH-1:0]    read_addr;
	reg    [5:0]    pin;
	wire    write_en;

	reg [DATAWIDTH-1:0] scc_dataout;

	reg [7:0] group_counter;
	wire avl_cmd_group_counter;
	wire [3:0] avl_cmd_section;
	wire avl_cmd_rfile_group_not_io;
	wire [5:0] avl_cmd_rfile_addr;

	wire avl_cmd_scan;
	wire avl_cmd_scan_begin;
	wire avl_cmd_scan_end;
	wire [5:0] avl_cmd_scan_addr;

	reg avl_doing_scan;
	reg scc_doing_scan;
	reg scc_doing_scan_r;
	reg [7:0] scc_group_counter;

	wire avl_cmd_rfile;
	wire avl_cmd_rfile_begin;
	wire avl_cmd_rfile_end;
	reg [RFILE_LATENCY-1:0] avl_cmd_rfile_latency;
	
	wire track_opr_check;
	wire avl_cmd_counter_access;
	wire avl_cmd_do_sample;

	wire avl_cmd_afi_req;

	reg avl_cmd_hhp_globals_end;
	wire avl_cmd_hhp_globals;
	wire avl_cmd_hhp_rfile;
	reg [AVL_DATA_WIDTH - 1:0] hhp_extras;
	reg [32 - 1:0] hhp_dqse_map;

	wire [AVL_DATA_WIDTH-1:0] shifted_dataout;
	
	// metastability flops
	reg avl_init_req_r;
	reg avl_cal_req_r;
	reg avl_init_req_r2;
	reg avl_cal_req_r2;
	reg avl_init_req_r3;
	reg avl_cal_req_r3;
	
	integer i;
	
	assign sel_scc = 1'b1;

	assign scc_clk_out = {MEM_IF_READ_DQS_WIDTH{scc_clk}};

	//integer scan_offsets[0:3] = '{ 0, MEM_IF_READ_DQS_WIDTH + MEM_DQ_PER_DQS, MEM_IF_READ_DQS_WIDTH, MEM_IF_READ_DQS_WIDTH + MEM_DQ_PER_DQS + 1 };
	wire [31:0] scan_offsets[0:3];						//PN  --change from SV to Verilog
	assign scan_offsets[0] = 0;
	assign scan_offsets[1] = MEM_IF_READ_DQS_WIDTH + MEM_DQ_PER_DQS;
	assign scan_offsets[2] = MEM_IF_READ_DQS_WIDTH;
	assign scan_offsets[3] = MEM_IF_READ_DQS_WIDTH + MEM_DQ_PER_DQS + 1;

	assign avl_cmd_section = avl_address[9:6];
	assign avl_cmd_group_counter = (sel_scc && (avl_cmd_section == 4'b0000));
	assign avl_cmd_rfile_group_not_io = ~(avl_address[9] == 1'b1 || avl_address[9:6] == 4'b0111) | (avl_cmd_section == 4'hB);

	assign avl_cmd_rfile = (sel_scc && (avl_cmd_section != 4'h0) && (avl_cmd_section != 4'hA) && 
					(avl_cmd_section != 4'hD) && (avl_cmd_section != 4'hE) && (avl_cmd_section != 4'hF));
	assign avl_cmd_rfile_begin = (avl_read || avl_write) && (avl_cmd_rfile || avl_cmd_group_counter) && ~(|avl_cmd_rfile_latency);
	assign avl_cmd_rfile_end = avl_cmd_rfile_latency[0];
	assign avl_cmd_rfile_addr = (avl_cmd_rfile_group_not_io ? 0 : MEM_IF_READ_DQS_WIDTH) + avl_address[5:0];		//*** SV-to-V: '0=>0 

	assign avl_cmd_scan = (sel_scc && avl_cmd_section == 4'he);
	assign avl_cmd_scan_begin = (avl_read || avl_write) && avl_cmd_scan && ~(avl_doing_scan) && ~(avl_done);
	assign avl_cmd_scan_end = avl_doing_scan && avl_done;
	assign avl_cmd_scan_addr = scan_offsets[avl_address[1:0]] + ((avl_writedata[7:0] == 8'hFF) ? 0 : avl_writedata[5:0]);		//*** SV-to-V: '0=>0 
	
	assign track_opr_check = (avl_address[5:0] == 6'b111111) ? 1'b1 : 0; 
	assign avl_cmd_counter_access = sel_scc && avl_cmd_section == 4'hF && !track_opr_check;
	assign avl_cmd_do_sample = (avl_write && sel_scc && avl_cmd_section == 4'hF && track_opr_check && avl_cmd_trk_afi_end);

	assign avl_cmd_afi_req = (sel_scc && avl_cmd_section == 4'hd);
	assign avl_cmd_hhp_globals = (sel_scc && avl_cmd_section == 4'hA);
	assign avl_cmd_hhp_rfile = (sel_scc && avl_cmd_section == 4'hB);

	assign avl_waitrequest = (~avl_reset_n) || (~avl_cmd_rfile_end && ~avl_cmd_scan_end && ~avl_cmd_trk_afi_end && ~avl_cmd_hhp_globals_end);
	always @* begin		//*** SV-to-V: always_comb=>always @*
	    if (avl_cmd_counter_access)
	        avl_readdata    =    read_sample_counter;
	    else
	        begin
	            if (avl_cmd_afi_req)
	                    avl_readdata    =    {avl_cal_req_r3,avl_init_req_r3};
	            else if (avl_cmd_rfile)
	                    avl_readdata    =    avl_cmd_hhp_rfile ? dataout : shifted_dataout;
	            else if (avl_cmd_hhp_globals && avl_address[5:0] == HHP_EXTRAS_OFFSET)
			    avl_readdata    =    hhp_extras;
	            else if (avl_cmd_hhp_globals && avl_address[5:0] == HHP_DQSE_MAP_OFFSET)
			    avl_readdata    =    hhp_dqse_map;
	            else if (avl_cmd_hhp_globals) begin
			    // synopsys translate_off
			    $display("[%0t] Unknown target for hhp global read %0h", $time, avl_address[5:0]);
			    // synopsys translate_on
			    avl_readdata    =    0;
	            end else
	                    avl_readdata    =    group_counter;
	        end
	end

			always @(posedge avl_clk or negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
			begin
				if (~avl_reset_n)
				begin
					avl_cmd_hhp_globals_end <= 0;
					//     bits: 0:0 = 1'b1   - dqs bypass
					//     bits: 1:1 = 1'b1   - dq bypass
					//     bits: 4:2 = 3'b001   - rfifo_mode
					//     bits: 6:5 = 2'b01  - rfifo clock_select
					//     bits: 7:7 = 1'b0  - separate gating from ungating setting
					//     bits: 8:8 = 1'b0  - separate OE from Output delay setting
					hhp_extras <= 'b000100111;
					hhp_dqse_map <= { 4'b1001, 4'b1000, 4'b1111, 4'b0110, 4'b0101, 4'b0100, 4'b0011, 4'b0010 };
				end
				else
				begin
					if (sel_scc && avl_cmd_hhp_globals && avl_write)
					begin
						if (avl_address[5:0] == HHP_EXTRAS_OFFSET)
							hhp_extras <= avl_writedata;
						else if (avl_address[5:0] == HHP_DQSE_MAP_OFFSET)
							hhp_dqse_map <= avl_writedata;
						else begin
							// synopsys translate_off
							$display("[%0t] Unknown target for global write %0h", $time, avl_address[5:0]);
							// synopsys translate_on
						end
					end
					if (sel_scc && avl_cmd_hhp_globals && (avl_write || avl_read) && ~avl_cmd_hhp_globals_end)
						avl_cmd_hhp_globals_end <= 1;
					else
						avl_cmd_hhp_globals_end <= 0;
				end
			end
			

	// Assert that the SCC manager only receives broadcast or single bit scan requests for DQS and DM I/Os.
//	ERROR_DQS_IO_SCAN_WRONG_DATA:
//*** 	assert property (@(posedge avl_clk) (avl_cmd_scan_begin && avl_address[3:0] == SCC_SCAN_DQS_IO) |-> (avl_writedata[7:0] == 8'hFF || avl_writedata[7:0] == 8'h00));		//*** SV-to-V: assert 
//	ERROR_DM_IO_SCAN_WRONG_DATA:
//*** 	assert property (@(posedge avl_clk) (avl_cmd_scan_begin && avl_address[3:0] == SCC_SCAN_DM_IO) |-> (avl_writedata[7:0] == 8'hFF || avl_writedata[7:0] < MEM_DM_PER_DQS));		//*** SV-to-V: assert 
//	ERROR_DQS_SCAN_WRONG_DATA:
//*** 	assert property (@(posedge avl_clk) (avl_cmd_scan_begin && avl_address[3:0] == SCC_SCAN_DQS) |-> (avl_writedata[7:0] == 8'hFF || avl_writedata[7:0] < MEM_IF_READ_DQS_WIDTH));		//*** SV-to-V: assert 
//	ERROR_DQ_IO_SCAN_WRONG_DATA:
//*** 	assert property (@(posedge avl_clk) (avl_cmd_scan_begin && avl_address[3:0] == SCC_SCAN_DQ_IO) |-> (avl_writedata[7:0] == 8'hFF || avl_writedata[7:0] < MEM_DQ_PER_DQS));		//*** SV-to-V: assert 

		
	//typedef bit [13:0] t_setting_mask;		//*** SV-to-V: 'typedef=>??? FIXED

	wire [31:0] setting_offsets[12:0];				//PN  --change from SV to Verilog
	wire [13:0] setting_masks [1:12];

      		  	//assign setting_offsets[1:9] = '{ 'd0, 'd5, 'd8, 'd13, 'd13, 'd18, 'd0, 'd5, 'd10 };

			assign setting_offsets[1] = 'd0;
			assign setting_offsets[2] = 'd5;
			assign setting_offsets[3] = 'd8;
			assign setting_offsets[4] = 'd13;
			assign setting_offsets[5] = 'd13;
			assign setting_offsets[6] = 'd18;
			assign setting_offsets[7] = 'd0;
			assign setting_offsets[8] = 'd5;
			assign setting_offsets[9] = 'd10;
			
			//assign setting_masks [1:9] = '{ 'b011111, 'b0111, 'b011111, 'b0, 'b011111, 'b011111, 'b011111, 'b011111, 'b011111 };

			assign setting_masks[1] = 'b011111;
			assign setting_masks[2] = 'b0111;
			assign setting_masks[3] = 'b011111;
			assign setting_masks[4] = 'b0;
			assign setting_masks[5] = 'b011111;
			assign setting_masks[6] = 'b011111;
			assign setting_masks[7] = 'b011111;
			assign setting_masks[8] = 'b011111;
			assign setting_masks[9] = 'b011111;

	always @(posedge avl_clk or negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
	begin
		if (~avl_reset_n)
		begin
			avl_cmd_rfile_latency <= 0;
			avl_doing_scan <= 0;
		end
		else begin
			avl_cmd_rfile_latency <= {avl_cmd_rfile_begin, avl_cmd_rfile_latency[RFILE_LATENCY - 1 : 1]};
			avl_doing_scan <= (avl_cmd_scan_begin || avl_doing_scan) && ~avl_done;
		end
	end

	assign read_addr = avl_cmd_scan ? avl_cmd_scan_addr : avl_cmd_rfile_addr;
	assign write_addr = avl_cmd_rfile_addr;
	assign write_en = avl_cmd_rfile && avl_write && avl_cmd_rfile_latency[1];

	assign datain = (dataout & (~(setting_masks[avl_cmd_section] << setting_offsets[avl_cmd_section]))) | ((setting_masks[avl_cmd_section] & avl_writedata) << setting_offsets[avl_cmd_section]);		//*** SV-to-V: '1=>??? FIXED

	assign shifted_dataout = (dataout >> setting_offsets[avl_cmd_section]) & setting_masks[avl_cmd_section];

	// config data storage
	
	
	seq_scc_reg_file #(
        .WIDTH  (DATAWIDTH),
		.DEPTH  (RFILE_DEPTH)
	) seq_scc_reg_file_inst (
        .clock      (avl_clk    ),
        .data       (avl_cmd_hhp_rfile ? avl_writedata[DATAWIDTH-1:0] : datain     ),
        .rdaddress  (read_addr  ),
        .wraddress  (write_addr ),
        .wren       (write_en   ),
        .q          (dataout    )
    );
	
	always @(posedge avl_clk or negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
	begin
		if (~avl_reset_n)
		begin
			group_counter <= 0;		//*** SV-to-V: '0=>0 
		end
		else begin
			if (avl_cmd_group_counter && avl_write)
			begin
				group_counter <= avl_writedata;
			end
		end
	end
	
	always @(posedge scc_clk or negedge scc_reset_n)		//*** SV-to-V: always_ff=>always 
	    begin
	        if (~scc_reset_n)
			begin
	            scc_dataout      <=    0;
				scc_doing_scan   <=    0;
				scc_doing_scan_r <=    0;
			end
	        else begin
	            scc_dataout      <=    dataout;
				scc_doing_scan   <=    avl_doing_scan;
				scc_doing_scan_r <=    scc_doing_scan;
			end
	    end	        
	
	// family specific decoder
		seq_scc_hhp_wrapper # (
			.DATAWIDTH              (DATAWIDTH              ),
			.IO_SDATA_BITS          (IO_SDATA_BITS          ),
			.DQS_SDATA_BITS         (DQS_SDATA_BITS         ),
			.AVL_DATA_WIDTH         (AVL_DATA_WIDTH         ),
			.DLL_DELAY_CHAIN_LENGTH (DLL_DELAY_CHAIN_LENGTH )
		) seq_scc_family_wrapper (
			.reset_n_scc_clk    (scc_reset_n        ),	
			.scc_clk            (scc_clk            ),
			.scc_dataout        (scc_dataout        ),
			.hhp_extras         (hhp_extras         ),
			.hhp_dqse_map       (hhp_dqse_map       ),
			.scc_io_cfg         (scc_io_cfg         ),
			.scc_dqs_cfg        (scc_dqs_cfg        )
		);
	
	// data transfer from SCC to AVALON
	
	always @ (posedge avl_clk) begin		//*** SV-to-V: always_ff=>always 
		avl_done <= scc_done;
	end
	
	// scan chain side state update
	// scan chain state machine transitions.
	
	always @ (posedge scc_clk or negedge scc_reset_n) begin		//*** SV-to-V: always_ff=>always 
		if (~scc_reset_n) begin
			scc_go_ena <= 0;		//*** SV-to-V: '0=>0 
			scc_go_ena_r <= 0;		//*** SV-to-V: '0=>0 
			scc_ena_addr <= 0;		//*** SV-to-V: '0=>0 
			scc_io_cfg_curr <= 0;		//*** SV-to-V: '0=>0 
			scc_dqs_cfg_curr <= 0;		//*** SV-to-V: '0=>0 
			scc_shift_cnt_curr <= 0;		//*** SV-to-V: '0=>0 
			scc_state_curr <= STATE_SCC_IDLE;
			scc_group_counter <= 0;		//*** SV-to-V: '0=>0 
		end
		else begin
			scc_go_ena <= avl_address[3:0];
			scc_go_ena_r <= scc_go_ena;
			scc_ena_addr <= avl_writedata[7:0];
			scc_io_cfg_curr <= scc_io_cfg_next;
			scc_dqs_cfg_curr <= scc_dqs_cfg_next;
			scc_shift_cnt_curr <= scc_shift_cnt_next;
			scc_state_curr <= scc_state_next;
			scc_group_counter <= group_counter;
		end
	end

	assign scc_go_group = (scc_go_ena_r == SCC_SCAN_DQS);
	assign scc_go_io = (scc_go_ena_r == SCC_SCAN_DQS_IO) || (scc_go_ena_r == SCC_SCAN_DQ_IO) || (scc_go_ena_r == SCC_SCAN_DM_IO);
	assign scc_go_update = (scc_go_ena_r == SCC_SCAN_UPD);


	always @ (negedge scc_clk) begin		//*** SV-to-V: always_ff=>always 
		scc_data <= scc_data_r;
		scc_dqs_ena <= scc_dqs_ena_r;
		scc_dqs_io_ena <= scc_dqs_io_ena_r;
		scc_dq_ena <= scc_dq_ena_r;
		scc_dm_ena <= scc_dm_ena_r;
		scc_upd <= scc_upd_r;	
	end

	always @ (posedge scc_clk or negedge scc_reset_n) begin
		if (~scc_reset_n) begin
			scc_data_r <= 0;
			scc_dqs_ena_r <= 0;
			scc_dqs_io_ena_r <= 0;
			scc_dq_ena_r <= 0;
			scc_dm_ena_r <= 0;
			scc_upd_r <= 0;	
		end
		else begin
			scc_data_r <= scc_data_c;
			scc_dqs_ena_r <= scc_dqs_ena_c;
			scc_dqs_io_ena_r <= scc_dqs_io_ena_c;
			scc_dq_ena_r <= scc_dq_ena_c;
			scc_dm_ena_r <= scc_dm_ena_c;
			scc_upd_r <= scc_upd_c;
		end
	end

	always @* begin		//*** SV-to-V: always_comb=>always @*
		scc_ena_addr_decode = 0;		//*** SV-to-V: '0=>0 

		if (scc_go_ena_r == SCC_SCAN_DQ_IO)
		begin
			if (scc_ena_addr == 8'b11111111) 
				scc_ena_addr_decode = {MEM_DQ_PER_DQS{1'b1}} << (scc_group_counter * MEM_DQ_PER_DQS);
			else
				scc_ena_addr_decode[scc_group_counter * MEM_DQ_PER_DQS + scc_ena_addr] = 1;
		end
		else if (scc_go_ena_r == SCC_SCAN_DQS) begin
			if (scc_ena_addr == 8'b11111111) 
				scc_ena_addr_decode = {255{1'b1}};		//*** SV-to-V: '1=>??? FIXED
			else
				scc_ena_addr_decode[scc_ena_addr] = 1;
		end
		else if (scc_go_ena_r == SCC_SCAN_DM_IO) begin
			if (scc_ena_addr == 8'b11111111) 
				scc_ena_addr_decode = {MEM_DM_PER_DQS{1'b1}} << ((scc_group_counter * MEM_DM_PER_DQS) >> log2(MEM_DQS_PER_DM));
			else
				scc_ena_addr_decode[(scc_group_counter >> log2(MEM_DQS_PER_DM)) * MEM_DM_PER_DQS + scc_ena_addr] = 1;
		end
		else begin
			if (scc_ena_addr == 8'b11111111) 
				scc_ena_addr_decode = {255{1'b1}};		//*** SV-to-V: '1=>??? FIXED
			else
				scc_ena_addr_decode[scc_group_counter] = 1;
		end
		
		scc_state_next = scc_state_curr;
		scc_shift_cnt_next = 0;		//*** SV-to-V: '0=>0 
		scc_io_cfg_next = scc_io_cfg;
		scc_dqs_cfg_next = scc_dqs_cfg;
		scc_data_c = 0;
		scc_dqs_ena_c = 0;		//*** SV-to-V: '0=>0 
		scc_dqs_io_ena_c = 0;		//*** SV-to-V: '0=>0 
		scc_dq_ena_c = 0;		//*** SV-to-V: '0=>0 
		scc_dm_ena_c = 0;		//*** SV-to-V: '0=>0 
		scc_upd_c = 0;
		scc_done = 0;

		case (scc_state_curr)
		STATE_SCC_IDLE: begin
			if (scc_doing_scan_r) begin
				if (scc_go_io) begin
					scc_state_next = STATE_SCC_LOAD;
					scc_shift_cnt_next = IO_SDATA_BITS - 1;
				end else if (scc_go_group) begin
					scc_state_next = STATE_SCC_LOAD;
					scc_shift_cnt_next = DQS_SDATA_BITS - 1;
				end else if (scc_go_update) begin
					scc_state_next = STATE_SCC_DONE;
					scc_upd_c = 1;
				end
			end
		end
		STATE_SCC_LOAD: begin
			scc_shift_cnt_next = scc_shift_cnt_curr - 1;

			if (scc_go_group) begin
				scc_dqs_ena_c = (scc_go_ena_r == SCC_SCAN_DQS) ? scc_ena_addr_decode : 0;		//*** SV-to-V: '0=>0 
				scc_data_c = scc_dqs_cfg_curr[DQS_SDATA_BITS - 1];
				scc_dqs_cfg_next = scc_dqs_cfg_curr << 1;
			end
			
			if (scc_go_io) begin
				scc_dqs_io_ena_c = (scc_go_ena_r == SCC_SCAN_DQS_IO) ? scc_ena_addr_decode : 0;		//*** SV-to-V: '0=>0 
				scc_dq_ena_c = (scc_go_ena_r == SCC_SCAN_DQ_IO) ? scc_ena_addr_decode : 0;		//*** SV-to-V: '0=>0 
				scc_dm_ena_c = (scc_go_ena_r == SCC_SCAN_DM_IO) ? scc_ena_addr_decode : 0;		//*** SV-to-V: '0=>0 
				scc_data_c = scc_io_cfg_curr[IO_SDATA_BITS - 1];
				scc_io_cfg_next = scc_io_cfg_curr << 1;
			end 
			
			if (scc_shift_cnt_curr == 0) begin
				scc_state_next = STATE_SCC_DONE;
			end
		end
		STATE_SCC_DONE:	begin
			scc_done = 1;

			if (~scc_doing_scan_r)
				scc_state_next = STATE_SCC_IDLE;
		end
		default : begin end
		endcase
	end
	
	always @(posedge avl_clk, negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
	    begin
	        if (~avl_reset_n)
	            avl_cmd_trk_afi_end    <=    1'b0;
	        else
	            begin
			    // added ' && ~avl_cmd_trk_afi_end) ' to end of conditional at the proper end
	                if (sel_scc && (avl_cmd_section == 4'hF || avl_cmd_section == 4'hd) && (avl_write || avl_read) && ~avl_cmd_trk_afi_end)
	                    avl_cmd_trk_afi_end    <=    1'b1;
	                else
	                    avl_cmd_trk_afi_end    <=    1'b0;
	            end
	    end
	
 
	generate
        if (DQS_TRK_ENABLED == 1)
        begin

        	reg    [MEM_IF_READ_DQS_WIDTH - 1:0] capture_strobe_tracking_r;
        	reg signed [SAMPLE_COUNTER_WIDTH - 1:0] sample_counter [MEM_IF_READ_DQS_WIDTH - 1:0];

		//debug signals
		assign debug_hphy_reg  = {avl_cmd_trk_afi_end,scc_state_curr[1:0],avl_done,scc_shift_cnt_curr[7:0],avl_doing_scan,capture_strobe_tracking_r[4:0],avl_cmd_hhp_globals_end};
		assign debug_hphy_comb = {read_sample_counter[5:0],scc_go_group,scc_go_io,scc_go_update,avl_cmd_rfile,avl_cmd_scan,avl_cmd_do_sample,avl_waitrequest};
 

		wire [SAMPLE_COUNTER_WIDTH - 1:0] temp;
                assign temp  =   sample_counter[avl_address[5:0]];
                assign read_sample_counter  =   {{(AVL_DATA_WIDTH-SAMPLE_COUNTER_WIDTH){temp[SAMPLE_COUNTER_WIDTH-1]}}, temp};
                
                always @(posedge avl_clk, negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
	                begin
	                    if (~avl_reset_n)
	                        capture_strobe_tracking_r    <=    1'b0;
	                    else
	                        capture_strobe_tracking_r    <=    capture_strobe_tracking;
	                end
	            
	            always @(posedge avl_clk, negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
	                begin
	                    if (~avl_reset_n)
	                        begin
	                            for (i=0; i<MEM_IF_READ_DQS_WIDTH; i=i+1)
	                            begin
	                                sample_counter[i]    <= 1'b0;
	                            end
	                        end
	                    else
	                        begin
	                            for (i=0; i<MEM_IF_READ_DQS_WIDTH; i=i+1)
	                            begin
	                                if (avl_cmd_counter_access && avl_write && i == avl_address[5:0])
	                                    sample_counter[i] <= avl_writedata;
	                                else if (avl_cmd_do_sample && (i == avl_writedata[7:0] || avl_writedata[7:0] == 8'hFF))
	                                    begin
	                                        if (capture_strobe_tracking_r[i])
	                                            begin
	                                                if (!sample_counter[i][SAMPLE_COUNTER_WIDTH-1] && &sample_counter[i][SAMPLE_COUNTER_WIDTH-2:0])
	                                                    sample_counter[i]    <=    sample_counter[i];
	                                                else
	                                                    sample_counter[i]    <=    sample_counter[i] + 1'b1;
	                                            end
	                                        else 
	                                            begin
	                                                if (sample_counter[i][SAMPLE_COUNTER_WIDTH-1] && ~(|sample_counter[i][SAMPLE_COUNTER_WIDTH-2:0]))
	                                                    sample_counter[i]    <=    sample_counter[i];
	                                                else
	                                                    sample_counter[i]    <=    sample_counter[i] - 1'b1;
	                                            end
	                                    end
	                            end
	                        end
	                end
	        end
        else
            begin
		//debug signals
		assign debug_hphy_reg  = {avl_cmd_trk_afi_end,scc_state_curr[1:0],avl_done,scc_shift_cnt_curr[7:0],avl_doing_scan,avl_cmd_hhp_globals_end};
		assign debug_hphy_comb = {read_sample_counter[5:0],scc_go_group,scc_go_io,scc_go_update,avl_cmd_rfile,avl_cmd_scan,avl_cmd_do_sample,avl_waitrequest};


                assign read_sample_counter  =   0;		//*** SV-to-V: '0=>0 
            end
	endgenerate
	
	always @(posedge avl_clk, negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
	    begin
	        if (~avl_reset_n)
	            begin
	                avl_init_req_r    <=    0;
	                avl_cal_req_r     <=    0;
	                avl_init_req_r2   <=    0;
	                avl_cal_req_r2    <=    0;
	                avl_init_req_r3   <=    0;
	                avl_cal_req_r3    <=    0;
	            end
	        else
	            begin
	                avl_init_req_r    <=    afi_init_req;
	                avl_cal_req_r     <=    afi_cal_req;
	                avl_init_req_r2   <=    avl_init_req_r;
	                avl_cal_req_r2    <=    avl_cal_req_r;
	                
	                if (avl_init_req_r2)
	                    avl_init_req_r3   <=    1;
	                else
	                    avl_init_req_r3   <=    0;
	                    
	                if (avl_cal_req_r2)
	                    avl_cal_req_r3    <=    1;
	                else
	                    avl_cal_req_r3    <=    0;
	            end
	    end

	function integer log2;
		input integer value;
		begin
		for (log2=0; value>0; log2=log2+1)
			value = value>>1;
		log2 = log2 - 1;
		end
	endfunction




endmodule
