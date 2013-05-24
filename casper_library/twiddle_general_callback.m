%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Meerkat radio telescope project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) Andrew Martens 2013                                         %
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

function twiddle_general_callback(blk)

  check_mask_type(blk, 'twiddle_general');

  mask_names = get_param(blk, 'MaskNames');
  mask_visibs = get_param(blk, 'MaskVisibilities');

  use_hdl = get_param(blk,'use_hdl');

  if( strcmp(use_hdl,'on')), use_embedded = 'off';
  else, use_embedded = 'on';
  end
  set_param(blk, 'use_embedded', use_embedded);
  mask_visibs{ismember(mask_names,'use_embedded')} = use_embedded;

  set_param(blk, 'MaskVisibilities', mask_visibs);

end %function
