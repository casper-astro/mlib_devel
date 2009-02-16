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
function fft_init(blk, varargin)
% Initialize and configure the complex FFT.
%
% fft_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% input_bit_width = Bit width of input and output data.
% coeff_bit_width = Bit width of coefficients.
% n_inputs = Number of parallel input streams
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft');
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
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});

biplexes = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on','masktype', 'fft_biplex');
outports = find_system(blk, 'lookUnderMasks', 'on', 'FollowLinks','on','SearchDepth',1,'BlockType', 'Outport');
num_biplexes = length(biplexes);
num_outports = length(outports);

delete_lines(blk);

% Add Ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 0 60 15], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [30 45 60 60], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [700 0 730 15], 'Port', '1');
if n_inputs < 1,
    reuse_block(blk, 'pol0', 'built-in/inport', 'Position', [30 100 60 115]);
    reuse_block(blk, 'pol1', 'built-in/inport', 'Position', [30 200 60 215]);
    reuse_block(blk, 'out0', 'built-in/outport', 'Position', [700 100 730 115]);
    reuse_block(blk, 'out1', 'built-in/outport', 'Position', [700 200 730 215]);
else,
    for i=0:2^n_inputs-1,
        reuse_block(blk, ['in',num2str(i)], 'built-in/inport', 'Position', [30 100*i+100 60 100*i+115], 'Port', num2str(i+3));
        reuse_block(blk, ['out',num2str(i)], 'built-in/outport', 'Position', [700 100*i+100 730 100*i+115], 'Port', num2str(i+2));
    end
end

% Add biplex FFTs
if n_inputs < 1,
    pos = [100 0 220 220];
    name = 'fft_biplex0';
    reuse_block(blk, name, 'casper_library/FFTs/fft_biplex', ...
        'FFTSize', num2str(FFTSize-n_inputs), 'input_bit_width', num2str(input_bit_width), ...
        'coeff_bit_width', num2str(coeff_bit_width), ...
        'add_latency', num2str(add_latency), 'mult_latency', num2str(mult_latency), ...
        'bram_latency', num2str(bram_latency), ... 
        'Position', pos);
    add_line(blk, 'pol0/1', [name,'/1']);
    add_line(blk, 'pol1/1', [name,'/2']);
    add_line(blk, 'shift/1', [name,'/4']);
    add_line(blk, 'sync/1', [name,'/3']);
elseif n_inputs ~= FFTSize,
    for i=0:2^(n_inputs-1)-1,
        pos = [100 200*i+100 220 200*i+220];
        name = ['fft_biplex',num2str(i)];
        reuse_block(blk, name, 'casper_library/FFTs/fft_biplex', ...
            'FFTSize', num2str(FFTSize-n_inputs), 'input_bit_width', num2str(input_bit_width), ...
            'coeff_bit_width', num2str(coeff_bit_width), ...
            'add_latency', num2str(add_latency), 'mult_latency', num2str(mult_latency), ...
            'bram_latency', num2str(bram_latency), 'Position', pos);
        add_line(blk, ['in',num2str(2*i),'/1'], [name,'/1']);
        add_line(blk, ['in',num2str(2*i+1),'/1'], [name,'/2']);
        add_line(blk, 'shift/1', [name,'/4']);
        add_line(blk, 'sync/1', [name,'/3']);
    end
end
% Add direct FFTs
if n_inputs < 1,
    add_line(blk, 'fft_biplex0/1', 'out0/1');
    add_line(blk, 'fft_biplex0/2', 'out1/1');
    add_line(blk, 'fft_biplex0/4', 'sync_out/1');
