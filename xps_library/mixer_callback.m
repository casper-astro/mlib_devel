function [] = mixer_callback(gcb, tile, slice, arch)

  % TODO gen 3 DUC has different capabilities, does this need to go here
  [~, adc_tile_arch, dac_tile_arch, ~, ~, ~, ~] = get_rfsoc_properties(gcb);

  if tile < 228
    tile_arch = adc_tile_arch;
  else
    tile_arch = dac_tile_arch;
  end

  if strcmp(tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    prefix = 'DT';
  end

  % only run the function if the architecture matches
  if ~strcmp(arch, prefix) return; end

  msk = Simulink.Mask.get(gcb);

  a = slice;

  if tile < 228 % indicates an adc
    % get current configuration
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

          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_mode']).TypeOptions = {'I/Q -> I/Q'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_mode'], 'I/Q -> I/Q');

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_dec_mode'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_dec_mode']));

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_sample_per_cycle'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_sample_per_cycle']));

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_nyquist_zone'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_nyquist_zone']));

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_cal_mode'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a), '_cal_mode']));

          DataDialog.Enabled  = 'off';
          MixerDialog.Enabled = 'off';
          AnalogDialog.Enabled= 'off';
          mixertype_callback(gcb,tile,slice+1,arch);
        else % mixer mode is not IQ->IQ
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_mode']).TypeOptions = {'Real -> I/Q'};
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
          if strcmp(get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_enable']),'on')
            DataDialog.Enabled  = 'on';
            MixerDialog.Enabled = 'on';
            AnalogDialog.Enabled= 'on';
          end
          mixertype_callback(gcb, tile, slice+1, arch);
        end % chk_param() I/Q -> I/Q
      end % mod() an even slice
    end % chk_param() I/Q

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  else % indicates a dac
    analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'];
    if chk_param(gcb, analog_mode_param, 'I/Q')
      % override if an even slice is C output with C2C mixer
      if ~mod(a,2) % an even slice
        DataDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_DataSettings']);
        MixerDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_MixerSettings']);
        AnalogDialog= msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_AnalogSettings']);

        % no need to check if ditial output is C because C2C only an option if already C
        mixer_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'];
        if chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable'], 'on');
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable']).Enabled = 'off';

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_analog_output'], 'I/Q');

          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type']).TypeOptions = {'Off'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type'], 'Off');

          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode']).TypeOptions = {'I/Q -> I/Q'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode'], 'I/Q -> I/Q');

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_inter_mode'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_inter_mode']));

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_sample_per_cycle'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_sample_per_cycle']));

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_nyquist_zone'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_nyquist_zone']));

          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_decode_mode'],...
                    get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_decode_mode']));

          DataDialog.Enabled  = 'off';
          MixerDialog.Enabled = 'off';
          AnalogDialog.Enabled= 'off';
          mixertype_callback(gcb,tile,slice+1,arch);
        else % mixer mode is IQ -> Real
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode']).TypeOptions = {'Real -> Real', 'I/Q -> Real'}; %
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
          if strcmp(get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable']),'on')
            DataDialog.Enabled  = 'on';
            MixerDialog.Enabled = 'on';
            AnalogDialog.Enabled= 'on';
          end
          mixertype_callback(gcb, tile, slice, arch)
        end
      end % is an even slice

    else % output mode is Real
      mixer_type_param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'];
      mixer_mode_param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'];
      coarse_freq_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_coarse_freq'];
      if chk_param(gcb, mixer_type_param, 'Coarse')
        if chk_param(gcb, mixer_mode_param, 'I/Q -> Real')
          msk.getParameter(coarse_freq_param).TypeOptions = {'Fs/2', 'Fs/4', '-Fs/4'};
        else
          msk.getParameter(coarse_freq_param).TypeOptions = {'0'};
        end
      end

    end % chk_param() I/Q
  end % check if adc or dac
  update_axis_clk_label(gcb,tile); %need to run this to potentially update required axi clk
end % function
