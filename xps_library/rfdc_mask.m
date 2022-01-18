% Known work to do and issues to fix:

% TODO: the lag in opening the mask is back after triming, drawing, cleaning is
% added because the initialization is ran every time the mask is re-opened. Need
% to either optimize base on how the callbacks are structured or implement a
% sort of state. Explored this with my own struct, but couldn't see how to make
% it persistent. I see the casper_library `save_state`/`same_state` methods.
% This might help here? May get worse as the sample rate check is now done every
% time

% TODO: make sure DT spliting data interfaces for complex doesn't mess with the
% computed data widths from number of samples per cycle (already double checked
% that it is right with regard to QT and since that works I recall that DT
% should be too).

% TODO: Sanitize and validate NCO freq range for fine mixer mode

% TODO: there is only a specific range of suggested tested frequencies for
% the fbdiv parameter that is tested within the specification given on
% DS926. These should be the ones that Vivado displays a warning when
% selected. Extend the same warning here. Need to figure out that range.

% TODO: Enabling I/Q -> I/Q and then chaning the decimation factor and axi
% samples per clock results in an invalid axi clocking configuration. This
% should not happen because the odd slice configuration is now dependent on
% the even slice.

% TODO: Enabling I/Q -> I/Q disables the odd slice ADC but when you hit OK and
% bring up the rfdc mask again the field is enabled. This is a symptom of the
% 'Enabled Checkbox being on' but not checking the even slice data mode
% correctly. (or it does check the mode correctly, but the callback appears
% in th wrong order).

% TODO: There are decimator capability improvements between rfsoc generations.
% Right now this yellow block only implements a common subset of the full
% capability. [1x,2x,4x,8x]

% NOTE: Only maxis_tdata field implemented. The ADC ignores tready and it is
% reasonably accurate to assume that the data will be valid before the user
% design is ready. Also, problems are typically handled and reported through
% the IRQ.

