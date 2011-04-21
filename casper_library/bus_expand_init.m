% Create a 'bus' of similar signals
%
% bus_expand_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% outputNum = Number of outputs to split bus into
% outputWidth = Total bit width of each output
% outputBinaryPt = Binary point of each output
% outputArithmeticType = Numerical type of each output
% outputToWorkspace = Optionally output each output to the Workspace
% variablePrefix = 
% outputToModeAsWell = 

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

% Sometimes it's nice to 'combine' a bunch of similar signals into one
% 'bus' using the bus_create or Xilinx concat blocks. But to split them up
% again is a pain in the butt. So this block just provides an easy way of
% doing that.

function bus_expand_init(blk, varargin)
%fprintf('start: bus_expand_advanced_init\n');

clog('entering bus_expand_init','trace');

check_mask_type(blk, 'bus_expand');

defaults = {'outputNum', 2, 'outputWidth', 8, ...
  'outputBinaryPt', 7, 'outputArithmeticType', 'Signed  (2''s comp)', ...
  'outputToWorkspace', 'off', 'variablePrefix', 'out', ...
  'outputToModelAsWell', 'off'};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

% check the params
outputNum = get_var('outputNum', 'defaults', defaults, varargin{:});
outputWidth = get_var('outputWidth', 'defaults', defaults, varargin{:});
outputBinaryPt = get_var('outputBinaryPt', 'defaults', defaults, varargin{:});
outputArithmeticType = get_var('outputArithmeticType', 'defaults', defaults, varargin{:});
outputToWorkspace = get_var('outputToWorkspace', 'defaults', defaults, varargin{:});
variablePrefix = get_var('variablePrefix', 'defaults', defaults, varargin{:});
outputToModelAsWell = get_var('outputToModelAsWell', 'defaults', defaults, varargin{:});

if ((outputNum <= 0) || isnan(outputNum) || (~isnumeric(outputNum))),
    errordlg('Need one or more outputs!'); error('Need one or more outputs!'); end;
if ((outputWidth <= 0) || isnan(outputWidth) || (~isnumeric(outputWidth))),
    errordlg('Need non-zero output width!'); error('Need non-zero output width!'); end;
if ((outputBinaryPt >= outputWidth) || isnan(outputBinaryPt) || (~isnumeric(outputBinaryPt))),
    errordlg('Binary point >= output width makes no sense!'); error('Binary point > output width makes no sense!'); end;
if strcmp(outputToWorkspace,'on') == 1,
    if (~isvarname(variablePrefix)),
        errordlg('That is not a valid variable name!'); error('That is not a valid variable name!'); end;
end

munge_block(blk, varargin{:});

% delete all the lines
delete_lines(blk);

% add the inputs, outputs and gateway out blocks, drawing lines between them
xSize = 100;
ySize = 20;
xStart = 100;
yPos = 100;

% one input for the bus
reuse_block(blk, 'bus_in', 'built-in/inport', 'Position', [xStart, yPos, xStart + (xSize/2), yPos + ySize]);

% draw the output chains
for p = 1 : outputNum,
    xPos = xStart + (xSize * 2);
    blockNum = outputNum + 1 - p;
    % the slice block
    sliceName = sprintf('slice%i', blockNum);
    reuse_block(blk, sliceName, 'xbsIndex_r4/Slice', ...
        'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], ...
        'nbits', num2str(outputWidth), ...
        'bit1', num2str(-1 * (p - 1) * outputWidth));
    xPos = xPos + (xSize * 2);
    % the reinterpret block
    reinterpretName = sprintf('reinterpret%i', blockNum);
    reuse_block(blk, reinterpretName, 'xbsIndex_r4/Reinterpret', ...
        'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], ...
        'force_arith_type', 'on', 'arith_type', outputArithmeticType, ...
        'force_bin_pt', 'on', 'bin_pt', num2str(outputBinaryPt));
    xPos = xPos + (xSize * 2);
    add_line(blk, ['bus_in', '/1'], [sliceName, '/1'], 'autorouting', 'on');
    add_line(blk, [sliceName, '/1'], [reinterpretName, '/1'], 'autorouting', 'on');
    % to workspace?
    if strcmp(outputToWorkspace,'on') == 1,
        % the gateway out block
        gatewayOutName = sprintf('gatewayOut%i', blockNum);
        reuse_block(blk, gatewayOutName, 'xbsIndex_r4/Gateway Out', ...
            'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], 'hdl_port', 'no');
        xPos = xPos + (xSize * 2);
        % the to-workspace block
        toWorkspaceName = sprintf('toWorkspace%i', blockNum);
        toWorkspaceVariableName = sprintf('%s_%i', variablePrefix, blockNum);
        reuse_block(blk, toWorkspaceName, 'built-in/To Workspace', ...
            'Position', [xPos, yPos, xPos + (xSize * 2), yPos + ySize], ...
            'VariableName', toWorkspaceVariableName, 'MaxDataPoints', 'inf',...
            'Decimation', '1','SampleTime', '-1','SaveFormat', 'Structure With Time', 'FixptAsFi', 'yes');
        add_line(blk, [reinterpretName, '/1'], [gatewayOutName, '/1'], 'autorouting', 'on');
        add_line(blk, [gatewayOutName, '/1'], [toWorkspaceName, '/1'], 'autorouting', 'on');
        yPos = yPos + (ySize * 2);
    end
    if ((strcmp(outputToWorkspace,'on') == 1) && (strcmp(outputToModelAsWell,'on') == 1)) || (strcmp(outputToWorkspace,'off') == 1),
        % the output block
        outName = sprintf('out%i', blockNum);
        if (blockNum == 1), outName = sprintf('lsb_%s', outName); end
        if (blockNum == outputNum), outName = sprintf('msb_%s', outName); end
        reuse_block(blk, outName, 'built-in/outport', 'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], 'Port', num2str(p));
        add_line(blk, [reinterpretName, '/1'], [outName, '/1'], 'autorouting', 'on');
        yPos = yPos + (ySize * 2);
    end
end;

% remove unconnected blocks
clean_blocks(blk);

% update format string so we know what's going on with this block
if strcmp(outputArithmeticType, 'Unsigned'), atStr = 'uf'; else atStr = 'f'; end
displayString = sprintf('%d outputs, %s%d.%d', outputNum, atStr, outputWidth, outputBinaryPt);
if strcmp(outputToWorkspace,'on') == 1,
    displayString = sprintf('%s, %s_?', displayString, variablePrefix);
end
set_param(blk, 'AttributesFormatString', displayString);

save_state(blk, 'defaults', defaults, varargin{:});  % Save and back-populate mask parameter values

clog('exiting bus_expand_init','trace');
