function delay_tree_init(blk, varargin)
% Initialize and configure a delay_tree block.
%
% delay_tree_init(blk, varargin)
%
% blk = the block to configure
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% fanout = Number of outputs.
% bfac = Branching factor of tree.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://casper.berkeley.edu                                                %
%   Copyright (C) 2010 William Mallard                                        %
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

% Set default vararg values.
defaults = { ...
    'fanout', 4, ...
    'bfac', 2, ...
};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'delay_tree');
munge_block(blk, varargin{:});

% Retrieve values from mask fields.
fanout = get_var('fanout', 'defaults', defaults, varargin{:});
bfac = get_var('bfac', 'defaults', defaults, varargin{:});

% Validate input fields.

if (fanout < 1),
    errordlg('Invalid fanout. Should be greater than zero.');
    return
end

if (bfac < 2),
    errordlg('Invalid branching factor. Should be greater than one.');
    return
end

if (bfac > fanout),
    errordlg('Branching factor cannot exceed fanout.');
    return
end

% Calculate number of columns.

if (bfac == 2),
    num_cols = nextpow2(fanout);
else
    num_cols = ceil(log2(fanout)/log2(bfac));
end

%%%%%%%%%%%%%%%
% Draw blocks %
%%%%%%%%%%%%%%%

% Delete all wires.
delete_lines(blk);

ypos = 50*.5*bfac^num_cols;
reuse_block(blk, 'in', 'built-in/inport', ...
    'Position', [15 ypos 45 ypos+14], ...
    'ShowName', 'on', ...
    'Port', '1');

for col = 1:num_cols+1,
    spacing = bfac^(num_cols+1-col);
    for row = 1:bfac^(col-1),
        name = ['delay_c', num2str(col), '_r', num2str(row)];
        xpos = col*100;
        ypos = (row-.5)*spacing*50;
        reuse_block(blk, name, 'xbsIndex_r4/Delay', ...
            'Position', [xpos ypos xpos+50 ypos+14], ...
            'ShowName', 'off', ...
            'latency', '1', ...
            'reg_retiming', 'off');
    end
end

xpos = 100*(num_cols+2);
for row = 1:bfac^num_cols,
    if (row <= fanout),
        ypos = 22+50*(row-1);
        reuse_block(blk, ['out', num2str(row)], 'built-in/outport', ...
            'Position', [xpos ypos xpos+30 ypos+15], ...
            'ShowName', 'on', ...
            'Port', num2str(row));
    else
        ypos = 22+50*(row-1);
        reuse_block(blk, ['term', num2str(row)], 'built-in/terminator', ...
            'Position', [xpos ypos xpos+20 ypos+20], ...
            'ShowName', 'off');
    end
end

%%%%%%%%%%%%%%
% Draw wires %
%%%%%%%%%%%%%%

add_line(blk, 'in/1', 'delay_c1_r1/1');

for col = 1:num_cols,
    for row = 1:bfac^(col-1),
        src = ['delay_c', num2str(col), '_r', num2str(row), '/1'];
        for group = 1:bfac,
            dst_id = 1+(row-1)*bfac+(group-1);
            dst = ['delay_c', num2str(col+1), '_r', num2str(dst_id), '/1'];
            add_line(blk, src, dst);
        end
    end
end

for row = 1:bfac^num_cols,
    src = ['delay_c', num2str(num_cols+1), '_r', num2str(row), '/1'];
    if (row <= fanout),
        dst = ['out', num2str(row), '/1'];
    else
        dst = ['term', num2str(row), '/1'];
    end
    add_line(blk, src, dst);
end

% Delete all unconnected blocks.
clean_blocks(blk);

%%%%%%%%%%%%%%%%%%
% Finish drawing %
%%%%%%%%%%%%%%%%%%

% Resize this block.
position = get_param(blk, 'Position');
xstart = position(1);
xend = xstart + 50;
ystart = position(2);
yend = ystart + 15*fanout;
position = [xstart, ystart, xend, yend];
set_param(blk, 'Position', position)

% Set block annotation.
fmtstr = sprintf('delay=%d', num_cols+1);
set_param(blk, 'AttributesFormatString', fmtstr);

% Save block state to stop repeated init script runs.
save_state(blk, 'defaults', defaults, varargin{:});