elseif n_inputs == FFTSize,
    pos = [400 0 520 120];
    reuse_block(blk, 'fft_direct', 'casper_library/FFTs/fft_direct', ...
        'FFTSize', num2str(n_inputs), 'input_bit_width', num2str(input_bit_width), ...
        'coeff_bit_width', num2str(coeff_bit_width), ...
        'add_latency', num2str(add_latency), 'mult_latency', num2str(mult_latency), ...
        'bram_latency', num2str(bram_latency), 'MapTail', '0', ...
        'Position', pos);
    add_line(blk, 'sync/1', 'fft_direct/1');
    add_line(blk, 'shift/1', 'fft_direct/2');
    add_line(blk, 'fft_direct/1', 'sync_out/1');
    for i=0:2^n_inputs-1,
        add_line(blk, ['in',num2str(i),'/1'], ['fft_direct/',num2str(i+3)]);
        add_line(blk, ['fft_direct/',num2str(i+2)], ['out',num2str(i),'/1']);
    end
else,
    pos = [400 0 520 120];
    reuse_block(blk, 'fft_direct', 'casper_library/FFTs/fft_direct', ...
        'FFTSize', num2str(n_inputs), 'input_bit_width', num2str(input_bit_width), ...
        'coeff_bit_width', num2str(coeff_bit_width), ...
        'add_latency', num2str(add_latency), 'mult_latency', num2str(mult_latency), ...
        'bram_latency', num2str(bram_latency), 'MapTail', '1', ...
        'LargerFFTSize', num2str(FFTSize), 'StartStage', num2str(FFTSize-n_inputs+1), 'Position', pos);
    pos = [400 200 520 200+120];
    reuse_block(blk, 'slice', 'xbsIndex_r4/Slice', ...
        'mode', 'Lower Bit Location + Width', 'bit0', num2str(FFTSize-n_inputs), 'nbits', num2str(n_inputs), ...
        'Position', [100 0 130 15]);
    add_line(blk, 'shift/1', 'slice/1');
    add_line(blk, 'slice/1', 'fft_direct/2');
    add_line(blk, 'fft_biplex0/4', 'fft_direct/1');
    for i=0:2^(n_inputs-1)-1,
        bi_name = ['fft_biplex',num2str(i)];
        add_line(blk, [bi_name,'/1'], ['fft_direct/',num2str(3+2*i)]);
        add_line(blk, [bi_name,'/2'], ['fft_direct/',num2str(3+2*i+1)]);
    end
    % Add Unscrambler
    reuse_block(blk, 'fft_unscrambler', 'casper_library/FFTs/fft_unscrambler', ...
        'FFTSize', num2str(FFTSize), 'n_inputs', num2str(n_inputs), 'bram_latency', num2str(bram_latency), ...
        'Position', [550 0 670 120]);
    for i=1:2^n_inputs+1,
        add_line(blk, ['fft_direct/',num2str(i)], ['fft_unscrambler/',num2str(i)]);
        if i==1, add_line(blk, ['fft_unscrambler/',num2str(i)], 'sync_out/1');
        else, add_line(blk, ['fft_unscrambler/',num2str(i)], ['out',num2str(i-2),'/1']);
        end
    end
end

% Propagate dynamic variables

%generate vectors of multiplier use from vectors passed in
vec_biplex = mult_spec(1:FFTSize-n_inputs);
if( n_inputs >= 1 ),
    vec_direct = mult_spec(FFTSize-n_inputs+1:FFTSize); 
end

if n_inputs < 1,
    name = [blk,'/fft_biplex0'];
    set_param(name, 'quantization', tostring(quantization));
    set_param(name, 'overflow', tostring(overflow));
    set_param(name, 'specify_mult', tostring(specify_mult));
    set_param(name, 'mult_spec', mat2str(vec_biplex));
else,
    if n_inputs ~= FFTSize,
        for i=0:2^(n_inputs-1)-1,
            name = [blk,'/fft_biplex',num2str(i)];
            set_param(name, 'quantization', tostring(quantization));
            set_param(name, 'overflow', tostring(overflow));
            set_param(name, 'specify_mult', tostring(specify_mult));
            set_param(name, 'mult_spec', mat2str(vec_biplex));
        end
    end
    name = [blk,'/fft_direct'];
    set_param(name, 'quantization', tostring(quantization));
    set_param(name, 'overflow', tostring(overflow));
    set_param(name, 'specify_mult', tostring(specify_mult));
    set_param(name, 'mult_spec', mat2str(vec_direct));
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, n_inputs=%d', FFTSize, n_inputs);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
