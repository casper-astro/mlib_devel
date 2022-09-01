function [] = enable_adc_opt(gcb,tile,slicenum)
  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    prefix = 'DT';
  end
 
  if ~(strcmp(tile_arch, 'dual') && (slicenum > 1))

    DataDialog   = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum), '_DataSettings']);
    MixerDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum), '_MixerSettings']);
    AnalogDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum), '_AnalogSettings']);

    %check what the value was before it was clicked (the value after click
    %only happens after you press the apply button, so we're checking what
    %it was before)

    if strcmp(get_param(gcb,['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum), '_enable']), 'off')
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';
      %manually changing the parameter value
      %msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum), '_enable']).Value = 'off';
      %set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc',  num2str(slicenum), '_enable'], 'off');
      if ~mod(slicenum,2)
        if (strcmp(msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_enable']).Enabled, 'off'))
          %if the neighboring slice enable is 'off' , then the neighbor
          %needs to be reenabled and turned to a valid config
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_mixer_mode']).TypeOptions = {'Real -> I/Q'};
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_mixer_mode'], 'Real -> I/Q');
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_DataSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_MixerSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum+1), '_AnalogSettings']).Enabled = 'on';

          mixer_callback(gcb,tile,slicenum+1,prefix); %update mixer
          mixertype_callback(gcb,tile,slicenum+1,prefix); %update mixer
        end
      end

    else
      DataDialog.Enabled   = 'on';
      MixerDialog.Enabled  = 'on';
      AnalogDialog.Enabled = 'on';
      % validate clocking when bringing slice back up
      update_axis_clk(gcb,tile);

      if (strcmp(get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum), '_mixer_mode']), 'I/Q -> I/Q'))
        %turning the slice on and it is already I/Q->I/Q, need to copy and
        %set the neighbor slice appropriately
        mixer_callback(gcb,tile,slicenum,prefix);
        if ~mod(slicenum,2)
          mixertype_callback(gcb,tile,slicenum+1,prefix);
        end
      end
    end
  end
end

