module pcs_tx(
  clk, reset,
  xgmii_txdata,
  xgmii_txcharisk,
  mgt_txdata,
  mgt_txcharisk
  );
  input  clk, reset;
  input  [63:0] xgmii_txdata;
  input   [7:0] xgmii_txcharisk;
  output [63:0] mgt_txdata;
  output  [7:0] mgt_txcharisk;

  wire code_sel_0;
  wire code_sel_1;
  wire [4:0] a_cnt_0;
  wire [4:0] a_cnt_1;

  reg offset;

  reg  [2:0] state;

  wire [2:0] state_int_0;
  wire [2:0] state_int_1;

  wire a_send_0;
  wire a_send_1;

  reg  q_det;
  wire q_det_int_0;
  wire q_det_int_1;

  reg  next_ifg;
  wire next_ifg_int_0;
  wire next_ifg_int_1;

  wire [31:0] txdata_o_0;
  wire [31:0] txdata_o_1;

  wire  [3:0] txcharisk_o_0;
  wire  [3:0] txcharisk_o_1;

  assign mgt_txdata = {txdata_o_1[31:24], txdata_o_0[31:24], txdata_o_1[23:16], txdata_o_0[23:16],
                       txdata_o_1[15:8 ], txdata_o_0[15:8 ], txdata_o_1[ 7:0 ], txdata_o_0[ 7:0 ]};

  assign mgt_txcharisk = {txcharisk_o_1[3], txcharisk_o_0[3],txcharisk_o_1[2], txcharisk_o_0[2],
                          txcharisk_o_1[1], txcharisk_o_0[1],txcharisk_o_1[0], txcharisk_o_0[0]};

  tx_state tx_state_0(
    .reset(reset), .a_cnt(a_cnt_0), .code_sel(code_sel_0),

    .current_state(state), .next_state(state_int_0),

    .current_ifg(next_ifg), .current_q_det(q_det),

    .next_ifg(next_ifg_int_0), .next_q_det(q_det_int_0), .a_send(a_send_0),

    .txdata_i(xgmii_txdata[31:0]), .txcharisk_i(xgmii_txcharisk[3:0]), 

    .txdata_o(txdata_o_0), .txcharisk_o(txcharisk_o_0),

    .link_status_event(1'b0), .link_status(32'b0) //TODO: implement link status events
  );

  tx_state tx_state_1(
    .reset(reset), .a_cnt(a_cnt_1), .code_sel(code_sel_1),

    .current_state(state_int_0), .next_state(state_int_1),

    .current_ifg(next_ifg_int_0), .current_q_det(q_det_int_0),

    .next_ifg(next_ifg_int_1), .next_q_det(q_det_int_1), .a_send(a_send_1),

    .txdata_i(xgmii_txdata[63:32]), .txcharisk_i(xgmii_txcharisk[7:4]), 

    .txdata_o(txdata_o_1), .txcharisk_o(txcharisk_o_1),

    .link_status_event(1'b0), .link_status(32'b0)
  );

  always @(posedge clk) begin
    state    <= state_int_1;
    if (reset) begin
      q_det <= 1'b0;
    end
    next_ifg <= next_ifg_int_1;
    q_det    <= q_det_int_1;
  end

  /* Pseudo-Random number generator */
  reg  [6:0] prng_reg;
  wire [6:0] prng_reg_int;

  wire next_bit_int = prng_reg[6] ^ prng_reg[5];
  assign prng_reg_int = { prng_reg[5:1], next_bit_int}; 

  wire next_bit = prng_reg_int[6] ^ prng_reg_int[5];

  always @(posedge clk) begin
    if (reset) begin
      prng_reg <= 7'b1101010;
    end else begin
      prng_reg <= { prng_reg[4:0], next_bit_int, next_bit};
    end
  end

  /* a_cnt */

  assign code_sel_0 = prng_reg[0]; 
  assign code_sel_1 = prng_reg_int[1];

  reg [4:0] a_cnt_reg;

 
  /* load a_cnt_int with PSR or dec by 1 */
  wire [4:0] a_cnt_int = a_send_0  ? {1'b1, prng_reg_int[3:0]} :
                         a_cnt_reg ? a_cnt_reg - 1 : 5'b0 ;

  assign a_cnt_0 = a_cnt_reg;
  assign a_cnt_1 = a_cnt_int;

  always @(posedge clk) begin
    if (reset) begin
      a_cnt_reg <= {1'b1, prng_reg_int[3:0]};
    end else begin
      a_cnt_reg <=  a_send_1 ? {1'b1, prng_reg_int[3:0]} :
                    a_cnt_int ? a_cnt_int - 1 : 5'b0; 
    end
  end

endmodule
