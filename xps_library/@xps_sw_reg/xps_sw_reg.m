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

function b = xps_sw_register(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_SW_REG class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_sw_reg')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.hw_sys = 'any';

switch get_param(blk_name,'io_dir')
    case 'From Processor'
        s.io_dir = 'in';
    case 'To Processor'
        s.io_dir = 'out';
end
b = class(s,'xps_sw_reg',blk_obj);

% ip name
switch get_param(blk_name,'io_dir')
    case 'From Processor'
		b = set(b,'ip_name','opb_register_ppc2simulink');
    case 'To Processor'
		b = set(b,'ip_name','opb_register_simulink2ppc');
end

% bus clock
switch get(xsg_obj,'hw_sys')
    case {'ROACH', 'ROACH2'}
        b = set(b,'opb_clk','epb_clk');
    case 'ROACH2'
        b = set(b,'opb_clk','epb_clk');
    otherwise
        b = set(b,'opb_clk','sys_clk');
end % switch get(xsg_obj,'hw_sys')

% bus offset
b = set(b,'opb_address_offset',256);

% misc ports
misc_ports.user_clk     = {1 'in'  get(xsg_obj,'clk_src')};
b = set(b,'misc_ports',misc_ports);

% software parameters
b = set(b,'c_params',s.io_dir);

% borf parameters
switch get_param(blk_name,'io_dir')
    case 'From Processor'
        borph_info.mode = 3;
    case 'To Processor'
        borph_info.mode = 1;
end

borph_info.size = 4;
b = set(b,'borph_info',borph_info);
