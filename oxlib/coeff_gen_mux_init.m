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

function coeff_gen_init(blk, varargin)

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'coeff_gen_mux');
munge_block(blk, varargin{:});

Coeffs = get_var('Coeffs', 'defaults', defaults, varargin{:});
StepPeriod = get_var('StepPeriod', 'defaults', defaults, varargin{:});
coeff_bit_width = get_var('coeff_bit_width', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
coeffs_bram = get_var('coeffs_bram', 'defaults', defaults, varargin{:});
mux_factor = get_var('mux_factor', 'defaults', defaults, varargin{:});

delete_lines(blk);

reuse_block(blk, 'rst', 'built-in/inport', 'Port', '1', ...
    'Position', [25 48 55 62]);

reuse_block(blk, 'ri_to_c', 'casper_library/Misc/ri_to_c', ...
    'Position', [295 54 335 96]);
reuse_block(blk, 'w', 'built-in/outport', 'Port', '1', ...
    'Position', [390 68 420 82]);
add_line(blk, 'ri_to_c/1', 'w/1');

%static coefficients
if length(Coeffs) == 1,
    %terminator
    reuse_block(blk, 'Terminator', 'built-in/Terminator', 'Position', [75 45 95 65]);
    add_line(blk, 'rst/1', 'Terminator/1');

    %constant blocks
    real_coeff = round(real(Coeffs(1)) * 2^(coeff_bit_width-1)) / 2^(coeff_bit_width-1);
    imag_coeff = round(imag(Coeffs(1)) * 2^(coeff_bit_width-1)) / 2^(coeff_bit_width-1);
    reuse_block(blk, 'Constant', 'xbsIndex_r4/Constant', ...
        'arith_type', tostring('Signed (2''s comp)'), ...
        'const', tostring(real_coeff), 'n_bits', tostring(coeff_bit_width), ...
        'explicit_period', 'on', 'period', '1', ...
        'bin_pt', tostring(coeff_bit_width-1), 'Position', [185 34 255 66]);         
    add_line(blk, 'Constant/1', 'ri_to_c/1');
    reuse_block(blk, 'Constant1', 'xbsIndex_r4/Constant', ...
        'arith_type', tostring('Signed (2''s comp)'), ...
        'const', tostring(imag_coeff), 'n_bits', tostring(coeff_bit_width), ...
        'explicit_period', 'on', 'period', '1', ...
        'bin_pt', tostring(coeff_bit_width-1), 'Position', [185 84 255 116]);         
    add_line(blk, 'Constant1/1', 'ri_to_c/2');
else,
    vlen = length(Coeffs);
    %counter
    reuse_block(blk, 'Counter', 'xbsIndex_r4/Counter', ...
        'cnt_type', 'Free Running', 'start_count', '0', 'cnt_by_val', '1', ...
        'arith_type', 'Unsigned', 'n_bits', tostring( log2(vlen)+StepPeriod+mux_factor ), ...
        'bin_pt', '0', 'rst', 'on', 'Position', [75 29 125 81]);
    add_line(blk, 'rst/1', 'Counter/1');
    %slice
    reuse_block(blk, 'Slice', 'xbsIndex_r4/Slice', ...
        'nbits', tostring(log2(vlen)), ...
        'mode', 'Upper Bit Location + Width', ...
        'bit1', '0', 'base1', 'MSB of Input', ...
        'Position', [145 41 190 69]);
    add_line(blk, 'Counter/1', 'Slice/1');
    %ROMs
    if( strcmp(coeffs_bram, 'on')),
        mem = 'Block RAM';
    else
        mem = 'Distributed memory';
    end
    real_coeffs = round( real(Coeffs) * 2^(coeff_bit_width-1) ) / 2^(coeff_bit_width-1);
    imag_coeffs = round( imag(Coeffs) * 2^(coeff_bit_width-1)  ) / 2^(coeff_bit_width-1);
    reuse_block(blk, 'ROM', 'xbsIndex_r4/ROM', ...
        'depth', tostring(length(Coeffs)), 'initVector', tostring(real_coeffs), ...
        'distributed_mem', tostring(mem), 'latency', tostring(bram_latency), ...
        'arith_type', 'Signed  (2''s comp)', 'n_bits', tostring(coeff_bit_width), ...
        'bin_pt', tostring(coeff_bit_width-1), 'Position', [210 30 260 82]);
    add_line(blk, 'Slice/1', 'ROM/1');
    add_line(blk, 'ROM/1','ri_to_c/1');

    reuse_block(blk, 'ROM1', 'xbsIndex_r4/ROM', ...
        'depth', tostring(length(Coeffs)), 'initVector', tostring(imag_coeffs), ...
        'distributed_mem', tostring(mem), 'latency', tostring(bram_latency), ...
        'arith_type', 'Signed  (2''s comp)', 'n_bits', tostring(coeff_bit_width), ...
        'bin_pt', tostring(coeff_bit_width-1), 'Position', [210 95 260 147]);
    add_line(blk, 'Slice/1', 'ROM1/1');
    add_line(blk, 'ROM1/1','ri_to_c/2');

end

clean_blocks(blk);

fmtstr = sprintf('coeff_bit_width=%d', coeff_bit_width);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
