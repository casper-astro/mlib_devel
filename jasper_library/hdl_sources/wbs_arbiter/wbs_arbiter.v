module wbs_arbiter(
    /*generic wb signals*/
    wb_clk_i, wb_rst_i,
    /*wbm signals*/
    wbm_cyc_i, wbm_stb_i, wbm_we_i, wbm_sel_i,
    wbm_adr_i, wbm_dat_i, wbm_dat_o,
    wbm_ack_o, wbm_err_o,
    /*wbs signals*/
    wbs_cyc_o, wbs_stb_o, wbs_we_o, wbs_sel_o,
    wbs_adr_o, wbs_dat_o, wbs_dat_i,
    wbs_ack_i, wbs_err_i
  );
  parameter NUM_SLAVES = 14;
  parameter SLAVE_ADDR = 0;
  parameter SLAVE_HIGH = 0;
  parameter TIMEOUT    = 10;

  input  wb_clk_i, wb_rst_i;

  input  wbm_cyc_i;
  input  wbm_stb_i;
  input  wbm_we_i;
  input   [3:0] wbm_sel_i;
  input  [31:0] wbm_adr_i;
  input  [31:0] wbm_dat_i;
  output [31:0] wbm_dat_o;
  output wbm_ack_o;
  output wbm_err_o;

  output [NUM_SLAVES - 1:0] wbs_cyc_o;
  output [NUM_SLAVES - 1:0] wbs_stb_o;
  output wbs_we_o;
  output  [3:0] wbs_sel_o;
  output [31:0] wbs_adr_o;
  output [31:0] wbs_dat_o;
  input  [NUM_SLAVES*32 - 1:0] wbs_dat_i;
  input  [NUM_SLAVES - 1:0] wbs_ack_i;
  input  [NUM_SLAVES - 1:0] wbs_err_i;

  /************************* Function Defines **************************/
  function [NUM_SLAVES-1:0] encode;
    input [NUM_SLAVES-1:0] in;

    integer trans;
    begin
      encode = 0; //default condition
      for (trans=0; trans < NUM_SLAVES; trans=trans+1) begin
        if (in[trans]) begin
          encode = trans;
        end
      end
    end
  endfunction


  /************************** Common Signals ***************************/

  wire [NUM_SLAVES - 1:0] wbs_sel;
  reg  [NUM_SLAVES - 1:0] wbs_active;

  wire timeout_reset;
  wire timeout;

  /************************ Timeout Monitoring **************************/

  timeout #(
    .TIMEOUT(TIMEOUT)
  ) timeout_inst (
    .clk(wb_clk_i), .reset(wb_rst_i | timeout_reset),
    .timeout(timeout)
  );

  /*********************** WB Slave Arbitration **************************/
  assign wbs_sel_o = wbm_sel_i;
 

  /* Generate wbs_sel from wbm_adr_i and SLAVE_ADDR & SLAVE_HIGH ie 001 -> slave 0 sel, 100 -> slave 2 sel*/
  genvar gen_i;
  generate for (gen_i=0; gen_i < NUM_SLAVES; gen_i=gen_i+1) begin : G0
    assign wbs_sel[gen_i] = wbm_adr_i[32 - 1:0] >= SLAVE_ADDR[32*(gen_i+1) - 1:32*(gen_i)] &&
                            wbm_adr_i[32 - 1:0] <= SLAVE_HIGH[32*(gen_i+1) - 1:32*(gen_i)];
  end endgenerate
  wire [NUM_SLAVES-1:0] wbs_sel_enc = encode(wbs_sel); //this is the encoded value ie 10 -> 2, 100 -> 3 etc

  /* Generate wbs_adr_o from wbm_adr_i and wbs_sel */
  wire [31:0] wbs_adr_o_int;
  wire [31:0] wbs_adr_o_diff;

  assign wbs_adr_o_int = wbm_adr_i - wbs_adr_o_diff;

  genvar gen_j;
  generate for (gen_j=0; gen_j < 32; gen_j=gen_j+1) begin : G1
    assign wbs_adr_o_diff[gen_j] = SLAVE_ADDR[32*wbs_sel_enc + gen_j];
  end endgenerate

  reg  [31:0] wbs_adr_o_reg;
  assign wbs_adr_o = wbs_adr_o_reg;

  /* Generate wbm_dat_o from wbs_sel_enc */
  genvar gen_k;
  generate for (gen_k=0; gen_k < 32; gen_k=gen_k+1) begin : G2
    assign wbm_dat_o[gen_k] = wbs_dat_i[32*wbs_sel_enc + gen_k];
  end endgenerate
  assign wbm_ack_o = (wbs_ack_i & wbs_active) != {NUM_SLAVES{1'b0}};

  assign wbs_we_o = wbm_we_i;
  assign wbs_dat_o = wbm_dat_i;

  reg wbm_err_o;

  reg [NUM_SLAVES - 1:0] wbs_cyc_o;
  assign wbs_stb_o = wbs_cyc_o;

  reg state;
  localparam STATE_IDLE   = 2'd0;
  localparam STATE_WAIT   = 2'd1;

  assign timeout_reset = ~(state == STATE_WAIT);
  
  always @(posedge wb_clk_i) begin
    /* strobes */
    wbs_cyc_o <= {NUM_SLAVES{1'b0}};
    wbm_err_o <= 1'b0;

    if (wb_rst_i) begin
      state <= STATE_IDLE;
      wbs_active <= {NUM_SLAVES{1'b0}};
    end else begin
      case (state)
        STATE_IDLE: begin
          if (wbm_cyc_i & wbm_stb_i) begin
            if (wbs_sel == {NUM_SLAVES{1'b0}}) begin
              wbm_err_o <= 1'b1;
            end else begin
              wbs_active <= wbs_sel;
              wbs_adr_o_reg <= wbs_adr_o_int;
              wbs_cyc_o <= wbs_sel;
              state <= STATE_WAIT;
            end
`ifdef DEBUG
            $display("wb_arb: got event, wbs_sel = %x",wbs_sel);
`endif
          end else begin
            //wbs_active <= {NUM_SLAVES{1'b0}};
            /* this delayed clear is intentional as the wbm_ack depends on the value */
          end
        end
        STATE_WAIT: begin
          if (wbs_ack_i & wbs_active) begin
            state <= STATE_IDLE;
`ifdef DEBUG
            $display("wb_arb: got ack");
`endif
          end else if (timeout) begin
            wbm_err_o <= 1'b1;
            state <= STATE_IDLE;
`ifdef DEBUG
            $display("wb_arb: bus timeout");
`endif
          end
        end
      endcase
    end
  end

endmodule
