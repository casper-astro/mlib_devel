% Create a 'bus' of similar signals
%
% bus_create_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% inputNum = Number of inputs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Meerkat radio telescope project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) Paul Prozesky 2011                                          %
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

% Create a 'bus' of similar signals.

function bus_create_init(blk, varargin)

clog('entering bus_create_init','trace');

check_mask_type(blk, 'bus_create');

defaults = {'inputNum', 2};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

% check the params
inputNum = get_var('inputNum', 'defaults', defaults, varargin{:});
if (isnan(inputNum) || (~isnumeric(inputNum))),
    errordlg('Number of inputs must be natural number'); error('Number of inputs must be natural number'); end;

munge_block(blk, varargin{:});

% delete all the lines
delete_lines(blk);

% add the inputs, outputs and gateway out blocks, drawing lines between them
xSize = 100;
ySize = 20;
xStart = 100;
xPos = xStart + (xSize * 2);
yPos = 100;

% one output for the bus
reuse_block(blk, 'bus_out', 'built-in/outport', ...
    'Position', [xStart + (xSize * 3 * 2), yPos + (ySize * (inputNum - 0.5)), xStart + (xSize * 3 * 2) + (xSize/2), yPos + (ySize * (inputNum + 0.5))]);
concatSize = ySize * inputNum;

if inputNum > 1,
  reuse_block(blk, 'concatenate', 'xbsIndex_r4/Concat', ...
      'Position', [xStart + (xSize * 2 * 2), yPos, xStart + (xSize * 2 * 2) + (xSize/2), yPos + (2 * ySize * inputNum) - ySize], ...
      'num_inputs', num2str(inputNum));
  add_line(blk, ['concatenate', '/1'], ['bus_out', '/1'], 'autorouting', 'on');
end

% draw the inputs and convert blocks
for p = 1 : inputNum,
    xPos = xStart;
    % the output block
    inName = sprintf('in%i', p);
    reuse_block(blk, inName, 'built-in/inport', 'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize]);
    xPos = xPos + (xSize * 2);
    % the cast block
    reinterpretName = sprintf('reinterpret%i', p);
    reuse_block(blk, reinterpretName, 'xbsIndex_r4/Reinterpret', ...
        'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], ...
        'force_arith_type', 'on', 'arith_type', 'Unsigned', ...
        'force_bin_pt', 'on', 'bin_pt', '0');
    yPos = yPos + (ySize * 2);
    % connect up the blocks
    add_line(blk, [inName, '/1'], [reinterpretName, '/1'], 'autorouting', 'on');
    if inputNum > 1,
      add_line(blk, [reinterpretName, '/1'], ['concatenate', '/', num2str(p)], 'autorouting', 'on');
    else
      add_line(blk, [reinterpretName, '/1'], 'bus_out/1', 'autorouting', 'on');
    end
end;

% remove unconnected blocks
clean_blocks(blk);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting bus_create_init','trace');
