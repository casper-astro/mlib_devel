module infrastructure(
    sys_clk_n, sys_clk_p,
    sys_clk, sys_clk90, sys_clk180, sys_clk270,
    dly_clk_n,  dly_clk_p,
    dly_clk,
    epb_clk_buf,
    epb_clk,
    idelay_rst, idelay_rdy,
    aux_clk_0_n, aux_clk_0_p,
    aux_clk_0,
    aux_clk_1_n, aux_clk_1_p,
    aux_clk_1
  );
  input  sys_clk_n, sys_clk_p;
  output sys_clk, sys_clk90, sys_clk180, sys_clk270;
  input  dly_clk_n, dly_clk_p;
  output dly_clk;
  input  epb_clk_buf;
  output epb_clk;
  input  aux_clk_0_n, aux_clk_0_p;
  output aux_clk_0;
  input  aux_clk_1_n, aux_clk_1_p;
  output aux_clk_1;

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

  /* other clocks */

  wire [2:0] bufg_int;

  wire sys_clk_int;

  IBUFGDS #(
    .IOSTANDARD("LVDS_25"),
    .DIFF_TERM("TRUE")
  ) ibufgd_arr [2:0](
    .I ({sys_clk_p, aux_clk_1_p, aux_clk_0_p}),
    .IB({sys_clk_n, aux_clk_1_n, aux_clk_0_n}),
    .O ({sys_clk_int, aux_clk_1, aux_clk_0})
  );

  wire sys_clk_dcm, sys_clk90_dcm, sys_clk180_dcm, sys_clk270_dcm;
  DCM_BASE #(
    .CLKIN_PERIOD(10.0)
  ) DCM_BASE_inst (
    .CLK0(sys_clk_dcm),
    .CLK180(sys_clk180_dcm),
    .CLK270(sys_clk270_dcm),
    .CLK2X(),
    .CLK2X180(),
    .CLK90(sys_clk90_dcm),
    .CLKDV(),
    .CLKFX(),
    .CLKFX180(),
    .LOCKED(),
    .CLKFB(sys_clk),
    .CLKIN(sys_clk_int),
    .RST(1'b0)
  );

  BUFG bufg_sys_clk[3:0](
    .I({sys_clk_dcm, sys_clk90_dcm, sys_clk180_dcm, sys_clk270_dcm}),
    .O({sys_clk,     sys_clk90,     sys_clk180,     sys_clk270})
  );

  /******** Delay Clock *********/
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
    .REFCLK(dly_clk),
    .RST(idelay_rst),
    .RDY(idelay_rdy)
  );


endmodule
