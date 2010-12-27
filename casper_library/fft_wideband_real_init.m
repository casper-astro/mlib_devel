function fft_wideband_real_init(blk, varargin)
% Initialize and configure an fft_wideband_real block.
%
% fft_real_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points).
% input_bit_width = Bit width of input and output data.
% coeff_bit_width = Bit width of coefficient data.
% n_inputs = Number of parallel input streams
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
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

clog('entering fft_wideband_real_init', 'trace');

% Set default vararg values.
defaults = { ...
    'FFTSize', 11, ...
    'n_inputs', 4, ...
    'input_bit_width', 18, ...
    'coeff_bit_width', 18,  ...
    'add_latency', 1, ...
    'mult_latency', 3, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
		'biplex_direct_latency', 2, ...
		'input_latency', 2, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'arch', 'Virtex5', ...
    'opt_target', 'logic', ...
    'coeffs_bit_limit', 8, ...
    'delays_bit_limit', 8, ...
    'specify_mult', 'on', ...
    'mult_spec', ones(1,11), ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1 1 1 1 1], ...
    'dsp48_adders', 'on', ...
    'unscramble', 'on', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_wideband_real_init post same_state', 'trace');
check_mask_type(blk, 'fft_wideband_real');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
biplex_direct_latency = get_var('biplex_direct_latency', 'defaults', defaults, varargin{:});
input_latency = get_var('input_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
delays_bit_limit = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
hardcode_shifts = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});
unscramble = get_var('unscramble', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin), 'fft_wideband_real_init_debug');

if strcmp(specify_mult, 'on') && (length(mult_spec) ~= FFTSize),
    error('fft_wideband_real_init.m: Multiplier use specification for stages does not match FFT size');
    clog('fft_wideband_real_init.m: Multiplier use specification for stages does not match FFT size','error');
    return
end

if n_inputs < 2,
    error('fft_wideband_real_init.m: REAL FFT: Number of inputs must be at least 4!');
    clog('fft_wideband_real_init.m: REAL FFT: Number of inputs must be at least 4!','error');
    return
end

delete_lines(blk);

% Add Ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [30 32 60 48], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [30 82 60 98], 'Port', '2');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [935 32 965 48], 'Port', '1');

for i=0:2^n_inputs-1,
    reuse_block(blk, ['in',num2str(i)], 'built-in/inport', ...
        'Position', [30 45*i+125 60 45*i+140], ...
        'Port', num2str(i+3));
end

for i=0:2^(n_inputs-1)-1,
    reuse_block(blk, ['out',num2str(i)], 'built-in/outport', ...
        'Position', [935 45*i+80 965 45*i+100], ...
        'Port', num2str(i+2));
end
reuse_block(blk, 'of', 'built-in/outport', ...
    'Position', [935 45*2^(n_inputs-1)+120 965 45*(2^(n_inputs-1))+135], ...
    'Port', num2str(2^(n_inputs-1)+2));

reuse_block(blk, 'of_or', 'xbsIndex_r4/Logical', ...
    'Position', [790 210 840 200+2^(n_inputs-1)*20], ...
    'logical_function', 'OR', ...
    'inputs', tostring(2^(n_inputs-2)+1), ...
    'latency', '1');

% split up multiplier specification
mults_biplex = 2.*ones(1, FFTSize-n_inputs);
mults_direct = 2.*ones(1, n_inputs);
if strcmp(specify_mult, 'on'),
    mults_biplex(1:FFTSize-n_inputs) = mult_spec(1: FFTSize-n_inputs);
    mults_direct = mult_spec(FFTSize-n_inputs+1:FFTSize);
end

% split up shift schedule
shifts_biplex = ones(1, FFTSize-n_inputs);
shifts_direct = ones(1, n_inputs);
if strcmp(hardcode_shifts, 'on'),
    shifts_biplex(1:FFTSize-n_inputs) = shift_schedule(1: FFTSize-n_inputs);
    shifts_direct = shift_schedule(FFTSize-n_inputs+1:FFTSize);
end

