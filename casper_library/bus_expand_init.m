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

clog('entering bus_expand_init','trace');

check_mask_type(blk, 'bus_expand');
munge_block(blk, varargin{:});

defaults = {'mode', 'divisions of equal size', 'outputNum', 2, 'outputWidth', 8, ...
  'outputBinaryPt', 7, 'outputArithmeticType', 1, ...
  'outputToWorkspace', 'off', 'variablePrefix', 'out', ...
  'outputToModelAsWell', 'off'};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

% check the params
mode = get_var('mode', 'defaults', defaults, varargin{:});
outputNum = get_var('outputNum', 'defaults', defaults, varargin{:});
outputWidth = get_var('outputWidth', 'defaults', defaults, varargin{:});
outputBinaryPt = get_var('outputBinaryPt', 'defaults', defaults, varargin{:});
outputArithmeticType = get_var('outputArithmeticType', 'defaults', defaults, varargin{:});
outputToWorkspace = get_var('outputToWorkspace', 'defaults', defaults, varargin{:});
variablePrefix = get_var('variablePrefix', 'defaults', defaults, varargin{:});
outputToModelAsWell = get_var('outputToModelAsWell', 'defaults', defaults, varargin{:});
show_format = get_var('show_format', 'defaults', defaults, varargin{:});

if (strcmp(mode, 'divisions of arbitrary size') == 1 && ... 
  (length(outputWidth) ~= length(outputBinaryPt) || length(outputWidth) ~= length(outputArithmeticType))) ,
  errordlg('Division width, binary point and arithmetic type vectors must be the same length when using arbitrary divisions');
  error('Division width, binary point and arithmetic type vectors must be the same length when using arbitrary divisions');
end

if strcmp(mode, 'divisions of arbitrary size'),
  outputNum = length(outputWidth); 
else
  if ((outputNum <= 0) || isnan(outputNum) || (~isnumeric(outputNum))),
    errordlg('Need one or more outputs!'); error('Need one or more outputs!');
  end
end

if strcmp(mode, 'divisions of equal size'), vals = 1;
else vals = outputNum;
end
for div = 1:vals,
  if ((outputWidth(div) <= 0) || isnan(outputWidth(div)) || (~isnumeric(outputWidth(div)))),
    errordlg('Need non-zero output width!'); error('Need non-zero output width!'); end;
  if ((outputBinaryPt(div) > outputWidth(div)) || isnan(outputBinaryPt(div)) || (~isnumeric(outputBinaryPt(div)))),
    errordlg('Binary point > output width makes no sense!'); error('Binary point > output width makes no sense!'); end;
  if (((outputArithmeticType(div) > 2) || outputArithmeticType(div) < 0) || isnan(outputArithmeticType(div)) || (~isnumeric(outputArithmeticType(div)))),
    errordlg('Arithmetic type must be one of 0,1,2!'); error('Arithmetic type must be one of 0,1,2!'); end;
  if (outputArithmeticType(div) == 2 && (outputWidth(div) ~= 1 || outputBinaryPt(div) ~= 0)),
    errordlg('Division width must be 1 and binary point 0 for Boolean Arithmetic type');
    error('Division width must be 1 and binary point 0 for Boolean Arithmetic type');
  end 

end

if strcmp(outputToWorkspace,'on') == 1,
  if (~isvarname(variablePrefix)),
    errordlg('That is not a valid variable name!'); error('That is not a valid variable name!'); end;
end

munge_block(blk, varargin{:});

% delete all the lines
delete_lines(blk);

% add the inputs, outputs and gateway out blocks, drawing lines between them
xSize = 100; ySize = 20; xStart = 100; yPos = 100;

% one input for the bus
reuse_block(blk, 'bus_in', 'built-in/inport', 'Position', [xStart, yPos, xStart + (xSize/2), yPos + ySize]);

acc_bits = 0;
config_string = '';

% draw the output chains
for p = 1 : outputNum,
    if strcmp(mode, 'divisions of equal size'),
        index = 1;
    else
        index = p;
    end

    boolean = 'off';
    width = outputWidth(index);
    bin_pt = outputBinaryPt(index);
    switch outputArithmeticType(index),
        case 1 
            arithmeticType = 'Signed  (2''s comp)';
            config_string = [config_string, sprintf('f%i.%i,', width, bin_pt)];
        case 2
            boolean = 'on';
            config_string = [config_string, 'b,'];
        otherwise 
            arithmeticType = 'Unsigned';
            config_string = [config_string, sprintf('uf%i.%i,', width, bin_pt)];
    end

    xPos = xStart + (xSize * 2);
    blockNum = outputNum + 1 - p;
    % the slice block
    sliceName = sprintf('slice%i', blockNum);
  
    reuse_block(blk, sliceName, 'xbsIndex_r4/Slice', ...
        'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], ...
        'boolean_output', boolean, 'nbits', num2str(width), ...
        'bit1', num2str(-1 * acc_bits));
    xPos = xPos + (xSize * 2);
    add_line(blk, ['bus_in', '/1'], [sliceName, '/1']);
  
    if outputArithmeticType(index) ~= 2,
        % the reinterpret block if not boolean
        reinterpretName = sprintf('reinterpret%i', blockNum);
        reuse_block(blk, reinterpretName, 'xbsIndex_r4/Reinterpret', ...
            'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], ...
            'force_arith_type', 'on', 'arith_type', arithmeticType, ...
            'force_bin_pt', 'on', 'bin_pt', num2str(bin_pt));
        add_line(blk, [sliceName, '/1'], [reinterpretName, '/1']);
    end
    xPos = xPos + (xSize * 2);

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
        if outputArithmeticType(index) ~= 2, % not boolean
            add_line(blk, [reinterpretName, '/1'], [gatewayOutName, '/1']);
        else
            add_line(blk, [sliceName, '/1'], [gatewayOutName, '/1']);
        end
        add_line(blk, [gatewayOutName, '/1'], [toWorkspaceName, '/1'], 'autorouting', 'on');
        yPos = yPos + (ySize * 2);
    end
    if ((strcmp(outputToWorkspace,'on') == 1) && (strcmp(outputToModelAsWell,'on') == 1)) || (strcmp(outputToWorkspace,'off') == 1),
        % the output block
        outName = sprintf('out%i', blockNum);
        if (blockNum == 1),
            outName = sprintf('lsb_%s', outName);
        end
        if (blockNum == outputNum),
            outName = sprintf('msb_%s', outName);
        end
        reuse_block(blk, outName, 'built-in/outport', 'Position', [xPos, yPos, xPos + (xSize/2), yPos + ySize], 'Port', num2str(p));
        if outputArithmeticType(index) ~= 2, % not boolean
            add_line(blk, [reinterpretName, '/1'], [outName, '/1']);
        else
            add_line(blk, [sliceName, '/1'], [outName, '/1']);
        end  
        yPos = yPos + (ySize * 2);
    end

    acc_bits = acc_bits + width;
end;

% remove unconnected blocks
clean_blocks(blk);

% update format string so we know what's going on with this block
if strcmp(show_format, 'on')
    displayString = sprintf('%d outputs: %s', outputNum, config_string);
else
    displayString = sprintf('%d outputs', outputNum);
end
if strcmp(outputToWorkspace,'on') == 1,
    displayString = sprintf('%s, %s_?', displayString, variablePrefix);
end
set_param(blk, 'AttributesFormatString', displayString);

save_state(blk, 'defaults', defaults, varargin{:});  % save and back-populate mask parameter values

clog('exiting bus_expand_init','trace');
