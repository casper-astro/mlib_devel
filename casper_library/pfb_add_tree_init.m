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

function pfb_add_tree_init(blk, varargin)
% Initialize and configure the Polyphase Filter Bank final summing tree.
%
% pfb_add_tree_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% TotalTaps = Total number of taps in the PFB
% BitWidthIn = Input Bitwidth
% BitWidthOut = Output Bitwidth
% CoeffBitWidth = Bitwidth of Coefficients.
% add_latency = Latency through each adder.
% quantization = 'Truncate', 'Round  (unbiased: +/- Inf)', or 'Round
% (unbiased: Even Values)'

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'pfb_add_tree');
munge_block(blk, varargin{:});

TotalTaps = get_var('TotalTaps', 'defaults', defaults, varargin{:});
BitWidthIn = get_var('BitWidthIn', 'defaults', defaults, varargin{:});
BitWidthOut = get_var('BitWidthOut', 'defaults', defaults, varargin{:});
CoeffBitWidth = get_var('CoeffBitWidth', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});

delete_lines(blk);

% Add ports
reuse_block(blk, 'din', 'built-in/inport', 'Position', [15 123 45 137], 'Port', '1');
reuse_block(blk, 'sync', 'built-in/inport', 'Position', [15 28 45 42], 'Port', '2');
reuse_block(blk, 'dout', 'built-in/outport', 'Position', [600 25*TotalTaps+100 630 25*TotalTaps+115], 'Port', '1');
reuse_block(blk, 'sync_out', 'built-in/outport', 'Position', [600 28 630 42], 'Port', '2');

% Add Static Blocks
reuse_block(blk, 'adder_tree1', 'casper_library_misc/adder_tree', ...
    'n_inputs', num2str(TotalTaps), 'latency', num2str(add_latency), ...
    'Position', [200 114 350 50*TotalTaps+114]);
reuse_block(blk, 'adder_tree2', 'casper_library_misc/adder_tree', ...
    'n_inputs', num2str(TotalTaps), 'latency', num2str(add_latency), ...
    'Position', [200 164+50*TotalTaps 350 164+100*TotalTaps]);
reuse_block(blk, 'convert1', 'xbsIndex_r4/Convert', ...
    'arith_type', 'Signed  (2''s comp)', 'n_bits', num2str(BitWidthOut), ...
    'bin_pt', num2str(BitWidthOut-1), 'quantization', quantization, ...
    'overflow', 'Saturate', 'latency', num2str(add_latency), 'pipeline', 'on',...
    'Position', [500 25*TotalTaps+114 530 25*TotalTaps+128]);
reuse_block(blk, 'convert2', 'xbsIndex_r4/Convert', ...
    'arith_type', 'Signed  (2''s comp)', 'n_bits', num2str(BitWidthOut), ...
    'bin_pt', num2str(BitWidthOut-1), 'quantization', quantization, ...
    'overflow', 'Saturate', 'latency', num2str(add_latency), ...
    'Position', [500 158+25*TotalTaps 530 172+25*TotalTaps]);

    % Delay to compensate for latency of convert blocks
reuse_block(blk, 'delay1', 'xbsIndex_r4/Delay', ...
    'latency', num2str(add_latency), ...
    'Position', [400 50+25*TotalTaps 430 80+25*TotalTaps]);

    % Scale Blocks are required before casting to n_(n-1) format
    % Input to adder tree seemes to be n_(n-2) format
    % each level in the adder tree requires one more shift
    % so with just two taps, there is one level in the adder tree
    % so we would have, eg, 17_14 format, so we need to shift by 2 to get
    % 17_16 which can be converted to 18_17 without overflow.
    % There are nextpow2(TotalTaps) levels in the adder tree.
scale_factor = 1 + nextpow2(TotalTaps);
reuse_block(blk, 'scale1', 'xbsIndex_r4/Scale', ...
    'scale_factor', num2str(-scale_factor), ...
    'Position', [400 25*TotalTaps+114 430 25*TotalTaps+128]);
reuse_block(blk, 'scale2', 'xbsIndex_r4/Scale', ...
    'scale_factor', num2str(-scale_factor), ...
    'Position', [400 158+25*TotalTaps 430 172+25*TotalTaps]);

% Add lines
%add_line(blk, 'adder_tree1/2', 'convert1/1');
%add_line(blk, 'adder_tree2/2', 'convert2/1');
add_line(blk, 'adder_tree1/2', 'scale1/1');
add_line(blk, 'scale1/1', 'convert1/1');
add_line(blk, 'adder_tree2/2', 'scale2/1');
add_line(blk, 'scale2/1', 'convert2/1');
reuse_block(blk, 'ri_to_c', 'casper_library_misc/ri_to_c', ...
    'Position', [550 114+25*TotalTaps 580 144+25*TotalTaps]);
add_line(blk, 'convert1/1', 'ri_to_c/1');
add_line(blk, 'convert2/1', 'ri_to_c/2');
add_line(blk, 'ri_to_c/1', 'dout/1');
add_line(blk, 'sync/1', 'adder_tree1/1');
add_line(blk, 'sync/1', 'adder_tree2/1');
%add_line(blk, 'adder_tree1/1', 'sync_out/1');
add_line(blk, 'adder_tree1/1', 'delay1/1');
add_line(blk, 'delay1/1', 'sync_out/1');

for p=0:TotalTaps-1,
    for q=1:2,
        slice_name = ['Slice', num2str(p),'_',num2str(q)];
        reuse_block(blk, slice_name, 'xbsIndex_r4/Slice', ...
            'mode', 'Upper Bit Location + Width', 'nbits', num2str(CoeffBitWidth + BitWidthIn), ...
            'base0', 'MSB of Input', 'base1', 'MSB of Input', ...
            'bit1', num2str(-(2*p+q-1)*(CoeffBitWidth + BitWidthIn)), 'Position', [70 50*p+25*q+116 115 50*p+25*q+128]);
        add_line(blk, 'din/1', [slice_name, '/1']);
        reint_name = ['Reint',num2str(p),'_',num2str(q)];
        reuse_block(blk, reint_name, 'xbsIndex_r4/Reinterpret', ...
            'force_arith_type', 'on', 'arith_type', 'Signed  (2''s comp)', ...
            'force_bin_pt', 'on', 'bin_pt', num2str(CoeffBitWidth + BitWidthIn - 2), ...
            'Position', [130 50*p+25*q+116 160 50*p+25*q+128]);
        add_line(blk, [slice_name, '/1'], [reint_name, '/1']);
        add_line(blk, [reint_name, '/1'], ['adder_tree',num2str(q),'/',num2str(p+2)]);
    end
end

clean_blocks(blk);

fmtstr = sprintf('taps=%d, add_latency=%d', TotalTaps, add_latency);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
