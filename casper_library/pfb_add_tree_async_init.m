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

function pfb_add_tree_async_init(blk, varargin)
% Initialize and configure the Polyphase Filter Bank final summing tree.
%
% pfb_add_tree_async_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% total_taps = Total number of taps in the PFB
% data_in_bits = Input Bitwidth
% data_out_bits = Output Bitwidth
% coeff_bits = Bitwidth of Coefficients.
% add_latency = Latency through each adder.
% quantization = 'Truncate', 'Round  (unbiased: +/- Inf)', or 'Round
% (unbiased: Even Values)'

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'pfb_add_tree_async');
munge_block(blk, varargin{:});

input_num = get_var('input_num', 'defaults', defaults, varargin{:});
total_taps = get_var('total_taps', 'defaults', defaults, varargin{:});
data_in_bits = get_var('data_in_bits', 'defaults', defaults, varargin{:});
coeff_bits = get_var('coeff_bits', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
debug_mode = get_var('debug_mode', 'defaults', defaults, varargin{:});

delete_lines(blk);

% ports
reuse_block(blk, 'din', 'built-in/inport', 'Position', [15 123 45 137], 'Port', '1');
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 28 45 42], 'Port', '2');
reuse_block(blk, 'dout', 'built-in/outport', 'Position', [600 25*total_taps+100 630 25*total_taps+115], 'Port', '1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [600 28 630 42], 'Port', '2');

% dv path
reuse_block(blk, 'dv', 'built-in/inport', 'Position', [30   668    60   682], 'Port', '3');
reuse_block(blk, 'dv_out', 'built-in/outport', 'Position', [875   668   905   682], 'Port', '3');
add_stages = ceil(log2(total_taps));
dv_latency = (add_latency * add_stages) + 1;
reuse_block(blk, 'delay_dv', 'xbsIndex_r4/Delay', ...
    'latency', num2str(dv_latency), ...
    'Position', [450   660   480   690]);
add_line(blk, 'dv/1', 'delay_dv/1');
add_line(blk, 'delay_dv/1', 'dv_out/1');

% static blocks
reuse_block(blk, 'adder_tree1', 'casper_library_misc/adder_tree', ...
    'n_inputs', num2str(total_taps), 'latency', 'add_latency', ...
    'Position', [200 114 350 50*total_taps+114]);
reuse_block(blk, 'adder_tree2', 'casper_library_misc/adder_tree', ...
    'n_inputs', num2str(total_taps), 'latency', 'add_latency', ...
    'Position', [200 164+50*total_taps 350 164+100*total_taps]);
for ctr = 1:2,
    if strcmp(debug_mode, 'on'),
        ttype = 'Unsigned';
        tbinpt = '0';
    else
        ttype = 'Signed  (2''s comp)';
        tbinpt = 'data_out_bits-1';
    end
    reuse_block(blk, ['convert', num2str(ctr)], 'xbsIndex_r4/Convert', ...
        'arith_type', ttype, 'n_bits', 'data_out_bits', ...
        'bin_pt', tbinpt, 'quantization', quantization, ...
        'overflow', 'Saturate', 'latency', 'add_latency', 'pipeline', 'on',...
        'Position', [500 25*total_taps+114+(40*(ctr-1)) 530 25*total_taps+128+(40*(ctr-1))]);
end

% delay to compensate for latency of convert blocks
reuse_block(blk, 'delay_convert', 'xbsIndex_r4/Delay', ...
    'latency', 'add_latency', ...
    'Position', [400 50+25*total_taps 430 80+25*total_taps]);

% Scale Blocks are required before casting to n_(n-1) format
% Input to adder tree seemes to be n_(n-2) format
% each level in the adder tree requires one more shift
% so with just two taps, there is one level in the adder tree
% so we would have, eg, 17_14 format, so we need to shift by 2 to get
% 17_16 which can be converted to 18_17 without overflow.
% There are nextpow2(total_taps) levels in the adder tree.
scale_factor = 1 + add_stages;
reuse_block(blk, 'scale1', 'xbsIndex_r4/Scale', ...
    'scale_factor', num2str(-scale_factor), ...
    'Position', [400 25*total_taps+114 430 25*total_taps+128]);
reuse_block(blk, 'scale2', 'xbsIndex_r4/Scale', ...
    'scale_factor', num2str(-scale_factor), ...
    'Position', [400 158+25*total_taps 430 172+25*total_taps]);

% lines
%add_line(blk, 'adder_tree1/2', 'convert1/1');
%add_line(blk, 'adder_tree2/2', 'convert2/1');
add_line(blk, 'adder_tree1/2', 'scale1/1');
add_line(blk, 'scale1/1', 'convert1/1');
add_line(blk, 'adder_tree2/2', 'scale2/1');
add_line(blk, 'scale2/1', 'convert2/1');
reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', ...
    'Position', [550 114+25*total_taps 580 144+25*total_taps]);
