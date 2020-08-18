/*

 Modified version of:
 XPS_ROACH2_BASE/pcores/opb_katcontroller/hdl/verilog/opb_katcontroller.v

 */
module wb_ads5296_controller#(
    parameter G_ROACH2_REV = 2,
    parameter G_ZDOK_REV   = 2,
    parameter G_NUM_UNITS  = 1,
    parameter G_NUM_SDATA_LINES = 1,
    parameter G_NUM_SCLK_LINES = 1,
    parameter G_NUM_CS_LINES = 1
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

    output        [G_NUM_CS_LINES - 1 : 0] adc_spi_cs,
    output        [G_NUM_SDATA_LINES - 1 : 0] adc_spi_mosi,
    input         [G_NUM_SDATA_LINES - 1 : 0] adc_spi_miso,
    output        [G_NUM_SCLK_LINES - 1 : 0] adc_spi_sclk,

    output        adc_reset,
    output        [8*G_NUM_UNITS - 1 : 0] adc_iserdes_bitslip,

    output        [8*G_NUM_UNITS - 1 : 0] adc_delay_rst,
    output        [8:0] adc_delay_tap,
    output        adc_snap_req,
    output  [1:0] adc_demux_mode,
    input   [1:0] adc_locked
  );

  localparam CONTROLLER_REV = 2'd3;

  /********* Global Signals *************/

  wire [31:0] adc_spi_wire;
  wire [31:0] adc_ctrl_wire;
  wire [8*G_NUM_UNITS - 1:0] adc_delay_strobe_wire;
  wire [G_NUM_CS_LINES - 1:0] adc_spi_cs_wire;

  /************ OPB Logic ***************/

  wire [31:0] opb_addr = wb_adr_i;

  reg wb_ack;

  /*** Registers ****/
  /* MISO register. Supports up to 8 1-bit inputs */
  reg [7:0] adc_spi_miso_reg = 8'b0;
  always @(posedge wb_clk_i) begin
    adc_spi_miso_reg[G_NUM_SDATA_LINES - 1 : 0] <= adc_spi_miso;
  end

  /* ADC0 3-Wire Register */
  reg [31:0] adc_spi_reg;
  reg [31:0] adc_spi_cs_reg;
  assign adc_spi_wire = adc_spi_reg;
  assign adc_spi_cs_wire = adc_spi_cs_reg[G_NUM_CS_LINES-1:0];

  /* ======================================= */
  /* ADC0 SPI Register (word 0)              */
  /* ======================================= */
  /* ZZ = ZDOK Pinout Revision               */
  /* LL = Clock locked bits                  */
  /* NNNN = Number of ADC chips supported    */
  /* RR = ROACH2 revision expected/required  */
  /* C = SCLK                                */
  /* D = SDATA MOSI                          */
  /* X = SDATA MISO (read only)              */
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
  /* ---- ---- ---- ---- ---- ---- XXXX XXXX */
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

  /* ======================================= */
  /* ADC0 3-Wire Register (word 1)           */
  /* ======================================= */
  /* Chip Selects for up to 32 ADCs          */
  /* ======================================= */
  /* |<-- MSb                       LSb -->| */
  /* 0000_0000_0011_1111_1111_2222_2222_2233 */
  /* 0123_4567_8901_2345_6789_0123_4567_8901 */
  /* 5432 10ZY XWVU TSRQ PONM LKJI HGFE DCBA */
  /* |                   |                 | */
  /* chip_sel_31    chip_sel_15   chip_sel_0 */
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
    assign adc_spi_sclk[i]  =  adc_spi_wire[9];
  end
  endgenerate

  generate
  for (i=0; i<G_NUM_SDATA_LINES; i=i+1) begin : gen_mosi
    assign adc_spi_mosi[i] =  adc_spi_wire[8];
  end
  endgenerate

  assign adc_spi_cs =  adc_spi_cs_wire;

  /* ADC0 Control Register */
  reg [31:0] adc_ctrl_reg;
  assign adc_ctrl_wire = adc_ctrl_reg;

  /* ======================================= */
  /* ADC0 Control Register (word 2)          */
  /* ======================================= */
  /* W  = Demux write-enable                 */
  /* MM = Demux mode                         */ 
  /* R  = Reset                              */
  /* S  = Snap Request                       */
  /* B  = ISERDES Chip Select                */
  /* X  = ISERDES Lane Select                */
  /* L  = bit slip strobe                    */
  /* D  = ISERDES delay strobe               */
  /* T  = Delay Tap                          */
  /* ======================================= */
  /* |<-- MSb                       LSb -->| */
  /* 0000 0000 0011 1111 1111 2222 2222 2233 */
  /* 0123 4567 8901 2345 6789 0123 4567 8901 */
  /* ---- -WMM ---- ---- ---- ---- ---- ---- */
  /* ---- ---- R--- ---- ---- ---- ---- ---- */
  /* ---- ---- -S-- ---- ---- ---- ---- ---- */
  /* ---- ---- ---- BBBB BXXX ---- ---- ---- */
  /* ---- ---- ---- ---- ---- ---T TTTT TTTT */
  /* ---- ---- ---- ---- ---- L--- ---- ---- */
  /* ---- ---- ---- ---- ---- -D-- ---- ---- */
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

  assign adc_demux_mode      = adc_ctrl_wire[25:24];
  assign adc_reset           = adc_ctrl_wire[23  ];
  assign adc_snap_req        = adc_ctrl_wire[22  ];
  assign adc_delay_tap       = adc_ctrl_wire[8:0 ];
  wire [4:0] adc_iserdes_bitslip_chip_sel = adc_ctrl_wire[19:15];
  wire [2:0] adc_iserdes_bitslip_lane_sel = adc_ctrl_wire[14:12];
  wire adc_delay_strb   = adc_ctrl_wire[10];
  wire adc_bitslip_strb = adc_ctrl_wire[11];

  function onehot_encode;
    input adc_val, adc_lane, strobe;
    reg [G_NUM_UNITS*8 - 1 : 0] v = 0;
    begin
      v[(adc_val << 3) + adc_lane] = strobe;
      onehot_encode = v;
    end
  endfunction

  assign adc_delay_rst = onehot_encode(adc_iserdes_bitslip_chip_sel, adc_iserdes_bitslip_lane_sel, adc_delay_strb);
  assign adc_iserdes_bitslip = onehot_encode(adc_iserdes_bitslip_chip_sel, adc_iserdes_bitslip_lane_sel, adc_bitslip_strb);

  /* OPB interface logic */

  reg [31:0] wb_data_out_reg;

  always @(posedge wb_clk_i) begin
    wb_ack <= 1'b0;

    adc_spi_reg <= adc_spi_reg;
    adc_spi_cs_reg <= adc_spi_cs_reg;
    adc_ctrl_reg <= adc_ctrl_reg;
    
    if (wb_rst_i) begin
    end else begin
      if (wb_stb_i && wb_cyc_i && !wb_ack) begin
        if (wb_we_i) begin
          case (opb_addr[3:2])
           0:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    // read-only
                    //adc_spi_reg[7:0] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    adc_spi_reg[15:8] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    adc_spi_reg[23:16] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    adc_spi_reg[31:24] <= wb_dat_i[31:24];
                end
           end
           1:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    adc_spi_cs_reg[7:0] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    adc_spi_cs_reg[15:8] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    adc_spi_cs_reg[23:16] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    adc_spi_cs_reg[31:24] <= wb_dat_i[31:24];
                end
           end
           2:  begin
                wb_ack <= 1'b1;
                if (wb_sel_i[0]) begin
                    adc_ctrl_reg[7:0] <= wb_dat_i[7:0];
                end
                if (wb_sel_i[1]) begin
                    adc_ctrl_reg[15:8] <= wb_dat_i[15:8];
                end
                if (wb_sel_i[2]) begin
                    adc_ctrl_reg[23:16] <= wb_dat_i[23:16];
                end
                if (wb_sel_i[3]) begin
                    /* All but the W and MM bits */
                    adc_ctrl_reg[31:27] <= wb_dat_i[31:27];
                    if (wb_dat_i[26]) begin
                        adc_ctrl_reg[25:24] <= wb_dat_i[25:24];
                    end
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
                   wb_data_out_reg[25:24] <= adc_locked;
                   wb_data_out_reg[23:20] <= G_NUM_UNITS;
                   wb_data_out_reg[19:18] <= CONTROLLER_REV;
                   wb_data_out_reg[17:16] <= G_ROACH2_REV;
                   wb_data_out_reg[15:0 ] <= adc_spi_reg[15:8];
                   wb_data_out_reg[ 7:0 ] <= adc_spi_miso_reg[7:0];
               end
           2:  begin
                   wb_ack <= 1'b1;
                   wb_data_out_reg <= adc_ctrl_reg;
               end
          endcase
        end
      end
    end


  end

  assign wb_dat_o     = wb_ack_o ? wb_data_out_reg : 32'b0;
  assign wb_err_o   = 1'b0;
  assign wb_ack_o  = wb_ack;

endmodule


