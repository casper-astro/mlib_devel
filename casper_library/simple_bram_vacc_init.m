%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C)2010 Billy Mallard                                           %
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

function simple_bram_vacc_init(blk, varargin)
% Initialize and configure a simple_bram_vacc block.
%
% simple_bram_vacc_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs.
%
% Valid varnames for this block are:
% vec_len = 
% arith_type = 
% n_bits = 
% bin_pt = 

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'simple_bram_vacc');
munge_block(blk, varargin{:});

vec_len = get_var('vec_len', 'defaults', defaults, varargin{:});
arith_type = get_var('arith_type', 'defaults', defaults, varargin{:});
n_bits = get_var('n_bits', 'defaults', defaults, varargin{:});
bin_pt = get_var('bin_pt', 'defaults', defaults, varargin{:});

% Validate input fields.

if vec_len < 6
	errordlg('simple_bram_vacc: Invalid vector length. Must be greater than 5.')
end

if n_bits < 1
	errordlg('simple_bram_vacc: Invalid bit width. Must be greater than 0.')
end

if bin_pt > n_bits
	errordlg('simple_bram_vacc: Invalid binary point. Cannot be greater than the bit width.')
end

% Adjust sub-block parameters.

set_param([blk, '/Constant'], 'arith_type', arith_type)
set_param([blk, '/Adder'], 'arith_type', arith_type)

save_state(blk, 'defaults', defaults, varargin{:});

