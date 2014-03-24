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

    input         dly_clk,
    output [35:0] dly_en_i,
    output [36:0] dly_en_o,
    output        dly_inc_dec,

    input [5*(37+36)-1:0] dly_cntrs,

    /* Misc signals */
    output qdr_reset,
    input  cal_fail,
    input  phy_rdy,
    input  qdr_clk
  );

  /************************** Registers *******************************/

  localparam REG_RESET          = 0;
  localparam REG_STATUS         = 1;
  localparam REG_DLY_EN_0       = 4;
  localparam REG_DLY_EN_1       = 5;
  localparam REG_DLY_EN_2       = 6;
  localparam REG_DLY_INC_DEC    = 7;
  localparam REG_DLY_CNTRS0     = 8;

  /**************** Control Registers OPB Attachment ******************/
  
  reg [35:0] dly_en_i_reg;
  reg [36:0] dly_en_o_reg;
  reg        dly_inc_dec_reg;

  /* OPB Address Decoding */
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;
  wire opb_sel = (OPB_ABus >= C_BASEADDR && OPB_ABus < C_HIGHADDR) && OPB_select;

  /* OPB Registers */
  reg Sl_xferAck_reg;
  reg [3:0] opb_data_sel;

  reg [4:0] qdr_reset_shifter;

  always @(posedge OPB_Clk) begin
    qdr_reset_shifter <= {qdr_reset_shifter[3:0], 1'b0};
   
    Sl_xferAck_reg <= 1'b0;

    if (OPB_Rst) begin
    end else begin
      if (opb_sel && !Sl_xferAck_reg) begin
        Sl_xferAck_reg <= 1'b1;
        opb_data_sel        <= opb_addr[5:2];

        case (opb_addr[5:2])  /* convert byte to word addressing */
          REG_RESET: begin
            if (!OPB_RNW) begin
              if (OPB_BE[3])
                qdr_reset_shifter[0] <= OPB_DBus[31];
            end
          end
          REG_DLY_EN_0: begin
            if (!OPB_RNW) begin
              dly_en_i_reg[31:0] <= OPB_DBus[0:31];
            end
          end
          REG_DLY_EN_1: begin
            if (!OPB_RNW) begin
              dly_en_i_reg[35:32] <= OPB_DBus[28:31];
              dly_en_o_reg[36:32] <= OPB_DBus[23:27];
            end
          end
          REG_DLY_EN_2: begin
            if (!OPB_RNW) begin
              dly_en_o_reg[31:0] <= OPB_DBus[0:31];
            end
          end
          REG_DLY_INC_DEC: begin
            if (!OPB_RNW) begin
              dly_inc_dec_reg <= OPB_DBus[31];
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
        REG_DLY_CNTRS0: begin
          Sl_DBus_reg <= dly_cntrs[31:0];
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

  wire [35:0] dly_en_i_clk_crossed;
  wire [36:0] dly_en_o_clk_crossed;
  wire        dly_inc_dec_clk_crossed;

  assign dly_inc_dec = dly_inc_dec_clk_crossed;
 
  /*** cross the clock domains ***/  
  clk_domain_crosser #(
    .DATA_WIDTH (74)
  ) clk_domain_crosser (
    .in_clk   (OPB_Clk),
    .out_clk  (dly_clk),
    .rst      (OPB_Rst),
    .data_in  ({dly_en_i_reg,         dly_en_o_reg,         dly_inc_dec_reg        }),
    .data_out ({dly_en_i_clk_crossed, dly_en_o_clk_crossed, dly_inc_dec_clk_crossed})
  );
  
  /*** edge detect ***/
  edge_detect #(
    .DATA_WIDTH (73),
    .EDGE_TYPE ("RISE")
  ) dly_en_edge_detect (
    .clk       (dly_clk),
    .en        (1'b1),
    .in        ({dly_en_i_clk_crossed[35:0], dly_en_o_clk_crossed[36:0]}),
    .pulse_out ({dly_en_i,                   dly_en_o})
  );
  
endmodule
