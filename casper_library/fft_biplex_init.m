% Initialize and configure an fft_biplex block.
%
% fft_biplex_init(blk, varargin)
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
% quantization = Quantization behavior.
% overflow = Overflow behavior.

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

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_biplex_init post same_state', 'trace');
check_mask_type(blk, 'fft_biplex');
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

delete_lines(blk);

%default setup for library
if FFTSize == 0,
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting fft_biplex_init','trace');
  return;
end

% check the per-stage multiplier specification
[temp, mult_spec] = multiplier_specification(mult_spec, FFTSize, blk);
clear temp;

%input ports
reuse_block(blk, 'sync', 'built-in/Inport', 'Port', '1', ...
  'Position', [15 30 45 45]);
reuse_block(blk, 'shift', 'built-in/Inport', 'Port', '2', ...
  'Position', [15 55 45 70]);
reuse_block(blk, 'pol1', 'built-in/Inport', 'Port', '3', ...
  'Position', [15 80 45 95]);
reuse_block(blk, 'pol2', 'built-in/Inport', 'Port', '4', ...
  'Position', [15 105 45 120]);

reuse_block(blk, 'biplex_core', 'casper_library_ffts/biplex_core', ...
  'FFTSize', num2str(FFTSize), ...
  'input_bit_width', num2str(input_bit_width), ...
  'coeff_bit_width', num2str(coeff_bit_width), ...
  'add_latency', num2str(add_latency), ...
  'mult_latency', num2str(mult_latency), ...
  'bram_latency', num2str(bram_latency), ...
  'conv_latency', num2str(conv_latency), ...
  'quantization', quantization, ...
  'overflow', overflow, ...
  'arch', arch, ...
  'opt_target', opt_target, ...
  'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
  'delays_bit_limit', num2str(delays_bit_limit), ...
  'mult_spec', 'mult_spec', ...
  'hardcode_shifts', hardcode_shifts, ...
  'shift_schedule', 'shift_schedule', ...
  'dsp48_adders', dsp48_adders, ...
  'Position', [120 30 180 130]);

add_line(blk, ['sync/1'], ['biplex_core/1']);
add_line(blk, ['shift/1'], ['biplex_core/2']);
add_line(blk, ['pol1/1'], ['biplex_core/3']);
add_line(blk, ['pol2/1'], ['biplex_core/4']);

reuse_block(blk, 'biplex_cplx_unscrambler', 'casper_library_ffts_internal/biplex_cplx_unscrambler', ...
  'FFTSize', 'FFTSize', ...
  'bram_latency', 'bram_latency', ...
  'Position', [285 25 375 125]) 

add_line(blk, ['biplex_core/1'], ['biplex_cplx_unscrambler/3']);
add_line(blk, ['biplex_core/2'], ['biplex_cplx_unscrambler/1']);
add_line(blk, ['biplex_core/3'], ['biplex_cplx_unscrambler/2']);

%output ports
reuse_block(blk, 'of', 'built-in/Outport', 'Port', '4', ...
  'Position', [220 108 250 122]);
add_line(blk, 'biplex_core/4', ['of/1']);

reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '1', ...
  'Position', [425 103 455 117]);
add_line(blk, ['biplex_cplx_unscrambler/3'], ['sync_out/1']);
reuse_block(blk, 'pol1_out', 'built-in/Outport', 'Port', '2', ...
  'Position', [425 33 455 47]);
add_line(blk, ['biplex_cplx_unscrambler/1'], ['pol1_out/1']);
reuse_block(blk, 'pol2_out', 'built-in/Outport', 'Port', '3', ...
  'Position', [425 68 455 82]);
add_line(blk, ['biplex_cplx_unscrambler/2'], ['pol2_out/1']);

fmtstr = sprintf('%d stages\n%s',FFTSize,arch);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_biplex_init', 'trace');

