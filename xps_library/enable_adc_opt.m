function [] = enable_adc_opt(gcb, tile, slice, arch)
  % this function should only be called for adc tiles

  [~, adc_tile_arch, ~, ~, ~, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(adc_tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(adc_tile_arch, 'dual')
    prefix = 'DT';
  end

  % only run the function if the architecture matches
  if ~strcmp(arch, prefix) return; end

  msk = Simulink.Mask.get(gcb);

  if tile < 228
    DataDialog   = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_DataSettings']);
    MixerDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_MixerSettings']);
    AnalogDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_AnalogSettings']);

    % check what the value was before it was clicked
    % (the value after click only happens after you press the apply button, so
    % we're checking what it was before)

    if strcmp(get_param(gcb,['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_enable']), 'off')
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';
      if ~mod(slice,2)
        if (strcmp(msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_enable']).Enabled, 'off'))
          % If the neighboring slice enable is 'off' , then the neighbor needs to be reenabled and turned to a valid config
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_mixer_mode']).TypeOptions = {'Real -> I/Q'};
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_mixer_mode'], 'Real -> I/Q');
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_DataSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_MixerSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_AnalogSettings']).Enabled = 'on';
          % update mixer
          mixer_callback(gcb, tile, slice+1, prefix);
          mixertype_callback(gcb, tile, slice+1, prefix);
        end
      end
    else
      DataDialog.Enabled   = 'on';
      MixerDialog.Enabled  = 'on';
      AnalogDialog.Enabled = 'on';
      % validate clocking when bringing slice back up
      update_axis_clk(gcb, tile);

      if (strcmp(get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_mixer_mode']), 'I/Q -> I/Q'))
        % turning the slice on and it is already I/Q->I/Q, need to copy and set the neighbor slice appropriately
        mixer_callback(gcb,tile,slice,prefix);
        if ~mod(slice,2)
          mixertype_callback(gcb, tile, slice+1, prefix);
        end
      end
    end % strcmp()
  end % tile < 228
end % function

