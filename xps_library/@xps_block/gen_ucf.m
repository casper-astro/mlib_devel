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

function str = gen_ucf(blk_obj)
str = '';

try
    ext_ports = blk_obj.ext_ports;
catch
    ext_ports = {};
end

if ~isempty(ext_ports)
    load_hw_routes();
    ext_port_names = fieldnames(ext_ports);
    for j = 1:length(ext_port_names)
        cur_ext_port = getfield(ext_ports,ext_port_names{j});
        if length(cur_ext_port) > 3
            locs = cur_ext_port{4};

            try
                ucf_constraints = cur_ext_port{7};
                ucf_constraints_fields = fieldnames(ucf_constraints);
                ucf_constraints_str = '';

                for n = 1:length(ucf_constraints_fields)
                    ucf_constraint_value = eval(['ucf_constraints.',ucf_constraints_fields{n}]);

                    if isempty(ucf_constraint_value)
                        ucf_constraints_str = [ucf_constraints_str, ' | ', ucf_constraints_fields{n}];
                    else
                        ucf_constraints_str = [ucf_constraints_str, ' | ', ucf_constraints_fields{n}, ' = ', ucf_constraint_value];
                    end % if isempty(ucf_constraint_value)
                end % for n = 1:length(ucf_constraints_fields)
            catch
                ucf_constraints_str = '';
            end % try

            if ~strcmp(locs,'null')
                if isstr(locs)
                    pin = eval(locs);
                else
                    pin = locs;
                end% if isstr(locs)

                if length(pin) ~= cur_ext_port{1}
                    error(['Number of pin locations for external port ',ext_port_names{j},' does not correspond to bitwidth']);
                end % length(locs) ~= cur_ext_port{1}

                if cur_ext_port{1} == 1 & ~strcmp(cur_ext_port{5},'vector=true')
                    str = [str,'NET \"',cur_ext_port{3},'\" LOC = ', pin{1}, ucf_constraints_str, ' ;\n'];
                else
                    for i = [1:cur_ext_port{1}]
                        str = [str,'NET \"',cur_ext_port{3},'<',num2str(i-1),'>\" LOC = ', pin{i}, ucf_constraints_str, ' ;\n'];
                    end % i = [1:cur_ext_port{1}]
                end % cur_ext_port{1} == 1 & ~strcmp(cur_ext_port{5},'vector=true')
            end % if ~strcmp(locs,'null')
        end % if length(cur_ext_port) > 3
    end % for j = 1:length(ext_port_names)
end % ~isempty(ext_ports)
