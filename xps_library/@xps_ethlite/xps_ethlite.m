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

function b = xps_ethlite(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_ETHLITE class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_ethlite')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

s.hw_sys = 'iBOB';

b = class(s,'xps_ethlite',blk_obj);

% ip name & version
b = set(b,'ip_name','opb_ethernetlite');
b = set(b,'ip_version','1.01.b');

% software driver
b = set(b, 'soft_driver', {'emaclite','1.01.a'});

% bus offset
b = set(b,'opb_address_offset',hex2dec('2000'));
b = set(b,'opb_address_align', hex2dec('2000'));

% parameters
parameters.C_OPB_CLK_PERIOD_PS = '10000';
b = set(b,'parameters',parameters);

% external ports
ucf_constraints = struct('IOSTANDARD', 'LVCMOS25');

ext_ports.PHY_col       = {1 'in'  'opb_ethlite_phy_col'     {'J32'}                   'vector=false' struct() ucf_constraints};
ext_ports.PHY_crs       = {1 'in'  'opb_ethlite_phy_crs'     {'J31'}                   'vector=false' struct() ucf_constraints};
ext_ports.PHY_dv        = {1 'in'  'opb_ethlite_phy_dv'      {'F33'}                   'vector=false' struct() ucf_constraints};
ext_ports.PHY_rx_clk    = {1 'in'  'opb_ethlite_phy_rx_clk'  {'H29'}                   'vector=false' struct() ucf_constraints};
ext_ports.PHY_rx_data   = {4 'in'  'opb_ethlite_phy_rx_data' {'G30' 'G29' 'G32' 'G31'} 'vector=false' struct() ucf_constraints};
ext_ports.PHY_rx_er     = {1 'in'  'opb_ethlite_phy_rx_err'  {'F34'}                   'vector=false' struct() ucf_constraints};
ext_ports.PHY_tx_clk    = {1 'in'  'opb_ethlite_phy_tx_clk'  {'H30'}                   'vector=false' struct() ucf_constraints};
ext_ports.PHY_tx_data   = {4 'out' 'opb_ethlite_phy_tx_data' {'J30' 'J29' 'G34' 'G33'} 'vector=false' struct() ucf_constraints};
ext_ports.PHY_tx_en     = {1 'out' 'opb_ethlite_phy_tx_en'   {'L26'}                   'vector=false' struct() ucf_constraints};
b = set(b,'ext_ports',ext_ports);
