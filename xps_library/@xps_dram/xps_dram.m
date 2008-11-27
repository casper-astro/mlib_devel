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
    error('XPS_SRAM class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_dram')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

xsg_obj_name = get(xsg_obj,'simulink_name');
xsg_hw_sys = get_param(xsg_obj_name,'hw_sys');

s.half_burst = num2str(strcmp(get_param(blk_name, 'half_burst'),'on'));
s.bank_mgt   = num2str(strcmp(get_param(blk_name, 'bank_mgt'),'on'));
s.wide_data  = num2str(strcmp(get_param(blk_name, 'wide_data'),'on'));
if( strcmp(xsg_hw_sys,'BEE2_ctrl') || strcmp(xsg_hw_sys,'BEE2_usr')),
	s.hw_sys = xsg_hw_sys;
	s.dimm  = get_param(blk_name, 'dimm');
else
	s.hw_sys = 'ROACH'; %assuming ROACH if not BEE2, should cause failure if something else
	s.dimm = 1;
end
b = class(s, 'xps_dram', blk_obj);

if( strcmp(xsg_hw_sys,'BEE2_ctrl') || strcmp(xsg_hw_sys,'BEE2_usr')),
	% ip name
	b = set(b, 'ip_name', 'plb_ddr2_sniffer');

	% plb bus offset
	b = set(b, 'plb_address_offset', hex2dec('100'));
	b = set(b, 'opb_address_offset', 0);
else 
	% ip name
	b = set(b, 'ip_name', 'opb_dram_sniffer');

	% opb bus offset
	b = set(b, 'opb_address_offset', hex2dec('100'));
	b = set(b, 'plb_address_offset', 0);
end

% interfaces
interfaces.DDR2_USER = ['ddr2_user_dimm', s.dimm, '_async'];
interfaces.DDR2_CTRL = ['ddr2_user_dimm', s.dimm, '_ctrl'];
b = set(b,'interfaces',interfaces);

% borph parameters
b = set(b, 'mode', 3);  % read/write mode
b = set(b, 'size', 2^30);

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
