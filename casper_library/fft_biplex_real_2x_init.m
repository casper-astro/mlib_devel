function fft_biplex_real_2x_init(blk, varargin)
% Initialize and configure an fft_biplex_real_2x block.
%
% fft_biplex_real_2x_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames:
% FFTSize = Size of the FFT (2^FFTSize points). 
% input_bit_width = Bit width of input and output data. 
% coeff_bit_width = Bit width of coefficients.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.
% conv_latency = 
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% arch = 
% opt_target = 
% coeff_bit_limit = 
% delays_bit_limit = 
% mult_spec = 
% hardcode_shifts = 
% shift_schedule = 
% dsp48_adders = 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu
%   Copyright (C) 2007 Terry Filiba, Aaron Parsons                            %
%   Copyright (C) 2010 William Mallard                                        %
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

clog('entering fft_biplex_real_2x_init','trace');

% Set default vararg values.
defaults = { ...
    'FFTSize', 2, ...
    'input_bit_width', 18, ...
    'coeff_bit_width', 18, ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'arch', 'Virtex5', ...
    'opt_target', 'logic', ...
    'coeffs_bit_limit', 8, ...
    'delays_bit_limit', 8, ...
    'mult_spec', 2, ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1 1], ...
    'dsp48_adders', 'off', ...
};

% Skip init script if mask state has not changed.
if same_state(blk, 'defaults', defaults, varargin{:}),
  return
end

clog('fft_biplex_real_2x_init post same_state','trace');

% Verify that this is the right mask for the block.
check_mask_type(blk, 'fft_biplex_real_2x');

% Disable link if state changes from default.
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
delays_bit_limit = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
hardcode_shifts = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin), 'fft_biplex_real_2x_init_debug');

if FFTSize == 0,
  delete_lines(blk);
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_biplex_real_2x_init','trace');
  return;
end

% validate input fields

% check the per-stage multiplier specification
[temp, mult_spec] = multiplier_specification(mult_spec, FFTSize, blk);
clear temp;

% Derive useful values.

if FFTSize > coeffs_bit_limit
  bram_map = 'on';
else
  bram_map = 'off';
end

%%%%%%%%%%%%%%%%%%
% Start drawing! %
%%%%%%%%%%%%%%%%%%

% Delete all lines.
delete_lines(blk);

%
% Add inputs and outputs.
%

reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 13 45 27], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [15 43 45 57], 'Port', '2');
reuse_block(blk, 'pol1', 'built-in/inport', 'Position', [15 73 45 87], 'Port', '3');
reuse_block(blk, 'pol2', 'built-in/inport', 'Position', [15 103 45 117], 'Port', '4');
reuse_block(blk, 'pol3', 'built-in/inport', 'Position', [15 133 45 147], 'Port', '5');
reuse_block(blk, 'pol4', 'built-in/inport', 'Position', [15 163 45 177], 'Port', '6');

reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [535  33 565  47], 'Port', '1');
reuse_block(blk, 'pol12_out', 'built-in/outport', 'Position', [535  78 565  92], 'Port', '2');
reuse_block(blk, 'pol34_out', 'built-in/outport', 'Position', [535 123 565 137], 'Port', '3');
reuse_block(blk, 'of', 'built-in/outport', 'Position', [320 138 350 152], 'Port', '4');

%
% Add ri_to_c blocks.
%

reuse_block(blk, 'ri_to_c0', 'casper_library_misc/ri_to_c', ...
    'Position', [95 74 135 116], ...
    'LinkStatus', 'inactive');
reuse_block(blk, 'ri_to_c1', 'casper_library_misc/ri_to_c', ...
    'Position', [95 134 135 176], ...
    'LinkStatus', 'inactive');

%
% Add biplex_core block.
%

reuse_block(blk, 'biplex_core', 'casper_library_ffts/biplex_core', ...
    'Position', [185 30 285 125], ...
    'LinkStatus', 'inactive', ...
    'FFTSize', num2str(FFTSize), ...
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
    'mult_spec', tostring(mult_spec), ...
    'hardcode_shifts', tostring(hardcode_shifts), ...
    'shift_schedule', tostring(shift_schedule), ...
    'dsp48_adders', tostring(dsp48_adders));

%
% Add bi_real_unscr_2x block.
%

reuse_block(blk, 'bi_real_unscr_2x', 'casper_library_ffts_internal/bi_real_unscr_2x', ...
    'Position', [385 15 485 151], ...
    'LinkStatus', 'inactive', ...
    'FFTSize', num2str(FFTSize), ...
    'n_bits', num2str(input_bit_width), ...
    'add_latency', num2str(add_latency), ...
    'conv_latency', num2str(conv_latency), ...
    'bram_latency', num2str(bram_latency), ...
    'bram_map', bram_map, ...
    'dsp48_adders', dsp48_adders);

%
% Draw wires.
%

add_line(blk, 'pol1/1', 'ri_to_c0/1');
add_line(blk, 'pol2/1', 'ri_to_c0/2');
add_line(blk, 'pol3/1', 'ri_to_c1/1');
add_line(blk, 'pol4/1', 'ri_to_c1/2');

add_line(blk, 'sync/1', 'biplex_core/1');
add_line(blk, 'shift/1', 'biplex_core/2');
add_line(blk, 'ri_to_c0/1', 'biplex_core/3');
add_line(blk, 'ri_to_c1/1', 'biplex_core/4');

add_line(blk, 'biplex_core/1', 'bi_real_unscr_2x/1');
add_line(blk, 'biplex_core/2', 'bi_real_unscr_2x/2');
add_line(blk, 'biplex_core/3', 'bi_real_unscr_2x/3');
add_line(blk, 'biplex_core/4', 'of/1');

add_line(blk, 'bi_real_unscr_2x/1', 'sync_out/1');
add_line(blk, 'bi_real_unscr_2x/2', 'pol12_out/1');
add_line(blk, 'bi_real_unscr_2x/3', 'pol34_out/1');

% Delete all unconnected blocks.
clean_blocks(blk);

%%%%%%%%%%%%%%%%%%%
% Finish drawing! %
%%%%%%%%%%%%%%%%%%%

% Set attribute format string (block annotation).
fmtstr = sprintf('%s\n%d stages\n[%d,%d]\n%s\n%s', ...
    arch, FFTSize, input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);

% Save block state to stop repeated init script runs.
save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting fft_biplex_real_2x_init','trace');

