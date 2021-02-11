function [] = update_rfdc_clocking(gcb)
  msk = Simulink.Mask.get(gcb);
  fs_mask = msk.getParameter('sample_rate').Value;
  fs_value = get_param(gcb, 'sample_rate');

  % update only when value changes not each time the mask initializes
  if ~strcmp(fs_mask, fs_value)
    % compute and update pll settings and `ref_clk` options
    update_pll(gcb);

    % compute rfdc adc_clk# output clock options
    update_adc_clkout(gcb);

    % compute axis interface (sys_clk) requirements and options
    update_axis_clk(gcb);
  end

end


