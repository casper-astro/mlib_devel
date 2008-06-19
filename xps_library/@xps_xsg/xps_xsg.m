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

function b = xps_ppc(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_PPC class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_xsg')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
s.hw_sys = get_param(blk_name,'hw_sys');
s.ibob_linux = get_param(blk_name,'ibob_linux');
s.mpc_type = get_param(blk_name,'mpc_type');
switch s.hw_sys
	case 'CORR'
		s.sw_os = 'tinySH';
	case 'iBOB'
		s.sw_os = 'tinySH';
	case 'BEE2_ctrl'
		s.sw_os = 'tinySH';
	case 'BEE2_usr'
		s.sw_os = 'tinySH';
    otherwise
  		error(['Unsupported Platform: ',s.hw_sys]);
end
s.clk_src = get_param(blk_name,'clk_src');
s.clk90_src = [s.clk_src,'90'];
s.clk_rate = eval_param(blk_name,'clk_rate');

[s.gpioclk_hw_sys,s.gpioclk_grp] = xps_get_hw_info(get_param(blk_name,'gpio_clk_io_group'));
s.gpioclkbit = eval_param(blk_name,'gpio_clk_bit_index');

b = class(s,'xps_xsg',blk_obj);

if strcmp(s.hw_sys, 'iBOB') & ~isempty(strmatch('usr_clk', s.clk_src))
    if ~isempty(strmatch(s.gpioclk_grp, {'zdok0', 'zdok1', 'mdr'}));
        ext_ports.usrclk_in_p = {1 'in' 'usrclk_in_p' [s.gpioclk_hw_sys, '.', s.gpioclk_grp,'_p([',num2str(s.gpioclkbit),']+1)'] 'LVDS_25' 'vector=false'};
        ext_ports.usrclk_in_n = {1 'in' 'usrclk_in_n' [s.gpioclk_hw_sys, '.', s.gpioclk_grp,'_n([',num2str(s.gpioclkbit),']+1)'] 'LVDS_25' 'vector=false'};
    else
        ext_ports.usrclk_in = {1 'in' 'usrclk_in' [s.gpioclk_hw_sys, '.', s.gpioclk_grp,'([',num2str(s.gpioclkbit),']+1)'] 'LVCMOS25' 'vector=false'};
    end
    b = set(b,'ext_ports',ext_ports);
end
