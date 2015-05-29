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
io_names =          get_param(blk, 'io_names');
io_widths =         eval(get_param(blk, 'io_widths'));
io_bps =            eval(get_param(blk, 'io_bps'));
io_types =          eval(get_param(blk, 'io_types'));
extra_names =       get_param(blk, 'extra_names');
extra_widths =      eval(get_param(blk, 'extra_widths'));
extra_bps =         eval(get_param(blk, 'extra_bps'));
extra_types =       eval(get_param(blk, 'extra_types'));

io_names = textscan(strtrim(strrep(strrep(strrep(strrep(io_names, ']', ''), '[', ''), ',', ' '), '  ', ' ')), '%s');
io_names = io_names{1};
extra_names = textscan(strtrim(strrep(strrep(strrep(strrep(extra_names, ']', ''), '[', ''), ',', ' '), '  ', ' ')), '%s');
extra_names = extra_names{1};

% check lengths and whatnot
if (numel(io_names) ~= numel(io_widths)) || (numel(io_names) ~= numel(io_bps)) || (numel(io_names) ~= numel(io_types)) || (numel(io_names) < 1),
    error('Lengths of IO fields must match and be >0.');
end
num_ios = numel(io_names);
% check that the widths of the inputs are not greater than the snap width
if sum(io_widths) > snap_data_width,
    error('%i-bit wide snapshot chosen, but %i bit inputs specified.', snap_data_width, sum(io_widths));
end
% extra vars
if (numel(extra_names) ~= numel(extra_widths)) || (numel(extra_names) ~= numel(extra_bps)) || (numel(extra_names) ~= numel(extra_types)) || (numel(extra_names) < 1),
    error('Lengths of Extra fields must match and be >0.');
end
num_extras = numel(extra_names);

% check that the widths of the extras are not greater than the extra register width
if sum(extra_widths) > 32,
    error('%i bit extras specified do not fit into 32-bit wide extra value register.', sum(extra_widths), 32);
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
        'Position', [x_start + (x_size * 2), y_pos + (y_size * (num_ios - 0.5)), x_start + (x_size * 2) + x_size, y_pos + (y_size * (num_ios + 5.5))], ...
        'inputNum', num2str(num_ios));

if snap_delay > 0,
    %reuse_block(blk, 'io_delay', 'xbsIndex_r4/Delay', 'latency', num2str(snap_delay), 'reg_retiming', 'on', ...
    %        'Position', [x_start + (x_size * 3.5), y_pos - (y_size * 0.5), x_start + (x_size * 3.5) + x_size, y_pos + (y_size * 0.5)]);   
    reuse_block(blk, 'io_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
            'Position', [x_start + (x_size * 3.5), y_pos - (y_size * 0.5), x_start + (x_size * 3.5) + x_size, y_pos + (y_size * 0.5)]);
end
    
% the snapshot block
%'Position', [x_start + (x_size * 5), y_pos + (y_size * (num_ios - 0.5)), x_start + (x_size * 5) + x_size, y_pos + (y_size * 10)], ...
reuse_block(blk, 'ss', 'casper_library_scopes/snapshot', ...
        'storage', snap_storage, ...
        'dram_dimm', num2str(snap_dram_dimm), ...
        'dram_clock', num2str(snap_dram_clock), ...
        'nsamples', num2str(snap_nsamples), ...
        'data_width', num2str(snap_data_width), ...
        'offset', snap_offset, ...
        'circap', snap_circap, ...
        'value', snap_value, ...
        'use_dsp48', snap_use_dsp48);
