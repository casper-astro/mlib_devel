module dram_arbiter(
    input  clk,
    input  rst,
    output  [31:0] master_cmd_addr,
    output master_cmd_rnw,
    output master_cmd_valid,
    output [143:0] master_wr_data,
    output  [17:0] master_wr_be,
    input  [143:0] master_rd_data,
    input  master_rd_valid,
    input  master_fifo_ready,

    input   [31:0] slave0_cmd_addr,
    input  slave0_cmd_rnw,
    input  slave0_cmd_valid,
    input  [143:0] slave0_wr_data,
    input   [17:0] slave0_wr_be,
    output [143:0] slave0_rd_data,
    output slave0_rd_valid,
    output slave0_ack,

    input   [31:0] slave1_cmd_addr,
    input  slave1_cmd_rnw,
    input  slave1_cmd_valid,
    input  [143:0] slave1_wr_data,
    input   [17:0] slave1_wr_be,
    output [143:0] slave1_rd_data,
    output slave1_rd_valid,
    output slave1_ack
  );

  /* Arbitration state machine */

  reg [2:0] arb_state;
  localparam STATE_ARB0 = 3'b001;
  localparam STATE_ARB1 = 3'b010;
  localparam STATE_WAIT = 3'b100;

  reg [1:0] prev_arb;

  always @(posedge clk) begin
    if (rst) begin
      arb_state <= STATE_ARB0;
    end else begin
      case (arb_state)
        STATE_ARB0: begin
          if (!master_fifo_ready || slave0_cmd_valid) begin
            arb_state <= STATE_WAIT;
            prev_arb  <= {1'b0, slave0_cmd_valid};
          end else if (slave1_cmd_valid) begin
            arb_state <= STATE_ARB1;
          end
        end
        STATE_ARB1: begin
          if (!master_fifo_ready || slave1_cmd_valid) begin
            arb_state <= STATE_WAIT;
            prev_arb  <= {slave1_cmd_valid, 1'b0};
          end else if (slave0_cmd_valid) begin
            arb_state <= STATE_ARB0;
          end
        end
        STATE_WAIT: begin
          if (master_fifo_ready) begin
            prev_arb  <= 2'b00;
            case ({slave1_cmd_valid, slave0_cmd_valid})
              2'b00: begin
                arb_state <= STATE_ARB0;
              end
              2'b01: begin
                arb_state <= STATE_ARB0;
              end
              2'b10: begin
                arb_state <= STATE_ARB1;
              end
              2'b11: begin
                if (prev_arb[0]) begin
                  arb_state <= STATE_ARB1;
                end else begin
                  arb_state <= STATE_ARB0;
                end
              end
            endcase
          end
        end
      endcase
    end
  end

  /* Controller signal assignments */

  assign slave0_ack = arb_state == STATE_ARB0;
  assign slave1_ack = arb_state == STATE_ARB1;


  assign master_cmd_valid = slave0_ack && slave0_cmd_valid || slave1_ack && slave1_cmd_valid;
  assign master_cmd_rnw   = slave0_ack ? slave0_cmd_rnw  : slave1_cmd_rnw;
  assign master_cmd_addr  = slave0_ack ? slave0_cmd_addr : slave1_cmd_addr;
  assign master_wr_data   = slave0_ack || prev_arb[0] ? slave0_wr_data  : slave1_wr_data;
  assign master_wr_be     = slave0_ack || prev_arb[0] ? slave0_wr_be    : slave1_wr_be;

  /*
  always @(*) begin
    $display("sl1 %b %b %b %x %x %x", slave1_cmd_valid, slave1_cmd_rnw, slave1_ack, slave1_cmd_addr, slave1_wr_data, slave1_wr_be);
  end
  */

  
  /* Read response collection/generation */

  /* read history fifo - 1-bit 128 entries fwft */
  /* TODO: check this size, too small == errors (there is no overflow checking) */

  reg new_strb;

  always @(posedge clk) begin
    new_strb <= 1'b1;
    if (rst) begin
    end else begin
      if (master_rd_valid && new_strb) begin
        new_strb <= 1'b0;
      end
    end
  end


  read_history_fifo read_history_fifo_inst(
    .clk     (clk),
    .rst     (rst),
    .wr_data (slave0_ack),
    .wr_en   (master_cmd_valid && master_cmd_rnw),
    .rd_data (rd_sel),
    .rd_en   (master_rd_valid && !new_strb)
    /* 
      rd_valid active for 2 cycles,
      only pop fifo on first part
    */
  );

  assign slave0_rd_data = master_rd_data;
  assign slave1_rd_data = master_rd_data;

  assign slave0_rd_valid = master_rd_valid && rd_sel;
  assign slave1_rd_valid = master_rd_valid && !rd_sel;

endmodule
