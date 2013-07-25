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

function b = xps_dram(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_DRAM class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_dram')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

xsg_obj_name = get(xsg_obj,'simulink_name');
[xsg_hw_sys, xsg_hw_subsys] = xps_get_hw_plat(get_param(xsg_obj_name,'hw_sys'));

s.half_burst  = num2str(strcmp(get_param(blk_name, 'half_burst'),  'on'));
s.bank_mgt    = num2str(strcmp(get_param(blk_name, 'bank_mgt'),    'on'));
s.wide_data   = num2str(strcmp(get_param(blk_name, 'wide_data'),   'on'));
s.bram_fifos  = num2str(strcmp(get_param(blk_name, 'bram_fifos'),  'on'));
s.disable_tag = num2str(strcmp(get_param(blk_name, 'disable_tag'), 'on'));
s.use_sniffer = num2str(strcmp(get_param(blk_name, 'use_sniffer'), 'on')); 
s.dimm = 1; %only one dimm on ROACH and ROACH2. BEE2 support removed.
s.hw_sys   = xsg_hw_sys;
s.clk_freq = str2num(get_param(blk_name,'ip_clock'));

b = class(s, 'xps_dram', blk_obj);
% IP name
%b = set(b, 'ip_name', 'opb_dram_sniffer');
% opb bus offset
%b = set(b, 'opb_address_offset', hex2dec('100'));
%b = set(b, 'plb_address_offset', 0);
%number of hard-coded opb0 interfaces
%b = set(b, 'opb0_devices', 2); %data and control interfaces on sniffer

% interfaces
interfaces.DDR2_USER = ['ddr2_user_dimm', s.dimm, '_async'];
interfaces.DDR2_CTRL = ['ddr2_user_dimm', s.dimm, '_ctrl'];
b = set(b,'interfaces',interfaces);

% borph parameters
if (strcmp(xsg_hw_sys,'ROACH'))
  borph_info.size = 2^30;
  borph_info.mode = 3;
  b = set(b,'borph_info',borph_info);
end


% misc ports
misc_ports.ddr_clk = {1 'in' 'ddr2_user_clk'};
b = set(b,'misc_ports',misc_ports);

% bus connections
buses.MEM_CMD.busif = {[clear_name(blk_name), '_MEM_CMD']};
buses.MEM_CMD.ports = {};
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Cmd_Address'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Cmd_RNW'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Cmd_Valid'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Cmd_Tag'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Cmd_Ack'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Rd_Dout'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Rd_Tag'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Rd_Ack'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Rd_Valid'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Wr_Din'];
buses.MEM_CMD.ports = [buses.MEM_CMD.ports, 'Mem_Wr_BE'];
b = set(b, 'buses', buses);
