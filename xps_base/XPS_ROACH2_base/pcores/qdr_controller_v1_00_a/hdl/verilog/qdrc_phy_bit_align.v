module qdrc_phy_bit_align(
    /* Misc signals */
    clk0, clk270,
    div_clk,
    reset,

    /* State control signals */
    bit_align_start,
    bit_align_done,
    bit_align_fail,

    /* Delay Control Signals */
    dly_inc_dec_n,
    dly_en,
    dly_rst,

    /* External QDR signals  */
    qdr_d_rise,
    qdr_d_fall,
    qdr_q_rise,
    qdr_q_fall,
    qdr_bw_n_rise,
    qdr_bw_n_fall,
    qdr_w_n,
    qdr_r_n,
    qdr_sa,

    /* Bit aligned Datal */
    qdr_q_rise_cal,
    qdr_q_fall_cal, 

    /* Debug probes */ 
    bit_align_state_prb,
    bit_train_state_prb,
    bit_train_error_prb
  );
  parameter DATA_WIDTH   = 36;
  parameter BW_WIDTH     = 4;
  parameter ADDR_WIDTH   = 21;
  parameter CLK_FREQ     = 200;
  parameter BURST_LENGTH = 4;
  parameter BYPASS       = 1;
  
  input clk0, clk270, div_clk, reset;

  input  bit_align_start;
  output bit_align_done, bit_align_fail;

  output [DATA_WIDTH - 1:0] dly_inc_dec_n;
  output [DATA_WIDTH - 1:0] dly_en;
  output [DATA_WIDTH - 1:0] dly_rst;

  output [DATA_WIDTH - 1:0] qdr_d_rise;
  output [DATA_WIDTH - 1:0] qdr_d_fall;
  input  [DATA_WIDTH - 1:0] qdr_q_rise;
  input  [DATA_WIDTH - 1:0] qdr_q_fall;
  output   [BW_WIDTH - 1:0] qdr_bw_n_rise;
  output   [BW_WIDTH - 1:0] qdr_bw_n_fall;
  output qdr_w_n;
  output qdr_r_n;
  output [ADDR_WIDTH - 1:0] qdr_sa;

  output [DATA_WIDTH - 1:0] qdr_q_rise_cal;
  output [DATA_WIDTH - 1:0] qdr_q_fall_cal;

  output [3:0]		    bit_align_state_prb;
  output [3:0]		    bit_train_state_prb;
  output [3:0]		    bit_train_error_prb;
   

  localparam STATE_IDLE   = 4'd0;
  localparam STATE_WRITE  = 4'd1;
  localparam STATE_WAIT   = 4'd2;
  localparam STATE_TRAIN  = 4'd3;
  localparam STATE_ALIGN  = 4'd4;
  localparam STATE_FINISH = 4'd5;
  localparam STATE_DONE   = 4'd6;

