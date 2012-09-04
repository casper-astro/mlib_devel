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

xaui_port   = get(blk_obj, 'port');
hw_sys      = get(blk_obj, 'hw_sys');

[str,opb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj.xps_block, opb_addr_start, opb_name);
str = [str, '\n'];

switch hw_sys
    case {'ROACH'}

        mgt_clk_num = num2str(floor(str2num(xaui_port)/2)); 

        str = [str, 'BEGIN xaui_phy',                                   '\n'];
        str = [str, '  PARAMETER INSTANCE = xaui_phy_', xaui_port,      '\n'];
        str = [str, '  PARAMETER HW_VER = 1.00.a',                      '\n'];
        str = [str, '  PARAMETER USE_KAT_XAUI = 0',                     '\n'];
        str = [str, '  BUS_INTERFACE XAUI_SYS = xaui_sys', xaui_port,   '\n'];
        str = [str, '  BUS_INTERFACE XGMII    = xgmii', xaui_port,      '\n'];
        str = [str, '  PORT reset   = sys_reset'            ,           '\n'];
        str = [str, '  PORT mgt_clk = mgt_clk_', mgt_clk_num,           '\n'];
        str = [str, 'END',                                              '\n'];
    % end case {'ROACH'}
    case {'ROACH2'}
        str = [str, 'BEGIN xaui_phy',                                   '\n'];
        str = [str, '  PARAMETER INSTANCE = xaui_phy_', xaui_port,      '\n'];
        str = [str, '  PARAMETER HW_VER = 1.00.a',                      '\n'];
        str = [str, '  BUS_INTERFACE XAUI_SYS = xaui_sys', xaui_port,   '\n']; 
        str = [str, '  BUS_INTERFACE XAUI_CONF = xaui_conf', xaui_port, '\n']; 
        str = [str, '  BUS_INTERFACE XGMII    = xgmii', xaui_port,      '\n']; 
        str = [str, '  PORT reset   = sys_reset'            ,           '\n'];
        str = [str, '  PORT xaui_clk = xaui_clk',                       '\n']; %from xaui_infrastructure
        str = [str, 'END',                                              '\n'];
    % end case {'ROACH'}
    otherwise
    % end otherwise
end % switch hw_sys