% Add biplex_real_4x FFTs
for i=0:2^(n_inputs-2)-1,
    pos = [200 200*i+100 320 200*i+255];
    name = ['fft_biplex_real_4x',num2str(i)];

    reuse_block(blk, name, 'casper_library_ffts/fft_biplex_real_4x', ...
        'Position', pos, ...
        'LinkStatus', 'inactive', ...
        'FFTSize', num2str(FFTSize-n_inputs), ...
        'input_bit_width', num2str(input_bit_width), ...
        'coeff_bit_width', num2str(coeff_bit_width), ...
        'add_latency', num2str(add_latency), ...
        'mult_latency', num2str(mult_latency), ...
        'bram_latency', num2str(bram_latency), ...
        'conv_latency', num2str(conv_latency), ...
        'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'arch', tostring(arch), ...
        'opt_target', tostring(opt_target), ...
        'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
        'delays_bit_limit', num2str(delays_bit_limit), ...
        'specify_mult', tostring(specify_mult), ...
        'mult_spec', mat2str(mults_biplex), ...
        'hardcode_shifts', tostring(hardcode_shifts), ...
        'shift_schedule', tostring(shifts_biplex), ...
        'dsp48_adders', tostring(dsp48_adders));

		% input sync through input latency
    reuse_block(blk, strcat('in_del_sync_4x', num2str(i) ), 'casper_library_delays/pipeline', 'latency', tostring(input_latency), 'Position', [125  108+i*200  185  122+i*200]);
    reuse_line(blk, 'sync/1', strcat('in_del_sync_4x', num2str(i), '/1' ) );
    reuse_line(blk, strcat('in_del_sync_4x', num2str(i), '/1' ), [name,'/1']);

		% connect shift
    reuse_line(blk, 'shift/1', [name,'/2']);

		% connect data inputs through input latency
    reuse_block(blk, strcat('in_del_4x', num2str(i), '_pol1'), 'casper_library_delays/pipeline', 'latency', tostring(input_latency), 'Position', [125  158+i*200  185  172+i*200]);
    reuse_block(blk, strcat('in_del_4x', num2str(i), '_pol2'), 'casper_library_delays/pipeline', 'latency', tostring(input_latency), 'Position', [125  183+i*200  185  197+i*200]);
    reuse_block(blk, strcat('in_del_4x', num2str(i), '_pol3'), 'casper_library_delays/pipeline', 'latency', tostring(input_latency), 'Position', [125  208+i*200  185  222+i*200]);
    reuse_block(blk, strcat('in_del_4x', num2str(i), '_pol4'), 'casper_library_delays/pipeline', 'latency', tostring(input_latency), 'Position', [125  233+i*200  185  247+i*200]);

    reuse_line(blk, ['in',num2str(4*i+0),'/1'], strcat('in_del_4x', num2str(i), '_pol1/1') );
    reuse_line(blk, ['in',num2str(4*i+1),'/1'], strcat('in_del_4x', num2str(i), '_pol2/1') );
    reuse_line(blk, ['in',num2str(4*i+2),'/1'], strcat('in_del_4x', num2str(i), '_pol3/1') );
    reuse_line(blk, ['in',num2str(4*i+3),'/1'], strcat('in_del_4x', num2str(i), '_pol4/1') );
    reuse_line(blk, strcat('in_del_4x', num2str(i), '_pol1/1'), [name,'/3']);
    reuse_line(blk, strcat('in_del_4x', num2str(i), '_pol2/1'), [name,'/4']);
    reuse_line(blk, strcat('in_del_4x', num2str(i), '_pol3/1'), [name,'/5']);
    reuse_line(blk, strcat('in_del_4x', num2str(i), '_pol4/1'), [name,'/6']);

		% connect overflow output
    reuse_line(blk, [name,'/6'], ['of_or/',num2str(i+2)]);
    
		% connect data outputs to output latency
    reuse_block(blk, strcat('del_4x', num2str(i), '_pol1'), 'casper_library_delays/pipeline', 'latency', tostring(biplex_direct_latency), 'Position', [335  133+i*200  395  147+i*200]);
    reuse_block(blk, strcat('del_4x', num2str(i), '_pol2'), 'casper_library_delays/pipeline', 'latency', tostring(biplex_direct_latency), 'Position', [335  158+i*200  395  172+i*200]);
    reuse_block(blk, strcat('del_4x', num2str(i), '_pol3'), 'casper_library_delays/pipeline', 'latency', tostring(biplex_direct_latency), 'Position', [335  183+i*200  395  197+i*200]);
    reuse_block(blk, strcat('del_4x', num2str(i), '_pol4'), 'casper_library_delays/pipeline', 'latency', tostring(biplex_direct_latency), 'Position', [335  208+i*200  395  222+i*200]);

		reuse_line(blk, strcat(name, '/2'), strcat('del_4x', num2str(i), '_pol1/1') );
		reuse_line(blk, strcat(name, '/3'), strcat('del_4x', num2str(i), '_pol2/1') );
		reuse_line(blk, strcat(name, '/4'), strcat('del_4x', num2str(i), '_pol3/1') );
		reuse_line(blk, strcat(name, '/5'), strcat('del_4x', num2str(i), '_pol4/1') );
