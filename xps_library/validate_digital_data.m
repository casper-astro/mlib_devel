function [] = validate_digital_data(gcb)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);

  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    adc_silces = 0:1;
    prefix = 'DT';
  end

  for a = adc_slices
    digital_mode_param = [prefix, '_adc', num2str(a), '_digital_output'];
    mixer_type_param = [prefix, '_adc', num2str(a), '_mixer_type'];
    mixer_mode_param = [prefix, '_adc', num2str(a), '_mixer_mode'];
    if chk_param(gcb, digital_mode_param, 'Real')
      msk.getParameter(mixer_type_param).TypeOptions = {'Bypassed'};
      set_param(gcb, mixer_type_param, 'Bypassed');
      msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> Real'};
      set_param(gcb, mixer_mode_param, 'Real -> Real');
    else
      msk.getParameter(mixer_type_param).TypeOptions = {'Fine', 'Coarse'};
      if mod(a,2) % an odd slice
        % only allow odd slices to select R2C when output is C
        msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> I/Q'};
      else
        msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> I/Q'; 'I/Q -> I/Q'};
      end
    end

  end

end

