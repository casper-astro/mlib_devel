module opb_attach(
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

    rxeqmix,
    rxeqpole,
    txpreemphasis,
    txdiffctrl,
    xaui_status
  );
  parameter C_BASEADDR = 0;
  parameter C_HIGHADDR = 0;

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

  output [1:0] rxeqmix;
  output [3:0] rxeqpole;
  output [2:0] txpreemphasis;
  output [2:0] txdiffctrl;
  input  [7:0] xaui_status;

  assign Sl_toutSup = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;

  wire a_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] a_trans = OPB_ABus - C_BASEADDR;

  localparam REG_RXEQMIX    = 0;
  localparam REG_RXEQPOLE   = 1;
  localparam REG_TXPREEMPH  = 2;
  localparam REG_TXDIFFCTRL = 3;
  localparam REG_STATUS     = 4;

  reg Sl_xferAck;

  reg [1:0] rxeqmix;
  reg [3:0] rxeqpole;
  reg [2:0] txpreemphasis;
  reg [2:0] txdiffctrl;

  always @(posedge OPB_Clk) begin
    Sl_xferAck <= 1'b0;

    if (OPB_Rst) begin
      rxeqmix        <= 2'b00;
      rxeqpole       <= 4'b0000;
      txpreemphasis  <= 3'b000;
      txdiffctrl     <= 3'b100;
    end else begin
      if (a_match && OPB_select && !Sl_xferAck) begin
        Sl_xferAck <= 1'b1;
        if (!OPB_RNW) begin
          case (a_trans[4:2])
            REG_RXEQMIX: begin
              if (OPB_BE[3])
                rxeqmix <= OPB_DBus[30:31];
            end
            REG_RXEQPOLE: begin
              if (OPB_BE[3])
                rxeqpole <= OPB_DBus[28:31];
            end
            REG_TXPREEMPH: begin
              if (OPB_BE[3])
                txpreemphasis <= OPB_DBus[29:31];
            end
            REG_TXDIFFCTRL: begin
              if (OPB_BE[3])
                txdiffctrl <= OPB_DBus[29:31];
            end
          endcase
        end
      end
    end
  end

  wire [31:0] Sl_DBus_int = a_trans[4:2] == REG_RXEQMIX    ? {30'b0, rxeqmix} :
                            a_trans[4:2] == REG_RXEQPOLE   ? {28'b0, rxeqpole} :
                            a_trans[4:2] == REG_TXPREEMPH  ? {29'b0, txpreemphasis} :
                            a_trans[4:2] == REG_TXDIFFCTRL ? {29'b0, txdiffctrl}:
                            a_trans[4:2] == REG_STATUS     ? {24'b0, xaui_status}:
                                            32'b0;

  assign Sl_DBus = Sl_xferAck ? Sl_DBus_int : 32'b0;

endmodule
