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

n_bits = get_var('n_bits','defaults', defaults, varargin{:});
counter_width = get_var('counter_width','defaults', defaults, varargin{:});
counter_start = get_var('counter_start','defaults', defaults, varargin{:});
counter_step = get_var('counter_step','defaults', defaults, varargin{:});
latency = get_var('latency','defaults', defaults, varargin{:});

delete_lines(blk);

%default state in library
if n_bits == 0,
  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});  
  return; 
end

reuse_block(blk, 'sync', 'built-in/Inport', ...
        'Port', '1', ...
        'Position', [20 63 50 77]);

reuse_block(blk, 'counter', 'xbsIndex_r4/Counter', ...
        'rst', 'on', ...
        'use_rpm', 'off', ...
        'Position', [80 42 125 98]);

%forces counter to be larger than 3 bits so
%that RAM has more than 2 bit address to prevent error
if(counter_width < 3),
    count = 'counter_width+2';
    set_param([blk,'/counter'], 'n_bits', count, ...
      'start_count', 'counter_start*4', 'cnt_by_val', 'counter_step*4');
else
    count = 'counter_width';
    set_param([blk,'/counter'],'n_bits', count, ... 
      'start_count','counter_start', 'cnt_by_val', 'counter_step');
end

reuse_block(blk, 'sincos', 'casper_library_downconverter/sincos', ...
    'func', 'sine and cosine', 'neg_sin', 'on', ...
    'neg_cos', 'off', 'symmetric', 'off', ...
    'handle_sync', 'off', 'depth_bits', count, ...
    'bit_width', 'n_bits', 'bram_latency', 'latency', ...
    'Position', [150 42 200 98]);

reuse_block(blk, 'sin', 'built-in/Outport', ...
        'Port', '1', ...
        'Position', [235 48 265 62]);

reuse_block(blk, 'cos', 'built-in/Outport', ...
        'Port', '2', ...
        'Position', [235 78 265 92]);

add_line(blk,'sync/1','counter/1');
add_line(blk,'counter/1','sincos/1');
add_line(blk,'sincos/2','cos/1');
add_line(blk,'sincos/1','sin/1');

clean_blocks(blk);
save_state(blk, 'defaults', defaults, varargin{:});
