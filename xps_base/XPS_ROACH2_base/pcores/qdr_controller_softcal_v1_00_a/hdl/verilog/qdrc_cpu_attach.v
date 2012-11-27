module qdrc_cpu_attach #(
    parameter C_BASEADDR     = 0,
    parameter C_HIGHADDR     = 0,
    parameter C_OPB_AWIDTH   = 0,
    parameter C_OPB_DWIDTH   = 0
  ) (
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

    /* controls the qdr dll */
    output        doffn,
    /* Enable the software calibration */
    output        cal_en,
    /* Calibration setup is complete */
    input         cal_rdy,
    /* Select the bit that we are calibrating */
    output [7:0]  bit_select,
    /* strobe to tick IODELAY delay tap */
    output        dll_en,
    /* Direction of IO delay */
    output        dll_inc_dec_n,
    /* IODELAY value reset */
    output        dll_rst,
    /* Set to enable additional delay to compensate for half cycle delay */
    output        align_en,
    output        align_strb,
    /* Sampled value */
    input  [1:0]  data_in,
    /* has the value been sampled 32 times */
    input         data_sampled,
    /* has the value stayed valid after being sampled 32 times */
    input         data_valid
  );

  /************************** Registers *******************************/

  localparam REG_CTRL      = 0;
  localparam REG_BITINDEX  = 1;
  localparam REG_BITCTRL   = 2;
  localparam REG_BITSTATUS = 3;

  /**************** Control Registers CPU Attachment ******************/
  

  /* OPB Registers */
  assign Sl_toutSup = 1'b0;
  assign Sl_retry   = 1'b0;
  assign Sl_errAck  = 1'b0;
  reg Sl_xferAck_reg;
  assign Sl_xferAck = Sl_xferAck_reg;

  wire a_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] a_trans = OPB_ABus - C_BASEADDR;

  reg       cal_en_reg;
  reg       doffn_reg;
  reg [7:0] bit_select_reg;
  reg       dll_inc_dec_n_reg;
  reg       dll_en_reg;
  reg       dll_rst_reg;
  reg       align_en_reg;
  reg       align_strb_reg;

  always @(posedge OPB_Clk) begin
    Sl_xferAck_reg <= 1'b0;
    if (a_match && OPB_select && !Sl_xferAck_reg) begin
      Sl_xferAck_reg <= 1'b1;
    end
  end

  always @(posedge OPB_Clk) begin
    /* Single cycle strobes */
    dll_en_reg     <= 1'b0;
    align_strb_reg <= 1'b0;

    if (OPB_Rst) begin
      cal_en_reg        <= 1'b0;
      doffn_reg         <= 1'b0;
      bit_select_reg    <= 8'b0;
      dll_inc_dec_n_reg <= 1'b0;
      dll_rst_reg       <= 1'b0;
      align_en_reg      <= 1'b0;
    end else begin
      if (a_match && OPB_select && !Sl_xferAck_reg && !OPB_RNW) begin
        case (a_trans[3:2])  /* convert byte to word addressing */
          REG_CTRL: begin
            if (OPB_BE[2])
              doffn_reg <= OPB_DBus[23];
            if (OPB_BE[3])
              cal_en_reg <= OPB_DBus[31];
          end
          REG_BITINDEX: begin
            if (OPB_BE[3])
              bit_select_reg <= OPB_DBus[24:31];
          end
          REG_BITCTRL: begin
            if (OPB_BE[2]) begin
              align_en_reg <= OPB_DBus[23];
              align_strb_reg <= 1'b1;
            end
            if (OPB_BE[3]) begin
              dll_rst_reg <= OPB_DBus[29];
              dll_inc_dec_n_reg <= OPB_DBus[30];
              dll_en_reg <= OPB_DBus[31];
            end 
          end
        endcase
      end
    end
  end

  assign cal_en         = cal_en_reg;
  assign doffn          = doffn_reg;
  assign bit_select     = bit_select_reg;
  assign dll_inc_dec_n  = dll_inc_dec_n_reg;
  assign dll_en         = dll_en_reg;
  assign dll_rst        = dll_rst_reg;
  assign align_en       = align_en_reg;
  assign align_strb     = align_strb_reg;

  /* Continuous Read Logic */
  reg [31:0] Sl_DBus_reg;
  assign Sl_DBus = Sl_DBus_reg;

  always @(*) begin
    if (!Sl_xferAck) begin
      Sl_DBus_reg <= 32'b0;
    end else begin
      case (a_trans[3:2]) 
        REG_CTRL: begin
          Sl_DBus_reg <= {16'b0, 7'b0, doffn, 7'b0, cal_en};
        end
        REG_BITINDEX: begin
          Sl_DBus_reg <= {24'b0, bit_select};
        end
        REG_BITCTRL: begin
          Sl_DBus_reg <= {7'b0, align_en, 7'b0, dll_rst, 7'b0, dll_inc_dec_n, 7'b0, dll_en};
        end
        REG_BITSTATUS: begin
          Sl_DBus_reg <= {7'b0, cal_rdy, 7'b0, data_sampled, 7'b0, data_valid, 6'b0, data_in};
        end
        default: begin
          Sl_DBus_reg <= 32'b0;
        end
      endcase
    end
  end


endmodule
