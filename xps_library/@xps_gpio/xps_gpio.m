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

function b = xps_gpio(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_GPIO class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_gpio')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
[s.hw_sys,s.io_group] = xps_get_hw_info(get_param(blk_name,'io_group'));
s.bit_index = eval_param(blk_name,'bit_index');
s.io_dir = get_param(blk_name,'io_dir');
s.reg_iob = get_param(blk_name,'reg_iob');
s.arith_type = get_param(blk_name,'arith_type');
if strcmp(s.arith_type,'Boolean')
	s.io_bitwidth = 1;
else
	s.io_bitwidth = eval_param(blk_name,'bitwidth');
end
s.reg_clk_phase = get_param(blk_name,'reg_clk_phase');
s.use_ddr = strcmp(get_param(blk_name,'use_ddr'),'on');
s.termtype = get_param(blk_name,'termination');
b = class(s,'xps_gpio',blk_obj);

use_diffio = ~isempty(strmatch(s.io_group, {'zdok0', 'zdok1', 'mdr'}));

if ~isempty(strmatch(s.termtype, {'Pullup', 'Pulldown'}))
    termination = s.termtype;
else
    termination = '';
end

misc_constraints = {};
misc_constraints = [misc_constraints, termination];

% ip name
if use_diffio
    switch s.io_dir
        case 'in'
            b = set(b, 'ip_name','diffgpio_ext2simulink');
        case 'out'
            b = set(b, 'ip_name','diffgpio_simulink2ext');
    end
else
    switch s.io_dir
        case 'in'
            b = set(b, 'ip_name','gpio_ext2simulink');
        case 'out'
            b = set(b, 'ip_name','gpio_simulink2ext');
    end
end

% external ports

switch s.hw_sys
    case 'BEE2_usr'
        switch s.io_group
            case 'leftlink'
                iostandard = 'LVCMOS25';
            case 'rightlink'
                iostandard = 'LVCMOS25';
            case 'uplink'
                iostandard = 'LVCMOS25';
            otherwise
                iostandard = 'LVCMOS18';
        end
    case 'BEE2_ctrl'
        switch s.io_group
            case 'downlink1'
                iostandard = 'LVCMOS25';
            case 'downlink2'
                iostandard = 'LVCMOS25';
            case 'downlink3'
                iostandard = 'LVCMOS25';
            case 'downlink4'
                iostandard = 'LVCMOS25';
            otherwise
                iostandard = 'LVCMOS18';
        end
    case 'iBOB'
        if use_diffio
            iostandard = 'LVDS_25';
        else
            iostandard = 'LVCMOS25';
        end
    otherwise
        iostandard = 'LVCMOS25';
end


switch s.use_ddr
	case 0
	    switch use_diffio
	        case 0
		        ext_ports.io_pad =   {s.io_bitwidth s.io_dir    [clear_name(blk_name),'_ext']   [s.hw_sys,'.',s.io_group,'([',num2str(s.bit_index),']+1)']      iostandard  'vector=true'   misc_constraints};
		    case 1
		        ext_ports.io_pad_p = {s.io_bitwidth s.io_dir    [clear_name(blk_name),'_ext_p'] [s.hw_sys,'.',s.io_group,'_p([',num2str(s.bit_index),']+1)']    iostandard  'vector=true'   misc_constraints};
		        ext_ports.io_pad_n = {s.io_bitwidth s.io_dir    [clear_name(blk_name),'_ext_n'] [s.hw_sys,'.',s.io_group,'_n([',num2str(s.bit_index),']+1)']    iostandard  'vector=true'   misc_constraints};
		end
	case 1
	    switch use_diffio
	        case 0
		        ext_ports.io_pad =   {s.io_bitwidth/2 s.io_dir  [clear_name(blk_name),'_ext']   [s.hw_sys,'.',s.io_group,'([',num2str(s.bit_index),']+1)']      iostandard  'vector=true'   misc_constraints};
		    case 1
		        ext_ports.io_pad_p = {s.io_bitwidth/2 s.io_dir  [clear_name(blk_name),'_ext_p'] [s.hw_sys,'.',s.io_group,'_p([',num2str(s.bit_index),']+1)']    iostandard  'vector=true'   misc_constraints};
		        ext_ports.io_pad_n = {s.io_bitwidth/2 s.io_dir  [clear_name(blk_name),'_ext_n'] [s.hw_sys,'.',s.io_group,'_n([',num2str(s.bit_index),']+1)']    iostandard  'vector=true'   misc_constraints};
		end
end
b = set(b,'ext_ports',ext_ports);

% parameters
parameters.DDR = num2str(s.use_ddr);
parameters.WIDTH = num2str(s.io_bitwidth);
parameters.CLK_PHASE = num2str(s.reg_clk_phase);
if strcmp(s.reg_iob,'on')
	parameters.REG_IOB = 'true';
else
	parameters.REG_IOB = 'false';
end
b = set(b,'parameters',parameters);

% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.clk = {1 'in' get(xsg_obj,'clk_src')};
misc_ports.clk90 = {1 'in' get(xsg_obj,'clk90_src')};
b = set(b,'misc_ports',misc_ports);
