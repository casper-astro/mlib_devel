% Known work to do and issues to fix:
%
% TODO: Mask does nothing to place the gateway blocks nicely

% TODO: Dual-Tile ADCs (e.g., zcu111 has not been tested): top level init does not
% implement drawing for the interfaces. Callbacks are not set.

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

% NOTE: Only maxis_tdata filed implemented. The ADC ignores tready and it is
% reasonably accurate to assume that the data will be valid before the user
% design is ready. Also, problems are typically handled and reported through
% the IRQ.

function [] = rfdc_mask(gcb);
  if strcmp(bdroot, 'xps_library')
    % exit early as to not run initialization for building out xps_library models
    return
  end

  msk = Simulink.Mask.get(gcb);

  [gen, tile_arch, fs_max, fs_min] = get_rfsoc_properties(gcb);

  adcbits = 16;
  gw_arith_type = 'Signed';
  gw_bin_pt = 0;

  if strcmp(tile_arch, 'quad') 

    % get both enabled tiles an un-enabled tiles
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
    for a = 0:3
      if chk_mask_param(msk, ['QT_adc', num2str(a), '_enable'], 'on')
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
        error('Tile 224 must be enabled when using Multi-Tile Synchronizatoin');
        return
      end
    end

    % interface name mXY_axis: X-Tile index, Y-ADC index
    % update interfaces for selected tiles
    for t = tiles
      for a = [0,1,2,3] % 4 ADCs per tile
        maxis = ['m', num2str(t), num2str(a), '_axis_tdata'];
        tdata = get_gw_obj(gcb, maxis);
        if chk_mask_param(msk, ['QT_adc', num2str(a), '_enable'], 'on')
          samples_per_cycle = msk.getParameter(['QT_adc', num2str(a), '_sample_per_cycle']).Value;
          n_bits = str2double(samples_per_cycle)*adcbits;
          if tdata.empty
            add_gw(gcb, tdata, gw_arith_type, num2str(n_bits), num2str(gw_bin_pt));
          else
            set_param(tdata.gw, 'n_bits', num2str(n_bits));
          end
        else
          if ~tdata.empty
            del_gw(gcb, tdata);
          end
        end
      end
    end

    % delete interfaces for un-enabled tiles
    for nt = ntiles
      for a = [0,1,2,3];
        maxis = ['m', num2str(nt), num2str(a), '_axis_tdata'];
        tdata = get_gw_obj(gcb, maxis);
        if ~tdata.empty
          del_gw(gcb, tdata);
        end
      end
    end

  elseif strcmp(tile_arch, 'dual') 
    error('Dual tile support not yet supported');
  end

  axis_clk_valid = validate_tile_clocking(gcb);
  if ~axis_clk_valid
    error(['Current ADC configuration results in inconsistent axi-stream (system) clocking ',...
           'between adc slices within a tile. Make sure data settings configuration results ',...
           'in a consistent required axi-stream (system) clock across all slices.']);
  end

  % let simulink auto-layout... didn't work as expected...
  %display('auto simulink layout');
  %Simulink.BlockDiagram.arrangeSystem(gcb);

end % function rfdc_mask

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [gw_obj] = get_gw_obj(blk, name)

  gw = find_system(blk, 'LookUnderMasks',  'on', 'FollowLinks', 'on',...
          'Name', [clear_name(blk), '_', name]); % name would be 'm00_axis_tdata' or the like

  if isempty(gw)
    iport = [blk, '/', name, '_sim']; % input from simulink into gateway for fpga simulation
    oport = [blk, '/', name];         % output of gateway into user fpga design
    gw = [blk, '/', clear_name(blk), '_', name];
    gw_obj = struct('empty', 1, 'name', name, 'gw', gw, 'iport', iport, 'oport', oport);
  else
    iport = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
            'Name', [name, '_sim']);
    oport = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
            'Name', name);
    gw_obj = struct('empty', 0, 'name', name, 'gw', gw, 'iport', iport, 'oport', oport);
  end

end

function [] = add_gw(gcb, gw_obj, arith_type, n_bits, bin_pt)

  add_block('built-in/Inport', gw_obj.iport);

  add_block('xbsIndex_r4/Gateway In', gw_obj.gw,...
              'arith_type', arith_type, 'n_bits', n_bits, 'bin_pt', bin_pt);

  add_block('built-in/Outport', gw_obj.oport);

  name = gw_obj.name;
  add_line(gcb, [name, '_sim', '/1'], [clear_name(gcb), '_', name, '/1']);
  add_line(gcb, [clear_name(gcb), '_', name, '/1'], [name, '/1']);

end

function [] = del_gw(gcb, gw_obj)
  name = gw_obj.name;
  delete_line(gcb, [name, '_sim', '/1'], [clear_name(gcb), '_', name, '/1']);
  delete_line(gcb, [clear_name(gcb), '_', name, '/1'], [name, '/1']);
  delete_block(gw_obj.iport);
  delete_block(gw_obj.oport);
  delete_block(gw_obj.gw);
end

