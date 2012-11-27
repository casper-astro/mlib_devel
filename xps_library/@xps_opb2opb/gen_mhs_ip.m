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
function [str,opb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj,opb_addr_start,opb_name)


str = '';

%does not affect the allocation of address space
opb_addr_end = opb_addr_start;

opb_name = blk_obj.opb_name;
opb_addr_start = blk_obj.opb_addr_start;
addr_size = blk_obj.addr_size;

try
    opb_clk = blk_obj.opb_clk;
catch
    opb_clk = 'epb_clk';
end

opb_slave = 'opb0';

str = [str, 'BEGIN opb_v20\n'];
str = [str, ' PARAMETER INSTANCE = ',opb_name,'\n'];
str = [str, ' PARAMETER HW_VER = 1.10.c\n'];
str = [str, ' PARAMETER C_EXT_RESET_HIGH = 1\n'];
str = [str, ' PORT SYS_Rst = sys_reset\n'];
str = [str, ' PORT OPB_Clk = ', opb_clk, '\n'];
str = [str, 'END\n'];
str = [str, '\n'];
str = [str, 'BEGIN opb_opb_lite\n'];
str = [str, ' PARAMETER INSTANCE = opb2opb_bridge_',opb_name,'\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
str = [str, ' PARAMETER C_NUM_DECODES  = 1\n'];
str = [str, ' PARAMETER C_DEC0_BASEADDR = 0x',dec2hex(opb_addr_start,8),'\n'];
str = [str, ' PARAMETER C_DEC0_HIGHADDR = 0x',dec2hex(opb_addr_start+addr_size-1,8),'\n'];
str = [str, ' BUS_INTERFACE SOPB = ',opb_slave,'\n'];
str = [str, ' BUS_INTERFACE MOPB = ',opb_name,'\n'];
str = [str, ' PORT MOPB_Clk = ', opb_clk, '\n'];
str = [str, ' PORT SOPB_Clk = ', opb_clk, '\n'];
str = [str, 'END\n'];
