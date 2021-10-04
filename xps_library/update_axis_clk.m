function [] = update_axis_clk(gcb,tile)
  % compute axis interface (sys_clk) requirements and options

  msk = Simulink.Mask.get(gcb);

  [gen, tile_arch, ~, ~] = get_rfsoc_properties(gcb);

  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
    QuadTile = 1;
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    prefix = 'DT';
    QuadTile = 0;
  end
  % TODO: should be determined like the adc parameters by the RFSoC chip
  dac_slices = 0:3;

  sample_rate_mhz = str2double(get_param(gcb, ['t',num2str(tile),'_','sample_rate']));

  % case where it's an ADC
  if tile < 228
    for a = adc_slices
      % determine choices for samples per clock
      if (gen < 2)
        w = 1:8;
      else
        w = 1:12;
      end

      % PG269, quad tiles adcs have I/Q data appear on the same interface in complex
      % pairs. E.g., 2 samples is one I and one Q sample
      if QuadTile
        if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_digital_output'], 'I/Q')
          w = w(2:2:end);
        end
      end

      decmode = get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_dec_mode']);
      factor  = str2double(decmode(1));

      sys_clk_mhz = (sample_rate_mhz/factor)./w;
      if QuadTile
        if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_digital_output'], 'I/Q')
          sys_clk_mhz = 2*sys_clk_mhz;
        end
      end
      sys_clk_mhz = round(sys_clk_mhz, 3);

      clk_max_mhz = 512.0;
      I = find(sys_clk_mhz <= clk_max_mhz);
      % the required `sys_clocks` for the seleceted parallel samples `w`
      % are at, sys_clk_mhz(I) w(I), respectively.

      % TODO: AXI required clock is correct for at least one of the values in the
      % updated 'samples per cycle' popup. but when that popup is set it overrides
      % and so should default to the min and then set it in the popup.
      msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_sample_per_cycle']).TypeOptions = compose('%d', w(I));
    end

  % need to add case for DACs
  elseif ~(~QuadTile && tile > 229)
    for a = dac_slices
      % determine choices for samples per clock
      if (gen < 2)
        w = 1:8;
      else
        w = 1:12;
      end

      % PG269, quad tiles adcs have I/Q data appear on the same interface in complex
      % pairs. E.g., 2 samples is one I and one Q sample
      if QuadTile
        if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'], 'I/Q')
          w = w(2:2:end);
        end
      end

      intermode = get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_inter_mode']);
      factor  = str2double(intermode(1));

      sys_clk_mhz = (sample_rate_mhz/factor)./w;
      if QuadTile
        if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'], 'I/Q')
          sys_clk_mhz = 2*sys_clk_mhz;
        end
      end
      sys_clk_mhz = round(sys_clk_mhz, 3);

      clk_max_mhz = 512.0;
      I = find(sys_clk_mhz <= clk_max_mhz);
      % the required `sys_clocks` for the seleceted parallel samples `w`
      % are at, sys_clk_mhz(I) w(I), respectively.

      % TODO: AXI required clock is correct for at least one of the values in the
      % updated 'samples per cycle' popup. but when that popup is set it overrides
      % and so should default to the min and then set it in the popup.
      msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_sample_per_cycle']).TypeOptions = compose('%d', w(I));
    end
  end

  update_axis_clk_label(gcb, tile);

end

