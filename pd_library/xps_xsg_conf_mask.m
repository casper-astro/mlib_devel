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

sysgen_blk = find_system(gcs, 'SearchDepth', 1, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'genX');
if length(sysgen_blk) == 1
    pd_blk = sysgen_blk{1};
else
    error('PD block must be on the same level as the Altera SysGen block');
end

[hw_sys, hw_subsys] = xps_get_hw_plat(get_param(gcb,'hw_sys'));
clk_src = get_param(gcb, 'clk_src');
syn_tool = get_param(gcb, 'synthesis_tool');

ngc_config.include_clockwrapper = 1;
ngc_config.include_cf = 0;

switch hw_sys
    case 'DE10NANO'
        disp('DANGUS')
        xlsetparam(pd_blk, 'intelfamily', 'Cyclone V',...
                'part', '5CSEBA6U23I7',...
                'speed', 'i7',...
                'testbench', 'off',...
                'package', 'ubga672');

    % end case 'DE10NANO'
    otherwise
        errordlg(['Unsupported hardware system: ', hw_sys]);
    % end 'otherwise'
end % switch hw_sys

xlsetparam(xsg_blk,...
    'sysclk_period', num2str(1000/clk_rate),...
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
            errordlg(['Invalid clock source ', clk_src, ' for hardware platform: ', hw_sys]);
        end
    case {'aux_clk'}
        if (strcmp(hw_sys,{'ROACH', 'ROACH2', 'SKARAB'}))
            errordlg(['Invalid clock source ', clk_src, ' for hardware platform: ', hw_sys]);
        end
    case {'aux0_clk' 'aux1_clk' 'aux0_clk2x' 'aux1_clk2x' 'arb_clk'}
        if isempty(find(strcmp(hw_sys,{'ROACH'}), 1))
            errordlg(['Invalid clock source ', clk_src, ' for hardware platform: ', hw_sys]);
        end
    case {'adc0_clk' 'adc1_clk' 'dac0_clk' 'dac1_clk'}
        if isempty(find(strcmp(hw_sys,{'ROACH', 'ROACH2', 'SNAP', 'MX175', 'SKARAB'}), 1))
            errordlg(['Invalid clock source ', clk_src, ' for hardware platform: ', hw_sys]);
        end
    case {'adc_clk'}
        if isempty(find(strcmp(hw_sys,{'MKDIG'}), 1))
            errordlg(['Invalid clock source ', clk_src, ' for hardware platform: ', hw_sys]);
        end
    otherwise
        errordlg(['Unsupported clock source: ', clk_src]);
end
