%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
%                                                                             %
%   Meerkat Telescope Project                                                 %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2011                                                        %
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

c_sys = gcb;

arith_type  = get_param(c_sys, 'arith_type');
data_width  = str2double(get_param(c_sys, 'data_width'));
data_bin_pt = eval_param(c_sys, 'data_bin_pt');
addr_width  = eval_param(c_sys, 'addr_width');

% set up address manipulation blocks

try
    set_param([c_sys, '/calc_add'], 'data_width', num2str(data_width), 'addr_width', num2str(addr_width));
catch
    warning('Shared BRAM block "%s" is out of date (needs its link restored)', c_sys);
end

% set up cast blocks

set_param([c_sys, '/convert_din1'], 'n_bits', num2str(data_width), 'bin_pt', num2str(data_bin_pt));

% set up gateways

gateway_ins = find_system(c_sys, 'searchdepth', 1, 'FollowLinks', 'on', ...
    'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
set_param(gateway_ins{1}, 'n_bits', num2str(data_width), ...
    'arith_type', 'Unsigned', 'bin_pt', num2str(data_bin_pt), 'Name', clear_name([c_sys,'_data_out']));
gateway_outs =find_system(c_sys, 'searchdepth', 1, 'FollowLinks', 'on', ...
    'lookundermasks', 'all', 'masktype', 'Xilinx Gateway Out Block');
for ctr =1:length(gateway_outs)
    gw = gateway_outs{ctr};
    if regexp(get_param(gw, 'Name'), '_addr$')
        set_param(gw, 'Name', clear_name([c_sys, '_addr']));
    elseif regexp(get_param(gw, 'Name'), '_data_in$')
        set_param(gw, 'Name', clear_name([c_sys, '_data_in']));
    elseif regexp(get_param(gw, 'Name'), '_we$')
        set_param(gw, 'Name', clear_name([c_sys, '_we']));
    else
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', get_param(gw, 'Name')]);
    end
end

% set up simulation memory

latency = 1;
if strcmp(get_param(c_sys, 'reg_prim_output'), 'on')
    latency = latency + 1;
end
if strcmp(get_param(c_sys, 'reg_core_output'), 'on')
    latency = latency + 1;
end
set_param([c_sys, '/sim_mem'], 'latency', num2str(latency));

set_param([c_sys, '/sim_mem'], 'data_width', get_param(c_sys, 'data_width'));
set_param([c_sys, '/sim_mem'], 'arith_type', get_param(c_sys, 'arith_type'));
set_param([c_sys, '/sim_mem'], 'addr_width', get_param(c_sys, 'addr_width'));
set_param([c_sys, '/sim_mem'], 'data_bin_pt', get_param(c_sys, 'data_bin_pt'));
set_param([c_sys, '/sim_mem'], 'init_vals', get_param(c_sys, 'init_vals'));
set_param([c_sys, '/sim_mem'], 'sample_rate', get_param(c_sys, 'sample_rate'));

% set up various munge blocks (which may have to redraw, so disable library link first)

set_param(c_sys,'LinkStatus','inactive');

divisions = ceil(data_width/32);
for name = {'munge_in'}
    try
        set_param([c_sys, '/', name{1}], ... 
            'divisions', num2str(divisions), ...
            'div_size', mat2str(repmat(min(32, data_width),1,divisions)), ...
            'order', ['[',num2str([divisions-1:-1:0]),']'], ...
            'arith_type_out', 'Unsigned', ...
            'bin_pt_out', num2str(data_bin_pt));
    catch
        warning('Shared BRAM block "%s" is out of date (needs its link restored)', c_sys);
    end
end % /for

for name = {'munge_out'}
    try
        set_param([c_sys, '/', name{1}], ... 
            'divisions', num2str(divisions), ...
            'div_size', mat2str(repmat(min(32, data_width),1,divisions)), ...
            'order', ['[',num2str([divisions-1:-1:0]),']'], ...
            'arith_type_out', arith_type, ...
            'bin_pt_out', num2str(data_bin_pt));
    catch
        warning('Shared BRAM block "%s" is out of date (needs its link restored)', c_sys);
    end
end
