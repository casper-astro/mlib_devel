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

s.hw_sys         = get(xsg_obj,'hw_sys');
s.flavour        = get_param(blk_name, 'flavour');
s.slot           = get_param(blk_name, 'slot');
s.preemph        = get_param(blk_name, 'pre_emph');
s.preemph_r2     = get_param(blk_name, 'pre_emph_r2');
s.postemph_r2    = get_param(blk_name, 'post_emph_r2');
s.rxeqmix_r2     = get_param(blk_name, 'rxeqmix_r2');
s.swing          = get_param(blk_name, 'swing');
s.swing_r2       = get_param(blk_name, 'swing_r2');
s.rx_dist_ram    = num2str(strcmp(get_param(blk_name, 'rx_dist_ram'), 'on'));
s.cpu_rx_enable  = num2str(strcmp(get_param(blk_name, 'cpu_rx_en'), 'on'));
s.cpu_tx_enable  = num2str(strcmp(get_param(blk_name, 'cpu_tx_en'), 'on'));
s.fab_mac        = ['0x', dec2hex(eval(get_param(blk_name, 'fab_mac')))  ];
s.fab_ip         = ['0x', dec2hex(eval(get_param(blk_name, 'fab_ip')))   ];
s.fab_udp        = ['0x', dec2hex(eval(get_param(blk_name, 'fab_udp')))  ];
s.fab_gate       = ['0x', dec2hex(eval(get_param(blk_name, 'fab_gate'))) ];
s.fab_en         = num2str(strcmp(get_param(blk_name, 'fab_en'),'on'));
s.large_packets  = num2str(strcmp(get_param(blk_name, 'large_frames'),'on'));

%convert (more intuitive) mask values to defines to be passed on if using ROACH2
switch s.hw_sys
  case {'ROACH'},
    s.port = get_param(blk_name, 'port_r1');

  case {'ROACH2'}, 
    %get the port from the appropriate parameter, roach2 mezzanine slot 0 has 4-7, roach2 mezzanine slot 1 has 0-3, so barrel shift
    if(strcmp(s.flavour,'cx4')),
      s.port = num2str(str2num(get_param(blk_name, 'port_r2_cx4')) + 4*(mod(s.slot+1,2)));
    elseif strcmp(s.flavour,'sfp+'),
      s.port = num2str(str2num(get_param(blk_name, 'port_r2_sfpp')) + 4*(mod(s.slot+1,2)));
    else
    end

    %values below taken from ug366 transceiver user guide (should match with tengbe_v2_loadfcn)

    postemph_lookup = [0.18;0.19;0.18;0.18;0.18;0.18;0.18;0.18;0.19;0.2;0.39;0.63;0.82;1.07;1.32;1.6;1.65;1.94;2.21;2.52;2.76;3.08;3.41;3.77;3.97;4.36;4.73;5.16;5.47;5.93;6.38;6.89];
    index = find(postemph_lookup == str2num(s.postemph_r2));
    if isempty(index), 
      error(['xps_tengbe_v2:''',str2num(s.postemph_r2),''' not found in ''',postemph_lookup,'''']);
      return; 
    end
    s.postemph_r2 = num2str(index(1)-1);

    preemph_lookup = [0.15;0.3;0.45;0.61;0.74;0.91;1.07;1.25;1.36;1.55;1.74;1.94;2.11;2.32;2.54;2.77];
    index = find(preemph_lookup == str2num(s.preemph_r2));
    if index == [], 
      error(['xps_tengbe_v2:''',str2num(s.preemph_r2),''' not found in ''',preemph_lookup,'''']);
      return; 
    end
    s.preemph_r2 = num2str(index(1)-1);

    swing_lookup = [110;210;310;400;480;570;660;740;810;880;940;990;1040;1080;1110;1130];
    index = find(swing_lookup == str2num(s.swing_r2));
    if index == [], 
      error(['xps_tengbe_v2:''',str2num(s.swing_r2),''' not found in ''',swing_lookup,'''']);
      return; 
    end
    s.swing_r2 = num2str(index(1)-1);
  otherwise
end

b = class(s,'xps_tengbe_v2',blk_obj);

% ip name & version
b = set(b,'ip_name','kat_ten_gb_eth');

switch s.hw_sys
  case {'ROACH','ROACH2'},
    b = set(b,'ip_version','1.00.a');
  otherwise
    error(['10GbE not supported for platform ', s.hw_sys]);
end

% bus offset

% ROACH/ROACH2 have OPB Ten Gig Eth interfaces
switch s.hw_sys
    case {'ROACH','ROACH2'},
        b = set(b,'opb_clk','epb_clk');
        b = set(b,'opb_address_offset',16384);
        b = set(b,'opb_address_align', hex2dec('4000'));
    % end case {'ROACH','ROACH2'}
end % switch s.hw_sys

parameters.FABRIC_MAC     = s.fab_mac;
parameters.FABRIC_IP      = s.fab_ip;
parameters.FABRIC_PORT    = s.fab_udp;
parameters.FABRIC_GATEWAY = s.fab_gate;
parameters.FABRIC_ENABLE  = s.fab_en;
parameters.LARGE_PACKETS  = s.large_packets;
parameters.RX_DIST_RAM    = s.rx_dist_ram;
parameters.CPU_RX_ENABLE  = s.cpu_rx_enable;
parameters.CPU_TX_ENABLE  = s.cpu_tx_enable;

switch s.hw_sys
  case {'ROACH2'}, 
    parameters.PREEMPHASIS    = s.preemph_r2; 
    parameters.POSTEMPHASIS   = s.postemph_r2;
    parameters.DIFFCTRL       = s.swing_r2;
    parameters.RXEQMIX        = s.rxeqmix_r2;
  otherwise,
    s.swing          = get_param(blk_name, 'swing');
    parameters.SWING          = s.swing;
    parameters.PREEMPHASYS    = s.preemph;
end

b = set(b,'parameters',parameters);

% bus interfaces
switch s.hw_sys
    case {'ROACH'},
        interfaces.XAUI_CONF = ['xaui_conf',s.port];
        interfaces.XGMII     = ['xgmii',s.port];
        b = set(b,'interfaces',interfaces);
    % end case 'ROACH'
    case {'ROACH2'},
        interfaces.PHY_CONF = ['phy_conf',s.port];
        interfaces.XAUI_CONF = ['xaui_conf',s.port];
        interfaces.XGMII     = ['xgmii',s.port];
        b = set(b,'interfaces',interfaces);
    % end case 'ROACH2'
end % switch s.hw_sys

% miscellaneous and external ports

misc_ports.clk     = {1 'in' get(xsg_obj,'clk_src')};

ext_ports = {};

switch s.hw_sys
    case {'ROACH'}, 
        if strcmp(s.port, '0') || strcmp(s.port, '1')
            misc_ports.xaui_clk = {1 'in'  'mgt_clk_0'};
        else
            misc_ports.xaui_clk = {1 'in'  'mgt_clk_1'};
        end
    case {'ROACH2'},
        misc_ports.xaui_clk = {1 'in' 'xaui_clk'};
        misc_ports.xaui_reset = {1 'in' 'sys_reset'};
    
end % switch s.hw_sys

b = set(b,'misc_ports',misc_ports);
b = set(b,'ext_ports',ext_ports);

% borf parameters
switch s.hw_sys
    case {'ROACH','ROACH2'},
        borph_info.size = hex2dec('4000');
        borph_info.mode = 3;
        b = set(b,'borph_info',borph_info);
    otherwise
        borph_info.size = 1;
        borph_info.mode = 7;
        b = set(b,'borph_info',borph_info);
end
