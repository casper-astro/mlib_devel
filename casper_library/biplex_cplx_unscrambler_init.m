function biplex_cplx_unscrambler_init(blk, varargin)

% Configure the biplex_cplx_unscrambler block.
% 
% biplex_cplx_unscrambler_init(blk, varargin)
% 
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames:
% * FFTSize = Size of the FFT (2^FFTSize points).
% * n_bits = Data bitwidth.
% * add_latency = Latency of adders blocks.
% * conv_latency = Latency of cast blocks.
% * bram_latency = Latency of BRAM blocks.
% * bram_map = Store map in BRAM.
% * dsp48_adders = Use DSP48s for adders.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Collaboration for Astronomy Signal Processing and Electronics Research    %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2012 Andrew Martens                                         %
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

defaults = {'FFTSize', 2, 'bram_latency', 2};

% Skip init script if mask state has not changed.
if same_state(blk, 'defaults', defaults, varargin{:}),
  return
end

% Verify that this is the right mask for the block.
check_mask_type(blk, 'biplex_cplx_unscrambler');

% Disable link if state changes from default.
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
FFTSize = get_var('FFTSize', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});

map = bit_reverse(0:2^(FFTSize-1)-1, FFTSize-1);
set_param([blk,'/reorder'],'map',mat2str([map,map+2^(FFTSize-1)]));
set_param([blk,'/reorder'],'bram_latency', num2str(bram_latency));
set_param([blk,'/reorder1'],'map',mat2str([map+2^(FFTSize-1),map]));
set_param([blk,'/reorder1'],'bram_latency', num2str(bram_latency));

save_state(blk, 'defaults', defaults, varargin{:});
