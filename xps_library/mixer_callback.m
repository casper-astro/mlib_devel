function [] = mixer_callback(gcb, tile, slice, arch)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);

  if strcmp(tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    prefix = 'DT';
  end

  a = slice;

  % only run the function if the architecture matches
  if (arch == prefix)

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
          mixertype_callback(gcb,tile,slice+1,arch);
        end
      end
    end

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  elseif ~(strcmp(tile_arch, 'dual') && (tile > 229)) %indicates a dac
    analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_analog_output'];
    %if chk_param(gcb, analog_mode_param, 'I/Q')
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
        else % digital output is IQ->Real
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode']).TypeOptions = {'Real -> Real', 'I/Q -> Real'};
          if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_mode'], 'I/Q -> Real')
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type']).TypeOptions = {'Fine','Coarse'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type'],'Fine')
          else
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type']).TypeOptions = {'Bypassed'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_mixer_type'],'Bypassed');
          end
          if strcmp(get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a+1), '_enable']),'on')
            DataDialog.Enabled  = 'on';
            MixerDialog.Enabled = 'on';
            AnalogDialog.Enabled= 'on';
          end
          if chk_param(gcb, mixer_mode_param, 'I/Q -> Real')
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type']).TypeOptions = {'Fine','Coarse'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'],'Fine')
          else %Real->Real
            msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type']).TypeOptions = {'Bypassed'};
            set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'],'Bypassed');
          end
          mixertype_callback(gcb,tile,slice,arch)
        end

      else %odd slices still need to do mixer settings
        if chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'], 'I/Q -> Real')
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type']).TypeOptions = {'Fine','Coarse'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'],'Fine')
        elseif chk_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_mode'], 'Real -> Real')
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type']).TypeOptions = {'Bypassed'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'],'Bypassed');
        else %mode is IQ IQ, mixer should be 'Off'
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type']).TypeOptions = {'Off'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(a), '_mixer_type'],'Off');
        end
        mixertype_callback(gcb,tile,slice,arch)
      end
    %end
  end
  update_axis_clk_label(gcb,tile); %need to run this to potentially update required axi clk
  end
end
