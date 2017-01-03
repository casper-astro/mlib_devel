function spead_pack_init(block)

function rvname = get_port_name(counter)
    if counter == 1,
        rvname = 'hdr_heap_id';
    elseif counter == 2,
        rvname = 'hdr_heap_size';
    elseif counter == 3,
        rvname = 'hdr_heap_offset';
    elseif counter == 4,
        rvname = 'hdr_pkt_len_words';
    else
        if bitand(header_direct_mask, header_ids(counter)) == 0,
            rvname = ['hdr', num2str(counter), '_', sprintf('0x%04x', header_ids(counter))];
        else
            rvname = ['hdr', num2str(counter), '_', sprintf('0x%04x_DIR', bitand(header_ids(counter), header_direct_mask-1))];
        end
    end
end

set_param(block, 'LinkStatus', 'inactive');

hdrs = get_param(block, 'header_ids');
hdrs_ind = get_param(block, 'header_ind_ids');
spead_msw = eval(get_param(block, 'spead_msw'));
spead_lsw = eval(get_param(block, 'spead_lsw'));
header_width_bits = spead_msw - spead_lsw;
header_direct_mask = pow2(header_width_bits-1);

% add a ONE on the MSb for the directly addressed headers
header_ids = spead_process_header_string(hdrs);
header_ids = [1,2,3,4,header_ids];
for ctr = 1 : length(header_ids),
    thisval = header_ids(ctr);
    newval = thisval + header_direct_mask;
    %fprintf('%i - %i -> %i\n', ctr, header_ids(ctr), newval);
    header_ids(ctr) = newval;
end
% add the indirect ones
header_ind_ids = spead_process_header_string(hdrs_ind);
header_ids = [header_ids, header_ind_ids];
num_headers = length(header_ids);

if num_headers < 5,
    error('Must have at least compulsory headers and one other header!');
end

all_match = true;

% check the given headers against the current ones
current_inprts = find_system(block, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'RegExp' ,'on', 'name', 'hdr[0-9].*', 'BlockType', 'Inport');
num_inprts = length(current_inprts);
num_headers = length(header_ids) - 4;

% if there's a different number, we have to redraw
if num_inprts ~= num_headers,
    %fprintf('Different number of headers to last time, redrawing: %i -> %i\n', num_inprts, num_headers);
    all_match = false;
end

% are there the same headers in the same order?
if all_match == true,
    for ctr = 1 : num_headers,
        prt = current_inprts{ctr};
        prtnum = str2double(get_param(prt, 'Port')) - 7;
        if prtnum ~= ctr,
            error('Receiving ports in an odd order - this should never happen?\n');
        end
        prt_hdrval = hex2dec(regexprep(regexprep(prt, [block, '/hdr[0-9]*_0x'], ''), '_.*', ''));
        if ~isempty(strfind(prt, 'DIR')),
            prt_hdrval = prt_hdrval + header_direct_mask;
        end
        new_hdrval = header_ids(ctr+4);
        if new_hdrval ~= prt_hdrval,
            %fprintf('Header at position %i has changed, redrawing: %i -> %i\n', ctr, prt_hdrval, new_hdrval);
            all_match = false;
            break
        end
    end
end

% has the number of bytes per word changed?
if all_match == true,
    padbits_new = log2(str2double(get_param(block, 'bytes_per_word')));
    padbits_old = str2double(get_param([block, '/header_4const4'], 'n_bits'));
    if padbits_new ~= padbits_old,
        %fprintf('Bytes per word has changed, redrawing: %i -> %i\n', padbits_old, padbits_new);
        all_match = false;
    end
end

% return if the headers were the same, nothing more to do
if all_match == true
    %fprintf('Nothing has changed, exiting.\n');
    return
end

