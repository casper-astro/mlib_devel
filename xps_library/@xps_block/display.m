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

function display(b)
%DISPLAY text display of the XPS_Block class object
%   DISPLAY(obj) displays the property values of the object
disp('==============================================================');
disp([' Simulink Name: ' b.simulink_name]);
disp([' Parent System: ' b.parent]);
disp([' Block type: ' b.type]);
if ~isempty(b.ports)
	disp([' Ports: ']);
	disp(b.ports);
end
params = fieldnames(b);
for i=[1:length(params)]
	if ~strcmp(params{i},'xps_block')
		if ischar(get(b,params{i}))
			disp([' ',params{i},' = ',get(b,params{i})]);
		elseif isnumeric(get(b,params{i}))
			disp([' ',params{i},' = ',num2str(get(b,params{i}))]);
		elseif islogical(get(b,params{i}))
			if get(b,params{i})
				disp([' ',params{i},' = true']);
			else
				disp([' ',params{i},' = false']);
			end
		elseif iscellstr(get(b,params{i}))
			disp([' ',params{i},' = ']);
			disp(get(b,params{i}));
		else
			disp([' ',params{i},' [Unknown object type]']);
		end
	end
end
disp('==============================================================');
