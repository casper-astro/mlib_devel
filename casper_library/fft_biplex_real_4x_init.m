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

function fft_biplex_real_4x_init(blk, varargin)
% Initialize and configure the 4x real FFT biplex.
%
% fft_biplex_real_4x_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% FFTSize = Size of the FFT (2^FFTSize points). 
% BitWidth = Bitwidth of input data. 
% quantization = Quantization behavior.
% overflow = Overflow behavior.
% add_latency = The latency of adders in the system.
% mult_latency = The latency of multipliers in the system.
% bram_latency = The latency of BRAM in the system.

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'fft_biplex_real_4x');
munge_block(blk, varargin{:});

FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
BitWidth = get_var('BitWidth', 'defaults', defaults, varargin{:});
quantization = get_var('quantization', 'defaults', defaults, varargin{:});
overflow = get_var('overflow', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

BRAMSize = 18432;
DelayBramThresh = 1/4;  % Use bram when delays will fill this fraction of a BRAM

biplex_core = [gcb,'/biplex_core'];
propagate_vars(biplex_core, 'defaults', defaults, varargin{:});
propagate_vars([gcb,'/bi_real_unscr_4x'], 'defaults', defaults, varargin{:});

% Implement delays normally or in BRAM
if (2^(FFTSize-1) * 2*BitWidth >= DelayBramThresh*BRAMSize),
    delay_bram = 'on';
else,
    delay_bram = 'off';
end

delays = {'delay0', 'delay1'};
for i=1:length(delays),
    full_path = [blk,'/bi_real_unscr_4x/',delays{i}];
    if 2^(FFTSize-1) > 16,
        replace_block([blk,'/bi_real_unscr_4x'],'Name',delays{i},'casper_library/Delays/delay_bram','noprompt');
        set_param(full_path,'LinkStatus','inactive');
        set_param(full_path, 'DelayLen', '2^(FFTSize-1)');
        set_param(full_path, 'bram_latency', 'bram_latency');
    else,
        replace_block([blk,'/bi_real_unscr_4x'],'Name',delays{i},'casper_library/Delays/delay_slr','noprompt');
        set_param(full_path,'LinkStatus','inactive');
        set_param(full_path, 'DelayLen', '2^(FFTSize-1)');
    end
end

clean_blocks(blk);

fmtstr = sprintf('FFTSize=%d, BitWidth=%d', FFTSize, BitWidth);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