add_line(blk, 'convert1/1', 'ri_to_c/1');
add_line(blk, 'convert2/1', 'ri_to_c/2');
add_line(blk, 'ri_to_c/1', 'dout/1');
add_line(blk, 'sync/1', 'adder_tree1/1');
add_line(blk, 'sync/1', 'adder_tree2/1');
%add_line(blk, 'adder_tree1/1', 'sync_out/1');
add_line(blk, 'adder_tree1/1', 'delay_convert/1');
add_line(blk, 'delay_convert/1', 'sync_out/1');

for p=0:total_taps-1,
    for q=1:2,
        slice_name = ['Slice', num2str(p),'_',num2str(q)];
        reuse_block(blk, slice_name, 'xbsIndex_r4/Slice', ...
            'mode', 'Upper Bit Location + Width', 'nbits', 'coeff_bits + data_in_bits', ...
            'base0', 'MSB of Input', 'base1', 'MSB of Input', ...
            'bit1', num2str(-(2*p+q-1)*(coeff_bits + data_in_bits)), 'Position', [70 50*p+25*q+116 115 50*p+25*q+128]);
        add_line(blk, 'din/1', [slice_name, '/1']);
        reint_name = ['Reint',num2str(p),'_',num2str(q)];
        if strcmp(debug_mode, 'on'),
            reuse_block(blk, reint_name, 'xbsIndex_r4/Reinterpret', ...
                'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
                'force_bin_pt', 'on', 'bin_pt', '0', ...
                'Position', [130 50*p+25*q+116 160 50*p+25*q+128]);
        else
            reuse_block(blk, reint_name, 'xbsIndex_r4/Reinterpret', ...
                'force_arith_type', 'on', 'arith_type', 'Signed  (2''s comp)', ...
                'force_bin_pt', 'on', 'bin_pt', 'coeff_bits + data_in_bits - 2', ...
                'Position', [130 50*p+25*q+116 160 50*p+25*q+128]);
        end
        add_line(blk, [slice_name, '/1'], [reint_name, '/1']);
        add_line(blk, [reint_name, '/1'], ['adder_tree',num2str(q),'/',num2str(p+2)]);
    end
end

% output data to the matlab workspace in debug mode
if strcmp(debug_mode, 'on'),
    reuse_block(blk, 'wrkspc', 'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', 'outputNum', 'total_taps * 2', ...
        'outputWidth', 'coeff_bits + data_in_bits', 'outputBinaryPt', '0', ...
        'outputArithmeticType', '0', 'outputToWorkspace', 'on', ...
        'variablePrefix', ['lasttap', num2str(input_num)], 'outputToModelAsWell', 'off', ...
        'Position', [200    19   250    66]);
    add_line(blk, 'din/1', 'wrkspc/1');
end

clean_blocks(blk);

fmtstr = sprintf('input(%d), taps(%d), add_lat(%d)', input_num, total_taps, add_latency);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
