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

inst_name = clear_name(get(blk_obj,'simulink_name'));
xsg_obj = get(blk_obj,'xsg_obj');

str = [str, 'BEGIN bram_if\n'];
str = [str, ' PARAMETER INSTANCE = ',inst_name,'_ramif\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
str = [str, ' PARAMETER ADDR_SIZE = ',num2str(blk_obj.addr_width) ,'\n'];
str = [str, ' BUS_INTERFACE PORTA = ',inst_name,'_ramblk_porta\n'];

str = [str, ' PORT clk_in   = ',get(xsg_obj,'clk_src'),'\n'];

str = [str, ' PORT addr     = ',inst_name,'_addr    \n'];
str = [str, ' PORT data_in  = ',inst_name,'_data_in \n'];
str = [str, ' PORT data_out = ',inst_name,'_data_out\n'];
str = [str, ' PORT we       = ',inst_name,'_we      \n'];

str = [str, 'END\n\n'];


str = [str, 'BEGIN bram_block\n'];
str = [str, ' PARAMETER INSTANCE = ',inst_name,'_ramblk\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
str = [str, ' BUS_INTERFACE PORTA = ',inst_name,'_ramblk_porta\n'];
str = [str, ' BUS_INTERFACE PORTB = ',inst_name,'_ramblk_portb\n'];
str = [str, 'END\n\n'];

opb_addr_start = ceil(opb_addr_start / (4*2^blk_obj.addr_width))*4*2^blk_obj.addr_width;
str = [str, 'BEGIN opb_bram_if_cntlr\n'];
str = [str, ' PARAMETER INSTANCE = ',inst_name,'\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
str = [str, ' PARAMETER C_OPB_CLK_PERIOD_PS = 10000\n'];
str = [str, ' PARAMETER C_BASEADDR = 0x',dec2hex(opb_addr_start),'\n'];
str = [str, ' PARAMETER C_HIGHADDR = 0x',dec2hex(opb_addr_start+4*2^blk_obj.addr_width-1),'\n'];
str = [str, ' BUS_INTERFACE SOPB = ',opb_name,'\n'];
opb_addr_end = opb_addr_start + 4*2^blk_obj.addr_width;

str = [str, ' BUS_INTERFACE PORTA = ',inst_name,'_ramblk_portb\n'];
str = [str, 'END\n\n'];

set(blk_obj,'borph_info.base_address', opb_addr_start);
