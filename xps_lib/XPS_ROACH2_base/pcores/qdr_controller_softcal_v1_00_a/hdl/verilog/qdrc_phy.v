module qdrc_phy #(
    parameter DATA_WIDTH   = 36,
    parameter ADDR_WIDTH   = 21,
    parameter Q_DELAY      = 3
  ) ( 
    input                       clk,
    input                       div_clk,
    input                       reset,
    output                      phy_rdy,
    output                      cal_fail,

    input                       phy_wr_strb,
    input    [ADDR_WIDTH - 1:0] phy_addr,

    input  [DATA_WIDTH*2 - 1:0] phy_wr_data,

    input                       phy_rd_strb,
    output [DATA_WIDTH*2 - 1:0] phy_rd_data,

    output   [DATA_WIDTH - 1:0] qdr_d_rise,
    output   [DATA_WIDTH - 1:0] qdr_d_fall,
    input    [DATA_WIDTH - 1:0] qdr_q_rise,
    input    [DATA_WIDTH - 1:0] qdr_q_fall,

    output   [ADDR_WIDTH - 1:0] qdr_sa,
    output                      qdr_w_n,
    output                      qdr_r_n,

    output                      qdr_dll_off_n,

    output   [DATA_WIDTH - 1:0] dly_inc_dec_n,
    output   [DATA_WIDTH - 1:0] dly_en,
    output   [DATA_WIDTH - 1:0] dly_rst,

    input                       doffn,
    input                       cal_en,
    output                      cal_rdy,
    input                 [7:0] bit_select,
    input                       dll_en,
    input                       dll_inc_dec_n,
    input                       dll_rst,
    input                       align_strb,
    input                       align_en,
    output                [1:0] data_value,
    output                      data_sampled,
    output                      data_valid
  );

  reg cal_en_R;
  reg cal_en_RR;

  always @(posedge clk) begin
    cal_en_R  <= cal_en;
    cal_en_RR <= cal_en_R;
  end

  assign cal_fail = 1'b0;
  assign phy_rdy  = !cal_en_RR;

  wire cal_busy = cal_en_RR;
  wire cal_w_n;
  wire cal_r_n;
  wire [DATA_WIDTH - 1:0] cal_qdr_q_fall;
  wire [DATA_WIDTH - 1:0] cal_qdr_q_rise;

  assign qdr_d_rise = cal_busy ? {DATA_WIDTH{1'b1}} : phy_wr_data[DATA_WIDTH - 1:0];
  assign qdr_d_fall = cal_busy ? {DATA_WIDTH{1'b0}} : phy_wr_data[2*DATA_WIDTH - 1:DATA_WIDTH];

  assign qdr_sa = cal_busy ? {ADDR_WIDTH{1'b0}} : phy_addr;

  assign qdr_w_n = cal_busy ? cal_w_n : !phy_wr_strb;
  assign qdr_r_n = cal_busy ? cal_r_n : !phy_rd_strb;

  reg [DATA_WIDTH-1:0] qdr_q_rise_z;
  reg [DATA_WIDTH-1:0] qdr_q_fall_z;

  reg [DATA_WIDTH-1:0] qdr_q_rise_zz;
  reg [DATA_WIDTH-1:0] qdr_q_fall_zz;

  reg [DATA_WIDTH-1:0] qdr_q_rise_zzz;
  reg [DATA_WIDTH-1:0] qdr_q_fall_zzz;

  reg [DATA_WIDTH-1:0] qdr_q_rise_zzzz;
  reg [DATA_WIDTH-1:0] qdr_q_fall_zzzz;

  /* this seems to be higher than it might be otherwise due to dodgy IO placements on r2 */
  //synthesis attribute shreg_extract of qdr_q_rise_z is no
  //synthesis attribute shreg_extract of qdr_q_fall_z is no
  //synthesis attribute shreg_extract of qdr_q_rise_zz is no
  //synthesis attribute shreg_extract of qdr_q_fall_zz is no
  //synthesis attribute shreg_extract of qdr_q_rise_zzz is no
  //synthesis attribute shreg_extract of qdr_q_fall_zzz is no
  
  always @(posedge clk) begin
    qdr_q_rise_z   <= qdr_q_rise;
    qdr_q_fall_z   <= qdr_q_fall;
    qdr_q_rise_zz  <= qdr_q_rise_z;
    qdr_q_fall_zz  <= qdr_q_fall_z;
    qdr_q_rise_zzz <= qdr_q_rise_zz;
    qdr_q_fall_zzz <= qdr_q_fall_zz;
    qdr_q_rise_zzzz <= qdr_q_rise_zzz;
    qdr_q_fall_zzzz <= qdr_q_fall_zzz;
  end
  wire [DATA_WIDTH-1:0] qdr_q_rise_delayed = qdr_q_rise_zzzz;
  wire [DATA_WIDTH-1:0] qdr_q_fall_delayed = qdr_q_fall_zzzz;

  assign phy_rd_data = {cal_qdr_q_fall, cal_qdr_q_rise};

  /* cal sm */
  reg [1:0] state;
  localparam STATE_IDLE  = 2'd0;
  localparam STATE_WRITE = 2'd1;
  localparam STATE_READ  = 2'd2;

  always @(posedge clk) begin
    if (reset) begin
      state <= STATE_IDLE;
    end else begin
      case (state)
        STATE_IDLE: begin
          if (cal_busy) 
            state <= STATE_WRITE;
        end
        STATE_WRITE: begin
          state <= STATE_READ;
        end
        STATE_READ: begin
        end
      endcase
    end

    if (!cal_busy) 
      state <= STATE_IDLE;
  end

  assign cal_w_n = state == STATE_WRITE ? 1'b0 : 1'b1;
  assign cal_r_n = state == STATE_READ  ? 1'b0 : 1'b1;

  reg cal_rdyR;
  reg cal_rdyRR;
  always @(posedge div_clk) begin
    cal_rdyR  <= state == STATE_READ;
    cal_rdyRR <= cal_rdyR;
  end
  assign cal_rdy = cal_rdyRR;

  /* bit align */

  qdrc_phy_train #(
    .DATA_WIDTH (DATA_WIDTH)
  ) qdrc_phy_train_inst (
    .clk           (div_clk),
    .q_rise        (qdr_q_rise_delayed),
    .q_fall        (qdr_q_fall_delayed),
    .dly_inc_dec_n (dly_inc_dec_n),
    .dly_en        (dly_en),
    .dly_rst       (dly_rst),
    .bit_select    (bit_select),
    .dll_en        (dll_en),
    .dll_inc_dec_n (dll_inc_dec_n),
    .dll_rst       (dll_rst),
    .data_value    (data_value),
    .data_sampled  (data_sampled),
    .data_valid    (data_valid)    
  );

  qdrc_phy_align #(
    .DATA_WIDTH (DATA_WIDTH)
  ) qdrc_phy_align_inst (
    .clk           (clk),
    .divclk        (div_clk),
    .bit_select    (bit_select),
    .align_strb    (align_strb),
    .align_en      (align_en),
    .q_rise        (qdr_q_rise_delayed),
    .q_fall        (qdr_q_fall_delayed),
    .cal_rise      (cal_qdr_q_rise),
    .cal_fall      (cal_qdr_q_fall)
  );
  assign qdr_dll_off_n = doffn;
endmodule
