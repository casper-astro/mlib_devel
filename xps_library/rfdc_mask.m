% Known work to do and issues to fix:

% TODO: Sanitize and validate NCO freq range for fine mixer mode

% TODO: there is only a specific range of suggested tested frequencies for
% the fbdiv parameter that is tested within the specification given on
% DS926. These should be the ones that Vivado displays a warning when
% selected. Extend the same warning here. Need to figure out that range.

% NOTE: Only maxis_tdata field implemented. The ADC ignores tready and it is
% reasonably accurate to assume that the data will be valid before the user
% design is ready. Also, problems are typically handled and reported through
% the IRQ.

function [] = rfdc_mask(gcb,force)
  if strcmp(bdroot, 'xps_library')
    % exit early as to not run initialization for building out xps_library models
    return
  end

  % Disable link
  set_param(gcb, 'LinkStatus', 'inactive');

  msk = Simulink.Mask.get(gcb);

  [gen, adc_tile_arch, dac_tile_arch, adc_num_tile, dac_num_tile, fs_max, fs_min] = get_rfsoc_properties(gcb);

  adcbits = 16;
  gw_arith_type = 'Signed';
  gw_bin_pt = 0;

  % gateway name for the block
  base_gw_name = clear_name(gcb);
  adc_gate = 1;
  dac_gate = 0;

  maxis_template = 'm%d%d_axis_tdata';
  saxis_template = 's%d%d_axis_tdata';

  max_tiles = 8;
  num_tiles = adc_num_tile + dac_num_tile;
  lastTile = 224+num_tiles-1;

  % ADC tile/slices configuration
  if strcmp(adc_tile_arch, 'quad')
    adc_prefix = 'QT';
    num_adc_slices = 4;
    adc_slices = zeros(adc_num_tile, 4);
  elseif strcmp(adc_tile_arch, 'dual')
    adc_prefix = 'DT';
    num_adc_slices = 2;
    adc_slices = zeros(adc_num_tile, 2);
  end

  % DAC tiles/slices configuration
  if strcmp(dac_tile_arch, 'quad')
    dac_prefix = 'QT';
    num_dac_slices = 4;
    dac_slices = zeros(dac_num_tile, 4);
  elseif strcmp(dac_tile_arch, 'dual')
    dac_prefix = 'DT';
    num_dac_slices = 2;
    dac_slices = zeros(dac_num_tile, 2);
  end

  % check which tiles are enabled
  %`tiles` represents all `max_tiles` in order; 1 is 'enabled', 0 is 'disabled'
  tiles = zeros(max_tiles, 1);
  for t = 224:lastTile % Xilinx tile mapping PG269 (v2.4, pg.11)
    if chk_mask_param(msk, ['Tile', num2str(t), '_enable'], 'on')
      tiles(t-223) = 1;
    end
  end

  % enforce that at least one tile is enabled
  if (max(tiles) == 0)
    error('At least one ADC or DAC tile must be enabled');
    return
  end

  % check which slices in a tile are enabeld: 1 is 'enabled', 0 is disabled `slices` 
  for t = 224:lastTile
    % check adc slices
    if t < 228
      for a = 0:(num_adc_slices-1)
        if chk_mask_param(msk, ['t', num2str(t), '_', adc_prefix, '_adc', num2str(a), '_enable'], 'on')
          adc_slices(t-223, a+1) = 1;
        end
      end
      % enforce that a slice is enabled if the tile is
      if (tiles(t-223) == 1) && (max(adc_slices(t-223,:)) == 0)
        error('At least one ADC slice must be enabled on each enabled ADC tile');
        return
      end

    else % check dac slices
      for d = 0:(num_dac_slices-1)
        if chk_mask_param(msk, ['t', num2str(t), '_', dac_prefix, '_dac', num2str(d), '_enable'], 'on')
          dac_slices(t-227, d+1) = 1;
        end
      end
      % enforce that a slice is enabled if the tile is
      if (tiles(t-223) == 1) && (max(dac_slices(t-227,:)) == 0)
        error('At least one DAC slice must be enabled on each enabled DAC tile');
        return
      end
    end % t < 228
  end % t = 224:lastTile

  % check if the mask state has changed
  if ~same_state(gcb,'Tiles',tiles,'ADCSlices',adc_slices,'DACSlices',dac_slices,'ADCTileArch',adc_tile_arch,'DACTileArch',dac_tile_arch,'ModelName',base_gw_name) || force
    for tile = 224:231
      QTConf = msk.getDialogControl(sprintf('t%d_QuadTileConfig', tile));
      DTConf = msk.getDialogControl(sprintf('t%d_DualTileConfig', tile));
      if tile < 228 % adc
        if strcmp(adc_tile_arch, 'quad')
          QTConf.Visible = 'on';
          DTConf.Visible = 'off';
        else
          QTConf.Visible = 'off';
          DTConf.Visible = 'on';
        end
      else % dac
        if strcmp(dac_tile_arch, 'quad')
          QTConf.Visible = 'on';
          DTConf.Visible = 'off';
        else
          QTConf.Visible = 'off';
          DTConf.Visible = 'on';
        end
      end

      % disable/enable tile configuration tabs in mask
      tileContainer = msk.getDialogControl(sprintf('Tile%d_container', tile));
      if tile > lastTile
        tileContainer.Visible = 'off';
      else
        tileContainer.Visible = 'on';
      end
    end % tile = 224:231

    % enable 'System Clocking' configuration tab for gen3 silicon
    SystemClocking = msk.getDialogControl('SystemClocking');
    if gen > 1
        SystemClocking.Visible = 'on';
    else
        SystemClocking.Visible = 'off';
    end

    % validate MTS for adc tiles
    mts_adc = zeros(adc_num_tile,1);
    for t = 224:227
      mts_adc(t-223) = chk_mask_param(msk, ['t',num2str(t),'_enable_mts'], 'on');
    end
    if (mts_adc(1) && ~tiles(1))
      error('Tile 224 must be enabled with Multi-Tile Synchronization on when using MTS on ADC tiles');
      return
    end

    % validate MTS for dac tile
    mts_dac = zeros(dac_num_tile,1);
    for t = 228:lastTile
      mts_dac(t-227) = chk_mask_param(msk, ['t',num2str(t),'_enable_mts'], 'on');
    end
    if (mts_dac(1) && ~tiles(5))
      error('Tile 228 must be enabled with Multi-Tile Synchronization on when using MTS on DAC tiles');
      return
    end

    % initial position offsets for drawing
    xpos = 0;
    ypos = 40;
    port_num = 1;

    % trim lines to begin to reuse or delete blocks
    delete_lines(gcb);

    % update ADC tile interfaces for enabled tiles, interface name mXY_axis: X-Tile index, Y-ADC index
    for t = 224:227
      if tiles(t-223) % check if the tile is enabled
        for a = 0:(num_adc_slices-1)
          if adc_slices(t-223,a+1) % check if the slice is on
            samples_per_cycle = get_param(gcb, ['t', num2str(t), '_', adc_prefix, '_adc', num2str(a), '_sample_per_cycle']);
            n_bits = str2double(samples_per_cycle)*adcbits;

            if strcmp(adc_tile_arch, 'quad')
              %only draw the gw if this is not an odd tile configured in IQ->IQ mode
              mixertype = get_param(gcb, ['t', num2str(t), '_', adc_prefix, '_adc', num2str(a), '_mixer_type']);
              if ~strcmp(mixertype,'Off')
                maxis = sprintf(maxis_template, t-224, a);
                [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, adc_gate);
              end
            else
              % If not a quad tile we need to look at the mixer/digital output to determine what ports to activate.
              % The quad tile outputs IQ on the same stream. The Dual tile uses the alternate adc path
              digital_mode_param = ['t', num2str(t), '_', adc_prefix, '_adc', num2str(a), '_digital_output'];
              mixer_mode_param   = ['t', num2str(t), '_', adc_prefix, '_adc', num2str(a), '_mixer_mode'];
              if chk_param(gcb, digital_mode_param, 'Real')
                maxis = sprintf(maxis_template, t-224, 2*a);
                [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, adc_gate);

              else % digital mode is I/Q
                if chk_param(gcb, mixer_mode_param, 'Real -> I/Q')
                  %only need to draw the one port, not two at a time
                  maxis = sprintf(maxis_template, t-224, 2*a);
                  [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, adc_gate);

                  maxis = sprintf(maxis_template, t-224, 2*a+1);
                  [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, adc_gate);

                elseif chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
                  % In this case ADC 1 must be enabled so here we are assuming that the gui logic has been
                  % correct to pass adc = [0 ,1] and the both interfaces will be subsequently created
                  maxis = sprintf(maxis_template, t-224, a);
                  [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, adc_gate);

                else
                  if mod(a,2) %if odd slice, might have mixer mode mode 'off'
                    if chk_param(gcb, ['t', num2str(t), '_', adc_prefix, '_adc', num2str(a-1), '_mixer_mode'], 'I/Q -> I/Q')
                        %good to go, don't need to make a gw for this
                    else
                      errstr = 'Unexpected value %s for Odd Slice Mixer Mode detected when ADC Ditital Ouput is I/Q mode, this is a bug';
                      error(sprintf(errstr, get_param(gcb, mixer_mode_param)));
                    end
                  else
                    errstr = 'Unexpected value %s for Even Slice Mixer Mode detected when ADC Ditital Ouput is I/Q mode, this is a bug';
                    error(sprintf(errstr, get_param(gcb, mixer_mode_param)));
                  end
                end
              end
            end % strcmp(adc_tile_arc, 'qaud')
          end
          dec_interp_opts(gcb, t, a)
        end % a = adcs
      end
    end % t = tiles

    % update DAC tiles
    for t = 228:lastTile
      if tiles(t-223) % check if the tile is on
        for a = 0:(num_dac_slices-1)
          if dac_slices(t-227,a+1) % check if the slice is on
            samples_per_cycle = get_param(gcb, ['t', num2str(t), '_', dac_prefix, '_dac', num2str(a), '_sample_per_cycle']);
            n_bits = str2double(samples_per_cycle)*adcbits;

            if strcmp(dac_tile_arch, 'quad')
              % only make port if this is not a odd slice used in IQ->IQ
              mixertype = get_param(gcb, ['t', num2str(t), '_', dac_prefix, '_dac', num2str(a), '_mixer_type']);
              if ~strcmp(mixertype,'Off')
                maxis = sprintf(saxis_template, t-228, a);
                [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, dac_gate);
              end

            else % dac dual-tile stuff
              analog_mode_param = ['t', num2str(t), '_', dac_prefix, '_dac', num2str(a), '_analog_output'];
              mixer_mode_param   = ['t', num2str(t), '_', dac_prefix, '_dac', num2str(a), '_mixer_mode'];
              if chk_param(gcb, analog_mode_param, 'Real')
                maxis = sprintf(saxis_template, t-228, a);
                [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, dac_gate);

              else % dac analog mode is I/Q
                % only the base slice (0 or 2) gets created
                if (a == 0 || a == 2)
                  maxis = sprintf(saxis_template, t-228, a);
                  [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, dac_gate);
                end
              end
            end % strcmp(dac_tile_arch, 'quad')
          end
          dec_interp_opts(gcb, t, a)
        end % a = dacs
      end
    end % t = tiles

    % setup system clocking tab based on platform info
    rfdc_system_clocking_config(gcb);

    % save state to compare against on next call to the mask
    save_state(gcb,'Tiles',tiles,'ADCSlices',adc_slices,'DACSlices',dac_slices,'ADCTileArch',adc_tile_arch,'DACTileArch',dac_tile_arch,'ModelName',base_gw_name);

    % delete interfaces for disabled tiles
    clean_blocks(gcb);
  end % ~same_state

  % axis_clk_valid = validate_tile_clocking(gcb);
  % if ~axis_clk_valid
  %   error(['Current ADC configuration results in inconsistent axi-stream (system) clocking ',...
  %          'between adc slices within a tile. Make sure data settings configuration results ',...
  %          'in a consistent required axi-stream (system) clock across all slices.']);
  % end

