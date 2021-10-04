function [] = enable_adc_opt(gcb,tile,slicenum)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
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

    else
      DataDialog.Enabled   = 'on';
      MixerDialog.Enabled  = 'on';
      AnalogDialog.Enabled = 'on';
      %msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slicenum), '_enable']).Value = 'on';
      %set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc',  num2str(slicenum), '_enable'], 'on');
      % validate clocking when bringing slice back up
      update_axis_clk(gcb,tile);
    end
  end
end

