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

function b = xps_tengbe_v2(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_TENGBE class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_tengbe_v2')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
toks = regexp(get_param(blk_name,'port'),'^(.*):(.*)$','tokens');

s.hw_sys         = get(xsg_obj,'hw_sys');
s.port           = get_param(blk_name, 'port');
s.preemph        = get_param(blk_name, 'pre_emph');
s.swing          = get_param(blk_name, 'swing');
s.rx_dist_ram    = num2str(strcmp(get_param(blk_name, 'rx_dist_ram'), 'on'));
s.cpu_rx_enable  = num2str(strcmp(get_param(blk_name, 'cpu_rx_en'), 'on'));
s.cpu_tx_enable  = num2str(strcmp(get_param(blk_name, 'cpu_tx_en'), 'on'));
s.fab_mac        = ['0x', dec2hex(eval(get_param(blk_name, 'fab_mac')))  ];
s.fab_ip         = ['0x', dec2hex(eval(get_param(blk_name, 'fab_ip')))   ];
s.fab_udp        = ['0x', dec2hex(eval(get_param(blk_name, 'fab_udp')))  ];
s.fab_gate       = ['0x', dec2hex(eval(get_param(blk_name, 'fab_gate'))) ];
s.fab_en         = num2str(strcmp(get_param(blk_name, 'fab_en'),'on'));
s.large_packets  = num2str(strcmp(get_param(blk_name, 'large_frames'),'on'));

b = class(s,'xps_tengbe_v2',blk_obj);

% ip name & version
b = set(b,'ip_name','kat_ten_gb_eth');

switch s.hw_sys
    case 'ROACH'
        b = set(b,'ip_version','1.00.a');
    otherwise
        error(['10GbE not supported for platform ', s.hw_sys]);
end

% bus offset

% ROACH has an OPB Ten Gig Eth interface
switch s.hw_sys
    case 'ROACH'
        b = set(b,'opb_clk','epb_clk');
        b = set(b,'opb_address_offset',16384);
        b = set(b,'opb_address_align', hex2dec('4000'));
    % end case 'ROACH'
end % switch s.hw_sys

parameters.SWING          = s.swing;
parameters.PREEMPHASYS    = s.preemph;
parameters.FABRIC_MAC     = s.fab_mac;
parameters.FABRIC_IP      = s.fab_ip;
parameters.FABRIC_PORT    = s.fab_udp;
parameters.FABRIC_GATEWAY = s.fab_gate;
parameters.FABRIC_ENABLE  = s.fab_en;
parameters.LARGE_PACKETS  = s.large_packets;
parameters.RX_DIST_RAM    = s.rx_dist_ram;
parameters.CPU_RX_ENABLE  = s.cpu_rx_enable;
parameters.CPU_TX_ENABLE  = s.cpu_tx_enable;

b = set(b,'parameters',parameters);

% bus interfaces
switch s.hw_sys
    case 'ROACH'
        interfaces.XAUI_CONF = ['xaui_conf',s.port];
        interfaces.XGMII     = ['xgmii',s.port];
        b = set(b,'interfaces',interfaces);
    % end case 'ROACH'
end % switch s.hw_sys

% miscellaneous and external ports

misc_ports.clk     = {1 'in' get(xsg_obj,'clk_src')};

ext_ports = {};

switch s.hw_sys
    case 'ROACH'
        if strcmp(s.port, '0') || strcmp(s.port, '1')
            misc_ports.xaui_clk = {1 'in'  'mgt_clk_0'};
        else
            misc_ports.xaui_clk = {1 'in'  'mgt_clk_1'};
        end
end % switch s.hw_sys

b = set(b,'misc_ports',misc_ports);
b = set(b,'ext_ports',ext_ports);

% borf parameters
switch s.hw_sys
    case 'ROACH'
        borph_info.size = hex2dec('4000');
        borph_info.mode = 3;
        b = set(b,'borph_info',borph_info);
    otherwise
        borph_info.size = 1;
        borph_info.mode = 7;
        b = set(b,'borph_info',borph_info);
end
