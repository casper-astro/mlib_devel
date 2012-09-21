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

[hw_sys, hw_subsys] = xps_get_hw_plat(get_param(gcb,'hw_sys'));
clk_src = get_param(gcb, [hw_sys, '_clk_src']);
syn_tool = get_param(gcb, 'synthesis_tool');

set_param(gcb, 'clk_src', clk_src);

ngc_config.include_clockwrapper = 1;
ngc_config.include_cf = 0;

switch hw_sys
    case 'ROACH'
        switch hw_subsys
            case 'lx110t'
                xlsetparam(xsg_blk,'xilinxfamily', 'Virtex5',...
                    'part', 'xc5vlx110t',...
                    'speed', '-1',...
                    'testbench', 'off',...
                    'package', 'ff1136');
            % end case 'lx110t'

            case 'sx95t'
                xlsetparam(xsg_blk,'xilinxfamily', 'Virtex5',...
                    'part', 'xc5vsx95t',...
                    'speed', '-1',...
                    'testbench', 'off',...
                    'package', 'ff1136');
            % end case 'sx95t'
        end % switch hw_subsys

    % end case 'ROACH
    case 'ROACH2'
        switch hw_subsys
            case 'sx475t'
                xlsetparam(xsg_blk,'xilinxfamily', 'Virtex6',...
                    'part', 'xc6vsx475t',...
                    'speed', '-1',...
                    'testbench', 'off',...
                    'package', 'ff1759');
            % end case 'lx110t'
        end % switch hw_subsys
    % end case 'ROACH2'
    
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

xlsetparam(xsg_blk,'clock_loc','d7hack')

switch clk_src
    case {'sys_clk' 'sys_clk2x'}
    case {'usr_clk' 'usr_clk2x'}
        if (strcmp(hw_sys,{'ROACH', 'ROACH2'}))
            errordlg(['Invalid clock source ',clk_src,' for hardware platform: ',hw_sys]);
        end
    case {'aux_clk'}
        if isempty(find(strcmp(hw_sys,{'ROACH2'})))
            errordlg(['Invalid clock source ',clk_src,' for hardware platform: ',hw_sys]);
        end
    case {'aux0_clk' 'aux1_clk' 'aux0_clk2x' 'aux1_clk2x' 'arb_clk'}
        if isempty(find(strcmp(hw_sys,{'ROACH'})))
            errordlg(['Invalid clock source ',clk_src,' for hardware platform: ',hw_sys]);
        end
    case {'adc0_clk' 'adc1_clk' 'dac0_clk' 'dac1_clk'}
        if isempty(find(strcmp(hw_sys,{'ROACH', 'ROACH2'})))
            errordlg(['Invalid clock source ',clk_src,' for hardware platform: ',hw_sys]);
        end
    otherwise
        errordlg(['Unsupported clock source: ',clk_src]);
end
