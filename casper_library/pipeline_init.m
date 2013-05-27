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
function pipeline_init(blk, varargin)
% Initialize and configure the pipeline block.
%
% pipeline_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% latency = number of cycles N to delay (z^-N)

% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

check_mask_type(blk, 'pipeline');
munge_block(blk, varargin{:});

latency = get_var('latency', 'defaults', defaults, varargin{:});

delete_lines(blk);

if (latency < 0)
    error('pipeline_init.m: Latency setting must be greater than or equal to 0');
    return;
end

% Add ports
reuse_block(blk, 'd', 'built-in/inport',  'Position', [15 48 45 62], 'Port', '1');
reuse_block(blk, 'q', 'built-in/outport', 'Position', [latency*100+115 48 latency*100+145 62], 'Port', '1');

% Add register blocks
for z = 0:latency-1
    reuse_block(blk, ['Register',num2str(z)], 'xbsIndex_r4/Register', ...
        'en', 'off', ...
        'Position', [100*z+115 27 100*z+175 83]);
end

% Connect blocks
if (latency == 0)
    add_line(blk, 'd/1', 'q/1');
else
    for z = 1:latency-1
        add_line(blk, ['Register', num2str(z-1), '/1'], ['Register', num2str(z), '/1']);
    end

    add_line(blk, 'd/1', 'Register0/1');
    add_line(blk, ['Register', num2str(latency-1), '/1'], 'q/1');
end

clean_blocks(blk);

save_state(blk, 'defaults', defaults, varargin{:});
