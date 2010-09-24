module signal_invert(
    input  sig_in,
    output sig_out
  );
  assign sig_out = ~sig_in;
endmodule
