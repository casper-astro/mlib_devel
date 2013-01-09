/*

 Modified version of:
 XPS_ROACH2_BASE/pcores/opb_katcontroller/hdl/verilog/opb_katcontroller.v

 */
module opb_adc16_controller(
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

    output        adc0_adc3wire_csn1,
    output        adc0_adc3wire_csn2,
    output        adc0_adc3wire_csn3,
    output        adc0_adc3wire_csn4,
    output        adc0_adc3wire_sdata,
    output        adc0_adc3wire_sclk,

    output        adc1_adc3wire_csn1,
    output        adc1_adc3wire_csn2,
    output        adc1_adc3wire_csn3,
    output        adc1_adc3wire_csn4,
    output        adc1_adc3wire_sdata,
    output        adc1_adc3wire_sclk,

    output        adc0_reset,
    output        [0:7] adc0_iserdes_bitslip,

    output        [0:31] adc0_delay_rst,
    output        [0:4] adc0_delay_tap,
    output        adc0_snap_req,
    input   [1:0] adc0_roach2_rev
  );
  parameter C_BASEADDR    = 32'h00000000;
  parameter C_HIGHADDR    = 32'h0000FFFF;
  parameter C_OPB_AWIDTH  = 32;
  parameter C_OPB_DWIDTH  = 32;
  parameter C_FAMILY      = "";

  /********* Global Signals *************/

  wire [0:31] adc0_adc3wire_wire;
  wire [0:31] adc0_ctrl_wire;
  wire [0:31] adc0_delay_strobe_wire;

  /************ OPB Logic ***************/

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;

  reg opb_ack;

  /*** Registers ****/

  /* ADC0 3-Wire Register */
  reg [0:31] adc0_adc3wire_reg;
  assign adc0_adc3wire_wire = adc0_adc3wire_reg;

  /* ======================================= */
  /* ADC0 3-Wire Register (word 0)           */
  /* ======================================= */
  /* RR = ROACH2 revision expected/required  */
  /* C = SCLK                                */
  /* D = SDATA                               */
  /* 7 = CSNH (chip select H, active high)   */
  /* 6 = CSNG (chip select G, active high)   */
  /* 5 = CSNF (chip select F, active high)   */
  /* 4 = CSNE (chip select E, active high)   */
  /* 3 = CSND (chip select D, active high)   */
  /* 2 = CSNC (chip select C, active high)   */
  /* 1 = CSNB (chip select B, active high)   */
  /* 0 = CSNA (chip select A, active high)   */
  /* ======================================= */
  /* |<-- MSb                       LSb -->| */
  /* 0000_0000_0011_1111_1111_2222_2222_2233 */
  /* 0123_4567_8901_2345_6789_0123_4567_8901 */
  /* ---- ---- ---- --RR ---- ---- ---- ---- */
  /* ---- ---- ---- ---- ---- --C- ---- ---- */
  /* ---- ---- ---- ---- ---- ---D ---- ---- */
  /* ---- ---- ---- ---- ---- ---- 7654 3210 */
  /* ======================================= */

  assign adc0_adc3wire_sclk  =  adc0_adc3wire_wire[22];
  assign adc0_adc3wire_sdata =  adc0_adc3wire_wire[23];
  /* Invert chip select bits on output. */
  assign adc1_adc3wire_csn4  = ~adc0_adc3wire_wire[24];
  assign adc1_adc3wire_csn3  = ~adc0_adc3wire_wire[25];
  assign adc1_adc3wire_csn2  = ~adc0_adc3wire_wire[26];
  assign adc1_adc3wire_csn1  = ~adc0_adc3wire_wire[27];
  assign adc0_adc3wire_csn4  = ~adc0_adc3wire_wire[28];
  assign adc0_adc3wire_csn3  = ~adc0_adc3wire_wire[29];
  assign adc0_adc3wire_csn2  = ~adc0_adc3wire_wire[30];
  assign adc0_adc3wire_csn1  = ~adc0_adc3wire_wire[31];

  /* ADC0 Control Register */
  reg [0:31] adc0_ctrl_reg;
  assign adc0_ctrl_wire = adc0_ctrl_reg;

  /* ======================================= */
  /* ADC0 Control Register (word 1)          */
  /* ======================================= */
  /* R = Reset                               */
  /* S = Snap Request                        */
  /* H = ISERDES Bit Slip Chip H             */
  /* G = ISERDES Bit Slip Chip G             */
  /* F = ISERDES Bit Slip Chip F             */
  /* E = ISERDES Bit Slip Chip E             */
  /* D = ISERDES Bit Slip Chip D             */
  /* C = ISERDES Bit Slip Chip C             */
  /* B = ISERDES Bit Slip Chip B             */
  /* A = ISERDES Bit Slip Chip A             */
  /* T = Delay Tap                           */
  /* ======================================= */
  /* |<-- MSb                       LSb -->| */
  /* 0000 0000 0011 1111 1111 2222 2222 2233 */
  /* 0123 4567 8901 2345 6789 0123 4567 8901 */
  /* ---- ---- ---R ---- ---- ---- ---- ---- */
  /* ---- ---- ---- ---S ---- ---- ---- ---- */
  /* ---- ---- ---- ---- HGFE DCBA ---- ---- */
  /* ---- ---- ---- ---- ---- ---- ---T TTTT */
  /* ======================================= */

  assign adc0_reset           = adc0_ctrl_wire[11   ];
  assign adc0_snap_req        = adc0_ctrl_wire[15   ];
  assign adc0_iserdes_bitslip = adc0_ctrl_wire[16:23];
  assign adc0_delay_tap       = adc0_ctrl_wire[27:31];

  /* ADC0 Delay Strobe Register */
  reg [0:31] adc0_delay_strobe_reg;
  assign adc0_delay_strobe_wire = adc0_delay_strobe_reg;

  /* =============================================== */
  /* ADC0 Delay Strobe Register (word 2)             */
  /* =============================================== */
  /* D = Delay RST                                   */
  /* =============================================== */
  /* |<-- MSb                              LSb -->|  */
  /* 0000  0000  0011  1111  1111  2222  2222  2233  */
  /* 0123  4567  8901  2345  6789  0123  4567  8901  */
  /* DDDD  DDDD  DDDD  DDDD  DDDD  DDDD  DDDD  DDDD  */
  /* |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  */
  /* H4 H1 G4 G1 F4 F1 E4 E1 D4 D1 C4 C1 B4 B1 A4 A1 */
  /* =============================================== */

  assign adc0_delay_rst = adc0_delay_strobe_wire[0:31];

  /* OPB interface logic */

  reg [31:0] opb_data_out;

  always @(posedge OPB_Clk) begin
    opb_ack <= 1'b0;

    adc0_adc3wire_reg <= adc0_adc3wire_reg;
    adc0_ctrl_reg <= adc0_ctrl_reg;

    if (OPB_Rst) begin
    end else begin
      if (addr_match && OPB_select && !opb_ack) begin
        if (!OPB_RNW) begin
          case (opb_addr[3:2])
           0:  begin
                opb_ack <= 1'b1;
                if (OPB_BE[0]) begin
                    adc0_adc3wire_reg[0:7] <= OPB_DBus[0:7];
                end
                if (OPB_BE[1]) begin
                    adc0_adc3wire_reg[8:15] <= OPB_DBus[8:15];
                end
                if (OPB_BE[2]) begin
                    adc0_adc3wire_reg[16:23] <= OPB_DBus[16:23];
                end
                if (OPB_BE[3]) begin
                    adc0_adc3wire_reg[24:31] <= OPB_DBus[24:31];
                end
           end
           1:  begin
                opb_ack <= 1'b1;
                if (OPB_BE[0]) begin
                    adc0_ctrl_reg[0:7] <= OPB_DBus[0:7];
                end
                if (OPB_BE[1]) begin
                    adc0_ctrl_reg[8:15] <= OPB_DBus[8:15];
                end
                if (OPB_BE[2]) begin
                    adc0_ctrl_reg[16:23] <= OPB_DBus[16:23];
                end
                if (OPB_BE[3]) begin
                    adc0_ctrl_reg[24:31] <= OPB_DBus[24:31];
                end
           end
           2:  begin
                opb_ack <= 1'b1;
                if (OPB_BE[0]) begin
                    adc0_ctrl_reg[0:7] <= OPB_DBus[0:7];
                end
                if (OPB_BE[1]) begin
                    adc0_ctrl_reg[8:15] <= OPB_DBus[8:15];
                end
                if (OPB_BE[2]) begin
                    adc0_ctrl_reg[16:23] <= OPB_DBus[16:23];
                end
                if (OPB_BE[3]) begin
                    adc0_ctrl_reg[24:31] <= OPB_DBus[24:31];
                end
           end
          endcase
        end else begin // if (!OPB_RNW)
          case (opb_addr[3:2])
           0:  begin
                   opb_ack <= 1'b1;
                   opb_data_out[31:18] <= adc0_adc3wire_reg[0:13];
                   opb_data_out[17:16] <= adc0_roach2_rev;
                   opb_data_out[15:0 ] <= adc0_adc3wire_reg[16:31];
               end
           1:  begin
                   opb_ack <= 1'b1;
                   opb_data_out <= adc0_ctrl_reg;
               end
           2:  begin
                   opb_ack <= 1'b1;
                   opb_data_out <= adc0_delay_strobe_reg;
               end
          endcase
        end
      end
    end


  end

  assign Sl_DBus     = Sl_xferAck ? opb_data_out : 32'b0;
  assign Sl_errAck   = 1'b0;
  assign Sl_retry    = 1'b0;
  assign Sl_toutSup  = 1'b0;
  assign Sl_xferAck  = opb_ack;

endmodule
