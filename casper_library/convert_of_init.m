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

defaults = { ...
  'bit_width_i', 0, ...
  'binary_point_i', 2, ...
  'quantization', 'Truncate', ...
  'overflow', 'Wrap', ...
  'bit_width_o', 8, ...
  'binary_point_o', 7, ...
  'latency',2, ...
};
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

if bit_width_i == 0 | bit_width_o == 0,
  clean_blocks(blk);
  set_param(blk, 'AttributesFormatString', '');
  save_state(blk, 'defaults', defaults, varargin{:});
  return;
end

%input and output ports
reuse_block(blk, 'din', 'built-in/inport', 'Port', '1', 'Position', [50 108 80 122]);
reuse_block(blk, 'dout', 'built-in/outport', 'Port', '1', 'Position', [415 108 445 122]);
reuse_block(blk, 'of', 'built-in/outport', 'Port', '2', 'Position', [415 188 445 202]);

%draw convert block

% First delete the convert block that exists so that it can be changed from a
% Xilnix convert block to a CASPER convert block.
%
% It would probably be better to simply change the convert_of block in
% casper_library_misc.mdl to use CASPER converts explicitly, but changing
% the .mdl file is riskier in that it could lead to merges that tend not to
% be pleasant.
conv_blk = find_system(blk, ...
	'LookUnderMasks','all', 'FollowLinks','on', ...
	'SearchDepth',1, 'Name','convert');
if ~isempty(conv_blk)
	delete_block(conv_blk{1});
end

%if within the capabilities of CASPER convert
if binary_point_i >= binary_point_o,
  reuse_block(blk, 'convert', 'casper_library_misc/convert', ...
    'bin_pt_in', 'binary_point_i', ...
    'n_bits_out', 'bit_width_o', ...
    'bin_pt_out', 'binary_point_o', ...
    'quantization', quantization, ...
    'overflow', overflow, ...
    'latency', 'latency', ...
    'Position', [275 100 320 130]);
else, %use Xilinx convert
  reuse_block(blk, 'convert', 'xbsIndex_r4/Convert', ...
    'arith_type', 'Signed  (2''s comp)', ...
    'n_bits', 'bit_width_o', ...
    'bin_pt', 'binary_point_o', ...
    'quantization', quantization, ...
    'overflow', overflow, ...
    'latency', 'latency', ...
    'pipeline', 'on', ...
    'Position', [275 100 320 130]);
end

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
else
	%draw 'and' blocks \
	%2's complement numbers have overflow if most sig bits to be discarded
	%are different (i.e not all 1's or all 0's)
	reuse_block(blk, 'all_0s', 'xbsIndex_r4/Logical', ...
		'precision','Full', ...
		'inputs', num2str(wb_lost+1), ...
		'latency', 'latency', ...
		'logical_function', 'NAND', ...
		'Position', [275 185 320 185+(wb_lost+1)*20] );

	reuse_block(blk, 'all_1s', 'xbsIndex_r4/Logical', ...
		'precision','Full', ...
		'inputs', num2str(wb_lost+1), ...
		'latency', 'latency', ...
		'logical_function', 'NAND', ...
		'Position', [275 185+(wb_lost+2)*20 320 185+(wb_lost+2)*20+(wb_lost+1)*20] );
	
    %draw slice blocks and inversion blocks
	for i = 1:(wb_lost+1),
		reuse_block(blk, ['slice',num2str(i)], 'xbsIndex_r4/Slice', ...
		'boolean_output','on', 'mode', 'Upper Bit Location + Width', ...
		'bit1', num2str(-1*(i-1)), 'base1', 'MSB of Input', ...
		'Position', [140 134+i*50 175 156+i*50]);
		
        add_line(blk, 'din/1', ['slice',num2str(i),'/1']);
		add_line(blk, ['slice',num2str(i),'/1'], ['all_1s','/',num2str(i)]);

		reuse_block(blk, ['invert',num2str(i)], 'xbsIndex_r4/Inverter', ...
		'Position', [200 134+i*50 235 156+i*50]);
        
        add_line(blk, ['slice',num2str(i),'/1'], ['invert',num2str(i),'/1']);
        add_line(blk, ['invert',num2str(i),'/1'], ['all_0s','/',num2str(i)]);

	end

	reuse_block(blk, 'and', 'xbsIndex_r4/Logical', ...
		'precision','Full', ...
		'inputs', '2', ...
		'latency', '0', ...
		'logical_function', 'AND', ...
		'Position', [350 185 390 220] );

	add_line(blk, 'all_0s/1', 'and/1'); 
	add_line(blk, 'all_1s/1', 'and/2');

    add_line(blk, 'and/1', 'of/1'); 
end

clean_blocks(blk);

fmtstr = sprintf('[%d,%d]->[%d,%d]', bit_width_i, binary_point_i, bit_width_o, binary_point_o);
set_param(blk, 'AttributesFormatString', fmtstr);

save_state(blk, 'defaults', defaults, varargin{:});
