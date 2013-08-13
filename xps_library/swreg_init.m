function swreg_init(blk)

numios = str2double(get_param(blk, 'numios'));
io_dir = get_param(blk, 'io_dir');

% count the exising variable tabs
done = false;
existing_ios = 0;
while ~done,
    try
        get_param(blk, sprintf('name%i', existing_ios+1));
        existing_ios = existing_ios + 1;
    catch ex
        done = true;
    end
end

% if the mask is still being rewritten then just return
if existing_ios ~= numios,
    return
end

try
    munge_block(blk);
    remove_all_blks(blk);
    delete_lines(blk);
catch ex
    % If remove_all_blks throws a CallbackDelete exception (more specifically a
    % Simulink:Engine:CallbackDelete exception), then we're in a callback of some
    % sort so we shouldn't be removing blocks or redrawing things anyway so just return.
    if regexp(ex.identifier, 'CallbackDelete'),
        return
    end
    % Otherwise it's perhaps a legitamite exception so dump and rethrow it.
    dump_and_rethrow(ex);
end

% add the inputs, outputs and gateway out blocks, drawing lines between them
x_size =    100;
y_size =    20;
x_start =   100;
y_pos =     100;

% the rest depends on whether it's an in or out reg
if strcmp(io_dir, 'To Processor'),
    draw_to();
else
    draw_from();
end

total_width = 0;
for count_width = 1 : numios,
    total_width = total_width + str2double(get_param(blk, sprintf('bitwidth%i', count_width)));
end
if total_width > 32,
    msgbox('WARNING: total bitwidth > 32, the top bits will be truncated.');
end

% remove unconnected blocks
clean_blocks(blk);

function draw_to()
    y_pos_row = y_pos;
    if numios > 1,
        % concat block
        reuse_block(blk, 'concatenate', 'xbsIndex_r4/Concat', ...
          'Position', [x_start + (x_size * 2 * 2), y_pos_row, x_start + (x_size * 2 * 2) + (x_size/2), y_pos_row + (numios * y_size)], ...
          'num_inputs', num2str(numios));
    end
    % io delay
    reuse_block(blk, 'io_delay', 'xbsIndex_r4/Delay', 'latency', get_param(blk, 'io_delay'), 'reg_retiming', 'on', ...
            'Position', [x_start + (x_size * 2.5 * 2), y_pos_row, x_start + (x_size * 2.5 * 2) + (x_size/2), y_pos_row + y_size]);
    % cast block
    reuse_block(blk, 'cast_gw', 'xbsIndex_r4/Convert', ...
            'Position', [x_start + (x_size * 3 * 2), y_pos_row, x_start + (x_size * 3 * 2) + (x_size/2), y_pos_row + y_size], ...
            'arith_type', 'Unsigned', 'n_bits', '32', ...
            'bin_pt', '0');
    % gateway out block
    gwout_name = [strrep(blk, '/', '_'), '_user_data_in'];
    reuse_block(blk, gwout_name, 'xbsIndex_r4/Gateway Out', ...
            'Position', [x_start + (x_size * 4 * 2), y_pos_row, x_start + (x_size * 4 * 2) + (x_size/2), y_pos_row + y_size], ...
            'hdl_port', 'on');
    reuse_block(blk, 'sim_out', 'built-in/outport', 'Port', '1', ...
            'Position', [x_start + (x_size * 6 * 2), y_pos_row, x_start + (x_size * 6 * 2) + (x_size/2), y_pos_row + y_size]);
    if numios > 1,
        add_line(blk, 'concatenate/1', 'io_delay/1', 'autorouting', 'on');
    end
    add_line(blk, 'io_delay/1', 'cast_gw/1', 'autorouting', 'on');
    add_line(blk, 'cast_gw/1', [gwout_name, '/1'], 'autorouting', 'on');
    add_line(blk, [gwout_name, '/1'], 'sim_out/1', 'autorouting', 'on');
    % ports
    for pindex = 1 : numios,
        in_name = sprintf('out_%s', get_param(blk, sprintf('name%i', pindex)));
        reinterpret_name = sprintf('reint%i', pindex);
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Port', num2str(pindex), ...
            'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, reinterpret_name, 'xbsIndex_r4/Reinterpret', ...
            'Position', [x_start + (x_size * 1 * 2), y_pos_row, x_start + (x_size * 1 * 2) + (x_size/2), y_pos_row + y_size], ...
            'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
            'force_bin_pt', 'on', 'bin_pt', '0');
        add_line(blk, [in_name, '/1'], [reinterpret_name, '/1'], 'autorouting', 'on');
        if numios > 1,
            add_line(blk, [reinterpret_name, '/1'], ['concatenate/', num2str(pindex)], 'autorouting', 'on');
        else
            add_line(blk, [reinterpret_name, '/1'], 'io_delay/1', 'autorouting', 'on');
        end
        y_pos_row = y_pos_row + (y_size * 2);
    end
end

