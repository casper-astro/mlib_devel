
cursys = gcb;

delete_lines(cursys);

gw_name = clear_name(cursys);

% TODO Get from mask parameter
board_count = str2num(get_param(cursys, 'board_count'));

chips = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'};

x =  0;
y = 20;

for chip=1:8

  % Chip 5 is the first chip of the second board
  if chip == 5
    if board_count == 1
      break
    else
      % Second column
      x = 210+30+50;
      y = 20;
    end
  end

  for channel=1:4
    port_num = num2str((chip-1)*4 + channel);
    inport_name  = sprintf('%s%d_sim', chips{chip}, channel);
    gateway_name = sprintf('%s_%s%d', gw_name, chips{chip}, channel);
    outport_name = sprintf('%s%d', chips{chip}, channel);

    inport_pos  = [x+ 20, y,   x+ 20+30, y+14];
    gateway_pos = [x+100, y-3, x+100+70, y+17];
    outport_pos = [x+210, y,   x+210+30, y+14];
    y = y + 50;

    reuse_block(cursys, inport_name, 'built-in/inport', ...
      'Port', port_num, ...
      'Position', inport_pos);

    reuse_block(cursys, gateway_name, 'xbsIndex_r4/Gateway In', ...
      'arith_type', 'Signed', ...
      'n_bits', '8', ...
      'bin_pt', '7', ...
      'Position', gateway_pos);

    reuse_block(cursys, outport_name, 'built-in/outport', ...
      'Port', port_num, ...
      'Position', outport_pos);


    add_line(cursys, [inport_name,  '/1'], [gateway_name, '/1']);
    h=add_line(cursys, [gateway_name, '/1'], [outport_name, '/1']);
    set_param(h, 'Name', outport_name);
  end
end
clean_blocks(cursys);
