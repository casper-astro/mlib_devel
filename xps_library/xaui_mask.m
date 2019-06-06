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

demux = str2num(get_param(cursys, 'demux'));

% Change data type parameters
set_param([cursys,'/convert_tx_data'],'n_bits', num2str(64/demux));
set_param([cursys,'/convert_tx_outofband'],'n_bits', num2str(8/demux));

% Rename ports
gateway_ins = find_system(cursys,'searchdepth',1,'FollowLinks', 'on', 'lookundermasks','all','masktype','Xilinx Gateway In Block');
for i = 1:length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw,'Name'),'(rx_data)$')
        toks = regexp(get_param(gw,'Name'),'(rx_data)$','tokens');
        set_param(gw,'n_bits', num2str(64/demux));
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(rx_outofband)$')
        toks = regexp(get_param(gw,'Name'),'(rx_outofband)$','tokens');
        set_param(gw,'n_bits', num2str(8/demux));
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(rx_empty)$')
        toks = regexp(get_param(gw,'Name'),'(rx_empty)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(rx_valid)$')
        toks = regexp(get_param(gw,'Name'),'(rx_valid)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(rx_linkdown)$')
        toks = regexp(get_param(gw,'Name'),'(rx_linkdown)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(rx_almost_full)$')
        toks = regexp(get_param(gw,'Name'),'(rx_almost_full)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(tx_full)$')
        toks = regexp(get_param(gw,'Name'),'(tx_full)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]))
    else
        errordlg(['Unkown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end


gateway_outs = find_system(cursys,'searchdepth',1,'FollowLinks', 'on','lookundermasks','all','masktype','Xilinx Gateway Out Block');
for i = 1:length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw,'Name'),'(rx_get)$')
        toks = regexp(get_param(gw,'Name'),'(rx_get)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(rx_reset)$')
        toks = regexp(get_param(gw,'Name'),'(rx_reset)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(tx_data)$')
        toks = regexp(get_param(gw,'Name'),'(tx_data)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(tx_outofband)$')
        toks = regexp(get_param(gw,'Name'),'(tx_outofband)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    elseif regexp(get_param(gw,'Name'),'(tx_valid)$')
        toks = regexp(get_param(gw,'Name'),'(tx_valid)$','tokens');
        set_param(gw,'Name',clear_name([cursys,'_',toks{1}{1}]));
    else
        errordlg(['Unkown gateway: ',get_param(gw,'Parent'),'/',get_param(gw,'Name')]);
    end
end