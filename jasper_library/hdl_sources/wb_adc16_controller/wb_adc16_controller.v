/*

 Modified version of:
 XPS_ROACH2_BASE/pcores/opb_katcontroller/hdl/verilog/opb_katcontroller.v

 */
module wb_adc16_controller#(
    parameter G_ROACH2_REV = 2,
    parameter G_ZDOK_REV   = 2,
    parameter G_NUM_UNITS  = 1,
    parameter G_NUM_SDATA_LINES = 1,
    parameter G_NUM_SCLK_LINES = 1
    )(
    input         wb_clk_i,
    input         wb_rst_i,
    output [31:0] wb_dat_o,
    output        wb_err_o,
    output        wb_ack_o,
    input  [31:0] wb_adr_i,
    input  [3:0]  wb_sel_i,
    input  [31:0] wb_dat_i,
    input         wb_we_i,
    input         wb_cyc_i,
    input         wb_stb_i,

    output        adc0_adc3wire_csn1,
    output        adc0_adc3wire_csn2,
    output        adc0_adc3wire_csn3,
    output        adc0_adc3wire_csn4,
    output        [G_NUM_SDATA_LINES - 1 : 0] adc0_adc3wire_sdata,
    output        [G_NUM_SCLK_LINES - 1 : 0] adc0_adc3wire_sclk,

    output        adc1_adc3wire_csn1,
    output        adc1_adc3wire_csn2,
    output        adc1_adc3wire_csn3,
    output        adc1_adc3wire_csn4,
    output        [G_NUM_SDATA_LINES - 1 : 0] adc1_adc3wire_sdata,
    output        [G_NUM_SCLK_LINES - 1 : 0] adc1_adc3wire_sclk,

    output        adc16_reset,
    output        [63:0] adc16_iserdes_bitslip,

    output        [63:0] adc16_delay_rst,
    output        [4:0] adc16_delay_tap,
    output        adc16_snap_req,
    output  [1:0] adc16_demux_mode,
    input   [1:0] adc16_locked
  );

  localparam CONTROLLER_REV = 2'b01;

  /********* Global Signals *************/

  wire [31:0] adc16_adc3wire_wire;
  wire [31:0] adc16_ctrl_wire;
  wire [63:0] adc16_delay_strobe_wire;

  /************ OPB Logic ***************/

  wire [31:0] opb_addr = wb_adr_i;

  reg wb_ack;

  /*** Registers ****/

  /* ADC0 3-Wire Register */
  reg [31:0] adc16_adc3wire_reg;
  assign adc16_adc3wire_wire = adc16_adc3wire_reg;

  /* ======================================= */
  /* ADC0 3-Wire Register (word 0)           */
  /* ======================================= */
  /* ZZ = ZDOK Pinout Revision               */
  /* LL = Clock locked bits                  */
  /* NNNN = Number of ADC chips supported    */
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

  genvar i;
  generate
  for (i=0; i<G_NUM_SCLK_LINES; i=i+1) begin : gen_sclk
    assign adc1_adc3wire_sclk[i]  =  adc16_adc3wire_wire[9];
    assign adc0_adc3wire_sclk[i]  =  adc16_adc3wire_wire[9];
  end
  endgenerate;

  generate
  for (i=0; i<G_NUM_SDATA_LINES; i=i+1) begin : gen_sdata
    assign adc1_adc3wire_sdata[i] =  adc16_adc3wire_wire[8];
    assign adc0_adc3wire_sdata[i] =  adc16_adc3wire_wire[8];
  end
  endgenerate;

  /* Invert chip select bits on output. */
  assign adc1_adc3wire_csn4  = ~adc16_adc3wire_wire[7];
  assign adc1_adc3wire_csn3  = ~adc16_adc3wire_wire[6];
  assign adc1_adc3wire_csn2  = ~adc16_adc3wire_wire[5];
  assign adc1_adc3wire_csn1  = ~adc16_adc3wire_wire[4];
  assign adc0_adc3wire_csn4  = ~adc16_adc3wire_wire[3];
  assign adc0_adc3wire_csn3  = ~adc16_adc3wire_wire[2];
  assign adc0_adc3wire_csn2  = ~adc16_adc3wire_wire[1];
  assign adc0_adc3wire_csn1  = ~adc16_adc3wire_wire[0];

  /* ADC0 Control Register */
  reg [31:0] adc16_ctrl_reg;
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

  assign adc16_demux_mode      = adc16_ctrl_wire[25:24];
  assign adc16_reset           = adc16_ctrl_wire[20  ];
  assign adc16_snap_req        = adc16_ctrl_wire[16  ];
  assign adc16_delay_tap       = adc16_ctrl_wire[4:0 ];
  wire [7:0] adc16_iserdes_bitslip_chip_sel = adc16_ctrl_wire[15:8];
  wire [2:0] adc16_iserdes_bitslip_lane_sel = adc16_ctrl_wire[7:5];

  /* ADC0 Delay Strobe Register */
  reg [63:0] adc16_delay_strobe_reg;
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

  reg [31:0] wb_data_out_reg;

  always @(posedge wb_clk_i) begin
    wb_ack <= 1'b0;

    adc16_adc3wire_reg <= adc16_adc3wire_reg;
    adc16_ctrl_reg <= adc16_ctrl_reg;
    adc16_delay_strobe_reg <= adc16_delay_strobe_reg;

    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wb_we_i) begin
          case (opb_addr[3:2])
           0:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    adc16_adc3wire_reg[7:0] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    adc16_adc3wire_reg[15:8] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    adc16_adc3wire_reg[23:16] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    adc16_adc3wire_reg[31:24] <= wb_dat_i[31:24];
                end
           end
           1:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    adc16_ctrl_reg[7:0] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    adc16_ctrl_reg[15:8] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    adc16_ctrl_reg[23:16] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    /* All but the W and MM bits */
                    adc16_ctrl_reg[31:27] <= wb_dat_i[31:27];
                    if (wb_dat_i[26]) begin
                        adc16_ctrl_reg[25:24] <= wb_dat_i[25:24];
                    end
                end
           end
           3:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    adc16_delay_strobe_reg[39:32] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    adc16_delay_strobe_reg[47:40] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    adc16_delay_strobe_reg[55:48] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    adc16_delay_strobe_reg[63:56] <= wb_dat_i[31:24];
                end
           end
           2:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    adc16_delay_strobe_reg[7:0] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    adc16_delay_strobe_reg[15:8] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    adc16_delay_strobe_reg[23:16] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    adc16_delay_strobe_reg[31:24] <= wb_dat_i[31:24];
                end
           end
          endcase
        end else begin // if (wb_we_i)
          case (opb_addr[3:2])
           0:  begin
                   wb_ack <= 1'b1;
                   wb_data_out_reg[31:30] <= 2'b00;
                   wb_data_out_reg[29:28] <= G_ZDOK_REV;
                   wb_data_out_reg[27:26] <= 2'b00;
                   wb_data_out_reg[25:24] <= adc16_locked;
                   wb_data_out_reg[23:20] <= G_NUM_UNITS;
                   wb_data_out_reg[19:18] <= CONTROLLER_REV;
                   wb_data_out_reg[17:16] <= G_ROACH2_REV;
                   wb_data_out_reg[15:0 ] <= adc16_adc3wire_reg[15:0];
               end
           1:  begin
                   wb_ack <= 1'b1;
                   wb_data_out_reg <= adc16_ctrl_reg;
               end
           3:  begin
                   wb_ack <= 1'b1;
                   wb_data_out_reg <= adc16_delay_strobe_reg[63:32];
               end
           2:  begin
                   wb_ack <= 1'b1;
                   wb_data_out_reg <= adc16_delay_strobe_reg[31:0];
               end
          endcase
        end
      end
    end


  end

  assign wb_dat_o     = wb_ack_o ? wb_data_out_reg : 32'b0;
  assign wb_err_o   = 1'b0;
  assign wb_ack_o  = wb_ack;

  wb_adc16_onehot_encoder #(
      .N_CHIPS(8)
  ) onehot_encoder_inst (
      .clk(wb_clk_i),
      .chip_sel(adc16_iserdes_bitslip_chip_sel),
      .lane_sel(adc16_iserdes_bitslip_lane_sel),
      .onehot(adc16_iserdes_bitslip)
  );

endmodule


