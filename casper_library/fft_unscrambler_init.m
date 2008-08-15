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

function fft_unscrambler_init(blk, varargin)
% Initialize and configure the FFT unscrambler.
%
% fft_unscrambler_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% n_inputs = Number of parallel input streams
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft_unscrambler');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

if n_inputs >= FFTSize - 2,
    errordlg('FFT Unscrambler: 2^n_inputs must be < 2^(FFT size-2).');
end
part_mat = [0:2^(FFTSize-2*n_inputs)-1]*2^(n_inputs);
map_mat = [];
for i=0:2^n_inputs-1,
    map_mat = [map_mat, part_mat+i];
end
map_str = tostring(map_mat);


delete_lines(blk);

% Add ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 60 60 74], 'Port', '1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [500 40 530 54], 'Port', '1');
for i=1:2^n_inputs,
    reuse_block(blk, ['In',num2str(i)], 'built-in/inport', 'Position', [30 20*i+60 60 20*i+74], 'Port', num2str(i+1));
    reuse_block(blk, ['Out',num2str(i)], 'built-in/outport', 'Position', [500 55*i+40 530 55*i+54], 'Port', num2str(i+1));
end

% Add static blocks
reuse_block(blk, 'square_transposer', 'casper_library/Reorder/square_transposer', ...
    'n_inputs', num2str(n_inputs), 'Position', [85 30 170 2^n_inputs*20+80]);
reuse_block(blk, 'reorder', 'casper_library/Reorder/reorder', ...
    'map', map_str, 'bram_latency', num2str(bram_latency), ...
    'n_inputs', num2str(2^n_inputs), 'map_latency', num2str(1),...
    'double_buffer', '0',...
    'Position', [265 37 360 93]);
reuse_block(blk, 'const', 'xbsIndex_r4/Constant', ...
    'arith_type', 'Boolean', 'explicit_period', 'on', 'Position', [225 57 250 73]);

% Add static lines
add_line(blk, 'sync/1', 'square_transposer/1');
add_line(blk, 'square_transposer/1', 'reorder/1');
add_line(blk, 'reorder/1', 'sync_out/1');
add_line(blk, 'const/1', 'reorder/2');

% Add dynamic lines
for i=1:2^n_inputs,
    in_name = ['In',num2str(i)];
    out_name = ['Out',num2str(i)];
    add_line(blk, [in_name,'/1'], ['square_transposer/',num2str(i+1)]);
    add_line(blk, ['square_transposer/',num2str(i+1)], ['reorder/',num2str(i+2)]);
    add_line(blk, ['reorder/',num2str(i+2)], [out_name,'/1']);
end


clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, n_inputs=%d', FFTSize, n_inputs);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
