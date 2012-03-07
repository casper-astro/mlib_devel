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

function b = xps_probe(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_PROBE class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_probe')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
s.hw_sys = 'any';
s.match_type = get_param(blk_name,'match_type');
s.match_counter_width = get_param(blk_name,'match_counter_width');
s.ila_number = str2num(get_param(blk_name,'ila_number'));
s.capture_depth = get_param(blk_name, 'capture_depth');
if strcmp(get_param(blk_name,'arith_type'),'Boolean')
	s.bitwidth = 1;
else
	s.bitwidth = get_param(blk_name,'bitwidth');
end
b = class(s,'xps_probe',blk_obj);

% ip name
b = set(b,'ip_name','chipscope_ila');

% misc ports
misc_ports.chipscope_ila_control = {36 'in' ['chipscope_icon_control',num2str(s.ila_number)]};
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.clk = {1 'in' get(xsg_obj,'clk_src')};
b = set(b,'misc_ports',misc_ports);

% parameters
parameters.C_TRIG0_UNITS = '1';
parameters.C_TRIG0_TRIGGER_IN_WIDTH = num2str(s.bitwidth);
parameters.C_TRIG0_UNIT_MATCH_TYPE = s.match_type;
parameters.C_TRIG0_UNIT_COUNTER_WIDTH = s.match_counter_width;
parameters.C_NUM_DATA_SAMPLES = s.capture_depth;
b = set(b,'parameters',parameters);