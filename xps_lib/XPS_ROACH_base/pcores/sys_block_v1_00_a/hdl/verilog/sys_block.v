module sys_block(
    OPB_Clk,
    OPB_Rst,
    SL_DBus,
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
    app_irq
  );
  parameter BOARD_ID     = 0;
  parameter REV_MAJOR    = 0;
  parameter REV_MINOR    = 0;
  parameter REV_RCS      = 0;
  parameter RCS_UPTODATE = 0;
  parameter C_BASEADDR   = 32'h00000000;
  parameter C_HIGHADDR   = 32'h0000FFFF;

  input  OPB_Clk, OPB_Rst;
  output [0:31] SL_DBus;
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

  assign Sl_toutSup = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;

  reg Sl_xferAck;
  reg soft_reset;

  reg [0:31] scratch_pad;

  wire a_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] a_trans = OPB_ABus - C_BASEADDR;

  always @(posedge OPB_Clk) begin
    //single cycle signals
    Sl_xferAck <= 1'b0;
    soft_reset <= 1'b0;

    if (OPB_Rst) begin
      scratch_pad <= 32'hB00BEEE5;
    end else if (a_match && OPB_select && !Sl_xferAck) begin
      Sl_xferAck <= 1'b1;
      if (!OPB_RNW) begin
        case (a_trans[4:2])
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
      end
    end
  end

  reg [0:31] SL_DBus;

  always @(*) begin
    if (!Sl_xferAck) begin
      SL_DBus <= 32'b0;
    end else begin
      case (a_trans[4:2])
        0: begin
          SL_DBus[ 0:15] <= BOARD_ID;
          SL_DBus[16:31] <= REV_MAJOR;
        end
        1: begin
          SL_DBus[ 0:15] <= REV_MINOR;
          SL_DBus[16:31] <= REV_RCS;
        end
        2: begin
          SL_DBus[ 0:15] <= {15'b0, RCS_UPTODATE};
          SL_DBus[16:31] <= {15'b0, soft_reset};
        end
        3: begin
          SL_DBus <= scratch_pad;
        end
      endcase
    end
  end

  /* TODO: implement IRQ chain */

  assign irq_n = 1'b1;

endmodule
