`timescale 1ns/10ps

module opb_attach #(
    parameter C_BASEADDR    = 32'h00000000,
    parameter C_HIGHADDR    = 32'h0000FFFF,
    parameter C_OPB_AWIDTH  = 32,
    parameter C_OPB_DWIDTH  = 32
  ) (
    input         OPB_Clk,
    input         OPB_Rst,
    output [0:31] Sl_DBus,
    output        Sl_errAck,
    output        Sl_retry,
    output        Sl_toutSup,
    output        Sl_xferAck,
    input  [0:31] OPB_ABus,
    input  [0:3]  OPB_BE,
    input  [0:31] OPB_DBus,
    input         OPB_RNW,
    input         OPB_select,
    input         OPB_seqAddr,
    output        adc0_reset,
    output        adc1_reset,

    output        adc0_psen,
    output        adc0_psincdec,
    output        adc0_psclk,
    input         adc0_psdone,

    output        adc1_psen,
    output        adc1_psincdec,
    output        adc1_psclk,
    input         adc1_psdone,

    output [15:0] adc0_config_data,
    output  [3:0] adc0_config_addr,
    output        adc0_config_start,
    input         adc0_config_idle,

    output [15:0] adc1_config_data,
    output  [3:0] adc1_config_addr,
    output        adc1_config_start,
    input         adc1_config_idle,

    input         auto_busy_0,
    input         auto_busy_1
  );

  /************ OPB Logic ***************/

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;

  reg opb_ack;

  /*** Registers ****/

  reg adc0_reset_reg;
  reg adc1_reset_reg;
  assign adc0_reset = adc0_reset_reg;
  assign adc1_reset = adc1_reset_reg;

  reg adc0_dcm_psen_reg;
  reg adc0_dcm_psincdec_reg;
  assign adc0_psen     = adc0_dcm_psen_reg;
  assign adc0_psincdec = adc0_dcm_psincdec_reg;
  assign adc0_psclk    = OPB_Clk;

  reg adc1_dcm_psen_reg;
  reg adc1_dcm_psincdec_reg;
  assign adc1_psen     = adc1_dcm_psen_reg;
  assign adc1_psincdec = adc1_dcm_psincdec_reg;
  assign adc1_psclk    = OPB_Clk;

  reg [15:0] adc0_config_data_reg;
  reg  [3:0] adc0_config_addr_reg;
  reg        adc0_config_start_reg;
  assign adc0_config_data  = adc0_config_data_reg;
  assign adc0_config_addr  = adc0_config_addr_reg;
  assign adc0_config_start = adc0_config_start_reg;

  reg [15:0] adc1_config_data_reg;
  reg  [3:0] adc1_config_addr_reg;
  reg        adc1_config_start_reg;
  assign adc1_config_data  = adc1_config_data_reg;
  assign adc1_config_addr  = adc1_config_addr_reg;
  assign adc1_config_start = adc1_config_start_reg;

  reg adc0_reset_hold;
  reg adc1_reset_hold;

  always @(posedge OPB_Clk) begin
    opb_ack <= 1'b0;
    
    adc0_reset_reg <= adc0_reset_hold;
    adc1_reset_reg <= adc1_reset_hold;

    adc0_dcm_psen_reg <= 1'b0;
    adc1_dcm_psen_reg <= 1'b0;

    adc0_config_start_reg <= 1'b0;
    adc1_config_start_reg <= 1'b0;

    if (OPB_Rst) begin
      adc0_reset_hold <= 1'b0;
      adc1_reset_hold <= 1'b0;
    end else begin
      if (addr_match && OPB_select && !opb_ack) begin
        opb_ack <= 1'b1;
        if (!OPB_RNW) begin
          case (opb_addr[3:2])
            0:  begin
              if (OPB_BE[3]) begin
                adc0_reset_reg <= OPB_DBus[31];
                adc1_reset_reg <= OPB_DBus[30];

                adc0_reset_hold <= OPB_DBus[27];
                adc1_reset_hold <= OPB_DBus[26];
              end
              if (OPB_BE[1]) begin
                adc0_dcm_psen_reg <= OPB_DBus[15];
                adc1_dcm_psen_reg <= OPB_DBus[11];
                adc0_dcm_psincdec_reg <= OPB_DBus[14];
                adc1_dcm_psincdec_reg <= OPB_DBus[10];
              end
            end
            1:  begin
              if (OPB_BE[3]) begin
                adc0_config_start_reg <= OPB_DBus[31];
              end
              if (OPB_BE[2]) begin
                adc0_config_addr_reg <= OPB_DBus[20:23];
              end
              if (OPB_BE[1]) begin
                adc0_config_data_reg[7:0] <= OPB_DBus[8:15];
              end
              if (OPB_BE[0]) begin
                adc0_config_data_reg[15:8] <= OPB_DBus[0:7];
              end
            end
            2:  begin
              if (OPB_BE[3]) begin
                adc1_config_start_reg <= OPB_DBus[31];
              end
              if (OPB_BE[2]) begin
                adc1_config_addr_reg <= OPB_DBus[20:23];
              end
              if (OPB_BE[1]) begin
                adc1_config_data_reg[7:0] <= OPB_DBus[8:15];
              end
              if (OPB_BE[0]) begin
                adc1_config_data_reg[15:8] <= OPB_DBus[0:7];
              end
            end
            3:  begin
            end
          endcase
        end
      end
    end
  end

  reg [31:0] opb_data_out;

  always @(*) begin
    case (opb_addr[3:2])
      0: opb_data_out <= {2'b0, adc1_psdone, adc0_psdone, 4'b0, 2'b0, adc1_dcm_psincdec_reg, adc1_dcm_psen_reg, 2'b0, adc0_dcm_psincdec_reg, adc0_dcm_psen_reg, 16'b0};
      1: opb_data_out <= {adc0_config_data[15:8], adc0_config_data[7:0], 4'b0, adc0_config_addr, 3'b0, auto_busy_0, 3'b0, adc0_config_idle};
      2: opb_data_out <= {adc1_config_data[15:8], adc1_config_data[7:0], 4'b0, adc1_config_addr, 3'b0, auto_busy_1, 3'b0, adc1_config_idle};
      3: opb_data_out <= {32'b0};
    endcase
  end

  assign Sl_DBus     = Sl_xferAck ? opb_data_out : 32'b0;
  assign Sl_errAck   = 1'b0;
  assign Sl_retry    = 1'b0;
  assign Sl_toutSup  = 1'b0;
  assign Sl_xferAck  = opb_ack;


endmodule
