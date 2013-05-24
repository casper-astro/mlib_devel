function twiddle_general_dsp48e_init(blk, varargin)
% Initialize and configure a twiddle_general_dsp48e block.
%
% twiddle_general_dsp48e_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames:
% * Coeffs
% * StepPeriod
% * input_bit_width
% * coeff_bit_width
% * bram_latency
% * conv_latency
% * arch
% * quantization
% * overflow
% * coeffs_bram

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
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

clog('entering twiddle_general_dsp48e_init','trace');

% Set default vararg values.
defaults = { ...
    'Coeffs', [1+i 2+2i], ...
    'StepPeriod', 0, ...
    'input_bit_width', 18, ...
    'coeff_bit_width', 18, ...
    'bram_latency', 2, ...
    'conv_latency', 1, ...
    'arch', 'Virtex5', ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Wrap', ...
    'coeffs_bram', 'off', ...
};

% Skip init script if mask state has not changed.
if same_state(blk, 'defaults', defaults, varargin{:}),
  return
end

clog('twiddle_general_dsp48e_init post same_state', 'trace');

% Verify that this is the right mask for the block.
check_mask_type(blk, 'twiddle_general_dsp48e');

% Disable link if state changes from default.
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
Coeffs = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod = get_var('StepPeriod', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
conv_latency = get_var('conv_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
coeffs_bram = get_var('coeffs_bram', 'defaults', defaults, varargin{:});

clog(flatstrcell(varargin),'twiddle_general_dsp48e_init_debug');

%%%%%%%%%%%%%%%%%%
% Start drawing! %
%%%%%%%%%%%%%%%%%%

% Delete all lines.
delete_lines(blk);

%default case, leave clean block with nothing for storage in the libraries 
if isempty(Coeffs)
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_general_dsp48e_init', 'trace');
  return;
end

%
% Add inputs and outputs.
%

reuse_block(blk, 'a', 'built-in/inport', 'Port', '1', 'Position',[15 28 45 42]);
reuse_block(blk, 'b', 'built-in/inport', 'Port', '2', 'Position',[15 118 45 132]);
reuse_block(blk, 'sync', 'built-in/inport', 'Port', '3', 'Position',[15 303 45 317]);

reuse_block(blk, 'a_re', 'built-in/outport', 'Port', '1', 'Position', [275 13 305 27]);
reuse_block(blk, 'a_im', 'built-in/outport', 'Port', '2', 'Position', [275 43 305 57]);
reuse_block(blk, 'bw_re', 'built-in/outport', 'Port', '3', 'Position', [375 153 405 167]);
reuse_block(blk, 'bw_im', 'built-in/outport', 'Port', '4', 'Position', [375 183 405 197]);
reuse_block(blk, 'sync_out', 'built-in/outport', 'Port', '5', 'Position', [185 303 215 317]);

% Add input delays.

reuse_block(blk, 'a_delay', 'xbsIndex_r4/Delay', ...
    'Position', [95 15 135 55], ...
    'latency', 'bram_latency + 4 + conv_latency');

reuse_block(blk, 'b_delay', 'xbsIndex_r4/Delay', ...
    'Position', [95 105 135 145], ...
    'latency', 'bram_latency', ...
    'reg_retiming', 'on');

reuse_block(blk, 'sync_delay', 'xbsIndex_r4/Delay', ...
    'Position', [95 290 135 330], ...
    'latency', 'bram_latency + 4 + conv_latency');

% Add coefficient generator.
% for the moment we make it unoptimised and compatible with old coeff_gen
% so that it still works
% TODO suck this into twiddle_general
reuse_block(blk, 'coeff_gen', 'casper_library_ffts_twiddle_coeff_gen/coeff_gen', ...
    'Position', [95 200 135 240], ...
    'FFTSize', 'FFTSize', ...
    'Coeffs', mat2str(Coeffs),  ...
    'StepPeriod', num2str(StepPeriod), ...
    'coeff_bit_width', 'coeff_bit_width', ...
    'bram_latency', 'bram_latency', ...
    'coeffs_bram', coeffs_bram, ...
    'dvalid', 'off', 'misc', 'off', ...
    'optimise', 'off');

% Add input c_to_ri blocks.

reuse_block(blk, 'a_c_to_ri', 'casper_library_misc/c_to_ri', ...
    'Position', [185 14 225 56], ...
    'n_bits', 'input_bit_width', ...
    'bin_pt', 'input_bit_width-1');

reuse_block(blk, 'b_c_to_ri', 'casper_library_misc/c_to_ri', ...
    'Position', [185 104 225 146], ...
    'n_bits', 'input_bit_width', ...
    'bin_pt', 'input_bit_width-1');

reuse_block(blk, 'coeff_c_to_ri', 'casper_library_misc/c_to_ri', ...
    'Position', [185 198 225 242], ...
    'n_bits', 'coeff_bit_width', ...
    'bin_pt', 'coeff_bit_width-2');

% Add complex multiplier.

reuse_block(blk, 'cmult', 'casper_library_multipliers/cmult_dsp48e', ...
    'Position', [275 141 325 204], ...
    'n_bits_a', 'input_bit_width', ...
    'bin_pt_a', 'input_bit_width - 1', ...
    'n_bits_b', 'coeff_bit_width', ...
    'bin_pt_b', 'coeff_bit_width - 2', ...
    'conjugated', 'off', ...
    'full_precision', 'off', ...
    'n_bits_c', 'input_bit_width + 4', ...
    'bin_pt_c', 'input_bit_width + 1', ...
    'quantization', tostring(quantization), ...
    'overflow', tostring(overflow), ...
    'cast_latency', 'conv_latency');

%
% Draw wires.
%

add_line(blk, 'a/1', 'a_delay/1');
add_line(blk, 'a_delay/1', 'a_c_to_ri/1');
add_line(blk, 'a_c_to_ri/1', 'a_re/1');
add_line(blk, 'a_c_to_ri/2', 'a_im/1');

add_line(blk, 'b/1', 'b_delay/1');
add_line(blk, 'b_delay/1', 'b_c_to_ri/1');
add_line(blk, 'b_c_to_ri/1', 'cmult/1');
add_line(blk, 'b_c_to_ri/2', 'cmult/2');

add_line(blk, 'sync/1', 'coeff_gen/1');
add_line(blk, 'coeff_gen/1', 'coeff_c_to_ri/1');
add_line(blk, 'coeff_c_to_ri/1', 'cmult/3');
add_line(blk, 'coeff_c_to_ri/2', 'cmult/4');

add_line(blk, 'cmult/1', 'bw_re/1');
add_line(blk, 'cmult/2', 'bw_im/1');

add_line(blk, 'sync/1', 'sync_delay/1');
add_line(blk, 'sync_delay/1', 'sync_out/1');

% Delete all unconnected blocks.
clean_blocks(blk);

%%%%%%%%%%%%%%%%%%%
% Finish drawing! %
%%%%%%%%%%%%%%%%%%%

% Set attribute format string (block annotation).
fmtstr = sprintf('data=(%d,%d)\ncoeffs=(%d,%d)\n%s\n(%s,%s)', ...
    input_bit_width, input_bit_width-1, ...
    coeff_bit_width, coeff_bit_width-2, ...
    arch, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);

% Save block state to stop repeated init script runs.
save_state(blk, 'defaults', defaults, varargin{:});

clog('exiting twiddle_general_dsp48e_init', 'trace');

