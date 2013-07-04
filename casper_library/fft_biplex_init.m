% Initialize and configure an fft_biplex block.
%
% fft_biplex_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames:
% n_inputs        = Number of simultaneous inputs
% FFTSize         = Size of the FFT (2^FFTSize points).
% input_bit_width = Bit width of input and output data.
% bin_pt_in       = Binary point position of input data.
% coeff_bit_width = Bit width of coefficients.
% add_latency     = The latency of adders in the system.
% mult_latency    = The latency of multipliers in the system.
% bram_latency    = The latency of BRAM in the system. 
% conv_latency    = The latency of convert operations in the system. 
% quantization    = Quantization strategy.
% overflow        = Overflow strategy.

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

function fft_biplex_init(blk, varargin)
clog('entering fft_biplex_init','trace');

% Set default vararg values.
defaults = { ...
    'n_inputs', 1, ...
    'FFTSize', 2, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'async', 'on', ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Saturate', ...
    'opt_target', 'logic', ...
    'delays_bit_limit', 8, ...
    'coeffs_bit_limit', 8, ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'coeff_generation', 'on', ...
    'cal_bits', 1, ...
    'n_bits_rotation', 25, ...
    'max_fanout', 4, ...
    'mult_spec', 2, ...
    'bitgrowth', 'off', ...
    'max_bits', 18, ...
    'hardcode_shifts', 'off', ...
    'shift_schedule', [1 1], ...
    'dsp48_adders', 'off', ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_biplex_init post same_state', {'trace', 'fft_biplex_init_debug'});
check_mask_type(blk, 'fft_biplex');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
async             = get_var('async', 'defaults', defaults, varargin{:});
add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
quantization      = get_var('quantization', 'defaults', defaults, varargin{:});
overflow          = get_var('overflow', 'defaults', defaults, varargin{:});
delays_bit_limit  = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
coeffs_bit_limit  = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
coeff_generation  = get_var('coeff_generation', 'defaults', defaults, varargin{:});
cal_bits          = get_var('cal_bits', 'defaults', defaults, varargin{:});
n_bits_rotation   = get_var('n_bits_rotation', 'defaults', defaults, varargin{:});
max_fanout        = get_var('max_fanout', 'defaults', defaults, varargin{:});
mult_spec         = get_var('mult_spec', 'defaults', defaults, varargin{:});
bitgrowth         = get_var('bitgrowth', 'defaults', defaults, varargin{:});
max_bits          = get_var('max_bits', 'defaults', defaults, varargin{:});
hardcode_shifts   = get_var('hardcode_shifts', 'defaults', defaults, varargin{:});
shift_schedule    = get_var('shift_schedule', 'defaults', defaults, varargin{:});
dsp48_adders      = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

delete_lines(blk);

%default setup for library
if n_inputs == 0 | FFTSize == 0,
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_biplex_init',{'trace','fft_biplex_init_debug'});
  return;
end

% check the per-stage multiplier specification
[temp, mult_spec] = multiplier_specification(mult_spec, FFTSize, blk);
clear temp;

%input ports
reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', 'Position', [15 37 45 53]);
reuse_block(blk, 'shift', 'built-in/Inport', 'Port', '2', 'Position', [15 67 45 83]);
reuse_block(blk, 'pol1', 'built-in/Inport', 'Port', '3', 'Position', [15 97 45 113]);
reuse_block(blk, 'pol2', 'built-in/Inport', 'Port', '4', 'Position', [15 127 45 143]);

reuse_block(blk, 'biplex_core', 'casper_library_ffts/biplex_core', ...
  'n_inputs', num2str(n_inputs), ...
  'FFTSize', num2str(FFTSize), ...
  'input_bit_width', num2str(input_bit_width), ...
  'bin_pt_in', num2str(bin_pt_in), ...
  'coeff_bit_width', num2str(coeff_bit_width), ...
  'async', async, ...
  'add_latency', num2str(add_latency), ...
  'mult_latency', num2str(mult_latency), ...
  'bram_latency', num2str(bram_latency), ...
  'conv_latency', num2str(conv_latency), ...
  'quantization', quantization, ...
  'overflow', overflow, ...
  'delays_bit_limit', num2str(delays_bit_limit), ...
  'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
  'coeff_sharing', coeff_sharing, ...
  'coeff_decimation', coeff_decimation, ...
  'coeff_generation', coeff_generation, ...
  'cal_bits', 'cal_bits', ...
  'n_bits_rotation', 'n_bits_rotation', ...
  'max_fanout', 'max_fanout', ...
  'mult_spec', 'mult_spec', ...
  'bitgrowth', bitgrowth, ...
  'max_bits', num2str(max_bits), ...
  'hardcode_shifts', hardcode_shifts, ...
  'shift_schedule', 'shift_schedule', ...
  'dsp48_adders', dsp48_adders, ...
  'Position', [95 26 170 154]);

add_line(blk, ['sync/1'], ['biplex_core/1']);
add_line(blk, ['shift/1'], ['biplex_core/2']);
add_line(blk, ['pol1/1'], ['biplex_core/3']);
add_line(blk, ['pol2/1'], ['biplex_core/4']);

reuse_block(blk, 'biplex_cplx_unscrambler', 'casper_library_ffts_internal/biplex_cplx_unscrambler', ...
  'FFTSize', num2str(FFTSize), ...
  'bram_latency', num2str(bram_latency), ...
  'async', async, ...
  'Position', [285 25 375 125]) 

add_line(blk, ['biplex_core/1'], ['biplex_cplx_unscrambler/3']);
add_line(blk, ['biplex_core/2'], ['biplex_cplx_unscrambler/1']);
add_line(blk, ['biplex_core/3'], ['biplex_cplx_unscrambler/2']);

%output ports
reuse_block(blk, 'of', 'built-in/Outport', 'Port', '4', 'Position', [210 128 240 142]);
add_line(blk, 'biplex_core/4', ['of/1']);
reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', 'Position', [425 103 455 117]);
add_line(blk, ['biplex_cplx_unscrambler/3'], ['sync_out/1']);
reuse_block(blk, 'pol1_out', 'built-in/Outport', 'Port', '2', 'Position', [425 33 455 47]);
add_line(blk, ['biplex_cplx_unscrambler/1'], ['pol1_out/1']);
reuse_block(blk, 'pol2_out', 'built-in/Outport', 'Port', '3', 'Position', [425 68 455 82]);
add_line(blk, ['biplex_cplx_unscrambler/2'], ['pol2_out/1']);

if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/Inport', 'Port', '5', 'Position', [15 157 45 173]);
  add_line(blk, 'en/1', 'biplex_core/5');
  add_line(blk, 'biplex_core/5', 'biplex_cplx_unscrambler/4');
  
  reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '5', 'Position', [425 133 455 147]);
  add_line(blk, 'biplex_cplx_unscrambler/4', 'dvalid/1');
end

clean_blocks(blk);

fmtstr = sprintf('%d stages',FFTSize);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_biplex_init', {'trace', 'fft_biplex_init_debug'});

