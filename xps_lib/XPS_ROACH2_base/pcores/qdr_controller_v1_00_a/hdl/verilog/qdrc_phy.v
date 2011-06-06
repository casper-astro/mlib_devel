module qdrc_phy(
    /* general signals */
    clk0,
    clk270,
    div_clk,
    reset,

    /* phy status signals */
    phy_rdy,
    cal_fail,

    /* user/phy interface signals */
    phy_addr,

    phy_wr_strb,
    phy_wr_data,
    phy_wr_ben,

    phy_rd_strb,
    phy_rd_data,

    /* FPGA infrastructure signals */
    qdr_d_rise,
    qdr_d_fall,
    qdr_q_rise,
    qdr_q_fall,
    qdr_bw_n_rise,
    qdr_bw_n_fall,
    qdr_w_n,
    qdr_r_n,
    qdr_sa,
    qdr_dll_off_n,

    dly_inc_dec_n,
    dly_en,
    dly_rst
  );
  parameter DATA_WIDTH   = 18;
  parameter BW_WIDTH     = 2;
  parameter ADDR_WIDTH   = 21;
  parameter CLK_FREQ     = 200;
  parameter BURST_LENGTH = 4;

  input  clk0, clk270, div_clk, reset;

  output phy_rdy, cal_fail;

  input  phy_wr_strb;
  input    [ADDR_WIDTH - 1:0] phy_addr;

  input  [DATA_WIDTH*2 - 1:0] phy_wr_data;
  input    [BW_WIDTH*2 - 1:0] phy_wr_ben;

  input  phy_rd_strb;
  output [DATA_WIDTH*2 - 1:0] phy_rd_data;

  output   [DATA_WIDTH - 1:0] qdr_d_rise;
  output   [DATA_WIDTH - 1:0] qdr_d_fall;
  input    [DATA_WIDTH - 1:0] qdr_q_rise;
  input    [DATA_WIDTH - 1:0] qdr_q_fall;

  output     [BW_WIDTH - 1:0] qdr_bw_n_rise;
  output     [BW_WIDTH - 1:0] qdr_bw_n_fall;
  output   [ADDR_WIDTH - 1:0] qdr_sa;
  output qdr_w_n;
  output qdr_r_n;

  output qdr_dll_off_n;

  output   [DATA_WIDTH - 1:0] dly_inc_dec_n;
  output   [DATA_WIDTH - 1:0] dly_en;
  output   [DATA_WIDTH - 1:0] dly_rst;

  wire bit_align_start,   bit_align_done,   bit_align_fail;
  wire burst_align_start, burst_align_done, burst_align_fail;

  qdrc_phy_sm qdrc_phy_sm_inst (
    .clk   (clk0),
    .reset (reset),
    /* qdr_dll_off signal */
    .qdr_dll_off_n (qdr_dll_off_n),
    /* PHY status signals */
    .phy_rdy  (phy_rdy),
    .cal_fail (cal_fail),
    /* Bit and burst alignment signals */
    .bit_align_start   (bit_align_start),
    .bit_align_done    (bit_align_done),
    .bit_align_fail    (bit_align_fail),
    .burst_align_start (burst_align_start),
    .burst_align_done  (burst_align_done),
    .burst_align_fail  (burst_align_fail)
  );

  /************ Bit Alignment Logic ***************/
  /* qdr external output signals */
  wire [DATA_WIDTH - 1:0] qdr_d_rise_bit;
  wire [DATA_WIDTH - 1:0] qdr_d_fall_bit;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_rise_bit;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_fall_bit;
  wire [ADDR_WIDTH - 1:0] qdr_sa_bit;
  wire qdr_w_n_bit;
  wire qdr_r_n_bit;

  /* bit aligned qdr data */
  wire [DATA_WIDTH - 1:0] qdr_q_rise_cal;
  wire [DATA_WIDTH - 1:0] qdr_q_fall_cal;

  qdrc_phy_bit_align #(
    .DATA_WIDTH   (DATA_WIDTH),
    .BW_WIDTH     (BW_WIDTH),
    .ADDR_WIDTH   (ADDR_WIDTH),
    .CLK_FREQ     (CLK_FREQ),
    .BURST_LENGTH (BURST_LENGTH),
    .BYPASS       (1'b0)
  ) qdrc_phy_bit_align_inst (
    /* Misc signals */
    .clk0    (clk0),
    .clk270  (clk270),
    .div_clk (div_clk),
    .reset   (reset),

    /* State control signals */
    .bit_align_start   (bit_align_start),
    .bit_align_done    (bit_align_done),
    .bit_align_fail    (bit_align_fail),

    /* Delay Control Signals */
    .dly_inc_dec_n     (dly_inc_dec_n),
    .dly_en            (dly_en),
    .dly_rst           (dly_rst),

    /* External QDR signals  */
    .qdr_d_rise    (qdr_d_rise_bit),
    .qdr_d_fall    (qdr_d_fall_bit),
    .qdr_q_rise    (qdr_q_rise),
    .qdr_q_fall    (qdr_q_fall),
    .qdr_bw_n_rise (qdr_bw_n_rise_bit),
    .qdr_bw_n_fall (qdr_bw_n_fall_bit),
    .qdr_w_n       (qdr_w_n_bit),
    .qdr_r_n       (qdr_r_n_bit),
    .qdr_sa        (qdr_sa_bit),

    /* Bit aligned Datal */
    .qdr_q_rise_cal (qdr_q_rise_cal),
    .qdr_q_fall_cal (qdr_q_fall_cal)
  );

  /************ Burst Alignment Logic ***************/
  /* qdr external output signals */
  wire [DATA_WIDTH - 1:0] qdr_d_rise_burst;
  wire [DATA_WIDTH - 1:0] qdr_d_fall_burst;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_rise_burst;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_fall_burst;
  wire [ADDR_WIDTH - 1:0] qdr_sa_burst;
  wire qdr_w_n_burst;
  wire qdr_r_n_burst;

  /* qdr fully calibrated data out */
  wire [DATA_WIDTH - 1:0] qdr_q_rise_done;
  wire [DATA_WIDTH - 1:0] qdr_q_fall_done;

  qdrc_phy_burst_align #(
    .DATA_WIDTH   (DATA_WIDTH),
    .BW_WIDTH     (BW_WIDTH),
    .ADDR_WIDTH   (ADDR_WIDTH),
    .CLK_FREQ     (CLK_FREQ),
    .BURST_LENGTH (BURST_LENGTH),
    .BYPASS       (1'b0)
  ) qdrc_phy_burst_align_inst (
    /* Misc signals */
    .clk   (clk0),
    .reset (reset),

    /* State control signals */
    .burst_align_start   (burst_align_start),
    .burst_align_done    (burst_align_done),
    .burst_align_fail    (burst_align_fail),

    /* External QDR signals  */
    .qdr_d_rise    (qdr_d_rise_burst),
    .qdr_d_fall    (qdr_d_fall_burst),
    .qdr_q_rise    (qdr_q_rise_cal),
    .qdr_q_fall    (qdr_q_fall_cal),
    .qdr_bw_n_rise (qdr_bw_n_rise_burst),
    .qdr_bw_n_fall (qdr_bw_n_fall_burst),
    .qdr_w_n       (qdr_w_n_burst),
    .qdr_r_n       (qdr_r_n_burst),
    .qdr_sa        (qdr_sa_burst),

    .qdr_q_rise_cal (qdr_q_rise_done),
    .qdr_q_fall_cal (qdr_q_fall_done)

  );

  /************ User signal assignments ***************/

  assign qdr_d_rise = !bit_align_done   ? qdr_d_rise_bit   :
                      !burst_align_done ? qdr_d_rise_burst :
                                          phy_wr_data[DATA_WIDTH - 1:0];

  assign qdr_d_fall = !bit_align_done   ? qdr_d_fall_bit   :
                      !burst_align_done ? qdr_d_fall_burst :
                                          phy_wr_data[2*DATA_WIDTH - 1:DATA_WIDTH];

  assign qdr_bw_n_rise = !bit_align_done   ? qdr_bw_n_rise_bit   :
                         !burst_align_done ? qdr_bw_n_rise_burst :
                                             ~phy_wr_ben[BW_WIDTH - 1:0];

  assign qdr_bw_n_fall = !bit_align_done   ? qdr_bw_n_fall_bit   :
                         !burst_align_done ? qdr_bw_n_fall_burst :
                                             ~phy_wr_ben[BW_WIDTH*2 - 1:BW_WIDTH];

  assign qdr_sa = !bit_align_done   ? qdr_sa_bit   :
                  !burst_align_done ? qdr_sa_burst :
                                      phy_addr;

  assign qdr_w_n = !bit_align_done   ? qdr_w_n_bit   :
                   !burst_align_done ? qdr_w_n_burst :
                                       !phy_wr_strb;

  assign qdr_r_n = !bit_align_done   ? qdr_r_n_bit   :
                   !burst_align_done ? qdr_r_n_burst :
                                       !phy_rd_strb;
  

  assign phy_rd_data = {qdr_q_fall_done, qdr_q_rise_done};


endmodule
