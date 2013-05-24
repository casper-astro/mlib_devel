% Initialize and configure a butterfly_direct block.
%
% butterfly_direct_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% * biplex = Make biplex.
% * FFTSize = Size of the FFT (2^FFTSize points).
% * Coeffs = Coefficients for twiddle blocks.
% * StepPeriod = Coefficient step period.
% * coeffs_bram = Store coefficients in BRAM.
% * coeff_bit_width = Bitwdith of coefficients.
% * input_bit_width = Bitwidth of input and output data.
% * downshift = Explicitly downshift output data.
% * bram_latency = Latency of BRAM blocks.
% * add_latency = Latency of adders blocks.
% * mult_latency = Latency of multiplier blocks.
% * conv_latency = Latency of cast blocks.
% * quantization = Quantization behavior.
% * overflow = Overflow behavior.
% * arch = Target architecture.
% * opt_target = Optimization target.
% * use_hdl = Use behavioral HDL for multipliers.
% * use_embedded = Use embedded multipliers.
% * hardcode_shifts = Enable downshift setting.
% * dsp48_adders = Use DSP48-based adders.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%   Copyright (C) 2010 William Mallard, David MacMahon                        %
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

function butterfly_direct_init(blk, varargin)

clog('entering butterfly_direct_init', 'trace');

% Set default vararg values.
defaults = { ...
    'biplex', 'on', ...
    'FFTSize', 3, ...
    'Coeffs', [0 1 2 3 4 5 6 7], ...
    'StepPeriod', 1, ...
    'coeff_bit_width', 18, ...
    'input_bit_width', 18, ...
    'downshift', 'off', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Wrap', ...
    'arch', 'Virtex5', ...
    'opt_target', 'logic', ...
    'coeffs_bram', 'off', ...
    'use_hdl', 'off', ...
    'use_embedded', 'off', ...
    'hardcode_shifts', 'off', ...
    'dsp48_adders', 'off', ...
};

% Skip init script if mask state has not changed.
if same_state(blk, 'defaults', defaults, varargin{:}), return; end

clog('butterfly_direct_init post same_state', 'trace');

% Verify that this is the right mask for the block.
check_mask_type(blk, 'butterfly_direct');

