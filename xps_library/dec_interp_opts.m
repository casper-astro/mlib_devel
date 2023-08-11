function dec_interp_opts(gcb, tile, slice)

  [gen, adc_tile_arch, dac_tile_arch, ~, ~, ~, ~] = get_rfsoc_properties(gcb);
  if tile < 228
    tile_arch = adc_tile_arch;
  else
    tile_arch = dac_tile_arch;
  end

  if strcmp(tile_arch, 'quad')
      prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
      prefix = 'DT';
  end

  switch gen
    case 1
      opts = {'1x', '2x', '4x', '8x'};
    case 2
      opts = {};
    case 3
      opts = {'1x', '2x', '3x', '4x', '5x', '6x', '8x', '10x', '12x', '16x', '20x', '24x', '40x'};
  end

  msk = Simulink.Mask.get(gcb);
  if tile < 228
    param = ['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_dec_mode'];
  else % is dac
    param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_inter_mode'];
    analog_mode_param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_analog_output'];
    if chk_param(gcb, analog_mode_param, 'I/Q')
      opts = opts(2:end);
    end
  end
  msk.getParameter(param).TypeOptions = opts;
end
