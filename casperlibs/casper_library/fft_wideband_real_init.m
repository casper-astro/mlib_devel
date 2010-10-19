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
% Initialize and configure the real wideband FFT.
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

clog('entering fft_wideband_real_init', 'trace');

% Declare any default values for arguments you might like.
defaults = {'FFTSize', 5, 'n_inputs', 2, ...
    'arch', 'Virtex5', 'opt_target', 'logic', ... 
    'quantization', 'Round  (unbiased: +/- Inf)', 'overflow', 'Saturate', ...
    'input_bit_width', 18, 'coeff_bit_width', 18,  ...
    'add_latency', 1, 'mult_latency', 2, 'bram_latency', 2, ...
    'conv_latency', 1, 'coeffs_bit_limit', 8, 'delays_bit_limit', 8, ...
    'specify_mult', 'off', 'mult_spec', [2 2], 'dsp48_adders', 'off'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_wideband_real_init post same_state', 'trace');
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
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
delays_bit_limit = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin), 'fft_wideband_real_init_debug');

if( strcmp(specify_mult, 'on') && length(mult_spec) ~= FFTSize ),
    error('fft_wideband_real_init.m: Multiplier use specification for stages does not match FFT size');
    clog('fft_wideband_real_init.m: Multiplier use specification for stages does not match FFT size','error');
    return
end

if n_inputs < 2                                                
    error('fft_wideband_real_init.m: REAL FFT: Number of inputs must be at least 4!'); 
    clog('fft_wideband_real_init.m: REAL FFT: Number of inputs must be at least 4!','error'); 
    return
end                                                            

delete_lines(blk);

% Add Ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 32 60 48], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [30 82 60 98], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [725 35 755 50], 'Port', '1');

for i=0:2^n_inputs-1,
    reuse_block(blk, ['in',num2str(i)], 'built-in/inport', ... 
        'Position', [30 45*i+125 60 45*i+140], 'Port', num2str(i+3));
end

for i=0:2^(n_inputs-1)-1,
    reuse_block(blk, ['out',num2str(i)], 'built-in/outport', ...
        'Position', [725 45*i+80 755 45*i+100], 'Port', num2str(i+2));
end
reuse_block(blk, 'of', 'built-in/outport', ...
    'Position', [725 45*2^(n_inputs-1)+120 755 45*(2^(n_inputs-1))+135], 'Port', num2str(2^(n_inputs-1)+2));

reuse_block(blk, 'of_or', 'xbsIndex_r4/Logical', ...
    'logical_function', 'OR', 'inputs', tostring(2^(n_inputs-2)+1), 'latency', '1', ...
    'Position', [575 210 625 200+2^(n_inputs-1)*20]);

%generate vectors of multiplier use from vectors passed in
vec_biplex = 2.*ones(1, FFTSize-n_inputs);
vec_direct = 2.*ones(1, n_inputs);

if strcmp(specify_mult, 'on'),
    %generate vectors of multiplier use from vectors passed in
    vec_biplex(1:FFTSize-n_inputs) = mult_spec(1: FFTSize-n_inputs);
    vec_direct = mult_spec(FFTSize-n_inputs+1:FFTSize); 
end

% Add biplex_real_4x FFTs
for i=0:2^(n_inputs-2)-1,
    pos = [100 200*i+100 220 200*i+255];
    name = ['fft_biplex_real_4x',num2str(i)];

    reuse_block(blk, name, 'casper_library_ffts/fft_biplex_real_4x', ...
        'FFTSize', num2str(FFTSize-n_inputs), 'input_bit_width', num2str(input_bit_width), ...
        'quantization', tostring(quantization), 'overflow', tostring(overflow), ...
        'arch', tostring(arch), 'opt_target', tostring(opt_target), ...
        'coeff_bit_width', num2str(coeff_bit_width), ...
        'coeffs_bit_limit', num2str(coeffs_bit_limit), 'delays_bit_limit', num2str(delays_bit_limit), ...
    	'conv_latency', num2str(conv_latency), 'add_latency', num2str(add_latency), ...
        'mult_latency', num2str(mult_latency), 'bram_latency',num2str(bram_latency), ...
        'dsp48_adders', tostring(dsp48_adders), ...
	    'specify_mult', tostring(specify_mult), 'mult_spec', mat2str(vec_biplex), ...
        'Position', pos);

    add_line(blk, ['in',num2str(4*i),'/1'], [name,'/1']);
    add_line(blk, ['in',num2str(4*i+1),'/1'], [name,'/2']);
    add_line(blk, ['in',num2str(4*i+2),'/1'], [name,'/3']);
    add_line(blk, ['in',num2str(4*i+3),'/1'], [name,'/4']);
    add_line(blk, 'shift/1', [name,'/6']);
    add_line(blk, 'sync/1', [name,'/5']);
    
    add_line(blk, [name,'/5'], ['of_or/',num2str(i+2)]);
end


% Add direct FFT
pos = [400 20 520 175];
reuse_block(blk, 'fft_direct', 'casper_library_ffts/fft_direct', ...
    'FFTSize', num2str(n_inputs), 'input_bit_width', num2str(input_bit_width), ...
    'coeff_bit_width', num2str(coeff_bit_width), 'conv_latency', num2str(conv_latency), ...
    'add_latency', num2str(add_latency), 'mult_latency', num2str(mult_latency), ...
    'quantization', tostring(quantization), 'overflow', tostring(overflow), ...
    'bram_latency', num2str(bram_latency), 'map_tail', 'on', ...
    'arch', tostring(arch), 'opt_target', tostring(opt_target), ...
    'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
    'dsp48_adders', tostring(dsp48_adders), ...
    'LargerFFTSize', num2str(FFTSize), 'StartStage', num2str(FFTSize-n_inputs+1), ...
    'specify_mult', tostring(specify_mult), 'mult_spec', mat2str(vec_direct), ...
    'Position', pos);

reuse_block(blk, 'slice', 'xbsIndex_r4/Slice', ...
    'mode', 'Lower Bit Location + Width', 'bit0', num2str(FFTSize-n_inputs), 'nbits', num2str(n_inputs), ...
    'Position', [100 82 130 100]);
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
  
%add overflow
add_line(blk, ['fft_direct/',num2str(2^n_inputs+3-1)], 'of_or/1');
add_line(blk, 'of_or/1', 'of/1');

% Add Unscrambler
reuse_block(blk, 'fft_unscrambler', 'casper_library_ffts/fft_unscrambler', ...
    'FFTSize', num2str(FFTSize-1), 'n_inputs', num2str(n_inputs-1), 'bram_latency', num2str(bram_latency), ...
    'Position', [550 20 670 160]);

for i=1:2^(n_inputs-1)+1,
    add_line(blk, ['fft_direct/',num2str(i)], ['fft_unscrambler/',num2str(i)]);
    if i==1, add_line(blk, ['fft_unscrambler/',num2str(i)], 'sync_out/1');
    else, add_line(blk, ['fft_unscrambler/',num2str(i)], ['out',num2str(i-2),'/1']);
    end
end

clean_blocks(blk);

fmtstr = sprintf('%d stages\n(%d,%d)\n%s\n%s', FFTSize, input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_wideband_real_init','trace');