% Disable link if state changes from default.
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
biplex          = get_var('biplex', 'defaults', defaults, varargin{:});
FFTSize         = get_var('FFTSize', 'defaults', defaults, varargin{:});
Coeffs          = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod      = get_var('StepPeriod', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
downshift       = get_var('downshift', 'defaults', defaults, varargin{:});
bram_latency    = get_var('bram_latency', 'defaults', defaults, varargin{:});
add_latency     = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency    = get_var('mult_latency', 'defaults', defaults, varargin{:});
conv_latency    = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization    = get_var('quantization', 'defaults', defaults, varargin{:});
overflow        = get_var('overflow', 'defaults', defaults, varargin{:});
arch            = get_var('arch', 'defaults', defaults, varargin{:});
opt_target      = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bram     = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
use_hdl         = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded    = get_var('use_embedded', 'defaults', defaults, varargin{:});
hardcode_shifts = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
dsp48_adders    = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

%default case for library storage, delete everything
if FFTSize == 0,
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting butterfly_direct_init', 'trace');
  return;
end

use_dsp48_mults = strcmp(use_embedded, 'on');
use_dsp48_adders = strcmp(dsp48_adders, 'on');
opt_logic = strcmp(opt_target, 'logic');
opt_mults = strcmp(opt_target, 'multipliers');

% Validate input fields.

if ~strcmp(arch, 'Virtex5') && strcmp(dsp48_adders, 'on'),
    fprintf('butterfly_direct_init: Cannot use dsp48e adders on a non-Virtex5 chip.\n');
    clog(['butterfly_direct_init: Cannot use dsp48e adders on a non-Virtex5 chip.\n'], 'error');
end

if strcmp(coeffs_bram, 'on'),
    coeff_type = 'BRAM';
else
    coeff_type = 'slices';
end

if strcmp(hardcode_shifts, 'on'),
    mux_latency = 0;
else
    mux_latency = 2;
end

if use_dsp48_adders,
    set_param(blk, 'add_latency', '2');
    add_latency = 2;
end

% Optimize twiddle for coeff = 0, 1, or alternating 0-1
if length(Coeffs) == 1,
    if Coeffs(1) == 0,
        %if used in biplex core and first stage
        if(strcmp(biplex, 'on')),
            twiddle_type = 'twiddle_pass_through';
        else, %otherwise do same but make sure have correct delay
            twiddle_type = 'twiddle_coeff_0';
        end
    elseif Coeffs(1) == 1,
        twiddle_type = 'twiddle_coeff_1';
    else
        twiddle_type = 'twiddle_general';
    end
elseif length(Coeffs)==2 && Coeffs(1)==0 && Coeffs(2)==1 && StepPeriod==FFTSize-2,
    twiddle_type = 'twiddle_stage_2';
else
    twiddle_type = 'twiddle_general';
end

clog([twiddle_type, ' for twiddle'], 'butterfly_direct_init_debug');
clog(['Coeffs = ', mat2str(Coeffs)], 'butterfly_direct_init_debug');

% Compute bit widths into addsub and convert blocks.
bw = input_bit_width + 3;
bd = input_bit_width;
if strcmp(twiddle_type, 'twiddle_stage_2') ...
    || strcmp(twiddle_type, 'twiddle_coeff_0') ...
    || strcmp(twiddle_type, 'twiddle_coeff_1') ...
    || strcmp(twiddle_type, 'twiddle_pass_through'),
    bw = input_bit_width + 2;
    bd = input_bit_width;
end

addsub_b_bitwidth = bw - 2;
addsub_b_binpoint = bd - 1;

if strcmp(hardcode_shifts, 'on'),
    if strcmp(downshift, 'on'),
        convert_in_bitwidth = bw - 1;
        convert_in_binpoint = bd;
    else
        convert_in_bitwidth = bw - 1;
        convert_in_binpoint = bd - 1;
    end
else
    convert_in_bitwidth = bw;
    convert_in_binpoint = bd;
end

%%%%%%%%%%%%%%%%%%
% Start drawing! %
%%%%%%%%%%%%%%%%%%

% Delete all lines.
delete_lines(blk);

%
% Add inputs and outputs.
%

reuse_block(blk, 'a', 'built-in/inport', ...
    'Position', [20 148 50 162], ...
    'Port', '1');
reuse_block(blk, 'b', 'built-in/inport', ...
    'Position', [40 178 70 192], ...
    'Port', '2');
reuse_block(blk, 'sync', 'built-in/inport', ...
    'Position', [15 208 45 222], ...
    'Port', '3');
reuse_block(blk, 'shift', 'built-in/inport', ...
    'Position', [310 23 340 37], ...
    'Port', '4');

reuse_block(blk, 'a+bw', 'built-in/outport', ...
    'Position', [880 83 910 97], ...
    'Port', '1');
reuse_block(blk, 'a-bw', 'built-in/outport', ...
    'Position', [880 253 910 267], ...
    'Port', '2');
reuse_block(blk, 'of', 'built-in/outport', ...
    'Position', [880 388 910 402], ...
    'Port', '3');
reuse_block(blk, 'sync_out', 'built-in/outport', ...
    'Position', [410 413 440 427], ...
    'Port', '4');

%
% Add twiddle block.
%

reuse_block(blk, 'twiddle', ['casper_library_ffts_twiddle/', twiddle_type], ...
        'FFTSize', num2str(FFTSize), ...
        'input_bit_width', 'input_bit_width', ...
        'bram_latency', 'bram_latency', ...
        'conv_latency', 'conv_latency', ...
        'add_latency', 'add_latency', ...
        'mult_latency', 'mult_latency', ...
        'Position', [110 141 200 229]);

if strcmp(twiddle_type, 'twiddle_general'), 
    set_param([blk, '/twiddle'], ...
        'n_inputs', '1', ...
        'arch', arch, ...
        'use_hdl', use_hdl, ...
        'use_embedded', use_embedded, ...
        'Coeffs', mat2str(Coeffs), ...
        'StepPeriod', 'StepPeriod', ...
        'coeffs_bram', coeffs_bram, ...
        'coeff_bit_width', 'coeff_bit_width', ...
        'quantization', quantization, ...
        'overflow', overflow);    
else,
    set_param([blk, '/twiddle'], ...
        'opt_target', opt_target);
end

%
% Add complex add/sub blocks.
%

if use_dsp48_adders,
    reuse_block(blk, 'cadd', 'casper_library_misc/caddsub_dsp48e', ...
        'Position', [300 71 350 134], ...
        'mode', 'Addition', ...
        'n_bits_a', num2str(input_bit_width), ...
        'bin_pt_a', num2str(input_bit_width-1), ...
        'n_bits_b', num2str(addsub_b_bitwidth), ...
        'bin_pt_b', num2str(addsub_b_binpoint), ...
        'full_precision', 'on');
    reuse_block(blk, 'csub', 'casper_library_misc/caddsub_dsp48e', ...
        'Position', [300 241 350 304], ...
        'mode', 'Subtraction', ...
        'n_bits_a', num2str(input_bit_width), ...
        'bin_pt_a', num2str(input_bit_width-1), ...
        'n_bits_b', num2str(addsub_b_bitwidth), ...
        'bin_pt_b', num2str(addsub_b_binpoint), ...
        'full_precision', 'on');
else
    for i = 0:3,
        yoffset = i*85;
        reuse_block(blk, ['AddSub', num2str(i)], 'xbsIndex_r4/AddSub', ...
            'Position', [300 68+yoffset 350 112+yoffset], ...
            'latency', 'add_latency', ...
            'precision', 'Full', ...
            'use_behavioral_HDL', 'on');
    end
    set_param([blk, '/AddSub0'], 'mode', 'Addition');
    set_param([blk, '/AddSub1'], 'mode', 'Addition');
    set_param([blk, '/AddSub2'], 'mode', 'Subtraction');
    set_param([blk, '/AddSub3'], 'mode', 'Subtraction');
end

%
% Add sync delay.
%

reuse_block(blk, 'sync_delay', 'xbsIndex_r4/Delay', ...
    'Position', [300 403 350 437], ...
    'latency', num2str(['add_latency + ',num2str(mux_latency),' + conv_latency']), ...
    'reg_retiming', 'on');

%
% Add shifts.
%

if strcmp(hardcode_shifts, 'off'),
    reuse_block(blk, 'shift_delay', 'xbsIndex_r4/Delay', ...
        'Position', [400 13 450 47], ...
        'latency', 'add_latency', ...
        'reg_retiming', 'off');

    for i = 0:3,
        yoffset = i*85;
        reuse_block(blk, ['Scale', num2str(i)], 'xbsIndex_r4/Scale', ...
            'Position', [400 99+yoffset 450 121+yoffset], ...
            'scale_factor', '-1');
    end

    for i = 0:3,
        yoffset = i*85;
        reuse_block(blk, ['Mux', num2str(i)], 'xbsIndex_r4/Mux', ...
            'Position', [560 57+yoffset 585 123+yoffset], ...
            'inputs', '2', ...
            'latency', num2str(mux_latency), ...
            'precision', 'Full');
    end
else
    reuse_block(blk, 'Terminator', 'built-in/terminator', ...
        'Position', [400 20 420 40], ...
        'ShowName', 'off');

    if strcmp(downshift, 'on'),
        for i = 0:3,
            yoffset = i*85;
            reuse_block(blk, ['Scale', num2str(i)], 'xbsIndex_r4/Scale', ...
                'Position', [400 79+yoffset 450 101+yoffset], ...
                'scale_factor', '-1');
        end
    end
end %if hardcode_shifts

%
% Add convert blocks.
%

for i = 0:3,
    yoffset = i*85;
    reuse_block(blk, ['convert_of', num2str(i)], 'casper_library_misc/convert_of', ...
        'Position', [630 70+yoffset 680 105+yoffset], ...
        'bit_width_i', num2str(convert_in_bitwidth), ...
        'binary_point_i', num2str(convert_in_binpoint), ...
        'bit_width_o', num2str(input_bit_width), ...
        'binary_point_o', num2str(input_bit_width-1), ...
        'latency', num2str(conv_latency), ...
        'quantization', quantization, ...
        'overflow', overflow);
end

%
% Add ri_to_c and logic blocks.
%

reuse_block(blk, 'ri_to_c01', 'casper_library_misc/ri_to_c', ...
    'Position', [800 69 840 111]);
reuse_block(blk, 'ri_to_c23', 'casper_library_misc/ri_to_c', ...
    'Position', [800 69+2*85 840 111+2*85]);
reuse_block(blk, 'Logical', 'xbsIndex_r4/Logical', ...
    'Position', [800 359 840 426], ...
    'logical_function', 'OR', ...
    'inputs', '4', ...
    'latency', '0', ...
    'precision', 'Full', ...
    'align_bp', 'on');

%
% Draw wires.
%

add_line(blk, 'a/1', 'twiddle/1');
add_line(blk, 'b/1', 'twiddle/2');
add_line(blk, 'sync/1', 'twiddle/3');

if strcmp(dsp48_adders, 'on'),
    add_line(blk, 'twiddle/1', 'cadd/1');
    add_line(blk, 'twiddle/2', 'cadd/2');
    add_line(blk, 'twiddle/3', 'cadd/3');
    add_line(blk, 'twiddle/4', 'cadd/4');
    add_line(blk, 'twiddle/1', 'csub/1');
    add_line(blk, 'twiddle/2', 'csub/2');
    add_line(blk, 'twiddle/3', 'csub/3');
    add_line(blk, 'twiddle/4', 'csub/4');
else
    add_line(blk, 'twiddle/1', 'AddSub0/1');
    add_line(blk, 'twiddle/2', 'AddSub1/1');
    add_line(blk, 'twiddle/3', 'AddSub0/2');
    add_line(blk, 'twiddle/4', 'AddSub1/2');
    add_line(blk, 'twiddle/1', 'AddSub2/1');
    add_line(blk, 'twiddle/2', 'AddSub3/1');
    add_line(blk, 'twiddle/3', 'AddSub2/2');
    add_line(blk, 'twiddle/4', 'AddSub3/2');
end

add_line(blk, 'twiddle/5', 'sync_delay/1');

if strcmp(hardcode_shifts, 'off'),
    add_line(blk, 'shift/1', 'shift_delay/1');

    add_line(blk, 'shift_delay/1', 'Mux0/1');
    add_line(blk, 'shift_delay/1', 'Mux1/1');
    add_line(blk, 'shift_delay/1', 'Mux2/1');
    add_line(blk, 'shift_delay/1', 'Mux3/1');

    if strcmp(dsp48_adders, 'on'),
        add_line(blk, 'cadd/1', 'Mux0/2');
        add_line(blk, 'cadd/2', 'Mux1/2');
        add_line(blk, 'csub/1', 'Mux2/2');
        add_line(blk, 'csub/2', 'Mux3/2');
        add_line(blk, 'cadd/1', 'Scale0/1');
        add_line(blk, 'cadd/2', 'Scale1/1');
        add_line(blk, 'csub/1', 'Scale2/1');
        add_line(blk, 'csub/2', 'Scale3/1');
    else
        add_line(blk, 'AddSub0/1', 'Mux0/2');
        add_line(blk, 'AddSub1/1', 'Mux1/2');
        add_line(blk, 'AddSub2/1', 'Mux2/2');
        add_line(blk, 'AddSub3/1', 'Mux3/2');
        add_line(blk, 'AddSub0/1', 'Scale0/1');
        add_line(blk, 'AddSub1/1', 'Scale1/1');
        add_line(blk, 'AddSub2/1', 'Scale2/1');
        add_line(blk, 'AddSub3/1', 'Scale3/1');
    end

    add_line(blk, 'Scale0/1', 'Mux0/3');
    add_line(blk, 'Scale1/1', 'Mux1/3');
    add_line(blk, 'Scale2/1', 'Mux2/3');
    add_line(blk, 'Scale3/1', 'Mux3/3');

    add_line(blk, 'Mux0/1', 'convert_of0/1');
    add_line(blk, 'Mux1/1', 'convert_of1/1');
    add_line(blk, 'Mux2/1', 'convert_of2/1');
    add_line(blk, 'Mux3/1', 'convert_of3/1');
else
    add_line(blk, 'shift/1', 'Terminator/1');

    if strcmp(downshift, 'on'),
        if strcmp(dsp48_adders, 'on'),
            add_line(blk, 'cadd/1', 'Scale0/1');
            add_line(blk, 'cadd/2', 'Scale1/1');
            add_line(blk, 'csub/1', 'Scale2/1');
            add_line(blk, 'csub/2', 'Scale3/1');

            add_line(blk, 'Scale0/1', 'convert_of0/1');
            add_line(blk, 'Scale1/1', 'convert_of1/1');
            add_line(blk, 'Scale2/1', 'convert_of2/1');
            add_line(blk, 'Scale3/1', 'convert_of3/1');
        else
            add_line(blk, 'AddSub0/1', 'Scale0/1');
            add_line(blk, 'AddSub1/1', 'Scale1/1');
            add_line(blk, 'AddSub2/1', 'Scale2/1');
            add_line(blk, 'AddSub3/1', 'Scale3/1');

            add_line(blk, 'Scale0/1', 'convert_of0/1');
            add_line(blk, 'Scale1/1', 'convert_of1/1');
            add_line(blk, 'Scale2/1', 'convert_of2/1');
            add_line(blk, 'Scale3/1', 'convert_of3/1');
        end
    else
        if strcmp(dsp48_adders, 'on'),
            add_line(blk, 'cadd/1', 'convert_of0/1');
            add_line(blk, 'cadd/2', 'convert_of1/1');
            add_line(blk, 'csub/1', 'convert_of2/1');
            add_line(blk, 'csub/2', 'convert_of3/1');
        else
            add_line(blk, 'AddSub0/1', 'convert_of0/1');
            add_line(blk, 'AddSub1/1', 'convert_of1/1');
            add_line(blk, 'AddSub2/1', 'convert_of2/1');
            add_line(blk, 'AddSub3/1', 'convert_of3/1');
        end
    end
end

add_line(blk, 'convert_of0/1', 'ri_to_c01/1');
add_line(blk, 'convert_of1/1', 'ri_to_c01/2');
add_line(blk, 'convert_of2/1', 'ri_to_c23/1');
add_line(blk, 'convert_of3/1', 'ri_to_c23/2');
add_line(blk, 'convert_of0/2', 'Logical/1');
add_line(blk, 'convert_of1/2', 'Logical/2');
add_line(blk, 'convert_of2/2', 'Logical/3');
add_line(blk, 'convert_of3/2', 'Logical/4');

add_line(blk, 'ri_to_c01/1', 'a+bw/1');
add_line(blk, 'ri_to_c23/1', 'a-bw/1');
add_line(blk, 'Logical/1', 'of/1');
add_line(blk, 'sync_delay/1', 'sync_out/1');

% Delete all unconnected blocks.
clean_blocks(blk);

%%%%%%%%%%%%%%%%%%%
% Finish drawing! %
%%%%%%%%%%%%%%%%%%%

% Set attribute format string (block annotation).
fmtstr = sprintf('%s\ncoeffs in %s', twiddle_type, coeff_type);
set_param(blk, 'AttributesFormatString', fmtstr);

% Save block state to stop repeated init script runs.
save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting butterfly_direct_init', 'trace');