function draw_from()
    y_pos_row = y_pos;
    gwin_name = [strrep(blk, '/', '_'), '_user_data_out'];
    reuse_block(blk, gwin_name, 'xbsIndex_r4/Gateway In', ...
        'Position', [x_start + (x_size * 4 * 2), y_pos_row, x_start + (x_size * 4 * 2) + (x_size/2), y_pos_row + y_size], ...
        'arith_type', 'Unsigned', 'n_bits', '32', 'bin_pt', '0', 'period', get_param(blk, 'sample_period'));
    reuse_block(blk, 'io_delay', 'xbsIndex_r4/Delay', 'latency', get_param(blk, 'io_delay'), 'reg_retiming', 'on', ...
            'Position', [x_start + (x_size * 4.5 * 2), y_pos_row, x_start + (x_size * 4.5 * 2) + (x_size/2), y_pos_row + y_size]);
    add_line(blk, [gwin_name, '/1'], 'io_delay/1', 'autorouting', 'on');
    if numios > 1,
        addstr = '';
        for pindex = 1 : numios,
            addstr = [addstr, '+'];
        end
        reuse_block(blk, 'sim_add', 'simulink/Math Operations/Add', 'Inputs', addstr, 'OutDataTypeStr', 'uint32', ...
                'Position', [x_start + (x_size * 3 * 2), y_pos_row, x_start + (x_size * 3 * 2) + (x_size/2), y_pos_row + (y_size * numios)]);
        clear addstr;
        add_line(blk, 'sim_add/1', [gwin_name, '/1'], 'autorouting', 'on');
    end
    % ports
    total_width = 0;
    for pindex = 1 : numios,
        total_width = total_width + str2double(get_param(blk, sprintf('bitwidth%i', pindex)));
    end
    for pindex = 1 : numios,
        io_arith_type = get_param(blk, sprintf('arith_type%i', pindex));
        if strcmp(io_arith_type, 'Boolean'),
            sliceboolean = 'on';
        else
            sliceboolean = 'off';
        end
        if strcmp(io_arith_type, 'Signed  (2''s comp)'),
            shorttype = 'sfix';
        else
            shorttype = 'ufix';
        end
        io_bin_pt = str2double(get_param(blk, sprintf('bin_pt%i', pindex)));
        io_bitwidth = str2double(get_param(blk, sprintf('bitwidth%i', pindex)));
        total_width = total_width - io_bitwidth;
        in_name = sprintf('sim_%s', get_param(blk, sprintf('name%i', pindex)));
        convert_name1 = ['convert1_', num2str(pindex)];
        convert_name2 = ['convert2_', num2str(pindex)];
        gain_name = ['gain_', num2str(pindex)];
        out_name = sprintf('in_%s', get_param(blk, sprintf('name%i', pindex)));
        slice_name = sprintf('slice_%s', get_param(blk, sprintf('name%i', pindex)));
        reinterpret_name = sprintf('reint%i', pindex);
        reuse_block(blk, in_name, 'built-in/inport', 'Port', num2str(pindex), ...
            'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, convert_name1, 'simulink/Commonly Used Blocks/Data Type Conversion', 'OutDataTypeStr', sprintf('fixdt(''%s%i_En%i'')', shorttype, io_bitwidth, io_bin_pt), ...
            'LockScale', 'on', 'ConvertRealWorld', 'Real World Value (RWV)', ...
            'Position', [x_start + (x_size * 1 * 2), y_pos_row, x_start + (x_size * 1 * 2) + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, convert_name2, 'simulink/Commonly Used Blocks/Data Type Conversion', 'OutDataTypeStr', sprintf('fixdt(''ufix%i_En0'')', io_bitwidth), ...
            'LockScale', 'on', 'ConvertRealWorld', 'Stored Integer (SI)', ...
            'Position', [x_start + (x_size * 1.5 * 2), y_pos_row, x_start + (x_size * 1.5 * 2) + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, gain_name, 'simulink/Commonly Used Blocks/Gain', 'Gain', num2str(pow2(total_width)), ...
            'Position', [x_start + (x_size * 2 * 2), y_pos_row, x_start + (x_size * 2 * 2) + (x_size/2), y_pos_row + y_size]);
        if numios > 1,
            add_line(blk, [in_name, '/1'], [convert_name1, '/1'], 'autorouting', 'on');
            add_line(blk, [convert_name1, '/1'], [convert_name2, '/1'], 'autorouting', 'on');
            add_line(blk, [convert_name2, '/1'], [gain_name, '/1'], 'autorouting', 'on');
            add_line(blk, [gain_name, '/1'], ['sim_add/', num2str(pindex)], 'autorouting', 'on');
        else
            add_line(blk, [in_name, '/1'], [gwin_name, '/1'], 'autorouting', 'on');
        end
        reuse_block(blk, slice_name, 'xbsIndex_r4/Slice', ...
            'Position', [x_start + (x_size * 5 * 2), y_pos_row, x_start + (x_size * 5 * 2) + (x_size/2), y_pos_row + y_size], ...
            'nbits', num2str(io_bitwidth), 'boolean_output', sliceboolean, 'mode', 'Lower Bit Location + Width', 'bit0', num2str(total_width));
        if strcmp(sliceboolean, 'off'),
            reuse_block(blk, reinterpret_name, 'xbsIndex_r4/Reinterpret', ...
                'Position', [x_start + (x_size * 6 * 2), y_pos_row, x_start + (x_size * 6 * 2) + (x_size/2), y_pos_row + y_size], ...
                'force_arith_type', 'on', 'arith_type', io_arith_type, ...
                'force_bin_pt', 'on', 'bin_pt', num2str(io_bin_pt));
        end
        reuse_block(blk, out_name, 'built-in/outport', ...
            'Port', num2str(pindex), ...
            'Position', [x_start + (x_size * 7 * 2), y_pos_row, x_start + (x_size * 7 * 2) + (x_size/2), y_pos_row + y_size]);
        add_line(blk, 'io_delay/1', [slice_name, '/1'], 'autorouting', 'on');
        if strcmp(sliceboolean, 'off'),
            add_line(blk, [slice_name, '/1'], [reinterpret_name, '/1'], 'autorouting', 'on');
            add_line(blk, [reinterpret_name, '/1'], [out_name, '/1'], 'autorouting', 'on');
        else
            add_line(blk, [slice_name, '/1'], [out_name, '/1'], 'autorouting', 'on');
        end
        y_pos_row = y_pos_row + (y_size * 2);
    end
end

end