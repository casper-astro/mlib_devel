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

function bitsnap_callback()

clog('entering bitsnap_callback', 'trace');
blk = gcb;
check_mask_type(blk, 'bitsnap');

mask_names = get_param(blk, 'MaskNames');
mask_enables = get_param(blk, 'MaskEnables');
mask_visibilities = get_param(blk, 'MaskVisibilities');

storage = get_param(blk, 'snap_storage');
if strcmp(storage, 'bram'),
  mask_visibilities{ismember(mask_names, 'snap_dram_dimm')} = 'off';
  mask_visibilities{ismember(mask_names, 'snap_dram_clock')} = 'off';
  mask_enables{ismember(mask_names, 'snap_data_width')} = 'on';
elseif strcmp(storage, 'dram'),
  mask_visibilities{ismember(mask_names, 'snap_dram_dimm')} = 'on';
  mask_visibilities{ismember(mask_names, 'snap_dram_clock')} = 'on';
  set_param(blk, 'snap_data_width', '64');
  mask_enables{ismember(mask_names, 'snap_data_width')} = 'off';
end

if strcmp(get_param(blk,'snap_value'), 'on'),
    mask_enables{ismember(mask_names, 'extra_names')} = 'on';
    mask_enables{ismember(mask_names, 'extra_widths')} = 'on';
    mask_enables{ismember(mask_names, 'extra_bps')} = 'on';
    mask_enables{ismember(mask_names, 'extra_types')} = 'on';
else
    mask_enables{ismember(mask_names, 'extra_names')} = 'off';
    mask_enables{ismember(mask_names, 'extra_widths')} = 'off';
    mask_enables{ismember(mask_names, 'extra_bps')} = 'off';
    mask_enables{ismember(mask_names, 'extra_types')} = 'off';
end

set_param(gcb, 'MaskEnables', mask_enables);
set_param(gcb, 'MaskVisibilities', mask_visibilities);

clog('exiting bitsnap_callback', 'trace');

