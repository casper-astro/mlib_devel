module sys_block(
    OPB_Clk,
    OPB_Rst,
    Sl_DBus,
    Sl_errAck,
    Sl_retry,
    Sl_toutSup,
    Sl_xferAck,
    OPB_ABus,
    OPB_BE,
    OPB_DBus,
    OPB_RNW,
    OPB_select,
    OPB_seqAddr,

    soft_reset,
    irq_n,
    app_irq,
    fab_clk
  );
  parameter BOARD_ID     = 16'b0;
  parameter REV_MAJOR    = 16'b0;
  parameter REV_MINOR    = 16'b0;
  parameter REV_RCS      = 16'b0;
  parameter RCS_UPTODATE = 16'b0;
  parameter C_BASEADDR   = 32'h00000000;
  parameter C_HIGHADDR   = 32'h0000FFFF;
  parameter C_OPB_AWIDTH = 0;
  parameter C_OPB_DWIDTH = 0;

  input  OPB_Clk, OPB_Rst;
  output [0:31] Sl_DBus;
  output Sl_errAck;
  output Sl_retry;
  output Sl_toutSup;
  output Sl_xferAck;
  input  [0:31] OPB_ABus;
  input  [0:3]  OPB_BE;
  input  [0:31] OPB_DBus;
  input  OPB_RNW;
  input  OPB_select;
  input  OPB_seqAddr;

  output soft_reset;
  output irq_n;
  input  [15:0] app_irq;
  input  fab_clk;

  assign Sl_toutSup = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;

  reg Sl_xferAck;
  reg soft_reset;

  reg [0:31] scratch_pad;

  reg [0:31] fab_clk_counter_latched;
  reg [0:31] fab_clk_counter;
  reg [0:31] fab_clk_counter_reg;

  wire a_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] a_trans = OPB_ABus - C_BASEADDR;

  reg bus_wait;
  reg latch_start;
  wire latch_done;

  always @(posedge OPB_Clk) begin
    //single cycle signals
    Sl_xferAck  <= 1'b0;
    soft_reset  <= 1'b0;
    latch_start <= 1'b0;

    if (OPB_Rst) begin
      scratch_pad <= 32'h12345678;
      bus_wait    <= 1'b0;
    end else if (bus_wait) begin
      if (latch_done) begin
        Sl_xferAck <= 1'b1;
        bus_wait   <= 1'b0;
      end
    end else if (a_match && OPB_select && !Sl_xferAck) begin
      Sl_xferAck <= 1'b1;
      if (!OPB_RNW) begin
        case (a_trans[5:2])
          2: begin
            if (OPB_BE[3])
              soft_reset <= OPB_DBus[31];
          end
          3: begin
            if (OPB_BE[0])
              scratch_pad[0:7]   <= OPB_DBus[ 0:7 ];
            if (OPB_BE[1])
              scratch_pad[8:15]  <= OPB_DBus[ 8:15];
            if (OPB_BE[2])
              scratch_pad[16:23] <= OPB_DBus[16:23];
            if (OPB_BE[3])
              scratch_pad[24:31] <= OPB_DBus[24:31];
          end
        endcase
      end else begin /* Read Case */
        case (a_trans[5:2])
          4: begin
            if (OPB_BE[0]) begin
              bus_wait    <= 1'b1;
              Sl_xferAck  <= 1'b0; //don't ack - lazy override
              latch_start <= 1'b1;
            end
          end
        endcase
      end
    end
  end

  reg [0:31] Sl_DBus;

  always @(*) begin
    if (!Sl_xferAck) begin
      Sl_DBus <= 32'b0;
    end else begin
      case (a_trans[5:2])
        0: begin
          Sl_DBus[ 0:15] <= BOARD_ID;
          Sl_DBus[16:31] <= REV_MAJOR;
        end
        1: begin
          Sl_DBus[ 0:15] <= REV_MINOR;
          Sl_DBus[16:31] <= REV_RCS;
        end
        2: begin
          Sl_DBus[ 0:15] <= {15'b0, RCS_UPTODATE};
          Sl_DBus[16:31] <= {15'b0, soft_reset};
        end
        3: begin
          Sl_DBus <= scratch_pad;
        end
        4: begin
          Sl_DBus <= fab_clk_counter_latched;
        end
        default: begin
          Sl_DBus <= 32'd0;
        end
      endcase
    end
  end

  /* TODO: implement IRQ chain */

  assign irq_n = 1'b1;

  /* handshake signals */
  reg val_got;
  reg val_gotR, val_gotRR;
  wire val_req;
  reg val_reqR, val_reqRR;
  reg got_wait;

  reg [1:0] latch_state;
  localparam LATCH_IDLE  = 2'd0;
  localparam LATCH_REQ   = 2'd1;
  localparam LATCH_WAIT  = 2'd2;

  always @(posedge OPB_Clk) begin
    val_gotR  <= val_got;
    val_gotRR <= val_gotR;

    if (OPB_Rst) begin
      latch_state <= LATCH_IDLE;
    end else begin
      case (latch_state)
        LATCH_IDLE: begin
          if (latch_start) begin
            latch_state <= LATCH_REQ;
          end
        end
        LATCH_REQ: begin
          if (val_gotRR) begin
            latch_state <= LATCH_WAIT;
            fab_clk_counter_latched <= fab_clk_counter_reg;
          end
        end
        LATCH_WAIT: begin
          if (!val_gotRR) begin
            latch_state <= LATCH_IDLE;
          end
        end
      endcase
    end
  end
  assign latch_done = latch_state == LATCH_WAIT && !val_gotRR;

  assign val_req = latch_state == LATCH_REQ;
  always @(posedge fab_clk) begin
    val_reqR  <= val_req;
    val_reqRR <= val_reqR;
    fab_clk_counter <= fab_clk_counter + 1;

    if (OPB_Rst) begin
      val_got <= 1'b0;
    end else begin
      if (val_reqRR && !val_got) begin
        fab_clk_counter_reg <= fab_clk_counter;
        val_got <= 1'b1;
      end 
      if (!val_reqRR) begin
        val_got <= 1'b0;
      end 
    end
  end

endmodule
