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

function [str,opb_addr_end,plb_addr_end] = gen_mhs_ip(blk_obj,opb_addr_start,plb_addr_start,plb_name,opb_name)
str = '';
opb_addr_end = opb_addr_start;
ip_name    = get(blk_obj,'ip_name');
interfaces = get(blk_obj,'interfaces');
misc_ports = get(blk_obj,'misc_ports');
range_plb  = get(blk_obj,'plb_address_offset');

str = [str, 'BEGIN ', get(blk_obj, 'ip_name'),'\n'];
str = [str, ' PARAMETER INSTANCE = ',clear_name(get(blk_obj,'simulink_name')),'\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
plb_addr_end = plb_addr_start + range_plb;
str = [str, ' PARAMETER C_BASEADDR = 0x',dec2hex(plb_addr_start),'\n'];
str = [str, ' PARAMETER C_HIGHADDR = 0x',dec2hex(plb_addr_end-1),'\n'];
str = [str, ' BUS_INTERFACE SPLB = ',plb_name,'\n'];
interfaces_names = fieldnames(interfaces);
for j = 1:length(interfaces_names)
    cur_interface = getfield(interfaces,interfaces_names{j});
    str = [str, ' BUS_INTERFACE ',interfaces_names{j},' = ',cur_interface,'\n'];
end
misc_port_names = fieldnames(misc_ports);
for j = 1:length(misc_port_names)
    cur_misc_port = getfield(misc_ports,misc_port_names{j});
    if cur_misc_port{1} == 1
        str = [str, ' PORT ',misc_port_names{j},' = ',cur_misc_port{3},'\n'];
    else
        str = [str, ' PORT ',misc_port_names{j},' = ',cur_misc_port{3},'\n'];
    end
end

str = [str, 'END\n'];

inst_name = clear_name(get(blk_obj,'simulink_name'));
xsg_obj = get(blk_obj,'xsg_obj');

dimm       = get(blk_obj,'dimm');
half_burst = get(blk_obj,'half_burst');
wide_data  = get(blk_obj,'wide_data');
bank_mgt   = get(blk_obj,'bank_mgt');

str = [str, 'BEGIN async_ddr2\n'];
str = [str, ' PARAMETER INSTANCE     = async_ddr2_dimm', dimm, '\n'];
str = [str, ' PARAMETER HW_VER       = 2.00.a\n'];
str = [str, ' PARAMETER C_WIDE_DATA  = ', wide_data, '\n'];
str = [str, ' PARAMETER C_HALF_BURST = ', half_burst, '\n'];
str = [str, ' BUS_INTERFACE MEM_CMD   = ', inst_name, '_MEM_CMD\n'];
str = [str, ' BUS_INTERFACE DDR2_USER = ddr2_user_dimm', dimm, '_async\n'];
str = [str, ' PORT Mem_Clk            = ', get(xsg_obj, 'clk_src'), '\n'];
str = [str, ' PORT MEM_Rst            = ', inst_name, '_Mem_Rst\n'];
str = [str, ' PORT DDR_Clk            = ddr2_user_clk\n'];
str = [str, 'END\n'];
str = [str, '\n'];
str = [str, 'BEGIN ddr2_controller\n'];
str = [str, ' PARAMETER INSTANCE = ddr2_controller_', dimm, '\n'];
str = [str, ' PARAMETER HW_VER = 2.00.a\n'];
str = [str, ' PARAMETER DIMM = ', dimm, '\n'];
str = [str, ' PARAMETER BANK_MANAGEMENT = ', bank_mgt, '\n'];
str = [str, ' BUS_INTERFACE DDR2_USER  = ddr2_user_dimm', dimm, '_ctrl\n'];
str = [str, ' BUS_INTERFACE DDR2_SYS   = ddr2_sys', num2str(str2num(dimm)-1), '\n'];
str = [str, ' PORT pad_rst_dqs_div_in  = dimm', dimm, '_rst_dqs_div_in\n'];
str = [str, ' PORT pad_rst_dqs_div_out = dimm', dimm, '_rst_dqs_div_out\n'];
str = [str, ' PORT pad_cke             = dimm', dimm, '_cke\n'];
str = [str, ' PORT pad_clk0            = dimm', dimm, '_clk0\n'];
str = [str, ' PORT pad_clk0b           = dimm', dimm, '_clk0b\n'];
str = [str, ' PORT pad_clk1            = dimm', dimm, '_clk1\n'];
str = [str, ' PORT pad_clk1b           = dimm', dimm, '_clk1b\n'];
str = [str, ' PORT pad_clk2            = dimm', dimm, '_clk2\n'];
str = [str, ' PORT pad_clk2b           = dimm', dimm, '_clk2b\n'];
str = [str, ' PORT pad_csb             = dimm', dimm, '_csb\n'];
str = [str, ' PORT pad_casb            = dimm', dimm, '_casb\n'];
str = [str, ' PORT pad_rasb            = dimm', dimm, '_rasb\n'];
str = [str, ' PORT pad_web             = dimm', dimm, '_web\n'];
str = [str, ' PORT pad_ODT             = dimm', dimm, '_ODT\n'];
str = [str, ' PORT pad_address         = dimm', dimm, '_address\n'];
str = [str, ' PORT pad_ba              = dimm', dimm, '_ba\n'];
str = [str, ' PORT pad_dm              = dimm', dimm, '_dm\n'];
str = [str, ' PORT pad_dqs             = dimm', dimm, '_dqs\n'];
str = [str, ' PORT pad_dq              = dimm', dimm, '_dq\n'];
str = [str, 'END\n'];
str = [str, 'PORT dimm', dimm, '_rst_dqs_div_in = dimm', dimm, '_rst_dqs_div_in, DIR = I\n'];
str = [str, 'PORT dimm', dimm, '_rst_dqs_div_out = dimm', dimm, '_rst_dqs_div_out, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_cke = dimm', dimm, '_cke, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_clk0 = dimm', dimm, '_clk0, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_clk0b = dimm', dimm, '_clk0b, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_clk1 = dimm', dimm, '_clk1, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_clk1b = dimm', dimm, '_clk1b, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_clk2 = dimm', dimm, '_clk2, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_clk2b = dimm', dimm, '_clk2b, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_csb = dimm', dimm, '_csb, VEC = [1:0], DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_casb = dimm', dimm, '_casb, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_rasb = dimm', dimm, '_rasb, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_web = dimm', dimm, '_web, DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_ODT = dimm', dimm, '_ODT, VEC = [1:0], DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_address = dimm', dimm, '_address, VEC = [13:0], DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_ba = dimm', dimm, '_ba, VEC = [1:0], DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_dm = dimm', dimm, '_dm, VEC = [8:0], DIR = O\n'];
str = [str, 'PORT dimm', dimm, '_dqs = dimm', dimm, '_dqs, VEC = [8:0], DIR = IO\n'];
str = [str, 'PORT dimm', dimm, '_dq = dimm', dimm, '_dq, VEC = [71:0], DIR = IO\n'];
