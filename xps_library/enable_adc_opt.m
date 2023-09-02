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

    EnableStatus = get_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_enable']);
    if strcmp(EnableStatus, 'off')
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';
      if ~mod(slice,2)
        neighborEnableStatus = msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_enable']).Enabled;
        if strcmp(neighborEnableStatus, 'off')
          % If the neighboring slice checkbox dialog is 'off' (greyed out) when turning the even slice off, then the
          % neighbor needs to be re-enabled removing the I/Q -> I/Q mixer setting and replacing with a valid config
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_mixer_mode']).TypeOptions = {'Real -> I/Q'};
          msk.getParameter(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_mixer_type']).TypeOptions = {'Fine', 'Coarse'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_mixer_mode'], 'Real -> I/Q');
          % update mixer
          %mixer_callback(gcb, tile, slice+1, prefix);
          mixertype_callback(gcb, tile, slice+1, prefix);

          % re-enable the neighbors (odd slice) configuration dialogs (un-grey them)
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_DataSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_MixerSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_adc', num2str(slice+1), '_AnalogSettings']).Enabled = 'on';
        end
      end
    else % EnableStatus is 'on' (checked)
      if ~mod(slice, 2) % an even slice
        DataDialog.Enabled   = 'on';
        MixerDialog.Enabled  = 'on';
        AnalogDialog.Enabled = 'on';
        mixer_callback(gcb,tile,slice,prefix);
      else % odd slice
        mixer_mode_param = ['t', num2str(tile), '_', prefix, '_adc', num2str(slice), '_mixer_mode'];
        if ~chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
          DataDialog.Enabled   = 'on';
          MixerDialog.Enabled  = 'on';
          AnalogDialog.Enabled = 'on';
        end % else configured in I/Q->I/Q mode and the dialog should remain disabled (greyed out)
      end

    end % strcmp()
    % validate clocking when bringing slices up and down
    update_axis_clk(gcb, tile);
  end % tile < 228
end % function

