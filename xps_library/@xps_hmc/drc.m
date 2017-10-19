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

for i=1:length(xps_objs)
	try
		if strcmp(get(blk_obj,'hw_qdr'),get(xps_objs{i},'hw_qdr'))
			if ~strcmp(get(blk_obj,'simulink_name'),get(xps_objs{i},'simulink_name'))
				msg = ['QDR ',get(blk_obj,'simulink_name'),' and QDR ',get(xps_objs{i},'simulink_name'),' are located on the same port.'];
				result = 1;
			end
		end
	end
end

if strcmp(get(blk_obj,'hw_sys'), 'ROACH')
	if ~(strcmp(get(blk_obj,'hw_qdr'),'qdr0') || strcmp(get(blk_obj,'hw_qdr'),'qdr1'))
		msg = ['QDR ',get(blk_obj,'simulink_name'), ' is located on port ',get(blk_obj,'hw_qdr'),'. This is not possible on ROACH 1, which only has 2 QDR ports (qdr0 & qdr1)'];
        result = 1;
    end
end

if strcmp(get(blk_obj,'hw_sys'), 'ROACH2')
	if ~(strcmp(get(blk_obj,'hw_qdr'),'qdr0') || strcmp(get(blk_obj,'hw_qdr'),'qdr1') || strcmp(get(blk_obj,'hw_qdr'),'qdr2') || strcmp(get(blk_obj,'hw_qdr'),'qdr3'))
		msg = ['QDR ',get(blk_obj,'simulink_name'), ' is located on port ',get(blk_obj,'hw_qdr'),'. This is not possible on ROACH 2, which only has 4 QDR ports (qdr0 & qdr1 & qdr2 & qdr3)'];
        result = 1;
    end
end


