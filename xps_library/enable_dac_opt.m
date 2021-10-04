function [] = enable_dac_opt(gcb,tile,slicenum)

  msk = Simulink.Mask.get(gcb);

  [~, tile_arch, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(tile_arch, 'quad')
    dac_slices = 0:3;
    prefix = 'QT';
  elseif strcmp(tile_arch, 'dual')
    dac_slices = 0:3;
    prefix = 'DT';
  end

  if ~(strcmp(tile_arch, 'dual') && (tile > 229))
      
    DataDialog   = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_DataSettings']);
    MixerDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_MixerSettings']);
    AnalogDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_AnalogSettings']);
      
    if strcmp(get_param(gcb,['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_enable']), 'on')
      %if chk_param(gcb, [prefix, '_adc', num2str(a), '_enable'], 'on')
      DataDialog.Enabled   = 'on';
      MixerDialog.Enabled  = 'on';
      AnalogDialog.Enabled = 'on';
          
      %manually changing the parameter value
      %msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_enable']).Value = 'on';
      %set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac',  num2str(slicenum), '_enable'], 'on');

      % validate clocking when bringing slice back up
      update_axis_clk(gcb,tile);
    else
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';

      %manually changing the parameter value
      %msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slicenum), '_enable']).Value = 'off';
      %set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac',  num2str(slicenum), '_enable'], 'off');
    end
  end
end

