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

function [str,opb_addr_end] = gen_mhs_xsg(blk_obj,opb_addr_start,opb_name)
str = '';
opb_addr_end = opb_addr_start;

ports = blk_obj.ports;
buses = blk_obj.buses;

if (isempty(ports) && isempty(buses))
    return;
end

inst_name = clear_name(get(blk_obj,'simulink_name'));

if ~isempty(ports)
    port_names = fieldnames(ports);
else
    port_names = {};
end

if ~isempty(buses)
    bus_names = fieldnames(buses);
else
    bus_names = {};
end

bus_ports = {};

for k = 1:length(bus_names)
    cur_bus = getfield(buses, bus_names{k});
    bus_if_name = getfield(cur_bus, 'busif');

    bus_ports = [bus_ports, getfield(cur_bus, 'ports')];
    str = [str, ' BUS_INTERFACE ', bus_if_name{1}, ' = ', inst_name, '_', bus_names{k}, '\n'];
end

for j = 1:length(port_names)
    cur_port = getfield(ports,port_names{j});

    if isempty(strmatch(cur_port{3}, bus_ports))
        str = [str, ' PORT ',port_names{j},' = ',port_names{j},'\n'];
    end
end
