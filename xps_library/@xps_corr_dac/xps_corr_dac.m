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

function b = xps_corr_dac(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_CORR_DAC class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_corr_dac')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.hw_sys = 'CORR';
s.reg_clk_phase = get_param(blk_name,'reg_clk_phase');
b = class(s,'xps_corr_dac',blk_obj);

% ip name
b = set(b,'ip_name','corr_dac_interface');

% parameters
parameters.CLK_PHASE = num2str(s.reg_clk_phase);
b = set(b,'parameters',parameters);

% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.sys_clk = {1 'in' get(xsg_obj,'clk_src')};
misc_ports.sys_clk90 = {1 'in' get(xsg_obj,'clk90_src')};
b = set(b,'misc_ports',misc_ports);

% external ports
ext_ports.dac_data = {14 'out' 'dac_data' 'CORR.dac.data' 'vector=true'  struct() struct()};
ext_ports.dac_sync = {1  'out' 'dac_sync' 'CORR.dac.sync' 'vector=false' struct() struct()};
b = set(b,'ext_ports',ext_ports);