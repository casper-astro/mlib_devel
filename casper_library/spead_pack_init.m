function spead_pack_init(block, hdrs)

set_param(block, 'LinkStatus', 'inactive');

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
else
    all_match = false;
end

if num_headers < 1,
    error('Must have at least one header!');
end
set_param([block, '/num_item_pts'], 'const', num2str(num_headers));
set_param([block, '/num_headers'], 'const', num2str(num_headers+1));
set_param([block, '/num_headers'], 'n_bits', num2str(ceil(log2(num_headers))+1));
set_param([block, '/hdr_ctr'], 'n_bits', num2str(ceil(log2(num_headers))+1));
set_param([block, '/hdr_ctr'], 'cnt_to', num2str(num_headers+1));
set_param([block, '/delay_data'], 'latency', num2str(num_headers+1));
set_param([block, '/delay_valid'], 'latency', num2str(num_headers+1));

% return if the headers were the same, nothing more to do
if all_match == true
    return
end

% remove existing header blocks and their lines
header_blks = find_system(block, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'RegExp' ,'on', 'name', '.*(hdr|hdra_|header_).*[0-9]');
for b = 1 : length(header_blks),
    blk = header_blks{b};
    delete_block_lines(blk);
    delete_block(blk);
end

% set the size of the output mux
set_param([block, '/mainmux'], 'inputs', num2str(2 + num_headers));
ph = get_param([block, '/', 'assert_data'], 'PortHandles');
line = get_param(ph.Outport(1), 'Line');
if line > -1,
    delete_line(line);
end

% draw the blocks
showname = 'off';
for ctr = 1 : length(header_ids),
    this_ctr = num2str(ctr);
    name_in = ['hdr', this_ctr, '_', sprintf('0x%04x', header_ids(ctr))];
    name_assert_in = ['hdra_', this_ctr];
    name_delay_in = ['hdrd_', this_ctr];
    name_to = ['header_to', this_ctr];
    name_constant = ['header_const', this_ctr];
    name_from = ['header_from', this_ctr];
    name_concat = ['header_cat', this_ctr];
    name_assert_id = ['header_assert', this_ctr];
    row_y = 110 + (ctr * 30);
    row_x = 20;
    reuse_block(block, name_in, 'built-in/inport', ...
        'showname', 'on', 'Port', num2str(3 + ctr), ...
        'Position', [row_x, row_y, row_x + 30, row_y + 14]);
    reuse_block(block, name_assert_in, 'xbsIndex_r4/Assert', ...
        'showname', showname, 'assert_type', 'on', ...
        'type_source', 'Explicitly', 'arith_type', 'Unsigned', ...
        'bin_pt', '0', 'gui_display_data_type', 'Fixed-point', ...
        'n_bits', 'spead_lsw', ...
        'Position', [row_x + 50, row_y, row_x + 80, row_y + 14]);
%     reuse_block(block, name_delay_in, 'xbsIndex_r4/Delay', ...
%         'showname', 'on', 'latency', num2str(num_headers + 1), ...
%         'Position', [row_x + 100, row_y, row_x + 120, row_y + 14]);
    reuse_block(block, name_delay_in, 'xbsIndex_r4/Delay', ...
        'showname', 'on', 'latency', num2str(ctr + 1), ...
        'Position', [row_x + 100, row_y, row_x + 120, row_y + 14]);
    reuse_block(block, name_to, 'built-in/goto', ...
        'GotoTag', ['hdr_', this_ctr], 'showname', showname, ...
        'Position', [row_x + 140, row_y, row_x + 160, row_y + 14]);
    row_y = 110 + (ctr * 75);
    row_x = 1340;
    reuse_block(block, name_constant, 'xbsIndex_r4/Constant', ...
        'showname', showname, 'const', num2str(header_ids(ctr)), ...
        'arith_type', 'Unsigned', 'bin_pt', '0', ...
        'n_bits', 'spead_msw - spead_lsw', ...
        'Position', [row_x, row_y, row_x + 50, row_y + 14]);
    reuse_block(block, name_from, 'built-in/from', ...
        'GotoTag', ['hdr_', this_ctr], 'showname', showname, ...
        'Position', [row_x, row_y + 25, row_x + 50, row_y + 39]);
    reuse_block(block, name_concat, 'xbsIndex_r4/Concat', ...
        'showname', showname, ...
        'Position', [row_x + 75, row_y, row_x + 115, row_y + 40]);
    reuse_block(block, name_assert_id, 'xbsIndex_r4/Assert', ...
        'showname', showname, 'assert_type', 'on', ...
        'type_source', 'Explicitly', 'arith_type', 'Unsigned', ...
        'bin_pt', '0', 'gui_display_data_type', 'Fixed-point', ...
        'n_bits', 'spead_msw', ...
        'Position', [row_x + 130, row_y, row_x + 160, row_y + 14]);
end

% connect them
for ctr = 1 : length(header_ids),
    this_ctr = num2str(ctr);
    name_in = ['hdr', this_ctr, '_', sprintf('0x%04x', header_ids(ctr))];
    name_assert_in = ['hdra_', this_ctr];
    name_delay_in = ['hdrd_', this_ctr];
    name_to = ['header_to', this_ctr];
    name_constant = ['header_const', this_ctr];
    name_from = ['header_from', this_ctr];
    name_concat = ['header_cat', this_ctr];
    name_assert_id = ['header_assert', this_ctr];
    add_line(block, [name_in,  '/1'], [name_assert_in, '/1'], 'autorouting', 'on');
    add_line(block, [name_assert_in,  '/1'], [name_delay_in, '/1'], 'autorouting', 'on');
    add_line(block, [name_delay_in,  '/1'], [name_to, '/1'], 'autorouting', 'on');
    add_line(block, [name_constant,  '/1'], [name_concat, '/1'], 'autorouting', 'on');
    add_line(block, [name_from,  '/1'], [name_concat, '/2'], 'autorouting', 'on');
    add_line(block, [name_concat,  '/1'], [name_assert_id, '/1'], 'autorouting', 'on');
    add_line(block, [name_assert_id,  '/1'], ['mainmux/', num2str(ctr+2)], 'autorouting', 'on');
    ph = get_param([block, '/', name_assert_in], 'PortHandles');
    set_param(ph.Outport(1), 'name', name_in);
    ph = get_param([block, '/', name_constant], 'PortHandles');
    set_param(ph.Outport(1), 'name', ['spid', this_ctr]);
end

add_line(block, 'assert_data/1', ['mainmux/', num2str(3 + num_headers)], 'autorouting', 'on');
ph = get_param([block, '/', 'assert_data'], 'PortHandles');
set_param(ph.Outport(1), 'name', 'pkt_data');


end