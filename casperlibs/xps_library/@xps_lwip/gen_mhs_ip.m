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

str = [str, 'BEGIN plb_sram\n'];
str = [str, ' PARAMETER INSTANCE = plb_sram_0\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
str = [str, ' PARAMETER C_AR0_BASEADDR = 0x00000000\n'];
str = [str, ' PARAMETER C_AR0_HIGHADDR = 0x001FFFFF\n'];
str = [str, ' BUS_INTERFACE SPLB = plb\n'];
str = [str, ' PORT pads_address = sram0_address\n'];
str = [str, ' PORT pads_bw_b = sram0_bw_b\n'];
str = [str, ' PORT pads_we_b = sram0_we_b\n'];
str = [str, ' PORT pads_adv_ld_b = sram0_adv_ld_b\n'];
str = [str, ' PORT pads_clk = sram0_clk\n'];
str = [str, ' PORT pads_ce = sram0_ce\n'];
str = [str, ' PORT pads_oe_b = sram0_oe_b\n'];
str = [str, ' PORT pads_cen_b = sram0_cen_b\n'];
str = [str, ' PORT pads_dq = sram0_dq\n'];
str = [str, ' PORT pads_mode = sram0_mode\n'];
str = [str, ' PORT pads_zz = sram0_zz\n'];
str = [str, 'END\n'];
str = [str, 'PORT sram0_address = sram0_address, DIR = out, VEC = [18:0]\n'];
str = [str, 'PORT sram0_bw_b = sram0_bw_b, DIR = out, VEC = [3:0]\n'];
str = [str, 'PORT sram0_we_b = sram0_we_b, DIR = out\n'];
str = [str, 'PORT sram0_adv_ld_b = sram0_adv_ld_b, DIR = out\n'];
str = [str, 'PORT sram0_clk = sram0_clk, DIR = out\n'];
str = [str, 'PORT sram0_ce = sram0_ce, DIR = out\n'];
str = [str, 'PORT sram0_oe_b = sram0_oe_b, DIR = out\n'];
str = [str, 'PORT sram0_cen_b = sram0_cen_b, DIR = out\n'];
str = [str, 'PORT sram0_dq = sram0_dq, DIR = inout, VEC = [35:0]\n'];
str = [str, 'PORT sram0_mode = sram0_mode, DIR = out\n'];
str = [str, 'PORT sram0_zz = sram0_zz, DIR = out\n'];
