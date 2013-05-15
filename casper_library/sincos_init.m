% Generate sine/cos.
%
% sincos_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:

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

function sincos_init(blk,varargin)

check_mask_type(blk, 'sincos');

defaults = {};
%if same_state(blk, 'defaults', defaults, varargin{:}), return, end
munge_block(blk, varargin{:});
func = get_var('func', 'defaults', defaults, varargin{:});
neg_sin = get_var('neg_sin', 'defaults', defaults, varargin{:});
neg_cos = get_var('neg_cos', 'defaults', defaults, varargin{:});
bit_width = get_var('bit_width', 'defaults', defaults, varargin{:});
symmetric = get_var('symmetric', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
depth_bits = get_var('depth_bits', 'defaults', defaults, varargin{:});
handle_sync = get_var('handle_sync', 'defaults', defaults, varargin{:});

delete_lines(blk);

%default case for storage in library
if depth_bits == 0,
  % When finished drawing blocks and lines, remove all unused blocks.
  clean_blocks(blk);
  save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values
  return;
end

base = 0;
%handle the sync
if strcmp(handle_sync, 'on'),
    reuse_block(blk, 'sync_in', 'built-in/inport', 'Port', '1', 'Position', [80 70 110 90]);
    reuse_block(blk, 'delay', 'xbsIndex_r4/Delay', ...
        'latency', 'bram_latency', ... 
        'Position', [190 70 230 90]);

    add_line(blk, 'sync_in/1', 'delay/1');
    reuse_block(blk, 'sync_out', 'built-in/outport', 'Port', '1', 'Position', [500 70 530 90]);
    add_line(blk, 'delay/1', 'sync_out/1');
    base = 1;
end

%input and output ports
reuse_block(blk, 'theta', 'built-in/inport', 'Port', num2str(base+1), 'Position', [80 130 110 150]);

%draw first lookup
if( strcmp(func, 'sine and cosine') || strcmp(func, 'sine') ),
    if strcmp(neg_sin, 'on') , sin_name = '-sine'; else sin_name = 'sine'; end
    reuse_block(blk, sin_name, 'built-in/outport', 'Port', num2str(base+1), 'Position', [500 130 530 150]);
end
if( strcmp(func, 'sine and cosine') || strcmp(func, 'cosine')),
    if strcmp(neg_cos, 'on') , cos_name = '-cos'; else cos_name = 'cos'; end
    if strcmp(func, 'sine and cosine') pos = '3'; end
    reuse_block(blk, cos_name, 'built-in/outport', 'Port', num2str(base+2), 'Position', [500 190 530 210]);
end

%lookup for sine/cos
s = '';
if( strcmp(func, 'sine') || strcmp(func, 'sine and cosine') ),
    if strcmp(neg_sin, 'on') , s = '-'; end    
    init_vec = sprintf('%ssin(2*pi*(0:(%s))/(%s))',s,'2^depth_bits-1','2^depth_bits');   
else 
    if( strcmp(neg_cos, 'on') ), s = '-'; end
    init_vec = sprintf('%scos(2*pi*(0:(%s))/(%s))',s,'2^depth_bits-1','2^depth_bits');   
end

bin_pt = 'bit_width-1';
if(strcmp(symmetric, 'on')), bin_pt = 'bit_width-2'; end
reuse_block(blk, 'rom0', 'xbsIndex_r4/ROM', ...
    'depth', '2^depth_bits', 'initVector', init_vec, ...
    'latency', 'bram_latency', 'n_bits', 'bit_width', ...
    'bin_pt', bin_pt, ...
    'Position', [180 120 240 160]);

add_line(blk, 'theta/1', 'rom0/1'); 

if strcmp(func, 'sine and cosine') || strcmp(func, 'sine'), dest = sin_name;
else dest = cos_name;
end

add_line(blk, 'rom0/1', [dest,'/1']);

%have 2 outputs
if strcmp(func, 'sine and cosine'),
    s = '';
    if( strcmp(neg_cos, 'on') ), s = '-'; end
    init_vec = sprintf('%scos(2*pi*(0:(%s))/(%s))',s,'2^depth_bits-1','2^depth_bits');   

    reuse_block(blk, 'rom1', 'xbsIndex_r4/ROM', ...
        'depth', '2^depth_bits', 'initVector', init_vec, ...
        'latency', 'bram_latency', 'n_bits', 'bit_width', ...
        'bin_pt', bin_pt, ...
        'Position', [180 180 240 220]);
    
    add_line(blk, 'theta/1', 'rom1/1'); 
    dest = cos_name;
    add_line(blk, 'rom1/1', [dest,'/1']);
end

% When finished drawing blocks and lines, remove all unused blocks.
clean_blocks(blk);

% Set attribute format string (block annotation)
annotation=sprintf('');
set_param(blk,'AttributesFormatString',annotation);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values


