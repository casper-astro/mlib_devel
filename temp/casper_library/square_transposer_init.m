%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
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

function square_transposer_init(blk, varargin)
% Initialize and configure the square transposer.
%
% square_transposer_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% n_inputs = The number of inputs to be transposed.

% Declare any default values for arguments you might like.

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'square_transposer');
munge_block(blk, varargin{:});

n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});

if n_inputs < 1,
    error('Number of inputs must be 2^1 or greater.');
end


delete_lines(blk);
% Add ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 10 45 24], 'Port', '1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [315 10 345 24], 'Port', '1');
for i=1:2^n_inputs,
    reuse_block(blk, ['In',num2str(i)], 'built-in/inport', 'Position', [15 i*80+95 45 109+80*i]);
    reuse_block(blk, ['Out',num2str(i)], 'built-in/outport', 'Position', [315 95+i*80 345 109+80*i]);
end

% Add blocks
reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
    'Position', [95 85 125 120], 'cnt_type', 'Free Running', 'n_bits', 'n_inputs', ...
    'arith_type', 'Unsigned', 'rst', 'on', 'operation', 'Down');
reuse_block(blk, 'delay0', 'xbsIndex_r4/Delay', ...
    'latency', num2str(2^n_inputs - 1), 'Position', [270 0 300 30]);
reuse_block(blk, 'barrel_switcher', 'barrel_switcher', ...
    'n_inputs', num2str(n_inputs), 'Position', [120 150 240 300]);
for j=1:2^n_inputs,
    reuse_block(blk, ['Delayf', num2str(j)], 'xbsIndex_r4/Delay', ...
        'latency', num2str(j-1), 'Position', [60 j*80+95 90 j*80+125]);
    reuse_block(blk, ['Delayb', num2str(j)], 'xbsIndex_r4/Delay', ...
        'latency', num2str(2^n_inputs-j), 'Position', [270 j*80+95 300 j*80+125]);
end


% Add lines
add_line(blk, 'sync/1', 'counter/1');
add_line(blk, 'sync/1', 'barrel_switcher/2');
add_line(blk, 'counter/1', 'barrel_switcher/1');
add_line(blk, 'barrel_switcher/1', 'delay0/1');
add_line(blk, 'delay0/1', 'sync_out/1');

for j=1:2^n_inputs,
    if j == 1,
        dport = 3;
    else,
        dport = (2^n_inputs - j + 2) + 2;
    end
    add_line(blk, ['In', num2str(j),'/1'], ['Delayf', num2str(j),'/1']);
    add_line(blk, ['Delayf', num2str(j), '/1'], ['barrel_switcher/', num2str(dport)]);
    add_line(blk, ['barrel_switcher/',num2str(j+1)], ['Delayb',num2str(j),'/1']);
    add_line(blk, ['Delayb',num2str(j),'/1'], ['Out',num2str(j),'/1']);
end

clean_blocks(blk);

fmtstr = sprintf('n_inputs=%d', n_inputs);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
