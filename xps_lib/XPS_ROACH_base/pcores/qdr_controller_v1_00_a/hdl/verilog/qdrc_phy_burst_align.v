module qdrc_phy_burst_align(
    /* Misc signals */
    clk,
    reset,

    /* State control signals */
    burst_align_start,
    burst_align_done,
    burst_align_fail,

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
    qdr_q_fall_cal 
  );
  parameter DATA_WIDTH   = 18;
  parameter BW_WIDTH     = 2;
  parameter ADDR_WIDTH   = 21;
  parameter CLK_FREQ     = 200;
  parameter BURST_LENGTH = 4;
  parameter BYPASS       = 1;

  input clk, reset;

  input  burst_align_start;
  output burst_align_done, burst_align_fail;

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

  localparam DEFAULT_LATENCY = 9;
  //up to this point the latency is 9
  //there is one additional cycle here

  function [DATA_WIDTH-1:0] bitwise_multiplex;
  input [DATA_WIDTH-1:0] in0;
  input [DATA_WIDTH-1:0] in1;
  input [DATA_WIDTH-1:0] sel;
  integer i;
    begin
      bitwise_multiplex[i] = {DATA_WIDTH{1'b0}};
      for (i=0; i < DATA_WIDTH; i = i+1) begin
        bitwise_multiplex[i] = sel[i] ? in1[i] : in0[i];
      end
    end
  endfunction
  
/**************** GENERATE BYPASS PHY ************************/
generate if (BYPASS == 1) begin :bypass_burst_align
/********************* BYPASS PHY ****************************/

  assign burst_align_done = 1'b1;
  assign burst_align_fail = 1'b0;

  assign qdr_d_rise       = {DATA_WIDTH{1'b1}};
  assign qdr_d_fall       = {DATA_WIDTH{1'b0}};

  assign qdr_bw_n_rise    = {BW_WIDTH{1'b1}};
  assign qdr_bw_n_fall    = {BW_WIDTH{1'b1}};

  assign qdr_w_n          = 1'b1;
  assign qdr_r_n          = 1'b1;

  assign qdr_sa           = {ADDR_WIDTH{1'b0}};

  assign qdr_q_rise_cal   = qdr_q_rise;
  assign qdr_q_fall_cal   = qdr_q_fall;

/************** GENERATE ELSE INCLUDE PHY ********************/
end else begin                  :include_burst_align
/******************** INCLUDE PHY ****************************/

  reg [1 + DEFAULT_LATENCY + 1:0] qdr_burst_state;

  reg [DATA_WIDTH - 1:0] offset; /* do we use the direct or delayed */

  always @(posedge clk) begin
    if (reset) begin
      qdr_burst_state <= {DATA_WIDTH{1'b0}};
    end else if (burst_align_start) begin
      qdr_burst_state[0] <= 1'b1;
    end else begin
      qdr_burst_state <= {qdr_burst_state[1 + DEFAULT_LATENCY:0], 1'b0};
    end
  end

  assign burst_align_fail = 1'b0;

  assign qdr_w_n          = !qdr_burst_state[0];
  assign qdr_d_rise       = {DATA_WIDTH{1'b0}};
  assign qdr_d_fall       = qdr_burst_state[1] ? {DATA_WIDTH{1'b1}} : {DATA_WIDTH{1'b0}};
  assign qdr_bw_n_rise    = {BW_WIDTH{1'b0}};
  assign qdr_bw_n_fall    = {BW_WIDTH{1'b0}};

  assign qdr_r_n          = !qdr_burst_state[1];

  assign qdr_sa           = {ADDR_WIDTH{1'b0}};

  reg [DATA_WIDTH - 1:0] qdr_q_rise_z;
  reg [DATA_WIDTH - 1:0] qdr_q_fall_z;

  always @(posedge clk) begin
    qdr_q_rise_z <= qdr_q_rise;
    qdr_q_fall_z <= qdr_q_fall;
  end

  assign qdr_q_rise_cal = bitwise_multiplex(qdr_q_rise_z, qdr_q_rise, offset);
  assign qdr_q_fall_cal = bitwise_multiplex(qdr_q_fall_z, qdr_q_fall, offset);
  /* if the data is delayed an extra cycle use the direct version otherwise
   * use the manually delayed version */

  always @(posedge clk) begin
    if (reset) begin
      offset <= {DATA_WIDTH{1'b1}};
    end else begin
      if (qdr_burst_state[1 + DEFAULT_LATENCY + 1]) begin
        offset <= ~qdr_q_fall; 
      end
    end
  end
    /* if the read-back fall data is low on the second word of the burst then
     * the data is offset (as we expect 1 back). 
     */

  reg burst_align_done_reg;
  always @(posedge clk) begin
    if (reset) begin
      burst_align_done_reg <= 1'b0;
    end else if (!burst_align_done_reg) begin
      burst_align_done_reg <= qdr_burst_state[1 + DEFAULT_LATENCY + 1];
    end
  end
  assign burst_align_done = burst_align_done_reg;

end endgenerate
/******************  END GENERATE ***************************/
endmodule
