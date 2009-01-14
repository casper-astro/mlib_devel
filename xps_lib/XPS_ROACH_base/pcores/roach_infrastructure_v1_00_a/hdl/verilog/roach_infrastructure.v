module roach_infrastructure(
    sys_clk_n, sys_clk_p,
    sys_clk, sys_clk90, sys_clk180, sys_clk270,
    dly_clk_n,  dly_clk_p,
    dly_clk,
    epb_clk_buf,
    epb_clk,
    idelay_rst, idelay_rdy,
    aux0_clk_n, aux0_clk_p,
    aux0_clk, aux0_clk90, aux0_clk180, aux0_clk270,
    aux1_clk_n, aux1_clk_p,
    aux1_clk, aux1_clk90, aux1_clk180, aux1_clk270,
    aux0_clk2x, aux0_clk2x90, aux0_clk2x180, aux0_clk2x270
  );
  input  sys_clk_n, sys_clk_p;
  output sys_clk, sys_clk90, sys_clk180, sys_clk270;
  input  dly_clk_n, dly_clk_p;
  output dly_clk;
  input  epb_clk_buf;
  output epb_clk;
  input  aux0_clk_n, aux0_clk_p;
  output aux0_clk, aux0_clk90, aux0_clk180, aux0_clk270;
  input  aux1_clk_n, aux1_clk_p;
  output aux1_clk, aux1_clk90, aux1_clk180, aux1_clk270;
  output aux0_clk2x, aux0_clk2x90, aux0_clk2x180, aux0_clk2x270;

  input  idelay_rst;
  output idelay_rdy;


  /* EPB Clk */
  wire epb_clk_ibuf;

  IBUF ibuf_epb(
    .I(epb_clk_buf),
    .O(epb_clk_ibuf)
  );

  BUFG bufg_epb(
    .I(epb_clk_ibuf), .O(epb_clk)
  );

  /* system clock */
  wire sys_clk_int;
  wire sysclk_dcm_locked;

  IBUFGDS #(
    .IOSTANDARD ("LVDS_25"),
    .DIFF_TERM  ("TRUE")
  ) ibufgd_sys (
    .I (sys_clk_p),
    .IB(sys_clk_n),
    .O (sys_clk_int)
  );

  wire sys_clk_dcm, sys_clk90_dcm;
  DCM_BASE #(
    .CLKIN_PERIOD   (10.0)
  ) SYSCLK_DCM (
    .CLKIN      (sys_clk_int),
    .CLK0       (sys_clk_dcm),
    .CLK180     (),
    .CLK270     (),
    .CLK2X      (),
    .CLK2X180   (),
    .CLK90      (sys_clk90_dcm),
    .CLKDV      (),
    .CLKFX      (),
    .CLKFX180   (),
    .LOCKED     (sysclk_dcm_locked),
    .CLKFB      (sys_clk),
    .RST        (1'b0)
  );

  BUFG bufg_sys_clk[1:0](
    .I({sys_clk_dcm, sys_clk90_dcm}),
    .O({sys_clk,     sys_clk90})
  );

  // rely on inference of Xilinx internal clock inversion structures down the line
  assign sys_clk180 = ~sys_clk;
  assign sys_clk270 = ~sys_clk90;

  /* Aux clocks */
  wire  aux0_clk_int;
  wire  aux1_clk_int;
  IBUFGDS #(
    .IOSTANDARD ("LVDS_25"),
    .DIFF_TERM  ("TRUE")
  ) ibufgd_aux_arr[1:0] (
    .I  ({aux0_clk_p,   aux1_clk_p}),
    .IB ({aux0_clk_n,   aux1_clk_n}),
    .O  ({aux0_clk_int, aux1_clk_int})
  );

  wire  aux0_clk_dcm;
  wire  aux0_clk90_dcm;
  wire  aux1_clk_dcm;
  wire  aux1_clk90_dcm;

  wire  aux0_clk_dcm_locked;
  wire  aux1_clk_dcm_locked;

  wire  aux0_clk2x_int;
  wire  aux0_clk2x_buf;
  wire  aux0_clk2x_dcm;
  wire  aux0_clk2x90_dcm;

  DCM_BASE #(
    .CLKIN_PERIOD       (5.0),
    .DLL_FREQUENCY_MODE ("HIGH")
  ) AUXCLK0_DCM (
    .CLKIN  (aux0_clk_int),
    .CLK0   (aux0_clk_dcm),
    .CLK90  (aux0_clk90_dcm),
    .CLK2X  (aux0_clk2x_int),
    .LOCKED (aux0_clk_dcm_locked),
    .CLKFB  (aux0_clk),
    .RST    (~sysclk_dcm_locked)
  );

  DCM_BASE #(
    .CLKIN_PERIOD       (5.0),
    .DLL_FREQUENCY_MODE ("HIGH")
  ) AUXCLK1_DCM (
    .CLKIN  (aux1_clk_int),
    .CLK0   (aux1_clk_dcm),
    .CLK90  (aux1_clk90_dcm),
    .LOCKED (aux1_clk_dcm_locked),
    .CLKFB  (aux1_clk),
    .RST    (~sysclk_dcm_locked)
  );

  DCM_BASE #(
    .CLKIN_PERIOD       (5.0),
    .DLL_FREQUENCY_MODE ("HIGH")
  ) AUXCLK0_2x_DCM (
    .CLKIN  (aux0_clk2x_buf),
    .CLK0   (aux0_clk2x_dcm),
    .CLK90  (aux0_clk2x90_dcm),
    .LOCKED (),
    .CLKFB  (aux0_clk2x),
    .RST    (~aux0_clk_dcm_locked)
  );


  BUFG bufg_aux_clk[3:0](
    .I({aux0_clk_dcm, aux0_clk90_dcm, aux1_clk_dcm, aux1_clk90_dcm}),
    .O({aux0_clk,     aux0_clk90,     aux1_clk,     aux1_clk90})
  );

  BUFG bufg_aux2_clk[2:0](
    .I({aux0_clk2x_int, aux0_clk2x_dcm, aux0_clk2x90_dcm}),
    .O({aux0_clk2x_buf, aux0_clk2x,     aux0_clk2x90})
  );

  // rely on inference of Xilinx internal clock inversion structures down the line
  assign aux0_clk180 = ~aux0_clk;
  assign aux0_clk270 = ~aux0_clk90;
  assign aux1_clk180 = ~aux1_clk;
  assign aux1_clk270 = ~aux1_clk90;

  assign aux0_clk2x180 = ~aux0_clk2x;
  assign aux0_clk2x270 = ~aux0_clk2x90;


  /* Delay Clock */
  wire dly_clk_int;
  IBUFDS ibufds_dly_clk(
    .I (dly_clk_p),
    .IB(dly_clk_n),
    .O (dly_clk_int)
  );

  BUFG bufg_inst(
    .I(dly_clk_int),
    .O(dly_clk)
  );

  IDELAYCTRL idelayctrl_inst(
    .REFCLK (dly_clk),
    .RST    (idelay_rst),
    .RDY    (idelay_rdy)
  );


endmodule
