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

function b = xps_adc086000(blk_obj)

disp('xps_adc086000 called')

if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_adc086000')
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
    case 'ROACH'
        if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))
            s.adc_str = s.hw_adc;
        else
            error(['Unsupported adc board: ',s.hw_adc]);
        end % if ~isempty(find(strcmp(s.hw_adc, {'adc0', 'adc1'})))

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
        ucf_constraints_single = struct('IOSTANDARD', 'LVCMOS25');
    % end case 'ROACH'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_adc086000',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'adc086000_interface');
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
if strcmp(get(b,'ip_version'), '1.01.a')
    misc_ports.dcm_reset        = {1 'in'  [s.adc_str,'_dcm_reset']};
    misc_ports.dcm_psdone       = {1 'out' [s.adc_str,'_psdone']};
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
adc0port = [s.hw_sys, '.', 'zdok0']%, s.adc_str(length(s.adc_str))];
adc1port = [s.hw_sys, '.', 'zdok1']%, s.adc_str(length(s.adc_str))];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ADC0
ext_ports.adc0_clk_p         = {1 'in'  ['adc0','clk_p']         ['{',adc0port,'_p{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc0_clk_n         = {1 'in'  ['adc0','clk_n']         ['{',adc0port,'_n{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc0_sync_p        = {1 'in'  ['adc0','sync_p']        ['{',adc0port,'_p{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_sync_n        = {1 'in'  ['adc0','sync_n']        ['{',adc0port,'_n{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_outofrange_p = {1 'in'  ['adc0','outofrange_p'] ['{',adc0port,'_p{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_outofrange_n = {1 'in'  ['adc0','outofrange_n'] ['{',adc0port,'_n{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_dataeveni_p   = {8 'in'  ['adc0','dataeveni_p']   ['{',adc0port,'_p{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataeveni_n   = {8 'in'  ['adc0','dataeveni_n']   ['{',adc0port,'_n{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataevenq_p    = {8 'in'  ['adc0','dataevenq_p']    ['{',adc0port,'_p{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataevenq_n    = {8 'in'  ['adc0','dataevenq_n']    ['{',adc0port,'_n{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddi_p   = {8 'in'  ['adc0','dataoddi_p']   ['{',adc0port,'_p{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddi_n   = {8 'in'  ['adc0','dataoddi_n']   ['{',adc0port,'_n{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddq_p    = {8 'in'  ['adc0','dataoddq_p']    ['{',adc0port,'_p{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddq_n    = {8 'in'  ['adc0','dataoddq_n']    ['{',adc0port,'_n{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_reset        = {1 'out' ['adc0','_reset']        ['{',adc0port,'_p{[19]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
%ext_ports.adc0_ddrb_n        = {1 'out' ['adc0','ddrb_n']        ['{',adc0port,'_n{[19]+1,:}}']                         'vector=false'  struct()        ucf_constraints_noterm };

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ADC1
ext_ports.adc1_clk_p         = {1 'in'  ['adc1','clk_p']         ['{',adc1port,'_p{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc1_clk_n         = {1 'in'  ['adc1','clk_n']         ['{',adc1port,'_n{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc1_sync_p        = {1 'in'  ['adc1','sync_p']        ['{',adc1port,'_p{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_sync_n        = {1 'in'  ['adc1','sync_n']        ['{',adc1port,'_n{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_outofrange_p = {1 'in'  ['adc1','outofrange_p'] ['{',adc1port,'_p{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_outofrange_n = {1 'in'  ['adc1','outofrange_n'] ['{',adc1port,'_n{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_dataeveni_p   = {8 'in'  ['adc1','dataeveni_p']   ['{',adc1port,'_p{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataeveni_n   = {8 'in'  ['adc1','dataeveni_n']   ['{',adc1port,'_n{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataevenq_p    = {8 'in'  ['adc1','dataevenq_p']    ['{',adc1port,'_p{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataevenq_n    = {8 'in'  ['adc1','dataevenq_n']    ['{',adc1port,'_n{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddi_p   = {8 'in'  ['adc1','dataoddi_p']   ['{',adc1port,'_p{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddi_n   = {8 'in'  ['adc1','dataoddi_n']   ['{',adc1port,'_n{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddq_p    = {8 'in'  ['adc1','dataoddq_p']    ['{',adc1port,'_p{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddq_n    = {8 'in'  ['adc1','dataoddq_n']    ['{',adc1port,'_n{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_reset       = {1 'out' ['adc1','_reset']        ['{',adc1port,'_p{[19]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
%ext_ports.adc1_ddrb_n        = {1 'out' ['adc1','ddrb_n']        ['{',adc1port,'_n{[19]+1,:}}']                         'vector=false'  struct()        ucf_constraints_noterm };


b = set(b,'ext_ports',ext_ports);

% Software parameters
b = set(b,'c_params',['adc = ',s.adc_str,' / interleave = ',s.adc_interleave]);
