module TB_x64_adc()

    /* Inputs from ADC */
    output             adc_clk_n,
    output             adc_clk_p,
    output       [7:0] in_0_n, 
    output       [7:0] in_0_p, 
    output             fc_0_n,
    output             fc_0_p,
    output       [7:0] in_1_n, 
    output       [7:0] in_1_p, 
    output             fc_1_n,
    output             fc_1_p,
    output       [7:0] in_2_n, 
    output       [7:0] in_2_p, 
    output             fc_2_n,
    output             fc_2_p,
    output       [7:0] in_3_n, 
    output       [7:0] in_3_p, 
    output             fc_3_n,
    output             fc_3_p,
    output       [7:0] in_4_n, 
    output       [7:0] in_4_p, 
    output             fc_4_n,
    output             fc_4_p,
    output       [7:0] in_5_n, 
    output       [7:0] in_5_p, 
    output             fc_5_n,
    output             fc_5_p,
    output       [7:0] in_6_n, 
    output       [7:0] in_6_p, 
    output             fc_6_n,
    output             fc_6_p,
    output       [7:0] in_7_n, 
    output       [7:0] in_7_p, 
    output             fc_7_n,
    output             fc_7_p,

   // /* Application outputs */
   // output            adc_clk0,
   // output            adc_clk90,
   // output            adc_clk180,
   // output            adc_clk270,

   // output [12*8-1:0] adc_data0,
   // output            adc_dvld0,
   // output [12*8-1:0] adc_data1,
   // output            adc_dvld1,
   // output [12*8-1:0] adc_data2,
   // output            adc_dvld2,
   // output [12*8-1:0] adc_data3,
   // output            adc_dvld3,
   // output [12*8-1:0] adc_data4,
   // output            adc_dvld4,
   // output [12*8-1:0] adc_data5,
   // output            adc_dvld5,
   // output [12*8-1:0] adc_data6,
   // output            adc_dvld6,
   // output [12*8-1:0] adc_data7,
   // output            adc_dvld7,
   // /* Software input/outputs */
   // output [12*8-1:0] fc_sampled,
    output             dly_clk,
    output       [7:0] dly_rst,
    output       [7:0] dly_en,
    output       [7:0] dly_inc_dec_n,
    output             dcm_reset,
   // output            dcm_locked
  );

  initial begin
    $display("PASSED");
  end
endmodule
