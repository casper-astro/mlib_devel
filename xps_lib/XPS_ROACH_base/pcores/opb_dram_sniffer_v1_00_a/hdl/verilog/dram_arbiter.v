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
  /* This state machine is hand optimized to remove the need for decoding */
  // synthesis attribute fsm_extract arb_state is no; 

  wire rd_history_afull;

  reg arb_ready;
  /* register to ease timing */
  always @(posedge clk) begin
    arb_ready <= master_fifo_ready && !rd_history_afull;
  end

  always @(posedge clk) begin
    if (rst) begin
      arb_state <= STATE_ARB0;
    end else begin
      case (arb_state)
        STATE_ARB0: begin
          if (slave0_cmd_valid || !arb_ready) begin
            arb_state <= STATE_WAIT;
          end else if (slave1_cmd_valid) begin
            arb_state <= STATE_ARB1;
          end
        end
        STATE_ARB1: begin
          arb_state <= STATE_WAIT;
        end
        STATE_WAIT: begin
          if (arb_ready) begin
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
                arb_state <= STATE_ARB1;
              end
            endcase
          end
        end
      endcase
    end
  end

  reg prev_ack;

  always @(posedge clk) begin
    prev_ack <= slave1_ack && slave1_cmd_valid;
  end

  /* Controller signal assignments */

  assign slave0_ack = arb_state[0];
  assign slave1_ack = arb_state[1];


  assign master_cmd_valid = slave0_ack && slave0_cmd_valid || slave1_ack && slave1_cmd_valid;
  assign master_cmd_rnw   = slave1_ack ? slave1_cmd_rnw  : slave0_cmd_rnw;
  assign master_cmd_addr  = slave1_ack ? slave1_cmd_addr : slave0_cmd_addr;
  assign master_wr_data   = slave1_ack || prev_ack ? slave1_wr_data  : slave0_wr_data;
  assign master_wr_be     = slave1_ack || prev_ack ? slave1_wr_be    : slave0_wr_be;

  /*
  always @(*) begin
    $display("sl1 %b %b %b %x %x %x", slave1_cmd_valid, slave1_cmd_rnw, slave1_ack, slave1_cmd_addr, slave1_wr_data, slave1_wr_be);
  end
  */

  
  /* Read response collection/generation */

  /************* read history fifo - 1-bit 1024 (TODO: optimize) entries fwft ********************/

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


  wire rd_sel;
  reg  rd_sel_z;
  always @(posedge clk) begin
    rd_sel_z <= rd_sel;
  end

  /* register write side to improve timing */
  /* extra latency shouldn't be a problem */
  reg read_history_fifo_rd_en;
  reg read_history_fifo_wr_en;
  reg read_history_fifo_din;
  always @(posedge clk) begin
    read_history_fifo_din   <= slave1_ack;
    read_history_fifo_wr_en <= master_cmd_valid && master_cmd_rnw;
    read_history_fifo_rd_en <= master_rd_valid && new_strb;
  end

  read_history_fifo read_history_fifo_inst(
    .clk(clk),
    .srst(rst),
    .din(read_history_fifo_din),
    .rd_en(read_history_fifo_rd_en),
    .wr_en(read_history_fifo_wr_en),
    .dout(rd_sel),
    .empty(),
    .prog_full(rd_history_afull),
    .full()
  );
  reg [144 - 1:0] master_rd_data_z;
  reg             master_rd_valid_z;
  always @(posedge clk) begin
    master_rd_data_z  <= master_rd_data;
    master_rd_valid_z <= master_rd_valid;
  end

  assign slave0_rd_data = master_rd_data_z;
  assign slave1_rd_data = master_rd_data_z;

  assign slave0_rd_valid = master_rd_valid_z && !rd_sel_z;
  assign slave1_rd_valid = master_rd_valid_z && rd_sel_z;

endmodule
