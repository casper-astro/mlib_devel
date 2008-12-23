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

sysgen_blk = find_system(gcs, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','genX');
if length(sysgen_blk) == 1
    xsg_blk = sysgen_blk{1};
else
    error('XPS block must be on the same level as the Xilinx SysGen block');
end

hw_sys = get_param(gcb,'hw_sys');
clk_src = get_param(gcb, [hw_sys, '_clk_src']);
syn_tool = get_param(gcb, 'synthesis_tool');

set_param(gcb, 'clk_src', clk_src);

ngc_config.include_clockwrapper = 1;
ngc_config.include_cf = 0;

switch hw_sys
    case 'iBOB'
        xlsetparam(xsg_blk,'xilinxfamily', 'Virtex2P',...
            'part', 'xc2vp50',...
            'speed', '-7',...
            'testbench', 'off',...
            'package', 'ff1152');
        set_param(gcb,'mpc_type','powerpc405');
    % end case 'iBOB'
    case 'CORR'
        xlsetparam(xsg_blk,'xilinxfamily', 'Virtex2P',...
            'part', 'xc2vp20',...
            'speed', '-6',...
            'testbench', 'off',...
            'package', 'ff896');
        set_param(gcb,'mpc_type','powerpc405');
    % end case 'CORR'
    case 'BEE2_ctrl'
        xlsetparam(xsg_blk,'xilinxfamily', 'Virtex2P',...
            'part', 'xc2vp70',...
            'speed', '-7',...
            'testbench', 'off',...
            'package', 'ff1704');
        set_param(gcb,'mpc_type','powerpc405');
    % end case 'BEE2_ctrl'
    case 'BEE2_usr'
        xlsetparam(xsg_blk,'xilinxfamily', 'Virtex2P',...
            'part', 'xc2vp70',...
            'speed', '-7',...
            'testbench', 'off',...
            'package', 'ff1704');
        set_param(gcb,'mpc_type','powerpc405');
    % end case 'BEE2_usr'
    case 'ML402'
        xlsetparam(xsg_blk,'xilinxfamily', 'Virtex4',...
            'part', 'xc4vsx35',...
            'speed', '-10',...
            'testbench', 'off',...
            'package', 'ff668');
        set_param(gcb,'mpc_type','microblaze');
    % end case 'ML402'
    case 'ROACH'
        xlsetparam(xsg_blk,'xilinxfamily', 'Virtex5',...
            'part', 'xc5vlx110t',...
            'speed', '-1',...
            'testbench', 'off',...
            'package', 'ff1136');
        set_param(gcb,'mpc_type','powerpc440_ext');
    % end case 'ROACH'
    otherwise
        errordlg(['Unsupported hardware system: ',hw_sys]);
    % end 'otherwise'
end % switch hw_sys

xlsetparam(xsg_blk,...
    'directory', ['./',clear_name(get_param(gcb,'parent')),'/sysgen'],...
    'sysclk_period', num2str(1000/clk_rate),...
    'compilation', 'NGC Netlist',...
    'ngc_config',ngc_config,...
    'synthesis_language', 'VHDL');

if strcmp(syn_tool, 'Leonardo Spectrum')
    xlsetparam(xsg_blk, 'synthesis_tool', 'Spectrum');
else
    xlsetparam(xsg_blk, 'synthesis_tool', syn_tool)
end

switch clk_src
    case {'sys_clk' 'sys_clk2x'}
    case {'usr_clk' 'usr_clk2x'}
        if regexp(hw_sys,'^CORR')
            errordlg(['Invalid clock source (',clk_src,'for hardware platform: ',hw_sys]);
        end
    case {'adc0_clk' 'adc1_clk' 'dac0_clk' 'dac1_clk'}
        if isempty(find(strcmp(hw_sys,{'iBOB', 'ROACH'})))
            errordlg(['Invalid clock source (',clk_src,'for hardware platform: ',hw_sys]);
        end
    otherwise
        errordlg(['Unsupported clock source: ',clk_src]);
end
