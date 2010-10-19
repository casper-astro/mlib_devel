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

function b = xps_vsi(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_VSI class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_vsi')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.hw_sys = 'iBOB';
s.hw_vsi = get_param(blk_name,'connector');
b = class(s,'xps_vsi',blk_obj);

switch s.hw_vsi
    case 'MDR'
        s.vsi_str = 'vsimdr';
    case 'ZDOK 1'
        s.vsi_str = 'vsizdok';
    otherwise
        error(['Unsupported VSI connector: ', s.hw_vsi]);
end

% ip name
b = set(b,'ip_name','vsi_interface');

% parameters
if strcmp(s.hw_vsi, 'ZDOK 1')
    parameters.CONNECTOR = '1';
else
    parameters.CONNECTOR = '0';
end

b = set(b, 'parameters', parameters);

% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.clk = {1 'in' get(xsg_obj,'clk_src')};
b = set(b,'misc_ports',misc_ports);

% external ports
ucf_constraints = struct('IOSTANDARD', 'LVDS_25');

ext_ports.vsi_bs_p      = {32 'out' [s.vsi_str,'_bs_p']      ['iBOB.',s.vsi_str,'.bs_p']      'vector=true'  struct() ucf_constraints};
ext_ports.vsi_onepps_p  = {1  'out' [s.vsi_str,'_onepps_p']  ['iBOB.',s.vsi_str,'.onepps_p']  'vector=false' struct() ucf_constraints};
ext_ports.vsi_pvalid_p  = {1  'out' [s.vsi_str,'_pvalid_p']  ['iBOB.',s.vsi_str,'.pvalid_p']  'vector=false' struct() ucf_constraints};
ext_ports.vsi_clock_p   = {1  'out' [s.vsi_str,'_clock_p']   ['iBOB.',s.vsi_str,'.clock_p']   'vector=false' struct() ucf_constraints};
ext_ports.vsi_pctrl_p   = {1  'out' [s.vsi_str,'_pctrl_p']   ['iBOB.',s.vsi_str,'.pctrl_p']   'vector=false' struct() ucf_constraints};
ext_ports.vsi_pdata_p   = {1  'out' [s.vsi_str,'_pdata_p']   ['iBOB.',s.vsi_str,'.pdata_p']   'vector=false' struct() ucf_constraints};
ext_ports.vsi_pspare1_p = {1  'out' [s.vsi_str,'_pspare1_p'] ['iBOB.',s.vsi_str,'.pspare1_p'] 'vector=false' struct() ucf_constraints};
ext_ports.vsi_pspare2_p = {1  'out' [s.vsi_str,'_pspare2_p'] ['iBOB.',s.vsi_str,'.pspare2_p'] 'vector=false' struct() ucf_constraints};
ext_ports.vsi_bs_n      = {32 'out' [s.vsi_str,'_bs_n']      ['iBOB.',s.vsi_str,'.bs_n']      'vector=true'  struct() ucf_constraints};
ext_ports.vsi_onepps_n  = {1  'out' [s.vsi_str,'_onepps_n']  ['iBOB.',s.vsi_str,'.onepps_n']  'vector=false' struct() ucf_constraints};
ext_ports.vsi_pvalid_n  = {1  'out' [s.vsi_str,'_pvalid_n']  ['iBOB.',s.vsi_str,'.pvalid_n']  'vector=false' struct() ucf_constraints};
ext_ports.vsi_clock_n   = {1  'out' [s.vsi_str,'_clock_n']   ['iBOB.',s.vsi_str,'.clock_n']   'vector=false' struct() ucf_constraints};
ext_ports.vsi_pctrl_n   = {1  'out' [s.vsi_str,'_pctrl_n']   ['iBOB.',s.vsi_str,'.pctrl_n']   'vector=false' struct() ucf_constraints};
ext_ports.vsi_pdata_n   = {1  'out' [s.vsi_str,'_pdata_n']   ['iBOB.',s.vsi_str,'.pdata_n']   'vector=false' struct() ucf_constraints};
ext_ports.vsi_pspare1_n = {1  'out' [s.vsi_str,'_pspare1_n'] ['iBOB.',s.vsi_str,'.pspare1_n'] 'vector=false' struct() ucf_constraints};
ext_ports.vsi_pspare2_n = {1  'out' [s.vsi_str,'_pspare2_n'] ['iBOB.',s.vsi_str,'.pspare2_n'] 'vector=false' struct() ucf_constraints};
b = set(b,'ext_ports',ext_ports);