end % function rfdc_mask

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ypos, port_num] = add_gw(gcb, base_gw_name, arith_type, n_bits, bin_pt, maxis, port_num, xpos, ypos, type)
  if type == 1 %1 is adc
    iport = sprintf('%s_sim', maxis);
    oport = sprintf('%s', maxis);
  elseif type == 0
    iport = sprintf('%s', maxis);
    oport = sprintf('%s_sim', maxis);
  end

  gwname = sprintf('%s_%s', base_gw_name, maxis);
  iport_pos = [xpos+ 20, ypos,   xpos+ 20+30, ypos+14];
  oport_pos = [xpos+210, ypos,   xpos+210+30, ypos+14];
  gw_pos    = [xpos+100, ypos-3, xpos+100+70, ypos+17];

  reuse_block(gcb, iport, 'built-in/inport', ...
      'Port', num2str(port_num), ...
      'Position', iport_pos);

  if type == 1
    xil_gate = 'xbsIndex_r4/Gateway In';
    reuse_block(gcb, gwname, xil_gate, ...
      'arith_type', arith_type, ...
      'n_bits', num2str(n_bits), ...
      'bin_pt', num2str(bin_pt), ...
      'Position', gw_pos);
  elseif type == 0
    xil_gate = 'xbsIndex_r4/Gateway Out';
    reuse_block(gcb, gwname, xil_gate, ...
      'Position', gw_pos);
  end


  reuse_block(gcb, oport, 'built-in/outport', ...
    'Port', num2str(port_num), ...
    'Position', oport_pos);

  add_line(gcb, [iport,  '/1'], [gwname, '/1']);
  line_handle = add_line(gcb, [gwname, '/1'], [oport, '/1']);
  set_param(line_handle, 'Name', oport);

  ypos = ypos + 80;
  port_num = port_num+1;
end % function add_gw
