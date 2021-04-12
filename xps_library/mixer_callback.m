function [] = mixer_callback(gcb)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);

  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    prefix = 'DT';
  end

  % get current configuration
  for a = adc_slices
    % override if an even slice is C output with C2C mixer
    if ~mod(a,2) % an even slice
      DataDialog  = msk.getDialogControl([prefix, '_adc', num2str(a+1), '_DataSettings']);
      MixerDialog = msk.getDialogControl([prefix, '_adc', num2str(a+1), '_MixerSettings']);

      % no need to check if ditial output is C because C2C only an option if already C
      mixer_mode_param = [prefix, '_adc', num2str(a), '_mixer_mode'];
      if chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
        set_param(gcb, [prefix, '_adc', num2str(a+1), '_enable'], 'on');
        msk.getParameter([prefix, '_adc', num2str(a+1), '_enable']).Enabled = 'off';

        set_param(gcb, [prefix, '_adc', num2str(a+1), '_digital_output'], 'I/Q');

        msk.getParameter([prefix, '_adc', num2str(a+1), '_mixer_type']).TypeOptions = {'Off'};
        set_param(gcb, [prefix, '_adc', num2str(a+1), '_mixer_type'], 'Off');

        msk.getParameter([prefix, '_adc', num2str(a+1), '_mixer_mode']).TypeOptions = {'Off'};
        set_param(gcb, [prefix, '_adc', num2str(a+1), '_mixer_mode'], 'Off');

        set_param(gcb, [prefix, '_adc', num2str(a+1), '_dec_mode'],...
                  get_param(gcb, [prefix, '_adc', num2str(a), '_dec_mode']));

        set_param(gcb, [prefix, '_adc', num2str(a+1), '_sample_per_cycle'],...
                  get_param(gcb, [prefix, '_adc', num2str(a), '_sample_per_cycle']));

        DataDialog.Enabled  = 'off';
        MixerDialog.Enabled = 'off';
      else
        msk.getParameter([prefix, '_adc', num2str(a+1), '_enable']).Enabled = 'on';
        msk.getParameter([prefix, '_adc', num2str(a+1), '_mixer_mode']).TypeOptions = {'Real -> I/Q'};
        msk.getParameter([prefix, '_adc', num2str(a+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
        DataDialog.Enabled  = 'on';
        MixerDialog.Enabled = 'on';
      end
    end

  end

end
