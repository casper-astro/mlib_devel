function [] = validate_digital_data(gcb)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);

  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    prefix = 'DT';
  end

  for a = adc_slices
    digital_mode_param = [prefix, '_adc', num2str(a), '_digital_output'];
    mixer_type_param = [prefix, '_adc', num2str(a), '_mixer_type'];
    mixer_mode_param = [prefix, '_adc', num2str(a), '_mixer_mode'];
    nco_freq_param  = [prefix, '_adc', num2str(a), '_nco_freq'];
    nco_phase_param = [prefix, '_adc', num2str(a), '_nco_phase'];
    coarse_freq_param = [prefix, '_adc', num2str(a), '_coarse_freq'];

    if chk_param(gcb, digital_mode_param, 'Real')
      msk.getParameter(mixer_type_param).TypeOptions = {'Bypassed'};
      set_param(gcb, mixer_type_param, 'Bypassed');
      msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> Real'};
      set_param(gcb, mixer_mode_param, 'Real -> Real');

      msk.getParameter(nco_freq_param).Visible = 'off';
      msk.getParameter(nco_phase_param).Visible = 'off';
      msk.getParameter(coarse_freq_param).Visible = 'off';
    else
      msk.getParameter(mixer_type_param).TypeOptions = {'Fine', 'Coarse'};
      %set_param(gcb, mixer_type_param, 'Fine');
      if mod(a,2) % an odd slice
        % only allow odd slices to select R2C when output is C
        msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> I/Q'};
      else
        msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> I/Q'; 'I/Q -> I/Q'};
      end

      % NCO visibility
      % why does not calling `set_param` on the mixer type above force a
      % callback calling `mixertype_callback`, possibly just substitute here for
      % a call to `mixertype_callback`?
      if chk_param(gcb, mixer_type_param, 'Fine')
        msk.getParameter(nco_freq_param).Visible = 'on';
        msk.getParameter(nco_phase_param).Visible = 'on';

        msk.getParameter(coarse_freq_param).Visible = 'off';

      elseif chk_param(gcb, mixer_type_param, 'Coarse')
        set_param(gcb, nco_freq_param, '0');
        set_param(gcb, nco_phase_param, '0');
        msk.getParameter(nco_freq_param).Visible = 'off';
        msk.getParameter(nco_phase_param).Visible = 'off';

        msk.getParameter(coarse_freq_param).TypeOptions = {'Fs/2', 'Fs/4', '-Fs/4'};
        msk.getParameter(coarse_freq_param).Visible = 'on';

      else % 'Bypassed'
        set_param(gcb, nco_freq_param, '0');
        set_param(gcb, nco_phase_param, '0');
        msk.getParameter(nco_freq_param).Visible = 'off';
        msk.getParameter(nco_phase_param).Visible = 'off';

        msk.getParameter(coarse_freq_param).TypeOptions = {'0'};
        set_param(gcb, coarse_freq_param, '0');
        msk.getParameter(coarse_freq_param).Visible = 'on';
      end
    end

  end

end

