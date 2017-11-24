function swreg_init(blk)

clog(sprintf('entering swreg_init(%s)', blk), 'trace');
check_mask_type(blk, 'swreg');
try
    munge_block(blk);
    remove_all_blks(blk, 1);
    delete_lines(blk);
catch ex
    if regexp(ex.identifier, 'CallbackDelete')
        return
    end
    dump_and_rethrow(ex);
end

% perform a sanity check on the mask values
[numios, current_names, current_widths, current_bins, current_types] = swreg_maskcheck(blk);

% should we make a sim in/out?
simport = true;
try
    if strcmp(get_param(blk, 'sim_port'), 'off')
        simport = false;
    end
catch ex
    % fall through to old default, adding the sim ports
end

% add the inputs, outputs and gateway out blocks, drawing lines between them
x_size =    100;
y_size =    20;
x_start =   100;
y_pos =     100;

% the rest depends on whether it's an in or out reg
% mode = get_param(blk, 'mode');
% current_names = textscan(strtrim(strrep(strrep(strrep(strrep(get_param(blk, 'names'), ']', ''), '[', ''), ',', ' '), '  ', ' ')), '%s');
% current_names = current_names{1};
% numios = length(current_names);
% current_types = eval(get_param(blk, 'arith_types'));
% current_bins = eval(get_param(blk, 'bin_pts'));
% current_widths = eval(get_param(blk, 'bitwidths'));
% if strcmp(mode, 'fields of equal size'),
%     ctypes = current_types;
%     cbins = current_bins;
%     cwidths = current_widths;
%     current_types = zeros(numios, 1);
%     current_bins = zeros(numios, 1);
%     current_widths = zeros(numios, 1);
%     for ctr = 1 : numios,
%         current_types(ctr) = ctypes(1);
%         current_bins(ctr) = cbins(1);
%         current_widths(ctr) = cwidths(1);
%     end
% end
io_dir = get_param(blk, 'io_dir');
if strcmp(io_dir, 'To Processor')
    iodir = 'output';
    draw_to();
else
    iodir = 'input';
    draw_from();
end

% remove unconnected blocks
clean_blocks(blk);

% update format string so we know what's going on with this block
show_format = get_param(blk, 'show_format');
if numios == 1
    display_string = strcat('1', ' ', iodir);
else
    display_string = sprintf('%d %ss', numios, iodir);
end
if strcmp(show_format, 'on')
    config_string = '';
    totalbits = 0;
    for ctr = 1 : numios
        switch current_types(ctr)
            case 1 
                config_string = strcat(config_string, sprintf('f%i.%i,', current_widths(ctr), current_bins(ctr)));
            case 2
                config_string = strcat(config_string, 'b,');
            otherwise 
                config_string = strcat(config_string, sprintf('uf%i.%i,', current_widths(ctr), current_bins(ctr)));
        end
        totalbits = totalbits + current_widths(ctr);
    end
    display_string = strcat(display_string, ': ', config_string);
    display_string = regexprep(display_string, ',$', '');
    display_string = sprintf('%s = %i bits', display_string, totalbits);
end
set_param(blk, 'AttributesFormatString', display_string);

clog('exiting swreg_init','trace');

function stype = type_to_string(arith_type)
    switch arith_type
        case 0
            stype = 'Unsigned';
            return
        case 1
            stype = 'Signed  (2''s comp)';
            return
        case 2
            stype = 'Boolean';
            return
        otherwise
            error('Unknown type %i', arith_type);
    end
end

