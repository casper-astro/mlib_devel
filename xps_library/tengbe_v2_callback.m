% ten_gbe_v2_callback
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

function ten_gbe_v2_callback()

clog('entering ten_gbe_v2_callback', 'trace');

blk = gcb;

check_mask_type(blk, 'ten_GbE_v2');

%search for sysgen block and get target
xps_xsg_blks    = find_system(bdroot,'SearchDepth',1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');

if length(xps_xsg_blks) ~= 1,
  errordlg('ten_Gbe_v2 requires a single MSSGE (XSG core config) block to be instantiated at the top level');
  return;
end

%get the target board for the design
hw_sys = get_param(xps_xsg_blks(1),'hw_sys');
flavour = get_param(blk,'flavour');
show_param = get_param(blk, 'show_param');
mask_names = get_param(blk, 'MaskNames');
mask_visibilities = get_param(blk, 'MaskVisibilities');

%turn everything off by default

for p = 1:length(mask_visibilities), 
  mask_visibilities{p} = 'off';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%
%these are visible always
%%%%%%%%%%%%%%%%%%%%%%%%%%

mask_visibilities{ismember(mask_names, 'rx_dist_ram')} = 'on';
mask_visibilities{ismember(mask_names, 'large_frames')} = 'on';
mask_visibilities{ismember(mask_names, 'show_param')} = 'on';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%these are visible always depending on architecture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(hw_sys,'ROACH2:sx475t'),
  mask_visibilities{ismember(mask_names, 'flavour')} = 'on';
  mask_visibilities{ismember(mask_names, 'slot')} = 'on';

  if strcmp(flavour,'cx4'), %CX4 mezzanine card for ROACH2 has only 3 (external) ports
    mask_visibilities{ismember(mask_names, 'port_r2_cx4')} = 'on';
  elseif strcmp(flavour, 'sfp+'), %SFP+ mezzanine card 4 external ports 
    mask_visibilities{ismember(mask_names, 'port_r2_sfpp')} = 'on';
  end
else
  mask_visibilities{ismember(mask_names, 'port_r1')} = 'on';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%these are visible if low level parameters enabled
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strcmp(show_param, 'on'),
  %these are visible regardless of target hardware
  mask_visibilities{ismember(mask_names, 'fab_en')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_mac')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_ip')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_udp')} = 'on';
  mask_visibilities{ismember(mask_names, 'fab_gate')} = 'on';
  mask_visibilities{ismember(mask_names, 'cpu_rx_en')} = 'on';
  mask_visibilities{ismember(mask_names, 'cpu_tx_en')} = 'on';
  
  if strcmp(hw_sys,'ROACH2:sx475t'),
    mask_visibilities{ismember(mask_names, 'pre_emph_r2')} = 'on';
    mask_visibilities{ismember(mask_names, 'swing_r2')} = 'on';
    mask_visibilities{ismember(mask_names, 'post_emph_r2')} = 'on';
    mask_visibilities{ismember(mask_names, 'rxeqmix_r2')} = 'on';
  else
    mask_visibilities{ismember(mask_names, 'pre_emph')} = 'on';
    mask_visibilities{ismember(mask_names, 'swing')} = 'on';
  end
end

%enable and make visible relevant parameters
set_param(blk, 'MaskVisibilities', mask_visibilities);

clog('exiting ten_gbe_v2_callback', 'trace');
