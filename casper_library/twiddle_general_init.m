% twiddle_general_init(blk, varargin)
%
% blk = The block to configure
% varargin = {'varname', 'value, ...} pairs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telesope                                                      %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2009 Andrew Martens                                         %
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

defaults = {'n_inputs', 1, 'FFTSize', 4, 'async', 'on', 'Coeffs', [0 1 2 3], 'StepPeriod', 0, ...
    'input_bit_width', 18, 'coeff_bit_width', 18, ...
    'add_latency', 1, 'mult_latency', 2, 'conv_latency', 1, 'bram_latency', 2, ...
    'arch', 'Virtex5', 'coeffs_bram', 'off', 'use_hdl', 'off', 'use_embedded', 'off', ...
    'quantization', 'Round  (unbiased: +/- Inf)', 'overflow', 'Wrap'};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
clog('twiddle_general_init post same_state', 'trace');
check_mask_type(blk, 'twiddle_general');
munge_block(blk, varargin{:});

n_inputs        = get_var('n_inputs', 'defaults', defaults, varargin{:});
FFTSize         = get_var('FFTSize', 'defaults', defaults, varargin{:});
Coeffs          = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod      = get_var('StepPeriod', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency     = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency    = get_var('mult_latency', 'defaults', defaults, varargin{:});
conv_latency    = get_var('conv_latency', 'defaults', defaults, varargin{:});
bram_latency    = get_var('bram_latency', 'defaults', defaults, varargin{:});
arch            = get_var('arch', 'defaults', defaults, varargin{:});
coeffs_bram     = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
use_hdl         = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded    = get_var('use_embedded', 'defaults', defaults, varargin{:});
quantization    = get_var('quantization', 'defaults', defaults, varargin{:});
overflow        = get_var('overflow', 'defaults', defaults, varargin{:});
async           = get_var('async', 'defaults', defaults, varargin{:});

if( strcmp(arch,'Virtex2Pro') ),
elseif( strcmp(arch,'Virtex5') ),
else,
    clog(['twiddle_general_init: unknown target architecture ',arch],'error');
    error(['twiddle_general_init: Unknown target architecture ',arch]);
    return
end

delete_lines(blk);

%default case, leave clean block with nothing for storage in the libraries 
if n_inputs == 0 || FFTSize == 0, 
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  clog('exiting twiddle_general_init', 'trace');
  return;
end

%sync input signal path
reuse_block(blk, 'sync_in', 'built-in/Inport', 'Port', '3', 'Position', [10 108 40 122]);
reuse_block(blk, 'sync_out', 'built-in/Outport', 'Port', '5', 'Position', [750 228 780 242]);

%a input signal path
reuse_block(blk, 'a', 'built-in/Inport', 'Port', '1', 'Position', [10 273 40 287]);

%reorder real and imaginary parts so we can do a simple slice on output 
reuse_block(blk, 'munge_a', 'casper_library_flow_control/munge', ...
        'divisions', 'n_inputs*2', 'div_size', 'input_bit_width', ...
        'order', '[[0:2:(n_inputs*2)-2],[1:2:(n_inputs*2)-1]]', ...
        'Position', [70 267 115 293]);
add_line(blk,'a/1','munge_a/1');

reuse_block(blk, 'a_re', 'built-in/Outport', 'Port', '1', 'Position', [750 263 780 277]);
reuse_block(blk, 'a_im', 'built-in/Outport', 'Port', '2', 'Position', [750 298 780 312]);

%b input signal path
reuse_block(blk, 'b', 'built-in/Inport', 'Port', '2', 'Position', [10 213 40 227]);

reuse_block(blk, 'munge_b', 'casper_library_flow_control/munge', ...
        'divisions', 'n_inputs*2', 'div_size', '(input_bit_width+1)', ...
        'order', '[[0:2:(n_inputs*2)-2],[1:2:(n_inputs*2)-1]]', ...
        'Position', [605 122 645 158]);

%if only one output, for the moment output signed data
if n_inputs == 1, 
  type = 1;
  bin_pt = input_bit_width-1;
else, 
  type = 0;
  bin_pt = 0;
end

if strcmp(async, 'on'), inputNum = 4;
else, inputNum = 3;
end

reuse_block(blk, 'bus_expand2', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of arbitrary size', ...
        'outputNum', num2str(inputNum), ...
        'outputWidth', mat2str([n_inputs*(input_bit_width+1) n_inputs*(input_bit_width+1)]), ...
        'outputBinaryPt', mat2str([bin_pt, bin_pt]), ...
        'outputArithmeticType', mat2str([type, type]), ...
        'Position', [670 112 720 168]);

add_line(blk, 'munge_b/1', 'bus_expand2/1');

reuse_block(blk, 'bw_re', 'built-in/Outport', 'Port', '3', 'Position', [750 118 780 132]);
add_line(blk, 'bus_expand2/1', 'bw_re/1');
reuse_block(blk, 'bw_im', 'built-in/Outport', 'Port', '4', 'Position', [750 148 780 162]);
add_line(blk, 'bus_expand2/2', 'bw_im/1');

%data valid for asynchronous operation
if strcmp(async, 'on'),
  reuse_block(blk, 'dvi', 'built-in/Inport', 'Port', '4', 'Position', [10 183 40 197]);
  reuse_block(blk, 'dvo', 'built-in/Outport', 'Port', '6', 'Position', [750 333 780 347]);
end

reuse_block(blk, 'bus_create', 'casper_library_flow_control/bus_create', ...
        'inputNum', num2str(inputNum), 'Position', [145 204 200 326]);
add_line(blk, 'b/1', 'bus_create/1');
add_line(blk, 'sync_in/1', 'bus_create/2');
add_line(blk, 'munge_a/1', 'bus_create/3');

% Coefficient generator
reuse_block(blk, 'coeff_gen', 'casper_library_ffts_twiddle_coeff_gen/coeff_gen', ...
        'FFTSize', 'FFTSize', 'Coeffs', mat2str(Coeffs), ...
        'coeff_bit_width', 'coeff_bit_width', 'StepPeriod', 'StepPeriod', ...
        'dvalid', async, 'misc', 'on', ...
        'bram_latency', 'bram_latency', 'coeffs_bram', coeffs_bram, ...
        'optimise', 'on', ... %TODO
        'Position', [225 78 285 302]);
add_line(blk, 'sync_in/1', 'coeff_gen/1');

if strcmp(async, 'on'), 
  add_line(blk, 'dvi/1', 'bus_create/4'); 
  add_line(blk, 'dvi/1', 'coeff_gen/2'); 
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
        'bin_pt_b', 'input_bit_width-1', 'type_b', '1', 'cmplx_b', 'on', ...
        'n_bits_out', 'input_bit_width+coeff_bit_width+1', ...
        'bin_pt_out', '(input_bit_width-1)+(coeff_bit_width-1)', 'type_out', '1', ...
        'quantization', '0', 'overflow', '0', ...
        'mult_latency', 'mult_latency', 'add_latency', 'add_latency', ...
        'max_fanout', '2', 'fan_latency', '1', ... %TODO properly
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
      'bin_pt_in', '(input_bit_width-1)+(coeff_bit_width-1)', 'cmplx', 'on', ...
      'n_bits_out', 'input_bit_width+1', 'bin_pt_out', 'input_bit_width-1', ...
      'quantization', quant, 'overflow', of, ...
      'latency', 'conv_latency', 'of', 'off', 'misc', 'on', ...
      'Position', [515 64 570 366]);
add_line(blk, 'bus_mult/1', 'bus_convert/1'); 
add_line(blk, 'bus_mult/2', 'bus_convert/2'); 
add_line(blk, 'bus_convert/1', 'munge_b/1'); 

if strcmp(async, 'on'),
  outputWidth = [1 n_inputs*input_bit_width n_inputs*input_bit_width 1]; %for bus_expand1
  outputBinaryPt = [0  bin_pt bin_pt  0];
  outputArithmeticType = [2 type type 2];
else
  outputWidth = [1 n_inputs*input_bit_width n_inputs*input_bit_width]; %for bus_expand1
  outputBinaryPt = [0 bin_pt bin_pt];
  outputArithmeticType = [2 type type];
end

reuse_block(blk, 'bus_expand1', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of arbitrary size', ...
        'outputNum', num2str(inputNum), ...
        'outputWidth', mat2str(outputWidth) , ...
        'outputBinaryPt', mat2str(outputBinaryPt) , ...
        'outputArithmeticType', mat2str(outputArithmeticType), ...
        'Position', [600 212 650 363]);

add_line(blk,'bus_convert/2','bus_expand1/1');

add_line(blk,'bus_expand1/1','sync_out/1');
add_line(blk,'bus_expand1/2','a_re/1');
add_line(blk,'bus_expand1/3','a_im/1');

if strcmp(async, 'on'), add_line(blk,'bus_expand1/4','dvo/1'); end

clean_blocks(blk);

fmtstr = sprintf('data=(%d,%d)\ncoeffs=(%d,%d)\n(%s,%s)', ...
    input_bit_width, input_bit_width-1, coeff_bit_width, coeff_bit_width-1, quantization, overflow);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
clog('exiting twiddle_general_init', 'trace');
