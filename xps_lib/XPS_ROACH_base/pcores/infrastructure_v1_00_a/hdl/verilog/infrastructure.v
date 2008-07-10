module infrastructure(
    mstr_clk_n, mstr_clk_p,
    mstr_clk,
    dly_clk_n,  dly_clk_p,
    dly_clk,
    epb_clk_buf,
    epb_clk, epb_clk90,
    idelay_rst, idelay_rdy,
    aux_clk_0_n, aux_clk_0_p,
    aux_clk_0,
    aux_clk_1_n, aux_clk_1_p,
    aux_clk_1
  );
  input  mstr_clk_n, mstr_clk_p;
  output mstr_clk;
  input  dly_clk_n, dly_clk_p;
  output dly_clk;
  input  epb_clk_buf;
  output epb_clk, epb_clk90;
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

  wire epb_clk_dcm, epb_clk90_dcm;
  DCM_BASE #(
    .CLKIN_PERIOD(10.0)
  ) DCM_BASE_inst (
    .CLK0(epb_clk_dcm),
    .CLK180(),
    .CLK270(),
    .CLK2X(),
    .CLK2X180(),
    .CLK90(epb_clk90_dcm),
    .CLKDV(),
    .CLKFX(),
    .CLKFX180(),
    .LOCKED(),
    .CLKFB(epb_clk),
    .CLKIN(epb_clk_ibuf),
    .RST(1'b0)
  );

  BUFG bufg_epb[1:0](
    .I({epb_clk_dcm, epb_clk90_dcm}), .O({epb_clk, epb_clk90})
  );

  /* other clocks */

  wire [2:0] bufg_int;

  IBUFGDS #(
    .IOSTANDARD("LVDS_25"),
    .DIFF_TERM("TRUE")
  ) ibufgd_arr [2:0](
    .I ({mstr_clk_p, aux_clk_1_p, aux_clk_0_p}),
    .IB({mstr_clk_n, aux_clk_1_n, aux_clk_0_n}),
    .O (bufg_int)
  );

  BUFG bufg_arr[2:0](
    .I(bufg_int), .O({mstr_clk, aux_clk_1, aux_clk_0})
  );

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
