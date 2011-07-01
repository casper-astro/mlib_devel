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

function snapshot_callback()

clog('entering bus_expand_callback', 'trace');

blk = gcb;

check_mask_type(blk, 'snapshot');

storage = get_param(blk, 'storage');

mask_names = get_param(blk, 'MaskNames');
mask_enables = get_param(blk, 'MaskEnables');
mask_visibilities = get_param(blk, 'MaskVisibilities');

if strcmp(storage, 'bram'),
  mask_visibilities{ismember(mask_names, 'dram_dimm')} = 'off';
  mask_visibilities{ismember(mask_names, 'dram_clock')} = 'off';
  mask_enables{ismember(mask_names, 'data_width')} = 'on';
elseif strcmp(storage, 'dram'),
  mask_visibilities{ismember(mask_names, 'dram_dimm')} = 'on';
  mask_visibilities{ismember(mask_names, 'dram_clock')} = 'on';
  set_param(blk, 'data_width', '64');
  mask_enables{ismember(mask_names, 'data_width')} = 'off';
else,
end

set_param(gcb, 'MaskEnables', mask_enables);
set_param(gcb, 'MaskVisibilities', mask_visibilities);

clog('exiting bus_expand_callback', 'trace');

