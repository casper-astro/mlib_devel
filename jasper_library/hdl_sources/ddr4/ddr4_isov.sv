`default_nettype none

// TODO consider not requiring the user to left shift the addr and take care of that internally here
module ddr4_isov #(
  parameter DDR_ADDR_WID=32, // must be <32 and a multiple of 8. The actual width is 30
  parameter DDR_DATA_WID=512,
  parameter TX_FIFO_DEPTH=256,
  parameter RX_FIFO_DEPTH=256,
  parameter DM_DBI_WID=8,
  parameter DQ_WID=64,
  parameter DQS_WID=8,
  parameter DDR_ADR_WID=17,
  parameter BA_WID=2
) (
  input wire logic user_clk,
  input wire logic sys_rst,
  // simulink write side
  input wire logic [DDR_ADDR_WID-1:0] user_addr,      // simulink
  input wire logic user_valid,                        // simulink
  input wire logic [2:0] user_cmd,                    // simulink
  output logic user_cmd_ready,                        // simulink
  input wire logic [DDR_DATA_WID-1:0] user_wr_data,   // simulink 
  input wire logic [DDR_DATA_WID/8-1:0] user_wr_mask, // simulink

  // simulink read side
  output logic [DDR_DATA_WID-1:0] user_rd_tdata, // simulink
  output logic user_rd_tvalid,                   // simulink
  input wire logic user_rd_tready,               // simulink
  output logic ddr_fifo_ready,                   // simulink

    // ddr4 interface
    input wire logic ddr4_c0_sys_clk_n,
    input wire logic ddr4_c0_sys_clk_p,
    inout wire logic [DM_DBI_WID-1:0] ddr4_dm_dbi_n,
    inout wire logic [DQ_WID-1:0] ddr4_dq,
    inout wire logic [DQS_WID-1:0] ddr4_dqs_c,
    inout wire logic [DQS_WID-1:0] ddr4_dqs_t,
    output logic ddr4_act_n,
    output logic [DDR_ADR_WID-1:0] ddr4_adr,
    output logic [BA_WID-1:0] ddr4_ba,
    output logic ddr4_bg,
    output logic ddr4_ck_c,
    output logic ddr4_ck_t,
    output logic ddr4_cke,
    output logic ddr4_cs_n,
    output logic ddr4_odt,
    output logic ddr4_reset_n
);
// ddr4 control signals
logic ddr4_ui_clk;
logic ddr4_ui_sync_rst;
logic ddr4_calib_complete;
logic app_en, app_rdy;
logic [2:0] app_cmd;
logic [DDR_ADDR_WID-1:0] app_addr;

// ddr4 wr signals
logic [DDR_DATA_WID-1:0] app_wr_data;
logic [(DDR_DATA_WID/8)-1:0] app_wr_mask;
logic app_wr_en, app_wr_end, app_wr_rdy;

// ddr4 rd signals
logic [DDR_DATA_WID-1:0] app_rd_data;
logic app_rd_valid;
logic app_rd_end;

// cdc wire for ddr side read fifo's ready
logic rd_fifo_ready;

// cmd fifo pop signal
logic cmd_fifo_tvalid;
logic cmd_fifo_tready;
logic [DDR_ADDR_WID-1:0] cmd_fifo_tdest;

localparam int ADDR_LSB_SHIFT = 3;
localparam [2:0] WRITE_CMD = 3'b000;
localparam [2:0] READ_CMD  = 3'b001;

logic cmd_is_write;
logic cmd_is_read;
logic mig_ui_ready;
logic mig_accept_write, mig_accept_read, mig_accept;

assign cmd_is_write = (app_cmd == WRITE_CMD);
assign cmd_is_read  = (app_cmd == READ_CMD);

// Only issue traffic once MIG UI is actually usable.
assign mig_ui_ready = (~ddr4_ui_sync_rst) & ddr4_calib_complete;

// Accept a write only when both command and write-data channels can take it.
assign mig_accept_write = mig_ui_ready
                        & cmd_fifo_tvalid
                        & cmd_is_write
                        & app_rdy
                        & app_wr_rdy;

// Accept a read only when command channel can take it
// AND the rx FIFO can currently accept returned data.
assign mig_accept_read  = mig_ui_ready
                        & cmd_fifo_tvalid
                        & cmd_is_read
                        & app_rdy;

assign mig_accept = mig_accept_write | mig_accept_read;

// Pop cmd FIFO only when the command is actually accepted.
assign cmd_fifo_tready = mig_accept;

// Assert write-data strobes for an accepted write.
assign app_en      = mig_accept;
assign app_wr_en   = mig_accept_write;
assign app_wr_end  = mig_accept_write;
assign app_addr    = (cmd_fifo_tdest << ADDR_LSB_SHIFT);

xpm_fifo_axis #(
   .CASCADE_HEIGHT(0),
   .CDC_SYNC_STAGES(2),
   .CLOCKING_MODE("independent_clock"),
   .ECC_MODE("no_ecc"),
   .FIFO_DEPTH(TX_FIFO_DEPTH),
   .FIFO_MEMORY_TYPE("auto"),
   .PACKET_FIFO("false"),
   .PROG_EMPTY_THRESH(10),
   .PROG_FULL_THRESH(10),
   .RD_DATA_COUNT_WIDTH(1),
   .RELATED_CLOCKS(0),
   .SIM_ASSERT_CHK(0),
   .TDATA_WIDTH(DDR_DATA_WID),
   .TDEST_WIDTH(DDR_ADDR_WID),
   .TID_WIDTH(3),
   .TUSER_WIDTH(1),
   .USE_ADV_FEATURES("1000"),
   .WR_DATA_COUNT_WIDTH(1)
)
cmd_fifo_axis (
  // simulink side
  .s_aclk(user_clk),
  .s_aresetn(~sys_rst),
  .s_axis_tdata(user_wr_data),    // wr data
  .s_axis_tvalid(user_valid),     // app_en
  .s_axis_tlast(1'b0),
  .s_axis_tready(user_cmd_ready), // (output to simulink design - cmd fifo not full, is ready)

  .s_axis_tdest(user_addr),       // addr
  .s_axis_tid(user_cmd),          // cmd
  .s_axis_tkeep(user_wr_mask),    // mask

  // ddr side
  .m_aclk(ddr4_ui_clk),
  .m_axis_tdata(app_wr_data),
  .m_axis_tvalid(cmd_fifo_tvalid),
  .m_axis_tlast(),
  .m_axis_tready(cmd_fifo_tready),

  .m_axis_tdest(cmd_fifo_tdest),
  .m_axis_tid(app_cmd),
  .m_axis_tkeep(app_wr_mask),

    // status signals
    .wr_data_count_axis(),
    .rd_data_count_axis(),
    .almost_empty_axis(),
    .almost_full_axis(),
    .prog_empty_axis(),
    .prog_full_axis(),
      // unused
      .m_axis_tstrb(),
      .m_axis_tuser(),
      .s_axis_tstrb(64'b0),
      .s_axis_tuser(1'b0),
      .injectdbiterr_axis(1'b0),
      .injectsbiterr_axis(1'b0),
      .dbiterr_axis(),
      .sbiterr_axis()
);

xpm_fifo_axis #(
   .CASCADE_HEIGHT(0),
   .CDC_SYNC_STAGES(2),
   .CLOCKING_MODE("independent_clock"),
   .ECC_MODE("no_ecc"),
   .FIFO_DEPTH(RX_FIFO_DEPTH),
   .FIFO_MEMORY_TYPE("auto"),
   .PACKET_FIFO("false"),
   .PROG_EMPTY_THRESH(10),
   .PROG_FULL_THRESH(10),
   .RD_DATA_COUNT_WIDTH(1),
   .RELATED_CLOCKS(0),
   .SIM_ASSERT_CHK(0),
   .TDATA_WIDTH(DDR_DATA_WID),
   .TDEST_WIDTH(1),
   .TID_WIDTH(1),
   .TUSER_WIDTH(1),
   .USE_ADV_FEATURES("1000"),
   .WR_DATA_COUNT_WIDTH(1)
)
rx_fifo_axis (
  // ddr side
  .s_aclk(ddr4_ui_clk),
  .s_aresetn(~ddr4_ui_sync_rst),
  .s_axis_tdata(app_rd_data),
  .s_axis_tvalid(app_rd_valid),
  .s_axis_tlast(app_rd_end),
  .s_axis_tready(rd_fifo_ready),  // (output to simulink) rx fifo not full, if this goes to zero need to stop reads
                                  // fifo is full and must assume data was dropped and reads need to be reissued.
  // simulink side
  .m_aclk(user_clk),
  .m_axis_tdata(user_rd_tdata),
  .m_axis_tlast(),
  .m_axis_tvalid(user_rd_tvalid),
  .m_axis_tready(user_rd_tready),

    // status signals
    .wr_data_count_axis(),
    .rd_data_count_axis(),
    .almost_empty_axis(),
    .almost_full_axis(),
    .prog_empty_axis(),
    .prog_full_axis(),
      // unused
      .s_axis_tdest(1'b0),
      .s_axis_tid(1'b0),
      .s_axis_tkeep(64'b0),
      .s_axis_tuser(1'b0),
      .s_axis_tstrb(64'b0),
      .m_axis_tdest(),
      .m_axis_tid(),
      .m_axis_tkeep(),
      .m_axis_tstrb(),
      .m_axis_tuser(),
      .injectdbiterr_axis(1'b0),
      .injectsbiterr_axis(1'b0),
      .dbiterr_axis(),
      .sbiterr_axis()
);

ddr4_core  ddr4_inst (
  .c0_ddr4_app_en(app_en),
  .c0_ddr4_app_cmd(app_cmd),
  .c0_ddr4_app_rdy(app_rdy),
  .c0_ddr4_app_addr(app_addr),

  .c0_ddr4_app_wdf_data(app_wr_data),
  .c0_ddr4_app_wdf_wren(app_wr_en),
  .c0_ddr4_app_wdf_end(app_wr_end),
  .c0_ddr4_app_wdf_rdy(app_wr_rdy),
  .c0_ddr4_app_wdf_mask(app_wr_mask),

  .c0_ddr4_app_rd_data(app_rd_data),
  .c0_ddr4_app_rd_data_valid(app_rd_valid),
  .c0_ddr4_app_rd_data_end(app_rd_end),

    .c0_ddr4_app_hi_pri(1'b0),
    .c0_ddr4_act_n(ddr4_act_n),
    .c0_ddr4_adr(ddr4_adr),
    .c0_ddr4_ba(ddr4_ba),
    .c0_ddr4_bg(ddr4_bg),
    .c0_ddr4_ck_c(ddr4_ck_c),
    .c0_ddr4_ck_t(ddr4_ck_t),
    .c0_ddr4_cke(ddr4_cke),
    .c0_ddr4_cs_n(ddr4_cs_n),
    .c0_ddr4_dm_dbi_n(ddr4_dm_dbi_n),
    .c0_ddr4_dq(ddr4_dq),
    .c0_ddr4_dqs_c(ddr4_dqs_c),
    .c0_ddr4_dqs_t(ddr4_dqs_t),
    .c0_ddr4_odt(ddr4_odt),
    .c0_ddr4_reset_n(ddr4_reset_n),
    .c0_ddr4_ui_clk(ddr4_ui_clk),
    .c0_ddr4_ui_clk_sync_rst(ddr4_ui_sync_rst),
    .c0_init_calib_complete(ddr4_calib_complete),
    .c0_sys_clk_n(ddr4_c0_sys_clk_n),
    .c0_sys_clk_p(ddr4_c0_sys_clk_p),
  .dbg_bus(),
  .dbg_clk(),
  .sys_rst(sys_rst)
);

xpm_cdc_single #(
  .DEST_SYNC_FF(3),
  .INIT_SYNC_FF(1),   // enable simulation init values
  .SIM_ASSERT_CHK(1), // enable simulation messages
  .SRC_INPUT_REG(0)   // do not register the input
) cdc_inst (
  .dest_out(ddr_fifo_ready),
  .dest_clk(user_clk),
  .src_clk(1'b0),
  .src_in(rd_fifo_ready)
);

endmodule : ddr4_isov


