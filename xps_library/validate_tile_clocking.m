function [axis_clks_valid] = validate_tile_clocking(gcb)
  display('validate_tile_clocking');
  % TODO get this constant from somewhere
  QuadTile = 1;

  if QuadTile
    adc_slices = 0:3;
    prefix = 'QT';
  else
    adc_silces = 0:1;
    prefix = 'DT';
  end

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
    set_param(gcb, 'axi_stream_clk', '*Axis Clocking Invalid*');
  else
    set_param(gcb, 'axi_stream_clk', num2str(axis_clks(1)));
  end

end
