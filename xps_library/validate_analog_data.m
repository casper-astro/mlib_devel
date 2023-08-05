function [] = validate_analog_data(gcb, tile, slice, arch)
  % this function should only be called for dac tiles

  [~, ~, dac_tile_arch, ~, ~, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(dac_tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(dac_tile_arch, 'dual')
    prefix = 'DT';
  end

  % only run the function if the architecture matches
  if ~strcmp(arch, prefix) return; end

  msk = Simulink.Mask.get(gcb);

  a = slice;

  analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'];
  mixer_type_param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'];
  mixer_mode_param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'];
  nco_freq_param    = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_nco_freq'];
  nco_phase_param   = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_nco_phase'];
  coarse_freq_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_coarse_freq'];

  if chk_param(gcb, analog_mode_param, 'Real')
    msk.getParameter(mixer_type_param).TypeOptions = {'Fine', 'Coarse'};
    if chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
      set_param(gcb, mixer_mode_param, 'Real -> Real');
    end

    if ~mod(slice,2) % an even slice
      if (chk_param(gcb,['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_analog_output'], 'I/Q'))
        % even slice is Real, so odd slice can't be I/Q
        set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_analog_output'], 'Real');
        mixer_callback(gcb,tile,slice,arch); % need to run this to copy IQ stuff over
      end
    else
      % Odd slices only show 'Real' option, becoming 'I/Q' is set when even slices select I/Q
      msk.getParameter(analog_mode_param).TypeOptions = {'Real'};
    end

  else % analog output mode is IQ
    if ~mod(a,2) % an even slice
      msk.getParameter(mixer_type_param).TypeOptions = {'Fine', 'Coarse'};
      msk.getParameter(mixer_mode_param).TypeOptions = {'I/Q -> I/Q'};

      % NCO visibility
      if chk_param(gcb, mixer_type_param, 'Fine')
        msk.getParameter(nco_freq_param).Visible = 'on';
        msk.getParameter(nco_phase_param).Visible = 'on';

        msk.getParameter(coarse_freq_param).Visible = 'off';

      else % if chk_param(gcb, mixer_type_param, 'Coarse')
        set_param(gcb, nco_freq_param, '0');
        set_param(gcb, nco_phase_param, '0');
        msk.getParameter(nco_freq_param).Visible = 'off';
        msk.getParameter(nco_phase_param).Visible = 'off';

        msk.getParameter(coarse_freq_param).TypeOptions = {'Fs/2', 'Fs/4', '-Fs/4'};
        msk.getParameter(coarse_freq_param).Visible = 'on';
      end

      mixer_callback(gcb, tile, slice, arch); % need to run this to copy IQ stuff over
    end
  end
end

