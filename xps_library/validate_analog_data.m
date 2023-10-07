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
    mixertype_callback(gcb, tile, slice, arch);

    if ~mod(slice,2) % we are an even slice, get the neighbor slice and ensure valid configuration
      neighbor_analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_analog_output'];
      if (chk_param(gcb, neighbor_analog_mode_param, 'I/Q')) % we are coming out of I/Q mode on the even slice and need to also fix the neighbor (odd) slice
        % the enable check box should be greyed out, need to turn it back
        neighbor_enable_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable'];
        msk.getParameter(neighbor_enable_param).Enabled = 'on';
        % even slice is Real, so odd slice can't be I/Q
        msk.getParameter(neighbor_analog_mode_param).TypeOptions = {'Real'};
        set_param(gcb, neighbor_analog_mode_param, 'Real');

        % turn mixer back on (remove 'Off' setting)
        neighbor_mixer_type_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type'];
        msk.getParameter(neighbor_mixer_type_param).TypeOptions = {'Coarse', 'Fine'};
        set_param(gcb, neighbor_mixer_type_param, 'Coarse');
        mixertype_callback(gcb, tile, a+1, arch);

        % re-enable the configuration dialogs (un-grey them)
        neighborDataDialog   = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_DataSettings']);
        neighborMixerDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_MixerSettings']);
        neighborAnalogDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_AnalogSettings']);
        neighborDataDialog.Enabled  = 'on';
        neighborMixerDialog.Enabled = 'on';
        neighborAnalogDialog.Enabled= 'on';
      end
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

      % run mixer callback to populate and setup the neighbor tile that has
      % to be enabled and configured when in I/Q output mode
      mixer_callback(gcb, tile, slice, arch);
    end
  end
end

