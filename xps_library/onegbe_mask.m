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

cursys = gcb;

%set_param(cursys, 'LinkStatus', 'inactive');

% Rename gateways
gateway_ins = find_system(cursys,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway In Block');
for i =1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw,'Name'),'_app_tx_afull$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_afull']));
    elseif regexp(get_param(gw,'Name'),'_app_tx_overflow$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_overflow']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_data$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_data']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_dvld$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_dvld']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_srcip$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_srcip']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_srcport$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_srcport']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_eof$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_eof']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_badframe$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_badframe']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_overrun$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_overrun']));
    elseif regexp(get_param(gw,'Name'),'_app_dbg_data$')
        set_param(gw,'Name',clear_name([cursys,'_app_dbg_data']));
    elseif regexp(get_param(gw,'Name'),'_app_dbg_dvld$')
        set_param(gw,'Name',clear_name([cursys,'_app_dbg_dvld']));
    else
        errordlg(['Unkown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end

gateway_outs = find_system(cursys,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'_app_tx_rst$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_rst']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_rst$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_rst']));
    elseif regexp(get_param(gw,'Name'),'_app_tx_data$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_data']));
    elseif regexp(get_param(gw,'Name'),'_app_tx_dvld$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_dvld']));
    elseif regexp(get_param(gw,'Name'),'_app_tx_destip$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_destip']));
    elseif regexp(get_param(gw,'Name'),'_app_tx_destport$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_destport']));
    elseif regexp(get_param(gw,'Name'),'_app_tx_eof$')
        set_param(gw,'Name',clear_name([cursys,'_app_tx_eof']));
    elseif regexp(get_param(gw,'Name'),'_app_rx_ack$')
        set_param(gw,'Name',clear_name([cursys,'_app_rx_ack']));
    else
        errordlg(['Unkown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end
