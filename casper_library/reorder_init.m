% Initialize and configure the reorder block.
%
% reorder_init(blk, varargin)
%
% blk = The block to be initialize.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% map = The desired output order.
% map_latency = The latency of the map block.
% bram_latency = The latency of buffer BRAM blocks.
% n_inputs = The number of parallel inputs to be reordered.
% double_buffer = Whether to use two buffers to reorder data (instead of
%                 doing it in-place).
% bram_map = Whether to use BlockRAM for address mapping (instead of
%            distributed RAM.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
%                                                                             %
%   Meerkat Radio Telescope Project                                           %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2011 Andrew Martens                                         %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function reorder_init(blk, varargin)

clog('entering reorder_init', 'trace');
% Declare any default values for arguments you might like.
%defaults = {} ;
defaults = {'map', [0 1 2 3], 'map_latency', 1, 'bram_latency', 1, ...
  'n_inputs', 1, 'double_buffer', 0, 'bram_map', 'off'};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('reorder_init post same_state', 'trace');
check_mask_type(blk, 'reorder');
munge_block(blk, varargin{:});

map = get_var('map', 'defaults', defaults, varargin{:});
map_latency = get_var('map_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
double_buffer = get_var('double_buffer', 'defaults', defaults, varargin{:});
bram_map = get_var('bram_map', 'defaults', defaults, varargin{:});

if n_inputs < 1
    error('Number of inputs cannot be less than 1.');
end

map_length = length(map);
%fprintf([num2str(map),'\n']);
%fprintf([num2str(map_length),'\n']);
map_bits = ceil(log2(map_length));
order = compute_order(map);
order_bits = ceil(log2(order));

if (strcmp('on',bram_map))
    map_memory_type = 'Block RAM';
else
    map_memory_type = 'Distributed memory';
end

if (double_buffer < 0 || double_buffer > 1) ,
	disp('Double Buffer must be 0 or 1');
	error('Double Buffer must be 0 or 1');
end

% At some point, when Xilinx supports muxes wider than 16, this can be
% fixed.
if order > 16 && double_buffer == 0,
    error('Reorder can only support a map orders <= 16 in single buffer mode.');
end
% Non-power-of-two maps could be supported by adding a counter an a
% comparitor, rather than grouping the map and address count into one
% counter.
if 2^map_bits ~= map_length,
    error('Reorder currently only supports maps which are 2^? long.')
end

if double_buffer == 1,
    order = 2;
end

% en stuff
% delays on way into buffer depend on double buffering 
if double_buffer == 0,
  pre_delay = (order-1)*map_latency+1; 
else
  pre_delay = map_latency;
end

delete_lines(blk);

reuse_block(blk, 'en', 'built-in/inport', 'Position', [25   120    55   134], 'Port', '2');
reuse_block(blk, 'delay_we', 'xbsIndex_r4/Delay', ...
  'reg_retiming', 'on', 'latency', num2str(pre_delay), 'Position', [305 50 345 70]);
add_line(blk, 'en/1', 'delay_we/1');
reuse_block(blk, 'delay_valid', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
    'Position', [615  50  655  70], 'latency', num2str(bram_latency+(double_buffer*2)));
add_line(blk, 'delay_we/1', 'delay_valid/1');
reuse_block(blk, 'valid', 'built-in/outport', 'Position', [705   50   735   66], 'Port', '2');
add_line(blk, 'delay_valid/1', 'valid/1');

% sync stuff
% delay value here is time into BRAM + time for one vector + time out of BRAM
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [25    65    50    79], 'Port', '1');
reuse_block(blk, 'pre_sync_delay', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', 'Position', [305 0 345 20], 'latency', num2str(pre_delay));
add_line(blk, 'sync/1', 'pre_sync_delay/1');
reuse_block(blk, 'or', 'xbsIndex_r4/Logical', ...
    'logical_function', 'OR', 'Position', [375 10 400 36]);
add_line(blk, 'delay_we/1', 'or/2');
add_line(blk, 'pre_sync_delay/1', 'or/1');
reuse_block(blk, 'sync_delay_en', 'casper_library_delays/sync_delay_en', ...
    'Position', [425 0 470 20], 'DelayLen', num2str(map_length));
add_line(blk, 'or/1', 'sync_delay_en/2');
add_line(blk, 'pre_sync_delay/1', 'sync_delay_en/1');
reuse_block(blk, 'post_sync_delay', 'xbsIndex_r4/Delay', ...
    'reg_retiming', 'on', 'Position', [615  0  655  20], 'latency', num2str(bram_latency+(double_buffer*2)));
add_line(blk, 'sync_delay_en/1', 'post_sync_delay/1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [705   0   735   16], 'Port', '1');
add_line(blk, 'post_sync_delay/1', 'sync_out/1');

% Special case for reorder of order 1 (just delay)
if order == 1,

    for cnt=1:n_inputs,
        % Ports
        reuse_block(blk, ['din', num2str(cnt-1)], 'built-in/inport', ...
            'Position', [495    80*cnt+53   525    80*cnt+67], 'Port', num2str(2+cnt));
        reuse_block(blk, ['dout', num2str(cnt-1)], 'built-in/outport', ...
            'Position', [705    80*cnt+53   735    80*cnt+67], 'Port', num2str(2+cnt));

        % Delays
        reuse_block(blk, ['delay_din', num2str(cnt-1)], 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
            'Position', [550    80*cnt+50    590    80*cnt+70], 'latency', num2str(pre_delay));
        reuse_block(blk, ['delay_din_bram', num2str(cnt-1)], 'casper_library_delays/delay_bram_en_plus', ...
            'Position', [620    80*cnt+50    660    80*cnt+70], 'DelayLen', 'length(map)', 'bram_latency', 'bram_latency');

        % Wires
        add_line(blk, ['din', num2str(cnt-1),'/1'], ['delay_din', num2str(cnt-1),'/1']);
        add_line(blk, ['delay_din', num2str(cnt-1),'/1'], ['delay_din_bram', num2str(cnt-1),'/1']);
        add_line(blk, ['delay_din_bram', num2str(cnt-1),'/1'], ['dout', num2str(cnt-1),'/1']);
        add_line(blk, 'delay_we/1', ['delay_din_bram', num2str(cnt-1),'/2']);
    end
% Case for order != 1, single-buffered
elseif double_buffer == 0,
    reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
        'Position', [95   90   145   145], 'n_bits', num2str(map_bits + order_bits), 'cnt_type', 'Count Limited', ...
        'arith_type', 'Unsigned', 'cnt_to', num2str(2^map_bits * order - 1), ...
        'en', 'on', 'rst', 'on');
    reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
        'Position', [170   90   200   110], 'mode', 'Upper Bit Location + Width', ...
        'nbits', num2str(order_bits));
    reuse_block(blk, 'Slice2', 'xbsIndex_r4/Slice', ...
        'Position', [170   125   200  145], 'mode', 'Lower Bit Location + Width', ...
        'nbits', num2str(map_bits));
    reuse_block(blk, 'Mux', 'xbsIndex_r4/Mux', ...
        'Position', [415    90   440    120+20*order], 'inputs', num2str(order), 'latency', '1');
    reuse_block(blk, 'delay_sel', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
        'Position', [305    90    345    110], 'latency', num2str((order-1)*map_latency));
    reuse_block(blk, 'delay_d0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
        'Position', [305    125    345    145], 'latency', num2str((order-1)*map_latency));

    % Add Dynamic Ports and Blocks
    for cnt=1:n_inputs,
        % Ports
        reuse_block(blk, ['din',num2str(cnt-1)], 'built-in/inport', ...
            'Position', [495    80*cnt+53   525    80*cnt+67], 'Port', num2str(2+cnt));
        reuse_block(blk, ['dout', num2str(cnt-1)], 'built-in/outport', ...
            'Position', [705    80*cnt+53   735    80*cnt+67], 'Port', num2str(2+cnt));

        % BRAMS
        reuse_block(blk, ['bram',num2str(cnt-1)], 'xbsIndex_r4/Single Port RAM', ...
            'Position', [615    80*cnt-17+50   680   80*cnt+87], 'depth', num2str(2^map_bits), ...
            'write_mode', 'Read Before Write', 'latency', num2str(bram_latency));
        reuse_block(blk, ['delay_din',num2str(cnt-1)], 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
            'latency', num2str(pre_delay), 'Position', [550 80*cnt+50 590 80*cnt+70]);
    end

    % Add Maps
    for cnt=1:order-1,
        mapname = ['map', num2str(cnt)];
        reuse_block(blk, mapname, 'xbsIndex_r4/ROM', ...
            'depth', num2str(map_length), 'initVector', 'map', 'latency', num2str(map_latency), ...
            'arith_type', 'Unsigned', 'n_bits', num2str(map_bits), 'bin_pt', '0', ...
            'distributed_mem', map_memory_type, 'Position', [230  125+50*cnt   270    145+50*cnt]);
        reuse_block(blk, ['delay_',mapname], 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
            'Position', [305   125+50*cnt    345   145+50*cnt], 'latency', [num2str(order-(cnt+1)),'*map_latency']);
    end

    % Add static wires
    add_line(blk, 'sync/1', 'Counter/1');
    add_line(blk, 'en/1', 'Counter/2');
    add_line(blk, 'Counter/1', 'Slice1/1');
    add_line(blk, 'Counter/1', 'Slice2/1');
    add_line(blk, 'Slice1/1', 'delay_sel/1');
    add_line(blk, 'delay_sel/1', 'Mux/1');
    add_line(blk, 'Slice2/1', 'delay_d0/1');
    add_line(blk, 'delay_d0/1', 'Mux/2');

    % Add dynamic wires
    for cnt=1:n_inputs
        add_line(blk, 'delay_we/1', ['bram',num2str(cnt-1),'/3']);
        add_line(blk, 'Mux/1', ['bram',num2str(cnt-1),'/1']);
        add_line(blk, ['din',num2str(cnt-1),'/1'], ['delay_din',num2str(cnt-1),'/1']);
        add_line(blk, ['delay_din',num2str(cnt-1),'/1'], ['bram',num2str(cnt-1),'/2']);
        add_line(blk, ['bram',num2str(cnt-1),'/1'], ['dout',num2str(cnt-1),'/1']);
    end

    for cnt=1:order-1,
        mapname = ['map',num2str(cnt)];
        prevmapname = ['map',num2str(cnt-1)];
        if cnt == 1,
            add_line(blk, 'Slice2/1', 'map1/1');
        else,
            add_line(blk, [prevmapname,'/1'], [mapname,'/1'], 'autorouting', 'on');
        end
        add_line(blk, [mapname,'/1'], ['delay_',mapname,'/1']);
        add_line(blk, ['delay_',mapname,'/1'], ['Mux/',num2str(cnt+2)]);
    end
% case for order > 1, double-buffered
else,

    reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
        'Position', [95   90   145   145], 'n_bits', num2str(map_bits + 1), 'cnt_type', 'Count Limited', ...
        'arith_type', 'Unsigned', 'cnt_to', num2str(2^map_bits * order - 1), ...
        'en', 'on', 'rst', 'on');
    reuse_block(blk, 'Slice1', 'xbsIndex_r4/Slice', ...
        'Position', [170   90   200   110], 'mode', 'Upper Bit Location + Width', ...
        'nbits', '1');
    reuse_block(blk, 'Slice2', 'xbsIndex_r4/Slice', ...
        'Position', [170   125   200  145], 'mode', 'Lower Bit Location + Width', ...
        'nbits', num2str(map_bits));
    reuse_block(blk, 'delay_sel', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
        'Position', [305    90    345    110], 'latency', num2str((order-1)*map_latency));
    reuse_block(blk, 'delay_d0', 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
        'Position', [305    125    345    145], 'latency', num2str((order-1)*map_latency));

    % Add Dynamic Ports and Blocks
    for cnt=1:n_inputs,
        % Ports
        reuse_block(blk, ['din',num2str(cnt-1)], 'built-in/inport', ...
            'Position', [495    80*cnt+53   525    80*cnt+67], 'Port', num2str(2+cnt));
        reuse_block(blk, ['dout', num2str(cnt-1)], 'built-in/outport', ...
            'Position', [705    80*cnt+53   735    80*cnt+67], 'Port', num2str(2+cnt));

        % BRAMS
        reuse_block(blk, ['delay_din',num2str(cnt-1)], 'xbsIndex_r4/Delay', 'reg_retiming', 'on', ...
            'Position', [550    80*cnt+50    590    80*cnt+70], 'latency', num2str(pre_delay));
        reuse_block(blk, ['dbl_buffer',num2str(cnt-1)], 'casper_library_reorder/dbl_buffer', ...
            'Position', [615    80*cnt-17+50   680   80*cnt+87], 'depth', num2str(2^map_bits), ...
            'latency', num2str(bram_latency));
    end

    % Add Maps
    mapname = 'map1';
    reuse_block(blk, mapname, 'xbsIndex_r4/ROM', ...
        'depth', num2str(map_length), 'initVector', 'map', 'latency', num2str(map_latency), ...
        'arith_type', 'Unsigned', 'n_bits', num2str(map_bits), 'bin_pt', '0', ...
        'distributed_mem', map_memory_type, 'Position', [230  175+50   270    195+50]);

    % Add static wires
    add_line(blk, 'sync/1', 'Counter/1');
    add_line(blk, 'en/1', 'Counter/2');
    add_line(blk, 'Counter/1', 'Slice1/1');
    add_line(blk, 'Counter/1', 'Slice2/1');
    add_line(blk, 'Slice1/1', 'delay_sel/1');
    add_line(blk, 'Slice2/1', 'delay_d0/1');
    add_line(blk, 'Slice2/1', 'map1/1');

    % Add dynamic wires
    for cnt=1:n_inputs
        bram_name = ['dbl_buffer',num2str(cnt-1)];
        add_line(blk, 'delay_d0/1', [bram_name,'/2']);
        add_line(blk, 'map1/1', [bram_name,'/3']);
        add_line(blk, 'delay_we/1', [bram_name,'/5']);
        add_line(blk, 'delay_sel/1', [bram_name,'/1']);
        add_line(blk, ['din',num2str(cnt-1),'/1'], ['delay_din',num2str(cnt-1),'/1']);
        add_line(blk, ['delay_din',num2str(cnt-1),'/1'], [bram_name,'/4']);
        add_line(blk, [bram_name,'/1'], ['dout',num2str(cnt-1),'/1']);
    end
end

clean_blocks(blk);

fmtstr = sprintf('order=%d', order);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting reorder_init', 'trace');
