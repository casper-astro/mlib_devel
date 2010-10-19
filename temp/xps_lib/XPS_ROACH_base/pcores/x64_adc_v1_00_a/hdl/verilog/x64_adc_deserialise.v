module x64_adc_deserialise(
    input             clk,
    input       [7:0] serial_rise,
    input       [7:0] serial_fall,
    input             fclk_rise,
    input             fclk_fall,
    output [12*8-1:0] pout,
    output            pvld
  );

  /* Is frame aligned to every other clock */
  reg aligned;

  wire fclk_posedge_aligned;
  wire fclk_posedge_offset;
  wire fclk_sync = fclk_posedge_aligned || fclk_posedge_offset;

  /* sync detect */
  reg fclk_fall_z;
  always @(posedge clk) begin
    fclk_fall_z <= fclk_fall;

    if (fclk_rise ^ fclk_fall)
      aligned <= 1'b0;

    if (fclk_posedge_aligned)
      aligned <= 1'b1;
  end

  assign fclk_posedge_offset  = !fclk_rise   && fclk_fall;
  assign fclk_posedge_aligned = !fclk_fall_z && fclk_rise;

  /******** Deserialise ********/


  /* generate the data index */
  reg [2:0] index;
  always @(posedge clk) begin

    index <= index < 5 ? index + 1 : 0;

    if (fclk_sync && aligned) begin
      index <= 1;
    end

    if (fclk_sync && !aligned) begin
      index <= 0;
    end
  end
  reg pvld_reg;
  assign pvld = pvld_reg;

  always @(posedge clk) begin
    pvld_reg <= index == 5;
  end

  reg  [7:0] serial_fall_z;

  /*
  TODO: this is profoundly lame, fix
  */
  // synthesis attribute shreg_extract of ser_r0 is NO
  // synthesis attribute shreg_extract of ser_f0 is NO
  // synthesis attribute shreg_extract of ser_r1 is NO
  // synthesis attribute shreg_extract of ser_f1 is NO
  // synthesis attribute shreg_extract of ser_r2 is NO
  // synthesis attribute shreg_extract of ser_f2 is NO
  // synthesis attribute shreg_extract of ser_r3 is NO
  // synthesis attribute shreg_extract of ser_f3 is NO
  // synthesis attribute shreg_extract of ser_r4 is NO
  // synthesis attribute shreg_extract of ser_f4 is NO
  // synthesis attribute shreg_extract of ser_r5 is NO
  // synthesis attribute shreg_extract of ser_f5 is NO

  reg [7:0] ser_r0;
  reg [7:0] ser_f0;
  reg [7:0] ser_r1;
  reg [7:0] ser_f1;
  reg [7:0] ser_r2;
  reg [7:0] ser_f2;
  reg [7:0] ser_r3;
  reg [7:0] ser_f3;
  reg [7:0] ser_r4;
  reg [7:0] ser_f4;
  reg [7:0] ser_r5;
  reg [7:0] ser_f5;

  //////
  //reg [5:0] pout_r0;
  //reg [5:0] pout_f0;
  //reg [5:0] pout_r1;
  //reg [5:0] pout_f1;
  //reg [5:0] pout_r2;
  //reg [5:0] pout_f2;
  //reg [5:0] pout_r3;
  //reg [5:0] pout_f3;
  //reg [5:0] pout_r4;
  //reg [5:0] pout_f4;
  //reg [5:0] pout_r5;
  //reg [5:0] pout_f5;
  //reg [5:0] pout_r6;
  //reg [5:0] pout_f6;
  //reg [5:0] pout_r7;
  //reg [5:0] pout_f7;

  always @(posedge clk) begin
    serial_fall_z <= serial_fall;

    ser_r5 <= aligned ? serial_rise : serial_fall_z;
    ser_r4 <= ser_r5;
    ser_r3 <= ser_r4;
    ser_r2 <= ser_r3;
    ser_r1 <= ser_r2;
    ser_r0 <= ser_r1;

    ser_f5 <= aligned ? serial_fall : serial_rise;
    ser_f4 <= ser_f5;
    ser_f3 <= ser_f4;
    ser_f2 <= ser_f3;
    ser_f1 <= ser_f2;
    ser_f0 <= ser_f1;

    //pout_r0[index] <= aligned ? serial_rise[0] : serial_fall_z[0]; 
    //pout_f0[index] <= aligned ? serial_fall[0] :   serial_rise[0];
    //pout_r1[index] <= aligned ? serial_rise[1] : serial_fall_z[1]; 
    //pout_f1[index] <= aligned ? serial_fall[1] :   serial_rise[1];
    //pout_r2[index] <= aligned ? serial_rise[2] : serial_fall_z[2]; 
    //pout_f2[index] <= aligned ? serial_fall[2] :   serial_rise[2];
    //pout_r3[index] <= aligned ? serial_rise[3] : serial_fall_z[3]; 
    //pout_f3[index] <= aligned ? serial_fall[3] :   serial_rise[3];
    //pout_r4[index] <= aligned ? serial_rise[4] : serial_fall_z[4]; 
    //pout_f4[index] <= aligned ? serial_fall[4] :   serial_rise[4];
    //pout_r5[index] <= aligned ? serial_rise[5] : serial_fall_z[5]; 
    //pout_f5[index] <= aligned ? serial_fall[5] :   serial_rise[5];
    //pout_r6[index] <= aligned ? serial_rise[6] : serial_fall_z[6]; 
    //pout_f6[index] <= aligned ? serial_fall[6] :   serial_rise[6];
    //pout_r7[index] <= aligned ? serial_rise[7] : serial_fall_z[7]; 
    //pout_f7[index] <= aligned ? serial_fall[7] :   serial_rise[7];
  end

  wire [11:0] pout_0 = {ser_f5[0], ser_r5[0], ser_f4[0], ser_r4[0],
                        ser_f3[0], ser_r3[0], ser_f2[0], ser_r2[0],
                        ser_f1[0], ser_r1[0], ser_f0[0], ser_r0[0]};
  wire [11:0] pout_1 = {ser_f5[1], ser_r5[1], ser_f4[1], ser_r4[1],
                        ser_f3[1], ser_r3[1], ser_f2[1], ser_r2[1],
                        ser_f1[1], ser_r1[1], ser_f0[1], ser_r0[1]};
  wire [11:0] pout_2 = {ser_f5[2], ser_r5[2], ser_f4[2], ser_r4[2],
                        ser_f3[2], ser_r3[2], ser_f2[2], ser_r2[2],
                        ser_f1[2], ser_r1[2], ser_f0[2], ser_r0[2]};
  wire [11:0] pout_3 = {ser_f5[3], ser_r5[3], ser_f4[3], ser_r4[3],
                        ser_f3[3], ser_r3[3], ser_f2[3], ser_r2[3],
                        ser_f1[3], ser_r1[3], ser_f0[3], ser_r0[3]};
  wire [11:0] pout_4 = {ser_f5[4], ser_r5[4], ser_f4[4], ser_r4[4],
                        ser_f3[4], ser_r3[4], ser_f2[4], ser_r2[4],
                        ser_f1[4], ser_r1[4], ser_f0[4], ser_r0[4]};
  wire [11:0] pout_5 = {ser_f5[5], ser_r5[5], ser_f4[5], ser_r4[5],
                        ser_f3[5], ser_r3[5], ser_f2[5], ser_r2[5],
                        ser_f1[5], ser_r1[5], ser_f0[5], ser_r0[5]};
  wire [11:0] pout_6 = {ser_f5[6], ser_r5[6], ser_f4[6], ser_r4[6],
                        ser_f3[6], ser_r3[6], ser_f2[6], ser_r2[6],
                        ser_f1[6], ser_r1[6], ser_f0[6], ser_r0[6]};
  wire [11:0] pout_7 = {ser_f5[7], ser_r5[7], ser_f4[7], ser_r4[7],
                        ser_f3[7], ser_r3[7], ser_f2[7], ser_r2[7],
                        ser_f1[7], ser_r1[7], ser_f0[7], ser_r0[7]};

  assign pout = {pout_7, pout_6, pout_5, pout_4, pout_3, pout_2, pout_1, pout_0};


endmodule
