module x64_adc (
    /* Inputs from ADC */
    input             adc_clk_n,
    input             adc_clk_p,

    input       [7:0] in_0_n, 
    input       [7:0] in_0_p, 
    input             fc_0_n,
    input             fc_0_p,
    input       [7:0] in_1_n, 
    input       [7:0] in_1_p, 
    input             fc_1_n,
    input             fc_1_p,
    input       [7:0] in_2_n, 
    input       [7:0] in_2_p, 
    input             fc_2_n,
    input             fc_2_p,
    input       [7:0] in_3_n, 
    input       [7:0] in_3_p, 
    input             fc_3_n,
    input             fc_3_p,
    input       [7:0] in_4_n, 
    input       [7:0] in_4_p, 
    input             fc_4_n,
    input             fc_4_p,
    input       [7:0] in_5_n, 
    input       [7:0] in_5_p, 
    input             fc_5_n,
    input             fc_5_p,
    input       [7:0] in_6_n, 
    input       [7:0] in_6_p, 
    input             fc_6_n,
    input             fc_6_p,
    input       [7:0] in_7_n, 
    input       [7:0] in_7_p, 
    input             fc_7_n,
    input             fc_7_p,

    //output            adc_reset,

    /* Application outputs */
    output            adc_clk0,
    output            fab_clk,
    output            fab_clk90,
    output            fab_clk180,
    output            fab_clk270,

    output [11:0] adc_data0,
    output [11:0] adc_data1,
    output [11:0] adc_data2,
    output [11:0] adc_data3,
    output [11:0] adc_data4,
    output [11:0] adc_data5,
    output [11:0] adc_data6,
    output [11:0] adc_data7,
    output [11:0] adc_data8,
    output [11:0] adc_data9,
    output [11:0] adc_data10,
    output [11:0] adc_data11,
    output [11:0] adc_data12,
    output [11:0] adc_data13,
    output [11:0] adc_data14,
    output [11:0] adc_data15,
    output [7:0]  adc_dout_sync,
    output [7:0]  adc_fifo_of,
    output [7:0]  adc_fifo_uf,
    output [7:0]  adc_dout_vld,
    
    /* Software input/outputs */
    output [12*8-1:0] fc_sampled,
    input             dly_clk,
    input       [7:0] dly_rst,
    input       [7:0] dly_en,
    input       [7:0] dly_inc_dec_n,
    input             dcm_reset,
    output            dcm_locked,
    input             reset
  );

  parameter ADC_BIT_CLK_PERIOD = 3.3;

  wire [7:0] in_rise_0;
  wire       fc_rise_0;
  wire [7:0] in_rise_1;
  wire       fc_rise_1;
  wire [7:0] in_rise_2;
  wire       fc_rise_2;
  wire [7:0] in_rise_3;
  wire       fc_rise_3;
  wire [7:0] in_rise_4;
  wire       fc_rise_4;
  wire [7:0] in_rise_5;
  wire       fc_rise_5;
  wire [7:0] in_rise_6;
  wire       fc_rise_6;
  wire [7:0] in_rise_7;
  wire       fc_rise_7;

  wire [7:0] in_fall_0;
  wire       fc_fall_0;
  wire [7:0] in_fall_1;
  wire       fc_fall_1;
  wire [7:0] in_fall_2;
  wire       fc_fall_2;
  wire [7:0] in_fall_3;
  wire       fc_fall_3;
  wire [7:0] in_fall_4;
  wire       fc_fall_4;
  wire [7:0] in_fall_5;
  wire       fc_fall_5;
  wire [7:0] in_fall_6;
  wire       fc_fall_6;
  wire [7:0] in_fall_7;
  wire       fc_fall_7;

  x64_adc_infrastructure #(
    .ADC_BIT_CLK_PERIOD (ADC_BIT_CLK_PERIOD)
    ) x64_adc_infrastructure_inst (
    .adc_clk_n     (adc_clk_n),
    .adc_clk_p     (adc_clk_p),

    .in_0_n        (in_0_n), 
    .in_0_p        (in_0_p), 
    .fc_0_n        (fc_0_n),
    .fc_0_p        (fc_0_p),
    .in_1_n        (in_1_n), 
    .in_1_p        (in_1_p), 
    .fc_1_n        (fc_1_n),
    .fc_1_p        (fc_1_p),
    .in_2_n        (in_2_n), 
    .in_2_p        (in_2_p), 
    .fc_2_n        (fc_2_n),
    .fc_2_p        (fc_2_p),
    .in_3_n        (in_3_n), 
    .in_3_p        (in_3_p), 
    .fc_3_n        (fc_3_n),
    .fc_3_p        (fc_3_p),
    .in_4_n        (in_4_n), 
    .in_4_p        (in_4_p), 
    .fc_4_n        (fc_4_n),
    .fc_4_p        (fc_4_p),
    .in_5_n        (in_5_n), 
    .in_5_p        (in_5_p), 
    .fc_5_n        (fc_5_n),
    .fc_5_p        (fc_5_p),
    .in_6_n        (in_6_n), 
    .in_6_p        (in_6_p), 
    .fc_6_n        (fc_6_n),
    .fc_6_p        (fc_6_p),
    .in_7_n        (in_7_n), 
    .in_7_p        (in_7_p), 
    .fc_7_n        (fc_7_n),
    .fc_7_p        (fc_7_p),

    .adc_clk0      (adc_clk0),

    .in_rise_0     (in_rise_0), 
    .fc_rise_0     (fc_rise_0),
    .in_rise_1     (in_rise_1), 
    .fc_rise_1     (fc_rise_1),
    .in_rise_2     (in_rise_2), 
    .fc_rise_2     (fc_rise_2),
    .in_rise_3     (in_rise_3), 
    .fc_rise_3     (fc_rise_3),
    .in_rise_4     (in_rise_4), 
    .fc_rise_4     (fc_rise_4),
    .in_rise_5     (in_rise_5), 
    .fc_rise_5     (fc_rise_5),
    .in_rise_6     (in_rise_6), 
    .fc_rise_6     (fc_rise_6),
    .in_rise_7     (in_rise_7), 
    .fc_rise_7     (fc_rise_7),

    .in_fall_0     (in_fall_0), 
    .fc_fall_0     (fc_fall_0),
    .in_fall_1     (in_fall_1), 
    .fc_fall_1     (fc_fall_1),
    .in_fall_2     (in_fall_2), 
    .fc_fall_2     (fc_fall_2),
    .in_fall_3     (in_fall_3), 
    .fc_fall_3     (fc_fall_3),
    .in_fall_4     (in_fall_4), 
    .fc_fall_4     (fc_fall_4),
    .in_fall_5     (in_fall_5), 
    .fc_fall_5     (fc_fall_5),
    .in_fall_6     (in_fall_6), 
    .fc_fall_6     (fc_fall_6),
    .in_fall_7     (in_fall_7), 
    .fc_fall_7     (fc_fall_7),

    .dly_clk       (dly_clk),
    .dly_rst       (dly_rst),
    .dly_en        (dly_en),
    .dly_inc_dec_n (dly_inc_dec_n),

    .dcm_reset     (dcm_reset),
    .dcm_locked    (dcm_locked),
    .fab_clk       (fab_clk),
    .fab_clk90     (fab_clk90),
    .fab_clk180    (fab_clk180),
    .fab_clk270    (fab_clk270)
  );

  wire [12*64-1:0] adc_parallel_streams;

  x64_adc_deserialise x64_adc_deserialise_inst [7:0] (
    .clk         (adc_clk0),
    .serial_rise ({in_rise_7, in_rise_6, in_rise_5, in_rise_4, in_rise_3, in_rise_2, in_rise_1, in_rise_0}),
    .serial_fall ({in_fall_7, in_fall_6, in_fall_5, in_fall_4, in_fall_3, in_fall_2, in_fall_1, in_fall_0}),
    .fclk_rise   ({fc_rise_7, fc_rise_6, fc_rise_5, fc_rise_4, fc_rise_3, fc_rise_2, fc_rise_1, fc_rise_0}),
    .fclk_fall   ({fc_fall_7, fc_fall_6, fc_fall_5, fc_fall_4, fc_fall_3, fc_fall_2, fc_fall_1, fc_fall_0}),
    .pout        (adc_parallel_streams),
    .pvld        ({adc_dvld7, adc_dvld6, adc_dvld5, adc_dvld4, adc_dvld3, adc_dvld2, adc_dvld1, adc_dvld0})
  );
  
  wire [16*12-1:0] adc_data_retimed;
  wire [7:0]       async_fifo_empty;
  wire async_fifo_rd_en = ((~async_fifo_empty[0])&&
                           (~async_fifo_empty[1])&&
                           (~async_fifo_empty[2])&&
                           (~async_fifo_empty[3])&&
                           (~async_fifo_empty[4])&&
                           (~async_fifo_empty[5])&&
                           (~async_fifo_empty[6])&&
                           (~async_fifo_empty[7]));

  x64_adc_retime x64_adc_retime_inst [7:0] (
    .wr_clk      (adc_clk0),
    .rd_clk      (fab_clk),
    .din         (adc_parallel_streams),
    .dvld        ({adc_dvld7, adc_dvld6, adc_dvld5, adc_dvld4, adc_dvld3, adc_dvld2, adc_dvld1, adc_dvld0}),
    .dout        (adc_data_retimed),
    .rst         (reset),
    .rd_en       (async_fifo_rd_en),
    .dout_sync   (adc_dout_sync),
    .fifo_of     (adc_fifo_of),
    .fifo_uf     (adc_fifo_uf),
    .fifo_empty  (async_fifo_empty),
    .dout_vld    (adc_dout_vld)
  );

  assign adc_data0 ={~adc_data_retimed[12*1 -1],adc_data_retimed[12*1 -2:12*0]};
  assign adc_data1 ={~adc_data_retimed[12*2 -1],adc_data_retimed[12*2 -2:12*1]};
  assign adc_data2 ={~adc_data_retimed[12*3 -1],adc_data_retimed[12*3 -2:12*2]};
  assign adc_data3 ={~adc_data_retimed[12*4 -1],adc_data_retimed[12*4 -2:12*3]};
  assign adc_data4 ={~adc_data_retimed[12*5 -1],adc_data_retimed[12*5 -2:12*4]};
  assign adc_data5 ={~adc_data_retimed[12*6 -1],adc_data_retimed[12*6 -2:12*5]};
  assign adc_data6 ={~adc_data_retimed[12*7 -1],adc_data_retimed[12*7 -2:12*6]};
  assign adc_data7 ={~adc_data_retimed[12*8 -1],adc_data_retimed[12*8 -2:12*7]};
  assign adc_data8 ={~adc_data_retimed[12*9 -1],adc_data_retimed[12*9 -2:12*8]};
  assign adc_data9 ={~adc_data_retimed[12*10-1],adc_data_retimed[12*10-2:12*9]};
  assign adc_data10={~adc_data_retimed[12*11-1],adc_data_retimed[12*11-2:12*10]};
  assign adc_data11={~adc_data_retimed[12*12-1],adc_data_retimed[12*12-2:12*11]};
  assign adc_data12={~adc_data_retimed[12*13-1],adc_data_retimed[12*13-2:12*12]};
  assign adc_data13={~adc_data_retimed[12*14-1],adc_data_retimed[12*14-2:12*13]};
  assign adc_data14={~adc_data_retimed[12*15-1],adc_data_retimed[12*15-2:12*14]};
  assign adc_data15={~adc_data_retimed[12*16-1],adc_data_retimed[12*16-2:12*15]};

  x64_adc_fcsample x64_adc_fcsample_inst [7:0] (
    .clk        (adc_clk0),
    .fc_rise    ({fc_rise_7, fc_rise_6, fc_rise_5, fc_rise_4, fc_rise_3, fc_rise_2, fc_rise_1, fc_rise_0}),
    .fc_fall    ({fc_fall_7, fc_fall_6, fc_fall_5, fc_fall_4, fc_fall_3, fc_fall_2, fc_fall_1, fc_fall_0}),
    .fc_sampled (fc_sampled)
  );

endmodule
