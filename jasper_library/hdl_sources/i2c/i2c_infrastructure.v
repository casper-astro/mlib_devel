module i2c_infrastructure(
	// I2C I/O/T signals 
	input  scl_pad_i,
	output scl_pad_o,
	output scl_padoen_o,
	input  sda_pad_i,
	output sda_pad_o,
	output sda_padoen_o,

    // Tristate IOs
    inout scl_io,
    inout sda_io
    );

    IOBUF scl_iobuf_inst (
        .I(scl_pad_o),
        .O(scl_pad_i),
        .T(scl_padoen_o),
        .IO(scl_io)
    );

    IOBUF sda_iobuf_inst (
        .I(sda_pad_o),
        .O(sda_pad_i),
        .T(sda_padoen_o),
        .IO(sda_io)
    );
endmodule
