% A wrapped yellow-block-register
%
% breg_init(blk, varargin)
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
function bitreg_init(blk, varargin)

defaults = {'io_dir', 'To Processor', 'io_names', {'a', 'b'}, 'io_widths', [1, 1]};

io_dir = get_var('io_dir', 'defaults', defaults, varargin{:});
io_names = get_var('io_names', 'defaults', defaults, varargin{:});
io_widths = get_var('io_widths', 'defaults', defaults, varargin{:});
io_bp = get_var('io_bp', 'defaults', defaults, varargin{:});
io_type = get_var('io_type', 'defaults', defaults, varargin{:});

if (numel(io_names) ~= numel(io_widths)) || (numel(io_names) ~= numel(io_bp)) || (numel(io_names) ~= numel(io_type)) || (numel(io_names) < 1),
    error('Lengths of fields must match and be >0.');
end
num_ios = numel(io_names);

munge_block(blk, varargin{:});
delete_lines(blk);

% add the inputs, outputs and gateway out blocks, drawing lines between them
x_size =    100;
y_size =    20;
x_start =   100;
y_pos =     100;

% set up the register itself
reuse_block(blk, 'reg', 'xps_library/software register', ...
        'Position', [x_start + (x_size * 3), y_pos + (y_size * (num_ios - 0.5)), x_start + (x_size * 3) + x_size, y_pos + (y_size * (num_ios + 0.5))]);

% the rest depends on whether it's an in or out reg
if strcmp(io_dir, 'To Processor'),
    set_param([blk,'/reg'], 'io_dir', 'To Processor');
    % in ports
    y_pos_row = y_pos;
    for p = 1 : num_ios,
        in_name = sprintf('in_%s', char(io_names(p)));
        reuse_block(blk, in_name, 'built-in/inport', ...
            'Port', num2str(p), ...
            'Position', [x_start, y_pos_row, x_start + (x_size/2), y_pos_row + y_size]);
        y_pos_row = y_pos_row + (y_size * 2);
    end
    % bus create block
    if num_ios > 1,
        reuse_block(blk, 'create', 'casper_library_flow_control/bus_create', ...
            'Position', [x_start + (x_size * 2), y_pos, x_start + (x_size * 2) + (x_size/2), y_pos + (2 * y_size * num_ios) - y_size], ...
            'inputNum', num2str(num_ios));
        for p = 1 : num_ios,
            in_name = sprintf('in_%s', char(io_names(p)));
            add_line(blk, [in_name,'/1'], ['create/',num2str(p)]);
        end
        add_line(blk, 'create/1', 'reg/1');
    else
        add_line(blk, [sprintf('in_%s', char(io_names(1))),'/1'], 'reg/1');
    end
    % out port
    reuse_block(blk, 'sim_out', 'built-in/outport', ...
        'Position', [x_start + (x_size * 3 * 2), y_pos + (y_size * (num_ios - 0.5)), x_start + (x_size * 3 * 2) + (x_size/2), y_pos + (y_size * (num_ios + 0.5))]);
    add_line(blk, 'reg/1', 'sim_out/1');
else
    set_param([blk,'/reg'], 'io_dir', 'From Processor');
    % in port
    reuse_block(blk, 'in_sim', 'built-in/inport', ...
        'Position', [x_start, y_pos + (y_size * (num_ios - 0.5)), x_start + (x_size/2), y_pos + (y_size * (num_ios + 0.5))]);
    add_line(blk, 'in_sim/1', 'reg/1');
    reuse_block(blk, 'expand', 'casper_library_flow_control/bus_expand', ...
        'Position', [x_start + (x_size*5), y_pos + (y_size * (num_ios - 0.5)), x_start  + (x_size*6), y_pos + (y_size * (num_ios + 0.5))], ...
        'mode', 'divisions of arbitrary size', ...
        'outputNum', num2str(num_ios), ...
        'outputWidth', 'io_widths', ...
        'outputBinaryPt', 'io_bp', ...
        'outputArithmeticType', 'io_type');
    add_line(blk, 'reg/1', 'expand/1');
    % out ports
    for p = 1 : num_ios,
        out_name = sprintf('out_%s', char(io_names(p)));
        x_pos = x_start + (x_size * 5);
        y_pos_row = y_pos + (y_size * (num_ios - 0.5));
        x_pos = x_pos + (x_size * 2);
        reuse_block(blk, out_name, 'built-in/outport', ...
            'Port', num2str(p), ...
            'Position', [x_pos, y_pos_row, x_pos + (x_size/2), y_pos_row + y_size]);
        add_line(blk, ['expand/', num2str(p)], [out_name, '/1']);
        y_pos = y_pos + (y_size * 2);
    end
end

% remove unconnected blocks
clean_blocks(blk);

%save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting breg_init','trace');
