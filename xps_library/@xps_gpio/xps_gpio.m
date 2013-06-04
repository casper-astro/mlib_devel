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
s.single_ended = get_param(blk_name,'use_single_ended');
b = class(s,'xps_gpio',blk_obj);

use_diffio = ~isempty(strmatch(s.io_group, {'zdok0', 'zdok1', 'mdr', 'qsh', 'sync_in', 'sync_out'})) & strcmp(s.single_ended, 'off');

if ~isempty(strmatch(s.termtype, {'Pullup', 'Pulldown'}))
    termination = s.termtype;
else
    termination = '';
end % ~isempty(strmatch(s.termtype, {'Pullup', 'Pulldown'}))


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
    case 'ROACH'
        if use_diffio
            iostandard = 'LVDS_25';
        else
            switch s.io_group
              case 'led'
                iostandard = 'LVCMOS18';
              case 'gpioa_oe_n'
                iostandard = 'LVCMOS33';
              case 'gpiob_oe_n'
                iostandard = 'LVCMOS33';
              case 'gpiob'
                iostandard = 'LVCMOS15';
              otherwise
                iostandard = 'LVCMOS25';
            end               
        end % if use_diffio
    % end case 'ROACH'
    case 'ROACH2'
        if use_diffio
            iostandard = 'LVDS_25';
        else
            iostandard = 'LVCMOS15';
        end % if use_diffio
    % end case 'ROACH2'
    otherwise
        iostandard = 'LVCMOS25';
end % switch 'hw_sys'

ucf_fields = {};
ucf_values = {};

%ucf_fields = [ucf_fields, 'IOSTANDARD', termination];
%ucf_values = [ucf_values, iostandard, ''];

if ~isempty(termination)
    ucf_constraints = struct('IOSTANDARD',iostandard, termination,'');
else
    ucf_constraints = struct('IOSTANDARD',iostandard);
end % if ~isempty(termination)

switch s.use_ddr
    case 0
        pad_bitwidth = s.io_bitwidth;
    case 1
        pad_bitwidth = s.io_bitwidth/2;
end % switch s.use_ddr

extportname = [clear_name(blk_name), '_ext'];
iobname = [s.hw_sys, '.', s.io_group];

%ucf_constraints = cell2struct(ucf_values, ucf_fields, length(ucf_fields));

switch use_diffio
    case 0
        ext_ports.io_pad =   {pad_bitwidth  s.io_dir    extportname         [iobname,'  ([',num2str(s.bit_index),']+1)']    'vector=true'   struct()    ucf_constraints };
    case 1
        ext_ports.io_pad_p = {pad_bitwidth  s.io_dir    [extportname, '_p'] [iobname,'_p([',num2str(s.bit_index),']+1)']    'vector=true'   struct()    ucf_constraints };
        ext_ports.io_pad_n = {pad_bitwidth  s.io_dir    [extportname, '_n'] [iobname,'_n([',num2str(s.bit_index),']+1)']    'vector=true'   struct()    ucf_constraints };
end % switch use_diffio

b = set(b,'ext_ports',ext_ports);

% parameters
parameters.DDR = num2str(s.use_ddr);
parameters.WIDTH = num2str(s.io_bitwidth);
parameters.CLK_PHASE = num2str(s.reg_clk_phase);
if strcmp(s.reg_iob,'on')
	parameters.REG_IOB = 'true';
else
	parameters.REG_IOB = 'false';
end % if strcmp(s.reg_iob,'on')
b = set(b,'parameters',parameters);

% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.clk = {1 'in' get(xsg_obj,'clk_src')};
misc_ports.clk90 = {1 'in' get(xsg_obj,'clk90_src')};
b = set(b,'misc_ports',misc_ports);
