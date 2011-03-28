module epb_infrastructure(
    epb_data_buf,
    epb_data_oe_n_i,
    epb_data_out_i,
    epb_data_in_o
  );
  inout  [31:0] epb_data_buf;
  input  epb_data_oe_n_i;
  input  [31:0] epb_data_out_i;
  output [31:0] epb_data_in_o;

  IOBUF iob_data[31:0](
    .O (epb_data_in_o),
    .IO(epb_data_buf),
    .I (epb_data_out_i),
    .T (epb_data_oe_n_i)
  );

endmodule
