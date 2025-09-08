// (C) 2001-2025 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files from any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera IP License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


`timescale 1 ps / 1 ps

module seq_scc_reg_file (
	clock,
	data,
	rdaddress,
	wraddress,
	wren,
	q);

	parameter WIDTH = 32;
	parameter DEPTH = 6;

	input	  clock;
	input	[WIDTH-1:0]  data;
	input	[DEPTH-1:0]  rdaddress;
	input	[DEPTH-1:0]  wraddress;
	input	  wren;
	output	[WIDTH-1:0]  q;

	wire [WIDTH-1:0] sub_wire0;
	wire [WIDTH-1:0] q = sub_wire0[WIDTH-1:0];

`ifdef ALTDPRAM
	altdpram	altdpram_component (
				.data (data),
				.outclock (clock),
				.rdaddress (rdaddress),
				.wren (wren),
				.inclock (clock),
				.wraddress (wraddress),
				.q (sub_wire0),
				.aclr (1'b0),
				.byteena (1'b1),
				.inclocken (1'b1),
				.outclocken (1'b1),
				.rdaddressstall (1'b0),
				.rden (1'b1),
				.wraddressstall (1'b0));
	defparam
		altdpram_component.indata_aclr = "OFF",
		altdpram_component.indata_reg = "INCLOCK",
		altdpram_component.intended_device_family = "Stratix IV",
		altdpram_component.lpm_type = "altdpram",
		altdpram_component.outdata_aclr = "OFF",
		altdpram_component.outdata_reg = "UNREGISTERED",
		altdpram_component.ram_block_type = "MLAB",
		altdpram_component.rdaddress_aclr = "OFF",
		altdpram_component.rdaddress_reg = "UNREGISTERED",
		altdpram_component.rdcontrol_aclr = "OFF",
		altdpram_component.rdcontrol_reg = "UNREGISTERED",
		altdpram_component.width = WIDTH,
		altdpram_component.widthad = DEPTH,
		altdpram_component.width_byteena = 1,
		altdpram_component.wraddress_aclr = "OFF",
		altdpram_component.wraddress_reg = "INCLOCK",
		altdpram_component.wrcontrol_aclr = "OFF",
		altdpram_component.wrcontrol_reg = "INCLOCK";
`else
        alt_mem_ddrx_buffer                                                 
        # (                                                                 
            .ADDR_WIDTH                         (DEPTH),
            .DATA_WIDTH                         (WIDTH) 
        )                                                                   
        altdpram_component                                              
        (                                                                   
            // port list                                                    
            .ctl_clk                            (clock),
            .ctl_reset_n                        (1'b1),
                                                                            
            // write interface                                              
            .write_valid                        (wren),
            .write_address                      (wraddress),
            .write_data                         (data),
                                                                            
            // read interface                                               
            .read_valid                         (1'b1),
            .read_address                       (rdaddress),
            .read_data                          (sub_wire0)
        );
`endif // ALTDPRAM

endmodule
