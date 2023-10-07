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
        else % mixer mode on the odd slice is not IQ->IQ, make changes to setup the odd slice appropriately
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_enable']).Enabled = 'on';
          if strcmp(get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_enable']),'on')
            DataDialog.Enabled  = 'on';
            MixerDialog.Enabled = 'on';
            AnalogDialog.Enabled= 'on';
            if ~chk_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_digital_output'], 'Real')
              % only edit the mixer mode if the odd slice is not real digital output
              msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_mode']).TypeOptions = {'Real -> I/Q'};
              msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(a+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
            end
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
        % no need to check if digital output is C because C2C only an option if already C
        mixer_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'];
        if chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
          % force enable (check the box) the neighboring tile and grey out the checkbox
          oddslice_enable_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable'];
          set_param(gcb, oddslice_enable_param, 'on');
          msk.getParameter(oddslice_enable_param).Enabled = 'off';

          % force the analog output to be I/Q and turn off mixer type and modes
          oddslice_analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_analog_output'];
          msk.getParameter(oddslice_analog_mode_param).TypeOptions = {'I/Q'};
          set_param(gcb, oddslice_analog_mode_param, 'I/Q');

          oddslice_mixer_type_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type'];
          msk.getParameter(oddslice_mixer_type_param).TypeOptions = {'Off'};
          set_param(gcb, oddslice_mixer_type_param, 'Off');

          oddslice_mixer_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode'];
          msk.getParameter(oddslice_mixer_mode_param).TypeOptions = {'I/Q -> I/Q'};
          set_param(gcb, oddslice_mixer_mode_param, 'I/Q -> I/Q');

          % copy interpolation factor, samples per cycle, nyquist zone, and decode mode from even slice to odd slice
          oddslice_inter_mode_param  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_inter_mode'];
          evenslice_inter_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_inter_mode'];
          set_param(gcb, oddslice_inter_mode_param, get_param(gcb, evenslice_inter_mode_param));

          oddslice_samp_per_cycle  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_sample_per_cycle'];
          evenslice_samp_per_cycle = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_sample_per_cycle'];
          set_param(gcb, oddslice_samp_per_cycle, get_param(gcb, evenslice_samp_per_cycle));

          oddslice_nyquist_zone  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_nyquist_zone'];
          evenslice_nyquist_zone = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_nyquist_zone'];
          set_param(gcb, oddslice_nyquist_zone, get_param(gcb, evenslice_nyquist_zone ));

          oddslice_decode_mode  = ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_decode_mode'];
          evenslice_decode_mode = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_decode_mode'];
          set_param(gcb, oddslice_decode_mode, get_param(gcb, evenslice_decode_mode));

          % mixertype_callback(gcb,tile,slice+1,arch);

          % disable configuration dialogs
          DataDialog   = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_DataSettings']);
          MixerDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_MixerSettings']);
          AnalogDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_AnalogSettings']);
          DataDialog.Enabled  = 'off';
          MixerDialog.Enabled = 'off';
          AnalogDialog.Enabled= 'off';
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
