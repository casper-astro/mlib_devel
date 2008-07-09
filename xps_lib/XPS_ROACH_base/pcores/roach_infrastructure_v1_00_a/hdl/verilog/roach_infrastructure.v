module roach_infrastructure(
    sys_clk_n, sys_clk_p,
    sys_clk,
    dly_clk_n, dly_clk_p,
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
  output sys_clk;
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

  wire epb_clk_int;

  IBUFG ibuf_epb(
    .I(epb_clk_buf),
    .O(epb_clk)
  );

//  BUFG bufg_epb(
//    .I(epb_clk_int), .O(epb_clk)
//  );

  IBUFGDS #(
    .IOSTANDARD("LVDS_25"),
    .DIFF_TERM("TRUE")
  ) ibufgd_arr [2:0](
    .I ({sys_clk_p, aux_clk_1_p, aux_clk_0_p}),
    .IB({sys_clk_n, aux_clk_1_n, aux_clk_0_n}),
    .O ({sys_clk,   aux_clk_1,   aux_clk_0})
  );

  wire dly_clk_int;
  IBUFGDS ibufds_dly_clk(
    .I (dly_clk_p),
    .IB(dly_clk_n),
    .O (dly_clk)
  );

//  BUFG bufg_inst(
//    .I(dly_clk_int),
//    .O(dly_clk)
//  );

  IDELAYCTRL idelayctrl_inst(
    .REFCLK(dly_clk),
    .RST(idelay_rst),
    .RDY(idelay_rdy)
  );


endmodule
