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

function last_tap_real_init(blk, varargin)
% Initialize and configure the last tap of the Polyphase Filter Bank.
%
% last_tap_real_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% TotalTaps = Total number of taps in the PFB
% BitWidthIn = Input Bitwidth
% CoeffBitWidth = Bitwidth of Coefficients.
% mult_latency = Latency through each multiplier

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'last_tap_real');
munge_block(blk, varargin{:});

use_hdl = get_var('use_hdl','defaults', defaults, varargin{:});
use_embedded = get_var('use_embedded','defaults', defaults, varargin{:});

set_param([blk,'/Mult'],'use_embedded',use_embedded);
set_param([blk,'/Mult'],'use_behavioral_HDL',use_hdl);

save_state(blk, 'defaults', defaults, varargin{:});

