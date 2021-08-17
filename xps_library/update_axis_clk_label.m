function [] = update_axis_clk_label(gcb)

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
    QuadTile = 1;
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    prefix = 'DT';
    QuadTile = 0;
  end

  msk = Simulink.Mask.get(gcb);

  sample_rate_mhz = str2double(get_param(gcb, 'sample_rate'));

  for a = adc_slices
    decmode = get_param(gcb, [prefix, '_adc', num2str(a), '_dec_mode']);
    axisamp = get_param(gcb, [prefix, '_adc', num2str(a), '_sample_per_cycle']);

    factor  = str2double(decmode(1));
    axisamp = str2double(axisamp);

    sys_clk_mhz = sample_rate_mhz/factor/axisamp;
    if QuadTile 
      if chk_param(gcb, [prefix, '_adc', num2str(a), '_digital_output'], 'I/Q')
        sys_clk_mhz = 2*sys_clk_mhz;
      end
    end
    sys_clk_mhz = round(sys_clk_mhz, 3);

    % only update label if new axis clk different than current one
    clk_label = [prefix, '_adc', num2str(a), '_req_axis_clk'];
    if ~strcmp(get_param(gcb, clk_label), num2str(sys_clk_mhz))
      set_param(gcb, [prefix, '_adc', num2str(a), '_req_axis_clk'], num2str(sys_clk_mhz));
    end

  end

  axis_clks_valid = validate_tile_clocking(gcb);

end

