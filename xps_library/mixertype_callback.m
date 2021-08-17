function [] = mixertype_callback(gcb)

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
    mixer_type_param = [prefix, '_adc', num2str(a), '_mixer_type'];
    nco_freq_param  = [prefix, '_adc', num2str(a), '_nco_freq'];
    nco_phase_param = [prefix, '_adc', num2str(a), '_nco_phase'];
    coarse_freq_param = [prefix, '_adc', num2str(a), '_coarse_freq'];

    if chk_param(gcb, mixer_type_param, 'Fine')
      % TODO: need to validate nco freq value, here is probably not the best
      % place just need to note it
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

    else % Bypassed
      set_param(gcb, nco_freq_param, '0');
      set_param(gcb, nco_phase_param, '0');
      msk.getParameter(nco_freq_param).Visible = 'off';
      msk.getParameter(nco_phase_param).Visible = 'off';

      msk.getParameter(coarse_freq_param).TypeOptions = {'0'};
      set_param(gcb, coarse_freq_param, '0');
      msk.getParameter(coarse_freq_param).Visible = 'off';
    end
  end
end
