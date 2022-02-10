%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
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

function vla_dts_mask(blk)

cursys = blk;
set_param(cursys, 'LinkStatus', 'inactive');

% rename gateways
gateway_ins = find_system(cursys, 'searchdepth', 1, 'FollowLinks', ...
    'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
for ctr = 1 : length(gateway_ins)
    gw = gateway_ins{ctr};
    if regexp(get_param(gw, 'Name'), '_frame_out$')
        set_param(gw, 'Name', clear_name([cursys, '_frame_out']));
    elseif regexp(get_param(gw, 'Name'), '_index$')
        set_param(gw, 'Name', clear_name([cursys, '_index']));
    elseif regexp(get_param(gw, 'Name'), '_one_sec$')
        set_param(gw, 'Name', clear_name([cursys, '_one_sec']));
    elseif regexp(get_param(gw, 'Name'), '_ten_sec$')
        set_param(gw, 'Name', clear_name([cursys, '_ten_sec']));
    elseif regexp(get_param(gw, 'Name'), '_locked$')
        set_param(gw, 'Name', clear_name([cursys, '_locked']));
    elseif regexp(get_param(gw, 'Name'), '_sync$')
        set_param(gw, 'Name', clear_name([cursys, '_sync']));
    else
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', ...
            get_param(gw, 'Name')]);
    end
end
gateway_outs = find_system(cursys, 'searchdepth', 1, ...
    'FollowLinks', 'on', 'lookundermasks', 'all', ...
    'masktype', 'Xilinx Gateway Out Block');
for ctr = 1 : length(gateway_outs)
    gw = gateway_outs{ctr};
    if regexp(get_param(gw, 'Name'), '_rst$')
        set_param(gw, 'Name', clear_name([cursys, '_rst']));
    else
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', ...
            get_param(gw, 'Name')]);
    end
end

set_param(cursys, 'AttributesFormatString', '');

end
% end
