function spead_unpack_init(block, hdrs)

current_consts = find_system(block, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'RegExp' ,'on', 'name', '.*header_const[0-9]');
header_ids = eval(hdrs);
num_headers = length(header_ids);
if length(current_consts) == num_headers,
    all_match = true;
    for ctr = 1 : num_headers,
        val = eval(get_param(current_consts{ctr}, 'const'));
        val2 = header_ids(ctr);
        if val ~= val2,
            all_match = false;
        end
    end
    if all_match == true,
        % still all the same
        return
    end
end

if num_headers < 1,
    error('Must have at least one header!');
end
set_param([block, '/num_item_pts'], 'const', num2str(num_headers));
set_param([block, '/num_headers'], 'const', num2str(num_headers+1));
set_param([block, '/num_headers'], 'n_bits', num2str(ceil(log2(num_headers+1))));
set_param([block, '/hdr_ctr'], 'n_bits', num2str(ceil(log2(num_headers+1))));
delay = 1;

% remove existing header blocks and their lines
header_blks = find_system(block, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'RegExp' ,'on', 'name', '.*(hdr|header_).*[0-9]');
for b = 1 : length(header_blks),
    blk = header_blks{b};
    delete_block_lines(blk);
    delete_block(blk);
end

% set the size of the error or block
set_param([block, '/error_or'], 'inputs', num2str(2 + length(header_ids)));

% draw the blocks
showname = 'off';
for ctr = 1 : length(header_ids),
    name_from = ['header_from', num2str(ctr)];
    name_reg = ['header_reg', num2str(ctr)];
    name_delay = ['header_delay', num2str(ctr)];
    name_slice = ['header_slice', num2str(ctr)];
    name_relational = ['header_rel', num2str(ctr)];
    name_constant = ['header_const', num2str(ctr)];
    name_out = ['hdr', num2str(ctr)];
    row_y = 70 + (ctr * 75);
    row_x = 1500 - (ctr * 50);
    reuse_block(block, name_from, 'built-in/from', ...
        'GotoTag', 'hdr_word_change', 'showname', showname, ...
        'Position', [row_x, row_y + 25, row_x + 10, row_y + 38]);
    reuse_block(block, name_constant, 'xbsIndex_r4/Constant', ...
        'showname', showname, 'const', num2str(header_ids(ctr)), ...
        'arith_type', 'Unsigned', 'bin_pt', '0', ...
        'n_bits', 'spead_msw - spead_lsw', ...
        'Position', [row_x + 50, row_y + 50, row_x + 100, row_y + 60]);
    reuse_block(block, name_reg, 'xbsIndex_r4/Register', ...
        'showname', showname, 'en', 'on', ...
        'Position', [row_x + 50, row_y, row_x + 100, row_y + 40]);
    reuse_block(block, name_delay, 'xbsIndex_r4/Delay', ...
        'showname', showname, 'Latency', num2str(delay+1), ...
        'Position', [row_x + 210, row_y, row_x + 230, row_y + 20]);
    reuse_block(block, name_slice, 'xbsIndex_r4/Slice', ...
        'showname', showname, 'nbits', 'spead_msw - spead_lsw', ...
        'mode', 'Upper Bit Location + Width', ...
        'bit1', '0', ...
        'Position', [row_x + 150, row_y + 25, row_x + 180, row_y + 45]);
    reuse_block(block, name_relational, 'xbsIndex_r4/Relational', ...
        'showname', showname, 'Latency', num2str(delay), ...
        'mode', 'a!=b', ...
        'Position', [row_x + 210, row_y + 28, row_x + 230, row_y + 48]);
    reuse_block(block, name_out, 'built-in/outport', ...
        'showname', 'on', 'Port', num2str(5 + ctr), ...
        'Position', [1755, row_y+3, 1785, row_y + 17]);
end

% connect them
for ctr = 1 : length(header_ids),
    name_from = ['header_from', num2str(ctr)];
    name_reg = ['header_reg', num2str(ctr)];
    name_delay = ['header_delay', num2str(ctr)];
    name_slice = ['header_slice', num2str(ctr)];
    name_relational = ['header_rel', num2str(ctr)];
    name_constant = ['header_const', num2str(ctr)];
    name_out = ['hdr', num2str(ctr)];
    if ctr == length(header_ids),
        add_line(block, ['from_gbe_data',  '/1'], [name_reg, '/1'], 'autorouting', 'on');
    else
        last_reg = ['header_reg', num2str(ctr+1)];
        add_line(block, [last_reg,  '/1'], [name_reg, '/1'], 'autorouting', 'on');
    end
    if ctr == 1,
        add_line(block, [name_reg, '/1'], 'reg_hdr_one/1', 'autorouting', 'on');
    end
    add_line(block, [name_from,  '/1'], [name_reg, '/2'], 'autorouting', 'on');
    add_line(block, [name_reg, '/1'], [name_slice, '/1'], 'autorouting', 'on');
    add_line(block, [name_slice, '/1'], [name_relational, '/1'], 'autorouting', 'on');
    add_line(block, [name_slice, '/1'], [name_delay, '/1'], 'autorouting', 'on');
    add_line(block, [name_constant, '/1'], [name_relational, '/2'], 'autorouting', 'on');
    add_line(block, [name_delay, '/1'], [name_out, '/1'], 'autorouting', 'on');
    add_line(block, [name_relational, '/1'], ['error_or/', num2str(ctr+2)], 'autorouting', 'on');
    ph = get_param([block, '/', name_delay], 'PortHandles');
    set_param(ph.Outport(1), 'name', name_out);
    ph = get_param([block, '/', name_slice], 'PortHandles');
    set_param(ph.Outport(1), 'name', ['spid', num2str(ctr)]);
    ph = get_param([block, '/', name_relational], 'PortHandles');
    set_param(ph.Outport(1), 'name', ['err', num2str(ctr)]);
    ph = get_param([block, '/', name_constant], 'PortHandles');
    set_param(ph.Outport(1), 'name', ['exp', num2str(ctr)]);
end


end