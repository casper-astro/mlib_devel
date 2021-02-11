function [] = update_axis_clk(gcb)
  % compute axis interface (sys_clk) requirements and options

  msk = Simulink.Mask.get(gcb);
  
  % TODO get these constants from somewhere
  gen = 3;
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
    % determine choices for samples per clock
    if (gen < 2)
      w = 1:8;
    else
      w = 1:12;
    end

    % PG269, quad tiles adcs have I/Q data appear on the same interface in complex
    % pairs. E.g., 2 samples is one I and one Q sample
    if QuadTile
      if chk_param(gcb, [prefix, '_adc', num2str(a), '_digital_output'], 'I/Q')
        w = w(2:2:end);
      end
    end

    decmode = get_param(gcb, [prefix, '_adc', num2str(a), '_dec_mode']);
    factor  = str2double(decmode(1));

    sys_clk_mhz = (sample_rate_mhz/factor)./w;
    if QuadTile
      if chk_param(gcb, [prefix, '_adc', num2str(a), '_digital_output'], 'I/Q')
        sys_clk_mhz = 2*sys_clk_mhz;
      end
    end
    sys_clk_mhz = round(sys_clk_mhz, 3);

    clk_max_mhz = 500.0;
    I = find(sys_clk_mhz <= clk_max_mhz);
    % the required `sys_clocks` for the seleceted parallel samples `w`
    % are at, sys_clk_mhz(I) w(I), respectively.

    % TODO: AXI required clock is correct for at least one of the values in the
    % updated 'samples per cycle' popup. but when that popup is set it overrides
    % and so should default to the min and then set it in the popup.
    msk.getParameter([prefix, '_adc', num2str(a), '_sample_per_cycle']).TypeOptions = compose('%d', w(I));

  end

  update_axis_clk_label(gcb);
  
end

  % Known work to do and issues to fix:
  %
  % TODO: !!! mask does not check and guard on min/max sampling frequency

  % TODO: !! Gen3 parts have configuration for clocking source and
  % distribution. Although this could be a board specific thing and just managed
  % by the platform (e.g., zcu216) yellow block

  % TODO: Mask does nothing to place the gateway blocks nicely

  % TODO: Dual-Tile ADCs (e.g., zcu111 has not been tested): top level init does not
  % implement drawing for the interfaces. Callbacks are not set.

  % TODO: Constants (gen, QuadTile, etc.) need to be determined and able to
  % provide to the methods

  % TODO: there is only a specific range of suggested tested frequencies for
  % the fbdiv parameter that is tested within the specification given on
  % DS926. These should be the ones that Vivado displays a warning when
  % selected. Extend the same warning here. Need to figure out that range.

  % TODO: Enabling I/Q -> I/Q and then chaning the decimation factor and axi
  % samples per clock results in an invalid axi clocking configuration. This
  % should not happen because the odd slice configuration is now dependent on
  % the even slice.

  % TODO: Enabling I/Q -> I/Q disables the odd slice ADC but when you hit OK and
  % bring up the rfdc mask again the field is enabled. This is a symptom of the
  % 'Enabled Checkbox being on' but not checking the even slice data mode
  % correctly. (or it does check the mode correctly, but the callback appears
  % in th wrong order).

  % NOTE: Only maxis_tdata filed implemented. The ADC ignores tready and it is
  % reasonably accurate to assume that the data will be valid before the user
  % design is ready. Also, problems are typically handled and reported through
  % the IRQ.
  
