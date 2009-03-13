% twiddle_general_3mult_init(blk, varargin)
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

function twiddle_general_3mult_init(blk, varargin)

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'twiddle_general_3mult');
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

if( strcmp(arch,'Virtex2Pro') ),
%    disp('targeting V2Pro');
elseif( strcmp(arch,'Virtex5') ),
%    disp('targeting V5');
else, 
    error('twiddle_general_3mult_init.m: Unknown target architecture')
end

delete_lines(blk);

%a input signal path
reuse_block(blk, 'a', 'built-in/inport', 'Port', '1', 'Position',[225 28 255 42]);
reuse_block(blk, 'Delay', 'xbsIndex_r4/Delay', ...
    'latency',tostring(mult_latency + 2*add_latency + bram_latency), ...
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
reuse_block(blk, 'sync', 'built-in/inport', 'Port', '3', 'Position',[40 463 70 477]);
reuse_block(blk, 'Delay2', 'xbsIndex_r4/Delay', ...
    'latency',tostring(mult_latency + 2*add_latency + bram_latency), ...
    'Position', [280 450 320 490]);
add_line(blk, 'sync/1', 'Delay2/1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Port', '5', 'Position', [340 463 370 477]);
add_line(blk, 'Delay2/1', 'sync_out/1');

%coefficient generator
reuse_block(blk, 'coeff_gen', 'casper_library/FFTs/Twiddle/coeff_gen/coeff_gen', ...
    'Coeffs', tostring(Coeffs),  ...
    'StepPeriod', tostring(StepPeriod), 'coeff_bit_width', tostring(coeff_bit_width), ...
    'bram_latency', tostring(bram_latency), 'coeffs_bram', coeffs_bram, ...
    'Position', [100 319 145 361]); 
add_line(blk, 'sync/1', 'coeff_gen/1');

reuse_block(blk, 'c_to_ri2', 'casper_library/Misc/c_to_ri', ...
    'n_bits', tostring(coeff_bit_width), 'bin_pt', tostring(coeff_bit_width-1), ...
    'Position', [180 319 220 361]);
add_line(blk, 'coeff_gen/1', 'c_to_ri2/1');
reuse_block(blk, 'AddSub2', 'xbsIndex_r4/AddSub', 'latency', tostring(add_latency), ...
    'use_behavioral_HDL', 'on', ...
    'mode', 'Addition', 'Position', [255 318 300 362]);
add_line(blk, 'c_to_ri2/1', 'AddSub2/1');
add_line(blk, 'c_to_ri2/2', 'AddSub2/2');
reuse_block(blk, 'AddSub3', 'xbsIndex_r4/AddSub', 'latency', tostring(add_latency), ...
    'use_behavioral_HDL', 'on', ...
    'mode', 'Subtraction', 'Position', [255 388 300 432]);
add_line(blk, 'c_to_ri2/2', 'AddSub3/1');
add_line(blk, 'c_to_ri2/1', 'AddSub3/2');
reuse_block(blk, 'Delay5', 'xbsIndex_r4/Delay', 'latency', tostring(add_latency), ...
    'Position', [260 255 300 295]);
add_line(blk, 'c_to_ri2/1', 'Delay5/1');
reuse_block(blk, 'Convert1', 'xbsIndex_r4/Convert', 'n_bits', 'coeff_bit_width', ...
    'bin_pt', 'coeff_bit_width-2', 'Position', [315 325 355 355]);
add_line(blk, 'AddSub2/1', 'Convert1/1');
reuse_block(blk, 'Convert2', 'xbsIndex_r4/Convert', 'n_bits', 'coeff_bit_width', ...
    'bin_pt', 'coeff_bit_width-2', 'Position', [320 395 360 425]);
add_line(blk, 'AddSub3/1', 'Convert2/1');

%b input signal path
reuse_block(blk, 'b', 'built-in/inport', 'Port', '2', 'Position',[50 98 80 112]);
reuse_block(blk, 'Delay1', 'xbsIndex_r4/Delay', 'latency', tostring(bram_latency), ...
    'Position', [105 85 145 125]);
add_line(blk, 'b/1', 'Delay1/1');
reuse_block(blk, 'c_to_ri3', 'casper_library/Misc/c_to_ri', ...
    'n_bits', tostring(input_bit_width), 'bin_pt', tostring(input_bit_width-1), ...
    'Position', [175 84 215 126]);
add_line(blk,'Delay1/1', 'c_to_ri3/1');
reuse_block(blk, 'AddSub1', 'xbsIndex_r4/AddSub', 'latency', tostring(add_latency), ...
    'use_behavioral_HDL', 'on', ...
    'mode', 'Addition', 'Position', [255 83 300 127]);
add_line(blk,'c_to_ri3/1', 'AddSub1/1');
add_line(blk,'c_to_ri3/2', 'AddSub1/2');
reuse_block(blk, 'Delay3', 'xbsIndex_r4/Delay', 'latency', tostring(add_latency), ...
    'Position', [260 145 300 185]);
add_line(blk, 'c_to_ri3/1','Delay3/1');
reuse_block(blk, 'Delay4', 'xbsIndex_r4/Delay', 'latency', tostring(add_latency), ...
    'Position', [260 200 300 240]);
add_line(blk, 'c_to_ri3/2','Delay4/1');
reuse_block(blk, 'Convert', 'xbsIndex_r4/Convert', 'n_bits', 'input_bit_width', ...
    'bin_pt', 'input_bit_width-2', 'Position', [320 90 360 120]);
add_line(blk, 'AddSub1/1', 'Convert/1');

%Mult
reuse_block(blk, 'Mult', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', tostring(mult_latency), ...
    'Position', [380 93 425 137]);
add_line(blk, 'Convert/1', 'Mult/1');
add_line(blk, 'Delay5/1', 'Mult/2');

%Mult1
reuse_block(blk, 'Mult1', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', tostring(mult_latency), ...
    'Position', [380 308 425 352]);
add_line(blk, 'Delay4/1', 'Mult1/1');
add_line(blk, 'Convert1/1', 'Mult1/2');

%Mult2
reuse_block(blk, 'Mult2', 'xbsIndex_r4/Mult', ...
    'use_embedded', use_embedded, 'use_behavioral_HDL', use_hdl, ...
    'latency', tostring(mult_latency), ...
    'Position', [380 378 425 422]);
add_line(blk, 'Delay3/1', 'Mult2/1');
add_line(blk, 'Convert2/1', 'Mult2/2');

%post mult adders
reuse_block(blk, 'AddSub', 'xbsIndex_r4/AddSub', 'latency', tostring(add_latency), ...
    'use_behavioral_HDL', 'on', ...
    'mode', 'Subtraction', 'Position', [525 103 570 147]);
reuse_block(blk, 'AddSub4', 'xbsIndex_r4/AddSub', 'latency', tostring(add_latency), ...
    'use_behavioral_HDL', 'on', ...
    'mode', 'Addition', 'Position', [525 303 570 347]);

%overflow logic
reuse_block(blk, 'Logical', 'xbsIndex_r4/Logical', ...
    'logical_function', 'OR', ...
    'Position', [675 393 720 422]);
reuse_block(blk, 'of', 'built-in/outport', 'Port', '6', 'Position', [740 405 780 419]);
add_line(blk, 'Logical/1','of/1'); 

reuse_block(blk, 'bw_re', 'built-in/outport', 'Port', '3', 'Position', [740 118 780 132]);
reuse_block(blk, 'bw_im', 'built-in/outport', 'Port', '4', 'Position', [740 318 780 332]);

%architecture specific logic
if( strcmp(arch,'Virtex2Pro') ),
    
    %add convert blocks to reduce logic in adders
    reuse_block(blk, 'convert_of', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width), ...
        'binary_point_i', tostring(input_bit_width-2+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+3), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', '0', 'quantization', 'Truncate', 'overflow', 'Wrap', ...
        'Position', [445 100 485 130]);
    add_line(blk, 'Mult/1', 'convert_of/1');

    reuse_block(blk, 'convert_of1', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-2), ...
        'bit_width_o', tostring(input_bit_width+3), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', '0', 'quantization', 'Truncate', 'overflow', 'Wrap', ...
        'Position', [445 315 485 345]);
    add_line(blk, 'Mult1/1', 'convert_of1/1');

    reuse_block(blk, 'convert_of2', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width), ...
        'binary_point_i', tostring(input_bit_width-1+coeff_bit_width-2), ...
        'bit_width_o', tostring(input_bit_width+3), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', '0', 'quantization', 'Truncate', 'overflow', 'Wrap', ...
        'Position', [445 385 485 415]);
    add_line(blk, 'Mult2/1', 'convert_of2/1');

    %join convert blocks to adders
    add_line(blk, 'convert_of/1', 'AddSub/1');
    add_line(blk, 'convert_of1/1', 'AddSub/2');
    add_line(blk, 'convert_of/1', 'AddSub4/1');
    add_line(blk, 'convert_of2/1', 'AddSub4/2');

    %join adders to ouputs
    add_line(blk, 'AddSub/1', 'bw_re/1');
    add_line(blk, 'AddSub4/1', 'bw_im/1');

    %join overflows
    set_param([blk,'/Logical'], 'inputs', '3', 'latency', 'add_latency');
    add_line(blk, 'convert_of/2', 'Logical/1');
    add_line(blk, 'convert_of1/2', 'Logical/2');
    add_line(blk, 'convert_of2/2', 'Logical/3');

