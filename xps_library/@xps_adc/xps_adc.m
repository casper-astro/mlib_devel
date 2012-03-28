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

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25_DT', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25_DT');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
    % end case 'iBOB'
    case {'ROACH', 'ROACH2'}
        if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))
            s.adc_str = s.hw_adc;
        else
            error(['Unsupported adc board: ',s.hw_adc]);
        end % if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
    % end case {'ROACH', 'ROACH2'}
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_adc',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'adc_interface');
switch s.hw_sys
    case 'iBOB'
        b = set(b, 'ip_version', '1.00.a');
    case {'ROACH', 'ROACH2'}
        b = set(b, 'ip_version', '1.01.a');
        b = set(b, 'opb0_devices', 1); %controller
end % switch s.hw_sys

supp_ip_names    = {'', 'opb_adccontroller'};
supp_ip_versions = {'', '1.00.a'};

b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

% misc ports
misc_ports.ctrl_reset      = {1 'in'  [s.adc_str,'_ddrb']};
misc_ports.ctrl_clk_in     = {1 'in'  get(xsg_obj,'clk_src')};
misc_ports.ctrl_clk_out    = {1 'out' [s.adc_str,'_clk']};
misc_ports.ctrl_clk90_out  = {1 'out' [s.adc_str,'_clk90']};
misc_ports.ctrl_dcm_locked = {1 'out' [s.adc_str,'_dcm_locked']};
if strcmp(get(b,'ip_version'), '1.01.a')
    switch s.hw_sys
        case 'iBOB'
            misc_ports.dcm_reset        = {1 'in'  [s.adc_str,'_dcm_reset']};
            misc_ports.dcm_psdone       = {1 'out' [s.adc_str,'_psdone']};
        case 'ROACH'
            misc_ports.dcm_reset        = {1 'in'  [s.adc_str,'_dcm_reset']};
            misc_ports.dcm_psdone       = {1 'out' [s.adc_str,'_psdone']};
        case 'ROACH2'
            misc_ports.mmcm_reset        = {1 'in'  [s.adc_str,'_mmcm_reset']};
            misc_ports.mmcm_psdone       = {1 'out' [s.adc_str,'_psdone']};
    end
    misc_ports.ctrl_clk180_out  = {1 'out' [s.adc_str,'_clk180']};
    misc_ports.ctrl_clk270_out  = {1 'out' [s.adc_str,'_clk270']};
end
misc_ports.dcm_psclk       = {1 'in'  [s.adc_str,'_psclk']};
misc_ports.dcm_psen        = {1 'in'  [s.adc_str,'_psen']};
misc_ports.dcm_psincdec    = {1 'in'  [s.adc_str,'_psincdec']};
b = set(b,'misc_ports',misc_ports);

% external ports
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.adc_clk_rate*1e6));

adcport = [s.hw_sys, '.', 'zdok', s.adc_str(length(s.adc_str))];

ext_ports.adc_clk_p         = {1 'in'  [s.adc_str,'clk_p']         ['{',adcport,'_p{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc_clk_n         = {1 'in'  [s.adc_str,'clk_n']         ['{',adcport,'_n{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc_sync_p        = {1 'in'  [s.adc_str,'sync_p']        ['{',adcport,'_p{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_sync_n        = {1 'in'  [s.adc_str,'sync_n']        ['{',adcport,'_n{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_outofrangei_p = {1 'in'  [s.adc_str,'outofrangei_p'] ['{',adcport,'_p{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_outofrangei_n = {1 'in'  [s.adc_str,'outofrangei_n'] ['{',adcport,'_n{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_outofrangeq_p = {1 'in'  [s.adc_str,'outofrangeq_p'] ['{',adcport,'_p{[28]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_outofrangeq_n = {1 'in'  [s.adc_str,'outofrangeq_n'] ['{',adcport,'_n{[28]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_dataeveni_p   = {8 'in'  [s.adc_str,'dataeveni_p']   ['{',adcport,'_p{[11 13 15 17 31 33 35 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dataeveni_n   = {8 'in'  [s.adc_str,'dataeveni_n']   ['{',adcport,'_n{[11 13 15 17 31 33 35 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dataoddi_p    = {8 'in'  [s.adc_str,'dataoddi_p']    ['{',adcport,'_p{[10 12 14 16 30 32 34 36]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dataoddi_n    = {8 'in'  [s.adc_str,'dataoddi_n']    ['{',adcport,'_n{[10 12 14 16 30 32 34 36]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dataevenq_p   = {8 'in'  [s.adc_str,'dataevenq_p']   ['{',adcport,'_p{[ 6  4  2  0 26 24 22 20]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dataevenq_n   = {8 'in'  [s.adc_str,'dataevenq_n']   ['{',adcport,'_n{[ 6  4  2  0 26 24 22 20]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dataoddq_p    = {8 'in'  [s.adc_str,'dataoddq_p']    ['{',adcport,'_p{[ 7  5  3  1 27 25 23 21]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dataoddq_n    = {8 'in'  [s.adc_str,'dataoddq_n']    ['{',adcport,'_n{[ 7  5  3  1 27 25 23 21]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_ddrb_p        = {1 'out' [s.adc_str,'ddrb_p']        ['{',adcport,'_p{[29]+1,:}}']                         'vector=false'  struct()        ucf_constraints_noterm };
ext_ports.adc_ddrb_n        = {1 'out' [s.adc_str,'ddrb_n']        ['{',adcport,'_n{[29]+1,:}}']                         'vector=false'  struct()        ucf_constraints_noterm };

b = set(b,'ext_ports',ext_ports);

% Software parameters
b = set(b,'c_params',['adc = ',s.adc_str,' / interleave = ',s.adc_interleave]);
