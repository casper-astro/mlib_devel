msk = Simulink.Mask.get(gcb);

%chk_mask_param(msk, 'QT_adc0_digital_output', 'REAL')

% TODO get this constant from somewhere
QuadTile = 1;
adcbits = 16;
gw_arith_type = 'Signed';
gw_bin_pt = 0;

if QuadTile

  % get the bot enabled tiles an un-enabled tiles
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

else % Dual Tile
  % TODO

end

axis_clk_valid = validate_tile_clocking(gcb);
if ~axis_clk_valid
  error(['Current ADC configuration results in inconsistent axi-stream (system) clocking ',...
         'between adc slices within a tile. Make sure data settings configuration results ',...
         'in a consistent required axi-stream (system) clock across all slices.']);
end


% let simulink auto-layout
%display('auto simulink layout');
%Simulink.BlockDiagram.arrangeSystem(gcb);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I can do the above or I am somewhat thinking of instead having a gateway
% struct instead since there is an add_block, delete_block, add_line,
% delete_line for each object.

% TODO: all of this 'clear_name' stuff... why? I see it gives a unique name, how
% can simulink's unique name help?
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

% TODO: how much functionality, should this delete? able to do both? call it manage_gw?
% TODO: need to configure the gateway
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

function [maxis] = get_axis_interface(blk, if_name)

  display('creating an axis interface structure');
  tready = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
            'Name', [if_name, '_tready']);
  tdata  = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
            'Name', [if_name, '_tdata']);
  tvalid = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
            'Name', [if_name, '_tvalid']);

  gw_tready = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
               'Name', [clear_name(blk), '_' if_name, '_tready']);
  gw_tdata  = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
               'Name', [clear_name(blk), '_' if_name, '_tdata']);
  gw_tvalid = find_system(blk, 'LookUnderMasks', 'on', 'FollowLinks', 'on',...
               'Name', [clear_name(blk), '_' if_name, '_tvalid']);

  maxis = struct();

  %if isempty(tready)
  %  maxis.empty = 1;
  %  maxis.tready = [blk, '/', if_name, '_tready'];
  %  maxis.gw_tready = [blk, '/', clear_name(blk), '_', if_name, '_tready'];

  %  maxis.tdata  = [blk, '/', if_name, '_tdata'];
  %  maxis.gw_tdata  = [blk, '/', clear_name(blk), '_', if_name, '_tdata'];

  %  maxis.tvalid = [blk, '/', if_name, '_tvalid'];
  %  maxis.gw_tvalid = [blk, '/', clear_name(blk), '_', if_name, '_tvalid'];

  %else
  %  maxis.empty = 0;
    maxis.tdata = tdata;
    maxis.gw_tdata = gw_tdata;

    maxis.tvalid = tvalid;
    maxis.gw_tvalid = gw_tvalid;

    maxis.tready = tready;
    maxis.gw_tready = gw_tready;
  %end

end
