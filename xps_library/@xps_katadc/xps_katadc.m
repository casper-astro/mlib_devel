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

function b = xps_katadc(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_katadc')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

s.hw_sys = get(xsg_obj,'hw_sys');
s.hw_adc = get_param(blk_name,'adc_brd');
s.clk_src  = get(xsg_obj,'clk_src');
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
s.adc_interleave = get_param(blk_name,'adc_interleave');
s.bypass_auto = get_param(blk_name,'bypass_auto');
s.en_gain = get_param(blk_name,'en_gain');

switch s.hw_sys
    case {'ROACH2', 'ROACH'}
        if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))
            s.adc_str = s.hw_adc;
        else
            error(['Unsupported adc board: ',s.hw_adc]);
        end % if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
    % end case {'ROACH2', 'ROACH'}
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_katadc',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'kat_adc_interface');
switch s.hw_sys
  case {'ROACH', 'ROACH2'},
    b = set(b, 'ip_version', '1.00.a');
    %hard-coded opb0 devices
    b = set(b, 'opb0_devices', 2);  %IIC and controller
end % switch s.hw_sys

supp_ip_names    = {'', 'opb_katadccontroller'};
supp_ip_versions = {'', '1.00.a'};

b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

% misc ports
misc_ports.ctrl_reset      = {1 'in'  [s.adc_str,'_adc_reset']}; % We have an active high signal
misc_ports.ctrl_clk_in     = {1 'in'  get(xsg_obj,'clk_src')};
misc_ports.ctrl_clk_out    = {1 'out' [s.adc_str,'_clk']};
misc_ports.ctrl_clk90_out  = {1 'out' [s.adc_str,'_clk90']};
misc_ports.ctrl_clk180_out = {1 'out' [s.adc_str,'_clk180']};
misc_ports.ctrl_clk270_out = {1 'out' [s.adc_str,'_clk270']};

switch s.hw_sys
    case 'iBOB'
        misc_ports.ctrl_dcm_locked   = {1 'out' [s.adc_str,'_dcm_locked']};
        misc_ports.dcm_reset         = {1 'in'  [s.adc_str,'_dcm_reset']};
        misc_ports.dcm_psdone        = {1 'out' [s.adc_str,'_psdone']};
        misc_ports.dcm_psclk       = {1 'in'  [s.adc_str,'_psclk']};
        misc_ports.dcm_psen        = {1 'in'  [s.adc_str,'_psen']};
        misc_ports.dcm_psincdec    = {1 'in'  [s.adc_str,'_psincdec']};
    case 'ROACH'
        misc_ports.ctrl_dcm_locked   = {1 'out' [s.adc_str,'_dcm_locked']};
        misc_ports.dcm_reset         = {1 'in'  [s.adc_str,'_dcm_reset']};
        misc_ports.dcm_psdone        = {1 'out' [s.adc_str,'_psdone']};
        misc_ports.dcm_psclk       = {1 'in'  [s.adc_str,'_psclk']};
        misc_ports.dcm_psen        = {1 'in'  [s.adc_str,'_psen']};
        misc_ports.dcm_psincdec    = {1 'in'  [s.adc_str,'_psincdec']};
    case 'ROACH2'
        misc_ports.ctrl_mmcm_locked  = {1 'out' [s.adc_str,'_mmcm_locked']};
        misc_ports.mmcm_reset        = {1 'in'  [s.adc_str,'_mmcm_reset']};
        misc_ports.mmcm_psdone       = {1 'out' [s.adc_str,'_psdone']};
        misc_ports.mmcm_psclk        = {1 'in'  [s.adc_str,'_psclk']};
        misc_ports.mmcm_psen         = {1 'in'  [s.adc_str,'_psen']};
        misc_ports.mmcm_psincdec     = {1 'in'  [s.adc_str,'_psincdec']};
end

b = set(b,'misc_ports',misc_ports);

% external ports
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.adc_clk_rate*1e6));

adcport = [s.hw_sys, '.', 'zdok', s.adc_str(length(s.adc_str))];

ext_ports.adc_clk_p       = {1 'in'  [s.adc_str,'clk_p']       ['{',adcport,'_p{[19]+1,:}}']                     'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc_clk_n       = {1 'in'  [s.adc_str,'clk_n']       ['{',adcport,'_n{[19]+1,:}}']                     'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc_sync_p      = {1 'in'  [s.adc_str,'sync_p']      ['{',adcport,'_p{[31]+1,:}}']                     'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_sync_n      = {1 'in'  [s.adc_str,'sync_n']      ['{',adcport,'_n{[31]+1,:}}']                     'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_overrange_p = {1 'in'  [s.adc_str,'overrange_p'] ['{',adcport,'_p{[39]+1,:}}']                     'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_overrange_n = {1 'in'  [s.adc_str,'overrange_n'] ['{',adcport,'_n{[39]+1,:}}']                     'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc_di_d_p      = {8 'in'  [s.adc_str,'di_d_p']      ['{',adcport,'_p{[21 1 11 22 2 32 12 23]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_di_d_n      = {8 'in'  [s.adc_str,'di_d_n']      ['{',adcport,'_n{[21 1 11 22 2 32 12 23]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_di_p        = {8 'in'  [s.adc_str,'di_p']        ['{',adcport,'_p{[3 33 13 24 4 34 14 25]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_di_n        = {8 'in'  [s.adc_str,'di_n']        ['{',adcport,'_n{[3 33 13 24 4 34 14 25]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dq_d_p      = {8 'in'  [s.adc_str,'dq_d_p']      ['{',adcport,'_p{[9 29 18 38 8 28 17 37]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dq_d_n      = {8 'in'  [s.adc_str,'dq_d_n']      ['{',adcport,'_n{[9 29 18 38 8 28 17 37]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dq_p        = {8 'in'  [s.adc_str,'dq_p']        ['{',adcport,'_p{[7 27 16 36 6 26 15 35]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_dq_n        = {8 'in'  [s.adc_str,'dq_n']        ['{',adcport,'_n{[7 27 16 36 6 26 15 35]+1,:}}']  'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc_rst         = {1 'out' [s.adc_str,'rst']         ['{',adcport,'_p{[5]+1,:}}']                     'vector=false'  struct()        };
ext_ports.adc_powerdown   = {1 'out' [s.adc_str,'powerdown']   ['{',adcport,'_p{[10]+1,:}}']                      'vector=false'  struct()        };

b = set(b,'ext_ports',ext_ports);

% Software parameters
b = set(b,'c_params',['adc = ',s.adc_str,' / interleave = ',s.adc_interleave]);

