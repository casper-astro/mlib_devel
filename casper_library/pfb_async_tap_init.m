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

function pfb_async_tap_init(blk, varargin)
% Initialize and configure the taps of the asynchronous Polyphase Filter Bank.
%
% pfb_async_tap_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% pfb_bits = The size of the PFB
% coeff_bits = Bitwidth of coefficients.
% total_taps = Total number of taps in the PFB
% data_in_bits = Input bitwidth
% mult_latency = Latency through each multiplier
% bram_latency = Latency through each BRAM.
% simul_bits = The number of parallel inputs
% fwidth = Scaling of the width of each PFB channel
% async = Enable the block to take a valid signal

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'tap_async');
munge_block(blk, varargin{:});

total_taps = get_var('total_taps', 'defaults', defaults, varargin{:});
this_tap = get_var('this_tap', 'defaults', defaults, varargin{:});
use_hdl = get_var('use_hdl','defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded','defaults', defaults, varargin{:});
%async = get_var('async','defaults', defaults, varargin{:});
debug_mode = get_var('debug_mode','defaults', defaults, varargin{:});

if (this_tap == 0) || (this_tap >= total_taps),
    error('Tap number must be >0 and <= %d\n', total_taps)
end

eblk = find_system(blk, 'lookUnderMasks', 'all', 'FollowLinks','on', 'SearchDepth', 1, 'Name', 'taps_in');
if this_tap > 1,
    if isempty(eblk),
        % delete line from ri_to_c to port
        delete_line(blk, 'tapout_delay/1', 'taps_out/1');
        % the in port
        reuse_block(blk, 'taps_in', 'built-in/inport', ...
            'Position', [35 247 65 263], 'Port', '5');
        % concat block
        reuse_block(blk, 'tapcat', 'xbsIndex_r4/Concat', ...
            'Position', [985  217 1005 268], 'num_inputs', '2');
        % move the out port
        reuse_block(blk, 'taps_out', 'built-in/outport', ...
            'Position', [1075 238 1105 252], 'Port', '5');
        % line from port to concat
        add_line(blk, 'taps_in/1', 'tapcat/2');
        % line from ri_to_c to concat
        add_line(blk, 'tapout_delay/1', 'tapcat/1');
        % line from concat to taps outport
        add_line(blk, 'tapcat/1', 'taps_out/1');
    end
else
    if ~isempty(eblk),
        delete_line(blk, 'taps_in/1', 'tapcat/2');
        delete_line(blk, 'tapout_delay/1', 'tapcat/1');
        delete_line(blk, 'tapcat/1', 'taps_out/1');
        reuse_block(blk, 'taps_out', 'built-in/outport', ...
            'Position', [865 198 895 212], 'Port', '5');
        add_line(blk, 'tapout_delay/1', 'taps_out/1');
    end
end

if strcmp(debug_mode, 'on'),
    set_param([blk,'/split_data'],  'outputWidth', 'data_in_bits', 'outputBinaryPt', '0', 'outputArithmeticType', '0');
    set_param([blk,'/interpret_coeff'],  'arith_type', 'Unsigned', 'bin_pt', '0');
else
    set_param([blk,'/split_data'],  'outputWidth', 'data_in_bits', 'outputBinaryPt', 'data_in_bits - 1', 'outputArithmeticType', '1');
    set_param([blk,'/interpret_coeff'],  'arith_type', 'Signed  (2''s comp)', 'bin_pt', 'coeff_bits - 1');
end

set_param([blk,'/Mult'],'use_embedded', use_embedded);
set_param([blk,'/Mult'],'use_behavioral_HDL', use_hdl);
set_param([blk,'/Mult1'],'use_embedded', use_embedded);
set_param([blk,'/Mult1'],'use_behavioral_HDL', use_hdl)

clean_blocks(blk);

fmtstr = sprintf('tap(%d/%d)', this_tap, total_taps);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});

