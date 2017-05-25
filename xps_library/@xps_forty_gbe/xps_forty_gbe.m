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

function b = xps_forty_gbe(blk_obj)

disp('here')

if ~isa(blk_obj,'xps_block')
    error('XPS_FORTY_GBE class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_forty_gbe')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

s.hw_sys         = get(xsg_obj,'hw_sys');
s.flavour        = get_param(blk_name, 'flavour');
s.slot           = get_param(blk_name, 'slot');
s.rx_dist_ram    = num2str(strcmp(get_param(blk_name, 'rx_dist_ram'), 'on'));
s.cpu_rx_enable  = num2str(strcmp(get_param(blk_name, 'cpu_rx_en'), 'on'));
s.cpu_tx_enable  = num2str(strcmp(get_param(blk_name, 'cpu_tx_en'), 'on'));
s.fab_mac        = ['0x', dec2hex(eval(get_param(blk_name, 'fab_mac')))  ];
s.fab_ip         = ['0x', dec2hex(eval(get_param(blk_name, 'fab_ip')))   ];
s.fab_udp        = ['0x', dec2hex(eval(get_param(blk_name, 'fab_udp')))  ];
s.fab_gate       = ['0x', dec2hex(eval(get_param(blk_name, 'fab_gate'))) ];
s.fab_en         = num2str(strcmp(get_param(blk_name, 'fab_en'),'on'));
s.large_packets  = num2str(strcmp(get_param(blk_name, 'large_frames'),'on'));
s.ttl            = ['0x', dec2hex(eval(get_param(blk_name, 'ttl')))   ];

%convert (more intuitive) mask values to defines to be passed on if using ROACH2
switch s.hw_sys
  case {'SKARAB'},
    s.port = get_param(blk_name, 'port_r1');
end

b = class(s,'xps_forty_gbe',blk_obj);

% ip name & version
b = set(b,'ip_name','forty_gbe');

switch s.hw_sys
  case {'SKARAB'},
    b = set(b,'ip_version','1.00.a');
  otherwise
    error(['40GbE not supported for platform ', s.hw_sys]);
end

% bus offset

parameters.FABRIC_MAC     = s.fab_mac;
parameters.FABRIC_IP      = s.fab_ip;
parameters.FABRIC_PORT    = s.fab_udp;
parameters.FABRIC_GATEWAY = s.fab_gate;
parameters.FABRIC_ENABLE  = s.fab_en;
parameters.LARGE_PACKETS  = s.large_packets;
parameters.RX_DIST_RAM    = s.rx_dist_ram;
parameters.CPU_RX_ENABLE  = s.cpu_rx_enable;
parameters.CPU_TX_ENABLE  = s.cpu_tx_enable;
parameters.TTL            = s.ttl;

b = set(b,'parameters',parameters);

% miscellaneous and external ports
misc_ports.clk     = {1 'in' get(xsg_obj,'clk_src')};
ext_ports = {};

b = set(b,'misc_ports',misc_ports);
b = set(b,'ext_ports',ext_ports);
