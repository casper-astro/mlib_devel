% forty_gbe_callback
%
% mask callback function

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

function forty_gbe_callback()

clog('entering forty_gbe_callback', 'trace');

blk = gcb;

% masktype = get_param(blk, 'MaskType');

check_mask_type(blk, 'forty_gbe');

%search for sysgen block and get target
xps_xsg_blks = find_system(bdroot, 'SearchDepth', 1, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'xps:xsg');
if length(xps_xsg_blks) ~= 1
  errordlg('forty_gbe requires a single MSSGE (XSG core config) block to be instantiated at the top level');
  return;
end

% get the target board for the design
hw_sys = get_param(xps_xsg_blks(1), 'hw_sys');
% flavour = get_param(blk, 'flavour');
show_param = get_param(blk, 'show_param');
mask_names = get_param(blk, 'MaskNames');
mask_visibilities = get_param(blk, 'MaskVisibilities');

%turn everything off by default

for p = 1:length(mask_visibilities)
  mask_visibilities{p} = 'off';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
% these are visible always
%%%%%%%%%%%%%%%%%%%%%%%%%%

mask_visibilities{ismember(mask_names, 'rx_dist_ram')} = 'on';
mask_visibilities{ismember(mask_names, 'large_frames')} = 'on';
mask_visibilities{ismember(mask_names, 'show_param')} = 'on';
try
    mask_visibilities{ismember(mask_names, 'input_pipeline_delay')} = 'on';
catch e
end

% debug counter checkboxes
try
    mask_visibilities{ismember(mask_names, 'debug_ctr_width')} = 'on';
catch e
end
try
    mask_visibilities{ismember(mask_names, 'debug_dis_all')} = 'on';
    mask_visibilities{ismember(mask_names, 'debug_en_all')} = 'on';
catch e
end
mask_visibilities{ismember(mask_names, 'txctr')} = 'on';
mask_visibilities{ismember(mask_names, 'txerrctr')} = 'on';
mask_visibilities{ismember(mask_names, 'txofctr')} = 'on';
mask_visibilities{ismember(mask_names, 'txfullctr')} = 'on';
mask_visibilities{ismember(mask_names, 'txvldctr')} = 'on';
mask_visibilities{ismember(mask_names, 'txsnaplen')} = 'on';
mask_visibilities{ismember(mask_names, 'rxctr')} = 'on';
mask_visibilities{ismember(mask_names, 'rxerrctr')} = 'on';
mask_visibilities{ismember(mask_names, 'rxofctr')} = 'on';
mask_visibilities{ismember(mask_names, 'rxbadctr')} = 'on';
mask_visibilities{ismember(mask_names, 'rxvldctr')} = 'on';
mask_visibilities{ismember(mask_names, 'rxeofctr')} = 'on';
mask_visibilities{ismember(mask_names, 'rxsnaplen')} = 'on';
try
    mask_visibilities{ismember(mask_names, 'rxsrcip')} = 'on';
    mask_visibilities{ismember(mask_names, 'rxdstip')} = 'on';
catch e
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% these are visible if low level parameters enabled
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(show_param, 'on')
  % these are visible regardless of target hardware
  mask_visibilities{ismember(mask_names, 'fab_en')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_mac')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_ip')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_udp')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_gate')} = 'on';
  mask_visibilities{ismember(mask_names, 'cpu_rx_en')} = 'on';
  mask_visibilities{ismember(mask_names, 'cpu_tx_en')} = 'on';
  mask_visibilities{ismember(mask_names, 'ttl')} = 'on';
  mask_visibilities{ismember(mask_names, 'promisc_mode')} = 'on';
end

% enable and make visible relevant parameters
set_param(blk, 'MaskVisibilities', mask_visibilities);

clog('exiting forty_gbe_callback', 'trace');

% end
