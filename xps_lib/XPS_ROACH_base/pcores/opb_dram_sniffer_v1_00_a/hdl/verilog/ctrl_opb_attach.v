module ctrl_opb_attach #(
    parameter C_BASEADDR     = 0,
    parameter C_HIGHADDR     = 0,
    parameter C_OPB_AWIDTH   = 32,
    parameter C_OPB_DWIDTH   = 32
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
    output [15:0] software_address_bits,
    input  phy_ready
  );


  /************************** Registers *******************************/

  localparam REG_SOFTADDR = 0;
  /* Stores the software controlled dram address bits.
   * Only a limited amount of memory can be mapped to the DRAM on ROACH
   * which necessitates the use of the MSBs of the DRAM address to be control
   * by an indirect software register
   */
  localparam REG_PHYREADY = 1;

  /**************** Control Registers OPB Attachment ******************/
  
  /* OPB Address Decoding */
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;
  wire opb_sel = (OPB_ABus >= C_BASEADDR && OPB_ABus < C_HIGHADDR) && OPB_select;


  /* OPB Registers */
  reg Sl_xferAck_reg;
  reg [15:0] soft_addr_reg;
  reg opb_data_sel;

  always @(posedge OPB_Clk) begin
    Sl_xferAck_reg <= 1'b0;

    if (OPB_Rst) begin
      soft_addr_reg <= 16'b0;
    end else begin
      if (opb_sel && !Sl_xferAck_reg) begin
        Sl_xferAck_reg <= 1'b1;
        opb_data_sel        <= opb_addr[2:2];

        case (opb_addr[2:2])  /* convert byte to word addressing */
          REG_SOFTADDR: begin
            if (!OPB_RNW) begin
              if (OPB_BE[3])
                soft_addr_reg[7:0]  <= OPB_DBus[24:31];
              if (OPB_BE[2])
                soft_addr_reg[15:8] <= OPB_DBus[16:23];
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
        REG_SOFTADDR: begin
          Sl_DBus_reg <= {16'h0, soft_addr_reg};
        end
        REG_PHYREADY: begin
          Sl_DBus_reg <= {31'h0, phy_ready};
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
  assign software_address_bits = soft_addr_reg;

endmodule
