function [] = update_axis_clk_label(gcb)
  display('update_axis_clk_label');
  % TODO get this constant from somewhere
  QuadTile = 1;

  if QuadTile
    adc_slices = 0:3;
    prefix = 'QT';
  else
    adc_silces = 0:1;
    prefix = 'DT';
  end

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

    set_param(gcb, [prefix, '_adc', num2str(a), '_req_axis_clk'], num2str(sys_clk_mhz));

  end

  axis_clks_valid = validate_tile_clocking(gcb);

end

