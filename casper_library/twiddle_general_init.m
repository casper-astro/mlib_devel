% twiddle_general_init(blk, varargin)
%
% blk = The block to configure
% varargin = {'varname', 'value, ...} pairs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telesope                                                      %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2013 Andrew Martens                                         %
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

function twiddle_general_init(blk, varargin)
clog('entering twiddle_general_init','trace');

defaults = { ...
    'n_inputs', 1, ...
    'FFTSize', 2, ...
    'async', 'off', ...
    'Coeffs', [0 1], ...
    'StepPeriod', 0, ...
    'input_bit_width', 18, ...
    'bin_pt_in', 17, ...
    'coeff_bit_width', 18, ...
    'add_latency', 1, ...
    'mult_latency', 2, ...
    'conv_latency', 1, ...
    'bram_latency', 2, ...
    'coeffs_bit_limit', 9, ...
    'coeff_sharing', 'on', ...
    'coeff_decimation', 'on', ...
    'coeff_generation', 'on', ...
    'cal_bits', 1, ...
    'n_bits_rotation', 25, ...
    'max_fanout', 4, ...
    'use_hdl', 'off', ...
    'use_embedded', 'off', ...
    'quantization', 'Round  (unbiased: +/- Inf)', ...
    'overflow', 'Wrap'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('twiddle_general_init post same_state', 'trace');
check_mask_type(blk, 'twiddle_general');
munge_block(blk, varargin{:});

n_inputs          = get_var('n_inputs', 'defaults', defaults, varargin{:});
FFTSize           = get_var('FFTSize', 'defaults', defaults, varargin{:});
Coeffs            = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod        = get_var('StepPeriod', 'defaults', defaults, varargin{:});
input_bit_width   = get_var('input_bit_width', 'defaults', defaults, varargin{:});
bin_pt_in         = get_var('bin_pt_in', 'defaults', defaults, varargin{:});
coeff_bit_width   = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency       = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency      = get_var('mult_latency', 'defaults', defaults, varargin{:});
conv_latency      = get_var('conv_latency', 'defaults', defaults, varargin{:});
bram_latency      = get_var('bram_latency', 'defaults', defaults, varargin{:});
coeffs_bit_limit  = get_var('coeffs_bit_limit', 'defaults', defaults, varargin{:});
coeff_sharing     = get_var('coeff_sharing', 'defaults', defaults, varargin{:});
coeff_decimation  = get_var('coeff_decimation', 'defaults', defaults, varargin{:});
coeff_generation  = get_var('coeff_generation', 'defaults', defaults, varargin{:});
cal_bits          = get_var('cal_bits', 'defaults', defaults, varargin{:});
n_bits_rotation   = get_var('n_bits_rotation', 'defaults', defaults, varargin{:});
max_fanout        = get_var('max_fanout', 'defaults', defaults, varargin{:});
use_hdl           = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded      = get_var('use_embedded', 'defaults', defaults, varargin{:});
quantization      = get_var('quantization', 'defaults', defaults, varargin{:});
overflow          = get_var('overflow', 'defaults', defaults, varargin{:});
async           = get_var('async', 'defaults', defaults, varargin{:});

delete_lines(blk);

%default case, leave clean block with nothing for storage in the libraries 
if n_inputs == 0 || FFTSize == 0, 
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_general_init', 'trace');
  return;
end

%sync signal path
reuse_block(blk, 'sync_in', 'built-in/Inport', 'Port', '3', 'Position', [10 108 40 122]);
reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '3', 'Position', [750 233 780 247]);

%a signal path
reuse_block(blk, 'ai', 'built-in/Inport', 'Port', '1', 'Position', [10 273 40 287]);
reuse_block(blk, 'ao', 'built-in/Outport', 'Port', '1', 'Position', [750 283 780 297]);

%b signal path
reuse_block(blk, 'bi', 'built-in/Inport', 'Port', '2', 'Position', [10 213 40 227]);

if strcmp(async, 'on'), inputNum = 4;
else, inputNum = 3;
end

reuse_block(blk, 'bwo', 'built-in/Outport', 'Port', '2', 'Position', [750 133 780 147]);

%data valid for asynchronous operation
if strcmp(async, 'on'),
  reuse_block(blk, 'en', 'built-in/Inport', 'Port', '4', 'Position', [10 183 40 197]);
  reuse_block(blk, 'dvalid', 'built-in/Outport', 'Port', '4', 'Position', [750 333 780 347]);
end

reuse_block(blk, 'bus_create', 'casper_library_flow_control/bus_create', ...
        'inputNum', num2str(inputNum), 'Position', [145 204 200 326]);
add_line(blk, 'bi/1', 'bus_create/1');
add_line(blk, 'sync_in/1', 'bus_create/2');
add_line(blk, 'ai/1', 'bus_create/3');

% Coefficient generator
reuse_block(blk, 'coeff_gen', 'casper_library_ffts_twiddle_coeff_gen/coeff_gen', ...
        'FFTSize', 'FFTSize', 'Coeffs', mat2str(Coeffs), ...
        'coeff_bit_width', 'coeff_bit_width', 'StepPeriod', 'StepPeriod', ...
        'async', async, 'misc', 'on', ...
        'bram_latency', 'bram_latency', 'mult_latency', 'mult_latency', ...
        'add_latency', 'add_latency', 'conv_latency', 'conv_latency', ...
        'coeffs_bit_limit', 'coeffs_bit_limit', 'coeff_sharing', coeff_sharing, ...
        'coeff_decimation', coeff_decimation, 'coeff_generation', coeff_generation, ...
        'cal_bits', 'cal_bits', 'n_bits_rotation', 'n_bits_rotation', ...           
        'quantization', quantization, 'Position', [225 78 285 302]);
add_line(blk, 'sync_in/1', 'coeff_gen/1');

if strcmp(async, 'on'), 
  add_line(blk, 'en/1', 'bus_create/4'); 
  add_line(blk, 'en/1', 'coeff_gen/2'); 
  add_line(blk, 'bus_create/1', 'coeff_gen/3'); 
  
  reuse_block(blk, 'Terminator', 'built-in/Terminator', 'Position', [305 180 325 200]);
  add_line(blk, 'coeff_gen/2', 'Terminator/1'); 
  outputWidth = '[n_inputs*input_bit_width*2, 2+(n_inputs*input_bit_width*2)]'; %for bus_expand
else, 
  add_line(blk, 'bus_create/1', 'coeff_gen/2'); 
  outputWidth = '[n_inputs*input_bit_width*2, 1+(n_inputs*input_bit_width*2)]'; %for bus_expand
end

%bus expand pre multipliers
reuse_block(blk, 'bus_expand', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of arbitrary size', 'outputNum', '2', ...
        'outputWidth', outputWidth, 'outputBinaryPt', '[0 0]', ...
        'outputArithmeticType', '[0 0]', 'Position', [345 164 395 366]);

if strcmp(async,'on'), add_line(blk, 'coeff_gen/3', 'bus_expand/1');
else, add_line(blk, 'coeff_gen/2', 'bus_expand/1');
end

%multipliers
reuse_block(blk, 'bus_mult', 'casper_library_bus/bus_mult', ...
        'n_bits_a', 'coeff_bit_width', ...
        'bin_pt_a', 'coeff_bit_width-1', 'type_a', '1', 'cmplx_a', 'on', ...
        'n_bits_b', mat2str(repmat(input_bit_width, 1, n_inputs)), ...
        'bin_pt_b', 'bin_pt_in', 'type_b', '1', 'cmplx_b', 'on', ...
        'n_bits_out', 'input_bit_width+coeff_bit_width+1', ...
        'bin_pt_out', '(bin_pt_in+coeff_bit_width-1)', 'type_out', '1', ...
        'quantization', '0', 'overflow', '0', ...
        'mult_latency', 'mult_latency', 'add_latency', 'add_latency', 'conv_latency', '0', ...
        'max_fanout', 'max_fanout', 'fan_latency', '1', ...
        'misc', 'on', ...
        'Position', [430 66 485 364]);
	add_line(blk,'coeff_gen/1','bus_mult/1');
	add_line(blk,'bus_expand/2','bus_mult/3');
	add_line(blk,'bus_expand/1','bus_mult/2');

%convert
if strcmp(quantization, 'Truncate'), quant = '0';
elseif strcmp(quantization, 'Round  (unbiased: +/- Inf)'), quant = '1';
elseif strcmp(quantization, 'Round  (unbiased: Even Values)'), quant = '2';
else %TODO 
end

if strcmp(overflow, 'Wrap'), of = '0';
elseif strcmp(overflow, 'Saturate'), of = '1';
elseif strcmp(overflow, 'Flag as error'), of = '2';
else %TODO
end

reuse_block(blk, 'bus_convert', 'casper_library_bus/bus_convert', ...
      'n_bits_in', 'repmat(input_bit_width+coeff_bit_width+1, 1, n_inputs)', ...
      'bin_pt_in', '(bin_pt_in+coeff_bit_width-1)', 'cmplx', 'on', ...
      'n_bits_out', 'input_bit_width+1', 'bin_pt_out', 'bin_pt_in', ...
      'quantization', quant, 'overflow', of, ...
      'latency', 'conv_latency', 'of', 'off', 'misc', 'on', ...
      'Position', [515 64 570 366]);
add_line(blk, 'bus_mult/1', 'bus_convert/1'); 
add_line(blk, 'bus_mult/2', 'bus_convert/2'); 
add_line(blk, 'bus_convert/1', 'bwo/1');

outputWidth = [1 n_inputs*(input_bit_width*2)];   %cut sync out
outputBinaryPt = [0 0];                           
outputArithmeticType = [2 0];

%cut dvalid out again
if strcmp(async, 'on'),
  outputWidth = [outputWidth, 1];
  outputBinaryPt = [outputBinaryPt, 0];
  outputArithmeticType = [outputArithmeticType, 2];
end

reuse_block(blk, 'bus_expand1', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of arbitrary size', ...
        'outputNum', num2str(inputNum-1), ...
        'outputWidth', mat2str(outputWidth) , ...
        'outputBinaryPt', mat2str(outputBinaryPt) , ...
        'outputArithmeticType', mat2str(outputArithmeticType), ...
        'Position', [600 212 650 363]);

add_line(blk,'bus_convert/2','bus_expand1/1');

add_line(blk,'bus_expand1/1','sync_out/1');
add_line(blk,'bus_expand1/2','ao/1');

if strcmp(async, 'on'), add_line(blk,'bus_expand1/3','dvalid/1'); end

clean_blocks(blk);

fmtstr = sprintf('data=(%d,%d)\ncoeffs=(%d,%d)\n(%s,%s)', ...
    input_bit_width, bin_pt_in, coeff_bit_width, coeff_bit_width-1, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting twiddle_general_init', 'trace');
