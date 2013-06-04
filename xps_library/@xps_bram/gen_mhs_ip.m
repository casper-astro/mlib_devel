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
opb_addr_end = opb_addr_start;

data_width      = blk_obj.data_width;
addr_width      = blk_obj.addr_width;
portb_width     = addr_width + log2(data_width/32);
optimization    = blk_obj.optimization;
reg_core_output = blk_obj.reg_core_output;
reg_prim_output = blk_obj.reg_prim_output;
num_we = data_width/8;

inst_name = clear_name(get(blk_obj,'simulink_name'));
xsg_obj = get(blk_obj,'xsg_obj');
if (data_width == 32 && strcmpi(reg_core_output,'false') && strcmpi(reg_prim_output,'false'))
  % Use the non-coregen scheme for the 32 bit case which is a lot faster.
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
else
  % Use the bram_block_custom block which calls coregen to generate multiport bram netlist
  str = [str, 'BEGIN bram_block_custom\n'];
  str = [str, ' PARAMETER INSTANCE = ',inst_name,'_ramblk\n'];
  str = [str, ' PARAMETER HW_VER = 1.00.a\n'];

  str = [str, ' PARAMETER C_PORTA_DWIDTH   = ', num2str(data_width),  '\n'];
  str = [str, ' PARAMETER C_PORTA_NUM_WE   = ', num2str(num_we),      '\n'];
  str = [str, ' PARAMETER C_PORTA_DEPTH    = ', num2str(addr_width),  '\n'];
  str = [str, ' PARAMETER C_PORTB_DEPTH    = ', num2str(portb_width), '\n'];
  str = [str, ' PARAMETER OPTIMIZATION     = ', optimization,         '\n'];
  str = [str, ' PARAMETER REG_CORE_OUTPUT  = ', reg_core_output,      '\n'];
  str = [str, ' PARAMETER REG_PRIM_OUTPUT  = ', reg_prim_output,      '\n'];

  str = [str, ' PORT clk           = ',get(xsg_obj,'clk_src'),'\n'];
  str = [str, ' PORT bram_addr     = ',inst_name,'_addr    \n'];
  str = [str, ' PORT bram_rd_data  = ',inst_name,'_data_out\n'];
  str = [str, ' PORT bram_wr_data  = ',inst_name,'_data_in \n'];
  str = [str, ' PORT bram_we       = ',inst_name,'_we      \n'];

  str = [str, ' BUS_INTERFACE PORTB = ',inst_name,'_ramblk_portb\n'];
  str = [str, 'END\n\n'];
end

% need to calculate address range based on the portb (ie cpu) width
% as this can vary depending on port widths
opb_addr_start = ceil(opb_addr_start / (4*2^portb_width))*4*2^portb_width;
str = [str, 'BEGIN opb_bram_if_cntlr\n'];
str = [str, ' PARAMETER INSTANCE = ',inst_name,'\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
str = [str, ' PARAMETER C_OPB_CLK_PERIOD_PS = 10000\n'];
str = [str, ' PARAMETER C_BASEADDR = 0x',dec2hex(opb_addr_start,32/4),'\n'];
str = [str, ' PARAMETER C_HIGHADDR = 0x',dec2hex(opb_addr_start+4*2^portb_width-1,(32/4)),'\n'];
str = [str, ' BUS_INTERFACE SOPB = ',opb_name,'\n'];
opb_addr_end = opb_addr_start + 4*2^portb_width;

str = [str, ' BUS_INTERFACE PORTA = ',inst_name,'_ramblk_portb\n'];
str = [str, 'END\n\n'];

set(blk_obj,'borph_info.base_address', opb_addr_start);
