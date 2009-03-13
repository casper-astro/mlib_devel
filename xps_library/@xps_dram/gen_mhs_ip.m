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

ip_name        = get(blk_obj,'ip_name');
interfaces     = get(blk_obj,'interfaces');
misc_ports     = get(blk_obj,'misc_ports');
range_plb      = get(blk_obj,'plb_address_offset');
hw_sys         = get(blk_obj,'hw_sys');
clk_freq       = get(blk_obj,'clk_freq');
inst_name      = clear_name(get(blk_obj,'simulink_name'));
xsg_obj        = get(blk_obj,'xsg_obj');
dimm           = num2str(get(blk_obj,'dimm'));
half_burst     = get(blk_obj,'half_burst');
wide_data      = get(blk_obj,'wide_data');
bank_mgt       = get(blk_obj,'bank_mgt');
skinny_buffers = get(blk_obj,'skinny_buffers');
disable_tag    = get(blk_obj,'disable_tag');
use_sniffer    = get(blk_obj,'use_sniffer'); 

bram_fifos = '1';
if strcmp(skinny_buffers,'1') 
  bram_fifos = '0';
end

% Generate 'infrastructure' MHS entry

switch hw_sys
   case 'ROACH'
     str = [str, 'BEGIN dram_infrastructure',                      '\n'];
     str = [str, ' PARAMETER INSTANCE = dram_infrastructure_inst', '\n'];
     str = [str, ' PARAMETER HW_VER   = 1.00.a',                   '\n'];
     str = [str, ' PARAMETER CLK_FREQ = ', num2str(clk_freq),      '\n'];
     str = [str, ' BUS_INTERFACE DRAM_SYS = dram_sys',             '\n'];
     str = [str, ' PORT reset         = sys_reset',                '\n'];
     str = [str, ' PORT clk_in        = dly_clk',                  '\n'];
     str = [str, ' PORT clk_in_locked = 0b1',                      '\n'];
     str = [str, ' PORT clk_out       = dram_user_clk',            '\n'];
     str = [str, 'END\n'];
     str = [str, '\n'];
   otherwise % case BEE2*
end % switch hw_sys

% Generate 'controller' MHS entry

switch hw_sys
   case 'ROACH'
     str = [str, 'BEGIN dram_controller',                          '\n'];
     str = [str, ' PARAMETER INSTANCE = dram_controller_inst',     '\n'];
     str = [str, ' PARAMETER HW_VER   = 1.00.a',                   '\n'];
     str = [str, ' PARAMETER CLK_FREQ = ', num2str(clk_freq),      '\n'];
     str = [str, ' BUS_INTERFACE DRAM_USER = dram_ctrl',           '\n'];
     str = [str, ' BUS_INTERFACE DRAM_SYS  = dram_sys',            '\n'];
     str = [str, ' PORT phy_rdy      = ', inst_name, '_phy_ready', '\n'];
     str = [str, ' PORT dram_ck      = dram_ck',                   '\n'];
     str = [str, ' PORT dram_ck_n    = dram_ck_n',                 '\n'];
     str = [str, ' PORT dram_a       = dram_a',                    '\n'];
     str = [str, ' PORT dram_ba      = dram_ba',                   '\n'];
     str = [str, ' PORT dram_ras_n   = dram_ras_n',                '\n'];
     str = [str, ' PORT dram_cas_n   = dram_cas_n',                '\n'];
     str = [str, ' PORT dram_we_n    = dram_we_n',                 '\n'];
     str = [str, ' PORT dram_cs_n    = dram_cs_n',                 '\n'];
     str = [str, ' PORT dram_cke     = dram_cke',                  '\n'];
     str = [str, ' PORT dram_odt     = dram_odt',                  '\n'];
     str = [str, ' PORT dram_dm      = dram_dm',                   '\n'];
     str = [str, ' PORT dram_dqs     = dram_dqs',                  '\n'];
     str = [str, ' PORT dram_dqs_n   = dram_dqs_n',                '\n'];
     str = [str, ' PORT dram_dq      = dram_dq',                   '\n'];
     str = [str, ' PORT dram_reset_n = dram_reset_n',              '\n'];
     str = [str, 'END\n'];
     str = [str, 'PORT dram_ck      = dram_ck,      DIR = O,  VEC = [2:0]',  '\n'];
     str = [str, 'PORT dram_ck_n    = dram_ck_n,    DIR = O,  VEC = [2:0]',  '\n'];
     str = [str, 'PORT dram_a       = dram_a,       DIR = O,  VEC = [15:0]', '\n'];
     str = [str, 'PORT dram_ba      = dram_ba,      DIR = O,  VEC = [2:0]',  '\n'];
     str = [str, 'PORT dram_ras_n   = dram_ras_n,   DIR = O',                '\n'];
     str = [str, 'PORT dram_cas_n   = dram_cas_n,   DIR = O',                '\n'];
     str = [str, 'PORT dram_we_n    = dram_we_n,    DIR = O',                '\n'];
     str = [str, 'PORT dram_cs_n    = dram_cs_n,    DIR = O,  VEC = [1:0]',  '\n'];
     str = [str, 'PORT dram_cke     = dram_cke,     DIR = O,  VEC = [1:0]',  '\n'];
     str = [str, 'PORT dram_odt     = dram_odt,     DIR = O,  VEC = [1:0]',  '\n'];
     str = [str, 'PORT dram_dm      = dram_dm,      DIR = O,  VEC = [8:0]',  '\n'];
     str = [str, 'PORT dram_dqs     = dram_dqs,     DIR = IO, VEC = [8:0]',  '\n'];
     str = [str, 'PORT dram_dqs_n   = dram_dqs_n,   DIR = IO, VEC = [8:0]',  '\n'];
     str = [str, 'PORT dram_dq      = dram_dq,      DIR = IO, VEC = [71:0]', '\n'];
     str = [str, 'PORT dram_reset_n = dram_reset_n, DIR = O',                '\n'];
     str = [str, '\n'];

   otherwise % case BEE2*
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
     str = [str, '\n'];
