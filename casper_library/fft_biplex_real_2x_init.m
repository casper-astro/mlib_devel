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

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft_biplex_real_2x');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
opt_target = get_var('opt_target', 'defaults', defaults, varargin{:});
coeffs_bit_limit = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
delays_bit_limit = get_var('delays_bit_limit', 'defaults', defaults, varargin{:});
specify_mult = get_var('specify_mult', 'defaults', defaults, varargin{:});
mult_spec = get_var('mult_spec', 'defaults', defaults, varargin{:});
dsp48_adders = get_var('dsp48_adders', 'defaults', defaults, varargin{:});

if( strcmp(specify_mult, 'on') && (length(mult_spec) ~= FFTSize)),
    errordlg('fft_biplex_real_2x_init.m: Multiplier use specification for stages does not match FFT size');
    error('fft_biplex_real_2x_init.m: Multiplier use specification for stages does not match FFT size');
    return
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

reuse_block(blk, 'ri_to_c0', 'casper_library/Misc/ri_to_c','Position',[65    34   105    76]);
reuse_block(blk, 'ri_to_c1', 'casper_library/Misc/ri_to_c','Position',[65    94   105   136]);

reuse_block(blk, 'biplex_core', 'casper_library/FFTs/biplex_core', ...
 'FFTSize', tostring(FFTSize), 'input_bit_width', tostring(input_bit_width), ...
 'coeff_bit_width',tostring(coeff_bit_width), ...
 'overflow', overflow, ...
 'quantization', quantization,... 
 'add_latency', tostring(add_latency), 'mult_latency', tostring(mult_latency), ...
 'bram_latency',tostring(bram_latency), 'dsp48_adders', tostring(dsp48_adders), ...
 'arch', tostring(arch), 'opt_target', tostring(opt_target), ...
 'coeffs_bit_limit', tostring(coeffs_bit_limit), ...
 'delays_bit_limit', tostring(delays_bit_limit), ...
 'Position', [145 105 265 200]);


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
propagate_vars([blk,'/bi_real_unscr_2x'],'defaults', defaults, varargin{:});

% Propagate dynamic variables
%generate vectors of multiplier use from vectors passed in
if strcmp(specify_mult,'on'),
    set_param([blk,'/biplex_core'], 'specify_mult', tostring(specify_mult), 'mult_spec', mat2str(mult_spec));
else
    set_param([blk,'/biplex_core'], 'specify_mult', tostring(specify_mult), 'mult_spec', mat2str( 2.*ones(1, FFTSize)));
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d', FFTSize);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});

