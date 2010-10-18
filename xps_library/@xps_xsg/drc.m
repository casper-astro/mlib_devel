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

function [result,msg] = drc(blk_obj, xps_objs)
result = 0;
msg = '';

%check hw_sys consistancy
hw_sys = get(blk_obj,'hw_sys');
for i=1:length(xps_objs)
    tmp = get(xps_objs{i},'hw_sys');
    if ~strcmp(hw_sys,tmp) & ~strcmp(tmp,'any') & isempty(strfind(hw_sys,tmp))
        result = 1;
        msg = ['Block ',get(xps_objs{i},'simulink_name'),' has an inconsistent hardware platform: ',tmp];
        return;
    end
end

clk_src = get(blk_obj,'clk_src');
if strcmp(hw_sys,'CORR')
	if strcmp(clk_src,'usr_clk') || strcmp(clk_src,'usr_clk2x')
        msg = ['Cannot use usr_clk or usr_clk2x on the CORR',tmp];
        return;
	end
end