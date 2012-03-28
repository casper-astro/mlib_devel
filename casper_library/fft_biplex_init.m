function fft_biplex_init(blk, varargin)
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
    'mult_spec', [2 2], ...
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

clog(flatstrcell(varargin),'fft_biplex_init_debug');

% check the per-stage multiplier specification
[temp, mult_spec] = multiplier_specification(mult_spec, FFTSize, 'fft_biplex_init');
clear temp;

%propagate_vars([blk,'/biplex_core'],'defaults', defaults, varargin{:});
set_param([blk,'/biplex_core'], ...
    'FFTSize', 'FFTSize', ...
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
propagate_vars([blk,'/biplex_cplx_unscrambler'],'defaults', defaults, varargin{:});

fmtstr = sprintf('%d stages\n%s',FFTSize,arch);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_biplex_init', 'trace');