function [] = rfdc_mask(gcb,force)
  if strcmp(bdroot, 'xps_library')
    % exit early as to not run initialization for building out xps_library models
    return
  end

  msk = Simulink.Mask.get(gcb);

  [gen, tile_arch, fs_max, fs_min] = get_rfsoc_properties(gcb);

  adcbits = 16;
  gw_arith_type = 'Signed';
  gw_bin_pt = 0;

  maxis_template = 'm%d%d_axis_tdata';
  saxis_template = 's%d%d_axis_tdata';

  adc_gate = 1;
  dac_gate = 0;

  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    dac_slices = 0:3;
    prefix = 'QT';
    QuadTile = 1;
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    dac_slices = 0:3;
    prefix = 'DT';
    QuadTile = 0;
  end

  %for each tile check tile number and change visibility
  %get both enabled tiles and disabled tiles
  %tiles represents all 8 tiles in order, 1 is on, 0 is off
  tiles = zeros(8,1);
  %DT config only has 2 DAC tiles
  if QuadTile
    lastTile = 231;
  else
    lastTile = 229;
  end

  for t = 224:lastTile % Xilinx tile mapping PG269 (v2.4, pg.11)
    if chk_mask_param(msk, ['Tile', num2str(t), '_enable'], 'on')
      tiles(t-223) = 1;
    end
  end

  % check that we have at least one Tile
  if (max(tiles) == 0)
    error('At least one ADC or DAC tile must be enabled');
    return
  end

  % check that every enabled tile has at least one slice enabled
  % map of enabled slices, rows are tiles, columns are slice numbers
  % 0 indicates off, 1 indicates enabled
  slices = zeros(8, length(dac_slices));
  % this will leave zeros in extra places for DT configs, due to the lack of
  % Tile-Slice symmetry between DT DACs (2 tiles 4 slices each) and ADCs (4
  % tiles 2 slices each)
  for t = 224:lastTile
    if t > 227
      num_slices = dac_slices;
      slicetype = '_dac';
    else
      num_slices = adc_slices;
      slicetype = '_adc';
    end
      for a = num_slices
          if chk_mask_param(msk, ['t',num2str(t),'_', prefix, slicetype, num2str(a), '_enable'], 'on')
              slices(t-223, a+1) = 1;
          end
      end
      if (tiles(t-223) == 1) && (max(slices(t-223,:)) == 0)
          error('At least one ADC or DAC must be enabled on each enabled tile');
          return
      end
  end

  % check if the state has changed
  if ~same_state(gcb,'Tiles',tiles,'Slices',slices,'TileArch',tile_arch) || force
    for tile = 224:231
      QTConf = msk.getDialogControl(sprintf('t%d_QuadTileConfig',tile));
      DTConf = msk.getDialogControl(sprintf('t%d_DualTileConfig',tile));
      SystemClocking = msk.getDialogControl('SystemClocking');
      if QuadTile
        QTConf.Visible = 'on';
        DTConf.Visible = 'off';
        SystemClocking.Visible = 'on';
      else
        QTConf.Visible = 'off';
        DTConf.Visible = 'on';
        SystemClocking.Visible = 'off';
      end
      if tile > 229
        QTDACtile = msk.getDialogControl(sprintf('Tile%d_container',tile));
        if QuadTile
          %turn on tiles 230 and 231
          QTDACtile.Visible = 'on';
        else
          %turn off tiles 230 and 231
          QTDACtile.Visible = 'off';
        end
      end
    end

    % validate use of MTS for each tile
    % adc tiles
    mts_adc = zeros(4,1);
    for t = 224:227
      mts_adc(t-223) = chk_mask_param(msk, ['t',num2str(t),'_enable_mts'], 'on');
      if mts_adc(t-223)
        if (~mts_adc(1) && ~tiles(1))
          error('Tile 224 must be enabled with Multi-Tile Synchronization on when using MTS on ADC tiles');
          return
        end
      end
    end
    % dac tiles
    mts_dac = zeros(4,1);
    for t = 228:lastTile
      mts_dac(t-227) = chk_mask_param(msk, ['t',num2str(t),'_enable_mts'], 'on');
      if mts_dac(t-227)
        if (~mts_dac(1) && ~tiles(5))
          error('Tile 228 must be enabled with Multi-Tile Synchronization on when using MTS on DAC tiles');
          return
        end
      end
    end

    % initial position drawing offsets
    xpos = 0;
    ypos = 40;
    port_num = 1;

    % trim lines to begin to reuse or delete blocks
    delete_lines(gcb);
    % gateway name for the block
    base_gw_name = clear_name(gcb);
    % interface name mXY_axis: X-Tile index, Y-ADC index TODO can possibly explain
    % Dual tile interface here instead of marked in todo block below
    % update interfaces for selected tiles

    % update ADC tiles
    for t = 224:227
      if tiles(t-223) %check if the tile is on
        %for a = adc_slices %[0,1,2,3] % 4 ADCs per tile
        for a = 0:length(slices(1,:))-1 % only need to go over the adcs activated now
          if slices(t-223,a+1) %check if the slice is on
            samples_per_cycle = get_param(gcb, ['t', num2str(t), '_', prefix, '_adc', num2str(a), '_sample_per_cycle']);
            n_bits = str2double(samples_per_cycle)*adcbits;
            %maxis = ['m', num2str(t), num2str(a), '_axis_tdata'];
            %if chk_mask_param(msk, [prefix, '_adc', num2str(a), '_enable'], 'on') - looping only enabled adcs now

            if QuadTile
              %only draw the gw if this is not an odd tile configured in IQ->IQ mode
              mixertype = get_param(gcb, ['t', num2str(t), '_', prefix, '_adc', num2str(a), '_mixer_type']);
              if ~strcmp(mixertype,'Off')
                maxis = sprintf(maxis_template, t-224, a);
                [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, adc_gate);
              end
            else
              % If not a quad tile we need to look at the mixer/digital output to determine what ports to activate.
              % The quad tile outputs IQ on the same stream. The Dual tile uses the alternate adc path
              digital_mode_param = ['t', num2str(t), '_', prefix, '_adc', num2str(a), '_digital_output'];
              mixer_mode_param   = ['t', num2str(t), '_', prefix, '_adc', num2str(a), '_mixer_mode'];
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
                    if chk_param(gcb, ['t', num2str(t), '_', prefix, '_adc', num2str(a-1), '_mixer_mode'], 'I/Q -> I/Q')
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
            end % QuadTile: add gw's/draw ports
          end
        end % a = adcs
      end
    end % t = tiles

    % update DAC tiles
    for t = 228:lastTile
      if tiles(t-223) %check if the tile is on
        for a = 0:length(slices(1,:))-1 % only need to go over the dacs activated now
          if slices(t-223,a+1) %check if the slice is on
            samples_per_cycle = msk.getParameter(['t', num2str(t), '_', prefix, '_dac', num2str(a), '_sample_per_cycle']).Value;
            n_bits = str2double(samples_per_cycle)*adcbits;
            %maxis = ['m', num2str(t), num2str(a), '_axis_tdata'];
            %if chk_mask_param(msk, [prefix, '_adc', num2str(a), '_enable'], 'on') - looping only enabled adcs now

            if QuadTile
              % only make port if this is not a odd slice used in IQ->IQ
              mixertype = get_param(gcb, ['t', num2str(t), '_', prefix, '_dac', num2str(a), '_mixer_type']);
              if ~strcmp(mixertype,'Off')
                maxis = sprintf(saxis_template, t-228, a);
                [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, dac_gate);
              end
            else %dual tile stuff

              analog_mode_param = ['t', num2str(t), '_', prefix, '_dac', num2str(a), '_analog_output'];
              mixer_mode_param   = ['t', num2str(t), '_', prefix, '_dac', num2str(a), '_mixer_mode'];
              if chk_param(gcb, analog_mode_param, 'Real')
                maxis = sprintf(saxis_template, t-228, a);
                [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, dac_gate);

              else % analog mode is I/Q
                %only the base slice (0 or 2) gets created
                if (a == 0 || a == 2)
                  maxis = sprintf(saxis_template, t-228, a);
                  [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos, dac_gate);
                end
              end
            end % QuadTile: add gw's/draw ports
          end
        end % a = adcs
      end
    end % t = tiles

    % save 'tiles' and 'slices' as a state to compare against later
    save_state(gcb,'Tiles',tiles,'Slices',slices,'TileArch',tile_arch);

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
