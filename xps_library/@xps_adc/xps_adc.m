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

function b = xps_adc(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_adc')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
[s.hw_sys,s.hw_adc] = xps_get_hw_info(get_param(blk_name,'adc_brd'));
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
s.adc_interleave = get_param(blk_name,'adc_interleave');
switch s.hw_sys
    case 'iBOB'
        switch s.hw_adc
            case 'adc0'
                s.adc_str = 'adc0';
            case 'adc1'
                s.adc_str = 'adc1';
            otherwise
                error(['Unsupported adc board: ',s.hw_adc]);
        end
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end
b = class(s,'xps_adc',blk_obj);

% ip name
b = set(b,'ip_name','adc_interface');
% misc ports
misc_ports.ctrl_reset      = {1 'in'  [s.adc_str,'_ddrb']};
misc_ports.ctrl_clk_in     = {1 'in'  get(xsg_obj,'clk_src')};
misc_ports.ctrl_clk_out    = {1 'out' [s.adc_str,'_clk']};
misc_ports.ctrl_clk90_out  = {1 'out' [s.adc_str,'_clk90']};
misc_ports.ctrl_dcm_locked = {1 'out' [s.adc_str,'_dcm_locked']};
misc_ports.dcm_psclk       = {1 'in'  [s.adc_str,'_psclk']};
misc_ports.dcm_psen        = {1 'in'  [s.adc_str,'_psen']};
misc_ports.dcm_psincdec    = {1 'in'  [s.adc_str,'_psincdec']};
b = set(b,'misc_ports',misc_ports);

% external ports
ext_ports.adc_clk_p         = {1 'in'  [s.adc_str,'clk_p']         ['iBOB.',s.adc_str,'.clk_p']         'LVDS_25_DT' 'vector=false'};
ext_ports.adc_clk_n         = {1 'in'  [s.adc_str,'clk_n']         ['iBOB.',s.adc_str,'.clk_n']         'LVDS_25_DT' 'vector=false'};
ext_ports.adc_sync_p        = {1 'in'  [s.adc_str,'sync_p']        ['iBOB.',s.adc_str,'.sync_p']        'LVDS_25_DT' 'vector=false'};
ext_ports.adc_sync_n        = {1 'in'  [s.adc_str,'sync_n']        ['iBOB.',s.adc_str,'.sync_n']        'LVDS_25_DT' 'vector=false'};
ext_ports.adc_outofrangei_p = {1 'in'  [s.adc_str,'outofrangei_p'] ['iBOB.',s.adc_str,'.outofrangei_p'] 'LVDS_25_DT' 'vector=false'};
ext_ports.adc_outofrangei_n = {1 'in'  [s.adc_str,'outofrangei_n'] ['iBOB.',s.adc_str,'.outofrangei_n'] 'LVDS_25_DT' 'vector=false'};
ext_ports.adc_outofrangeq_p = {1 'in'  [s.adc_str,'outofrangeq_p'] ['iBOB.',s.adc_str,'.outofrangeq_p'] 'LVDS_25_DT' 'vector=false'};
ext_ports.adc_outofrangeq_n = {1 'in'  [s.adc_str,'outofrangeq_n'] ['iBOB.',s.adc_str,'.outofrangeq_n'] 'LVDS_25_DT' 'vector=false'};
ext_ports.adc_dataeveni_p   = {8 'in'  [s.adc_str,'dataeveni_p']   ['iBOB.',s.adc_str,'.dataeveni_p']   'LVDS_25_DT' 'vector=true'};
ext_ports.adc_dataeveni_n   = {8 'in'  [s.adc_str,'dataeveni_n']   ['iBOB.',s.adc_str,'.dataeveni_n']   'LVDS_25_DT' 'vector=true'};
ext_ports.adc_dataoddi_p    = {8 'in'  [s.adc_str,'dataoddi_p']    ['iBOB.',s.adc_str,'.dataoddi_p']    'LVDS_25_DT' 'vector=true'};
ext_ports.adc_dataoddi_n    = {8 'in'  [s.adc_str,'dataoddi_n']    ['iBOB.',s.adc_str,'.dataoddi_n']    'LVDS_25_DT' 'vector=true'};
ext_ports.adc_dataevenq_p   = {8 'in'  [s.adc_str,'dataevenq_p']   ['iBOB.',s.adc_str,'.dataevenq_p']   'LVDS_25_DT' 'vector=true'};
ext_ports.adc_dataevenq_n   = {8 'in'  [s.adc_str,'dataevenq_n']   ['iBOB.',s.adc_str,'.dataevenq_n']   'LVDS_25_DT' 'vector=true'};
ext_ports.adc_dataoddq_p    = {8 'in'  [s.adc_str,'dataoddq_p']    ['iBOB.',s.adc_str,'.dataoddq_p']    'LVDS_25_DT' 'vector=true'};
ext_ports.adc_dataoddq_n    = {8 'in'  [s.adc_str,'dataoddq_n']    ['iBOB.',s.adc_str,'.dataoddq_n']    'LVDS_25_DT' 'vector=true'};
ext_ports.adc_ddrb_p        = {1 'out' [s.adc_str,'ddrb_p']        ['iBOB.',s.adc_str,'.ddrb_p']        'LVDS_25'    'vector=false'};
ext_ports.adc_ddrb_n        = {1 'out' [s.adc_str,'ddrb_n']        ['iBOB.',s.adc_str,'.ddrb_n']        'LVDS_25'    'vector=false'};
b = set(b,'ext_ports',ext_ports);
% Software parameters
b = set(b,'c_params',['adc = ',s.adc_str,' / interleave = ',s.adc_interleave]);