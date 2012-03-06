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

function b = xps_onegbe(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_ONEGBE class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_onegbe')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

% Get MASK paramters from the one_GbE yellow block
s.hw_sys         = get(xsg_obj,'hw_sys');

s.local_en         = num2str(strcmp(get_param(blk_name, 'local_en'), 'on'));
s.cpu_promiscuous  = num2str(strcmp(get_param(blk_name, 'cpu_promiscuous'), 'on'));
s.dis_cpu_tx       = num2str(strcmp(get_param(blk_name, 'dis_cpu_tx'), 'on'));
s.dis_cpu_rx       = num2str(strcmp(get_param(blk_name, 'dis_cpu_rx'), 'on'));
s.local_mac        = ['0x', dec2hex(eval(get_param(blk_name, 'local_mac')))  ];
s.local_ip         = ['0x', dec2hex(eval(get_param(blk_name, 'local_ip')))   ];
s.local_port       = ['0x', dec2hex(eval(get_param(blk_name, 'local_port')))  ];
s.local_gateway    = ['0x', dec2hex(eval(get_param(blk_name, 'local_gateway'))) ];

% These MASK parameters ends up to be generics for the HDL (gbe_udp.v)
% also see gbe_udp_v2_1_0.mpd for connections and parameter declarations
parameters.LOCAL_ENABLE     = s.local_en;
parameters.LOCAL_MAC        = s.local_mac;
parameters.LOCAL_IP         = s.local_ip;
parameters.LOCAL_PORT       = s.local_port;
parameters.LOCAL_GATEWAY    = s.local_gateway;
parameters.CPU_PROMISCUOUS  = s.cpu_promiscuous;
parameters.DIS_CPU_TX       = s.dis_cpu_tx;
parameters.DIS_CPU_RX       = s.dis_cpu_rx;

b = class(s,'xps_onegbe',blk_obj);

% ip name & version
b = set(b,'ip_name','gbe_udp');

switch s.hw_sys
    case 'ROACH2'
        b = set(b,'ip_version','1.00.a');
    otherwise
        error(['1GbE not supported for platform ', s.hw_sys]);
end

% ROACH2 has an OPB One Gig Eth interface
switch s.hw_sys
    case 'ROACH2'
        b = set(b,'opb_clk','epb_clk');
        %b = set(b,'opb_clk',get(xsg_obj,'clk_src'));
        b = set(b,'opb_address_offset',16384);
        b = set(b,'opb_address_align', hex2dec('4000'));
    % end case 'ROACH'
    otherwise
        error(['1GbE not supported for platform ', s.hw_sys]);
    % end otherwise
end % switch s.hw_sys

b = set(b,'parameters',parameters);

% bus interfaces
switch s.hw_sys
    case 'ROACH2'
        interfaces.MAC = ['mac'];
        b = set(b,'interfaces',interfaces);
    otherwise
        error(['1GbE not supported for platform ', s.hw_sys]);
    % end otherwise
end % switch s.hw_sys

% miscellaneous and external ports

% also see gbe_udp_v2_1_0.mpd for connections and parameter declarations

% Connect yellow block app clk to the selected XSG Core Config clk_src
misc_ports.app_clk     = {1 'in' get(xsg_obj,'clk_src')};

% connect mac_tx_rst & mac_rx_rst ports to the yellow block app_tx_rst & app_rx_rst
misc_ports.mac_tx_rst  = {1 'in' clear_name([blk_name,'_app_tx_rst'])}
misc_ports.mac_rx_rst  = {1 'in' clear_name([blk_name,'_app_rx_rst'])}

b = set(b,'misc_ports',misc_ports);

% This yellow block does not have any FPGA pins
ext_ports = {};

b = set(b,'ext_ports',ext_ports);

% borf parameters
switch s.hw_sys
    case 'ROACH2'
        borph_info.size = hex2dec('4000');
        borph_info.mode = 3;
        b = set(b,'borph_info',borph_info);
    otherwise
        borph_info.size = 1;
        borph_info.mode = 7;
        b = set(b,'borph_info',borph_info);
end