/**************** GENERATE BYPASS PHY ************************/
generate if (BYPASS == 1) begin :bypass_bit_align
/********************* BYPASS PHY ****************************/

  assign bit_align_done = 1'b1;
  assign bit_align_fail = 1'b0;

  assign dly_inc_dec_n  = {DATA_WIDTH{1'b0}};
  assign dly_en         = {DATA_WIDTH{1'b0}};
  assign dly_rst        = {DATA_WIDTH{1'b0}};

  assign qdr_d_rise     = {DATA_WIDTH{1'b1}};
  assign qdr_d_fall     = {DATA_WIDTH{1'b0}};

  assign qdr_bw_n_rise  = {BW_WIDTH{1'b0}};
  assign qdr_bw_n_fall  = {BW_WIDTH{1'b0}};

  assign qdr_w_n        = 1'b1;
  assign qdr_r_n        = 1'b1;

  assign qdr_sa         = {ADDR_WIDTH{1'b0}};

  assign qdr_q_rise_cal = qdr_q_rise;
  assign qdr_q_fall_cal = qdr_q_fall;

/************** GENERATE ELSE INCLUDE PHY ********************/
end else begin                  :include_bit_align
/******************** INCLUDE PHY ****************************/

  reg train_start;
  wire train_done;
  wire train_fail;
  wire [DATA_WIDTH - 1:0] aligned;

  reg [3:0] train_start_stretch;
  reg [3:0] reset_stretch;

  always @(posedge clk0) begin
    if (reset) begin
      train_start_stretch <= 4'b0;
      reset_stretch       <= 4'b1111;
    end else begin
      if (train_start_stretch) begin
        train_start_stretch <= train_start_stretch << 1;
      end else if (train_start) begin
        train_start_stretch <= 4'b1111;
      end
      reset_stretch <= reset_stretch << 1;
    end
  end

  reg train_start_div_clk;
  reg reset_div_clk;

  always @(posedge div_clk) begin
    train_start_div_clk <= train_start_stretch[3];
    reset_div_clk       <= reset_stretch[3];
  end


  qdrc_phy_bit_train qdrc_phy_bit_train_inst (
    .clk   (div_clk),
    .reset (reset_div_clk),

    .train_start (train_start_div_clk),
    .train_done  (train_done),
    .train_fail  (train_fail),
    .aligned     (aligned),

    .q_rise (qdr_q_rise),
    .q_fall (qdr_q_fall),

    .dly_inc_dec_n (dly_inc_dec_n),
    .dly_en        (dly_en),
    .dly_rst       (dly_rst),

    .bit_train_state_prb (bit_train_state_prb),
    .bit_train_error_prb (bit_train_error_prb)
  );

 
  reg [3:0] state;
  assign bit_align_state_prb = state;

  assign bit_align_done = state == STATE_DONE;
  reg bit_align_fail_reg;
  assign bit_align_fail = bit_align_fail_reg;

  reg [3:0] read_wait;

  reg [2:0] finish_wait;

  always @(posedge clk0) begin
    train_start <= 1'b0;
    if (reset) begin
      state          <= STATE_IDLE;
      bit_align_fail_reg <= 1'b0;
    end else begin
      case (state)
        STATE_IDLE: begin
          if (bit_align_start) begin
             state <= STATE_WRITE;
          end
        end
        STATE_WRITE: begin
          read_wait <= 4'b1111;
          state <= STATE_WAIT;
        end
        STATE_WAIT:  begin
          if (read_wait) begin
            read_wait <= read_wait - 1;
          end else begin
            train_start <= 1'b1;
            state <= STATE_TRAIN;
          end
        end
        STATE_TRAIN: begin
        if (train_done) begin
            if (train_fail) begin
              bit_align_fail_reg <= 1'b1;
            end
            state <= STATE_ALIGN;
          end
        end
        STATE_ALIGN: begin
          state       <= STATE_FINISH;
          finish_wait <= 0;
        end
        STATE_FINISH: begin
          if (finish_wait == 3'b111) begin
            state <= STATE_DONE;
          end else begin
            finish_wait <= finish_wait + 1;
          end
        end
        STATE_DONE:  begin
        end
      endcase
    end
  end

  /* This module removes a possible half cycle delay 
   * that causes the rise data = 0 and fall = 1 */

  qdrc_phy_bit_correct qdrc_phy_bit_correct_inst [DATA_WIDTH - 1:0](
    .clk0   (clk0),
    .clk270 (clk270),
    .reset  (reset),

    .aligned (aligned),

    .qdr_q_rise (qdr_q_rise),
    .qdr_q_fall (qdr_q_fall),

    .qdr_q_rise_cal (qdr_q_rise_cal),
    .qdr_q_fall_cal (qdr_q_fall_cal)
  );

  assign qdr_d_rise     = {DATA_WIDTH{1'b1}};
  assign qdr_d_fall     = {DATA_WIDTH{1'b0}};

  assign qdr_bw_n_rise  = {BW_WIDTH{1'b0}};
  assign qdr_bw_n_fall  = {BW_WIDTH{1'b0}};

  reg qdr_w_n_reg, qdr_r_n_reg;
  always @(posedge clk0) begin
    qdr_w_n_reg <= !(state == STATE_WRITE);
    qdr_r_n_reg <= !(state == STATE_TRAIN || state == STATE_ALIGN || state == STATE_WAIT);
  end
  assign qdr_w_n = qdr_w_n_reg;
  assign qdr_r_n = qdr_r_n_reg;

  assign qdr_sa         = {ADDR_WIDTH{1'b0}};

end endgenerate
/******************  END GENERATE ***************************/

endmodule
