% Known work to do and issues to fix:

% TODO: updating the sample rate does not update the gui correctly (pll refclk,
% adc clk out). noticed this when extending gui to support DT because I had not
% added the `get_rfsoc_properties` to `update_adc_clkout` and in testing noticed
% changes were not being applied to get teh correct lower frequency's used on DT
% architectures

% TODO: make sure DT spliting data interfaces for complex doesn't mess with the
% computed data widths from number of samples per cycle

% TODO: the lag in opening the mask is back after triming, drawing, cleaning is
% added because the initialization is ran every time the mask is re-opened. Need
% to either optimize base on how the callbacks are structured or implement a
% sort of state. Explored this with my own struct, but couldn't see how to make
% it persistent. I see the casper_library `save_state`/`same_state` methods.
% This might help here?

% TODO: ADCs visibility not correct if mask starts with a check box disabled

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

function [] = rfdc_mask(gcb)
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

  if strcmp(tile_arch, 'quad')
    adc_slices = 0:3;
    prefix = 'QT';
    QuadTile = 1;
  elseif strcmp(tile_arch, 'dual')
    adc_slices = 0:1;
    prefix = 'DT';
    QuadTile = 0;
  end

  QTConf = msk.getDialogControl('QuadTileConfig');
  DTConf = msk.getDialogControl('DualTileConfig');
  if QuadTile
    QTConf.Visible = 'on';
    DTConf.Visible = 'off';
  else
    QTConf.Visible = 'off';
    DTConf.Visible = 'on';
  end

  %if strcmp(tile_arch, 'quad')
  % get both enabled tiles and diabled tiles
  tiles = [];
  ntiles = [];
  for t = 224:227 % Xilinx tile mapping PG269 (v2.4, pg.11)
    if chk_mask_param(msk, ['Tile', num2str(t), '_enable'], 'on')
      tiles = [tiles, t-224];
    else
      ntiles = [ntiles, t-224];
    end
  end

  % check that we have at least one Tile and ADC Slice to work with
  if isempty(tiles)
    error('At least one ADC tile must be enabled');
    return
  end

  adcs = [];
  for a = adc_slices
    if chk_mask_param(msk, [prefix, '_adc', num2str(a), '_enable'], 'on')
      adcs = [adcs, a];
    end
  end

  if isempty(adcs)
    error('At least one ADC must be enabled');
    return
  end

  % validate use of MTS
  mts = chk_mask_param(msk, 'enable_mts', 'on');
  if mts
    if ~sum(tiles==0)
      error('Tile 224 must be enabled when using Multi-Tile Synchronization');
      return
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
  for t = tiles
    %for a = adc_slices %[0,1,2,3] % 4 ADCs per tile
    for a = adcs % only need to go over the adcs activted now
      samples_per_cycle = msk.getParameter([prefix, '_adc', num2str(a), '_sample_per_cycle']).Value;
      n_bits = str2double(samples_per_cycle)*adcbits;
      %maxis = ['m', num2str(t), num2str(a), '_axis_tdata'];
      %if chk_mask_param(msk, [prefix, '_adc', num2str(a), '_enable'], 'on') - looping only enabled adcs now

      if QuadTile
        maxis = sprintf(maxis_template, t, a);
        [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos);
      else
        % TODO: make the below todo a comment describing what is happening tested
        % TODO: If not a quad tile we need to look at the mixer/digital output
        % to determine what ports to activate. The quad tile outputs IQ on the
        % same stream. The Dual tile uses the alternate adc path
        digital_mode_param = [prefix, '_adc', num2str(a), '_digital_output'];
        mixer_mode_param   = [prefix, '_adc', num2str(a), '_mixer_mode'];
        if chk_param(gcb, digital_mode_param, 'Real')
          maxis = sprintf(maxis_template, t, 2*a);
          [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos);

        else % digital mode is I/Q
          if chk_param(gcb, mixer_mode_param, 'Real -> I/Q')
            maxis = sprintf(maxis_template, t, 2*a);
            [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos);

            maxis = sprintf(maxis_template, t, 2*a+1);
            [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos);

          elseif chk_param(gcb, mixer_mode_param, 'I/Q -> I/Q')
            % In this case ADC 1 must be enabled so here we are assuming that
            % the gui logic has been correct to pass adc = [0 ,1] and the both
            % interfaces will be subsequently created
            maxis = sprintf(maxis_template, t, a);
            [ypos, port_num] = add_gw(gcb, base_gw_name, gw_arith_type, n_bits, gw_bin_pt, maxis, port_num, xpos, ypos);

          else
            errstr = 'Unexpected value %s for Mixer Mode detected when ADC Ditital Ouput is I/Q mode, this is a bug';
            error(sprintf(errstr, get_param(gcb, mixer_mode_param)));
          end
        end
      end % QuadTile: add gw's/draw ports
    end % a = adcs
  end % t = tiles

  % delete interfaces for disabled tiles
  clean_blocks(gcb);

  %elseif strcmp(tile_arch, 'dual')
  %  error('Dual tile support not yet supported');
  %end

  axis_clk_valid = validate_tile_clocking(gcb);
  if ~axis_clk_valid
    error(['Current ADC configuration results in inconsistent axi-stream (system) clocking ',...
           'between adc slices within a tile. Make sure data settings configuration results ',...
           'in a consistent required axi-stream (system) clock across all slices.']);
  end

end % function rfdc_mask

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ypos, port_num] = add_gw(gcb, base_gw_name, arith_type, n_bits, bin_pt, maxis, port_num, xpos, ypos)
  iport = sprintf('%s_sim', maxis);
  oport = sprintf('%s', maxis);
  gwname = sprintf('%s_%s', base_gw_name, maxis);
  iport_pos = [xpos+ 20, ypos,   xpos+ 20+30, ypos+14];
  oport_pos = [xpos+210, ypos,   xpos+210+30, ypos+14];
  gw_pos    = [xpos+100, ypos-3, xpos+100+70, ypos+17];

  reuse_block(gcb, iport, 'built-in/inport', ...
    'Port', num2str(port_num), ...
    'Position', iport_pos);

  reuse_block(gcb, gwname, 'xbsIndex_r4/Gateway In', ...
    'arith_type', arith_type, ...
    'n_bits', num2str(n_bits), ...
    'bin_pt', num2str(bin_pt), ...
    'Position', gw_pos);

  reuse_block(gcb, oport, 'built-in/outport', ...
    'Port', num2str(port_num), ...
    'Position', oport_pos);

  add_line(gcb, [iport,  '/1'], [gwname, '/1']);
  line_handle = add_line(gcb, [gwname, '/1'], [oport, '/1']);
  set_param(line_handle, 'Name', oport);

  ypos = ypos + 80;
  port_num = port_num+1;
end % function add_gw