end % switch hw_sys

% Generate 'sniffer' MHS entry

switch hw_sys
   case 'ROACH'
     str = [str, 'BEGIN opb_dram_sniffer',                                   '\n'];
     str = [str, ' PARAMETER INSTANCE = opb_dram_sniffer_inst',              '\n'];
     str = [str, ' PARAMETER HW_VER = 1.00.a',                               '\n'];
     str = [str, ' PARAMETER CTRL_C_BASEADDR = 0x00050000',                  '\n'];
     str = [str, ' PARAMETER CTRL_C_HIGHADDR = 0x0005FFFF',                  '\n'];
     str = [str, ' PARAMETER MEM_C_BASEADDR  = 0x04000000',                  '\n'];
     str = [str, ' PARAMETER MEM_C_HIGHADDR  = 0x07FFFFFF',                  '\n'];
     str = [str, ' PARAMETER ENABLE          = ', use_sniffer,               '\n'];
     str = [str, ' BUS_INTERFACE SOPB_CTRL = opb0',                          '\n'];
     str = [str, ' BUS_INTERFACE SOPB_MEM  = opb0',                          '\n'];
     str = [str, ' BUS_INTERFACE DRAM_CTRL = dram_ctrl',                     '\n'];
     str = [str, ' BUS_INTERFACE DRAM_APP  = dram_user_dimm', dimm,'_async', '\n'];
     str = [str, ' PORT dram_clk  = dram_user_clk',                          '\n'];
     str = [str, ' PORT dram_rst  = dram_user_reset',                        '\n'];
     str = [str, ' PORT phy_ready = ', inst_name, '_phy_ready',              '\n'];
     str = [str, 'END',                                                      '\n'];
     str = [str,                                                             '\n'];

   otherwise % case BEE2*
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
     str = [str, '\n'];

end % switch hw_sys

% Generate 'async_ddr' MHS entry

switch hw_sys
   case 'ROACH'
     str = [str, 'BEGIN async_dram\n'];
     str = [str, ' PARAMETER INSTANCE      = async_dram_', dimm,              '\n'];
     str = [str, ' PARAMETER HW_VER        = 1.00.a',                         '\n'];
     str = [str, ' PARAMETER C_WIDE_DATA   = ', wide_data,                    '\n'];
     str = [str, ' PARAMETER C_HALF_BURST  = ', half_burst,                   '\n'];
     str = [str, ' PARAMETER BRAM_FIFOS    = ', bram_fifos,                   '\n'];
     str = [str, ' PARAMETER TAG_BUFFER_EN = ', disable_tag,                  '\n'];
     str = [str, ' BUS_INTERFACE MEM_CMD   = ', inst_name, '_MEM_CMD',        '\n'];
     str = [str, ' BUS_INTERFACE DRAM_USER = dram_user_dimm', dimm, '_async', '\n'];
     str = [str, ' PORT Mem_Clk            = ', get(xsg_obj, 'clk_src'),      '\n'];
     str = [str, ' PORT Mem_Rst            = ', inst_name, '_Mem_Rst',        '\n'];
     str = [str, ' PORT dram_clk           = dram_user_clk',                  '\n'];
     str = [str, ' PORT dram_reset         = dram_user_reset',                '\n'];
     str = [str, 'END\n'];
     str = [str, '\n'];
   otherwise % case BEE2*
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
end % switch hw_sys

