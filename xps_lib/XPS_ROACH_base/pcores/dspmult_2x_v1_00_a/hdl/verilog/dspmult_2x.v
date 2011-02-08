module dspmult_2x (
    /* clock inputs */

    // Main simulink clock
    input             app_clk,
    // DSP clock (2x app clock)
    input             dsp_clk,

    /* Multiplier inputs */
    input       [24:0] in0_25b, 
    input       [17:0] in0_18b, 
    input       [24:0] in1_25b, 
    input       [17:0] in1_18b, 

    /* Multiplier outputs */
    output      [42:0] out0,
    output      [42:0] out1
  );

  // Register the inputs in the slow clock domain
  reg [24:0] in0_25b_reg;
  reg [18:0] in0_18b_reg;
  reg [24:0] in1_25b_reg;
  reg [18:0] in1_18b_reg;
  always @(posedge app_clk) begin
    in0_25b_reg <= in0_25b;
    in0_18b_reg <= in0_18b;
    in1_25b_reg <= in1_25b;
    in1_18b_reg <= in1_18b;
  end

  // Make the multiplexer input select
  reg mux_sel;
  always @(posedge dsp_clk) begin
    mux_sel <= mux_sel+1;
  end

  // Instantiate the multiplexers
  wire [24:0] mux_out_25b;
  wire [17:0] mux_out_18b;
  
  assign mux_out_25b = mux_sel ? in1_25b_reg : in0_25b_reg;
  assign mux_out_18b = mux_sel ? in1_18b_reg : in0_18b_reg;

  // Instantiate the DSP module
  wire [42:0] pout;
  dsp48_macro dsp48_inst (
    .clk (dsp_clk),
    .a   (mux_out_25b),
    .b   (mux_out_18b),
    .p   (pout)
  );

  // DSP block pipelines at 4 stages at 2x app clock rate.
  // Latency is two app_clk's
  // Shift the two products relative to each other by half an app_clk cycle
  
  reg [42:0] pout_z;
  always @(posedge dsp_clk) begin
    pout_z <= pout;
  end

  // Bring the products back into the app_clk domain
  reg [42:0] out0_reg;
  reg [42:0] out1_reg;
  always @(posedge app_clk) begin
    out0_reg <= pout_z;
    out1_reg <= pout;
  end

  assign out0 = out0_reg;
  assign out1 = out1_reg;

endmodule
