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
    if regexp(get_param(gw,'Name'),'_tx_afull$')
        set_param(gw,'Name',clear_name([cursys,'_tx_afull']));
    elseif regexp(get_param(gw,'Name'),'_tx_overflow$')
        set_param(gw,'Name',clear_name([cursys,'_tx_overflow']));
    elseif regexp(get_param(gw,'Name'),'_rx_valid$')
        set_param(gw,'Name',clear_name([cursys,'_rx_valid']));
    elseif regexp(get_param(gw,'Name'),'_rx_data$')
        set_param(gw,'Name',clear_name([cursys,'_rx_data']));
    elseif regexp(get_param(gw,'Name'),'_rx_source_ip$')
        set_param(gw,'Name',clear_name([cursys,'_rx_source_ip']));
    elseif regexp(get_param(gw,'Name'),'_rx_source_port$')
        set_param(gw,'Name',clear_name([cursys,'_rx_source_port']));
    elseif regexp(get_param(gw,'Name'),'_rx_end_of_frame$')
        set_param(gw,'Name',clear_name([cursys,'_rx_end_of_frame']));
    elseif regexp(get_param(gw,'Name'),'_rx_bad_frame$')
        set_param(gw,'Name',clear_name([cursys,'_rx_bad_frame']));
    elseif regexp(get_param(gw,'Name'),'_rx_overrun$')
        set_param(gw,'Name',clear_name([cursys,'_rx_overrun']));
    elseif regexp(get_param(gw,'Name'),'_led_up$')
        set_param(gw,'Name',clear_name([cursys,'_led_up']));
    elseif regexp(get_param(gw,'Name'),'_led_rx$')
        set_param(gw,'Name',clear_name([cursys,'_led_rx']));
    elseif regexp(get_param(gw,'Name'),'_led_tx$')
        set_param(gw,'Name',clear_name([cursys,'_led_tx']));
    elseif regexp(get_param(gw,'Name'),'_rx_size$')
        set_param(gw,'Name',clear_name([cursys,'_rx_size']));
    else
        errordlg(['Unknown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end


gateway_outs = find_system(cursys,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'_rst$')
        set_param(gw,'Name',clear_name([cursys,'_rst']));
    elseif regexp(get_param(gw,'Name'),'_tx_valid$')
        set_param(gw,'Name',clear_name([cursys,'_tx_valid']));
    elseif regexp(get_param(gw,'Name'),'_tx_end_of_frame$')
        set_param(gw,'Name',clear_name([cursys,'_tx_end_of_frame']));
    elseif regexp(get_param(gw,'Name'),'_tx_discard$')
        set_param(gw,'Name',clear_name([cursys,'_tx_discard']));
    elseif regexp(get_param(gw,'Name'),'_tx_data$')
        set_param(gw,'Name',clear_name([cursys,'_tx_data']));
    elseif regexp(get_param(gw,'Name'),'_tx_dest_ip$')
        set_param(gw,'Name',clear_name([cursys,'_tx_dest_ip']));
    elseif regexp(get_param(gw,'Name'),'_tx_dest_port$')
        set_param(gw,'Name',clear_name([cursys,'_tx_dest_port']));
    elseif regexp(get_param(gw,'Name'),'_rx_ack$')
        set_param(gw,'Name',clear_name([cursys,'_rx_ack']));
    elseif regexp(get_param(gw,'Name'),'_rx_overrun_ack$')
        set_param(gw,'Name',clear_name([cursys,'_rx_overrun_ack']));
    else
        errordlg(['Unkown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end

