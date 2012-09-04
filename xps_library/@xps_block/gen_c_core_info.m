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

function str = gen_c_core_info(blk_obj)
str = '';

try
	range_opb = blk_obj.opb_address_offset;
catch
	range_opb = 0;
end

short_name = regexp(blk_obj.simulink_name,'^\w*\/(.*)','tokens');
try
	short_name = short_name{1}{1};
catch
	short_name = blk_obj.simulink_name;
end

short_name = char(cellstr(short_name));

if range_opb ~= 0
	str = ['{"',short_name,'",',blk_obj.type,',','XPAR_',upper(clear_name(blk_obj.simulink_name)),'_BASEADDR',',"',blk_obj.c_params,'"},\n'];
else
	str = ['{"',short_name,'",',blk_obj.type,',-1,"',blk_obj.c_params,'"},\n'];
end