num_headers = length(header_ids);
num_total_hdrs = num2str(num_headers+1);
total_hdrs_bits = num2str(ceil(log2(num_headers+2)));
set_param([block, '/num_item_pts'], 'const', num2str(num_headers));
set_param([block, '/num_headers'], 'const', num_total_hdrs);
set_param([block, '/num_headers'], 'n_bits', total_hdrs_bits);
set_param([block, '/hdr_ctr'], 'cnt_to', num_total_hdrs, 'n_bits', total_hdrs_bits);
set_param([block, '/delay_data'], 'latency', num_total_hdrs, 'reg_retiming', 'on');
set_param([block, '/delay_valid'], 'latency', num_total_hdrs, 'reg_retiming', 'on');

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
for ctr = 1 : num_headers,
    this_ctr = num2str(ctr);
    name_in = get_port_name(ctr);
    name_assert_in = ['hdra_', this_ctr];
    name_delay_in = ['hdrd_', this_ctr];
    name_to = ['header_to', this_ctr];
    name_constant = ['header_const', this_ctr];
    name_from = ['header_from', this_ctr];
    name_concat = ['header_cat', this_ctr];
    name_assert_id = ['header_assert', this_ctr];
    row_y = 150 + (ctr * 30);
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
%         'reg_retiming', 'on', ...
%         'showname', 'on', 'latency', num2str(num_headers + 1), ...
%         'Position', [row_x + 100, row_y, row_x + 120, row_y + 14]);
    reuse_block(block, name_delay_in, 'xbsIndex_r4/Delay', ...
        'reg_retiming', 'on', ...
        'showname', 'on', 'latency', num2str(ctr + 1), ...
        'Position', [row_x + 100, row_y, row_x + 120, row_y + 14]);
    reuse_block(block, name_to, 'built-in/goto', ...
        'GotoTag', ['hdr_', this_ctr], 'showname', showname, ...
        'Position', [row_x + 140, row_y, row_x + 160, row_y + 14]);
    row_y = 150 + (ctr * 75);
    row_x = 1340;
    reuse_block(block, name_constant, 'xbsIndex_r4/Constant', ...
        'showname', showname, 'const', num2str(header_ids(ctr)), ...
        'arith_type', 'Unsigned', 'bin_pt', '0', ...
        'n_bits', 'spead_msw - spead_lsw', ...
        'Position', [row_x, row_y, row_x + 50, row_y + 14]);
    % the pkt len is a special case, we need to convert it to bytes
    if ctr == 4,
        name_cast = ['header_4cast', this_ctr];
        name_concat2 = ['header_4cat', this_ctr];
        name_const2 = ['header_4const', this_ctr];
        padbits = log2(str2double(get_param(block, 'bytes_per_word')));
        reuse_block(block, name_from, 'built-in/from', ...
            'GotoTag', ['hdr_', this_ctr], 'showname', showname, ...
            'Position', [row_x - 145, row_y + 25, row_x - 95, row_y + 39]);
        reuse_block(block, name_cast, 'xbsIndex_r4/Convert', ...
            'showname', showname, 'arith_type', 'Unsigned', ...
            'n_bits', ['spead_lsw - ', num2str(padbits)], ...
            'bin_pt', '0', 'pipeline', 'on', ...
            'Position', [row_x - 75, row_y + 25, row_x - 25, row_y + 39]);
        reuse_block(block, name_const2, 'xbsIndex_r4/Constant', ...
            'showname', showname, 'const', '0', ...
            'arith_type', 'Unsigned', 'bin_pt', '0', ...
            'n_bits', num2str(padbits), ...
            'Position', [row_x - 75, row_y + 25 + 14 + 5, row_x - 25, row_y + 25 + 14 + 5 + 14]);
        reuse_block(block, name_concat2, 'xbsIndex_r4/Concat', ...
            'showname', showname, ...
            'Position', [row_x, row_y + 25, row_x + 50, row_y + 39 + 14]);
    else
        reuse_block(block, name_from, 'built-in/from', ...
            'GotoTag', ['hdr_', this_ctr], 'showname', showname, ...
            'Position', [row_x, row_y + 25, row_x + 50, row_y + 39]);
    end
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
for ctr = 1 : num_headers,
    this_ctr = num2str(ctr);
    name_in = get_port_name(ctr);
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
    if ctr == 4,
        name_cast = ['header_4cast', this_ctr];
        name_concat2 = ['header_4cat', this_ctr];
        name_const2 = ['header_4const', this_ctr];
        add_line(block, [name_from,  '/1'], [name_cast, '/1'], 'autorouting', 'on');
        add_line(block, [name_cast,  '/1'], [name_concat2, '/1'], 'autorouting', 'on');
        add_line(block, [name_const2,  '/1'], [name_concat2, '/2'], 'autorouting', 'on');
        add_line(block, [name_concat2,  '/1'], [name_concat, '/2'], 'autorouting', 'on');
    else
        add_line(block, [name_from,  '/1'], [name_concat, '/2'], 'autorouting', 'on');
    end
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
