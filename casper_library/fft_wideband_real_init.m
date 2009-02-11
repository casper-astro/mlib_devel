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
function fft_wideband_real_init(blk, varargin)
% Initialize and configure the real FFT.
%
% fft_real_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% input_bit_width = Bit width of input and output data.
% coeff_bit_width = Bit width of coefficient data.
% n_inputs = Number of parallel input streams 
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft_wideband_real');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

if n_inputs < 2                                                
	errordlg('REAL FFT: Number of inputs must be at least 4!');  
end                                                            


biplexes = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on','masktype', 'fft_biplex_real_4x');
outports = find_system(blk, 'lookUnderMasks', 'on', 'FollowLinks','on','SearchDepth',1,'BlockType', 'Outport');
num_biplexes = length(biplexes);
num_outports = length(outports);

delete_lines(blk);

% Add Ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 0 60 15], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [30 45 60 60], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [700 0 730 15], 'Port', '1');

for i=0:2^n_inputs-1,
    reuse_block(blk, ['in',num2str(i)], 'built-in/inport', 'Position', [30 100*i+100 60 100*i+115], 'Port', num2str(i+3));
end

for i=0:2^(n_inputs-1)-1,
    reuse_block(blk, ['out',num2str(i)], 'built-in/outport', 'Position', [700 100*i+100 730 100*i+115], 'Port', num2str(i+2));
end

% Add biplex_real_4x FFTs
for i=0:2^(n_inputs-2)-1,
    pos = [100 200*i+100 220 200*i+220];
    name = ['fft_biplex_real_4x',num2str(i)];
    reuse_block(blk, name, 'casper_library/FFTs/fft_biplex_real_4x', ...
        'FFTSize', tostring(FFTSize-n_inputs), 'input_bit_width', tostring(input_bit_width), ...
        'coeff_bit_width',tostring(coeff_bit_width), ...
        'add_latency', tostring(add_latency), 'mult_latency', tostring(mult_latency), ...
        'bram_latency',tostring(bram_latency), 'Position', pos);
    add_line(blk, ['in',num2str(4*i),'/1'], [name,'/1']);
    add_line(blk, ['in',num2str(4*i+1),'/1'], [name,'/2']);
    add_line(blk, ['in',num2str(4*i+2),'/1'], [name,'/3']);
    add_line(blk, ['in',num2str(4*i+3),'/1'], [name,'/4']);
    add_line(blk, 'shift/1', [name,'/6']);
    add_line(blk, 'sync/1', [name,'/5']);
end

% Add direct FFTs
pos = [400 0 520 120];
reuse_block(blk, 'fft_direct', 'casper_library/FFTs/fft_direct', ...
    'FFTSize', num2str(n_inputs), 'input_bit_width', num2str(input_bit_width), ...
    'coeff_bit_width',tostring(coeff_bit_width), ...
    'add_latency', num2str(add_latency), 'mult_latency', num2str(mult_latency), ...
    'bram_latency', num2str(bram_latency), 'MapTail', num2str(1), ...
    'LargerFFTSize', num2str(FFTSize), 'StartStage', num2str(FFTSize-n_inputs+1), 'Position', pos);
pos = [400 200 520 200+120];
reuse_block(blk, 'slice', 'xbsIndex_r4/Slice', ...
    'mode', 'Lower Bit Location + Width', 'bit0', tostring(FFTSize-n_inputs), 'nbits', tostring(n_inputs), ...
    'Position', [100 0 130 15]);
add_line(blk, 'shift/1', 'slice/1');
add_line(blk, 'slice/1', 'fft_direct/2');
add_line(blk, 'fft_biplex_real_4x0/6', 'fft_direct/1');
for i=0:2^(n_inputs-2)-1,
    bi_name = ['fft_biplex_real_4x',num2str(i)];
    add_line(blk, [bi_name,'/1'], ['fft_direct/',num2str(3+4*i)]);                               
        add_line(blk, [bi_name,'/2'], ['fft_direct/',num2str(3+4*i+1)]);                             
        add_line(blk, [bi_name,'/3'], ['fft_direct/',num2str(3+4*i+2)]);                             
        add_line(blk, [bi_name,'/4'], ['fft_direct/',num2str(3+4*i+3)]); 
end

% Add Unscrambler
reuse_block(blk, 'fft_unscrambler', 'casper_library/FFTs/fft_unscrambler', ...
    'FFTSize', num2str(FFTSize-1), 'n_inputs', num2str(n_inputs-1), 'bram_latency', num2str(bram_latency), ...
    'Position', [550 0 670 120]);

for i=1:2^(n_inputs-1)+1,
    add_line(blk, ['fft_direct/',num2str(i)], ['fft_unscrambler/',num2str(i)]);
    if i==1, add_line(blk, ['fft_unscrambler/',num2str(i)], 'sync_out/1');
    else, add_line(blk, ['fft_unscrambler/',num2str(i)], ['out',num2str(i-2),'/1']);
    end
end

clean_blocks(blk);

% Propagate dynamic variables
for i=0:2^(n_inputs-2)-1,
    name = [blk,'/fft_biplex_real_4x',num2str(i)];
    if ~strcmp(get_param(name, 'quantization'), quantization),
        set_param(name, 'quantization', quantization);
    end
    if ~strcmp(get_param(name, 'overflow'), overflow),
        set_param(name, 'overflow', overflow);
    end
end

name = [blk,'/fft_direct'];
if ~strcmp(get_param(name, 'quantization'), quantization),
    set_param(name, 'quantization', quantization);
end
if ~strcmp(get_param(name, 'overflow'), overflow),
    set_param(name, 'overflow', overflow);
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, n_inputs=%d,\n input_bit_width=%d,\n coeff_bit_width=%d', FFTSize, n_inputs, input_bit_width, coeff_bit_width);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
