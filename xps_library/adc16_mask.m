
cursys = gcb;

delete_lines(cursys);

gw_name = clear_name(cursys);

% TODO Get from mask parameter
num_adcs = 1;

chips = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'};

y=20;

for chip=1:8
  if chip > 4 && num_adcs == 1
    break
  end

  for channel=1:4
    port_num = num2str((chip-1)*4 + channel);
    inport_name  = sprintf('%s%d_sim', chips{chip}, channel);
    gateway_name = sprintf('%s_%s%d', gw_name, chips{chip}, channel);
    outport_name = sprintf('%s%d', chips{chip}, channel);

    inport_pos  = [ 20, y,    20+30, y+14];
    gateway_pos = [100, y-3, 100+70, y+17];
    outport_pos = [210, y,   210+30, y+14];
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
