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

function b = xps_adc083000x2(blk_obj)

fprintf('Creating block object: xps_adc083000x2\n')

if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_adc083000x2')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

% Retrieve block configuration parameters
s.hw_sys = get(xsg_obj,'hw_sys');
s.use_adc0 = strcmp( get_param(blk_name, 'use_adc0'), 'on');
s.use_adc1 = strcmp( get_param(blk_name, 'use_adc1'), 'on');
s.demux_adc = strcmp( get_param(blk_name, 'demux_adc'), 'on');
s.using_ctrl = strcmp( get_param(blk_name, 'using_ctrl'), 'on' );


if s.demux_adc
    s.sysclk_rate = eval_param(blk_name,'adc_clk_rate')/8;
else
    s.sysclk_rate = eval_param(blk_name,'adc_clk_rate')/4;
end
if s.use_adc0
    s.adc_str = 'adc0';
else
    s.adc_str = 'adc1';
end
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
s.adc_interleave = strcmp( get_param(blk_name,'clock_sync'), 'on');
s.adc_str = 'adc0'; % "dominant" ADC is in ZDOK 0

switch s.hw_sys
    case 'ROACH'
        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
        ucf_constraints_single = struct('IOSTANDARD', 'LVCMOS25');
    % end case 'ROACH'
    case 'ROACH2'
        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/s.adc_clk_rate*4),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
        ucf_constraints_single = struct('IOSTANDARD', 'LVCMOS25');            
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_adc083000x2',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'adc083000x2_interface');
switch s.hw_sys
    case 'ROACH'
        b = set(b, 'ip_version', '1.00.a');
    case 'ROACH2'
        b = set(b, 'ip_version', '1.00.a');
end % switch s.hw_sys

% misc ports
% misc_ports.ctrl_reset      = {1 'in'  [s.adc_str,'_ddrb']};
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
misc_ports.sys_clk       = {1 'in'  'sys_clk'};

% if s.using_ctrl,
%     misc_ports.adc_ctrl_notSCS = {1 'in' 'adc_ctrl_notSCS'};
%     misc_ports.adc_ctrl_clk = {1 'in' 'adc_ctrl_clk'};
%     misc_ports.adc_ctrl_sdata = {1 'in' 'adc_ctrl_sdata'};
% end

% misc_ports.dcm_psen        = {1 'in'  [s.adc_str,'_psen']};
% misc_ports.dcm_psincdec    = {1 'in'  [s.adc_str,'_psincdec']};
% misc_ports.control_data = {1, 'in', 'adc_control_data'};
b = set(b,'misc_ports',misc_ports);

% external ports
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.adc_clk_rate*1e6));

