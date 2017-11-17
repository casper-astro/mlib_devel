% A wrapped snapshot block
%
% bitsnap_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %                                                                             %
% %   Meerkat radio telescope project                                           %
% %   www.kat.ac.za                                                             %
% %   Copyright (C) Paul Prozesky 2013                                          %
% %                                                                             %
% %   This program is free software; you can redistribute it and/or modify      %
% %   it under the terms of the GNU General Public License as published by      %
% %   the Free Software Foundation; either version 2 of the License, or         %
% %   (at your option) any later version.                                       %
% %                                                                             %
% %   This program is distributed in the hope that it will be useful,           %
% %   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
% %   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
% %   GNU General Public License for more details.                              %
% %                                                                             %
% %   You should have received a copy of the GNU General Public License along   %
% %   with this program; if not, write to the Free Software Foundation, Inc.,   %
% %   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
% %                                                                             %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Wrap a software register and specify bit slices to and from the 32-bit
% register. These will automatically be processed by the toolflow.
% 
function bitsnap_init(blk)

if strcmp(gcs, 'casper_library_scopes') == 1
    return
end

% get values from the mask
snap_storage =      get_param(blk, 'snap_storage');
snap_dram_dimm =    eval(get_param(blk, 'snap_dram_dimm'));
snap_dram_clock =   eval(get_param(blk, 'snap_dram_clock'));
snap_nsamples =     eval(get_param(blk, 'snap_nsamples'));
snap_data_width =   eval(get_param(blk, 'snap_data_width'));
snap_circap =       get_param(blk, 'snap_circap');
snap_offset =       get_param(blk, 'snap_offset');
snap_value =        get_param(blk, 'snap_value');
snap_use_dsp48 =    get_param(blk, 'snap_use_dsp48');
snap_delay =        eval(get_param(blk, 'snap_delay'));
try
    old_snaps = 0;
    snap_ext_arm = get_param(blk, 'snap_ext_arm');
    snap_ext_circ = get_param(blk, 'snap_ext_circ');
    snap_provide_outputs = 'off';
catch
    warning('Using old bitsnap %s, consider updating it from the library.', blk);
    old_snaps = 1;
    snap_ext_arm = 'off';
    snap_ext_circ = 'off';
    snap_provide_outputs = 'off';
end
if strcmp(snap_ext_circ, 'on')
    snap_circap = 'on';
end

blktype = 2;
fld_nms = 'io_names';
fld_bps = 'io_bps';
fld_wid = 'io_widths';
fld_typ = 'io_types';
[io_numios, io_current_names, io_current_widths, io_current_bins, io_current_types] = bitfield_maskcheck(blk, blktype, fld_nms, fld_typ, fld_bps, fld_wid);

if strcmp(snap_value, 'on')
    blktype = 3;
    fld_nms = 'extra_names';
    fld_bps = 'extra_bps';
    fld_wid = 'extra_widths';
    fld_typ = 'extra_types';
    [extra_numios, extra_current_names, extra_current_widths, extra_current_bins, extra_current_types] = bitfield_maskcheck(blk, blktype, fld_nms, fld_typ, fld_bps, fld_wid);
end

munge_block(blk);
delete_lines(blk);

% add the inputs, outputs and gateway out blocks, drawing lines between them
x_size =    100;
y_size =    20;
x_start =   100;
y_pos =     100;

% the bus create block
reuse_block(blk, 'buscreate', 'casper_library_flow_control/bus_create', ...
    'Position', [x_start + (x_size * 2), y_pos + (y_size * (io_numios - 0.5)), x_start + (x_size * 2) + x_size, y_pos + (y_size * (io_numios + 5.5))], ...
    'inputNum', num2str(io_numios));

if snap_delay > 0
    reuse_block(blk, 'io_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
        'Position', [x_start + (x_size * 3.5), y_pos - (y_size * 0.5), x_start + (x_size * 3.5) + x_size, y_pos + (y_size * 0.5)]);
end
    
