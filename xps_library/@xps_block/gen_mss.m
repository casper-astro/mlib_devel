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

function str = gen_mss(blk_obj)
str = '';

try
	ip_name = blk_obj.ip_name;
catch
	ip_name = '';
end

try
	soft_driver = blk_obj.soft_driver;
catch
	soft_driver = {};
end
if isempty(soft_driver)
	soft_driver = {'generic' '1.00.a'};
end

if ~isempty(ip_name)
	str = [str, 'BEGIN DRIVER\n'];
	str = [str, ' PARAMETER DRIVER_NAME = ',soft_driver{1},'\n'];
	str = [str, ' PARAMETER DRIVER_VER = ',soft_driver{2},'\n'];
	str = [str, ' PARAMETER HW_INSTANCE = ',clear_name(get(blk_obj,'simulink_name')),'\n'];
	str = [str, 'END\n'];
end
