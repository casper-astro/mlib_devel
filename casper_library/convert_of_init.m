% Bit width conversion in 2's complement data with indication of
% over/underflow
%
% convert_of_init(blk, varargin)
% 
% blk = The block to initialise
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
%
% bit_width_i = Total bit width of input data
% binary_point_i = Number of fractional bits in input data
% bit_width_o = Total bit width of output data
% binary_point_o = Number of fractional bits in output data
% quantization = Quantization strategy during conversion
% overflow = Overflow strategy during conversion
% latency = Latency during conversion process

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2008 Andrew Martens                                         %
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

function convert_of_init(blk,varargin)

%disp('Entering');

defaults = {'latency',2};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'convert_of');
munge_block(blk, varargin{:});

bit_width_i = get_var('bit_width_i', 'defaults', defaults, varargin{:});
%data_type_i = get_var('data_type_i', 'defaults', defaults, varargin{:});
binary_point_i = get_var('binary_point_i', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
bit_width_o = get_var('bit_width_o', 'defaults', defaults, varargin{:});
%data_type_o = get_var('data_type_o', 'defaults', defaults, varargin{:});
binary_point_o = get_var('binary_point_o', 'defaults', defaults, varargin{:});
latency = get_var('latency', 'defaults', defaults, varargin{:});

delete_lines(blk);

%input and output ports
reuse_block(blk, 'din', 'built-in/inport', 'Port', '1', 'Position', [50 108 80 122]);
reuse_block(blk, 'dout', 'built-in/outport', 'Port', '1', 'Position', [415 108 445 122]);
reuse_block(blk, 'of', 'built-in/outport', 'Port', '2', 'Position', [415 188 445 202]);
%disp('Input + output ports done');

%draw convert block
reuse_block(blk, 'convert', 'xbsIndex_r4/Convert', ...
	'n_bits', 'bit_width_o', ...
	'bin_pt', 'binary_point_o', ...
	'quantization', tostring(quantization), ...
	'overflow', tostring(overflow), ...
	'latency', 'latency', ...
	'Position', [245 100 290 130]);
%disp('Convert block done');

%join input port to convert to output port
add_line(blk, 'din/1', 'convert/1'); 
add_line(blk, 'convert/1', 'dout/1');

%only care about bits above binary point
wb_lost = max((bit_width_i - binary_point_i) - (bit_width_o - binary_point_o),0);

%for case where no overflow issues
if wb_lost == 0,
	reuse_block(blk, 'never', 'xbsIndex_r4/Constant', ...
		'arith_type', 'Boolean', 'const','0', ...
        'explicit_period', 'on', 'period', '1', ...
		'Position', [315 182 370 208]);
	add_line(blk, 'never/1','of/1');
%	fprintf('Constant done\n');
else
	%draw 'xor' block \
	%2's complement numbers have overflow if most sig bits to be discarded
	%are different (i.e not all 1's or all 0's)
	reuse_block(blk, 'xor', 'xbsIndex_r4/Logical', ...
		'precision','Full', ...
		'inputs', tostring(wb_lost+1), ...
		'latency', 'latency', ...
		'logical_function', 'XOR', ...
		'Position', [245 185 295 245] );
%	disp('XOR block drawn');

	%draw slice blocks
	for i = 1:(wb_lost+1),
		reuse_block(blk, ['slice',num2str(i)], 'xbsIndex_r4/Slice', ...
		'boolean_output','on', 'mode', 'Upper Bit Location + Width', ...
		'bit1', num2str(-1*(i-1)), 'base1', 'MSB of Input', ...
		'Position', [140 134+i*50 175 156+i*50]);

%		disp(['Slice block ',num2str(i),' drawn']);
		add_line(blk, 'din/1', ['slice',num2str(i),'/1']);
		add_line(blk, ['slice',num2str(i),'/1'], ['xor','/',num2str(i)]);
%		disp('Lines drawn');
	end
%	disp('Slice blocks drawn');

	add_line(blk, 'xor/1', 'of/1'); 
end

clean_blocks(blk);

fmtstr = sprintf('[%d,%d]->[%d,%d]', bit_width_i, binary_point_i, bit_width_o, binary_point_o);
set_param(blk, 'AttributesFormatString', fmtstr);

save_state(blk, 'defaults', defaults, varargin{:});
%fprintf(['Done\n']);
