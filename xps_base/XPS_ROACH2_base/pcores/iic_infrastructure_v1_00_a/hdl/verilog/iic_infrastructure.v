module iic_infrastructure(
    output Sda_I,
    input  Sda_O,
    input  Sda_T,
    output Scl_I,
    input  Scl_O,
    input  Scl_T,
    inout  Sda,
    inout  Scl
  );
  IOBUF iobuf_sda(
    .O (Sda_I),
    .IO(Sda),
    .I (Sda_O),
    .T (Sda_T)
  );
  IOBUF iobuf_scl(
    .O (Scl_I),
    .IO(Scl),
    .I (Scl_O),
    .T (Scl_T)
  );
endmodule
