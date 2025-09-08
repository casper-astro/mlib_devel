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
// trk_mgr
// ******
//
// TRK Manager
//
// General Description
// -------------------
//
// This component interface to the controller to stall it after refresh
// takes over AFI interface, trigger RW manager to issue DQS calibration routine
// and issue scc manager to update its dqs delay chain when count is reached
//

`timescale 1 ps / 1 ps

module seq_trk_mgr #
    ( parameter
        MEM_CHIP_SELECT_WIDTH   = 1,
        MEM_DQS_WIDTH           = 2,
        AVL_DATA_WIDTH          = 32,
	AVL_MTR_ADDR_WIDTH      = 20, // should be larger than slave address since master is addressing a few slaves
	PHASE_WIDTH             = 4,
	READ_VALID_FIFO_SIZE    = 5,
        MUX_SEL_SEQUENCER_VAL   = 1,
        MUX_SEL_CONTROLLER_VAL  = 0,
	PHY_MGR_BASE            = 20'h00000,
	RW_MGR_BASE             = 20'h08000,
	SCC_MGR_BASE            = 20'h10000,
	REG_FILE_BASE           = 20'h18000
    )
    (
    // AFI interface to controller
    afi_ctl_refresh_done,
    afi_seq_busy,
    afi_ctl_long_idle,
    
	// Avalon Interface	
	avl_clk,
	avl_reset_n,
	avl_address,
	avl_write,
	avl_writedata,
	avl_read,
	avl_readdata,
	avl_waitrequest,
	debug_hphy_reg,
	debug_hphy_comb
	
	
);

	input [MEM_CHIP_SELECT_WIDTH - 1:0] afi_ctl_refresh_done;
	output [MEM_CHIP_SELECT_WIDTH - 1:0] afi_seq_busy;
	input [MEM_CHIP_SELECT_WIDTH - 1:0] afi_ctl_long_idle;

	input avl_clk;
	input avl_reset_n;
	output [AVL_MTR_ADDR_WIDTH - 1:0] avl_address;
	output avl_write;
	output [AVL_DATA_WIDTH - 1:0] avl_writedata;
	output avl_read;
	input [AVL_DATA_WIDTH - 1:0] avl_readdata;
	input avl_waitrequest;

	//debug signals
	output wire [24:0] debug_hphy_reg;
	output wire [ 1:0] debug_hphy_comb;
	
	
	
    localparam PHY_MGR_MUX_SEL  =    PHY_MGR_BASE+20'h04008;
    localparam PHY_MGR_INCVFIFO =    PHY_MGR_BASE+20'h00004;
    localparam RW_MGR_JMPCOUNT  =    RW_MGR_BASE+20'h800;
    localparam RW_MGR_JMPADDR   =    RW_MGR_BASE+20'hC00;
    localparam SCC_MGR_DO_SMPL  =    SCC_MGR_BASE+20'h00FFF;
    localparam SCC_MGR_SAMPLE   =    SCC_MGR_BASE+20'h00F00;
    localparam SCC_MGR_PHS      =    SCC_MGR_BASE+20'h00200;
    localparam SCC_MGR_DEL      =    SCC_MGR_BASE+20'h00300;
    localparam SCC_MGR_SCAN     =    SCC_MGR_BASE+20'h00E00;
    localparam SCC_MGR_UPDATE   =    SCC_MGR_BASE+20'h00E20;
    localparam REG_FILE_DTAP    =    REG_FILE_BASE+20'h0001C;
    localparam REG_FILE_SMPL    =    REG_FILE_BASE+20'h00020;
    localparam REG_FILE_LGIDL   =    REG_FILE_BASE+20'h00024;
    localparam REG_FILE_DELAY   =    REG_FILE_BASE+20'h00028;
    localparam REG_FILE_ADDR    =    REG_FILE_BASE+20'h0002C;
    localparam REG_FILE_NUM_DQS =    REG_FILE_BASE+20'h00030;
    localparam REG_FILE_RFSH    =    REG_FILE_BASE+20'h00034;
    
    localparam VFIFO_DEPTH	= READ_VALID_FIFO_SIZE;
	localparam ARF_COUNTER_WIDTH = 24;
	
	reg afi_ctl_refresh_done_r;
	reg afi_ctl_refresh_done_r2;
	wire [MEM_CHIP_SELECT_WIDTH - 1:0] afi_seq_busy;		//*** SV-to-V: 'logic=>reg ??? fixed/wire
	reg afi_ctl_long_idle_r;
	reg afi_ctl_long_idle_r2;
	
	reg [AVL_MTR_ADDR_WIDTH - 1:0] avl_address;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg avl_write;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [AVL_DATA_WIDTH - 1:0] avl_writedata;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg avl_read;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [AVL_DATA_WIDTH - 1:0] sample;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [AVL_DATA_WIDTH - 1:0] delay;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [AVL_DATA_WIDTH - 1:0] delay_result;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [AVL_DATA_WIDTH - 1:0] phase;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [AVL_DATA_WIDTH - 1:0] phase_result;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg increment_vfifo;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg decrement_vfifo;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	
	reg reset_jumplogic_done;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg avl_prdc_ack;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg avl_long_ack;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [5:0] substate; // for max of 32 groups		//*** SV-to-V: 'logic=>reg ??? fixme? 
	
	reg [AVL_DATA_WIDTH - 1:0] count; // used for both periodic and longidle, cannot track both at a time
	reg [AVL_DATA_WIDTH - 1:0] longidle_outer_loop;
	
	reg [AVL_DATA_WIDTH - 1:0] dtaps_per_ptap;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	wire [PHASE_WIDTH - 1:0] max_phase_value;		//*** SV-to-V: 'logic=>reg ??? fixed/wire 
	reg [5:0] afi_mux_delay;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [5:0] read_strobe_delay;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [READ_VALID_FIFO_SIZE - 1:0] vfifo_decr_loop;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [5:0] trcd_delay; // temporary storage for programmable_trcd
	reg [7:0] trfc_delay;
	
	reg [AVL_DATA_WIDTH - 1:0] cfg_sample_count;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [15:0] cfg_longidle_smpl_count;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [5:0] phy_mux_delay;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [5:0] vfifo_waitstate;		//*** SV-to-V: 'logic=>reg ??? fixme? 
	reg [AVL_DATA_WIDTH - 1:0] rw_mgr_concatenated_addr;		//*** SV-to-V: 'logic=>reg ??? fixme?
	reg [2:0] num_dqs;
	reg [5:0] programmable_trcd;
	reg [15:0] cfg_longidle_outer_loop;
	reg [ARF_COUNTER_WIDTH - 1:0] cfg_refresh_interval;
	reg [7:0] programmable_trfc;
	
	reg [7:0] rw_mgr_idle;
	reg [7:0] rw_mgr_activate_0_and_1;
	reg [7:0] rw_mgr_sgle_read;
	reg [7:0] rw_mgr_precharge_all;
	reg [7:0] rw_mgr_refresh;
	
	reg [ARF_COUNTER_WIDTH - 1 : 0] refresh_cnt;
	reg refresh_req;
	wire do_refresh;
	// typedef enum int unsigned {
		localparam TRK_MGR_STATE_IDLE = 0;
		localparam TRK_MGR_STATE_DTAPRD = 1;
		localparam TRK_MGR_STATE_RFILE_NUM_DQS = 2;
		localparam TRK_MGR_STATE_RFILE_ADDR = 3;
		localparam TRK_MGR_STATE_RFILE_SMPL = 4;
		localparam TRK_MGR_STATE_RFILE_LGIDL = 5;
		localparam TRK_MGR_STATE_RFILE_DELAY = 6;
		localparam TRK_MGR_STATE_RFILE_RFSH = 7;
		localparam TRK_MGR_STATE_JMPCOUNT = 8;
		localparam TRK_MGR_STATE_JMPADDR = 9;
		localparam TRK_MGR_STATE_INIT = 10;
		localparam TRK_MGR_STATE_REFRESH = 11;
		localparam TRK_MGR_STATE_ACTIVATE = 12;
		localparam TRK_MGR_STATE_READ = 13;
		localparam TRK_MGR_STATE_PRECHARGE = 14;
		localparam TRK_MGR_STATE_DO_SAMPLE = 15;
		localparam TRK_MGR_STATE_RD_SAMPLE = 16;
		localparam TRK_MGR_STATE_CLR_ALL_SMPL = 17;
		localparam TRK_MGR_STATE_CLR_SAMPLE = 18;
		localparam TRK_MGR_STATE_RD_DELAY = 19;
		localparam TRK_MGR_STATE_RD_PHASE = 20;
		localparam TRK_MGR_STATE_WR_DELAY = 21;
		localparam TRK_MGR_STATE_WR_PHASE = 22;
		localparam TRK_MGR_STATE_INCR_VFIFO = 23;
		localparam TRK_MGR_STATE_DECR_VFIFO = 24;
		localparam TRK_MGR_STATE_SCAN = 25;
		localparam TRK_MGR_STATE_UPDATE = 26;
		localparam TRK_MGR_STATE_RELEASE = 27;
		localparam TRK_MGR_STATE_DONE = 28;
	// } TRK_MGR_STATE;

	 integer avl_state;		//*** SV-to-V: typedef TRK_MGR_STATE=>integer
	
	assign afi_seq_busy = {MEM_CHIP_SELECT_WIDTH{avl_prdc_ack | avl_long_ack}};
	assign max_phase_value = {PHASE_WIDTH{1'b1}};
	
	// synchronizer
	always @(posedge avl_clk, negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
        begin
            if (!avl_reset_n)
                begin
                    afi_ctl_refresh_done_r  <=  0;
                    afi_ctl_refresh_done_r2 <=  0;
                    afi_ctl_long_idle_r     <=  0;
                    afi_ctl_long_idle_r2    <=  0;
                end
            else
                begin
                    afi_ctl_refresh_done_r  <=  afi_ctl_refresh_done[0]; // only want to check LSB
                    afi_ctl_refresh_done_r2 <=  afi_ctl_refresh_done_r;
                    afi_ctl_long_idle_r     <=  afi_ctl_long_idle[0]; // only want to check LSB
                    afi_ctl_long_idle_r2    <=  afi_ctl_long_idle_r;
                end
        end
	
	// calculate resulting delay
	always @(posedge avl_clk, negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
        begin
            if (!avl_reset_n)
                begin
                    delay_result  <=  0;
                    phase_result  <=  0;
                    increment_vfifo <=  0;
                    decrement_vfifo <=  0;
                end
            else
                begin
                    if (avl_state == TRK_MGR_STATE_WR_DELAY)
                        begin
                            if (!sample[AVL_DATA_WIDTH-1])
                                begin
                                    if (delay == 0)
                                        begin
                                            delay_result    <=  dtaps_per_ptap;
                                            if (phase == 0)
                                                begin
                                                    phase_result    <=  max_phase_value;
						    // FIXME: what if vfifo is at zero (of course, should never happen)
                                                    decrement_vfifo <=  1'b1;
                                                end
                                            else
                                                phase_result    <=  phase - 1'b1;
                                        end
                                    else
                                        begin
                                            delay_result  <=  delay - 1'b1;
                                            phase_result  <=  phase;
                                        end
                                end
                            else
                                begin
                                    if (delay == dtaps_per_ptap)
                                        begin
                                            delay_result    <=  0;
                                            if (phase == max_phase_value)
                                                begin
                                                    phase_result    <=  0;
						    // FIXME: what if vfifo is at max (of course, should never happen)
                                                    increment_vfifo <=  1'b1;
                                                end
                                            else
                                                phase_result    <=  phase + 1'b1;
                                        end
                                    else
                                        begin
                                            delay_result    <=  delay + 1'b1;
                                            phase_result    <=  phase;
                                        end
                                end
                        end
                    else if (avl_state == TRK_MGR_STATE_SCAN)
                        begin
                            increment_vfifo <=  0;
                            decrement_vfifo <=  0;
                        end
                end
        end
    assign do_refresh = (avl_state == TRK_MGR_STATE_REFRESH);
    // refresh counter
    always @(posedge avl_clk, negedge avl_reset_n)
        begin
            if (!avl_reset_n)
                begin
                    refresh_cnt <= 0;
                end
            else
                begin
                    if (do_refresh || afi_ctl_refresh_done_r2)
                        begin
                            refresh_cnt <= 1;
                        end
                    else if (refresh_cnt != {ARF_COUNTER_WIDTH{1'b1}})
                        begin
                            refresh_cnt <= refresh_cnt + 1'b1;
                        end
                end
        end
    // refresh request logic
    always @(posedge avl_clk, negedge avl_reset_n)
        begin
            if (!avl_reset_n)
                begin
                    refresh_req <= 1'b0;
                end
            else
                begin
                    if (do_refresh)
                        begin
                            refresh_req <= 1'b0;
                        end
                    else if (refresh_cnt >= cfg_refresh_interval)
                        begin
                            refresh_req <= 1'b1;
                        end
                    else
                        begin
                            refresh_req <= 1'b0;
                        end
                end
        end
	
	always @(posedge avl_clk, negedge avl_reset_n)		//*** SV-to-V: always_ff=>always 
        begin
            if (!avl_reset_n)
                begin
                    avl_state   <=  TRK_MGR_STATE_IDLE;
                    reset_jumplogic_done    <=  0;
                    substate        <=  0;
                    avl_prdc_ack    <=  0;
                    avl_long_ack    <=  0;
                    count           <=  0;
                    avl_address     <=  0;
	                avl_write       <=  1'b0;
	                avl_writedata   <=  0;
	                avl_read        <=  1'b0;
	                sample          <=  0;
	                delay           <=  0;
	                phase           <=  0;
	                afi_mux_delay   <=  0;
	                dtaps_per_ptap   <=  0;
	                read_strobe_delay       <=    0;
	                cfg_sample_count        <=    0;
	                cfg_longidle_smpl_count <=    0;
	                phy_mux_delay           <=    0;
	                vfifo_waitstate         <=    0;
	                vfifo_decr_loop <=  0;
	                trcd_delay      <=  0;
	                trfc_delay      <=  0;
			num_dqs <= 0;
	                programmable_trcd    <=    0;
	                longidle_outer_loop  <=    0;
	                rw_mgr_precharge_all    <=    0;
	                rw_mgr_sgle_read        <=    0;
	                rw_mgr_activate_0_and_1 <=    0;
	                rw_mgr_idle             <=    0;
	                cfg_longidle_outer_loop <=    0;
	                programmable_trfc       <=    0;
	                cfg_refresh_interval    <=    0;
	                rw_mgr_refresh          <=    0;
                end
            else
                case(avl_state)
                    TRK_MGR_STATE_IDLE :
                        begin
                            avl_read        <=  1'b0;
                            if (afi_ctl_refresh_done_r2)
                                begin
                                    if (reset_jumplogic_done)
                                        avl_state <= TRK_MGR_STATE_INIT;
                                    else
                                        avl_state <= TRK_MGR_STATE_DTAPRD;
                                    avl_prdc_ack    <=  1;
                                end
                            else if (afi_ctl_long_idle_r2)
                                begin
                                    if (reset_jumplogic_done)
                                        avl_state <= TRK_MGR_STATE_INIT;
                                    else
                                        avl_state <= TRK_MGR_STATE_DTAPRD;
                                    avl_long_ack    <=  1;
                                end
                            else
                                begin
                                    avl_state <= TRK_MGR_STATE_IDLE;
                                end
                        end
                    TRK_MGR_STATE_DTAPRD :
                        begin
                            avl_read <= 1'b1;
                            avl_address <= REG_FILE_DTAP;
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_RFILE_NUM_DQS;
                                    avl_read <= 1'b0;
                                    dtaps_per_ptap <= avl_readdata;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RFILE_NUM_DQS :
                        begin
                            avl_read <= 1'b1;
                            avl_address <= REG_FILE_NUM_DQS;
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_RFILE_ADDR;
                                    avl_read <= 1'b0;
				    num_dqs <= avl_readdata;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RFILE_ADDR :
                        begin
                            avl_read <= 1'b1;
                            avl_address <= REG_FILE_ADDR;
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_RFILE_SMPL;
                                    avl_read <= 1'b0;
                                    rw_mgr_precharge_all    <= avl_readdata[7:0];
                                    rw_mgr_sgle_read        <= avl_readdata[15:8];
                                    rw_mgr_activate_0_and_1 <= avl_readdata[23:16];
                                    rw_mgr_idle             <= avl_readdata[31:24];
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RFILE_SMPL :
                        begin
                            avl_read <= 1'b1;
                            avl_address <= REG_FILE_SMPL;
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_RFILE_LGIDL;
                                    avl_read <= 1'b0;
                                    cfg_sample_count <= avl_readdata;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RFILE_LGIDL :
                        begin
                            avl_read <= 1'b1;
                            avl_address <= REG_FILE_LGIDL;
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_RFILE_DELAY;
                                    avl_read <= 1'b0;
                                    cfg_longidle_smpl_count <= avl_readdata[15:0];
                                    cfg_longidle_outer_loop <= avl_readdata[31:16];
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RFILE_DELAY :
                        begin
                            avl_read <= 1'b1;
                            avl_address <= REG_FILE_DELAY;
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_RFILE_RFSH;
                                    avl_read <= 1'b0;
                                    phy_mux_delay <= avl_readdata[7:0];
                                    vfifo_waitstate <= avl_readdata[15:8];
                                    programmable_trcd <= avl_readdata[23:16];
                                    programmable_trfc <= avl_readdata[31:24];
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RFILE_RFSH :
                        begin
                            avl_read <= 1'b1;
                            avl_address <= REG_FILE_RFSH;
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_JMPCOUNT;
                                    avl_read <= 1'b0;
                                    cfg_refresh_interval <= avl_readdata[23:0];
                                    rw_mgr_refresh <= avl_readdata[31:24];
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_JMPCOUNT :
                        begin
                            // loop through substate value, empty all jump counter value
                            avl_write <= 1'b1;
                            avl_address <= RW_MGR_JMPCOUNT + {substate,2'b00}; // append two zeros because masters are byte addressed
                            avl_writedata <= 32'h00;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_state <= TRK_MGR_STATE_JMPADDR;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_JMPADDR :
                        begin
                            // loop through substate value, set jump address to idle
                            avl_write <= 1'b1;
                            avl_address <= RW_MGR_JMPADDR + {substate,2'b00};
                            avl_writedata <= rw_mgr_idle;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_write <= 1'b0;
                                    if (substate == 3) // this is 3 because RW has four jump counters
                                        begin
                                            avl_state   <=  TRK_MGR_STATE_INIT;
                                            reset_jumplogic_done    <=  1;
                                            substate    <=    0;
                                        end
                                    else
                                        begin
                                            avl_state   <=  TRK_MGR_STATE_JMPCOUNT;
                                            substate  <= substate + 1'b1;
                                        end
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_INIT :
                        begin
                            // sequencer takes control over path to memory
                            avl_write <= 1'b1;
                            avl_address <= PHY_MGR_MUX_SEL;
			    avl_writedata <= MUX_SEL_SEQUENCER_VAL;
                            if (afi_mux_delay != 0)
                                begin
                                    avl_write <= 1'b0;
                                    if (afi_mux_delay == 1)
                                        begin
                                            afi_mux_delay   <=  0;
                                            if (avl_prdc_ack)
                                                avl_state <= TRK_MGR_STATE_ACTIVATE;
                                            else
                                                begin
                                                    avl_state <= TRK_MGR_STATE_CLR_ALL_SMPL;
                                                    count   <=  0;
                                                    longidle_outer_loop <=  cfg_longidle_outer_loop;
                                                end
                                        end
                                    else
                                        afi_mux_delay   <=  afi_mux_delay - 1'b1;
                                end
                            else if (afi_mux_delay == 0 && !avl_waitrequest && avl_write)
                                begin
                                    afi_mux_delay   <=  phy_mux_delay;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_REFRESH :
                        begin                            
                            // command to RW MGR to refresh
                            avl_write <= 1'b1;
                            avl_address <= RW_MGR_BASE;
                            avl_writedata <= rw_mgr_refresh;
                            if (trfc_delay !=0)
                                begin
                                    avl_write <= 1'b0;
                                    if (trfc_delay == 1)
                                        begin
                                            trfc_delay   <=  0;
                                            avl_state <= TRK_MGR_STATE_ACTIVATE;
                                        end
                                    else
                                        trfc_delay   <=  trfc_delay - 1'b1;
                                end
                            else if (trfc_delay == 0 && !avl_waitrequest && avl_write)
                                begin
                                    trfc_delay  <=  programmable_trfc;
                                    avl_write <= 1'b0;                                    
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_ACTIVATE :
                        begin                            
                            // command to RW MGR to activate
                            avl_write <= 1'b1;
                            avl_address <= RW_MGR_BASE;
                            avl_writedata <= rw_mgr_activate_0_and_1;
                            
                            if (trcd_delay !=0)
                                begin
                                    avl_write <= 1'b0;
                                    if (trcd_delay == 1)
                                        begin
                                            trcd_delay   <=  0;
                                            avl_state <= TRK_MGR_STATE_READ;
                                end
                            else
                                        trcd_delay   <=  trcd_delay - 1'b1;
                        end
                            else if (trcd_delay == 0 && !avl_waitrequest && avl_write)
                                begin
                                    trcd_delay  <=  programmable_trcd;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_READ :
                        begin                            
                            // command to RW MGR to read
                            avl_write <= 1'b1;
                            avl_address <= RW_MGR_BASE;
                            avl_writedata <= rw_mgr_sgle_read;
                            if (read_strobe_delay != 0)
                                begin
                                    avl_write <= 1'b0;
                                    if (read_strobe_delay == 1)
                                        begin
                                            read_strobe_delay   <=  0;
                                                avl_state <= TRK_MGR_STATE_DO_SAMPLE;
                                        end
                                    else
                                        read_strobe_delay   <=  read_strobe_delay - 1'b1;
                                end
                            else if (read_strobe_delay == 0 && !avl_waitrequest && avl_write)
                                begin
                                    read_strobe_delay   <=  vfifo_waitstate;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_DO_SAMPLE :
                        begin
                            if (count != {AVL_DATA_WIDTH{1'b1}} && !avl_write)
                                count <= count + 1'b1;
                            
                            // command for SCC manager to take sample
                            avl_write <= 1'b1;
                            avl_address <= SCC_MGR_DO_SMPL;
                            avl_writedata <= 32'hFF; // data is the group to take sample FF is all groups
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_write <= 1'b0;
                                    if (avl_prdc_ack)
                                        avl_state <= TRK_MGR_STATE_PRECHARGE;
                                    else
                                        begin
                                            if (count >= cfg_longidle_smpl_count)
                                                begin
                                                    avl_state <= TRK_MGR_STATE_PRECHARGE;
                                                    count   <= 0;
                                                end
                                            else
                                                begin
                                                    if (refresh_req)
                                                        avl_state <= TRK_MGR_STATE_PRECHARGE;
                                                    else
                                                avl_state <= TRK_MGR_STATE_READ;
                                                end
                                        end
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_PRECHARGE :
                        begin                            
                            //__ACDS_USER_COMMENT__ command to RW MGR to precharge
                            avl_write <= 1'b1;
                            avl_address <= RW_MGR_BASE;
                            avl_writedata <= rw_mgr_precharge_all;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_write <= 1'b0;
                                    if (avl_prdc_ack)
                                        begin
                                            if (count >= cfg_sample_count)
                                                begin
                                                    avl_state <= TRK_MGR_STATE_RD_SAMPLE;
                                                    count   <= 0;
                                                end
                                            else
                                                avl_state <= TRK_MGR_STATE_RELEASE;
                                        end
                                    else
                                        begin
                                            if (count == 0)
                                        avl_state <= TRK_MGR_STATE_RD_SAMPLE;
                                            else
                                                avl_state <= TRK_MGR_STATE_REFRESH;
                                        end
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RD_SAMPLE :
                        begin
                            // read scc manager sample
                            avl_read <= 1'b1;
                            avl_address <= SCC_MGR_SAMPLE + {substate,2'b00}; // loops through all groups
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_CLR_SAMPLE;
                                    avl_read <= 1'b0;
                                    sample  <= avl_readdata;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_CLR_ALL_SMPL :
                        begin
                            // clear all scc manager sample
                            avl_write <= 1'b1;
                            avl_address <= SCC_MGR_SAMPLE + {substate,2'b00};
                            avl_writedata <= 32'h0;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    if (substate == num_dqs-1)
                                        begin
                                            avl_state <= TRK_MGR_STATE_ACTIVATE;
                                            substate  <= 0;
                                        end
                                    else
                                        begin
                                            avl_state <= TRK_MGR_STATE_CLR_ALL_SMPL;
                                            substate  <= substate + 1'b1;
                                        end
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_CLR_SAMPLE :
                        begin
                            // clear scc manager sample
                            avl_write <= 1'b1;
                            avl_address <= SCC_MGR_SAMPLE + {substate,2'b00};
                            avl_writedata <= 32'h0;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_state <= TRK_MGR_STATE_RD_DELAY;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RD_DELAY :
                        begin
                            // read existing scc manager delay
                            avl_read <= 1'b1;
                            avl_address <= SCC_MGR_DEL + {substate,2'b00};
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_RD_PHASE;
                                    avl_read <= 1'b0;
                                    delay  <= avl_readdata;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RD_PHASE :
                        begin
                            // read existing scc manager delay
                            avl_read <= 1'b1;
                            avl_address <= SCC_MGR_PHS + {substate,2'b00};
                            if (!avl_waitrequest && avl_read)
                                begin
                                    avl_state <= TRK_MGR_STATE_WR_DELAY;
                                    avl_read <= 1'b0;
                                    phase  <= avl_readdata;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_WR_DELAY :
                        begin
                            // write new value into scc manager
                            avl_write <= 1'b1;
                            avl_address <= SCC_MGR_DEL + {substate,2'b00};
                            avl_writedata <= delay_result;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_state <= TRK_MGR_STATE_WR_PHASE;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_WR_PHASE :
                        begin
                            // write new value into scc manager
                            avl_write <= 1'b1;
                            avl_address <= SCC_MGR_PHS + {substate,2'b00};
                            avl_writedata <= phase_result;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_write <= 1'b0;
                                    if (increment_vfifo)
                                        avl_state <= TRK_MGR_STATE_INCR_VFIFO;
                                    else if (decrement_vfifo)
                                        begin
                                            avl_state <= TRK_MGR_STATE_DECR_VFIFO;
                                            vfifo_decr_loop <=  VFIFO_DEPTH;
                                        end
                                    else
                                        avl_state <= TRK_MGR_STATE_SCAN;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_INCR_VFIFO :
                        begin
                            // increment vfifo
                            avl_write <= 1'b1;
                            avl_address <= PHY_MGR_INCVFIFO;
                            avl_writedata <= substate;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    avl_state <= TRK_MGR_STATE_SCAN;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_DECR_VFIFO :
                        begin
                            // decrement vfifo
                            avl_write <= 1'b1;
                            avl_address <= PHY_MGR_INCVFIFO;
                            avl_writedata <= substate;
                            if (!avl_waitrequest && avl_write && vfifo_decr_loop == 2)
                                begin
                                    avl_state <= TRK_MGR_STATE_SCAN;
                                    avl_write <= 1'b0;
                                end
                            else if (!avl_waitrequest && avl_write && vfifo_decr_loop > 0)
                                begin
                                    avl_state <= avl_state;
                                    vfifo_decr_loop <=  vfifo_decr_loop - 1'b1;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_SCAN :
                        begin
                            // scan new value
                            avl_write <= 1'b1;
                            avl_address <= SCC_MGR_SCAN;
                            avl_writedata <= substate;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    if (substate == num_dqs-1)
                                        begin
                                            avl_state <= TRK_MGR_STATE_UPDATE;
                                            substate  <= 0;
                                        end
                                    else
                                        begin
                                            avl_state <= TRK_MGR_STATE_RD_SAMPLE;
                                            substate  <= substate + 1'b1;
                                        end
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_UPDATE :
                        begin
                            // command for scc manager to update its DQS delay
                            avl_write <= 1'b1;
                            avl_address <= SCC_MGR_UPDATE;
                            avl_writedata <= 32'h01;
                            if (!avl_waitrequest && avl_write)
                                begin
                                    if ((avl_long_ack && longidle_outer_loop == 0) || avl_prdc_ack)
                                        begin
                                    avl_state <= TRK_MGR_STATE_RELEASE;
                                        end
                                    else
                                        begin
                                            avl_state <= TRK_MGR_STATE_ACTIVATE;
                                            longidle_outer_loop <=  longidle_outer_loop - 1'b1;
                                        end
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_RELEASE :
                        begin
                            if (avl_write && !avl_waitrequest)
                                begin
                                    avl_long_ack <= 0;
                                    avl_prdc_ack <= 0;
                                end
                            
                            // sequencer gives control over path to memory
                            avl_write <= 1'b1;
                            avl_address <= PHY_MGR_MUX_SEL;
			    avl_writedata <= MUX_SEL_CONTROLLER_VAL;
                            if (afi_mux_delay != 0)
                                begin
                                    avl_write <= 1'b0;
                                    if (afi_mux_delay == 1)
                                        begin
                                            afi_mux_delay   <=  0;
                                            avl_state <= TRK_MGR_STATE_DONE;
                                        end
                                    else
                                        afi_mux_delay   <=  afi_mux_delay - 1'b1;
                                end
                            else if (afi_mux_delay == 0 && !avl_waitrequest && avl_write)
                                begin
                                    afi_mux_delay   <=  phy_mux_delay;
                                    avl_write <= 1'b0;
                                end
                            else
                                avl_state <= avl_state;
                        end
                    TRK_MGR_STATE_DONE :
                        begin
                            if (!(afi_ctl_refresh_done_r2) && !(afi_ctl_long_idle_r2))
                                avl_state <= TRK_MGR_STATE_IDLE;
                            else
                                avl_state <= TRK_MGR_STATE_DONE;
                        end
		    default : 
			begin
			    avl_state <= TRK_MGR_STATE_IDLE;
			end
                endcase
        end

//debug signals
assign debug_hphy_reg  = {avl_state[4:0],phase_result[3:0],afi_ctl_refresh_done_r,afi_ctl_long_idle_r,increment_vfifo,decrement_vfifo,substate[5:0],delay_result[5:0]};
assign debug_hphy_comb = {avl_waitrequest,afi_seq_busy};

	
endmodule
