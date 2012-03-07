module epb_infrastructure(
    epb_data_buf,
    epb_data_oe_n_i,
    epb_data_out_i, epb_data_in_o,
    epb_oe_n_buf, epb_oe_n,
    epb_cs_n_buf, epb_cs_n,
    epb_r_w_n_buf, epb_r_w_n, 
    epb_be_n_buf, epb_be_n,
    epb_addr_buf, epb_addr,
    epb_addr_gp_buf, epb_addr_gp,
    epb_rdy_buf,
    epb_rdy,
    epb_rdy_oe
  );
  inout  [15:0] epb_data_buf;
  input  epb_data_oe_n_i;
  input  [15:0] epb_data_out_i;
  output [15:0] epb_data_in_o;
  input  epb_oe_n_buf;
  output epb_oe_n;
  input  epb_cs_n_buf;
  output epb_cs_n;
  input  epb_r_w_n_buf;
  output epb_r_w_n;
  input   [1:0] epb_be_n_buf;
  output  [1:0] epb_be_n;
  input  [22:0] epb_addr_buf;
  output [22:0] epb_addr;
  input   [5:0] epb_addr_gp_buf;
  output  [5:0] epb_addr_gp;

  output epb_rdy_buf;
  input  epb_rdy;
  input  epb_rdy_oe;

  IOBUF iob_data[15:0](
    .O (epb_data_in_o),
    .IO(epb_data_buf),
    .I (epb_data_out_i),
    .T (epb_data_oe_n_i)
  );

  IOBUF iob_epb_rdy(
    .O (),
    .IO(epb_rdy_buf),
    .I (epb_rdy),
    .T (!epb_rdy_oe)
  );

  assign epb_addr_gp = epb_addr_gp_buf;
  assign epb_addr    = epb_addr_buf;
  assign epb_be_n    = epb_be_n_buf;
  assign epb_r_w_n   = epb_r_w_n_buf;
  assign epb_cs_n    = epb_cs_n_buf;
  assign epb_oe_n    = epb_oe_n_buf;

/*
  IODELAY #(
    .IDELAY_TYPE("FIXED"),
    .IDELAY_VALUE(0),
    .ODELAY_VALUE(0)
  ) iodelay_inst [15:0] (
    .DATAOUT(epb_data_in_o),
    .DATAIN(epb_data_out_i),
    .IDATAIN(epb_data_buf),
    .ODATAIN(),
    .T(epb_data_oe_n_i),

    .C(1'b0),
    .CE(1'b0),
    .INC(1'b0),
    .RST(1'b0)
  );

  IODELAY #(
    .IDELAY_TYPE("FIXED"),
    .IDELAY_VALUE(0),
    .ODELAY_VALUE(0)
  ) idelay_inst [33:0] (
    .DATAOUT({epb_oe_n,     epb_cs_n,     epb_r_w_n,     epb_be_n,     epb_addr,     epb_addr_gp}),
    .DATAIN(),
    .IDATAIN({epb_oe_n_buf, epb_cs_n_buf, epb_r_w_n_buf, epb_be_n_buf, epb_addr_buf, epb_addr_gp_buf}),
    .ODATAIN(),
    .T(1'b1),

    .C(1'b0),
    .CE(1'b0),
    .INC(1'b0),
    .RST(1'b0)
  );
*/

endmodule
