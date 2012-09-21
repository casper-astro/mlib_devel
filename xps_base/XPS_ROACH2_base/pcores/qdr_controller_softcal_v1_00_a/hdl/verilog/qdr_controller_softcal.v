module qdr_controller_softcal (
    OPB_Clk,
    OPB_Rst,
    Sl_DBus,
    Sl_errAck,
    Sl_retry,
    Sl_toutSup,
    Sl_xferAck,
    OPB_ABus,
    OPB_BE,
    OPB_DBus,
    OPB_RNW,
    OPB_select,
    OPB_seqAddr,

    /* QDR Infrastructure */
    clk0,
    clk180,
    clk270,
    reset, //release when clock and delay elements are stable 
    clk_200_mhz, //200mhz ref clock for io delay ctrl
    /* Physical QDR Signals */
    qdr_d,
    qdr_q,
    qdr_sa,
    qdr_w_n,
    qdr_r_n,
    qdr_doff_n,
    qdr_k,
    qdr_k_n,
    /* QDR PHY ready */
    phy_rdy, cal_fail,
    /* QDR read interface */
    usr_rd_strb,
    usr_wr_strb,
    usr_addr,

    usr_rd_data,
    usr_rd_dvld,

    usr_wr_data
  );
  parameter DATA_WIDTH   = 36;
  parameter ADDR_WIDTH   = 22;
  /* OPB parameters */
  parameter C_BASEADDR     = 0;
  parameter C_HIGHADDR     = 0;
  parameter C_OPB_AWIDTH   = 0;
  parameter C_OPB_DWIDTH   = 0;
  /* OPB ports */
  input  OPB_Clk;
  input  OPB_Rst;
  output [0:31] Sl_DBus;
  output Sl_errAck;
  output Sl_retry;
  output Sl_toutSup;
  output Sl_xferAck;
  input  [0:31] OPB_ABus;
  input  [0:3]  OPB_BE;
  input  [0:31] OPB_DBus;
  input  OPB_RNW;
  input  OPB_select;
  input  OPB_seqAddr;

  input clk0, clk180, clk270;
  input clk_200_mhz;
  input reset;

  output [DATA_WIDTH - 1:0] qdr_d;
  input  [DATA_WIDTH - 1:0] qdr_q;
  output [ADDR_WIDTH - 1:0] qdr_sa;
  output qdr_w_n;
  output qdr_r_n;
  output qdr_doff_n;
  output qdr_k;
  output qdr_k_n;

  output phy_rdy;
  output cal_fail;

  input  usr_rd_strb;
  input  usr_wr_strb;
  input  [31:0] usr_addr;

  output [2*DATA_WIDTH - 1:0] usr_rd_data;
  output usr_rd_dvld;

  input  [2*DATA_WIDTH - 1:0] usr_wr_data;


  wire         doffn;
  /* Enable the software calibration */
  wire         cal_en;
  /* Calibration setup is complete */
  wire         cal_rdy;
  /* Select the bit that we are calibrating */
  wire  [7:0]  bit_select;
  /* strobe to tick IODELAY delay tap */
  wire         dll_en;
  /* Direction of IO delay */
  wire         dll_inc_dec_n;
  /* IODELAY value reset */
  wire         dll_rst;
  /* Set to enable additional delay to compensate for half cycle delay */
  wire         align_en;
  wire         align_strb;
  /* Sampled value */
  wire  [1:0]  data_value;
  /* has the value been sampled 32 times */
  wire         data_sampled;
  /* has the value stayed valid after being sampled 32 times */
  wire         data_valid;

  qdrc_cpu_attach #(
    .C_BASEADDR   (C_BASEADDR  ),
    .C_HIGHADDR   (C_HIGHADDR  ),
    .C_OPB_AWIDTH (C_OPB_AWIDTH),
    .C_OPB_DWIDTH (C_OPB_DWIDTH)
  ) cpu_attach_inst (
    .OPB_Clk      (OPB_Clk),
    .OPB_Rst      (OPB_Rst),
    .Sl_DBus      (Sl_DBus    ),
    .Sl_errAck    (Sl_errAck  ),
    .Sl_retry     (Sl_retry   ),
    .Sl_toutSup   (Sl_toutSup ),
    .Sl_xferAck   (Sl_xferAck ),
    .OPB_ABus     (OPB_ABus   ),
    .OPB_BE       (OPB_BE     ),
    .OPB_DBus     (OPB_DBus   ),
    .OPB_RNW      (OPB_RNW    ),
    .OPB_select   (OPB_select ),
    .OPB_seqAddr  (OPB_seqAddr),

    .doffn         (doffn),
    .cal_en        (cal_en),
    .cal_rdy       (cal_rdy),
    .bit_select    (bit_select),
    .dll_en        (dll_en),
    .dll_inc_dec_n (dll_inc_dec_n),
    .dll_rst       (dll_rst),
    .align_en      (align_en),
    .align_strb    (align_strb),
    .data_in       (data_value),
    .data_sampled  (data_sampled),
    .data_valid    (data_valid)
  );

  qdrc_top #(
    .DATA_WIDTH   (DATA_WIDTH  ),
    .ADDR_WIDTH   (ADDR_WIDTH  )
  ) qdrc_top_inst (
    .clk0    (clk0),
    .clk180  (clk180),
    .clk270  (clk270),
    .div_clk (OPB_Clk),
    .clk_200_mhz(clk_200_mhz),
    .reset   (reset),

    .phy_rdy  (phy_rdy),
    .cal_fail (cal_fail),

    .qdr_d         (qdr_d),
    .qdr_q         (qdr_q),
    .qdr_sa        (qdr_sa),
    .qdr_w_n       (qdr_w_n),
    .qdr_r_n       (qdr_r_n),
    .qdr_k         (qdr_k),
    .qdr_k_n       (qdr_k_n),
    .qdr_dll_off_n (qdr_doff_n),

    .usr_rd_strb (usr_rd_strb),
    .usr_wr_strb (usr_wr_strb),
    .usr_addr    (usr_addr[ADDR_WIDTH-1:0]),
    .usr_rd_data (usr_rd_data),
    .usr_rd_dvld (usr_rd_dvld),
    .usr_wr_data (usr_wr_data),

    .doffn         (doffn),
    .cal_en        (cal_en),
    .cal_rdy       (cal_rdy),
    .bit_select    (bit_select),
    .dll_en        (dll_en),
    .dll_inc_dec_n (dll_inc_dec_n),
    .dll_rst       (dll_rst),
    .align_en      (align_en),
    .align_strb    (align_strb),
    .data_value    (data_value),
    .data_sampled  (data_sampled),
    .data_valid    (data_valid)
  );

endmodule
