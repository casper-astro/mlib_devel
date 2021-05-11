function [] = enable_adc_opt(gcb)

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
    DataDialog   = msk.getDialogControl([prefix, '_adc', num2str(a), '_DataSettings']);
    MixerDialog  = msk.getDialogControl([prefix, '_adc', num2str(a), '_MixerSettings']);
    AnalogDialog = msk.getDialogControl([prefix, '_adc', num2str(a), '_AnalogSettings']);

    if chk_mask_param(msk, [prefix, '_adc', num2str(a), '_enable'], 'on')
    %if chk_param(gcb, [prefix, '_adc', num2str(a), '_enable'], 'on')
      DataDialog.Enabled   = 'on';
      MixerDialog.Enabled  = 'on';
      AnalogDialog.Enabled = 'on';
      % validate clocking when bringing slice back up
      update_axis_clk(gcb);
    else
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';
    end
  end


end

