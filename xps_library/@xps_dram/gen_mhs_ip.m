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
fprintf('Calling DRAM function...')

str = '';
opb_addr_end = opb_addr_start;

ip_name        = get(blk_obj,'ip_name');
interfaces     = get(blk_obj,'interfaces');
misc_ports     = get(blk_obj,'misc_ports');
hw_sys         = get(blk_obj,'hw_sys');
clk_freq       = get(blk_obj,'clk_freq');
inst_name      = clear_name(get(blk_obj,'simulink_name'));
xsg_obj        = get(blk_obj,'xsg_obj');
fprintf('Looking for dimm number...')
dimm           = num2str(get(blk_obj,'dimm'));
half_burst     = get(blk_obj,'half_burst');
wide_data      = get(blk_obj,'wide_data');
bank_mgt       = get(blk_obj,'bank_mgt');
bram_fifos     = get(blk_obj,'bram_fifos');
disable_tag    = get(blk_obj,'disable_tag');
use_sniffer    = get(blk_obj,'use_sniffer'); 

% Generate 'infrastructure' MHS entry

switch hw_sys
   case {'ROACH', 'ROACH2'}
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
   otherwise % case ROACH/ROACH2*
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
end % switch hw_sys

% Generate 'sniffer' MHS entry

switch hw_sys
   case {'ROACH', 'ROACH2'}
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

end % switch hw_sys

% Generate 'async_ddr' MHS entry

switch hw_sys
   case {'ROACH', 'ROACH2'}
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
end % switch hw_sys

