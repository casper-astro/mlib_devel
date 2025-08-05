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

if ~strcmp(bdroot, 'pd_library')
    sysgen_blk = find_system(gcs, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','genX');
    if length(sysgen_blk) == 1
        pd_blk = sysgen_blk{1};
    else
        error('PD block must be on the same level as the Altera SysGen block');
    end

    [hw_sys, hw_subsys] = pd_get_hw_plat(get_param(gcb,'hw_sys'));
    clk_src = get_param(gcb, 'clk_src');
    syn_tool = get_param(gcb, 'synthesis_tool');
    clk_rate = 50; % MHz, assumes 50 MHz system clock

    %set_param(gcb, 'clk_src', clk_src);

    ngc_config.include_clockwrapper = 1;
    ngc_config.include_cf = 0;

    xlsetparam(pd_blk,'intelfamily', 'Cyclone V',...
        'part', '5CSEBA6U23I7',...
        'speed', 'i7',...
        'testbench', 'off',...
        'package', 'ubga672');


    xlsetparam(pd_blk,...
        'sysclk_period', num2str(1000/clk_rate),...
        'synthesis_language', 'VHDL');

    if strcmp(syn_tool, 'Leonardo Spectrum')
        xlsetparam(pd_blk, 'synthesis_tool', 'Spectrum');
    else
        xlsetparam(pd_blk, 'synthesis_tool', syn_tool)
    end
end
