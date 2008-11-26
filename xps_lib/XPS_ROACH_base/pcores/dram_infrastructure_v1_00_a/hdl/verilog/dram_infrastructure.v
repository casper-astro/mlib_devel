module dram_infrastructure(
    reset,
    clk_in, //200MHz
    clk_in_locked,
    dram_clk_0, dram_clk_90, dram_clk_div,
    dram_rst_0, dram_rst_90, dram_rst_div,
    usr_rst, usr_clk
  );
  parameter CLK_FREQ = 266;
  input  reset, clk_in, clk_in_locked;
  output dram_clk_0, dram_clk_90, dram_clk_div;
  output dram_rst_0, dram_rst_90, dram_rst_div;
  input  usr_rst, usr_clk;

  /************ Generate DDR2 Clock ****************/
  wire mem_clk;
  wire mem_clk_lock;

  localparam FX_MULT = CLK_FREQ == 150 ?  3 :
                       CLK_FREQ == 200 ?  2 :
                       CLK_FREQ == 266 ?  8 :
                       CLK_FREQ == 333 ? 10 :
                                          8;

  localparam FX_DIV  = CLK_FREQ == 150 ? 4 :
                       CLK_FREQ == 200 ? 2 :
                       CLK_FREQ == 266 ? 6 :
                       CLK_FREQ == 333 ? 6 :
                                         6;

  localparam CLK_PERIOD = CLK_FREQ == 150 ? 6666 :
                          CLK_FREQ == 200 ? 5000 :
                          CLK_FREQ == 266 ? 3760 :
                          CLK_FREQ == 333 ? 3003 :
                                            3760;


  wire fb_clk;
  DCM_BASE #(
    .CLKFX_DIVIDE(FX_DIV),
    .CLKFX_MULTIPLY(FX_MULT),
    .CLKIN_PERIOD(5.0),
    .DFS_FREQUENCY_MODE("HIGH"),
    .DLL_FREQUENCY_MODE("HIGH")
  ) DCM_BASE_inst (
    .CLK0(fb_clk),
    .CLK180(),
    .CLK270(),
    .CLK2X(),
    .CLK2X180(),
    .CLK90(),
    .CLKDV(),
    .CLKFX(mem_clk),
    .CLKFX180(),
    .LOCKED(mem_clk_lock),
    .CLKFB(fb_clk),
    .CLKIN(clk_in),
    .RST(~clk_in_locked | reset)
  );

  /** Generate Phase Matched Controller Clocks **/
  wire pll_locked;

  wire pll_fb;

  wire dram_clk_0_int, dram_clk_90_int, dram_clk_div_int;
  PLL_BASE #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(3),
    .CLKFBOUT_PHASE(0.0),
    .CLKIN_PERIOD(CLK_PERIOD/1000),

    .CLKOUT0_DIVIDE(3),
    .CLKOUT0_DUTY_CYCLE(0.5),
    .CLKOUT0_PHASE(0.0),

    .CLKOUT1_DIVIDE(3),
    .CLKOUT1_DUTY_CYCLE(0.5),
    .CLKOUT1_PHASE(90),

    .CLKOUT2_DIVIDE(6),
    .CLKOUT2_DUTY_CYCLE(0.5),
    .CLKOUT2_PHASE(0),

    .COMPENSATION("SYSTEM_SYNCHRONOUS"),
    .DIVCLK_DIVIDE(1),
    .REF_JITTER(0.100),
    .RESET_ON_LOSS_OF_LOCK("FALSE")
  ) PLL_BASE_inst (
   .CLKFBOUT(pll_fb),
   .CLKOUT0(dram_clk_0_int),
   .CLKOUT1(dram_clk_90_int),
   .CLKOUT2(dram_clk_div_int),
   .CLKOUT3(),
   .CLKOUT4(),
   .CLKOUT5(),
   .LOCKED(pll_locked),
   .CLKFBIN(pll_fb),
   .CLKIN(mem_clk),
   .RST(reset | ~mem_clk_lock)
  );

  BUFG bufg_arr[2:0](
    .I({dram_clk_0_int, dram_clk_90_int, dram_clk_div_int}),
    .O({dram_clk_0, dram_clk_90, dram_clk_div})
  );



  /************ Generate User Resets ****************/

  reg [7:0] usr_rst_reg;

  wire usr_rst_int = usr_rst_reg[7];

  always @(posedge usr_clk) begin
    if (usr_rst | reset) begin
      usr_rst_reg <= 8'b1111_1111;
    end else begin
      usr_rst_reg <= usr_rst_reg << 1;
    end
  end

  wire reset_int = reset | usr_rst_int | ~pll_locked;

  reg [7:0] dram_rst_0_reg;
  assign dram_rst_0 = dram_rst_0_reg[7];
  
  always @(posedge dram_clk_0) begin
    if (reset_int) begin
      dram_rst_0_reg <= 8'b1111_1111;
    end else begin
      dram_rst_0_reg <= dram_rst_0_reg << 1;
    end
  end

  /************ Cross Domain Resets ****************/

  reg [7:0] dram_rst_90_reg;
  assign dram_rst_90 = dram_rst_90_reg[7];
  
  always @(posedge dram_clk_90) begin
    if (reset_int) begin
      dram_rst_90_reg <= 8'b1111_1111;
    end else begin
      dram_rst_90_reg <= dram_rst_90_reg << 1;
    end
  end

  reg [7:0] dram_rst_div_reg;
  assign dram_rst_div = dram_rst_div_reg[7];
  
  always @(posedge dram_clk_div) begin
    if (reset_int) begin
      dram_rst_div_reg <= 8'b1111_1111;
    end else begin
      dram_rst_div_reg <= dram_rst_div_reg << 1;
    end
  end

endmodule
