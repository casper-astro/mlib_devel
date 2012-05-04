module async_qdr_interface #(
    parameter QDR_LATENCY = 10
  ) (
    input  host_clk,
    input  host_rst,
    input  host_en,
    input  host_rnw,
    input  [31:0] host_addr,
    input  [31:0] host_datai,
    input   [3:0] host_be,
    output [31:0] host_datao,
    output host_ack,
    input  qdr_clk,
    input  qdr_rst,
    output qdr_req,
    input  qdr_ack,
    output [31:0] qdr_addr,
    output qdr_r,
    output qdr_w,
    output [35:0] qdr_d,
    output  [3:0] qdr_be,
    input  [35:0] qdr_q
  );


  /* TODO: A FIFO might be more appropriate but wastes a BlockRAM */

  /********** QDR assignments **********/

  /* On addressing:
     The LSB of the qdr address addresses
     A single burst ie 2 * 36 bits.
     The LSB of the OPB address addresses
     a single byte.
  */

  reg [31:0] host_addr_reg;
  reg [31:0] host_datai_reg;
  reg  [3:0] host_be_reg;
  reg host_rnw_reg;

  reg [31:0] host_datao_reg;
  
  reg second_cycle;
  
  wire second_word = host_addr_reg[2];

  assign qdr_addr = host_addr_reg[31:3];

  assign qdr_r  = qdr_req & host_rnw_reg;
  assign qdr_w  = qdr_req & !host_rnw_reg;
  assign qdr_d  = {1'b0, host_datai_reg[31:24], 1'b0, host_datai_reg[23:16], 1'b0, host_datai_reg[15:8], 1'b0, host_datai_reg[7:0]};
  assign qdr_be = (second_cycle && second_word) || (!second_cycle && !second_word) ?
                     host_be_reg : 4'b0;

  assign host_datao = host_datao_reg;
  reg host_ack_reg;
  assign host_ack = host_ack_reg;

  /* foo */

  reg trans_reg;
  reg trans_regR;
  reg trans_regRR;
  //synthesis attribute HU_SET of trans_regR  is SET1
  //synthesis attribute HU_SET of trans_regRR is SET1
  //synthesis attribute RLOC   of trans_regR  is X0Y0
  //synthesis attribute RLOC   of trans_regRR is X0Y1

  reg resp_reg;
  reg resp_regR;
  reg resp_regRR;
  //synthesis attribute HU_SET of resp_regR  is SET0
  //synthesis attribute HU_SET of resp_regRR is SET0
  //synthesis attribute RLOC   of resp_regR  is X0Y0
  //synthesis attribute RLOC   of resp_regRR is X0Y1


  reg wait_clear;

  always @(posedge host_clk) begin
    host_ack_reg <= 1'b0;

    resp_regR  <= resp_reg;
    resp_regRR <= resp_regR;

    if (host_rst) begin
      trans_reg  <= 1'b0;
      wait_clear <= 1'b0;
      host_ack_reg <= 1'b0;
    end else begin
      if (host_en) begin
        trans_reg  <= 1'b1;
        wait_clear <= 1'b0;
      end
      if (resp_regRR) begin
        trans_reg  <= 1'b0;
        wait_clear <= 1'b1;
      end
      if (wait_clear && !resp_regRR) begin
        wait_clear   <= 1'b0;
        host_ack_reg <= 1'b1;
      end
    end
  end

  reg qdr_trans_strb, qdr_resp_ready;
  reg hshake_state;

  localparam RESP_IDLE = 1'b0;
  localparam RESP_BUSY = 1'b1;

  always @(posedge qdr_clk) begin
    qdr_trans_strb <= 1'b0;

    trans_regR  <= trans_reg;
    trans_regRR <= trans_regR;
    if (qdr_rst) begin
      hshake_state <= RESP_IDLE;
      resp_reg   <= 1'b0;
    end else begin
      case (hshake_state)
        RESP_IDLE: begin
          if (trans_regRR) begin
            qdr_trans_strb <= 1'b1;
            host_addr_reg  <= host_addr;
            host_datai_reg <= host_datai;
            host_be_reg    <= host_be;
            host_rnw_reg   <= host_rnw;
            hshake_state   <= RESP_BUSY;
          end
        end
        RESP_BUSY: begin
          if (qdr_resp_ready)
            resp_reg  <= 1'b1;

          if (!trans_regRR) begin
            resp_reg  <= 1'b0;
            hshake_state   <= RESP_IDLE;
          end
        end
      endcase
    end
  end

  /* Response Collection State Machine */

  reg [QDR_LATENCY - 1:0] qvld_shifter;

  reg [1:0] resp_state;
  localparam IDLE    = 2'd0;
  localparam WAIT    = 2'd1;
  localparam COLLECT = 2'd2;
  localparam FINAL   = 2'd3;

  always @(posedge qdr_clk) begin
    qdr_resp_ready <= 1'b0;
    second_cycle   <= 1'b0;
    qvld_shifter   <= {qvld_shifter[QDR_LATENCY - 2:0], resp_state == WAIT && qdr_ack};

    if (qdr_rst) begin
      resp_state <= IDLE;
    end else begin
      case (resp_state)
        IDLE: begin
          if (qdr_trans_strb) begin
            resp_state <= WAIT;
          end
        end
        WAIT: begin
          if (qdr_ack) begin
            second_cycle <= 1'b1;
            resp_state <= COLLECT;
          end
        end
        COLLECT: begin
          if (!host_rnw_reg) begin
            resp_state <= IDLE;
            qdr_resp_ready <= 1'b1;
          end else if (qvld_shifter[QDR_LATENCY-1]) begin
            if (!second_word) begin
              resp_state <= IDLE;
              host_datao_reg <= qdr_q[31:0];//{qdr_q[34:27], qdr_q[25:18], qdr_q[16:9], qdr_q[7:0]};
              qdr_resp_ready <= 1'b1;
            end else begin
              resp_state <= FINAL;
            end
          end
        end
        FINAL: begin
          qdr_resp_ready <= 1'b1;
          host_datao_reg <= qdr_q[31:0];//{qdr_q[34:27], qdr_q[25:18], qdr_q[16:9], qdr_q[7:0]};
          resp_state <= IDLE;
        end
      endcase
    end
  end

  assign qdr_req = qdr_trans_strb || resp_state == WAIT;

endmodule

