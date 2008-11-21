module async_qdr_interface #(
    parameter QDR_LATENCY = 9
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

  /* strobes for transaction and responses */

  reg qdr_trans_strb;
  reg qdr_resp_strb;

  /* Transaction Handshake */

  reg trans_got;
  reg trans_got_reg;
  reg trans_ack;
  reg trans_ack_reg;

  always @(posedge host_clk) begin
    trans_ack_reg <= trans_ack;
    if (host_rst) begin
      trans_got <= 1'b0;
    end else begin
      if (host_en) begin
          trans_got <= 1'b1;
`ifdef DEBUG
          $display("async_qdr: got host_en");
`endif
      end

      if (trans_ack_reg) begin
        trans_got <= 1'b0;
      end
    end
  end

  always @(posedge qdr_clk) begin
    qdr_trans_strb <= 1'b0;

    trans_got_reg  <= trans_got;
    if (qdr_rst) begin
      trans_ack <= 1'b0;
    end else begin
      if (trans_got_reg && !trans_ack) begin
        trans_ack <= 1'b1; 
        qdr_trans_strb <= 1'b1;
        /* Latch stable data */
        host_addr_reg  <= host_addr;
        host_datai_reg <= host_datai;
        host_be_reg    <= host_be;
        host_rnw_reg   <= host_rnw;
`ifdef DEBUG
        $display("async_qdr: trans_got, set trans_ack");
`endif
      end
      if (!trans_got_reg) begin
        trans_ack <= 1'b0; 
`ifdef DEBUG
        $display("async_qdr: !trans_got, clear trans_ack, reg data");
`endif
      end
    end
  end

  /* Response Handshake */

  reg qdr_resp_ready;

  reg resp_got;
  reg resp_got_reg;
  reg resp_ack;
  reg resp_ack_reg;

  always @(posedge qdr_clk) begin
    resp_ack_reg <= resp_ack;
    if (qdr_rst) begin
      resp_got <= 1'b0;
    end else begin
      if (qdr_resp_ready) begin
        resp_got <= 1'b1;
      end
      if (resp_ack_reg) begin
        resp_got <= 1'b0;
      end
    end
  end

  always @(posedge host_clk) begin
    host_ack_reg <= 1'b0;
    qdr_resp_strb <= 1'b0;

    resp_got_reg  <= resp_got;
    if (host_rst) begin
      resp_ack <= 1'b0;
    end else begin
      if (resp_got_reg) begin
        resp_ack <= 1'b1; 
        host_ack_reg <= 1'b1;
      end
      if (!resp_got_reg) begin
        resp_ack <= 1'b0; 
      end
    end
  end

  /* Response Collection State Machine */

  reg [QDR_LATENCY - 1:0] qvld_shifter;

  reg [1:0] resp_state;
  localparam IDLE    = 0;
  localparam WAIT    = 1;
  localparam COLLECT = 2;
  localparam FINAL   = 3;

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
              host_datao_reg <= {qdr_q[34:27], qdr_q[25:18], qdr_q[16:9], qdr_q[7:0]};
              qdr_resp_ready <= 1'b1;
            end else begin
              resp_state <= FINAL;
            end
          end
        end
        FINAL: begin
          qdr_resp_ready <= 1'b1;
          host_datao_reg <= {qdr_q[34:27], qdr_q[25:18], qdr_q[16:9], qdr_q[7:0]};
          resp_state <= IDLE;
        end
      endcase
    end
  end

  assign qdr_req = qdr_trans_strb || resp_state == WAIT;

endmodule

