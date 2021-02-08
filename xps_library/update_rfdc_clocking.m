function [] = update_rfdc_clocking(gcb)
  display('update_rfdc_clocking');
  % compute and update pll settings and `ref_clk` options
  update_pll(gcb);

  % compute rfdc adc_clk# output clock options
  update_adc_clkout(gcb);
  
  % compute axis interface (sys_clk) requirements and options
  update_axis_clk(gcb);

end

