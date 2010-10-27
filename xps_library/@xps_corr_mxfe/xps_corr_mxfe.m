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

function b = xps_corr_mxfe(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_CORR_MXFE class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_corr_mxfe')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.hw_sys = 'CORR';
s.reg_clk_phase = get_param(blk_name,'reg_clk_phase');
b = class(s,'xps_corr_mxfe',blk_obj);

% ip name
b = set(b,'ip_name','corr_mxfe_interface');
% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.sys_clk   = {1 'in' get(xsg_obj,'clk_src')};
misc_ports.sys_clk90 = {1 'in' get(xsg_obj,'clk90_src')};
b = set(b,'misc_ports',misc_ports);

% parameters
parameters.CLK_PHASE = num2str(s.reg_clk_phase);
b = set(b,'parameters',parameters);

% external ports
ext_ports.mxfe_rst      = {1  'out' 'mxfe_rst'      'CORR.mxfe.rst'      'vector=false' struct() struct()};
ext_ports.mxfe_clk      = {1  'out' 'mxfe_clk'      'CORR.mxfe.clk'      'vector=false' struct() struct()};
ext_ports.mxfe_sdio     = {1  'out' 'mxfe_sdio'     'CORR.mxfe.sdio'     'vector=false' struct() struct()};
ext_ports.mxfe_le       = {1  'out' 'mxfe_le'       'CORR.mxfe.le'       'vector=false' struct() struct()};
ext_ports.mxfe_clk_sel  = {1  'out' 'mxfe_clk_sel'  'CORR.mxfe.clk_sel'  'vector=false' struct() struct()};
ext_ports.mxfe_fpga_clk = {1  'out' 'mxfe_fpga_clk' 'CORR.mxfe.fpga_clk' 'vector=false' struct() struct()};
ext_ports.mxfe_sdo      = {1  'in'  'mxfe_sdo'      'CORR.mxfe.sdo'      'vector=false' struct() struct()};
b = set(b,'ext_ports',ext_ports);
