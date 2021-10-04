function [] = mixer_callback(gcb, tile)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);

  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    prefix = 'DT';
  end

  % TODO: this needs to be determined like the adc parameters based on the RFSoC chip
  dac_slices = 0:3;

  if tile < 228 % indicates an adc
    % get current configuration
    for a = adc_slices
      digital_mode_param = ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_digital_output'];
      if chk_param(gcb, digital_mode_param, 'I/Q')
        % override if an even slice is C output with C2C mixer
        if ~mod(a,2) % an even slice
          DataDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_DataSettings']);
          MixerDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_MixerSettings']);
          AnalogDialog= msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_AnalogSettings']);

          % no need to check if ditial output is C because C2C only an option if already C
          mixer_mode_param = ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_mixer_mode'];
          if chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_enable'], 'on');
            msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_enable']).Enabled = 'off';

            set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_digital_output'], 'I/Q');

            msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_type']).TypeOptions = {'Off'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_type'], 'Off');

            msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_mode']).TypeOptions = {'Off'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_mode'], 'Off');

            set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_dec_mode'],...
                      get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_dec_mode']));

            set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_sample_per_cycle'],...
                      get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_sample_per_cycle']));

            DataDialog.Enabled  = 'off';
            MixerDialog.Enabled = 'off';
            AnalogDialog.Enabled= 'off';
          else % digital output is Real
            msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_enable']).Enabled = 'on';
            msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_mode']).TypeOptions = {'Real -> I/Q'};
            msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
            DataDialog.Enabled  = 'on';
            MixerDialog.Enabled = 'on';
            AnalogDialog.Enabled= 'on';
          end
        end
      end
    end

  elseif ~(strcmp(tile_arch, 'dual') && (tile > 229)) %indicates a dac
    % get current configuration
    for a = dac_slices
      digital_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'];
      if chk_param(gcb, digital_mode_param, 'I/Q')
        % override if an even slice is C output with C2C mixer
        if ~mod(a,2) % an even slice
          DataDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_DataSettings']);
          MixerDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_MixerSettings']);
          AnalogDialog= msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_AnalogSettings']);

          % no need to check if analog output is C because C2C only an option if already C
          mixer_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'];
          if chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable'], 'on');
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable']).Enabled = 'off';

            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_digital_output'], 'I/Q');

            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type']).TypeOptions = {'Off'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type'], 'Off');

            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode']).TypeOptions = {'Off'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode'], 'Off');

            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_inter_mode'],...
                      get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_inter_mode']));

            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_sample_per_cycle'],...
                      get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_sample_per_cycle']));

            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_datapath_mode'],...
                      get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_datapath_mode']));

            DataDialog.Enabled  = 'off';
            MixerDialog.Enabled = 'off';
            AnalogDialog.Enabled= 'off';
          else % analog output is Real
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable']).Enabled = 'on';
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode']).TypeOptions = {'I/Q -> Real'};
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
            DataDialog.Enabled  = 'on';
            MixerDialog.Enabled = 'on';
            AnalogDialog.Enabled= 'on';
          end
        end
      end
    end
  end
end
