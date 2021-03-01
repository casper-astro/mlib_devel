function [adc_clkout] = update_adc_clkout(gcb, parent)
  % compute output adc clk options and update mask list

  % TODO need to get access to these
  gen = 3;
  fs_max = 2.5;
  fs_min = 0.5;

  msk = Simulink.Mask.get(gcb);

  sample_rate_mhz = str2double(get_param(gcb, 'sample_rate'));

  adc_clkout = [];
  min_adc_clkout_mhz = 10.0;
  div = 2.^(3:6);

  if fs_max >= 4.0
    div = div.*2;
  end

  for d = div
    clkout = round(sample_rate_mhz/d, 3);
    if (clkout > min_adc_clkout_mhz)
      adc_clkout = [adc_clkout, clkout];
  end

  adc_clkout_list = compose('%g', adc_clkout);
  msk.getParameter('clk_out').TypeOptions = adc_clkout_list;

end