end

% Add direct FFT
pos = [530 35 650 180];
reuse_block(blk, 'fft_direct', 'casper_library_ffts/fft_direct', ...
    'Position', pos, ...
    'LinkStatus', 'inactive', ...
    'FFTSize', num2str(n_inputs), ...
    'input_bit_width', num2str(input_bit_width), ...
    'coeff_bit_width', num2str(coeff_bit_width), ...
    'map_tail', 'on', ...
    'LargerFFTSize', num2str(FFTSize), ...
    'StartStage', num2str(FFTSize-n_inputs+1), ...
    'add_latency', num2str(add_latency), ...
    'mult_latency', num2str(mult_latency), ...
    'bram_latency', num2str(bram_latency), ...
    'conv_latency', num2str(conv_latency), ...
    'quantization', tostring(quantization), ...
    'overflow', tostring(overflow), ...
    'arch', tostring(arch), ...
    'opt_target', tostring(opt_target), ...
    'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
    'specify_mult', tostring(specify_mult), ...
    'mult_spec', mat2str(mults_direct), ...
    'hardcode_shifts', tostring(hardcode_shifts), ...
    'shift_schedule', tostring(shifts_direct), ...
    'dsp48_adders', tostring(dsp48_adders));

reuse_block(blk, 'slice', 'xbsIndex_r4/Slice', ...
    'Position', [100 82 130 100], ...
    'mode', 'Lower Bit Location + Width', ...
    'bit0', num2str(FFTSize-n_inputs), ...
    'nbits', num2str(n_inputs));
reuse_line(blk, 'shift/1', 'slice/1');
reuse_line(blk, 'slice/1', 'fft_direct/2');
for i=0:2^(n_inputs-2)-1,
    reuse_line(blk, strcat('del_4x', num2str(i), '_pol1/1'), ['fft_direct/',num2str(3+4*i)]);
    reuse_line(blk, strcat('del_4x', num2str(i), '_pol2/1'), ['fft_direct/',num2str(3+4*i+1)]);
    reuse_line(blk, strcat('del_4x', num2str(i), '_pol3/1'), ['fft_direct/',num2str(3+4*i+2)]);
    reuse_line(blk, strcat('del_4x', num2str(i), '_pol4/1'), ['fft_direct/',num2str(3+4*i+3)]);
end
reuse_block(blk, 'del_sync', 'casper_library_delays/pipeline', 'latency', tostring(biplex_direct_latency), 'Position', [335  108  395  122]);
reuse_line(blk, 'fft_biplex_real_4x0/1', 'del_sync/1'); 
reuse_line(blk, 'del_sync/1', 'fft_direct/1');

%add overflow
reuse_line(blk, ['fft_direct/',num2str(2^n_inputs+3-1)], 'of_or/1');
reuse_line(blk, 'of_or/1', 'of/1');

% Add Unscrambler
if strcmp(unscramble, 'on'),
    reuse_block(blk, 'fft_unscrambler', 'casper_library_ffts/fft_unscrambler', ...
        'Position', [755 28 875 172], ...
        'FFTSize', num2str(FFTSize-1), ...
        'n_inputs', num2str(n_inputs-1), ...
        'bram_latency', num2str(bram_latency));
    reuse_line(blk, 'fft_direct/1', 'fft_unscrambler/1');
    reuse_line(blk, 'fft_unscrambler/1', 'sync_out/1');
    for i=1:2^(n_inputs-1),
        reuse_line(blk, ['fft_direct/',num2str(i+1)], ['fft_unscrambler/',num2str(i+1)]);
        reuse_line(blk, ['fft_unscrambler/',num2str(i+1)], ['out',num2str(i-1),'/1']);
    end
else
    reuse_line(blk, 'fft_direct/1', 'sync_out/1');
    for i=1:2^(n_inputs-1),
        reuse_line(blk, ['fft_direct/',num2str(i+1)], ['out',num2str(i-1),'/1']);
    end
end

clean_blocks(blk);

fmtstr = sprintf('%d stages\n(%d,%d)\n%s\n%s', FFTSize, input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_wideband_real_init','trace');