if snap_delay > 0,
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
for p = 1 : num_ios,
    x_start =   80;
    in_name = sprintf('in_%s', char(io_names(p)));
    assert_name = sprintf('assert_%s', char(io_names(p)));
    if io_types(p) == 2
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
            'type_source', 'Explicitly', 'arith_type', type_to_string(io_types(p)), ...
            'bin_pt', num2str(io_bps(p)), 'gui_display_data_type', gddtype, ...
            'n_bits', num2str(io_widths(p)), ...
            'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
    add_line(blk, [in_name, '/1'], [assert_name, '/1']);
    add_line(blk, [assert_name, '/1'], ['buscreate/', num2str(p)]);
    y_pos_row = y_pos_row + (y_size * 2);
end

% we
portnum = num_ios + 1;
snapport = 2;
y1 = 165;
reuse_block(blk, 'we', 'built-in/inport', ...
    'Port', num2str(portnum), ...
    'Position', [485, y1, 535, y1+y_size]);
if snap_delay > 0,
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
if snap_delay > 0,
    reuse_block(blk, 'trig_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
        'Position', [545, y1, 595, y1+y_size]);
    add_line(blk, 'trig/1', 'trig_delay/1');
    add_line(blk, 'trig_delay/1', ['ss/', num2str(snapport)]);
else
    add_line(blk, 'trig/1', ['ss/', num2str(snapport)]);
end

% stop
if strcmp(snap_circap, 'on'),
    portnum = portnum + 1; y1 = y1 + 50; snapport = snapport + 1;
    reuse_block(blk, 'stop', 'built-in/inport', ...
        'Port', num2str(portnum), ...
        'Position', [485, y1, 535, y1+y_size]);
    if snap_delay > 0,
        reuse_block(blk, 'stop_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
            'Position', [545, y1, 595, y1+y_size]);
        add_line(blk, 'stop/1', 'stop_delay/1');
        add_line(blk, 'stop_delay/1', ['ss/', num2str(snapport)]);
    else
        add_line(blk, 'stop/1', ['ss/', num2str(snapport)]);
    end
end

% extra value
if strcmp(snap_value, 'on'),
    % buscreate block
    reuse_block(blk, 'extracreate', 'casper_library_flow_control/bus_create', ...
        'Position', [x_start + (x_size * 1), y_pos + 500 + (y_size * (num_extras - 0.5)), x_start + (x_size * 1) + x_size, y_pos + 500 + (y_size * (num_extras + 5.5))], ...
        'inputNum', num2str(num_extras));
    if snap_delay > 0,
        reuse_block(blk, 'extra_delay', 'casper_library_delays/pipeline', 'latency', num2str(snap_delay), ...
                'Position', [x_start + (x_size * 3.5), y_pos + 500 - (y_size * 0.5), x_start + (x_size * 3.5) + x_size, y_pos + 500 + (y_size * 0.5)]);
    end
    snapport = snapport + 1;
    if snap_delay > 0,
        add_line(blk, 'extracreate/1', 'extra_delay/1');
        add_line(blk, 'extra_delay/1', ['ss/', num2str(snapport)]);
    else
        add_line(blk, 'extracreate/1', ['ss/', num2str(snapport)]);
    end
    % draw an input port for each field for the extra value
    for p = 1 : num_extras,
        x_start =   100;
        in_name = sprintf('extra_%s', char(extra_names(p)));
        assert_name = sprintf('assextra_%s', char(extra_names(p)));
        if extra_types(p) == 2
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
            'type_source', 'Explicitly', 'arith_type', type_to_string(extra_types(p)), ...
            'bin_pt', num2str(extra_bps(p)), 'gui_display_data_type', gddtype, ...
            'n_bits', num2str(extra_widths(p)), ...
            'Position', [x_start, y_pos_row + 500, x_start + (x_size/2), y_pos_row + 500 + y_size]);
        add_line(blk, [in_name, '/1'], [assert_name, '/1']);
        add_line(blk, [assert_name, '/1'], ['extracreate/', num2str(p)]);
        y_pos_row = y_pos_row + (y_size*2.5);
    end
    
end

% remove unconnected blocks
clean_blocks(blk);

%save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting bitsnap_init','trace');

% end of main function
end
