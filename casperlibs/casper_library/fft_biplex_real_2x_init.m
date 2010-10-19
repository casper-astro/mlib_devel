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

function fft_biplex_real_2x_init(blk, varargin)
% Initialize and configure the 2x real FFT biplex.
%
% fft_biplex_real_2x_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points).
% input_bit_width = Bit width of input and output data.
% coeff_bit_width = Bit width of coefficients
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system. 
% quantization = Quantization behavior.
% overflow = Overflow behavior.

clog('entering fft_biplex_real_2x_init','trace');
% Declare any default values for arguments you might like.
defaults = {'FFTSize', 2, 'input_bit_width', 18, 'coeff_bit_width', 18, ...
    'quantization', 'Round  (unbiased: +/- Inf)', 'overflow', 'Saturate', ...
    'add_latency', 1, 'mult_latency', 2, 'bram_latency', 2, ...
    'arch', 'Virtex5', 'opt_target', 'logic', ...
    'conv_latency', 1, 'coeffs_bit_limit', 8, 'delays_bit_limit', 8, ...
    'specify_mult', 'off', 'mult_spec', [2 2], 'dsp48_adders', 'off'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('fft_biplex_real_2x_init post same_state','trace');
check_mask_type(blk, 'fft_biplex_real_2x');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
delays_bit_limit = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin), 'fft_biplex_real_2x_init_debug');

if( strcmp(specify_mult, 'on') && (length(mult_spec) ~= FFTSize)),
    errordlg('fft_biplex_real_2x_init.m: Multiplier use specification for stages does not match FFT size');
    error('fft_biplex_real_2x_init.m: Multiplier use specification for stages does not match FFT size');
    return;
end

delete_lines(blk);

% Add Ports
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15   158    45   172], 'Port', '1');
reuse_block(blk, 'shift', 'built-in/inport', 'Position', [15   183    45   197], 'Port', '2');
reuse_block(blk, 'pol0', 'built-in/inport', 'Position', [15    33    45    47], 'Port', '3');
reuse_block(blk, 'pol1', 'built-in/inport', 'Position', [15    63    45    77], 'Port', '4');
reuse_block(blk, 'pol2', 'built-in/inport', 'Position', [15    93    45   107], 'Port', '5');
reuse_block(blk, 'pol3', 'built-in/inport', 'Position', [15   123    45   137], 'Port', '6');

reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [470   173   500   187], 'Port', '1');
reuse_block(blk, 'pol02_out', 'built-in/outport', 'Position', [470   113   500   127], 'Port', '2');
reuse_block(blk, 'pol13_out', 'built-in/outport', 'Position', [470   143   500   157], 'Port', '3');
reuse_block(blk, 'of', 'built-in/outport', 'Position', [285   153   315   167], 'Port', '4');

reuse_block(blk, 'ri_to_c0', 'casper_library_misc/ri_to_c','Position',[65    34   105    76]);
reuse_block(blk, 'ri_to_c1', 'casper_library_misc/ri_to_c','Position',[65    94   105   136]);

%generate vectors of multiplier use from vectors passed in
if strcmp(specify_mult,'on'),
    mult_spec_str = mat2str(mult_spec);
else
    mult_spec_str = mat2str(2.*ones(1, FFTSize));
end

reuse_block(blk, 'biplex_core', 'casper_library_ffts/biplex_core', ...
    'FFTSize', num2str(FFTSize), 'input_bit_width', num2str(input_bit_width), ...
    'coeff_bit_width', num2str(coeff_bit_width), ... 
    'quantization', tostring(quantization), 'add_latency', num2str(add_latency), ...
    'mult_latency', num2str(mult_latency), 'bram_latency',num2str(bram_latency), ...
    'dsp48_adders', tostring(dsp48_adders), 'arch', tostring(arch), ...
    'opt_target', tostring(opt_target), 'coeffs_bit_limit', num2str(coeffs_bit_limit), ...
    'delays_bit_limit', num2str(delays_bit_limit), 'overflow', tostring(overflow), ...
    'conv_latency', num2str(conv_latency), 'specify_mult', tostring(specify_mult), ...
    'mult_spec', mult_spec_str, 'Position', [145 105 265 200]);

add_line(blk, ['pol0','/1'], ['ri_to_c0','/1']);
add_line(blk, ['pol1','/1'], ['ri_to_c0','/2']);
add_line(blk, ['pol2','/1'], ['ri_to_c1','/1']);
add_line(blk, ['pol3','/1'], ['ri_to_c1','/2']);

add_line(blk, ['ri_to_c0','/1'],'biplex_core/1');
add_line(blk, ['ri_to_c1','/1'],'biplex_core/2');

add_line(blk, 'sync/1', ['biplex_core','/3']);
add_line(blk, 'shift/1', ['biplex_core','/4']);
add_line(blk, ['biplex_core','/1'],'bi_real_unscr_2x/1');
add_line(blk, ['biplex_core','/2'],'bi_real_unscr_2x/2');
add_line(blk, ['biplex_core','/3'],'of/1');
add_line(blk, ['biplex_core','/4'],'bi_real_unscr_2x/3');

add_line(blk, 'bi_real_unscr_2x/1','pol02_out/1');
add_line(blk, 'bi_real_unscr_2x/2','pol13_out/1');
add_line(blk, 'bi_real_unscr_2x/3','sync_out/1');

% Unscrambler is not in library!
if FFTSize > coeffs_bit_limit
  bram_map = 'on';
else
  bram_map = 'off';
end
propagate_vars([blk,'/bi_real_unscr_2x'],'defaults', defaults, varargin{:}, 'bram_map', bram_map);

fmtstr = sprintf('%s\n%d stages\n[%d,%d]\n%s\n%s', arch, FFTSize, input_bit_width, coeff_bit_width, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting fft_biplex_real_2x_init','trace');
