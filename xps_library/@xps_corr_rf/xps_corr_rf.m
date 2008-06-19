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

function b = xps_corr_rf(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_CORR_RF class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_corr_rf')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.hw_sys = 'CORR';
b = class(s,'xps_corr_rf',blk_obj);

% ip name
b = set(b,'ip_name','corr_rf_interface');
% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.sys_clk = {1 'in' get(xsg_obj,'clk_src')};
b = set(b,'misc_ports',misc_ports);

% external ports
ext_ports.rf_pll_clk  = {1  'out' 'rf_pll_clk'  'CORR.rf.pll_clk ' 'null' 'vector=false'};
ext_ports.rf_pll_data = {1  'out' 'rf_pll_data' 'CORR.rf.pll_data' 'null' 'vector=false'};
ext_ports.rf_pll_le   = {1  'out' 'rf_le'       'CORR.rf.pll_le'   'null' 'vector=false'};
ext_ports.rf_tx_power = {3  'out' 'rf_tx_power' 'CORR.rf.tx_power' 'null' 'vector=true'};
ext_ports.rf_lna_gain = {1  'out' 'rf_lna_gain' 'CORR.rf.lna_gain' 'null' 'vector=false'};
ext_ports.rf_ant_sel  = {1  'out' 'rf_ant_sel'  'CORR.rf.ant_sel'  'null' 'vector=false'};
ext_ports.rf_tx_on    = {1  'out' 'rf_tx_on'    'CORR.rf.tx_on'    'null' 'vector=false'};
b = set(b,'ext_ports',ext_ports);