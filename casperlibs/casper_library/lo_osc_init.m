%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
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

function lo_osc_init(blk,varargin)

defaults = {};
check_mask_type(blk, 'lo_osc');
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
munge_block(blk, varargin{:});

counter_width = get_var('counter_width','defaults', defaults, varargin{:});
counter_start = get_var('counter_start','defaults', defaults, varargin{:});
counter_step = get_var('counter_step','defaults', defaults, varargin{:});
n_bits = get_var('n_bits','defaults', defaults, varargin{:});
latency = get_var('latency','defaults', defaults, varargin{:});

%forces counter to be larger than 3 bits so
%that RAM has more than 2 bit address to prevent 
%error
if(counter_width < 3),
    count = counter_width+2;
    set_param([blk,'/counter'],'n_bits','counter_width+2');
    set_param([blk,'/counter'],'start_count','counter_start*4');
    set_param([blk,'/counter'],'cnt_by_val','counter_step*4');
else
    count = counter_width;
    set_param([blk,'/counter'],'start_count','counter_start');
    set_param([blk,'/counter'],'cnt_by_val','counter_step');
    set_param([blk,'/counter'],'n_bits','counter_width');
end

set_param([blk,'/sincos'], ...
    'func', 'sine and cosine', 'neg_sin', 'on', ...
    'neg_cos', 'off', 'symmetric', 'off', ...
    'handle_sync', 'off', 'depth_bits', tostring(count), ...
    'bit_width', tostring(n_bits), ...
    'bram_latency', tostring(latency));

save_state(blk, 'defaults', defaults, varargin{:});

