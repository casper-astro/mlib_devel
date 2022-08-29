function [] = update_axis_clk_label(gcb,tile)

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    dac_slices = 0:3;
    prefix = 'QT';
    QuadTile = 1;
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    dac_slices = 0:3;
    prefix = 'DT';
    QuadTile = 0;
  end

  msk = Simulink.Mask.get(gcb);

  sample_rate_mhz = str2double(get_param(gcb, ['t', num2str(tile), '_', 'sample_rate']));

  %case with adc
  if tile < 228
    for a = adc_slices
      decmode = get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_dec_mode']);
      axisamp = get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_sample_per_cycle']);

      factor  = str2double(decmode(1));
      axisamp = str2double(axisamp);

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

  %case for dac
  elseif ~(tile > 229 && (strcmp(tile_arch, 'dual')))
    for a = dac_slices
      intermode = get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_inter_mode']);
      axisamp = get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_sample_per_cycle']);

      factor  = str2double(intermode(1));
      axisamp = str2double(axisamp);

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

