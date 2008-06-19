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

function [str,opb_addr_end,plb_addr_end] = gen_mhs_ip(blk_obj,opb_addr_start,plb_addr_start,plb_name,opb_name)
str = '';
opb_addr_end = opb_addr_start;
plb_addr_end = plb_addr_start;

try
	ext_ports = get(blk_obj, 'ext_ports');
catch
	ext_ports = {};
end

if ~isempty(ext_ports)
	ext_port_names = fieldnames(ext_ports);

	for j = 1:length(ext_port_names)
	    cur_ext_port = getfield(ext_ports,ext_port_names{j});
	    if cur_ext_port{1} == 1 & ~strcmp(cur_ext_port{6},'vector=true')
	        str = [str, 'PORT ',cur_ext_port{3},' = ',cur_ext_port{3},', DIR = ',cur_ext_port{2},'\n'];
	    else
	        str = [str, 'PORT ',cur_ext_port{3},' = ',cur_ext_port{3},', DIR = ',cur_ext_port{2},', VEC = [',num2str(cur_ext_port{1}-1),':0]\n'];
	    end
	end
end
