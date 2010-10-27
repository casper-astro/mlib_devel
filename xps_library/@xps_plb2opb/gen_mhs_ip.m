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
function [str,opb_addr_end,plb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj,opb_addr_start,plb_addr_start,plb_name,opb_name)

str = '';
opb_addr_end = opb_addr_start;
plb_addr_end = plb_addr_start;

opb_name = blk_obj.opb_name;
opb_addr_start = blk_obj.opb_addr_start;
addr_size = blk_obj.addr_size;

try
    opb_clk = blk_obj.opb_clk;
catch
    opb_clk = '';
end

try
    plb_clk = blk_obj.plb_clk;
catch
    plb_clk = '';
end

if isempty(opb_clk)
    opb_clk = 'sys_clk';
end

if isempty(plb_clk)
    plb_clk = 'sys_clk';
end

str = [str, 'BEGIN opb_v20\n'];
str = [str, ' PARAMETER INSTANCE = ',opb_name,'\n'];
str = [str, ' PARAMETER HW_VER = 1.10.c\n'];
str = [str, ' PARAMETER C_EXT_RESET_HIGH = 1\n'];
str = [str, ' PORT SYS_Rst = sys_bus_reset\n'];
str = [str, ' PORT OPB_Clk = ', opb_clk, '\n'];
str = [str, 'END\n'];
str = [str, '\n'];
str = [str, 'BEGIN plb2opb_bridge\n'];
str = [str, ' PARAMETER INSTANCE = plb2opb_bridge_',opb_name,'\n'];
str = [str, ' PARAMETER HW_VER = 1.01.a\n'];
str = [str, ' PARAMETER C_DCR_INTFCE = 0\n'];
str = [str, ' PARAMETER C_NUM_ADDR_RNG = 1\n'];
str = [str, ' PARAMETER C_RNG0_BASEADDR = 0x',dec2hex(opb_addr_start),'\n'];
str = [str, ' PARAMETER C_RNG0_HIGHADDR = 0x',dec2hex(opb_addr_start+addr_size-1),'\n'];
str = [str, ' BUS_INTERFACE SPLB = ',plb_name,'\n'];
str = [str, ' BUS_INTERFACE MOPB = ',opb_name,'\n'];
str = [str, ' PORT PLB_Clk = ', plb_clk, '\n'];
str = [str, ' PORT OPB_Clk = ', opb_clk, '\n'];
str = [str, 'END\n'];
