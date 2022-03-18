function [] = enable_dac_opt(gcb,tile,slicenum)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    prefix = 'DT';
  end

  if ~(strcmp(tile_arch, 'dual') && (tile > 229))
    DataDialog   = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_DataSettings']);
    MixerDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_MixerSettings']);
    AnalogDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_AnalogSettings']);

    EnableStatus = get_param(gcb,['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_enable']);
    if strcmp(EnableStatus, 'on')
      %if chk_param(gcb, [prefix, '_adc', num2str(a), '_enable'], 'on')
      DataDialog.Enabled   = 'on';
      MixerDialog.Enabled  = 'on';
      AnalogDialog.Enabled = 'on';

      %manually changing the parameter value
      %msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_enable']).Value = 'on';
      %set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac',  num2str(slicenum), '_enable'], 'on');

      % validate clocking when bringing slice back up
      update_axis_clk(gcb,tile);

      if (strcmp(get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_mixer_mode']), 'I/Q -> I/Q'))
        %turning the slice on and it is already I/Q->I/Q, need to copy and
        %set the neighbor slice appropriately
        mixer_callback(gcb,tile,slicenum,prefix);
        if ~mod(slicenum,2) %only do this for an even slice
          mixertype_callback(gcb,tile,slicenum+1,prefix);
        end
      end

    else
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';
      if ~(mod(slicenum,2))
        EnableStatus = msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_enable']).Enabled;
        if strcmp(EnableStatus, 'off')
          %if the neighboring slice enable.Enabled is 'off' , then the neighbor needs to be re-enabled and turned to a valid config
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_mixer_mode']).TypeOptions = {'Real -> Real', 'I/Q -> Real'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_analog_output'], 'Real');
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_mixer_mode'], 'Real -> Real');
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_DataSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_MixerSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum+1), '_AnalogSettings']).Enabled = 'on';

          %validate_analog_data(gcb,tile,slice+1,arch);
          %update_axis_clk(gcb,tile);
          mixer_callback(gcb,tile,slicenum+1,prefix); %update mixer
          mixertype_callback(gcb,tile,slicenum+1,prefix); %update mixer
        end
      end
      %manually changing the parameter value
      %msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_enable']).Value = 'off';
      %set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac',  num2str(slicenum), '_enable'], 'off');
    end
  end
end

