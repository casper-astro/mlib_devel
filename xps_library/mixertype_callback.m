function [] = mixertype_callback(gcb, tile, slice, arch)

  [~, adc_tile_arch, dac_tile_arch, ~, ~, ~, ~] = get_rfsoc_properties(gcb);

  if tile < 228
    tile_arch = adc_tile_arch;
    slicename = '_adc';
  else
    tile_arch = dac_tile_arch;
    slicename = '_dac';
  end

  if strcmp(tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    prefix = 'DT';
  end

  % only run the function if the architecture matches
  if ~strcmp(arch, prefix) return; end

  msk = Simulink.Mask.get(gcb);

  mixer_type_param  = ['t', num2str(tile), '_', prefix, slicename, num2str(slice), '_mixer_type'];
  mixer_mode_param  = ['t', num2str(tile), '_', prefix, slicename, num2str(slice), '_mixer_mode'];
  nco_freq_param    = ['t', num2str(tile), '_', prefix, slicename, num2str(slice), '_nco_freq'];
  nco_phase_param   = ['t', num2str(tile), '_', prefix, slicename, num2str(slice), '_nco_phase'];
  coarse_freq_param = ['t', num2str(tile), '_', prefix, slicename, num2str(slice), '_coarse_freq'];

  if tile < 228 % indicates an adc
    if chk_param(gcb, mixer_type_param, 'Fine')
      % TODO: need to validate nco freq value, here is probably not the best place just need to note it
      msk.getParameter(nco_freq_param).Visible = 'on';
      msk.getParameter(nco_phase_param).Visible = 'on';
      msk.getParameter(coarse_freq_param).Visible = 'off';

    elseif chk_param(gcb, mixer_type_param, 'Coarse')
      set_param(gcb, nco_freq_param, '0'); % not exactly necessary to reset to zero
      set_param(gcb, nco_phase_param, '0');
      msk.getParameter(nco_freq_param).Visible = 'off';
      msk.getParameter(nco_phase_param).Visible = 'off';

      msk.getParameter(coarse_freq_param).TypeOptions = {'Fs/2', 'Fs/4', '-Fs/4'};
      msk.getParameter(coarse_freq_param).Visible = 'on';

    elseif chk_param(gcb, mixer_type_param, 'Bypassed')
      set_param(gcb, nco_freq_param, '0');
      set_param(gcb, nco_phase_param, '0');
      msk.getParameter(nco_freq_param).Visible = 'off';
      msk.getParameter(nco_phase_param).Visible = 'off';

      msk.getParameter(coarse_freq_param).TypeOptions = {'0'};
      set_param(gcb, coarse_freq_param, '0');
      msk.getParameter(coarse_freq_param).Visible = 'off';
    else
      msk.getParameter(nco_freq_param).Visible = 'off';
      msk.getParameter(nco_phase_param).Visible = 'off';
      msk.getParameter(coarse_freq_param).Visible = 'off';
    end

  else % is a dac
    analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_analog_output'];

    if chk_param(gcb, mixer_type_param, 'Fine')
      msk.getParameter(nco_freq_param).Visible = 'on';
      msk.getParameter(nco_phase_param).Visible = 'on';
      msk.getParameter(coarse_freq_param).Visible = 'off';

      if ~chk_param(gcb, analog_mode_param, 'I/Q')
        msk.getParameter(mixer_mode_param).TypeOptions = {'I/Q -> Real'};
      end

    elseif chk_param(gcb, mixer_type_param, 'Coarse')
      set_param(gcb, nco_freq_param, '0'); % not exactly necessary to reset to zero
      set_param(gcb, nco_phase_param, '0');
      msk.getParameter(nco_freq_param).Visible = 'off';
      msk.getParameter(nco_phase_param).Visible = 'off';

      if ~chk_param(gcb, analog_mode_param, 'I/Q')
        msk.getParameter(mixer_mode_param).TypeOptions = {'Real -> Real', 'I/Q -> Real'};
      end % else don't change it from what it is as I/Q, which is I/Q -> I/Q

      if chk_param(gcb, mixer_mode_param, 'I/Q -> Real')
        msk.getParameter(coarse_freq_param).TypeOptions = {'Fs/2', 'Fs/4', '-Fs/4'};
      elseif chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
        msk.getParameter(coarse_freq_param).TypeOptions = {'Fs/2', 'Fs/4', '-Fs/4', '0'};
      else
        msk.getParameter(coarse_freq_param).TypeOptions = {'0'};
      end
      msk.getParameter(coarse_freq_param).Visible = 'on';

  end
end