% adcport = [s.hw_sys, '.', 'zdok', s.adc_str(length(s.adc_str))];
adc0port = [s.hw_sys, '.', 'zdok0'];%, s.adc_str(length(s.adc_str))];
adc1port = [s.hw_sys, '.', 'zdok1'];%, s.adc_str(length(s.adc_str))];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ADC0
ext_ports.adc0_clk_p         = {1 'in'  ['adc0','clk_p']         ['{',adc0port,'_p{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc0_clk_n         = {1 'in'  ['adc0','clk_n']         ['{',adc0port,'_n{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc0_sync_p        = {1 'in'  ['adc0','sync_p']        ['{',adc0port,'_p{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_sync_n        = {1 'in'  ['adc0','sync_n']        ['{',adc0port,'_n{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_outofrange_p = {1 'in'  ['adc0','outofrange_p'] ['{',adc0port,'_p{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_outofrange_n = {1 'in'  ['adc0','outofrange_n'] ['{',adc0port,'_n{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc0_dataeveni_p   = {8 'in'  ['adc0','dataeveni_p']   ['{',adc0port,'_p{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataeveni_n   = {8 'in'  ['adc0','dataeveni_n']   ['{',adc0port,'_n{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddi_p    = {8 'in'  ['adc0','dataoddi_p']    ['{',adc0port,'_p{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddi_n    = {8 'in'  ['adc0','dataoddi_n']    ['{',adc0port,'_n{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataevenq_p   = {8 'in'  ['adc0','dataevenq_p']   ['{',adc0port,'_p{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataevenq_n   = {8 'in'  ['adc0','dataevenq_n']   ['{',adc0port,'_n{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddq_p    = {8 'in'  ['adc0','dataoddq_p']    ['{',adc0port,'_p{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_dataoddq_n    = {8 'in'  ['adc0','dataoddq_n']    ['{',adc0port,'_n{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc0_reset        = {1 'out' ['adc0','_reset']        ['{',adc0port,'_p{[19]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
% ext_ports.adc0_notSCS        = {1 'out' ['adc0','_notSCS']        ['{',adc0port,'_p{[9]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
% ext_ports.adc0_sdata        = {1 'out' ['adc0','_sdata']        ['{',adc0port,'_n{[9]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
% ext_ports.adc0_sclk        = {1 'out' ['adc0','_sclk']        ['{',adc0port,'_n{[8]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ADC1
ext_ports.adc1_clk_p         = {1 'in'  ['adc1','clk_p']         ['{',adc1port,'_p{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc1_clk_n         = {1 'in'  ['adc1','clk_n']         ['{',adc1port,'_n{[39]+1,:}}']                         'vector=false'  mhs_constraints ucf_constraints_clock };
ext_ports.adc1_sync_p        = {1 'in'  ['adc1','sync_p']        ['{',adc1port,'_p{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_sync_n        = {1 'in'  ['adc1','sync_n']        ['{',adc1port,'_n{[38]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_outofrange_p = {1 'in'  ['adc1','outofrange_p'] ['{',adc1port,'_p{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_outofrange_n = {1 'in'  ['adc1','outofrange_n'] ['{',adc1port,'_n{[18]+1,:}}']                         'vector=false'  struct()        ucf_constraints_term };
ext_ports.adc1_dataeveni_p   = {8 'in'  ['adc1','dataeveni_p']   ['{',adc1port,'_p{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataeveni_n   = {8 'in'  ['adc1','dataeveni_n']   ['{',adc1port,'_n{[0 1 2 3 4 5 6 7]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddi_p    = {8 'in'  ['adc1','dataoddi_p']    ['{',adc1port,'_p{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddi_n    = {8 'in'  ['adc1','dataoddi_n']    ['{',adc1port,'_n{[10 11 12 13 14 15 16 17]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataevenq_p   = {8 'in'  ['adc1','dataevenq_p']   ['{',adc1port,'_p{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataevenq_n   = {8 'in'  ['adc1','dataevenq_n']   ['{',adc1port,'_n{[20 21 22 23 24 25 26 27]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddq_p    = {8 'in'  ['adc1','dataoddq_p']    ['{',adc1port,'_p{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_dataoddq_n    = {8 'in'  ['adc1','dataoddq_n']    ['{',adc1port,'_n{[30 31 32 33 34 35 36 37]+1,:}}']    'vector=true'   struct()        ucf_constraints_term };
ext_ports.adc1_reset       = {1 'out' ['adc1','_reset']        ['{',adc1port,'_p{[19]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
% ext_ports.adc1_notSCS        = {1 'out' ['adc1','_notSCS']        ['{',adc1port,'_p{[9]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
% ext_ports.adc1_sdata        = {1 'out' ['adc1','_sdata']        ['{',adc1port,'_n{[9]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };
% ext_ports.adc1_sclk        = {1 'out' ['adc1','_sclk']        ['{',adc1port,'_n{[8]+1,:}}']                         'vector=false'  struct()        ucf_constraints_single };


b = set(b,'ext_ports',ext_ports);
parameters.DEMUX_DATA_OUT  = num2str(s.demux_adc);
parameters.USE_ADC0 = num2str(s.use_adc0);
parameters.USE_ADC1 = num2str(s.use_adc1);
parameters.INTERLEAVE_BOARDS = num2str(s.adc_interleave);

b = set(b,'parameters',parameters);
% Software parameters
b = set(b,'c_params',['adc = ',s.adc_str,' / interleave = ',num2str(s.adc_interleave)]);
