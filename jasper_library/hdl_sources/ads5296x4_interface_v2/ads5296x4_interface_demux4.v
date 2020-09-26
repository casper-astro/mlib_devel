module ads5296x4_interface_v2 #(
    parameter G_NUM_UNITS = 4,
    parameter IS_MASTER = 1'b1
  )(
    input rst,
    input sync,
    // Line clocks
    input lclk_p,
    input lclk_n,
    // Frame clocks
    input fclk_p,
    input fclk_n,
    // If not a master -- use this clock
    input sclk,
    // Data inputs
    input [4*2*G_NUM_UNITS - 1:0] din_p,
    input [4*2*G_NUM_UNITS - 1:0] din_n,
    // Deserialized outputs
    output [10*4*G_NUM_UNITS - 1:0] dout,
    output clk_out,

    // Software register interface

    // Wishbone interface
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
    input         wb_stb_i
  );

  wire [4*2*G_NUM_UNITS + 1 - 1 : 0]  delay_load;
  wire [4*2*G_NUM_UNITS + 1 - 1 : 0]  delay_rst;
  wire [4*2*G_NUM_UNITS + 1 - 1 : 0] delay_en_vtc;
  wire [8 : 0] delay_val;

  wb_ads5296_attach wb_attach_inst (
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    .wb_dat_o(wb_dat_o),
    .wb_err_o(wb_err_o),
    .wb_ack_o(wb_ack_o),
    .wb_adr_i(wb_adr_i),
    .wb_sel_i(wb_sel_i),
    .wb_dat_i(wb_dat_i),
    .wb_we_i(wb_we_i),
    .wb_cyc_i(wb_cyc_i),
    .wb_stb_i(wb_stb_i),
    .delay_load(delay_load),
    .delay_rst(delay_rst),
    .delay_en_vtc(delay_en_vtc),
    .delay_val(delay_val)
  );

  // Buffer the differential inputs
  wire lclk_int;
  wire fclk;
  wire lclk;
  wire lclk_d4;
  wire [4*2*G_NUM_UNITS - 1:0] din;
  wire [4*4*2*G_NUM_UNITS - 1:0] din4b;
  wire [8*4*2*G_NUM_UNITS - 1:0] din8b;
  wire [3:0] fclk4b;

  IBUFDS fclk_buf (
    .I(fclk_p),
    .IB(fclk_n),
    .O(fclk)
  );
   
  IBUFDS lclk_ibuf (
    .I(lclk_p),
    .IB(lclk_n),
    .O(lclk_int)
  );

  BUFG lclk_buf (
    .I(lclk_int),
    .O(lclk)
  );

  BUFGCE_DIV #(
    .BUFGCE_DIVIDE(4)
  ) clkout_bufg(
    .I(lclk_int),
    .O(lclk_d4),
    .CE(1'b1),
    .CLR(1'b0)
  );

  IBUFDS din_buf[4*2*G_NUM_UNITS - 1:0] (
    .I(din_p),
    .IB(din_n),
    .O(din)
  );


  /*
   * To update:
   *   Wait for RDY to go high
   *   Write EN_VTC low
   *   Wait > 10 cycles
   *   write value to CNTVALUEIN
   *   wait 1 clock
   *   pulse LOAD high for 1 cycle
   */

  wire delay_clk = wb_clk_i;

  (* async_reg = "true" *) reg [4*2*G_NUM_UNITS : 0] delay_loadR;
  (* async_reg = "true" *) reg [4*2*G_NUM_UNITS : 0] delay_loadRR;
  (* async_reg = "true" *) reg [4*2*G_NUM_UNITS : 0] delay_loadRRR;

  wire [4*2*G_NUM_UNITS : 0] delay_load_strobe = delay_loadRR & ~delay_loadRRR;
  always @(posedge lclk_d4) begin
    delay_loadR <= delay_load;
    delay_loadRR <= delay_loadR;
    delay_loadRRR <= delay_loadRR;
  end

  wire [4*2*G_NUM_UNITS - 1:0] din_delayed;
  wire fclk_delayed;
  IDELAYE3 #(
    .DELAY_TYPE("VAR_LOAD"),
    .DELAY_FORMAT("TIME"),
    .UPDATE_MODE("ASYNC"),
    .DELAY_SRC("IDATAIN"),
    .DELAY_VALUE(1100),
    .CASCADE("NONE"),
    .SIM_DEVICE("ULTRASCALE"),
    .REFCLK_FREQUENCY(200.0)
  ) iodelay_in [ 4*2*G_NUM_UNITS : 0] (
    .CLK     (lclk_d4),
    .LOAD    (delay_load_strobe),
    .DATAIN  (1'b0),
    .IDATAIN ({fclk, din}),
    .CNTVALUEIN(delay_val),
    .CNTVALUEOUT(),
    .INC     (1'b0),
    .CE      (1'b0),
    .RST     (delay_rst),
    .DATAOUT ({fclk_delayed, din_delayed}),
    .EN_VTC(delay_en_vtc)
  );

  // Deserialize fclk and data
  // Don't use vector instances because we have
  // to deal with the fact that the ISERDES block
  // has an 8-bit Q output, meaning data need
  // some slicing.
  ISERDESE3 #(
    .DATA_WIDTH(4),
    .SIM_DEVICE("ULTRASCALE")
  ) iserdes_fclk (
    .CLK(lclk),
    .CLK_B(~lclk),
    .CLKDIV(lclk_d4),
    .D(fclk_delayed),
    .Q(fclk4b),
    .RST(1'b0),
    .FIFO_RD_EN(1'b0),
    .FIFO_EMPTY()
  );

  generate
    genvar i;
    for (i=0; i<4*2*G_NUM_UNITS; i=i+1) begin
      ISERDESE3 #(
        .DATA_WIDTH(4),
        .SIM_DEVICE("ULTRASCALE")
      ) iserdes_data (
        .CLK(lclk),
        .CLK_B(~lclk),
        .CLKDIV(lclk_d4),
        .D(din_delayed[i]),
        .Q(din8b[(i+1)*8 - 1 : i*8]),
        .RST(1'b0),
        .FIFO_RD_EN(1'b0),
        .FIFO_EMPTY()
      );
      assign din4b[(i+1)*4 - 1 : i*4] = din8b[(i+1)*8 - 4 - 1: i*8];
    end
  endgenerate


  generate
  if (IS_MASTER) begin
    // Generate output clock
    wire sclk_mmcm;
    wire sclk_fb;
    MMCME3_BASE #(
      .BANDWIDTH("OPTIMIZED"),
      .DIVCLK_DIVIDE(1),
      .CLKFBOUT_MULT_F(8.000),
      .CLKOUT0_DIVIDE_F(5.0),
      .CLKIN1_PERIOD(10.000)
    ) mmcm_inst (
      .CLKIN1(lclk_d4),   // 5*fs / 4 / 2
      .RST(rst),
      .CLKOUT0(sclk_mmcm),  // fs
      .CLKFBOUT(sclk_fb),
      .CLKFBIN(sclk_fb),
      .LOCKED(),
      .PWRDWN(1'b0)
    );

  BUFG clk_out_buf (
    .I(sclk_mmcm),
    .O(clk_out)
  );
  end else begin
    assign clk_out = 1'b0;
  end
  endgenerate
  

  // Deserializers
  (* async_reg = "true" *) reg syncR;
  (* async_reg = "true" *) reg syncRR;
  reg fifo_we;
  always @(posedge lclk_d4) begin
    syncR <= sync;
    syncRR <= syncR;
    if (rst) begin
      fifo_we <= 1'b0;
    end else begin
      if (syncR & ~syncRR) begin
        fifo_we <= 1'b1;
      end
    end
  end

  reg [10:0] fifo_re_sr;
  wire fifo_re = fifo_re_sr[10];
  reg syncR_sclk;
  reg syncRR_sclk;
  always @(posedge sclk) begin
    syncR_sclk <= sync;
    syncRR_sclk <= syncR_sclk;
    if (rst) begin
      fifo_re_sr <= 11'b0;
    end else begin
      fifo_re_sr <= {fifo_re_sr[9:0], syncR_sclk & ~ syncRR_sclk};
    end
  end
  ads5296_unit adc_unit_inst[4*G_NUM_UNITS - 1:0] (
    .lclk_d4(lclk_d4),
    .fclk4b(fclk4b),
    .din4b(din4b),
    .wr_en(fifo_we),
    .rst(rst),

    .sclk(sclk),
    .rd_en(fifo_re),
    .dout(dout)
  );

endmodule