function draw_to()
    y_pos_row = y_pos;
    if numios > 1
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
    if simport
        reuse_block(blk, 'sim_out', 'built-in/outport', 'Port', '1', ...
            'Position', [x_start + (x_size * 6 * 2), y_pos_row, x_start + (x_size * 6 * 2) + (x_size/2), y_pos_row + y_size]);
    else
        reuse_block(blk, 'sim_out', 'built-in/terminator', ...
            'Position', [x_start + (x_size * 6 * 2), y_pos_row, x_start + (x_size * 6 * 2) + (x_size/2), y_pos_row + y_size]);
    end
    if numios > 1
        add_line(blk, 'concatenate/1', 'io_delay/1', 'autorouting', 'on');
    end
    add_line(blk, 'io_delay/1', 'cast_gw/1', 'autorouting', 'on');
    add_line(blk, 'cast_gw/1', [gwout_name, '/1'], 'autorouting', 'on');
    add_line(blk, [gwout_name, '/1'], 'sim_out/1', 'autorouting', 'on');
    % ports
    for pindex = 1 : numios
        in_name = sprintf('out_%s', current_names{pindex});
        assert_name = sprintf('assert_%s', current_names{pindex});
        reinterpret_name = sprintf('reint%i', pindex);
        if current_types(pindex) == 2
            gddtype = 'Boolean';
        else
            gddtype = 'Fixed-point';
        end
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Port', num2str(pindex), ...
            'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, assert_name, 'xbsIndex_r4/Assert', ...
            'showname', 'off', 'assert_type', 'on', ...
            'type_source', 'Explicitly', 'arith_type', type_to_string(current_types(pindex)), ...
            'bin_pt', num2str(current_bins(pindex)), 'gui_display_data_type', gddtype, ...
            'n_bits', num2str(current_widths(pindex)), ...
            'Position', [x_start + (x_size * 1 * 1), y_pos_row, x_start + (x_size * 1 * 1) + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, reinterpret_name, 'xbsIndex_r4/Reinterpret', ...
            'Position', [x_start + (x_size * 1 * 2), y_pos_row, x_start + (x_size * 1 * 2) + (x_size/2), y_pos_row + y_size], ...
            'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
            'force_bin_pt', 'on', 'bin_pt', '0');
        add_line(blk, [in_name, '/1'], [assert_name, '/1'], 'autorouting', 'on');
        add_line(blk, [assert_name, '/1'], [reinterpret_name, '/1'], 'autorouting', 'on');
        if numios > 1
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
        'arith_type', 'Unsigned', 'n_bits', '32', 'bin_pt', '0', 'period', get_param(blk, 'sample_period'), ...
        'hdl_port', 'on');
    reuse_block(blk, 'io_delay', 'xbsIndex_r4/Delay', 'latency', get_param(blk, 'io_delay'), 'reg_retiming', 'on', ...
            'Position', [x_start + (x_size * 4.5 * 2), y_pos_row, x_start + (x_size * 4.5 * 2) + (x_size/2), y_pos_row + y_size]);
    add_line(blk, [gwin_name, '/1'], 'io_delay/1', 'autorouting', 'on');
    if numios > 1
        addstr = '';
        for pindex = 1 : numios
            addstr = [addstr, '+'];
        end
        reuse_block(blk, 'sim_add', 'simulink/Math Operations/Add', 'Inputs', addstr, 'OutDataTypeStr', 'uint32', ...
                'Position', [x_start + (x_size * 3 * 2), y_pos_row, x_start + (x_size * 3 * 2) + (x_size/2), y_pos_row + (y_size * numios)]);
        clear addstr;
        add_line(blk, 'sim_add/1', [gwin_name, '/1'], 'autorouting', 'on');
    end
    % ports
    total_width = sum(current_widths);
    for pindex = 1 : numios
        io_arith_type = current_types(pindex);
        if io_arith_type == 2
            sliceboolean = 'on';
        else
            sliceboolean = 'off';
        end
        if strcmp(io_arith_type, 'Signed  (2''s comp)')
            shorttype = 'sfix';
        else
            shorttype = 'ufix';
        end
        io_bin_pt = current_bins(pindex);
        io_bitwidth = current_widths(pindex);
        total_width = total_width - io_bitwidth;
        in_name = sprintf('sim_%i', pindex);
        convert_name1 = ['convert1_', num2str(pindex)];
        convert_name2 = ['convert2_', num2str(pindex)];
        gain_name = ['gain_', num2str(pindex)];
        out_name = sprintf('in_%s', current_names{pindex});
        slice_name = sprintf('slice_%s', current_names{pindex});
        reinterpret_name = sprintf('reint%i', pindex);
        if simport
            reuse_block(blk, in_name, 'built-in/inport', 'Port', num2str(pindex), ...
                'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
        else
            reuse_block(blk, in_name, 'built-in/constant', 'Value', '0', ...
                'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
        end
        reuse_block(blk, convert_name1, 'simulink/Commonly Used Blocks/Data Type Conversion', 'OutDataTypeStr', sprintf('fixdt(''%s%i_En%i'')', shorttype, io_bitwidth, io_bin_pt), ...
            'LockScale', 'on', 'ConvertRealWorld', 'Real World Value (RWV)', ...
            'Position', [x_start + (x_size * 1 * 2), y_pos_row, x_start + (x_size * 1 * 2) + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, convert_name2, 'simulink/Commonly Used Blocks/Data Type Conversion', 'OutDataTypeStr', sprintf('fixdt(''ufix%i_En0'')', io_bitwidth), ...
            'LockScale', 'on', 'ConvertRealWorld', 'Stored Integer (SI)', ...
            'Position', [x_start + (x_size * 1.5 * 2), y_pos_row, x_start + (x_size * 1.5 * 2) + (x_size/2), y_pos_row + y_size]);
        reuse_block(blk, gain_name, 'simulink/Commonly Used Blocks/Gain', 'Gain', num2str(pow2(total_width)), ...
            'Position', [x_start + (x_size * 2 * 2), y_pos_row, x_start + (x_size * 2 * 2) + (x_size/2), y_pos_row + y_size]);
        if numios > 1
            add_line(blk, [in_name, '/1'], [convert_name1, '/1'], 'autorouting', 'on');
            add_line(blk, [convert_name1, '/1'], [convert_name2, '/1'], 'autorouting', 'on');
            add_line(blk, [convert_name2, '/1'], [gain_name, '/1'], 'autorouting', 'on');
            add_line(blk, [gain_name, '/1'], ['sim_add/', num2str(pindex)], 'autorouting', 'on');
        else
            % add_line(blk, [in_name, '/1'], [gwin_name, '/1'], 'autorouting', 'on');
            add_line(blk, [in_name, '/1'], [convert_name1, '/1'], 'autorouting', 'on');
            add_line(blk, [convert_name1, '/1'], [convert_name2, '/1'], 'autorouting', 'on');
            add_line(blk, [convert_name2, '/1'], [gain_name, '/1'], 'autorouting', 'on');
            add_line(blk, [gain_name, '/1'], [gwin_name, '/1'], 'autorouting', 'on');
            
        end
        reuse_block(blk, slice_name, 'xbsIndex_r4/Slice', ...
            'Position', [x_start + (x_size * 5 * 2), y_pos_row, x_start + (x_size * 5 * 2) + (x_size/2), y_pos_row + y_size], ...
            'nbits', num2str(io_bitwidth), 'boolean_output', sliceboolean, 'mode', 'Lower Bit Location + Width', 'bit0', num2str(total_width));
        if strcmp(sliceboolean, 'off')
            reuse_block(blk, reinterpret_name, 'xbsIndex_r4/Reinterpret', ...
                'Position', [x_start + (x_size * 6 * 2), y_pos_row, x_start + (x_size * 6 * 2) + (x_size/2), y_pos_row + y_size], ...
                'force_arith_type', 'on', 'arith_type', io_arith_type, ...
                'force_bin_pt', 'on', 'bin_pt', num2str(io_bin_pt));
        end
        reuse_block(blk, out_name, 'built-in/outport', ...
            'Port', num2str(pindex), ...
            'Position', [x_start + (x_size * 7 * 2), y_pos_row, x_start + (x_size * 7 * 2) + (x_size/2), y_pos_row + y_size]);
        add_line(blk, 'io_delay/1', [slice_name, '/1'], 'autorouting', 'on');
        if strcmp(sliceboolean, 'off')
            add_line(blk, [slice_name, '/1'], [reinterpret_name, '/1'], 'autorouting', 'on');
            add_line(blk, [reinterpret_name, '/1'], [out_name, '/1'], 'autorouting', 'on');
        else
            add_line(blk, [slice_name, '/1'], [out_name, '/1'], 'autorouting', 'on');
        end
        y_pos_row = y_pos_row + (y_size * 2);
    end
end

end
