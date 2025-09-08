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
module altera_mem_if_hhp_qseq_top 
# ( parameter
	APB_DATA_WIDTH     = 32,
	APB_ADDR_WIDTH     = 32,
	AVL_DATA_WIDTH     = 32,
	AVL_ADDR_WIDTH     = 16, // for PHY
	AVL_MMR_DATA_WIDTH = 32,
	AVL_MMR_ADDR_WIDTH = 8,
	MEM_IF_DQS_WIDTH   = 1,
	MEM_IF_DQ_WIDTH    = 8,
	MEM_IF_DM_WIDTH    = 1,
	MEM_IF_CS_WIDTH    = 1
) (
	input  wire        avl_clk,
	input  wire        avl_reset_n,
	input  wire        apb_clk,
	input  wire        apb_reset_n,
	output wire [APB_DATA_WIDTH-1:0] prdata,
	output wire        pready,
	output wire        pslverr,
	input  wire [APB_DATA_WIDTH-1:0] pwdata,
	input  wire        pwrite,
	input  wire        penable,
	input  wire        psel,
	input  wire [APB_ADDR_WIDTH-1:0] paddr,
	input  wire        mmr_avl_waitrequest,
	input  wire [AVL_MMR_DATA_WIDTH-1:0] mmr_avl_readdata,
	input  wire        mmr_avl_readdatavalid,
	output wire        mmr_avl_burstcount,
	output wire [AVL_MMR_DATA_WIDTH-1:0] mmr_avl_writedata,
	output wire [AVL_MMR_ADDR_WIDTH-1:0]  mmr_avl_address,
	output wire        mmr_avl_write,
	output wire        mmr_avl_read,
	output wire [(AVL_MMR_DATA_WIDTH/8)-1:0]  mmr_avl_be,
	output wire        mmr_avl_debugaccess,
	output wire [AVL_ADDR_WIDTH-1:0] avl_address,
	output wire        avl_read,
	input  wire [AVL_DATA_WIDTH-1:0] avl_readdata,
	output wire        avl_write,
	output wire [AVL_DATA_WIDTH-1:0] avl_writedata,
	input  wire        avl_waitrequest,
	output wire        scc_data,
	output wire [MEM_IF_DQS_WIDTH-1:0]  scc_dqs_ena,
	output wire [MEM_IF_DQS_WIDTH-1:0]  scc_dqs_io_ena,
	output wire [MEM_IF_DQ_WIDTH-1:0] scc_dq_ena,
	output wire [MEM_IF_DM_WIDTH-1:0]  scc_dm_ena,
	output wire        scc_upd,
	input  wire [MEM_IF_DQS_WIDTH-1:0]  capture_strobe_tracking,
	input  wire        afi_init_req,
	input  wire        afi_cal_req,
	input  wire        scc_clk,
	input  wire        reset_n_scc_clk,
	output wire [MEM_IF_CS_WIDTH-1:0]  afi_seq_busy,
	input  wire [MEM_IF_CS_WIDTH-1:0]  afi_ctl_long_idle,
	input  wire [MEM_IF_CS_WIDTH-1:0]  afi_ctl_refresh_done
);

// MMR doesn't use BE, so we fake it out for test version and always enable
assign  mmr_avl_be = {(AVL_MMR_DATA_WIDTH/8){1'b1}};


// tracking manager expects all bits to be set for tracking signals
// but since it's hardened, depending on the variant, not all may be set
// so, if only single rank, replicate key signals to all inputs
wire [1:0] afi_ctl_long_idle_int;
wire [1:0] afi_ctl_refresh_done_int;
generate
	if (MEM_IF_CS_WIDTH == 1)
	begin
		assign afi_ctl_long_idle_int = {2{afi_ctl_long_idle[0]}};
		assign afi_ctl_refresh_done_int = {2{afi_ctl_refresh_done[0]}};
	end
	else
	begin
		assign afi_ctl_long_idle_int = afi_ctl_long_idle;
		assign afi_ctl_refresh_done_int = afi_ctl_refresh_done;
	end
endgenerate

seq seq_inst (
	.avl_clk(avl_clk),
	.avl_reset_n(avl_reset_n),
	.apb_clk(apb_clk),
	.apb_reset_n(apb_reset_n),
	.prdata(prdata),
	.pready(pready),
	.pslverr(pslverr),
	.pwdata(pwdata),
	.pwrite(pwrite),
	.penable(penable),
	.psel(psel),
	.paddr(paddr),
	.mmr_avl_waitrequest(mmr_avl_waitrequest),
	.mmr_avl_readdata(mmr_avl_readdata),
	.mmr_avl_readdatavalid(mmr_avl_readdatavalid),
	.mmr_avl_burstcount(mmr_avl_burstcount),
	.mmr_avl_writedata(mmr_avl_writedata),
	.mmr_avl_address(mmr_avl_address),
	.mmr_avl_write(mmr_avl_write),
	.mmr_avl_read(mmr_avl_read),
//	.mmr_avl_be(mmr_avl_be),
	.mmr_avl_debugaccess(mmr_avl_debugaccess),
	.avl_address(avl_address),
	.avl_read(avl_read),
	.avl_readdata(avl_readdata),
	.avl_write(avl_write),
	.avl_writedata(avl_writedata),
	.avl_waitrequest(avl_waitrequest),
	.scc_data(scc_data),
	.scc_dqs_ena(scc_dqs_ena),
	.scc_dqs_io_ena(scc_dqs_io_ena),
	.scc_dq_ena(scc_dq_ena),
	.scc_dm_ena(scc_dm_ena),
	.scc_upd(scc_upd),
	.capture_strobe_tracking(capture_strobe_tracking),
	.afi_init_req(afi_init_req),
	.afi_cal_req(afi_cal_req),
//	.scc_clk(scc_clk),
//	.reset_n_scc_clk(reset_n_scc_clk),
	.afi_seq_busy(afi_seq_busy),
	.afi_ctl_long_idle(afi_ctl_long_idle_int),
	.afi_ctl_refresh_done(afi_ctl_refresh_done_int)
);

endmodule
