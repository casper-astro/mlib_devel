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

function b = xps_dac(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_DAC class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_dac')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.dac_clk_rate = eval_param(blk_name,'dac_clk_rate');
[s.hw_sys,s.hw_dac] = xps_get_hw_info(get_param(blk_name,'dac_brd'));

switch s.hw_sys
    case 'iBOB'
        switch s.hw_dac
            case 'dac0'
                s.dac_str = 'dac0';
            case 'dac1'
                s.dac_str = 'dac1';
            otherwise
                error(['Unsupported dac board: ',s.hw_dac]);
        end
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end

s.invert_clk = get_param(gcb, 'invert_clock');

b = class(s,'xps_dac',blk_obj);

% ip name
b = set(b,'ip_name','dac_interface');
b = set(b,'ip_version','1.00.b');

% parameters
parameters.CTRL_CLK_PHASE = num2str(strcmp(s.invert_clk, 'on'));
b = set(b,'parameters',parameters);

% misc ports
misc_ports.user_data_clk   = {1 'out' [s.dac_str,'_clk']};
misc_ports.user_data_clk90 = {1 'out' [s.dac_str,'_clk90']};
b = set(b,'misc_ports',misc_ports);

% external ports

ucf_constraints = struct('IOSTANDARD', 'LVDS_25');

ext_ports.dac_dsp_clk_p  = {1 'in'  [s.dac_str,'_dsp_clk_p']  ['iBOB.',s.dac_str,'.dsp_clk_p']  'vector=false' struct() ucf_constraints};
ext_ports.dac_dsp_clk_n  = {1 'in'  [s.dac_str,'_dsp_clk_n']  ['iBOB.',s.dac_str,'.dsp_clk_n']  'vector=false' struct() ucf_constraints};

ext_ports.dac_data_clk_p = {1 'out' [s.dac_str,'_data_clk_p'] ['iBOB.',s.dac_str,'.data_clk_p'] 'vector=false' struct() ucf_constraints};
ext_ports.dac_data_clk_n = {1 'out' [s.dac_str,'_data_clk_n'] ['iBOB.',s.dac_str,'.data_clk_n'] 'vector=false' struct() ucf_constraints};
ext_ports.dac_data_a_p   = {9 'out' [s.dac_str,'_data_a_p']   ['iBOB.',s.dac_str,'.data_a_p']   'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_a_n   = {9 'out' [s.dac_str,'_data_a_n']   ['iBOB.',s.dac_str,'.data_a_n']   'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_b_p   = {9 'out' [s.dac_str,'_data_b_p']   ['iBOB.',s.dac_str,'.data_b_p']   'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_b_n   = {9 'out' [s.dac_str,'_data_b_n']   ['iBOB.',s.dac_str,'.data_b_n']   'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_c_p   = {9 'out' [s.dac_str,'_data_c_p']   ['iBOB.',s.dac_str,'.data_c_p']   'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_c_n   = {9 'out' [s.dac_str,'_data_c_n']   ['iBOB.',s.dac_str,'.data_c_n']   'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_d_p   = {9 'out' [s.dac_str,'_data_d_p']   ['iBOB.',s.dac_str,'.data_d_p']   'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_d_n   = {9 'out' [s.dac_str,'_data_d_n']   ['iBOB.',s.dac_str,'.data_d_n']   'vector=true'  struct() ucf_constraints};

b = set(b, 'ext_ports', ext_ports);
