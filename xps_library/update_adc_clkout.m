function [adc_clkout] = update_adc_clkout(gcb, tile)
  % compute output adc clk options and update mask list

  [gen, ~, ~, ~, ~, fs_max, fs_min] = get_rfsoc_properties(gcb);

  msk = Simulink.Mask.get(gcb);

  sample_rate_mhz = str2double(get_param(gcb, ['t', num2str(tile), '_', 'sample_rate']));

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
  % Simulink runs all callbacks sequentially when opening the mask dialog. So
  % the list of refclks and user selected value would be overwritten when
  % opening if the TypeOptions are reset each time.
  % So, only update the PLL if the list of refclk is not up to date. There is
  % probably a smarter way to organize all the logic to be more efficent.
  % TODO: this is the same as `update_pll.m`
  current_clkout_list = msk.getParameter(['t', num2str(tile), '_', 'clk_out']).TypeOptions;
  if ~isempty( setdiff(adc_clkout_list, current_clkout_list) )
    msk.getParameter(['t', num2str(tile), '_', 'clk_out']).TypeOptions = adc_clkout_list;
    set_param(gcb, ['t', num2str(tile), '_', 'clk_out'], num2str(adc_clkout(1)));
  end

end
