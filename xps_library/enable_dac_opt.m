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
      DataDialog.Enabled   = 'on';
      MixerDialog.Enabled  = 'on';
      AnalogDialog.Enabled = 'on';

      % validate clocking when bringing slice back up
      update_axis_clk(gcb,tile);

      mixer_mode_param = get_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slice), '_mixer_mode']);
      if (strcmp(mixer_mode_param, 'I/Q -> I/Q'))
        % turning the slice on and it is already I/Q->I/Q, need to copy and set the neighbor slice appropriately
        mixer_callback(gcb, tile, slice, prefix);
        if ~mod(slice,2) % only do this for an even slice
          mixertype_callback(gcb, tile, slice+1, prefix);
        end
      end

    else % EnableStaus is 'off'
      DataDialog.Enabled   = 'off';
      MixerDialog.Enabled  = 'off';
      AnalogDialog.Enabled = 'off';
      if ~mod(slice,2)
        EnableStatus = msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_enable']).Enabled;
        if strcmp(EnableStatus, 'off')
          % if the neighboring slice enable.Enabled is 'off' , then the neighbor needs to be re-enabled and turned to a valid config
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_enable']).Enabled = 'on';
          msk.getParameter(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_mixer_mode']).TypeOptions = {'Real -> Real', 'I/Q -> Real'};
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_analog_output'], 'Real');
          set_param(gcb, ['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_mixer_mode'], 'Real -> Real');
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_DataSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_MixerSettings']).Enabled = 'on';
          msk.getDialogControl(['t', num2str(tile), '_', prefix, '_dac', num2str(slice+1), '_AnalogSettings']).Enabled = 'on';

          % update mixer
          mixer_callback(gcb, tile, slice+1, prefix);
          mixertype_callback(gcb, tile, slice+1, prefix);
        end
      end
    end % strcmp()
  end % tile > 227
end % function

