function [] = update_rfdc_clocking(gcb)
  msk = Simulink.Mask.get(gcb);

  fs_mask = msk.getParameter('sample_rate').Value;
  fs_value = get_param(gcb, 'sample_rate');

  [gen, tile_arch, fs_max, fs_min] = get_rfsoc_properties(gcb);

  if (str2num(fs_value) > fs_max)
    error(['Maximum sample rate for this ADC is ', num2str(fs_max), ' Msps']);
  elseif (str2num(fs_value) < fs_min)
    error(['Minimum sample rate for this ADC is ', num2str(fs_min), ' Msps']);
  end

  % update only when value changes not each time the mask initializes
  % TODO: this check didn't work, so this is still running every time... slowing
  % us down more... need to investigate how to speed things up
  %if ~strcmp(fs_mask, fs_value)
  % compute and update pll settings and `ref_clk` options
  update_pll(gcb);

  % compute rfdc adc_clk# output clock options
  update_adc_clkout(gcb);

  % compute axis interface (sys_clk) requirements and options
  update_axis_clk(gcb);
  %end

end


