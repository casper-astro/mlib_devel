module ddr3_clk #(
    parameter DRAM_FREQUENCY = 400,
    parameter CLKFBOUT_MULT_F = 12,
    parameter DIVCLK_DIVIDE   = 1,


    parameter CLKOUT0_DIVIDE_F = 3,
    parameter CLKOUT1_DIVIDE   = 6,
    parameter CLKOUT2_DIVIDE   = 3,
    parameter PERIOD	       = 10.00
 ) (
    input  clk_100,
    input  sys_rst,
    input  iodelay_ctrl_rdy,

    output clk_mem,            // 2x logic clock
    output clk_app,            // 1x logic clock
    output clk_rd_base,        // 2x base read clock

    output rstdiv0,            // Reset CLK and CLKDIV logic (incl I/O),

    input  PSEN,               // For enabling fine-phase shift
    input  PSINCDEC,           // = 1 increment phase shift, = 0
    output PSDONE
  );

  wire clk_mem_mmcm;
  wire clk_app_mmcm;
  wire clk_fb;

  MMCM_ADV #(
    .BANDWIDTH             ("OPTIMIZED"),
    .CLOCK_HOLD            ("FALSE"),
    .COMPENSATION          ("ZHOLD"),
    .REF_JITTER1           (0.005),
    .REF_JITTER2           (0.005),
    .STARTUP_WAIT          ("FALSE"),
    .CLKIN1_PERIOD         (PERIOD),
    .CLKIN2_PERIOD         (PERIOD),
    .CLKFBOUT_MULT_F       (CLKFBOUT_MULT_F),
    .DIVCLK_DIVIDE         (DIVCLK_DIVIDE),
    .CLKFBOUT_PHASE        (0.000),
    .CLKFBOUT_USE_FINE_PS  ("FALSE"),
    .CLKOUT0_DIVIDE_F      (CLKOUT0_DIVIDE_F),
    .CLKOUT0_DUTY_CYCLE    (0.500),
    .CLKOUT0_PHASE         (0.000),
    .CLKOUT0_USE_FINE_PS   ("FALSE"),
    .CLKOUT1_DIVIDE        (CLKOUT1_DIVIDE),
    .CLKOUT1_DUTY_CYCLE    (0.500),
    .CLKOUT1_PHASE         (0.000),
    .CLKOUT1_USE_FINE_PS   ("FALSE"),
    .CLKOUT2_DIVIDE        (CLKOUT2_DIVIDE),
    .CLKOUT2_DUTY_CYCLE    (0.500),
    .CLKOUT2_PHASE         (0.000),
    .CLKOUT2_USE_FINE_PS   ("TRUE"),
    .CLKOUT3_DIVIDE        (1),
    .CLKOUT3_DUTY_CYCLE    (0.500),
    .CLKOUT3_PHASE         (0.000),
    .CLKOUT3_USE_FINE_PS   ("FALSE"),
    .CLKOUT4_CASCADE       ("FALSE"),
    .CLKOUT4_DIVIDE        (1),
    .CLKOUT4_DUTY_CYCLE    (0.500),
    .CLKOUT4_PHASE         (0.000),
    .CLKOUT4_USE_FINE_PS   ("FALSE"),
    .CLKOUT5_DIVIDE        (1),
    .CLKOUT5_DUTY_CYCLE    (0.500),
    .CLKOUT5_PHASE         (0.000),
    .CLKOUT5_USE_FINE_PS   ("FALSE"),
    .CLKOUT6_DIVIDE        (1),
    .CLKOUT6_DUTY_CYCLE    (0.500),
    .CLKOUT6_PHASE         (0.000),
    .CLKOUT6_USE_FINE_PS   ("FALSE")
  ) u_mmcm_adv (
    .CLKFBOUT     (clk_fb),
    .CLKFBOUTB    (),
    .CLKFBSTOPPED (),
    .CLKINSTOPPED (),
    .CLKOUT0      (clk_mem_mmcm),
    .CLKOUT0B     (),
    .CLKOUT1      (clk_app_mmcm),
    .CLKOUT1B     (),
    .CLKOUT2      (clk_rd_base),
    .CLKOUT2B     (),
    .CLKOUT3      (),
    .CLKOUT3B     (),
    .CLKOUT4      (),
    .CLKOUT5      (),
    .CLKOUT6      (),
    .DO           (),
    .DRDY         (),
    .LOCKED       (pll_lock),
    .PSDONE       (PSDONE),
    .CLKFBIN      (clk_fb),
    .CLKIN1       (clk_100),
    .CLKIN2       (1'b0),
    .CLKINSEL     (1'b1),
    .DADDR        (7'b0000000),
    .DCLK         (1'b0),
    .DEN          (1'b0),
    .DI           (16'h0000),
    .DWE          (1'b0),
    .PSCLK        (clk_bufg),
    .PSEN         (PSEN),
    .PSINCDEC     (PSINCDEC),
    .PWRDWN       (1'b0),
    .RST          (sys_rst)
  );

  BUFG u_bufg_clk0 (
    .I (clk_mem_mmcm),
    .O (clk_mem)
  );

  BUFG u_bufg_clkdiv0 (
    .I (clk_app_mmcm),
    .O (clk_app)
  );

  assign clk_bufg = clk_app;

  //*****************************************************************
  // CLKDIV logic reset
  //*****************************************************************

  // Wait for MMCM and IDELAYCTRL to lock before releasing reset

  localparam RST_SYNC_NUM = 15;
  localparam RST_DIV_SYNC_NUM = (RST_SYNC_NUM+1)/2;

  reg [RST_DIV_SYNC_NUM-1:0] rstdiv0_sync_r;
  assign rst_tmp = sys_rst | ~pll_lock | ~iodelay_ctrl_rdy;

  always @(posedge clk_bufg or posedge rst_tmp)
    if (rst_tmp)
      rstdiv0_sync_r <= {RST_DIV_SYNC_NUM{1'b1}};
    else
      rstdiv0_sync_r <= rstdiv0_sync_r << 1;

  assign rstdiv0 = rstdiv0_sync_r[RST_DIV_SYNC_NUM-1];

endmodule
