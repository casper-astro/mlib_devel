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

s.hw_sys = get(xsg_obj,'hw_sys');
s.hw_adc = get_param(blk_name,'adc_brd');
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
s.adc_interleave = get_param(blk_name,'adc_interleave');

switch s.hw_sys
    case 'iBOB'
        if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))
            s.adc_str = s.hw_adc;
        else
            error(['Unsupported adc board: ',s.hw_adc]);
        end % if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25_DT', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns'])
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25_DT');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
    % end case 'iBOB'
    case 'ROACH'
        if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))
            s.adc_str = s.hw_adc;
        else
            error(['Unsupported adc board: ',s.hw_adc]);
        end % if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
    % end case 'ROACH'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_adc',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'adc_interface');
switch s.hw_sys
    case 'iBOB'
        b = set(b, 'ip_version', '1.00.a');
    case 'ROACH'
        b = set(b, 'ip_version', '1.01.a');
end % switch s.hw_sys

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
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.adc_clk_rate*1e6));

adcport = [s.hw_sys, '.', s.adc_str];

ext_ports.adc_clk_p         = { 1 'in'  [s.adc_str,'clk_p']         [adcport,'.clk_p']         'vector=false' mhs_constraints ucf_constraints_clock };
ext_ports.adc_clk_n         = { 1 'in'  [s.adc_str,'clk_n']         [adcport,'.clk_n']         'vector=false' mhs_constraints ucf_constraints_clock };
ext_ports.adc_sync_p        = { 1 'in'  [s.adc_str,'sync_p']        [adcport,'.sync_p']        'vector=false' struct()        ucf_constraints_term };
ext_ports.adc_sync_n        = { 1 'in'  [s.adc_str,'sync_n']        [adcport,'.sync_n']        'vector=false' struct()        ucf_constraints_term };
ext_ports.adc_outofrangei_p = { 1 'in'  [s.adc_str,'outofrangei_p'] [adcport,'.outofrangei_p'] 'vector=false' struct()        ucf_constraints_term };
ext_ports.adc_outofrangei_n = { 1 'in'  [s.adc_str,'outofrangei_n'] [adcport,'.outofrangei_n'] 'vector=false' struct()        ucf_constraints_term };
ext_ports.adc_outofrangeq_p = { 1 'in'  [s.adc_str,'outofrangeq_p'] [adcport,'.outofrangeq_p'] 'vector=false' struct()        ucf_constraints_term };
ext_ports.adc_outofrangeq_n = { 1 'in'  [s.adc_str,'outofrangeq_n'] [adcport,'.outofrangeq_n'] 'vector=false' struct()        ucf_constraints_term };
ext_ports.adc_dataeveni_p   = { 8 'in'  [s.adc_str,'dataeveni_p']   [adcport,'.dataeveni_p']   'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_dataeveni_n   = { 8 'in'  [s.adc_str,'dataeveni_n']   [adcport,'.dataeveni_n']   'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_dataoddi_p    = { 8 'in'  [s.adc_str,'dataoddi_p']    [adcport,'.dataoddi_p']    'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_dataoddi_n    = { 8 'in'  [s.adc_str,'dataoddi_n']    [adcport,'.dataoddi_n']    'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_dataevenq_p   = { 8 'in'  [s.adc_str,'dataevenq_p']   [adcport,'.dataevenq_p']   'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_dataevenq_n   = { 8 'in'  [s.adc_str,'dataevenq_n']   [adcport,'.dataevenq_n']   'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_dataoddq_p    = { 8 'in'  [s.adc_str,'dataoddq_p']    [adcport,'.dataoddq_p']    'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_dataoddq_n    = { 8 'in'  [s.adc_str,'dataoddq_n']    [adcport,'.dataoddq_n']    'vector=true'  struct()        ucf_constraints_term };
ext_ports.adc_ddrb_p        = { 1 'out' [s.adc_str,'ddrb_p']        [adcport,'.ddrb_p']        'vector=false' struct()        ucf_constraints_noterm };
ext_ports.adc_ddrb_n        = { 1 'out' [s.adc_str,'ddrb_n']        [adcport,'.ddrb_n']        'vector=false' struct()        ucf_constraints_noterm };
b = set(b,'ext_ports',ext_ports);

% Software parameters
b = set(b,'c_params',['adc = ',s.adc_str,' / interleave = ',s.adc_interleave]);
