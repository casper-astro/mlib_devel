function [] = validate_analog_data(gcb,tile,slice,arch)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);

  if strcmp(tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    prefix = 'DT';
  end

  % only run the function if the architecture matches
  if (arch ~= prefix), return, end

  a = slice;

  analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'];
  mixer_type_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'];
  mixer_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'];
  nco_freq_param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_nco_freq'];
  nco_phase_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_nco_phase'];
  coarse_freq_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_coarse_freq'];
  if chk_param(gcb, analog_mode_param, 'Real')
    msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> Real', 'I/Q -> Real'};
    if chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
      set_param(gcb, mixer_mode_param, 'Real -> Real');
    end
    if chk_param(gcb, mixer_mode_param, 'Real -> Real')
      msk.getParameter(mixer_type_param).TypeOptions = {'Bypassed'};
      set_param(gcb, mixer_type_param, 'Bypassed');
      msk.getParameter(nco_freq_param).Visible = 'off';
      msk.getParameter(nco_phase_param).Visible = 'off';
      msk.getParameter(coarse_freq_param).Visible = 'off';
    else % param is IQ->Real
      msk.getParameter(mixer_type_param).TypeOptions = {'Fine', 'Coarse'};
      if mod(a,2) % an odd slice
      % only allow odd slices to select C2R when output is C
        msk.getParameter(mixer_mode_param).TypeOptions = {'I/Q -> Real'};
      else
        msk.getParameter(mixer_mode_param).TypeOptions = {'I/Q -> Real'; 'I/Q -> I/Q'};
      end

    % NCO visibility
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
    if ~mod(slice,2)
      if (chk_param(gcb,['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_analog_output'], 'I/Q'))
          %even slice is Real, so odd slice can't be I/Q
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_analog_output'], 'Real');
          %validate_analog_data(gcb,tile,slice+1,arch);
          mixer_callback(gcb,tile,slice,arch); % need to run this to copy IQ stuff over
      end
    end

  else %mode is IQ
    if ~mod(slice,2) % even slices can turn to IQ
      msk.getParameter(mixer_type_param).TypeOptions = {'Fine', 'Coarse'};

      msk.getParameter(mixer_mode_param).TypeOptions = {'I/Q -> I/Q'};

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
      if ~mod(slice,2)
        mixer_callback(gcb,tile,slice,arch); % need to run this to copy IQ stuff over
      end
    else % odd slice, can't become IQ on its own
      if ~(chk_param(gcb,['t', num2str(tile), '_', prefix, '_dac', num2str(a-1), '_analog_output'], 'I/Q'))
        % don't let them
        set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'], 'Real');
        error("Odd DAC slices cannot be configured to IQ output on their own.")
      end
    end

  end
end

