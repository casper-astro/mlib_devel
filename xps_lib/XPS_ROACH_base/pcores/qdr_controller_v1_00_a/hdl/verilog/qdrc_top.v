module qdrc_top (
    /* QDR Infrastructure */
    clk0,
    clk180,
    clk270,
    div_clk,
    reset, //release when clock and delay elements are stable 
    /* Physical QDR Signals */
    qdr_d,
    qdr_q,
    qdr_sa,
    qdr_w_n,
    qdr_r_n,
    qdr_dll_off_n,
    qdr_bw_n,
    qdr_cq,
    qdr_cq_n,
    qdr_k,
    qdr_k_n,
    qdr_qvld,
    /* QDR PHY ready */
    phy_rdy, cal_fail,
    /* QDR read interface */
    usr_rd_strb,
    usr_wr_strb,
    usr_addr,

    usr_rd_data,
    usr_rd_dvld,

    usr_wr_data,
    usr_wr_be /* 'byte' enable */
  );
  parameter DATA_WIDTH   = 18;
  parameter BW_WIDTH     = 2;
  parameter ADDR_WIDTH   = 21;
  parameter BURST_LENGTH = 4;
  parameter CLK_FREQ     = 200;

  input clk0, clk180, clk270, div_clk;
  input reset;

  output [DATA_WIDTH - 1:0] qdr_d;
  input  [DATA_WIDTH - 1:0] qdr_q;
  output [ADDR_WIDTH - 1:0] qdr_sa;
  output qdr_w_n;
  output qdr_r_n;
  output qdr_dll_off_n;
  output   [BW_WIDTH - 1:0] qdr_bw_n;
  input  qdr_cq;
  input  qdr_cq_n;
  output qdr_k;
  output qdr_k_n;
  input  qdr_qvld;

  output phy_rdy;
  output cal_fail;

  input  usr_rd_strb;
  input  usr_wr_strb;
  input    [ADDR_WIDTH - 1:0] usr_addr;

  output [2*DATA_WIDTH - 1:0] usr_rd_data;
  output usr_rd_dvld;

  input  [2*DATA_WIDTH - 1:0] usr_wr_data;
  input    [2*BW_WIDTH - 1:0] usr_wr_be;

  /********** QDR Infrastucture *********/


  /* DDR rise and fall outputs*/
  wire [DATA_WIDTH - 1:0] qdr_d_rise;
  wire [DATA_WIDTH - 1:0] qdr_d_fall;
  wire [DATA_WIDTH - 1:0] qdr_q_rise;
  wire [DATA_WIDTH - 1:0] qdr_q_fall;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_rise;
  wire   [BW_WIDTH - 1:0] qdr_bw_n_fall;

  /* SDR control signals, pre-output buffer*/
  wire [ADDR_WIDTH - 1:0] qdr_sa_buf;
  wire qdr_w_n_buf;
  wire qdr_r_n_buf;
  wire qdr_dll_off_n_buf;

  /* Delay for ddr_q input alignment */
  wire [DATA_WIDTH - 1:0] dly_inc_dec_n;
  wire [DATA_WIDTH - 1:0] dly_en;
  wire [DATA_WIDTH - 1:0] dly_rst;

  wire reset0, reset180, reset270;

  qdrc_infrastructure #(
    .DATA_WIDTH (DATA_WIDTH),
    .BW_WIDTH   (BW_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH),
    .CLK_FREQ   (CLK_FREQ)
  ) qdrc_infrastructure_inst(
    /* general signals */
    .clk0     (clk0),
    .clk180   (clk180),
    .clk270   (clk270),
    .reset0   (reset0),
    .reset180 (reset180),
    .reset270 (reset270),
    /* external signals */
    .qdr_d         (qdr_d),
    .qdr_q         (qdr_q),
    .qdr_sa        (qdr_sa),
    .qdr_w_n       (qdr_w_n),
    .qdr_r_n       (qdr_r_n),
    .qdr_dll_off_n (qdr_dll_off_n),
    .qdr_bw_n      (qdr_bw_n),
    .qdr_cq        (qdr_cq),
    .qdr_cq_n      (qdr_cq_n),
    .qdr_k         (qdr_k),
    .qdr_k_n       (qdr_k_n),
    .qdr_qvld      (qdr_qvld),
    /* phy->external signals */
    .qdr_d_rise        (qdr_d_rise),
    .qdr_d_fall        (qdr_d_fall),
    .qdr_q_rise        (qdr_q_rise),
    .qdr_q_fall        (qdr_q_fall),
    .qdr_bw_n_rise     (qdr_bw_n_rise),
    .qdr_bw_n_fall     (qdr_bw_n_fall),
    .qdr_sa_buf        (qdr_sa_buf),
    .qdr_w_n_buf       (qdr_w_n_buf),
    .qdr_r_n_buf       (qdr_r_n_buf),
    .qdr_dll_off_n_buf (qdr_dll_off_n_buf),
    .qdr_cq_buf        (),
    .qdr_cq_n_buf      (),
    .qdr_qvld_buf      (qdr_qvld_buf),
    /* phy training signals */
    .dly_clk       (div_clk),
    .dly_inc_dec_n (dly_inc_dec_n),
    .dly_en        (dly_en),
    .dly_rst       (dly_rst)
  );

  /********* QDR PHY interface **********/

  wire phy_wr_strb;
  wire [2*DATA_WIDTH - 1:0] phy_wr_data;
  wire   [2*BW_WIDTH - 1:0] phy_wr_be;

  wire phy_rd_strb;
  wire [2*DATA_WIDTH - 1:0] phy_rd_data;

  wire   [ADDR_WIDTH - 1:0] phy_addr;

  qdrc_phy #(
    .DATA_WIDTH   (DATA_WIDTH),
    .BW_WIDTH     (BW_WIDTH),
    .ADDR_WIDTH   (ADDR_WIDTH),
    .CLK_FREQ     (CLK_FREQ),
    .BURST_LENGTH (BURST_LENGTH)
  ) qdrc_phy_inst(
    /* general signals */
    .clk0    (clk0),
    .clk270  (clk270),
    .div_clk (div_clk),
    .reset   (reset0),

    /* phy status signals */
    .phy_rdy  (phy_rdy),
    .cal_fail (cal_fail),

    /* user/phy interface signals */
    .phy_addr    (phy_addr),
    .phy_wr_strb (phy_wr_strb),
    .phy_wr_data (phy_wr_data),
    .phy_wr_ben  (phy_wr_be),

    .phy_rd_strb (phy_rd_strb),
    .phy_rd_data (phy_rd_data),

    /* FPGA infrastructure signals */
    .qdr_d_rise    (qdr_d_rise),
    .qdr_d_fall    (qdr_d_fall),
    .qdr_q_rise    (qdr_q_rise),
    .qdr_q_fall    (qdr_q_fall),
    .qdr_bw_n_rise (qdr_bw_n_rise),
    .qdr_bw_n_fall (qdr_bw_n_fall),
    .qdr_w_n       (qdr_w_n_buf),
    .qdr_r_n       (qdr_r_n_buf),
    .qdr_sa        (qdr_sa_buf),

    .qdr_dll_off_n (qdr_dll_off_n_buf),

    .dly_inc_dec_n (dly_inc_dec_n),
    .dly_en        (dly_en),
    .dly_rst       (dly_rst)
  );


  /********* QDR Write logic **********/
  assign phy_addr = usr_addr;

  qdrc_wr #(
    .DATA_WIDTH (DATA_WIDTH),
    .BW_WIDTH   (BW_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
  ) qdrc_wr_inst (
    .clk   (clk0),
    .reset (reset0),

    .usr_strb (usr_wr_strb),
    .usr_data (usr_wr_data),
    .usr_ben  (usr_wr_be),

    .phy_strb (phy_wr_strb),
    .phy_data (phy_wr_data),
    .phy_ben  (phy_wr_be)
  );

  /********* QDR Read logic **********/

  qdrc_rd #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
  ) qdrc_rd_inst (
    .clk   (clk0),
    .reset (reset0),

    .phy_rdy (phy_rdy),

    .usr_strb (usr_rd_strb),
    .usr_data (usr_rd_data),
    .usr_dvld (usr_rd_dvld),

    .phy_strb (phy_rd_strb),
    .phy_data (phy_rd_data)
  );

  /********** Reset Generation **********/

  reg reset_retimed0;
  assign reset0 = reset_retimed0;

  always @(posedge clk0) begin
    reset_retimed0 <= reset;
  end

  reg reset_retimed180;
  assign reset180 = reset_retimed180;

  always @(posedge clk180) begin
    reset_retimed180 <= reset;
  end

  reg reset_retimed270;
  assign reset270 = reset_retimed270;

  always @(posedge clk270) begin
    reset_retimed270 <= reset;
  end
  //synthesis attribute ASYNC_REG of reset_retimed0   is true
  //synthesis attribute ASYNC_REG of reset_retimed180 is true
  //synthesis attribute ASYNC_REG of reset_retimed270 is true

endmodule