elseif( strcmp(arch,'Virtex5') )
    %add convert blocks to after adders to ensure adders absorbed into multipliers
    add_line(blk, 'Mult/1', 'AddSub/1');
    add_line(blk, 'Mult1/1', 'AddSub/2');
    add_line(blk, 'Mult/1', 'AddSub4/1');
    add_line(blk, 'Mult2/1', 'AddSub4/2');

    reuse_block(blk, 'convert_of', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width+1), ...
        'binary_point_i', tostring(input_bit_width-2+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+4), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', '0', 'quantization', 'Truncate', 'overflow', 'Wrap', ...
        'Position', [600 105 650 140]);
    add_line(blk, 'AddSub/1', 'convert_of/1');
    add_line(blk, 'convert_of/1', 'bw_re/1');

    reuse_block(blk, 'convert_of1', 'casper_library/Misc/convert_of', ...
        'bit_width_i', tostring(input_bit_width+coeff_bit_width+1), ...
        'binary_point_i', tostring(input_bit_width-2+coeff_bit_width-1), ...
        'bit_width_o', tostring(input_bit_width+4), ...
        'binary_point_o', tostring(input_bit_width), ...
        'latency', '0', 'quantization', 'Truncate', 'overflow', 'Wrap', ...
        'Position', [600 305 650 340]);
    add_line(blk, 'AddSub4/1', 'convert_of1/1');
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
