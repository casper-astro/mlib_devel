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


gcb_arith_type = get_param(gcb, 'arith_type');
gateway_ins =find_system(gcb,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway In Block');
set_param(gateway_ins{1},'arith_type',gcb_arith_type,'Name',clear_name([gcb,'_data_out']));
gateway_outs =find_system(gcb,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'_addr$')
        set_param(gw,'Name',clear_name([gcb,'_addr']));
    elseif regexp(get_param(gw,'Name'),'_data_in$')
        set_param(gw,'Name',clear_name([gcb,'_data_in']));
    elseif regexp(get_param(gw,'Name'),'_we$')
        set_param(gw,'Name',clear_name([gcb,'_we']));
    else
        errordlg(['Unkown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end

set_param([gcb,'/convert_din'],'arith_type',gcb_arith_type);
set_param([gcb,'/mem/sim_data_in'],'arith_type',gcb_arith_type);
if addr_width < 11
    errordlg('Shared BRAM address width cannot be less than 11');
end
if addr_width > 16
    errordlg('Shared BRAM address width cannot be greater than 16');
end
