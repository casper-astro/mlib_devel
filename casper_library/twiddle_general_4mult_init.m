% twiddle_general_4mult_init(blk, varargin)
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

function twiddle_general_4mult_init(blk, varargin)

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'twiddle_general_4mult');
munge_block(blk, varargin{:});

Coeffs = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod = get_var('StepPeriod', 'defaults', defaults, varargin{:});
input_bit_width = get_var('input_bit_width', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
arch = get_var('arch', 'defaults', defaults, varargin{:});
coeffs_bram = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
use_hdl = get_var('use_hdl', 'defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});

if( strcmp(arch,'Virtex2Pro') ),
%    disp('targeting V2Pro');
elseif( strcmp(arch,'Virtex5') ),
%    disp('targeting V5');
else,
    error('twiddle_general_4mult_init.m: Unknown target architecture')
end

delete_lines(blk);

conv_latency = 1;

%a input signal path
reuse_block(blk, 'a', 'built-in/inport', 'Port', '1', 'Position',[225 28 255 42]);
reuse_block(blk, 'Delay', 'xbsIndex_r4/Delay', ...
    'latency',tostring(mult_latency + add_latency + bram_latency + conv_latency), ...
    'Position', [275 15 315 55]);
add_line(blk, 'a/1', 'Delay/1');
reuse_block(blk, 'c_to_ri1', 'casper_library/Misc/c_to_ri', ...
    'n_bits', tostring(input_bit_width), 'bin_pt', tostring(input_bit_width-1), ...
    'Position', [340 14 380 56]);
add_line(blk,'Delay/1','c_to_ri1/1');
reuse_block(blk, 'a_re', 'built-in/outport', 'Port', '1', 'Position', [405 13 435 27]);
reuse_block(blk, 'a_im', 'built-in/outport', 'Port', '2', 'Position', [405 43 435 57]);
add_line(blk, 'c_to_ri1/1', 'a_re/1');
add_line(blk, 'c_to_ri1/2', 'a_im/1');

%sync input signal path
reuse_block(blk, 'sync', 'built-in/inport', 'Port', '3', 'Position',[40 393 70 407]);
reuse_block(blk, 'Delay2', 'xbsIndex_r4/Delay', ...
    'latency',tostring(mult_latency + add_latency + bram_latency + conv_latency), ...
    'Position', [280 380 320 420]);
add_line(blk, 'sync/1', 'Delay2/1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Port', '5', 'Position', [340 393 370 407]);
add_line(blk, 'Delay2/1', 'sync_out/1');

%coefficient generator
reuse_block(blk, 'coeff_gen', 'casper_library/FFTs/Twiddle/coeff_gen/coeff_gen', ...
    'Coeffs', tostring(Coeffs),  ...
    'StepPeriod', tostring(StepPeriod), 'coeff_bit_width', tostring(coeff_bit_width), ...
    'bram_latency', tostring(bram_latency), 'coeffs_bram', coeffs_bram, ...
    'Position', [105 249 150 291]);
add_line(blk, 'sync/1', 'coeff_gen/1');

reuse_block(blk, 'c_to_ri2', 'casper_library/Misc/c_to_ri', ...
    'n_bits', tostring(coeff_bit_width), 'bin_pt', tostring(coeff_bit_width-1), ...
    'Position', [180 249 220 291]);
add_line(blk, 'coeff_gen/1', 'c_to_ri2/1');

%b input signal path
reuse_block(blk, 'b', 'built-in/inport', 'Port', '2', 'Position',[35 148 65 162]);
reuse_block(blk, 'Delay1', 'xbsIndex_r4/Delay', 'latency', tostring(bram_latency), ...
    'Position', [105 135 145 175]);
add_line(blk, 'b/1', 'Delay1/1');
reuse_block(blk, 'c_to_ri3', 'casper_library/Misc/c_to_ri', ...
    'n_bits', tostring(input_bit_width), 'bin_pt', tostring(input_bit_width-1), ...
    'Position', [185 134 225 176]);
add_line(blk, 'Delay1/1', 'c_to_ri3/1');

%Mult
reuse_block(blk, 'Mult', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', tostring(mult_latency), ...
    'Position', [275 128 320 172]);
add_line(blk, 'c_to_ri3/1', 'Mult/1');
add_line(blk, 'c_to_ri2/1', 'Mult/2');

%Mult1
reuse_block(blk, 'Mult1', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', tostring(mult_latency), ...
    'Position', [275 188 320 232]);
add_line(blk, 'c_to_ri3/2', 'Mult1/1');
add_line(blk, 'c_to_ri2/1', 'Mult1/2');

%Mult2
reuse_block(blk, 'Mult2', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', tostring(mult_latency), ...
    'Position', [275 248 320 292]);
add_line(blk, 'c_to_ri3/2', 'Mult2/1');
add_line(blk, 'c_to_ri2/2', 'Mult2/2');

%Mult3
reuse_block(blk, 'Mult3', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', tostring(mult_latency), ...
    'Position', [275 308 320 352]);
add_line(blk, 'c_to_ri3/1', 'Mult3/1');
add_line(blk, 'c_to_ri2/2', 'Mult3/2');

%overflow logic
reuse_block(blk, 'Logical', 'xbsIndex_r4/Logical', ...
    'logical_function', 'OR', ...
    'Position', [575 393 620 422]);
reuse_block(blk, 'of', 'built-in/outport', 'Port', '6', 'Position', [670 405 710 419]);
add_line(blk, 'Logical/1','of/1');

%adders
reuse_block(blk, 'AddSub', 'xbsIndex_r4/AddSub', 'latency', tostring(add_latency), ...
    'mode', 'Subtraction','use_behavioral_HDL', 'on', ...
    'Position', [410 138 455 182]);
reuse_block(blk, 'AddSub1', 'xbsIndex_r4/AddSub', 'latency', tostring(add_latency), ...
    'mode', 'Addition','use_behavioral_HDL', 'on', ...
    'Position', [410 298 455 342]);

%output ports
reuse_block(blk, 'bw_re', 'built-in/outport', 'Port', '3', 'Position', [670 153 710 167]);
reuse_block(blk, 'bw_im', 'built-in/outport', 'Port', '4', 'Position', [670 313 710 327]);

%architecture specific logic
if( strcmp(arch,'Virtex2Pro') ),

    %add convert blocks to reduce logic in adders
    reuse_block(blk, 'convert_of', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+2), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', tostring(conv_latency), 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [340 135 380 165]);
    add_line(blk, 'Mult/1', 'convert_of/1');

    reuse_block(blk, 'convert_of1', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+2), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', tostring(conv_latency), 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [340 195 380 225]);
    add_line(blk, 'Mult1/1', 'convert_of1/1');

    reuse_block(blk, 'convert_of2', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+2), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', tostring(conv_latency), 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [340 255 380 285]);
    add_line(blk, 'Mult2/1', 'convert_of2/1');

    reuse_block(blk, 'convert_of3', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+2), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', tostring(conv_latency), 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [340 315 380 345]);
    add_line(blk, 'Mult3/1', 'convert_of3/1');

    %join convert blocks to adders
    add_line(blk, 'convert_of/1', 'AddSub/1');
    add_line(blk, 'convert_of2/1', 'AddSub/2');
    add_line(blk, 'convert_of1/1', 'AddSub1/1');
    add_line(blk, 'convert_of3/1', 'AddSub1/2');

    %join adders to ouputs
    add_line(blk, 'AddSub/1', 'bw_re/1');
    add_line(blk, 'AddSub1/1', 'bw_im/1');

    %join overflows
    set_param([blk,'/Logical'], 'inputs', '4', 'latency', 'add_latency');
    add_line(blk, 'convert_of/2', 'Logical/1');
    add_line(blk, 'convert_of1/2', 'Logical/2');
    add_line(blk, 'convert_of2/2', 'Logical/3');
    add_line(blk, 'convert_of3/2', 'Logical/4');

elseif( strcmp(arch,'Virtex5') )
    %add convert blocks to after adders to ensure adders absorbed into multipliers
    add_line(blk, 'Mult/1', 'AddSub/1');
    add_line(blk, 'Mult1/1', 'AddSub1/1');
    add_line(blk, 'Mult2/1', 'AddSub/2');
    add_line(blk, 'Mult3/1', 'AddSub1/2');

    reuse_block(blk, 'convert_of', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width+1), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+3), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', tostring(conv_latency), 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [485 145 525 175]);
    add_line(blk, 'AddSub/1', 'convert_of/1');
    add_line(blk, 'convert_of/1', 'bw_re/1');

    reuse_block(blk, 'convert_of1', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width+1), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+3), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', tostring(conv_latency), 'quantization', tostring(quantization), ...
        'overflow', tostring(overflow), ...
        'Position', [485 305 525 335]);
    add_line(blk, 'AddSub1/1', 'convert_of1/1');
    add_line(blk, 'convert_of1/1', 'bw_im/1');

    %join overflows
    set_param([blk,'/Logical'], 'inputs', '2', 'latency', '0');
    add_line(blk, 'convert_of/2', 'Logical/1');
    add_line(blk, 'convert_of1/2', 'Logical/2');
else
    return;
end

clean_blocks(blk);

fmtstr = sprintf('arch=%s,\n input_bit_width=%d,\n coeff_bit_width=%d', arch, input_bit_width, coeff_bit_width);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
