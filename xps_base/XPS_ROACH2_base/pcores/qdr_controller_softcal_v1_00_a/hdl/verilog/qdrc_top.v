module qdrc_top (
    /* QDR Infrastructure */
    clk0,
    clk180,
    clk270,
    clk_200_mhz,
    div_clk,
    reset, //release when clock and delay elements are stable 
    /* Physical QDR Signals */
    qdr_d,
    qdr_q,
    qdr_sa,
    qdr_w_n,
    qdr_r_n,
    qdr_dll_off_n,
    qdr_k,
    qdr_k_n,
    /* QDR PHY ready */
    phy_rdy,
    cal_fail,
    /* QDR read interface */
    usr_rd_strb,
    usr_wr_strb,
    usr_addr,

    usr_rd_data,
    usr_rd_dvld,

    usr_wr_data,

    doffn,
    cal_en,
    cal_rdy,
    bit_select,
    dll_en,
    dll_inc_dec_n,
    dll_rst,
    align_en,
    align_strb,
    data_value,
    data_sampled,
    data_valid    
  );
  parameter DATA_WIDTH   = 36;
  parameter ADDR_WIDTH   = 21;

  input clk0, clk180, clk270, div_clk;
  input clk_200_mhz;
  input reset;

  output [DATA_WIDTH - 1:0] qdr_d;
  input  [DATA_WIDTH - 1:0] qdr_q;
  output [ADDR_WIDTH - 1:0] qdr_sa;
  output qdr_w_n;
  output qdr_r_n;
  output qdr_dll_off_n;
  output qdr_k;
  output qdr_k_n;

  output phy_rdy;
  output cal_fail;

  input  usr_rd_strb;
  input  usr_wr_strb;
  input    [ADDR_WIDTH - 1:0] usr_addr;

  output [2*DATA_WIDTH - 1:0] usr_rd_data;
  output usr_rd_dvld;

  input  [2*DATA_WIDTH - 1:0] usr_wr_data;

  input          doffn;
  input          cal_en;
  output         cal_rdy;
  input   [7:0]  bit_select;
  input          dll_en;
  input          dll_inc_dec_n;
  input          dll_rst;
  input          align_en;
  input          align_strb;
  output  [1:0]  data_value;
  output         data_sampled;
  output         data_valid;

  /********** QDR Infrastucture *********/


  /* DDR rise and fall outputs*/
  wire [DATA_WIDTH - 1:0] qdr_d_rise;
  wire [DATA_WIDTH - 1:0] qdr_d_fall;
  wire [DATA_WIDTH - 1:0] qdr_q_rise;
  wire [DATA_WIDTH - 1:0] qdr_q_fall;

  /* SDR control signals, pre-output buffer*/
  wire [ADDR_WIDTH - 1:0] qdr_sa_buf;
  wire qdr_w_n_buf;
  wire qdr_r_n_buf;
  wire qdr_dll_off_n_buf;

  /* Delay for ddr_q input alignment */
  wire [DATA_WIDTH - 1:0] dly_inc_dec_n;
  wire [DATA_WIDTH - 1:0] dly_en;
  wire [DATA_WIDTH - 1:0] dly_rst;

  qdrc_infrastructure #(
    .DATA_WIDTH (DATA_WIDTH),
    .ADDR_WIDTH (ADDR_WIDTH)
  ) qdrc_infrastructure_inst(
    /* general signals */
    .clk0     (clk0),
    .clk180   (clk180),
    .clk270   (clk270),

    /* IO delay ctrl clk */
    .clk_200_mhz(clk_200_mhz),

    .rst0     (reset),
    /* external signals */
    .qdr_d         (qdr_d),
    .qdr_q         (qdr_q),
    .qdr_sa        (qdr_sa),
    .qdr_w_n       (qdr_w_n),
    .qdr_r_n       (qdr_r_n),
    .qdr_dll_off_n (qdr_dll_off_n),
    .qdr_k         (qdr_k),
    .qdr_k_n       (qdr_k_n),
    /* phy->external signals */
    .qdr_d_rise        (qdr_d_rise),
    .qdr_d_fall        (qdr_d_fall),
    .qdr_q_rise        (qdr_q_rise),
    .qdr_q_fall        (qdr_q_fall),
    .qdr_sa_buf        (qdr_sa_buf),
    .qdr_w_n_buf       (qdr_w_n_buf),
    .qdr_r_n_buf       (qdr_r_n_buf),
    .qdr_dll_off_n_buf (qdr_dll_off_n_buf),
    /* phy training signals */
    .dly_clk       (div_clk),
    .dly_inc_dec_n (dly_inc_dec_n),
    .dly_en        (dly_en),
    .dly_rst       (dly_rst)
  );

  /********* QDR PHY interface **********/

  qdrc_phy #(
    .DATA_WIDTH   (DATA_WIDTH),
    .ADDR_WIDTH   (ADDR_WIDTH)
  ) qdrc_phy_inst(
    /* general signals */
    .clk      (clk0),
    .div_clk  (div_clk),
    .reset    (reset),
    .cal_fail (cal_fail),
    .phy_rdy  (phy_rdy),

    /* user/phy interface signals */
    .phy_addr    (usr_addr),
    .phy_wr_strb (usr_wr_strb),
    .phy_wr_data (usr_wr_data),

    .phy_rd_strb (usr_rd_strb),
    .phy_rd_data (usr_rd_data),

    /* FPGA infrastructure signals */
    .qdr_d_rise    (qdr_d_rise),
    .qdr_d_fall    (qdr_d_fall),
    .qdr_q_rise    (qdr_q_rise),
    .qdr_q_fall    (qdr_q_fall),
    .qdr_w_n       (qdr_w_n_buf),
    .qdr_r_n       (qdr_r_n_buf),
    .qdr_sa        (qdr_sa_buf),

    .qdr_dll_off_n (qdr_dll_off_n_buf),

    .dly_inc_dec_n (dly_inc_dec_n),
    .dly_en        (dly_en),
    .dly_rst       (dly_rst),

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

  /* Generate qdr_rd_dvld 10 cycles after strb is sent */ 

  localparam QDR_LATENCY = 15;
  reg [QDR_LATENCY - 1:0] strb_shifter;
  //synthesis attribute shreg_extract of strb_shifter is NO

  always @(posedge clk0) begin
    strb_shifter <= {usr_rd_strb, strb_shifter[QDR_LATENCY-1:1]};
  end
  assign usr_rd_dvld = strb_shifter[0];

endmodule
