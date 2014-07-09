module v5_sysmon(
    input  clk,
    input  reset,

    input  drp_den,
    input  drp_dwe,
    input   [6:0] drp_daddr,
    input  [15:0] drp_datai,
    output [15:0] drp_datao,
    output drp_drdy, 

    output port_busy
  );

  wire over_temperature;
  wire alarm_temp, alarm_vccint, alarm_vccaux;

  wire jtag_busy;
  wire jtag_lock;

  SYSMON #(
    .INIT_40(16'h3000), // Configuration register 0
    .INIT_41(16'h2000), // Configuration register 1
    .INIT_42(16'h1000), // Configuration register 2
    .INIT_43(16'h0), // Test register 0
    .INIT_44(16'h0), // Test register 1
    .INIT_45(16'h0), // Test register 2
    .INIT_46(16'h0), // Test register 3
    .INIT_47(16'h0), // Test register 4
    .INIT_48(16'b0011_1111_0000_0001), // Sequence register 0
    .INIT_49(16'b0000_0000_0000_0000), // Sequence register 1
    .INIT_4A(16'b0011_1111_0000_0000), // Sequence register 2
    .INIT_4B(16'b0000_0000_0000_0000), // Sequence register 3
    .INIT_4C(16'h0), // Sequence register 4
    .INIT_4D(16'h0), // Sequence register 5
    .INIT_4E(16'h0), // Sequence register 6
    .INIT_4F(16'h0), // Sequence register 7
    .INIT_50(16'h0), // Alarm limit register 0
    .INIT_51(16'h0), // Alarm limit register 1
    .INIT_52(16'hE000), // Alarm limit register 2
    .INIT_53(16'h0), // Alarm limit register 3
    .INIT_54(16'h0), // Alarm limit register 4
    .INIT_55(16'h0), // Alarm limit register 5
    .INIT_56(16'hCAAA), // Alarm limit register 6
    .INIT_57(16'h0), // Alarm limit register 7
    .SIM_MONITOR_FILE("") // Simulation analog entry file
  ) SYSMON_inst (
    .ALM     ({alarm_temp, alarm_vccint, alarm_vccaux}), // 3-bit output for temp, Vccint and Vccaux
    .OT      ({over_temperature}),                       // 1-bit output over temperature alarm

    .BUSY    (),   // 1-bit output ADC busy signal
    .CHANNEL (),   // 5-bit output channel selection
    .EOC     (),   // 1-bit output end of conversion
    .EOS     (),   // 1-bit output end of sequence

    .DCLK  (clk),         // 1-bit input clock for dynamic reconfig
    .DEN   (drp_den),     // 1-bit input enable for dynamic reconfig
    .DWE   (drp_dwe),     // 1-bit input write enable for dynamic reconfig
    .DADDR (drp_daddr),   // 7-bit input address bus for dynamic reconfig
    .DI    (drp_datai),   // 16-bit input data bus for dynamic reconfig
    .DO    (drp_datao),   // 16-bit output data bus for dynamic reconfig
    .DRDY  (drp_drdy),    // 1-bit output data ready for dynamic reconfig
    .RESET (reset),       // 1-bit input active high reset

    .JTAGBUSY     (jtag_busy),  // 1-bit output JTAG DRP busy
    .JTAGLOCKED   (jtag_lock),  // 1-bit output DRP port lock
    .JTAGMODIFIED (),           // 1-bit output JTAG write to DRP

    .CONVST    (1'b0), // 1-bit input convert start
    .CONVSTCLK (1'b0), // 1-bit input convert start clock

    .VAUXN (16'b0),     // 16-bit input N-side auxiliary analog input
    .VAUXP (16'b0),     // 16-bit input P-side auxiliary analog input

    .VN (1'b0),           // 1-bit input N-side analog input
    .VP (1'b0)            // 1-bit input P-side analog input
  );

  assign port_busy = jtag_busy || jtag_lock;

endmodule

