%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

function b = xps_xsg(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_PPC class requires a xps_block class object');
end % if ~isa(blk_obj,'xps_block')

if ~strcmp(get(blk_obj,'type'),'xps_xsg')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end % if ~strcmp(get(blk_obj,'type'),'xps_xsg')

blk_name = get(blk_obj,'simulink_name');

[hw_sys, hw_subsys] = xps_get_hw_plat(get_param(blk_name,'hw_sys'));

s.hw_sys = hw_sys;
s.hw_subsys = hw_subsys;

supp_ip_names = {};
supp_ip_versions = {};

switch s.hw_sys
	case 'ROACH'
	    s.sw_os = 'none';
    % end case 'ROACH'

	case 'ROACH2'
	    s.sw_os = 'none';
    % end case 'ROACH2'

  otherwise
  		error(['Unsupported Platform: ',s.hw_sys]);
end % switch s.hw_sys

s.clk_src    = get_param(blk_name,'clk_src');
s.clk90_src  = [s.clk_src,'90'];
s.clk180_src = [s.clk_src,'180'];
s.clk270_src = [s.clk_src,'270'];
s.clk_rate   = eval_param(blk_name,'clk_rate');

b = class(s,'xps_xsg',blk_obj);

b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.clk_rate*1e6));
