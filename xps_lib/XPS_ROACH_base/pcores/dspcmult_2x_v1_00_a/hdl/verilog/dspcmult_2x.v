module dspcmult_2x (
    /* clock inputs */

    // Main simulink clock
    input             app_clk,
    // DSP clock (2x app clock)
    input             dsp_clk,

    /* Multiplier inputs */
    input       [17:0] in0a_r, 
    input       [17:0] in0a_i, 
    input       [17:0] in1a_r, 
    input       [17:0] in1a_i, 
    input       [17:0] in0b_r, 
    input       [17:0] in0b_i, 
    input       [17:0] in1b_r, 
    input       [17:0] in1b_i, 

    /* Multiplier outputs */
    output      [36:0] out0_r,
    output      [36:0] out0_i,
    output      [36:0] out1_r,
    output      [36:0] out1_i
  );

  // Register the inputs in the slow clock domain
  reg [17:0] in0a_r_reg; 
  reg [17:0] in0a_i_reg; 
  reg [17:0] in1a_r_reg; 
  reg [17:0] in1a_i_reg; 
  reg [17:0] in0b_r_reg; 
  reg [17:0] in0b_i_reg; 
  reg [17:0] in1b_r_reg; 
  reg [17:0] in1b_i_reg; 
  always @(posedge app_clk) begin
    in0a_r_reg <= in0a_r; 
    in0a_i_reg <= in0a_i; 
    in1a_r_reg <= in1a_r; 
    in1a_i_reg <= in1a_i; 
    in0b_r_reg <= in0b_r; 
    in0b_i_reg <= in0b_i; 
    in1b_r_reg <= in1b_r; 
    in1b_i_reg <= in1b_i; 
  end

  // Make the multiplexer input select
  reg mux_sel;
  always @(posedge dsp_clk) begin
    mux_sel <= mux_sel+1;
  end

  // Instantiate the multiplexers
  wire [17:0] mux_out_a_r;
  wire [17:0] mux_out_a_i;
  wire [17:0] mux_out_b_r;
  wire [17:0] mux_out_b_i;
  
  assign mux_out_a_r = mux_sel ? in1a_r_reg : in0a_r_reg;
  assign mux_out_a_i = mux_sel ? in1a_i_reg : in0a_i_reg;
  assign mux_out_b_r = mux_sel ? in1b_r_reg : in0b_r_reg;
  assign mux_out_b_i = mux_sel ? in1b_i_reg : in0b_i_reg;

  // Instantiate the DSP module
  // (a+ib) x (c-id) = (ac+bd)+i(bc-ad)
  // Instantiation template from virtex 5 libraries guide
  // Configuration from DSP48E guide (ug193)

  // Outputs
  wire [47:0] real_out;
  wire [47:0] imag_out;

  // DSP cascade wires
  wire [48:0] pcout_ac;
  wire [48:0] pcout_ad;

  DSP48E #(
    .ALUMODEREG(1),     // Pipeline ALUMODE input
    .CARRYINREG(1),     // Pipeline CARRYIN input
    .CARRYINSELREG(1),  // Pipeline CARRYINSEL input
    .MREG(1),           // Pipline multiplier
    .OPMODEREG(1),      // Pipeline OPMODE input
    .PREG(1),           // Pipline P output
    .AREG(2),           // A input pipeline
    .BREG(2)            // B input pipeline
  ) dsp_inst_ac (
    .A({ {12{mux_out_a_r[17]}}, mux_out_a_r }),    // real part of input a -- sign extend to 30 bits
    .B(mux_out_b_r),    // real part of input b
    .OPMODE(7'd5),      // Operation mode input
    .CARRYIN(1'b0),     // 1 bit carry input
    .CARRYINSEL(3'b0),  // 3-bit carry select input
    .ALUMODE(4'd0),     // 4 bit ALU mode input
    .PCOUT(pcout_ac)    // 48 bit cascade output
  );

  DSP48E #(
    .ALUMODEREG(1),     // Pipeline ALUMODE input
    .CARRYINREG(1),     // Pipeline CARRYIN input
    .CARRYINSELREG(1),  // Pipeline CARRYINSEL input
    .MREG(1),           // Pipline multiplier
    .OPMODEREG(1),      // Pipeline OPMODE input
    .PREG(1),           // Pipline P output
    .AREG(2),           // A input pipeline
    .BREG(2)            // B input pipeline
  ) dsp_inst_bd (
    .A({{12{mux_out_a_i[17]}}, mux_out_a_i}),    // imag part of input a -- sign extend to 30 bits
    .B(mux_out_b_i),    // imag part of input b
    .PCIN(pcout_ac),    // 48-bit cascade input
    .OPMODE(7'd21),      // Operation mode input
    .CARRYIN(1'b0),     // 1 bit carry input
    .CARRYINSEL(3'b0),  // 3-bit carry select input
    .ALUMODE(4'd3),     // 4 bit ALU mode input
    .P(real_out)        // 48 bit output
  );
  
  DSP48E #(
    .ALUMODEREG(1),     // Pipeline ALUMODE input
    .CARRYINREG(1),     // Pipeline CARRYIN input
    .CARRYINSELREG(1),  // Pipeline CARRYINSEL input
    .MREG(1),           // Pipline multiplier
    .OPMODEREG(1),      // Pipeline OPMODE input
    .PREG(1),           // Pipline P output
    .AREG(2),           // A input pipeline
    .BREG(2)            // B input pipeline
  ) dsp_inst_ad (
    .A({{12{mux_out_a_r[17]}}, mux_out_a_r}),    // real part of input a -- sign extend to 30 bits
    .B(mux_out_b_i),    // imag part of input b
    .OPMODE(7'd5),      // Operation mode input
    .CARRYIN(1'b0),     // 1 bit carry input
    .CARRYINSEL(3'b0),  // 3-bit carry select input
    .ALUMODE(4'd0),     // 4 bit ALU mode input
    .PCOUT(pcout_ad)    // 48 bit cascade output
  );

  DSP48E #(
    .ALUMODEREG(1),     // Pipeline ALUMODE input
    .CARRYINREG(1),     // Pipeline CARRYIN input
    .CARRYINSELREG(1),  // Pipeline CARRYINSEL input
    .MREG(1),           // Pipline multiplier
    .OPMODEREG(1),      // Pipeline OPMODE input
    .PREG(1),           // Pipline P output
    .AREG(2),           // A input pipeline
    .BREG(2)            // B input pipeline
  ) dsp_inst_bc (
    .A({{12{mux_out_a_i[17]}}, mux_out_a_i}),    // imag part of input a -- sign extend to 30 bits
    .B(mux_out_b_r),    // real part of input b
    .PCIN(pcout_ad),    // 48-bit cascade input
    .OPMODE(7'd21),      // Operation mode input
    .CARRYIN(1'b0),     // 1 bit carry input
    .CARRYINSEL(3'b0),  // 3-bit carry select input
    .ALUMODE(4'd0),     // 4 bit ALU mode input
    .P(imag_out)        // 48 bit output
  );

  // DSP block pipelines at 4 stages at 2x app clock rate.
  // Latency is two app_clk's
  // Shift the two results relative to each other by half an app_clk cycle
  // keep only 18*2+1 bits (37 bits)
  
  reg [36:0] real_z;
  reg [36:0] imag_z;
  always @(posedge dsp_clk) begin
    real_z <= real_out;
    imag_z <= imag_out;
  end

  // Bring the products back into the app_clk domain
  reg [36:0] out0_r_reg;
  reg [36:0] out0_i_reg;
  reg [36:0] out1_r_reg;
  reg [36:0] out1_i_reg;
  always @(posedge app_clk) begin
    out0_r_reg <= real_z;
    out0_i_reg <= imag_z;
    out0_r_reg <= real_out;
    out0_i_reg <= imag_out;
  end

  assign out0_r = out0_r_reg;
  assign out0_i = out0_i_reg;
  assign out1_r = out0_r_reg;
  assign out1_i = out0_i_reg;

endmodule
