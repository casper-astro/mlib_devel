module i2c_infrastructure(
	// I2C I/O/T signals 
	input  scl_pad_i,
	output scl_pad_o,
	input scl_padoen_i,
	input  sda_pad_i,
	output sda_pad_o,
	input sda_padoen_i,

    // Tristate IOs
    inout scl_io,
    inout sda_io
    );

    IOBUF scl_iobuf_inst (
        .I(scl_pad_i),
        .O(scl_pad_o),
        .T(scl_padoen_i),
        .IO(scl_io)
    );

    IOBUF sda_iobuf_inst (
        .I(sda_pad_i),
        .O(sda_pad_o),
        .T(sda_padoen_i),
        .IO(sda_io)
    );
endmodule