% the snapshot block
% force an update if it's an old snapblock
try
    get_param([blk, '/ss'], 'ext_arm');
    get_param([blk, '/ss'], 'ext_circ');
    ssports = get_param([blk, '/ss'], 'Ports');
    if ssports(2) == 0
        oldsnap = 1;
    else
        oldsnap = 0;
    end
catch
    oldsnap = 1;
end
if oldsnap == 1
    try
        delete_block([blk, '/ss']);
    catch
        % pass
    end
end
reuse_block(blk, 'ss', 'casper_library_scopes/snapshot', ...
    'storage', snap_storage, ...
    'dram_dimm', num2str(snap_dram_dimm), ...
    'dram_clock', num2str(snap_dram_clock), ...
    'nsamples', num2str(snap_nsamples), ...
    'data_width', num2str(snap_data_width), ...
    'offset', snap_offset, ...
    'circap', snap_circap, ...
    'value', snap_value, ...
    'ext_arm', snap_ext_arm, ...
    'ext_circ', snap_ext_circ, ...
    'provide_outputs', snap_provide_outputs, ...
    'use_dsp48', snap_use_dsp48, ...
    'Position', [700 71 790 239]);

reuse_block(blk, 'arm_out', 'built-in/outport', ...
    'Position', [850 147 880 163], 'Port', '1');
add_line(blk, 'ss/1', 'arm_out/1');

if snap_delay > 0
    add_line(blk, 'buscreate/1', 'io_delay/1');
    add_line(blk, 'io_delay/1', 'ss/1');
else
    add_line(blk, 'buscreate/1', 'ss/1');
end

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

