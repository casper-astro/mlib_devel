module adc_reset(
  base_clk,
  reset_clk,
  system_reset,
  reset_output,
  delay_count,
  end_reset,
  adc0_view_reset,
  reset_start

  );
  
  // System Parameters
  parameter reset_time_delay = 32'h3;
  
  // Inputs and Outputs 
  //===================
  input base_clk;
  input reset_clk;
  input system_reset;
  
  output reset_output;
  output [31:0] delay_count;
  output end_reset;
  output adc0_view_reset;
  input reset_start;
  
  // Wires and Regs
  //===============
  reg reset_output;
  
  //wire [15:0] delay_count;
  //wire end_reset;
  //wire adc0_view_reset;
  
  // Module Declarations
  //====================
  //Counter delay_counter (
  //  .Clock(base_clk),
  //  .Reset(system_reset),
  //  .Set(),
  //  .Load(),
  //  .Enable(1'b1),
  //  .In(),
  //  .Count(delay_count)
  //);
  //defparam delay_counter.width = 32;
  //defparam delay_counter.limited = 1;
  //
  //assign reset_start = (delay_count == reset_time_delay);

  // Asynchronous reset register
  always @ (posedge base_clk or posedge end_reset or posedge system_reset) begin
    if (system_reset) begin
      reset_output <= 1'b0;
    end else if (end_reset) begin
      reset_output <= 1'b0;
    end else if (reset_start) begin
      reset_output <= 1'b1;
    end
  end
  
  Register delay_adc0_view_reset (
    .Clock(base_clk),
    .Reset(system_reset),
    .Set(),
    .Enable(1'b1),
    .In(reset_output),
    .Out(adc0_view_reset)
  );
  defparam delay_adc0_view_reset.width = 1;
  
  Register adc0_end_reset (
    .Clock(reset_clk),
    .Reset(system_reset),
    .Set(adc0_view_reset),
    .Enable(),
    .In(),
    .Out(end_reset)
  );
  defparam adc0_end_reset.width = 1;
endmodule
