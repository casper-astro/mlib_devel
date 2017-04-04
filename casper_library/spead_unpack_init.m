function spead_unpack_init(block)

function rvname = get_port_name(counter)
    if counter == 1,
        rvname = 'hdr_heap_id';
    elseif counter == 2,
        rvname = 'hdr_heap_size';
    elseif counter == 3,
        rvname = 'hdr_heap_offset';
    elseif counter == 4,
        rvname = 'hdr_pkt_len';
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

all_match = true;

% check the given headers against the current ones
current_outprts = find_system(block, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'RegExp' ,'on', 'name', 'hdr[0-9].*', 'BlockType', 'Outport');
num_inprts = length(current_outprts);
num_headers = length(header_ids) - 4;
if length(header_ids) < 5,
    error('Must have at least compulsory headers and one other header!');
end

% if there's a different number, we have to redraw
if num_inprts ~= num_headers,
    %fprintf('Different number of headers to last time, redrawing: %i -> %i\n', num_inprts, num_headers);
    all_match = false;
end

% are there the same headers in the same order?
if all_match == true,
    for ctr = 1 : num_headers,
        prt = current_outprts{ctr};
        prtnum = str2double(get_param(prt, 'Port')) - 9;
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

% has the error option changed?
error_change = false;
combine_errors = strcmp(get_param(block, 'combine_errors'), 'on');
error_or_blk = find_system(block, 'LookUnderMasks', 'all', 'name', 'error_or');
if (~isempty(error_or_blk) && (combine_errors == 0)) || (isempty(error_or_blk) && (combine_errors == 1)),
    error_change = true;
end

% everything still the same?
if (all_match == true) && (error_change == false),
    %fprintf('Nothing has changed, exiting.\n');
    return
end

num_headers = length(header_ids);
num_total_hdrs = num2str(num_headers+1);
total_hdrs_bits = num2str(ceil(log2(num_headers+2)));
set_param([block, '/num_item_pts'], 'const', num2str(num_headers));
set_param([block, '/num_headers'], 'const', num_total_hdrs);
set_param([block, '/num_headers'], 'n_bits', total_hdrs_bits);
set_param([block, '/hdr_ctr'], 'n_bits', total_hdrs_bits);
delay = 1;

showname = 'off';

% remove existing header blocks and their lines
header_blks = find_system(block, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'RegExp' ,'on', 'name', '.*(hdr|header_).*[0-9]');
for b = 1 : length(header_blks),
    blk = header_blks{b};
    delete_block_lines(blk);
    delete_block(blk);
end

% delete some lines that will be remade, possibly from other blocks
err_blks = find_system(block, 'LookUnderMasks', 'all', 'RegExp' ,'on', 'name', 'err.*');
for b = 1 : length(err_blks),
    blk = err_blks{b};
    delete_block_lines(blk);
end

% set the size of the error or block
if combine_errors == 1,
    try delete_block([block, '/err_hdr']); catch eid, end
    try delete_block([block, '/err_pktlen']); catch eid, end
    reuse_block(block, 'error_or', 'xbsIndex_r4/Logical', ...
        'showname', showname, 'logical_function', 'OR', ...
        'inputs', num2str(2 + num_headers), ...
        'Position', [1665, 150 + ((num_headers+1) * 75), 1720, 150 + ((num_headers+1) * 75) + ((num_headers+1) * 10)]);
    reuse_block(block, 'eof_out_from', 'built-in/from', ...
        'GotoTag', 'eof_out', 'showname', showname, ...
        'Position', [1665, 220 + ((num_headers+1) * 75), 1720, 234 + ((num_headers+1) * 75)]);
    reuse_block(block, 'error_gate', 'xbsIndex_r4/Logical', ...
        'showname', showname, 'logical_function', 'AND', ...
        'inputs', '2', ...
        'Position', [1760, 150 + ((num_headers+1) * 75), 1800, 190 + ((num_headers+1) * 75)]);
    reuse_block(block, 'error', 'built-in/outport', ...
        'showname', 'on', 'Port', '5', ...
        'Position', [1840, 1143, 1880, 1157]);
    add_line(block, 'badpktand/1', 'error_or/1', 'autorouting', 'on');
    add_line(block, 'hdr_chk/1', 'error_or/2', 'autorouting', 'on');
    add_line(block, 'error_or/1', 'error_gate/1', 'autorouting', 'on');
    add_line(block, 'eof_out_from/1', 'error_gate/2', 'autorouting', 'on');
    add_line(block, 'error_gate/1', 'error/1', 'autorouting', 'on');
