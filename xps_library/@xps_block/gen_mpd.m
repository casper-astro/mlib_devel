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

function str = gen_mpd(blk_obj)
str = '';

ports = blk_obj.ports;
buses = blk_obj.buses;

inst_name = clear_name(get(blk_obj,'simulink_name'));

if (isempty(ports) && isempty(buses))
    return;
end

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

    bus_ports = [bus_ports, getfield(cur_bus, 'ports')];
    bus_if_name = getfield(cur_bus, 'busif');

    str = [str, 'BUS_INTERFACE BUS = ', bus_if_name{1}, ', BUS_STD = TRANSPARENT, BUS_TYPE = UNDEF\n'];
end

for j = 1:length(port_names)
    cur_port = getfield(ports,port_names{j});

    str = [str, 'PORT ', port_names{j}, ' = '];

    if ~isempty(strmatch(cur_port{3}, bus_ports))
        for k = 1:length(bus_names)
            cur_bus = getfield(buses, bus_names{k});

            if strmatch(cur_port{3}, getfield(cur_bus, 'ports'));
                bus_if_name = getfield(cur_bus, 'busif');
                str = [str, cur_port{3}, ', BUS = ', bus_if_name{1}];
                break;
            end
        end
    else
        str = [str, '""'];
    end

    if cur_port{1} == 1
        try
            if strcmp(cur_port{6}, 'vector=true')
                str = [str, ', DIR = ',cur_port{2},', VEC = [0:0]\n'];
            else
                str = [str, ', DIR = ',cur_port{2},'\n'];
            end
        catch
            str = [str, ', DIR = ',cur_port{2},'\n'];
        end
    else
        str = [str, ', DIR = ',cur_port{2},', VEC = [',num2str(cur_port{1}-1),':0]\n'];
    end

end
