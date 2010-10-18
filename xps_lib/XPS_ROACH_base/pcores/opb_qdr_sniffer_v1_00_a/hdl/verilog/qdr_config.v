module qdr_config #(
    /* config IF */
    parameter C_BASEADDR     = 0,
    parameter C_HIGHADDR     = 0,
    parameter C_OPB_AWIDTH   = 0,
    parameter C_OPB_DWIDTH   = 0
  )(
    input  OPB_Clk,
    input  OPB_Rst,
    output [0:31] Sl_DBus,
    output Sl_errAck,
    output Sl_retry,
    output Sl_toutSup,
    output Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input  OPB_RNW,
    input  OPB_select,
    input  OPB_seqAddr,
    output qdr_reset,
    input  cal_fail,
    input  phy_rdy,
    input  qdr_clk
  );

  /************************** Registers *******************************/

  localparam REG_RESET  = 0;
  localparam REG_STATUS = 1;

  /**************** Control Registers OPB Attachment ******************/
  
  /* OPB Address Decoding */
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;
  wire opb_sel = (OPB_ABus >= C_BASEADDR && OPB_ABus < C_HIGHADDR) && OPB_select;


  /* OPB Registers */
  reg Sl_xferAck_reg;
  reg opb_data_sel;

  reg [4:0] qdr_reset_shifter;

  always @(posedge OPB_Clk) begin
    qdr_reset_shifter <= {qdr_reset_shifter[3:0], 1'b0};
   
    Sl_xferAck_reg <= 1'b0;

    if (OPB_Rst) begin
    end else begin
      if (opb_sel && !Sl_xferAck_reg) begin
        Sl_xferAck_reg <= 1'b1;
        opb_data_sel        <= opb_addr[2:2];

        case (opb_addr[2:2])  /* convert byte to word addressing */
          REG_RESET: begin
            if (!OPB_RNW) begin
              if (OPB_BE[3])
                qdr_reset_shifter[0] <= OPB_DBus[31];
            end
          end
        endcase
      end
    end
  end

  /* Continuous Read Logic */
  reg [0:31] Sl_DBus_reg;

  always @(*) begin
    if (Sl_xferAck_reg) begin
      case (opb_data_sel) 
        REG_STATUS: begin
          Sl_DBus_reg <= {16'b0, 7'b0, cal_fail, 7'b0, phy_rdy};
        end
        default: begin
          Sl_DBus_reg <= 32'h0;
        end
      endcase
    end else begin
      Sl_DBus_reg <= 32'b0;
    end
  end

  /* OPB output assignments */

  assign Sl_errAck   = 1'b0;
  assign Sl_retry    = 1'b0;
  assign Sl_toutSup  = 1'b0;
  assign Sl_xferAck  = Sl_xferAck_reg;
  assign Sl_DBus     = Sl_DBus_reg;

  /* */
  reg qdr_reset_R;
  reg qdr_reset_RR;
  always @(posedge qdr_clk) begin
    qdr_reset_R  <= |qdr_reset_shifter;
    qdr_reset_RR <= qdr_reset_R;
  end
  assign qdr_reset = qdr_reset_RR;

endmodule
