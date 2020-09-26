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
  wire [4*2*G_NUM_UNITS - 1:0] din;
  wire [4*2*G_NUM_UNITS - 1:0] din_rise;
  wire [4*2*G_NUM_UNITS - 1:0] din_fall;
  wire fclk_rise;
  wire fclk_fall;

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

  reg [4*2*G_NUM_UNITS : 0] delay_loadR;
  wire [4*2*G_NUM_UNITS : 0] delay_load_strobe = delay_load & ~delay_loadR;
  always @(posedge delay_clk) begin
    delay_loadR <= delay_load;
  end

  wire [4*2*G_NUM_UNITS - 1:0] din_delayed;
  wire fclk_delayed;
  IDELAYE3 #(
    .DELAY_TYPE("VAR_LOAD"),
    .DELAY_FORMAT("TIME"),
    .UPDATE_MODE("ASYNC"),
    .REFCLK_FREQUENCY (200.0)
  ) iodelay_in [ 4*2*G_NUM_UNITS : 0] (
    .CLK     (delay_clk),
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

  // deal with data DDR
  IDDRE1 #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
  ) data_iddr_inst [4*2*G_NUM_UNITS - 1:0] (
    .C(lclk),
    .CB(~lclk),
    .D(din_delayed),
    .R(1'b0),
    .Q1(din_rise),
    .Q2(din_fall)
  );

  IDDRE1 #(
    .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
  ) fclk_iddr_inst (
    .C(lclk),
    .CB(~lclk),
    .D(fclk_delayed),
    .R(1'b0),
    .Q1(fclk_rise),
    .Q2(fclk_fall)
  );


  wire rst_lclk;
  reg fclk_riseR;
  wire start_of_word = fclk_rise & ~fclk_riseR;
  reg [3:0] bufr_rst_sr;
  always @(posedge lclk) begin
    fclk_riseR <= fclk_rise;
    bufr_rst_sr <= {bufr_rst_sr[2:0], start_of_word};
  end
    
  reg rst_stable;
  wire sclk_div2;
  // From UG572:
  // When CLR is deasserted,
  // O transtitions to high on next
  // Enabled I
  BUFGCE_DIV #(
    .BUFGCE_DIVIDE(5)
  ) clkout_bufg(
    .I(lclk),
    .O(sclk_div2),
    .CE(1'b1),
    .CLR(bufr_rst_sr[3]) // ?? CHECK: Is this offset by 1 lclk or 2?
  );


  generate
  if (IS_MASTER) begin
    // Generate output clock
    wire sclk_mmcm;
    wire sclk_fb_out;
    wire sclk_fb;
    MMCME3_BASE #(
      .BANDWIDTH("OPTIMIZED"),
      .DIVCLK_DIVIDE(1),
      .CLKFBOUT_MULT_F(8.000),
      .CLKOUT0_DIVIDE_F(4.0),
      .CLKOUT1_DIVIDE(8),
      .CLKIN1_PERIOD(10.000)
    ) mmcm_inst (
      .CLKIN1(sclk_div2),   // fs/2
      .RST(rst),
      .CLKOUT0(sclk_mmcm),  // fs
      .CLKFBOUT(sclk_fb_out),
      .CLKFBIN(sclk_fb),
      .LOCKED(),
      .PWRDWN(1'b0)
    );

  BUFG clk_out_buf[1:0] (
    .I({sclk_mmcm, sclk_fb_out}),
    .O({clk_out, sclk_fb})
  );
  end else begin
    assign clk_out = 1'b0;
  end
  endgenerate
  

  // Deserializers
  //wire [10*4*G_NUM_UNITS - 1:0] dout_int;
  //reg  [10*4*G_NUM_UNITS - 1:0] dout_cdc;
  reg syncR;
  reg syncRR;
  reg fifo_we;
  always @(posedge sclk_div2) begin
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
  always @(posedge sclk) begin
    if (rst) begin
      fifo_re_sr <= 11'b0;
    end else begin
      fifo_re_sr <= {fifo_re_sr[9:0], syncR & ~syncRR};
    end
  end
  ads5296_unit adc_unit_inst[4*G_NUM_UNITS - 1:0] (
    .lclk(lclk),
    .fclk_rise(fclk_rise),
    .fclk_fall(fclk_fall),
    .din_rise(din_rise),
    .din_fall(din_fall),

    .sclk_div2(sclk_div2),
    .wr_en(fifo_we),
    .rst(rst),

    .sclk(sclk),
    .rd_en(fifo_re),
    .dout(dout)
  );

endmodule