% io ports and assert blocks
y_pos_row = y_pos;
for p = 1 : io_numios
    x_start =   80;
    in_name = sprintf('in_%s', char(io_current_names(p)));
    assert_name = sprintf('assert_%s', char(io_current_names(p)));
    if io_current_types(p) == 2
        gddtype = 'Boolean';
    else
        gddtype = 'Fixed-point';
    end
    reuse_block(blk, in_name, 'built-in/inport', ...
        'Port', num2str(p), ...
        'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
    x_start = x_start + (x_size*1.5);
    reuse_block(blk, assert_name, 'xbsIndex_r4/Assert', ...
            'showname', 'off', 'assert_type', 'on', ...
            'type_source', 'Explicitly', 'arith_type', type_to_string(io_current_types(p)), ...
            'bin_pt', num2str(io_current_bins(p)), 'gui_display_data_type', gddtype, ...
            'n_bits', num2str(io_current_widths(p)), ...
            'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
    add_line(blk, [in_name, '/1'], [assert_name, '/1']);
    add_line(blk, [assert_name, '/1'], ['buscreate/', num2str(p)]);
    y_pos_row = y_pos_row + (y_size * 2);
end

% we
portnum = io_numios + 1;
snapport = 2;
y1 = 165;
reuse_block(blk, 'we', 'built-in/inport', ...
    'Port', num2str(portnum), ...
    'Position', [485, y1, 535, y1+y_size]);
if snap_delay > 0
    reuse_block(blk, 'we_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
        'Position', [545, y1, 595, y1+y_size]);
    add_line(blk, 'we/1', 'we_delay/1');
    add_line(blk, 'we_delay/1', ['ss/', num2str(snapport)]);
else
    add_line(blk, 'we/1', ['ss/', num2str(snapport)]);
end

% trigger
portnum = portnum + 1; y1 = y1 + 50; snapport = snapport + 1;
reuse_block(blk, 'trig', 'built-in/inport', ...
    'Port', num2str(portnum), ...
    'Position', [485, y1, 535, y1+y_size]);
if snap_delay > 0
    reuse_block(blk, 'trig_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
        'Position', [545, y1, 595, y1+y_size]);
    add_line(blk, 'trig/1', 'trig_delay/1');
    add_line(blk, 'trig_delay/1', ['ss/', num2str(snapport)]);
else
    add_line(blk, 'trig/1', ['ss/', num2str(snapport)]);
end

% stop
if strcmp(snap_circap, 'on')
    portnum = portnum + 1; y1 = y1 + 50; snapport = snapport + 1;
    reuse_block(blk, 'stop', 'built-in/inport', ...
        'Port', num2str(portnum), ...
        'Position', [485, y1, 535, y1+y_size]);
    if snap_delay > 0
        reuse_block(blk, 'stop_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
            'Position', [545, y1, 595, y1+y_size]);
        add_line(blk, 'stop/1', 'stop_delay/1');
        add_line(blk, 'stop_delay/1', ['ss/', num2str(snapport)]);
    else
        add_line(blk, 'stop/1', ['ss/', num2str(snapport)]);
    end
end

% extra value
if strcmp(snap_value, 'on')
    % buscreate block
    reuse_block(blk, 'extracreate', 'casper_library_flow_control/bus_create', ...
        'Position', [x_start + (x_size * 1), y_pos + 500 + (y_size * (extra_numios - 0.5)), x_start + (x_size * 1) + x_size, y_pos + 500 + (y_size * (extra_numios + 5.5))], ...
        'inputNum', num2str(extra_numios));
    % delay
    if snap_delay > 0
        reuse_block(blk, 'extra_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
            'Position', [x_start + (x_size * 3.5), y_pos + 500 - (y_size * 0.5), x_start + (x_size * 3.5) + x_size, y_pos + 500 + (y_size * 0.5)]);
    end
    % cast the output of the buscreate to 32-bits for the snap extra val
    reuse_block(blk, 'extracast', 'xbsIndex_r4/Convert', 'arith_type', 'Unsigned', 'n_bits', '32', 'bin_pt', '0', ...
        'Position', [x_start + (x_size * 6), y_pos + 500 - (y_size * 0.5), x_start + (x_size * 6) + x_size, y_pos + 500 + (y_size * 0.5)]);
    
    % connect them
    snapport = snapport + 1;
    if snap_delay > 0
        add_line(blk, 'extracreate/1', 'extra_delay/1');
        add_line(blk, 'extra_delay/1', 'extracast/1');
    else
        add_line(blk, 'extracreate/1', 'extracast/1');
    end
    add_line(blk, 'extracast/1', ['ss/', num2str(snapport)]);
    
    % draw an input port for each field for the extra value
    for p = 1 : extra_numios
        x_start =   100;
        in_name = sprintf('extra_%s', char(extra_current_names(p)));
        assert_name = sprintf('assextra_%s', char(extra_current_names(p)));
        if extra_current_types(p) == 2
            gddtype = 'Boolean';
        else
            gddtype = 'Fixed-point';
        end
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Port', num2str(p + portnum), ...
            'Position', [x_start, y_pos_row + 500, x_start + (x_size/2), y_pos_row + 500 + y_size]);
        x_start = x_start + (x_size*1.5);
        reuse_block(blk, assert_name, 'xbsIndex_r4/Assert', ...
            'showname', 'off', 'assert_type', 'on', ...
            'type_source', 'Explicitly', 'arith_type', type_to_string(extra_current_types(p)), ...
            'bin_pt', num2str(extra_current_bins(p)), 'gui_display_data_type', gddtype, ...
            'n_bits', num2str(extra_current_widths(p)), ...
            'Position', [x_start, y_pos_row + 500, x_start + (x_size/2), y_pos_row + 500 + y_size]);
        add_line(blk, [in_name, '/1'], [assert_name, '/1']);
        add_line(blk, [assert_name, '/1'], ['extracreate/', num2str(p)]);
        y_pos_row = y_pos_row + (y_size*2.5);
    end
 
end

if old_snaps == 0
    if strcmp(snap_ext_arm, 'on')
        reuse_block(blk, 'arm', 'built-in/inport', ...
            'Position', [80 300 110 315]);
        %         'Port', num2str(arm_port), ...
        arm_port = 4;
        if strcmp(snap_circap, 'on')
            arm_port = arm_port + 1;
        end
        if strcmp(snap_value, 'on')
            arm_port = arm_port + 1;
        end
        if snap_delay > 0
            % arm_delay = snap_delay;
            arm_delay = 0;
            reuse_block(blk, 'arm_delay', 'casper_library_delays/pipeline', ...
                'latency', num2str(arm_delay), 'Position', [130 300 160 315]);
            add_line(blk, 'arm/1', 'arm_delay/1');
            add_line(blk, 'arm_delay/1', ['ss/', num2str(arm_port)]);
        else
            add_line(blk, 'arm/1', ['ss/', num2str(arm_port)]);
        end
    end
    
    if strcmp(snap_ext_circ, 'on')
        circ_port = 4;
        if strcmp(snap_circap, 'on')
            circ_port = circ_port + 1;
        end
        if strcmp(snap_value, 'on')
            circ_port = circ_port + 1;
        end
        if strcmp(snap_ext_arm, 'on')
            circ_port = circ_port + 1;
        end
        reuse_block(blk, 'circ', 'built-in/inport', ...
            'Position', [80 367 110 383]);
        % what is its port number going to be?
        in_ports = get_param(blk, 'PortHandles');
        num_ports = length(in_ports.Inport);
        set_param([blk, '/circ'], 'Port', num2str(num_ports));
        if snap_delay > 0
            circ_delay = 0;
            reuse_block(blk, 'circ_delay', 'casper_library_delays/pipeline', ...
                'latency', num2str(circ_delay), 'Position', [130 367 160 383]);
            add_line(blk, 'circ/1', 'circ_delay/1');
            add_line(blk, 'circ_delay/1', ['ss/', num2str(circ_port)]);
        else
            add_line(blk, 'circ/1', ['ss/', num2str(circ_port)]);
        end
    end
    
    if strcmp(snap_provide_outputs, 'on')
        reuse_block(blk, 'out_data', 'built-in/outport', ...
            'Port', '1', 'Position', [770 160 800 175]);
        reuse_block(blk, 'out_we', 'built-in/outport', ...
            'Port', '2', 'Position', [770 190 800 205]);
        reuse_block(blk, 'out_done', 'built-in/outport', ...
            'Port', '3', 'Position', [770 220 800 235]);
        add_line(blk, 'ss/1', 'out_data/1');
        add_line(blk, 'ss/2', 'out_we/1');
        add_line(blk, 'ss/3', 'out_done/1');
    end
end
    
% remove unconnected blocks
clean_blocks(blk);

% update format string so we know what's going on with this block
try
    show_format = get_param(blk, 'show_format');
catch
    show_format = 'off';
end

function display_string = format_string(prefix)
    totalbits = 0;
    numios = eval(strcat(prefix, '_numios'));
    wids = eval(strcat(prefix, '_current_widths'));
    typs = eval(strcat(prefix, '_current_types'));
    bins = eval(strcat(prefix, '_current_bins'));
    if numios == 1
        display_string = '(1)';
    else
        display_string = sprintf('(%d)', numios);
    end
    config_string = '';
    for ctr = 1 : numios
        switch typs(ctr)
            case 1 
                config_string = strcat(config_string, sprintf('f%i.%i,', wids(ctr), bins(ctr)));
            case 2
                config_string = strcat(config_string, 'b,');
            otherwise 
                config_string = strcat(config_string, sprintf('uf%i.%i,', wids(ctr), bins(ctr)));
        end
        totalbits = totalbits + wids(ctr);
    end
    display_string = strcat(display_string, ': ', config_string);
    display_string = regexprep(display_string, ',$', '');
    display_string = sprintf('%s = %i bits', display_string, totalbits);
end

display_string = '';
if strcmp(show_format, 'on')
    display_string = strcat('snap', format_string('io'));
    if strcmp(snap_value, 'on')
        extrastr = strcat('extra', format_string('extra'));
        display_string = strcat(display_string, '\n', extrastr);
    end
end
if ~isempty(display_string)
    display_string = strcat(display_string, '\n');
end

display_string = strcat(display_string, ...
    sprintf('%i wide, %i deep\ndebugID: %s', snap_data_width, 2^snap_nsamples, num2str(hashcode([blk, '/ss']))));
set_param(blk, 'AttributesFormatString', display_string);

% when finished drawing blocks and lines, remove all unused blocks
clean_blocks(blk);

% save and back-populate mask parameter values
%save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting bitsnap_init','trace');

% end of main function
end
