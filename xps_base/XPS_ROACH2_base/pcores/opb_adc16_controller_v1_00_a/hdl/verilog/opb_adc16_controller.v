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

    output        adc16_reset,
    output        [0:63] adc16_iserdes_bitslip,

    output        [0:63] adc16_delay_rst,
    output        [0:4] adc16_delay_tap,
    output        adc16_snap_req,
    output        [0:1] adc16_demux_mode,
    input   [1:0] adc16_locked,
    input   [1:0] adc16_roach2_rev,
    input   [1:0] adc16_zdok_rev,
    input   [3:0] adc16_num_units
  );
  parameter C_BASEADDR    = 32'h00000000;
  parameter C_HIGHADDR    = 32'h0000FFFF;
  parameter C_OPB_AWIDTH  = 32;
  parameter C_OPB_DWIDTH  = 32;
  parameter C_FAMILY      = "";

  localparam CONTROLLER_REV = 2'b01;

  /********* Global Signals *************/

  wire [0:31] adc16_adc3wire_wire;
  wire [0:31] adc16_ctrl_wire;
  wire [0:63] adc16_delay_strobe_wire;
  wire [0:7] adc16_iserdes_bitslip_chip_sel;
  wire [0:3] adc16_iserdes_bitslip_lane_sel;

  /************ OPB Logic ***************/

  wire addr_match = OPB_ABus >= C_BASEADDR && OPB_ABus <= C_HIGHADDR;
  wire [31:0] opb_addr = OPB_ABus - C_BASEADDR;

  reg opb_ack;

  /*** Registers ****/

  /* ADC0 3-Wire Register */
  reg [0:31] adc16_adc3wire_reg;
  assign adc16_adc3wire_wire = adc16_adc3wire_reg;

  /* ======================================= */
  /* ADC0 3-Wire Register (word 0)           */
  /* ======================================= */
  /* ZZ = ZDOK Pinout Revision               */
  /* LL = Clock locked bits                  */
  /* NNNN = Number of ADC chips supported    */
  /* VV = Controller Version                 */
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
  /* --ZZ ---- ---- ---- ---- ---- ---- ---- */
  /* ---- --LL ---- ---- ---- ---- ---- ---- */
  /* ---- ---- NNNN ---- ---- ---- ---- ---- */
  /* ---- ---- ---- VVRR ---- ---- ---- ---- */
  /* ---- ---- ---- ---- ---- --C- ---- ---- */
  /* ---- ---- ---- ---- ---- ---D ---- ---- */
  /* ---- ---- ---- ---- ---- ---- 7654 3210 */
  /* ======================================= */
  /* NOTE: LL reflects the runtime lock      */
  /*       status of a line clock from each  */
  /*       ADC board.  A '1' bit means       */
  /*       locked (good!).  Bit 5 is always  */
  /*       used, but bit 6 is only used when */
  /*       NNNN is 4 (or less).              */
  /* ======================================= */
  /* NOTE: NNNN, RR and ZZ are read-only     */
  /*       values that are set at compile    */
  /*       time.  They do not indicate the   */
  /*       state of the actual hardware in   */
  /*       use at runtime.                   */
  /* ======================================= */

  assign adc1_adc3wire_sclk  =  adc16_adc3wire_wire[22];
  assign adc0_adc3wire_sclk  =  adc16_adc3wire_wire[22];
  assign adc1_adc3wire_sdata =  adc16_adc3wire_wire[23];
  assign adc0_adc3wire_sdata =  adc16_adc3wire_wire[23];
  /* Invert chip select bits on output. */
  assign adc1_adc3wire_csn4  = ~adc16_adc3wire_wire[24];
  assign adc1_adc3wire_csn3  = ~adc16_adc3wire_wire[25];
  assign adc1_adc3wire_csn2  = ~adc16_adc3wire_wire[26];
  assign adc1_adc3wire_csn1  = ~adc16_adc3wire_wire[27];
  assign adc0_adc3wire_csn4  = ~adc16_adc3wire_wire[28];
  assign adc0_adc3wire_csn3  = ~adc16_adc3wire_wire[29];
  assign adc0_adc3wire_csn2  = ~adc16_adc3wire_wire[30];
  assign adc0_adc3wire_csn1  = ~adc16_adc3wire_wire[31];

  /* ADC0 Control Register */
  reg [0:31] adc16_ctrl_reg;
  assign adc16_ctrl_wire = adc16_ctrl_reg;

  /* ======================================= */
  /* ADC0 Control Register (word 1)          */
  /* ======================================= */
  /* W  = Demux write-enable                 */
  /* MM = Demux mode                         */ 
  /* R  = Reset                              */
  /* S  = Snap Request                       */
  /* H  = ISERDES Bit Slip Chip H            */
  /* G  = ISERDES Bit Slip Chip G            */
  /* F  = ISERDES Bit Slip Chip F            */
  /* E  = ISERDES Bit Slip Chip E            */
  /* D  = ISERDES Bit Slip Chip D            */
  /* C  = ISERDES Bit Slip Chip C            */
  /* B  = ISERDES Bit Slip Chip B            */
  /* A  = ISERDES Bit Slip Chip A            */
  /* XXX = ISERDES Bit Slip Lane Select      */
  /* T  = Delay Tap                          */
  /* ======================================= */
  /* |<-- MSb                       LSb -->| */
  /* 0000 0000 0011 1111 1111 2222 2222 2233 */
  /* 0123 4567 8901 2345 6789 0123 4567 8901 */
  /* ---- -WMM ---- ---- ---- ---- ---- ---- */
  /* ---- ---- ---R ---- ---- ---- ---- ---- */
  /* ---- ---- ---- ---S ---- ---- ---- ---- */
  /* ---- ---- ---- ---- HGFE DCBA ---- ---- */
  /* ---- ---- ---- ---- ---- ---- XXXT TTTT */
  /* ======================================= */
  /* NOTE: W enables writing the MM bits.    */
  /*       Some of the other bits in this    */
  /*       register are one-hot.  Using      */
  /*       W ensures that the MM bits will   */
  /*       only be written to when desired.  */
  /*       00: demux by 1 (single channel)   */
  /* ======================================= */
  /* NOTE: MM selects the demux mode.        */
  /*       00: demux by 1 (single channel)   */
  /*       01: demux by 2 (dual channel)     */
  /*       10: demux by 4 (quad channel)     */
  /*       11: undefined                     */
  /*       ADC board.  A '1' bit means       */
  /*       locked (good!).  Bit 5 is always  */
  /*       used, but bit 6 is only used when */
  /*       NNNN is 4 (or less).              */
  /* ======================================= */

  assign adc16_demux_mode      = adc16_ctrl_wire[ 6: 7];
  assign adc16_reset           = adc16_ctrl_wire[11   ];
  assign adc16_snap_req        = adc16_ctrl_wire[15   ];
  assign adc16_delay_tap       = adc16_ctrl_wire[27:31];
  assign adc16_iserdes_bitslip_chip_sel = adc16_ctrl_wire[16:23];
  assign adc16_iserdes_bitslip_lane_sel = adc16_ctrl_wire[24:26];

  /* ADC0 Delay Strobe Register */
  reg [0:63] adc16_delay_strobe_reg;
  assign adc16_delay_strobe_wire = adc16_delay_strobe_reg;

  /* =============================================== */
  /* ADC0 Delay A Strobe Register (word 2)           */
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

  /* =============================================== */
  /* ADC0 Delay B Strobe Register (word 3)           */
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

  assign adc16_delay_rst = adc16_delay_strobe_wire;

  /* OPB interface logic */

  reg [31:0] opb_data_out;

  always @(posedge OPB_Clk) begin
    opb_ack <= 1'b0;

    adc16_adc3wire_reg <= adc16_adc3wire_reg;
    adc16_ctrl_reg <= adc16_ctrl_reg;
    adc16_delay_strobe_reg <= adc16_delay_strobe_reg;

    if (OPB_Rst) begin
    end else begin
      if (addr_match && OPB_select && !opb_ack) begin
        if (!OPB_RNW) begin
          case (opb_addr[3:2])
           0:  begin
                opb_ack <= 1'b1;
                if (OPB_BE[0]) begin
                    adc16_adc3wire_reg[0:7] <= OPB_DBus[0:7];
                end
                if (OPB_BE[1]) begin
                    adc16_adc3wire_reg[8:15] <= OPB_DBus[8:15];
                end
                if (OPB_BE[2]) begin
                    adc16_adc3wire_reg[16:23] <= OPB_DBus[16:23];
                end
                if (OPB_BE[3]) begin
                    adc16_adc3wire_reg[24:31] <= OPB_DBus[24:31];
                end
           end
           1:  begin
                opb_ack <= 1'b1;
                if (OPB_BE[0]) begin
                    /* All but the W and MM bits */
                    adc16_ctrl_reg[0:4] <= OPB_DBus[0:4];
                    /* Write to MM bits if W bit is set */
                    if(OPB_DBus[5]) begin
                        adc16_ctrl_reg[6:7] <= OPB_DBus[6:7];
                    end
                end
                if (OPB_BE[1]) begin
                    adc16_ctrl_reg[8:15] <= OPB_DBus[8:15];
                end
                if (OPB_BE[2]) begin
                    adc16_ctrl_reg[16:23] <= OPB_DBus[16:23];
                end
                if (OPB_BE[3]) begin
                    adc16_ctrl_reg[24:31] <= OPB_DBus[24:31];
                end
           end
           2:  begin
                opb_ack <= 1'b1;
                if (OPB_BE[0]) begin
                    adc16_delay_strobe_reg[32:39] <= OPB_DBus[0:7];
                end
                if (OPB_BE[1]) begin
                    adc16_delay_strobe_reg[40:47] <= OPB_DBus[8:15];
                end
                if (OPB_BE[2]) begin
                    adc16_delay_strobe_reg[48:55] <= OPB_DBus[16:23];
                end
                if (OPB_BE[3]) begin
                    adc16_delay_strobe_reg[56:63] <= OPB_DBus[24:31]; // LSB
                end
           end
           3:  begin
                opb_ack <= 1'b1;
                if (OPB_BE[0]) begin
                    adc16_delay_strobe_reg[0:7] <= OPB_DBus[0:7]; // MSB
                end
                if (OPB_BE[1]) begin
                    adc16_delay_strobe_reg[8:15] <= OPB_DBus[8:15];
                end
                if (OPB_BE[2]) begin
                    adc16_delay_strobe_reg[16:23] <= OPB_DBus[16:23];
                end
                if (OPB_BE[3]) begin
                    adc16_delay_strobe_reg[24:31] <= OPB_DBus[24:31];
                end
           end
          endcase
        end else begin // if (!OPB_RNW)
          case (opb_addr[3:2])
           0:  begin
                   opb_ack <= 1'b1;
                   opb_data_out[31:30] <= 2'b00;
                   opb_data_out[29:28] <= adc16_zdok_rev;
                   opb_data_out[27:26] <= 2'b00;
                   opb_data_out[25:24] <= adc16_locked;
                   opb_data_out[23:20] <= adc16_num_units;
                   opb_data_out[19:18] <= CONTROLLER_REV;
                   opb_data_out[17:16] <= adc16_roach2_rev;
                   opb_data_out[15:0 ] <= adc16_adc3wire_reg[16:31];
               end
           1:  begin
                   opb_ack <= 1'b1;
                   opb_data_out <= adc16_ctrl_reg;
               end
           2:  begin
                   opb_ack <= 1'b1;
                   opb_data_out <= adc16_delay_strobe_reg[32:63]; // Lower half
               end
           3:  begin
                   opb_ack <= 1'b1;
                   opb_data_out <= adc16_delay_strobe_reg[0:31]; // Upper half
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

  /* Bitslip Decode */
  opb_adc16_onehot_encoder #(
      .N_CHIPS(8)
  ) onehot_encoder_inst (
      .clk(OPB_Clk),
      .chip_sel(adc16_iserdes_bitslip_chip_sel),
      .lane_sel(adc16_iserdes_bitslip_lane_sel),
      .onehot(adc16_iserdes_bitslip)
  );

endmodule
