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

function b = xps_mkadc(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_mkadc')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');


s.hw_sys = get(xsg_obj,'hw_sys');
s.hw_adc = get_param(blk_name,'adc_brd');
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
s.clk_src  = get(xsg_obj,'clk_src');

% Get MASK paramters from the one_GbE yellow block
s.hw_sys         = get(xsg_obj,'hw_sys');

s.gray_en          = num2str(strcmp(get_param(blk_name, 'gray_en'), 'on'));

% These MASK parameters ends up to be generics for the HDL (mkadc_interface.vhd)
% also see mkadc_interface_v2_1_0.mpd for connections and parameter declarations
parameters.G_GRAY_EN        = s.gray_en;

switch s.hw_sys
    case 'ROACH2'
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

b = class(s,'xps_mkadc',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'mkadc_interface');

switch s.hw_sys
    case {'ROACH2'}
        b = set(b, 'ip_version', '1.00.a');
        %hard-coded opb0 devices
        b = set(b, 'opb0_devices', 2);  %IIC and controller
end % switch s.hw_sys

supp_ip_names    = {'', 'opb_katadccontroller'};
supp_ip_versions = {'', '1.00.a'};

b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

b = set(b,'parameters',parameters);

% misc ports
misc_ports.ctrl_clk_in      = {1 'in'  get(xsg_obj,'clk_src')};
misc_ports.ctrl_clk_out     = {1 'out' [s.adc_str,'_clk']};
misc_ports.ctrl_clk90_out   = {1 'out' [s.adc_str,'_clk90']};
misc_ports.ctrl_clk180_out  = {1 'out' [s.adc_str,'_clk180']};
misc_ports.ctrl_clk270_out  = {1 'out' [s.adc_str,'_clk270']};
misc_ports.power_on_rst     = {1 'in'  ['power_on_rst']};
switch s.hw_sys
    case 'ROACH2'
        misc_ports.ctrl_mmcm_locked  = {1 'out' [s.adc_str,'_mmcm_locked']};
        misc_ports.mmcm_reset        = {1 'in'  [s.adc_str,'_mmcm_reset']};
        misc_ports.mmcm_psdone       = {1 'out' [s.adc_str,'_psdone']};
        misc_ports.mmcm_psclk        = {1 'in'  ['epb_clk']};
        misc_ports.mmcm_psen         = {1 'in'  [s.adc_str,'_psen']};
        misc_ports.mmcm_psincdec     = {1 'in'  [s.adc_str,'_psincdec']};
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end

b = set(b,'misc_ports',misc_ports);

% external ports
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.adc_clk_rate*1e6*2));

adcport = [s.hw_sys, '.', 'zdok', s.adc_str(length(s.adc_str))];

ext_ports.adc_clk_p         = {1 'in'   [s.adc_str,'_adc_clk_p']   ['{',adcport,'_p{[19]+1,:}}']    'vector=false'  mhs_constraints ucf_constraints_clock   };
ext_ports.adc_clk_n         = {1 'in'   [s.adc_str,'_adc_clk_n']   ['{',adcport,'_n{[19]+1,:}}']    'vector=false'  mhs_constraints ucf_constraints_clock   };
ext_ports.adc_sync_p        = {1 'in'   [s.adc_str,'_adc_sync_p']       };
ext_ports.adc_sync_n        = {1 'in'   [s.adc_str,'_adc_sync_n']       };
ext_ports.adc_or_a_p        = {1 'in'   [s.adc_str,'_adc_or_a_p']       };
ext_ports.adc_or_a_n        = {1 'in'   [s.adc_str,'_adc_or_a_n']       };
ext_ports.adc_or_b_p        = {1 'in'   [s.adc_str,'_adc_or_b_p']       };
ext_ports.adc_or_b_n        = {1 'in'   [s.adc_str,'_adc_or_b_n']       };
ext_ports.adc_data_a_p      = {10 'in'  [s.adc_str,'_adc_data_a_p']     };
ext_ports.adc_data_a_n      = {10 'in'  [s.adc_str,'_adc_data_a_n']     };
ext_ports.adc_data_b_p      = {10 'in'  [s.adc_str,'_adc_data_b_p']     };
ext_ports.adc_data_b_n      = {10 'in'  [s.adc_str,'_adc_data_b_n']     };
ext_ports.adc_reset         = {1 'out'  [s.adc_str,'_adc_reset']        };
ext_ports.adc_demux_bist    = {1 'out'  [s.adc_str,'_adc_demux_bist']   };

b = set(b,'ext_ports',ext_ports);
