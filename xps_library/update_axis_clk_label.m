function [] = update_axis_clk_label(gcb, tile)

  [gen, adc_tile_arch, dac_tile_arch, adc_num_tile, dac_num_tile, fs_max, fs_min] = get_rfsoc_properties(gcb);

  if tile < 228
    tile_arch = adc_tile_arch;
  else
    tile_arch = dac_tile_arch;
  end

  if strcmp(tile_arch, 'quad')
    n_slices = 0:3;
    prefix = 'QT';
    QuadTile = 1;
  elseif strcmp(tile_arch, 'dual')
    n_slices = 0:1;
    prefix = 'DT';
    QuadTile = 0;
  end

  msk = Simulink.Mask.get(gcb);

  sample_rate_mhz = str2double(get_param(gcb, ['t', num2str(tile), '_', 'sample_rate']));

  if tile < 228 % adc
    for a = n_slices
      decmode_str = get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_dec_mode']);
      dec_match = regexp(decmode_str, '([0-9]*)x', 'tokens');
      % do not check if empty match, assuming a valid factor will be matched
      factor  = str2double(dec_match{1}{1});

      axisamp_str = get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_sample_per_cycle']);
      axisamp = str2double(axisamp_str);

      sys_clk_mhz = sample_rate_mhz/factor/axisamp;
      if QuadTile
        if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_digital_output'], 'I/Q')
          sys_clk_mhz = 2*sys_clk_mhz;
        end
      end
      sys_clk_mhz = round(sys_clk_mhz, 3);

      % only update label if new axis clk different than current one
      clk_label = ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_req_axis_clk'];
      if ~strcmp(get_param(gcb, clk_label), num2str(sys_clk_mhz))
        set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_req_axis_clk'], num2str(sys_clk_mhz));
      end
    end

  else % dac
    for a = n_slices
      intermode_str = get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_inter_mode']);
      inter_match = regexp(intermode_str, '([0-9]*)x', 'tokens');
      % do not check if empty match, assuming a valid factor will be matched
      factor  = str2double(inter_match{1}{1});

      axisamp_str = get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_sample_per_cycle']);
      axisamp = str2double(axisamp_str);

      sys_clk_mhz = sample_rate_mhz/factor/axisamp;
      check_IQIQ = chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'], 'I/Q');
      check_IQReal = chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'], 'I/Q -> Real');
      if check_IQIQ || check_IQReal
        sys_clk_mhz = 2*sys_clk_mhz;
      end
      sys_clk_mhz = round(sys_clk_mhz, 3);

      % only update label if new axis clk different than current onesim
      clk_label = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_req_axis_clk'];
      if ~strcmp(get_param(gcb, clk_label), num2str(sys_clk_mhz))
        set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_req_axis_clk'], num2str(sys_clk_mhz));
      end
    end
  end
  axis_clks_valid = validate_tile_clocking(gcb, tile);

  % This function is called whenever there is a potential change in port size,
  % so we need to update the port sizes
  if chk_param(gcb,'runinit','1') %only run if this isn't during the mask opening
    set_param(gcb,'forceredraw','1'); %force the mask to redraw itself
  end
end

