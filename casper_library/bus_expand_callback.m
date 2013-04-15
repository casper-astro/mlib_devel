%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Meerkat radio telescope project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) Andrew Martens 2011                                         %
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

function bus_expand_callback()

clog('entering bus_expand_callback', 'trace');

blk = gcb;

check_mask_type(blk, 'bus_expand');

outputToWorkspace = get_param(blk, 'outputToWorkspace');
mode = get_param(blk, 'mode');
outputWidth = str2num(get_param(blk, 'outputWidth'));

mask_names = get_param(blk, 'MaskNames');
mask_enables = get_param(blk, 'MaskEnables');

if strcmp(mode, 'divisions of arbitrary size'),
  en = 'off';
  set_param(blk, 'outputNum', num2str(length(outputWidth)));
else
  en = 'on';
end

mask_enables{ismember(mask_names, 'outputNum')} = en;
mask_enables{ismember(mask_names, 'variablePrefix')} = outputToWorkspace;
mask_enables{ismember(mask_names, 'outputToModelAsWell')} = outputToWorkspace;
set_param(gcb, 'MaskEnables', mask_enables);

temp = get_param(blk, 'MaskPrompts');
if strcmp(en, 'off'),
    temp(3) = {'Output width [msb ... lsb]:'};
    temp(4) = {'Output binary point position [msb ... lsb]:'};
    temp(5) = {'Output arithmetic type (ufix=0, fix=1, bool=2) [msb ... lsb]:'};
else
    temp(3) = {'Output width:'};
    temp(4) = {'Output binary point position:'};
    temp(5) = {'Output arithmetic type (ufix=0, fix=1, bool=2):'};
end
set_param(blk, 'MaskPrompts', temp);
    
clog('exiting bus_expand_callback', 'trace');
