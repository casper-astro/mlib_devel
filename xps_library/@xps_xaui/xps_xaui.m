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

function b = xps_xaui(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_XAUI class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_xaui')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
toks = regexp(get_param(blk_name,'port'),'^(.*):(.*)$','tokens');

s.board = toks{1}{1};
s.port = toks{1}{2};
s.hw_sys = s.board;
s.preemph = get_param(blk_name, 'pre_emph');
s.swing = get_param(blk_name, 'swing');
s.open_phy  = num2str(strcmp(get_param(blk_name, 'open_phy'), 'on'));

b = class(s,'xps_xaui',blk_obj);

% ip name
b = set(b,'ip_name','XAUI_interface');

% misc ports
misc_ports.app_clk     = {1 'in' get(xsg_obj,'clk_src')};

switch s.board
    case 'ROACH'
        if strcmp(s.port, '0') || strcmp(s.port, '1')
            misc_ports.xaui_clk =    {1 'in'  'mgt_clk_0'};
        else
            misc_ports.xaui_clk =    {1 'in'  'mgt_clk_1'};
        end
end % switch s.board

b = set(b,'misc_ports',misc_ports);

% parameters
parameters.DEMUX = get_param(blk_name,'demux');
b = set(b,'parameters',parameters);

% external ports
portnum  = ['XAUI', s.port];
xauiport = [s.board,'.',portnum];

if ~strcmp(s.board,'ROACH')
    ext_ports.mgt_tx_l0_p = {1 'out' [portnum,'_tx_l0_p'] [xauiport, '.tx_l0_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_tx_l0_n = {1 'out' [portnum,'_tx_l0_n'] [xauiport, '.tx_l0_n'] 'vector=false' struct() struct()};
    ext_ports.mgt_tx_l1_p = {1 'out' [portnum,'_tx_l1_p'] [xauiport, '.tx_l1_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_tx_l1_n = {1 'out' [portnum,'_tx_l1_n'] [xauiport, '.tx_l1_n'] 'vector=false' struct() struct()};
    ext_ports.mgt_tx_l2_p = {1 'out' [portnum,'_tx_l2_p'] [xauiport, '.tx_l2_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_tx_l2_n = {1 'out' [portnum,'_tx_l2_n'] [xauiport, '.tx_l2_n'] 'vector=false' struct() struct()};
    ext_ports.mgt_tx_l3_p = {1 'out' [portnum,'_tx_l3_p'] [xauiport, '.tx_l3_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_tx_l3_n = {1 'out' [portnum,'_tx_l3_n'] [xauiport, '.tx_l3_n'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l0_p = {1 'in'  [portnum,'_rx_l0_p'] [xauiport, '.rx_l0_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l0_n = {1 'in'  [portnum,'_rx_l0_n'] [xauiport, '.rx_l0_n'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l1_p = {1 'in'  [portnum,'_rx_l1_p'] [xauiport, '.rx_l1_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l1_n = {1 'in'  [portnum,'_rx_l1_n'] [xauiport, '.rx_l1_n'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l2_p = {1 'in'  [portnum,'_rx_l2_p'] [xauiport, '.rx_l2_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l2_n = {1 'in'  [portnum,'_rx_l2_n'] [xauiport, '.rx_l2_n'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l3_p = {1 'in'  [portnum,'_rx_l3_p'] [xauiport, '.rx_l3_p'] 'vector=false' struct() struct()};
    ext_ports.mgt_rx_l3_n = {1 'in'  [portnum,'_rx_l3_n'] [xauiport, '.rx_l3_n'] 'vector=false' struct() struct()};
    b = set(b,'ext_ports',ext_ports);
end

if strcmp(s.board,'ROACH')
    interfaces.XAUI_CONF = ['xaui_conf',s.port];
    interfaces.XGMII     = ['xgmii',s.port];
    b = set(b,'interfaces',interfaces);
end

% Only ROACH has an OPB attachment for XAUI
switch s.hw_sys
    case 'ROACH'
        b = set(b,'opb_clk','epb_clk');
        b = set(b,'opb_address_offset', 256);
end % switch s.hw_sys

% borf parameters
switch s.hw_sys
    case 'ROACH'
        borph_info.size = 32;
        borph_info.mode = 3;
        b = set(b,'borph_info',borph_info);
end
