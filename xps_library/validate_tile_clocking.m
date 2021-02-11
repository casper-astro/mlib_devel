function [axis_clks_valid] = validate_tile_clocking(gcb)
  % TODO get this constant from somewhere
  QuadTile = 1;

  if QuadTile
    adc_slices = 0:3;
    prefix = 'QT';
  else
    adc_silces = 0:1;
    prefix = 'DT';
  end

  msk = Simulink.Mask.get(gcb);

  enabled_adcs = [];
  for a = adc_slices
    if chk_param(gcb, [prefix, '_adc', num2str(a), '_enable'], 'on')
      enabled_adcs = [enabled_adcs, a];
    end
  end

  axis_clks = [];
  for a = enabled_adcs
    slice_clk = str2double(get_param(gcb, [prefix, '_adc', num2str(a), '_req_axis_clk']));
    axis_clks = [axis_clks, slice_clk];
  end

  % axis clocks must be the same for each adc slice within a tile
  axis_clks_valid = all(axis_clks == axis_clks(1));
  if ~axis_clks_valid
    label_txt = '*Axis Clockign Invalid*';
  else
    label_txt = num2str(axis_clks(1));
  end

  % compare label with current value and only update if needed
  if ~strcmp(get_param(gcb, 'axi_stream_clk'), label_txt)
    set_param(gcb, 'axi_stream_clk', label_txt);
  end

end
