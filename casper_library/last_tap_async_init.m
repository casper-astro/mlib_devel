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

function last_tap_async_init(blk, varargin)
% Initialize and configure the last tap of the Polyphase Filter Bank.
%
% last_tap_async_init(blk, varargin)
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
% mult_latency = Latency through each multiplier
% quantization = 'Truncate', 'Round  (unbiased: +/- Inf)', or 'Round (unbiased: Even Values)'
% async - Asynchronous mode

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'last_tap_async');
munge_block(blk, varargin{:});

propagate_vars([blk,'/pfb_add_tree_async'], 'defaults', defaults, varargin{:});

use_hdl = get_var('use_hdl','defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded','defaults', defaults, varargin{:});
total_taps = get_var('total_taps', 'defaults', defaults, varargin{:});
debug_mode = get_var('debug_mode', 'defaults', defaults, varargin{:});
input_num = get_var('input_num', 'defaults', defaults, varargin{:});

if strcmp(debug_mode, 'on'),
    set_param([blk,'/split_data'],  'outputWidth', 'data_in_bits', 'outputBinaryPt', '0', 'outputArithmeticType', '0');
    set_param([blk,'/interpret_coeff'],  'arith_type', 'Unsigned', 'bin_pt', '0');
else
    set_param([blk,'/split_data'],  'outputWidth', 'data_in_bits', 'outputBinaryPt', 'data_in_bits - 1', 'outputArithmeticType', '1');
    set_param([blk,'/interpret_coeff'],  'arith_type', 'Signed  (2''s comp)', 'bin_pt', 'coeff_bits - 1');
end

set_param([blk,'/Mult'],  'use_embedded', use_embedded);
set_param([blk,'/Mult'],  'use_behavioral_HDL', use_hdl);
set_param([blk,'/Mult1'], 'use_embedded', use_embedded);
set_param([blk,'/Mult1'], 'use_behavioral_HDL', use_hdl);

fmtstr = sprintf('input(%d), tap(%d,%d)', input_num, total_taps, total_taps);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
