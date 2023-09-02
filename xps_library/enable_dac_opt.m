function [] = enable_dac_opt(gcb, tile, slice, arch)
  % this function should only be called for dac tiles

  [~, ~, dac_tile_arch, ~, ~, ~, ~] = get_rfsoc_properties(gcb);
  if strcmp(dac_tile_arch, 'quad')
    prefix = 'QT';
  elseif strcmp(dac_tile_arch, 'dual')
    prefix = 'DT';
  end

  % only run the function if the architecture matches
  if ~strcmp(arch, prefix) return; end

  msk = Simulink.Mask.get(gcb);

  if tile > 227
    DataDialog   = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_DataSettings']);
    MixerDialog  = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_MixerSettings']);
    AnalogDialog = msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_AnalogSettings']);

    EnableStatus = get_param(gcb,['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_enable']);
    if strcmp(EnableStatus, 'on')
      if ~mod(slice, 2) % an even slice
        DataDialog.Enabled   = 'on';
        MixerDialog.Enabled  = 'on';
        AnalogDialog.Enabled = 'on';
        % if an I/Q tile comes back up this forces the odd slice neighbor to be configured I/Q too
        mixer_callback(gcb, tile, slice, prefix);
      else % odd slice
        analog_mode_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_analog_output'];
        if ~chk_param(gcb, analog_mode_param, 'I/Q')
          DataDialog.Enabled   = 'on';
          MixerDialog.Enabled  = 'on';
          AnalogDialog.Enabled = 'on';
        end % else configured in I/Q output mode and the dialog should remain disabled (greyed out)
      end

    else % EnableStatus is 'off' (unchecked)
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';
      if ~mod(slice,2) % an even slice
        neighborEnableStatus = msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_enable']).Enabled;
        if strcmp(neighborEnableStatus, 'off')
          % This case is needed if this even slice output is I/Q and then disable the even slice (which is the only way
          % the neighbor would have had a greyed enable checkbox)
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_analog_output']).TypeOptions = {'Real'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_analog_output'], 'Real');
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_mixer_mode']).TypeOptions = {'Real -> Real', 'I/Q -> Real'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_mixer_mode'], 'Real -> Real');

          % turn mixer back on (remove 'Off' setting) and update the type options
          neighbor_mixer_type_param = ['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_mixer_type'];
          msk.getParameter(neighbor_mixer_type_param).TypeOptions = {'Coarse', 'Fine'};
          set_param(gcb, neighbor_mixer_type_param, 'Coarse');
          mixertype_callback(gcb, tile, slice+1, arch);

          % re-enable the neighbors (odd slice) configuration dialogs (un-grey them)
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_DataSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_MixerSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_AnalogSettings']).Enabled = 'on';
        end
      end
    end % strcmp()
    % validate clocking when bringing slices up and down
    update_axis_clk(gcb,tile);
  end % tile > 227
end % function

