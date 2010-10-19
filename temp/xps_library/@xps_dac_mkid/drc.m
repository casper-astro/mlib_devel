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
		if strcmp(get(blk_obj,'hw_dac'), get(xps_objs{i},'hw_dac'))
			if ~strcmp(get(blk_obj, 'simulink_name'), get(xps_objs{i},'simulink_name'))
				msg = ['DAC ', get(blk_obj, 'simulink_name'),' and DAC ', get(xps_objs{i}, 'simulink_name'), ' are using the same connector.'];
				result = 1;
			end
		end
	end

	try
		if strcmp(get(blk_obj,'type'),'xps_dac') && strcmp(get(xps_objs{i},'type'), 'xps_adc')
		    if (strcmp(get(blk_obj,'hw_dac'),'dac0') && strcmp(get(xps_objs{i},'hw_adc'),'adc0')) || (strcmp(get(blk_obj,'hw_dac'),'dac1') && strcmp(get(xps_objs{i},'hw_adc'),'adc1'))
		        msg = ['DAC ', get(blk_obj,'simulink_name'), ' and ADC ', get(xps_objs{i},'simulink_name'),' are located on the same Z-DOK connector.'];
		        result = 1;
		    end
		end
    end

	try
		if strcmp(get(blk_obj,'type'),'xps_dac') && strcmp(get(xps_objs{i},'type'), 'xps_vsi')
		    if strcmp(get(blk_obj,'hw_dac'),'dac1') && strcmp(get(xps_objs{i},'hw_vsi'),'ZDOK 1')
		        msg = ['DAC ', get(blk_obj,'simulink_name'), ' and VSI ', get(xps_objs{i},'simulink_name'),' are located on the same Z-DOK connector.'];
		        result = 1;
		    end
		end
    end
end
