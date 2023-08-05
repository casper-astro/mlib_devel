function [] = update_rfdc_clocking(gcb,tile)

  msk = Simulink.Mask.get(gcb);

  fs_mask = msk.getParameter(['t', num2str(tile), '_', 'sample_rate']).Value;
  fs_value = get_param(gcb, ['t', num2str(tile), '_', 'sample_rate']);

  [gen, adc_tile_arch, dac_tile_arch, adc_num_tile, dac_num_tile, fs_max, fs_min] = get_rfsoc_properties(gcb);

  if tile < 228 % adc tile
    if (str2num(fs_value) > fs_max)
      error(['Maximum sample rate for this ADC is ', num2str(fs_max), ' Msps']);
    elseif (str2num(fs_value) < fs_min)
      error(['Minimum sample rate for this ADC is ', num2str(fs_min), ' Msps']);
    end
  else % dac tile
    % TODO: store max DAC sample rates for platforms so we can read them here
  end

  % update only when value changes not each time the mask initializes
  % TODO: this check didn't work, so this is still running every time... slowing
  % us down more... need to investigate how to speed things up
  %if ~strcmp(fs_mask, fs_value)
  % compute and update pll settings and `ref_clk` options
  update_pll(gcb, tile);

  % compute rfdc adc_clk# output clock options
  update_adc_clkout(gcb, tile);

  % compute axis interface (sys_clk) requirements and options
  update_axis_clk(gcb, tile);
  %end

end


