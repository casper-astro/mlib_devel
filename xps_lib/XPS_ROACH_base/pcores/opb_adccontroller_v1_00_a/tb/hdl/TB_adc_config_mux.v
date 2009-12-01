`timescale 1ns/10ps

`define SIMLENGTH 20000
`define SYS_CLK_PERIOD 4

module TB_adc_config_mux();

  wire sys_rst;
  wire sys_clk;

  /***************** DUT ***************/

 adc_config_mux #(
    .INTERLEAVED (0)
  ) adc_config_mux_inst (
    .clk (sys_clk),
    .rst (sys_rst),
    .request (1'b0),
    .ddrb_i  (1'b0),
    .mode_i  (1'b0),

    .config_start_i (1'b0),
    .config_busy_o  (),
    .config_data_i  (1'b0),
    .config_addr_i  (1'b0),

    .ddrb_o      (),
    .dcm_reset_o (),
    .mode_o      (),
    .ctrl_clk_o  (),
    .ctrl_strb_o (),
    .ctrl_data_o ()
  );

  /****** System Signal generations ******/
  reg [31:0] sys_clk_counter;

  reg reset;
  assign sys_rst = reset;

  initial begin
    $dumpvars;
    sys_clk_counter <= 32'b0;

    reset <= 1'b1;
    #20
    reset <= 1'b0;
`ifdef DEBUG
    $display("sys: reset cleared");
`endif
    #`SIMLENGTH
    $display("PASSED");
    $finish;
  end

  assign sys_clk = sys_clk_counter < ((`SYS_CLK_PERIOD) / 2);

  always begin
    #1 sys_clk_counter <= (sys_clk_counter == `SYS_CLK_PERIOD - 1 ? 32'b0 : sys_clk_counter + 1);
  end

  
endmodule
