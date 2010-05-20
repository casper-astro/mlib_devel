/* TODO: requires clean-up */
module dram_controller #(
   parameter BANK_WIDTH              = 2,       
                                       // # of memory bank addr bits.
   parameter CKE_WIDTH               = 1,       
                                       // # of memory clock enable outputs.
   parameter CLK_WIDTH               = 1,       
                                       // # of clock outputs.
   parameter COL_WIDTH               = 10,       
                                       // # of memory column bits.
   parameter CS_NUM                  = 1,       
                                       // # of separate memory chip selects.
   parameter CS_WIDTH                = 1,       
                                       // # of total memory chip selects.
   parameter CS_BITS                 = 0,       
                                       // set to log2(CS_NUM) (rounded up).
   parameter DM_WIDTH                = 9,       
                                       // # of data mask bits.
   parameter DQ_WIDTH                = 72,       
                                       // # of data width.
   parameter DQ_PER_DQS              = 8,       
                                       // # of DQ data bits per strobe.
   parameter DQS_WIDTH               = 9,       
                                       // # of DQS strobes.
   parameter DQ_BITS                 = 7,       
                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
   parameter DQS_BITS                = 4,       
                                       // set to log2(DQS_WIDTH).
   parameter ODT_WIDTH               = 1,       
                                       // # of memory on-die term enables.
   parameter ROW_WIDTH               = 13,       
                                       // # of memory row and # of addr bits.
   parameter ADDITIVE_LAT            = 0,       
                                       // additive write latency.
   parameter BURST_LEN               = 4,       
                                       // burst length (in double words).
   parameter BURST_TYPE              = 0,       
                                       // burst type (=0 seq; =1 interleaved).
   parameter CAS_LAT                 = 5,       
                                       // CAS latency.
   parameter ECC_ENABLE              = 0,       
                                       // enable ECC (=1 enable).
   parameter MULTI_BANK_EN           = 1,       
                                       // Keeps multiple banks open. (= 1 enable).
   parameter TWO_T_TIME_EN           = 0,       
                                       // 2t timing for unbuffered dimms.
   parameter ODT_TYPE                = 1,       
                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
   parameter REDUCE_DRV              = 0,       
                                       // reduced strength mem I/O (=1 yes).
   parameter REG_ENABLE              = 1,       
                                       // registered addr/ctrl (=1 yes).
   parameter TREFI_NS                = 7800,       
                                       // auto refresh interval (ns).
   parameter TRAS                    = 45000,       
                                       // active->precharge delay.
   parameter TRCD                    = 15000,       
                                       // active->read/write delay.
   parameter TRFC                    = 127333,       
                                       // refresh->refresh, refresh->active delay.
   parameter TRP                     = 15000,       
                                       // precharge->command delay.
   parameter TRTP                    = 7500,       
                                       // read->precharge delay.
   parameter TWR                     = 15000,       
                                       // used to determine write->precharge.
   parameter TWTR                    = 10000,       
                                       // write->read delay.
   parameter HIGH_PERFORMANCE_MODE   = "TRUE",       
                              // # = TRUE, the IODELAY performance mode is set
                              // to high.
                              // # = FALSE, the IODELAY performance mode is set
                              // to low.
   parameter CLK_FREQ                = 266,       
                                       // Core/Memory clock period (in ps).
   parameter DQS_IO_COL              = 18'b000000000000000000,       
                                       // I/O column location of DQS groups
                                       // (=0, left; =1 center, =2 right).
   parameter DQ_IO_MS                = 72'b101001011010010110100101101001011010010110100101101001011010010110100101
                                       // Master/Slave location of DQ I/O (=0 slave).
                                       // =1 for active low reset, =0 for active high.
  ) (
    input          clk0,
    input          clk90,
    input          clkdiv0,
    input          rst0,
    input          rst90,
    input          rstdiv0,
    output         phy_rdy,
    output         cal_fail,

    input   [31:0] app_cmd_addr,
    input          app_cmd_rnw,
    input          app_cmd_valid,
    input  [143:0] app_wr_data,
    input   [17:0] app_wr_be,
    output [143:0] app_rd_data,
    output         app_rd_valid,
    output         app_fifo_ready,

    output   [2:0] dram_ck,
    output   [2:0] dram_ck_n,
    output  [15:0] dram_a,
    output   [2:0] dram_ba,
    output         dram_ras_n,
    output         dram_cas_n,
    output         dram_we_n,
    output   [1:0] dram_cs_n,
    output   [1:0] dram_cke,
    output   [1:0] dram_odt,
    output   [8:0] dram_dm,
    inout    [8:0] dram_dqs,
    inout    [8:0] dram_dqs_n,
    inout   [71:0] dram_dq,
    output         dram_reset_n
  );

  assign dram_reset_n = 1'b1;

  wire [3:0]                             dbg_calib_done_nc;
  wire [3:0]                             dbg_calib_err_nc;
  wire [(6*DQ_WIDTH)-1:0]                dbg_calib_dq_tap_cnt_nc;
  wire [(6*DQS_WIDTH)-1:0]               dbg_calib_dqs_tap_cnt_nc;
  wire [(6*DQS_WIDTH)-1:0]               dbg_calib_gate_tap_cnt_nc;
  wire [DQS_WIDTH-1:0]                   dbg_calib_rd_data_sel_nc;
  wire [(5*DQS_WIDTH)-1:0]               dbg_calib_rden_dly_nc;
  wire [(5*DQS_WIDTH)-1:0]               dbg_calib_gate_dly_nc;

  wire wr_trans = app_cmd_valid && !app_cmd_rnw;

  reg wr_trans_second;
  always @(posedge clk0) begin
    wr_trans_second <= wr_trans;
  end

  wire app_wdf_wren = wr_trans || wr_trans_second;

  // memory initialization/control logic

  localparam APPDATA_WIDTH = DQ_WIDTH*2;
  localparam CLK_PERIOD    = CLK_FREQ == 150 ? 6666 :
                             CLK_FREQ == 200 ? 5000 :
                             CLK_FREQ == 266 ? 3759 :
                             CLK_FREQ == 333 ? 3003 :
                                               3759; /* default 266 */
  localparam SIM_ONLY    = 0;       // = 1 to skip SDRAM power up delay
  localparam DEBUG_EN    = 0;       // Enable debug signals/controls

  wire app_af_afull;
  wire app_wdf_afull;

  reg app_fifo_ready_reg;
  reg app_af_afull_z, app_wdf_afull_z;
  always @(posedge clk0) begin
    app_af_afull_z     <= app_af_afull;
    app_wdf_afull_z    <= app_wdf_afull;
    app_fifo_ready_reg <= !(app_af_afull_z || app_wdf_afull_z);
  end
  assign app_fifo_ready = app_fifo_ready_reg;


  ddr2_mem_if_top #
    (
     .BANK_WIDTH     (BANK_WIDTH),
     .CKE_WIDTH      (CKE_WIDTH),
     .CLK_WIDTH      (CLK_WIDTH),
     .COL_WIDTH      (COL_WIDTH),
     .CS_BITS        (CS_BITS),
     .CS_NUM         (CS_NUM),
     .CS_WIDTH       (CS_WIDTH),
     .DM_WIDTH       (DM_WIDTH),
     .DQ_WIDTH       (DQ_WIDTH),
     .DQ_BITS        (DQ_BITS),
     .DQ_PER_DQS     (DQ_PER_DQS),
     .DQS_BITS       (DQS_BITS),
     .DQS_WIDTH      (DQS_WIDTH),
     .ODT_WIDTH      (ODT_WIDTH),
     .ROW_WIDTH      (ROW_WIDTH),
     .APPDATA_WIDTH  (APPDATA_WIDTH),
     .ADDITIVE_LAT   (ADDITIVE_LAT),
     .BURST_LEN      (BURST_LEN),
     .BURST_TYPE     (BURST_TYPE),
     .CAS_LAT        (CAS_LAT),
     .ECC_ENABLE     (ECC_ENABLE),
     .MULTI_BANK_EN  (MULTI_BANK_EN),
     .TWO_T_TIME_EN  (TWO_T_TIME_EN),
     .ODT_TYPE       (ODT_TYPE),
     .DDR_TYPE       (1),
     .REDUCE_DRV     (REDUCE_DRV),
     .REG_ENABLE     (REG_ENABLE),
     .TREFI_NS       (TREFI_NS),
     .TRAS           (TRAS),
     .TRCD           (TRCD),
     .TRFC           (TRFC),
     .TRP            (TRP),
     .TRTP           (TRTP),
     .TWR            (TWR),
     .TWTR           (TWTR),
     .CLK_PERIOD     (CLK_PERIOD),
     .SIM_ONLY       (SIM_ONLY),
     .DEBUG_EN       (DEBUG_EN),
     .DQS_IO_COL     (DQS_IO_COL),
     .DQ_IO_MS       (DQ_IO_MS)
     )
    mem_if_top_inst
      (
       .clk0                   (clk0),
       .clk90                  (clk90),
       .clkdiv0                (clkdiv0),
       .rst0                   (rst0),
       .rst90                  (rst90),
       .rstdiv0                (rstdiv0),
       .app_af_cmd             (app_cmd_rnw ? 3'b001 : 3'b000),
       .app_af_addr            (app_cmd_addr),
       .app_af_wren            (app_cmd_valid),
       .app_wdf_wren           (app_wdf_wren),
       .app_wdf_data           (app_wr_data[(APPDATA_WIDTH)-1:0]),
       .app_wdf_mask_data      ( ~app_wr_be[(APPDATA_WIDTH/8)-1:0]), //active low
       .app_af_afull           (app_af_afull),
       .app_wdf_afull          (app_wdf_afull),
       .rd_data_valid          (app_rd_valid),
       .rd_data_fifo_out       (app_rd_data),
       .rd_ecc_error           (),
       .phy_init_done          (phy_rdy),
       .ddr_ck                 (dram_ck[CLK_WIDTH-1:0]),
       .ddr_ck_n               (dram_ck_n[CLK_WIDTH-1:0]),
       .ddr_addr               (dram_a[ROW_WIDTH-1:0]),
       .ddr_ba                 (dram_ba[BANK_WIDTH-1:0]),
       .ddr_ras_n              (dram_ras_n),
       .ddr_cas_n              (dram_cas_n),
       .ddr_we_n               (dram_we_n),
       .ddr_cs_n               (dram_cs_n),
       .ddr_cke                (dram_cke[CKE_WIDTH-1:0]),
       .ddr_odt                (dram_odt[ODT_WIDTH-1:0]),
       .ddr_dm                 (dram_dm[DM_WIDTH-1:0]),
       .ddr_dqs                (dram_dqs[DQS_WIDTH-1:0]),
       .ddr_dqs_n              (dram_dqs_n[DQS_WIDTH-1:0]),
       .ddr_dq                 (dram_dq[DQ_WIDTH-1:0]),
       .dbg_idel_up_all        (1'b0),
       .dbg_idel_down_all      (1'b0),
       .dbg_idel_up_dq         (1'b0),
       .dbg_idel_down_dq       (1'b0),
       .dbg_idel_up_dqs        (1'b0),
       .dbg_idel_down_dqs      (1'b0),
       .dbg_idel_up_gate       (1'b0),
       .dbg_idel_down_gate     (1'b0),
       .dbg_sel_idel_dq        ({DQ_BITS{1'b0}}),
       .dbg_sel_all_idel_dq    (1'b0),
       .dbg_sel_idel_dqs       ({DQS_BITS+1{1'b0}}),
       .dbg_sel_all_idel_dqs   (1'b0),
       .dbg_sel_idel_gate      ({DQS_BITS+1{1'b0}}),
       .dbg_sel_all_idel_gate  (1'b0),
       .dbg_calib_done         (dbg_calib_done_nc),
       .dbg_calib_err          (dbg_calib_err_nc),
       .dbg_calib_dq_tap_cnt   (dbg_calib_dq_tap_cnt_nc),
       .dbg_calib_dqs_tap_cnt  (dbg_calib_dqs_tap_cnt_nc),
       .dbg_calib_gate_tap_cnt (dbg_calib_gate_tap_cnt_nc),
       .dbg_calib_rd_data_sel  (dbg_calib_rd_data_sel_nc),
       .dbg_calib_rden_dly     (dbg_calib_rden_dly_nc),
       .dbg_calib_gate_dly     (dbg_calib_gate_dly_nc)
  );
  assign cal_fail = 1'b0;

generate if (CLK_WIDTH < 3) begin : clk_gen
  OBUFDS obufds_inst[3 - CLK_WIDTH - 1:0](
    .O( {dram_ck[2:CLK_WIDTH]}),
    .OB({dram_ck_n[2:CLK_WIDTH]}),
    .I({3 - CLK_WIDTH{1'b0}})
  );
end endgenerate

endmodule
