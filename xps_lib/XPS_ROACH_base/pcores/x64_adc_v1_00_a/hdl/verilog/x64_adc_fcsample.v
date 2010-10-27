module x64_adc_fcsample (
    input         clk,
    input         fc_rise,
    input         fc_fall,
    output [11:0] fc_sampled 
  );

  reg [2:0] index;

  reg [5:0] fcs_r;
  reg [5:0] fcs_f;

  always @(posedge clk) begin
    index <= index < 5 ? index + 1 : 0;
    fcs_r[index] <= fc_rise;
    fcs_f[index] <= fc_fall;
  end
  assign fc_sampled = {fcs_f[5], fcs_r[5], fcs_f[4], fcs_r[4],
                       fcs_f[3], fcs_r[3], fcs_f[2], fcs_r[2],
                       fcs_f[1], fcs_r[1], fcs_f[0], fcs_r[0]};


endmodule
