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

function b = xps_sram(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_SRAM class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_sram')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.hw_sys = 'iBOB';
s.sram = get_param(blk_name,'sram');
b = class(s,'xps_sram',blk_obj);

% ip name
b = set(b,'ip_name','sram_interface');
% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.clk = {1 'in' get(xsg_obj,'clk_src')};
b = set(b,'misc_ports',misc_ports);

% external ports
ext_ports.pads_address  = {19 'out'   ['sram',s.sram,'_address']  ['iBOB.sram',s.sram,'.address']   'null' 'vector=true'};
ext_ports.pads_bw_b     = {4  'out'   ['sram',s.sram,'_bw_b']     ['iBOB.sram',s.sram,'.bw_b']      'null' 'vector=true'};
ext_ports.pads_we_b     = {1  'out'   ['sram',s.sram,'_we_b']     ['iBOB.sram',s.sram,'.we_b']      'null' 'vector=false'};
ext_ports.pads_adv_ld_b = {1  'out'   ['sram',s.sram,'_adv_ld_b'] ['iBOB.sram',s.sram,'.adv_ld_b']  'null' 'vector=false'};
ext_ports.pads_clk      = {1  'out'   ['sram',s.sram,'_clk']      ['iBOB.sram',s.sram,'.clk']       'null' 'vector=false'};
ext_ports.pads_ce       = {1  'out'   ['sram',s.sram,'_ce']       ['iBOB.sram',s.sram,'.ce']        'null' 'vector=false'};
ext_ports.pads_oe_b     = {1  'out'   ['sram',s.sram,'_oe_b']     ['iBOB.sram',s.sram,'.oe_b']      'null' 'vector=false'};
ext_ports.pads_cen_b    = {1  'out'   ['sram',s.sram,'_cen_b']    ['iBOB.sram',s.sram,'.cen_b']     'null' 'vector=false'};
ext_ports.pads_dq       = {36 'inout' ['sram',s.sram,'_dq']       ['iBOB.sram',s.sram,'.dq']        'null' 'vector=true'};
ext_ports.pads_mode     = {1  'out'   ['sram',s.sram,'_mode']     ['iBOB.sram',s.sram,'.mode']      'null' 'vector=false'};
ext_ports.pads_zz       = {1  'out'   ['sram',s.sram,'_zz']       ['iBOB.sram',s.sram,'.zz']        'null' 'vector=false'};
b = set(b,'ext_ports',ext_ports);
