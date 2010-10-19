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
		if strcmp(get(blk_obj,'ila_number'),get(xps_objs{i},'ila_number'))
			if ~strcmp(get(blk_obj,'simulink_name'),get(xps_objs{i},'simulink_name'))
				msg = ['Probe ',get(blk_obj,'simulink_name'),' and probe ',get(xps_objs{i},'simulink_name'),' have the same ILA number.'];
				result = 1;
			end
		end
	end
end

nb_probes = 0;
max_ila_n = 0;
for i=1:length(xps_objs)
	if strcmp(get(xps_objs{i},'type'),'xps_probe')
		nb_probes = nb_probes + 1;
		ila_n = get(xps_objs{i},'ila_number');
		if ila_n > max_ila_n
			max_ila_n = ila_n;
		end
	end
end
if nb_probes ~= max_ila_n + 1
	msg = ['ILA numbers not organized correctly for the chipscope probes. They should be growing from 0 to ',num2str(nb_probes-1)];
	result = 1;
end

% EDK 7.1 limits the number of ILA probes to 1
if nb_probes ~= 1
	msg = 'Due to current implementation limitations in EDK 7.1, you can only use one probe in a design and it has to have the ILA number 0';
	result = 1;
end