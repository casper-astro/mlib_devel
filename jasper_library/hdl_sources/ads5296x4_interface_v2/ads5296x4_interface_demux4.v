module ads5296x4_interface_v2 #(
    parameter G_NUM_UNITS = 4,
    parameter G_NUM_FCLKS = 4,
    parameter G_IS_MASTER = 1'b1
  )(
    input rst,
    input sync,
    // Line clocks
    input lclk_p,
    input lclk_n,
    // Frame clocks
    input [G_NUM_FCLKS - 1 : 0] fclk_p,
    input [G_NUM_FCLKS - 1 : 0] fclk_n,
    // If not a master -- use this clock
    input sclk,
    // Data inputs
    input [4*2*G_NUM_UNITS - 1:0] din_p,
    input [4*2*G_NUM_UNITS - 1:0] din_n,
    // Deserialized outputs
    output [10*4*G_NUM_UNITS - 1:0] dout,
    output clk_out,
    output sync_out,

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

  // Clocks
  wire lclk_int; // lclk single ended unbuffered
  wire [4 - 1 : 0] fclk;     // fclk data signal single ended
  wire lclk;     // lclk buffered
  wire lclk_d4;  // lclk buffered div by 2

  wire [31:0] fclk_err_cnt;
  wire iserdes_rst;
  wire mmcm_rst;
  reg [31:0] fclk0_ctr;
  reg [31:0] fclk1_ctr;
  reg [31:0] fclk2_ctr;
  reg [31:0] fclk3_ctr;
  reg [31:0] lclk_ctr;
  wb_ads5296_attach #( 
    .G_NUM_UNITS(G_NUM_UNITS),
    .G_NUM_FCLKS(1) // Only bother controlling 1 fclk
  ) wb_ads5296_attach_inst (
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
    .user_clk(lclk_d4),
    .lclk_cnt(lclk_ctr),
    .fclk0_cnt(fclk0_ctr),
    .fclk1_cnt(fclk1_ctr),
    .fclk2_cnt(fclk2_ctr),
    .fclk3_cnt(fclk3_ctr),
    .fclk_err_cnt(fclk_err_cnt),
    .delay_load(delay_load),
    .delay_rst(delay_rst),
    .delay_en_vtc(delay_en_vtc),
    .delay_val(delay_val),
    .iserdes_rst(iserdes_rst),
    .mmcm_rst(mmcm_rst)
  );

  // Buffer the differential inputs
  wire [4*2*G_NUM_UNITS - 1:0] din;
  wire [4*4*2*G_NUM_UNITS - 1:0] din4b;
  wire [8*4*2*G_NUM_UNITS - 1:0] din8b;
  wire [3:0] fclk4b;

  IBUFDS fclk_buf [G_NUM_FCLKS - 1 : 0] (
    .I(fclk_p),
    .IB(fclk_n),
    .O(fclk[G_NUM_FCLKS - 1 : 0])
  );
   
  generate
  if (G_NUM_FCLKS < 4) begin
    assign fclk[3] = 1'b0;
  end
  endgenerate
  
  generate
  if (G_NUM_FCLKS < 3) begin
    assign fclk[2] = 1'b0;
  end
  endgenerate
  
  generate
  if (G_NUM_FCLKS < 2) begin
    assign fclk[1] = 1'b0;
  end
  endgenerate 
   
  IBUFDS lclk_ibuf (
    .I(lclk_p),
    .IB(lclk_n),
    .O(lclk_int)
  );

  BUFG lclk_buf (
    .I(lclk_int),
    .O(lclk)
  );

  reg lclk_d4_rst = 1'b0;
  reg lclk_d4_rstR = 1'b0;
  BUFGCE_DIV #(
    .BUFGCE_DIVIDE(2)
  ) clkout_bufg(
    .I(lclk_int),
    .O(lclk_d4),
    .CE(1'b1),
    .CLR(lclk_d4_rstR)
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
    .IDATAIN ({fclk[0], din}),
    .CNTVALUEIN(delay_val),
    .CNTVALUEOUT(),
    .INC     (1'b0),
    .CE      (1'b0),
    .RST     (delay_rst),
    .DATAOUT ({fclk_delayed, din_delayed}),
    .EN_VTC(delay_en_vtc)
  );
  
  reg fclk_delayedR;
  reg iserdes_rst_reg = 1'b0;
  wire start_of_frame = fclk_delayed & ~fclk_delayedR;
  reg mmcm_rstR;
  reg mmcm_rstRR;
  // Only reset the MMCM using the mmcm_rst posedge, since once
  // reset is asserted, lclk_d4 stops, and mmcm_rst (which exits
  // the wishbone controller on the lclk_d4 domain) won't deassert
  wire mmcm_rst_posedge = mmcm_rstR & ~mmcm_rstRR;
  always @(posedge lclk) begin
    mmcm_rstR <= mmcm_rst; // mmcm_rst is on lclk_d4 domain
    mmcm_rstRR <= mmcm_rstR;
    fclk_delayedR <= fclk_delayed;
    lclk_d4_rstR <= lclk_d4_rst;
    // TODO: we can't assert mmcm_rst, because once high
    // lclk_d4 stops and start_of_frame never clears the reset?
    if (mmcm_rst_posedge) begin
      lclk_d4_rst <= 1'b1;
    end else if (start_of_frame) begin
      lclk_d4_rst <= 1'b0;
    end
    if (iserdes_rst) begin
      iserdes_rst_reg <= 1'b1;
    end else if (start_of_frame) begin
      iserdes_rst_reg <= 1'b0;
    end
  end
  
  always @(posedge fclk_delayed) begin
    fclk0_ctr <= fclk0_ctr + 1'b1;
  end
  always @(posedge fclk[1]) begin
    fclk1_ctr <= fclk1_ctr + 1'b1;
  end
  always @(posedge fclk[2]) begin
    fclk2_ctr <= fclk2_ctr + 1'b1;
  end
  always @(posedge fclk[3]) begin
    fclk3_ctr <= fclk3_ctr + 1'b1;
  end
  always @(posedge lclk) begin
    lclk_ctr <= lclk_ctr + 1'b1;
  end

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
    //.D(fclk),
    .Q(fclk4b),
    .RST(iserdes_rst_reg),
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
        //.D(din[i]),
        .Q(din8b[(i+1)*8 - 1 : i*8]),
        .RST(iserdes_rst_reg),
        .FIFO_RD_EN(1'b0),
        .FIFO_EMPTY()
      );
      assign din4b[(i+1)*4 - 1 : i*4] = din8b[(i+1)*8 - 4 - 1: i*8];
    end
  endgenerate


  generate
  if (G_IS_MASTER) begin
    // Generate output clock
    wire sclk_mmcm;
    wire sclk_fb_mmcm;
    wire sclk_fb;
    MMCME3_BASE #(
      .BANDWIDTH("OPTIMIZED"),
      .DIVCLK_DIVIDE(2),
      .CLKFBOUT_MULT_F(8.000),
      .CLKOUT0_DIVIDE_F(5.0),
      .CLKIN1_PERIOD(10.000)
    ) mmcm_inst (
      .CLKIN1(lclk_d4),   // 5*fs / 2 / 2
      .RST(mmcm_rst),
      .CLKOUT0(sclk_mmcm),  // fs
      .CLKFBOUT(sclk_fb_mmcm),
      .CLKFBIN(sclk_fb),
      .LOCKED(),
      .PWRDWN(1'b0)
    );

  BUFG clk_out_buf[1:0] (
    .I({sclk_mmcm, sclk_fb_mmcm}),
    .O({clk_out, sclk_fb})
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
  reg fifo_re_reg;
  wire fifo_re = fifo_re_sr[10];
  reg syncR_sclk;
  reg syncRR_sclk;
  always @(posedge sclk) begin
    syncR_sclk <= sync;
    syncRR_sclk <= syncR_sclk;
    if (rst) begin
      fifo_re_sr <= 11'b0;
    end else if ( ~fifo_re ) begin
      fifo_re_sr <= {fifo_re_sr[9:0], syncR_sclk & ~ syncRR_sclk};
    end
  end
  wire [32*4*G_NUM_UNITS - 1 : 0] fclk_err_cnt_multi;
  wire [4*G_NUM_UNITS - 1 : 0] sync_out_multi;
  assign fclk_err_cnt = fclk_err_cnt_multi[31:0];
  assign sync_out = sync_out_multi[0];
  ads5296_unit adc_unit_inst[4*G_NUM_UNITS - 1:0] (
    .lclk_d4(lclk_d4),
    .fclk4b(fclk4b),
    .fclk_err_cnt(fclk_err_cnt_multi),
    .din4b(din4b),
    .wr_en(fifo_we),
    .rst(rst),
    .sync(syncR & syncRR),

    .sclk(sclk),
    .rd_en(fifo_re),
    .dout(dout),
    .sync_out(sync_out_multi)
  );

endmodule
