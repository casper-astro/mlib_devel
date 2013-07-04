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
function bitsnap_init(blk, varargin)

defaults = {'io_dir', 'To Processor', 'io_names', {'b', 'a'}, 'io_widths', [1, 1], ...
            'io_bps', [0, 0], 'io_types', [0, 0], ...
            'snap_storage', 'bram', 'snap_dram_dimm', '1', 'snap_dram_clock', '200', ...
            'snap_nsamples', '10', 'snap_data_width', '32', 'snap_circap', 'on', ...
            'snap_offset', 'on', 'snap_value', 'off', 'snap_use_dsp48', 'on'};

% snapshot vars
snap_storage =      get_var('snap_storage', 'defaults', defaults, varargin{:});
snap_dram_dimm =    get_var('snap_dram_dimm', 'defaults', defaults, varargin{:});
snap_dram_clock =   get_var('snap_dram_clock', 'defaults', defaults, varargin{:});
snap_nsamples =     get_var('snap_nsamples', 'defaults', defaults, varargin{:});
snap_data_width =   get_var('snap_data_width', 'defaults', defaults, varargin{:});
snap_circap =       get_var('snap_circap', 'defaults', defaults, varargin{:});
snap_offset =       get_var('snap_offset', 'defaults', defaults, varargin{:});
snap_value =        get_var('snap_value', 'defaults', defaults, varargin{:});
snap_use_dsp48 =    get_var('snap_use_dsp48', 'defaults', defaults, varargin{:});
% io vars
io_names = get_var('io_names', 'defaults', defaults, varargin{:});
io_widths = get_var('io_widths', 'defaults', defaults, varargin{:});
io_bps = get_var('io_bps', 'defaults', defaults, varargin{:});
io_types = get_var('io_types', 'defaults', defaults, varargin{:});
if (numel(io_names) ~= numel(io_widths)) || (numel(io_names) ~= numel(io_bps)) || (numel(io_names) ~= numel(io_types)) || (numel(io_names) < 1),
    error('Lengths of IO fields must match and be >0.');
end
num_ios = numel(io_names);
% check that the widths of the inputs are not greater than the snap width
if sum(io_widths) > str2double(snap_data_width),
    error('%i-bit wide snapshot chosen, but %i bit inputs specified.', str2double(snap_data_width), sum(io_widths));
end

% extra vars
extra_names = get_var('extra_names', 'defaults', defaults, varargin{:});
extra_widths = get_var('extra_widths', 'defaults', defaults, varargin{:});
extra_bps = get_var('extra_bps', 'defaults', defaults, varargin{:});
extra_types = get_var('extra_types', 'defaults', defaults, varargin{:});
if (numel(extra_names) ~= numel(extra_widths)) || (numel(extra_names) ~= numel(extra_bps)) || (numel(extra_names) ~= numel(extra_types)) || (numel(extra_names) < 1),
    error('Lengths of Extra fields must match and be >0.');
end
num_extras = numel(extra_names);
% check that the widths of the extras are not greater than the extra register width
if sum(extra_widths) > 32,
    error('%i bit extras specified do not fit into 32-bit wide extra value register.', sum(extra_widths), 32);
end

munge_block(blk, varargin{:});
delete_lines(blk);

% add the inputs, outputs and gateway out blocks, drawing lines between them
x_size =    100;
y_size =    20;
x_start =   100;
y_pos =     100;

% the bus create block
reuse_block(blk, 'buscreate', 'casper_library_flow_control/bus_create', ...
        'Position', [x_start + (x_size * 1), y_pos + (y_size * (num_ios - 0.5)), x_start + (x_size * 1) + x_size, y_pos + (y_size * (num_ios + 5.5))], ...
        'inputNum', num2str(num_ios));

% the snapshot block
reuse_block(blk, 'ss', 'casper_library_scopes/snapshot', ...
        'Position', [x_start + (x_size * 5), y_pos + (y_size * (num_ios - 0.5)), x_start + (x_size * 5) + x_size, y_pos + (y_size * 10)], ...
        'storage', snap_storage, ...
        'dram_dimm', snap_dram_dimm, ...
        'dram_clock', snap_dram_clock, ...
        'nsamples', num2str(snap_nsamples), ...
        'data_width', snap_data_width, ...
        'offset', snap_offset, ...
        'circap', snap_circap, ...
        'value', snap_value, ...
        'use_dsp48', snap_use_dsp48);
add_line(blk, 'buscreate/1', 'ss/1');

% io ports
y_pos_row = y_pos;
for p = 1 : num_ios,
    idx = p;
    in_name = sprintf('in_%s', char(io_names(idx)));
    reuse_block(blk, in_name, 'built-in/inport', ...
        'Port', num2str(p), ...
        'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
    add_line(blk, [in_name, '/1'], ['buscreate/', num2str(p)]);
    y_pos_row = y_pos_row + (y_size * 2);
end

% we
portnum = num_ios + 1;
snapport = 2;
y1 = 165;
reuse_block(blk, 'we', 'built-in/inport', ...
    'Port', num2str(portnum), ...
    'Position', [485, y1, 535, y1+y_size]);
add_line(blk, 'we/1', ['ss/', num2str(snapport)]);

% trigger
portnum = portnum + 1; y1 = y1 + 50; snapport = snapport + 1;
reuse_block(blk, 'trig', 'built-in/inport', ...
    'Port', num2str(portnum), ...
    'Position', [485, y1, 535, y1+y_size]);
add_line(blk, 'trig/1', ['ss/', num2str(snapport)]);

% stop
if strcmp(snap_circap, 'on'),
    portnum = portnum + 1; y1 = y1 + 50; snapport = snapport + 1;
    reuse_block(blk, 'stop', 'built-in/inport', ...
        'Port', num2str(portnum), ...
        'Position', [485, y1, 535, y1+y_size]);
    add_line(blk, 'stop/1', ['ss/', num2str(snapport)]);
end

% extra value
if strcmp(snap_value, 'on'),
    % buscreate block
    reuse_block(blk, 'extracreate', 'casper_library_flow_control/bus_create', ...
        'Position', [x_start + (x_size * 1), y_pos + 500 + (y_size * (num_extras - 0.5)), x_start + (x_size * 1) + x_size, y_pos + 500 + (y_size * (num_extras + 5.5))], ...
        'inputNum', num2str(num_extras));
    snapport = snapport + 1;
    add_line(blk, 'extracreate/1', ['ss/', num2str(snapport)]);
    % draw an input port for each field for the extra value
    for p = 1 : num_extras,
        idx = p;
        in_name = sprintf('extra_%s', char(extra_names(idx)));
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Port', num2str(p + portnum), ...
            'Position', [x_start, y_pos_row + 500, x_start + (x_size/2), y_pos_row + 500 + y_size]);
        add_line(blk, [in_name, '/1'], ['extracreate/', num2str(p)]);
        y_pos_row = y_pos_row + (y_size*2.5);
    end
    
end

% remove unconnected blocks
clean_blocks(blk);

%save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting bitsnap_init','trace');
