% ten_gbe_v2_openfcn
%
% Sets up the mask according to the target architecture just
% before displaying the Mask Parameter dialog. 
% Use 'set_param(gcb, 'OpenFcn', 'tengbe_v2_openfcn')
% to set up the block to run the function just before displaying the 
% mask parameter dialog.

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

function tengbe_v2_openfcn()

clog('entering tengbe_v2_openfcn', 'trace');

blk = gcb;

check_mask_type(blk, 'ten_GbE_v2');

%disable link to library so can change values (MaskStyle) in mask
set_param(blk,'LinkStatus','inactive');

%search for sysgen block and get target
xps_xsg_blks    = find_system(gcs,'SearchDepth',1,'FollowLinks','on','LookUnderMasks','all','Tag','xps:xsg');

if length(xps_xsg_blks) ~= 1,
  errordlg('ten_Gbe_v2 requires one MSSGE (XSG core config) block to be instantiated at the top level');
  return;
end

%get the target board for the design
hw_sys = get_param(xps_xsg_blks(1),'hw_sys');
mask_names = get_param(blk, 'MaskNames');
mask_enables = get_param(blk, 'MaskEnables');
mask_visibilities = get_param(blk, 'MaskVisibilities');
mask_style = regexp(get_param(blk, 'MaskStyleString'),',','split');

if strcmp(hw_sys,'ROACH2:sx475t'), %values from ug366 gtx data sheet (should match with xps_tengbe_v2)
  mask_style{ismember(mask_names, 'port')} = 'popup(0|1|2|3|4|5|6|7)'; %allow 8 ports for ROACH2
  
  mask_enables{ismember(mask_names, 'swing_r2')} = 'on'; %enable parameter
  mask_visibilities{ismember(mask_names, 'swing_r2')} = 'on'; %make parameter visible
  mask_enables{ismember(mask_names, 'swing')} = 'off'; %disable parameter
  mask_visibilities{ismember(mask_names, 'swing')} = 'off'; %make parameter invisible

  mask_enables{ismember(mask_names, 'post_emph_r2')} = 'on'; %enable parameter
  mask_visibilities{ismember(mask_names, 'post_emph_r2')} = 'on'; %make parameter visible

  mask_enables{ismember(mask_names, 'pre_emph_r2')} = 'on'; %enable parameter
  mask_visibilities{ismember(mask_names, 'pre_emph_r2')} = 'on'; %make visible post emphasis parameter
  mask_enables{ismember(mask_names, 'pre_emph')} = 'off'; %disable parameter
  mask_visibilities{ismember(mask_names, 'pre_emph')} = 'off'; %make parameter invisible

  mask_enables{ismember(mask_names, 'rxeqmix_r2')} = 'on'; %enable receive equalisation parameter
  mask_visibilities{ismember(mask_names, 'rxeqmix_r2')} = 'on'; %make receive equalisation parameter visible

else %TODO make mask values more intuitive for ROACH
  mask_style{ismember(mask_names, 'port')} = 'popup(0|1|2|3)'; %allow 4 ports for ROACH
  
  mask_enables{ismember(mask_names, 'swing')} = 'on'; %enable parameter
  mask_visibilities{ismember(mask_names, 'swing')} = 'on'; %make parameter visible
  mask_enables{ismember(mask_names, 'swing_r2')} = 'off'; %disable parameter
  mask_visibilities{ismember(mask_names, 'swing_r2')} = 'off'; %make parameter invisible

  mask_enables{ismember(mask_names, 'post_emph_r2')} = 'off'; %disable post emphasis parameter
  mask_visibilities{ismember(mask_names, 'post_emph_r2')} = 'off'; %make parameter invisible
  
  mask_enables{ismember(mask_names, 'pre_emph')} = 'on'; %enable parameter
  mask_visibilities{ismember(mask_names, 'pre_emph')} = 'on'; %make parameter visible
  mask_enables{ismember(mask_names, 'pre_emph_r2')} = 'off'; %disable parameter
  mask_visibilities{ismember(mask_names, 'pre_emph_r2')} = 'off'; %make parameter invisible
  
  mask_enables{ismember(mask_names, 'rxeqmix_r2')} = 'off'; %disable parameter
  mask_visibilities{ismember(mask_names, 'rxeqmix_r2')} = 'off'; %make parameter invisible

end

%reconstruct mask_style_string
mask_style_string = [mask_style{1}];
for n = 2:length(mask_style),
  mask_style_string = [mask_style_string,',',mask_style{n}];
end

set_param(blk, 'MaskStyleString', mask_style_string);
set_param(blk, 'MaskEnables', mask_enables);
set_param(blk, 'MaskVisibilities', mask_visibilities);


% open the mask parameter dialog 
open_system(blk, 'mask');

clog('exiting tengbe_v2_openfcn', 'trace');