else
    try delete_block([block, '/error_or']); catch eid, end
    try delete_block([block, '/error']); catch eid, end
    try delete_block([block, '/error_gate']); catch eid, end
    reuse_block(block, 'err_pktlen', 'built-in/outport', ...
        'showname', 'on', 'Port', '6', ...
        'Position', [1755, 1143, 1785, 1157]);
    reuse_block(block, 'err_hdr', 'built-in/outport', ...
        'showname', 'on', 'Port', '5', ...
        'Position', [1755, 1103, 1785, 1123]);
    add_line(block, 'badpktand/1', 'err_pktlen/1', 'autorouting', 'on');
    add_line(block, 'hdr_chk/1', 'err_hdr/1', 'autorouting', 'on');
end

% draw the blocks
for ctr = 1 : num_headers,
    this_ctr = num2str(ctr);
    name_from = ['header_from', this_ctr];
    name_reg = ['header_reg', this_ctr];
    name_delay = ['header_delay', this_ctr];
    name_slice = ['header_slice', this_ctr];
    name_slice2 = ['header_vslice', this_ctr];
    name_relational = ['header_rel', this_ctr];
    name_error = ['err_hdr', this_ctr];
    name_constant = ['header_const', this_ctr];
    name_out = get_port_name(ctr);
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
        'reg_retiming', 'on', ...
        'showname', showname, 'Latency', num2str(delay+1), ...
        'Position', [row_x + 210, row_y, row_x + 230, row_y + 20]);
    reuse_block(block, name_slice2, 'xbsIndex_r4/Slice', ...
        'showname', showname, 'nbits', 'spead_lsw', ...
        'mode', 'Lower Bit Location + Width', ...
        'bit0', '0', ...
        'Position', [row_x + 150, row_y, row_x + 180, row_y + 20]);
    reuse_block(block, name_slice, 'xbsIndex_r4/Slice', ...
        'showname', showname, 'nbits', 'spead_msw - spead_lsw', ...
        'mode', 'Upper Bit Location + Width', ...
        'bit1', '0', ...
        'Position', [row_x + 150, row_y + 25, row_x + 180, row_y + 45]);
    reuse_block(block, name_relational, 'xbsIndex_r4/Relational', ...
        'showname', showname, 'Latency', num2str(delay), ...
        'mode', 'a!=b', ...
        'Position', [row_x + 210, row_y + 28, row_x + 230, row_y + 48]);
    if combine_errors == 1,
        try delete_block([block, '/', name_error]); catch eid, end
        outportnum = 5 + ctr;
    else
        reuse_block(block, name_error, 'built-in/outport', ...
            'showname', 'on', 'Port', num2str(6 + (ctr*2)), ...
            'Position', [1755, row_y+33, 1785, row_y + 47]);
        outportnum = 6 + (ctr*2) - 1;
    end
    reuse_block(block, name_out, 'built-in/outport', ...
        'showname', 'on', 'Port', num2str(outportnum), ...
        'Position', [1755, row_y+3, 1785, row_y + 17]);
end

% connect them
for ctr = 1 : num_headers,
    this_ctr = num2str(ctr);
    name_from = ['header_from', this_ctr];
    name_reg = ['header_reg', this_ctr];
    name_delay = ['header_delay', this_ctr];
    name_slice = ['header_slice', this_ctr];
    name_slice2 = ['header_vslice', this_ctr];
    name_relational = ['header_rel', this_ctr];
    name_error = ['err_hdr', this_ctr];
    name_constant = ['header_const', this_ctr];
    name_out = get_port_name(ctr);
    if ctr == num_headers,
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
    add_line(block, [name_reg, '/1'], [name_slice2, '/1'], 'autorouting', 'on');
    add_line(block, [name_slice, '/1'], [name_relational, '/1'], 'autorouting', 'on');
    add_line(block, [name_slice2, '/1'], [name_delay, '/1'], 'autorouting', 'on');
    add_line(block, [name_constant, '/1'], [name_relational, '/2'], 'autorouting', 'on');
    add_line(block, [name_delay, '/1'], [name_out, '/1'], 'autorouting', 'on');
    if combine_errors == 1,
        add_line(block, [name_relational, '/1'], ['error_or/', num2str(ctr+2)], 'autorouting', 'on');
    else
        add_line(block, [name_relational, '/1'], [name_error, '/1'], 'autorouting', 'on');
    end
    ph = get_param([block, '/', name_delay], 'PortHandles');
    set_param(ph.Outport(1), 'name', name_out);
    ph = get_param([block, '/', name_slice], 'PortHandles');
    set_param(ph.Outport(1), 'name', ['spid', this_ctr]);
    ph = get_param([block, '/', name_relational], 'PortHandles');
    set_param(ph.Outport(1), 'name', ['err', this_ctr]);
    ph = get_param([block, '/', name_constant], 'PortHandles');
    set_param(ph.Outport(1), 'name', ['exp', this_ctr]);
end
add_line(block, 'header_delay4/1', 'check_datalen/2', 'autorouting', 'on');

clean_blocks(block);

end