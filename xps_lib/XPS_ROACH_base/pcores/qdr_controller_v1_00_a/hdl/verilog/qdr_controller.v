module qdr_controller (
    /* QDR Infrastructure */
    clk0,
    clk180,
    clk270,
    div_clk,
    reset, //release when clock and delay elements are stable
    idelay_rdy, 
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
  parameter ADDR_WIDTH   = 22;
  parameter BURST_LENGTH = 4;
  parameter CLK_FREQ     = 200;

  input clk0, clk180, clk270, div_clk;
  input reset;
  input idelay_rdy;

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
  
  wire qdr_rst;
  
  assign qdr_rst = (idelay_rdy == 1'b0 || reset == 1'b1) ? 1'b1 : 1'b0;

  qdrc_top #(
    .DATA_WIDTH   (DATA_WIDTH  ),
    .BW_WIDTH     (BW_WIDTH    ),
    .ADDR_WIDTH   (ADDR_WIDTH  ),
    .BURST_LENGTH (BURST_LENGTH),
    .CLK_FREQ     (CLK_FREQ    )
  ) qdrc_top_inst (
    .clk0    (clk0),
    .clk180  (clk180),
    .clk270  (clk270),
    .div_clk (div_clk),
    .reset   (qdr_rst),

    .phy_rdy  (phy_rdy),
    .cal_fail (cal_fail),

    .qdr_d         (qdr_d),
    .qdr_q         (qdr_q),
    .qdr_sa        (qdr_sa),
    .qdr_w_n       (qdr_w_n),
    .qdr_r_n       (qdr_r_n),
    .qdr_bw_n      (qdr_bw_n),
    .qdr_cq        (qdr_cq),
    .qdr_cq_n      (qdr_cq_n),
    .qdr_k         (qdr_k),
    .qdr_k_n       (qdr_k_n),
    .qdr_qvld      (qdr_qvld),
    .qdr_dll_off_n (qdr_dll_off_n),

    .usr_rd_strb (usr_rd_strb),
    .usr_wr_strb (usr_wr_strb),
    .usr_addr    (usr_addr),
    .usr_rd_data (usr_rd_data),
    .usr_rd_dvld (usr_rd_dvld),
    .usr_wr_data (usr_wr_data),
    .usr_wr_be   (usr_wr_be)
  );

endmodule
