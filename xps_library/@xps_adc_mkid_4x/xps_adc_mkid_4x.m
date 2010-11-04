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

function b = xps_adc_mkid_4x(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('xps_quadc class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_adc_mkid_4x')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

s.hw_sys = get(xsg_obj,'hw_sys');
s.adc_brd = get_param(blk_name, 'adc_brd');
s.adc_str = ['adc', s.adc_brd];

s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
s.clk_sys = get(xsg_obj,'clk_src');
  
  
b = class(s,'xps_adc_mkid_4x',blk_obj);

% ip name & version
b = set(b,'ip_name','adc_mkid_4x_interface');
b = set(b,'ip_version','1.00.a');

parameters.OUTPUT_CLK = '0';
if strfind(s.clk_sys,'adc')
  parameters.OUTPUT_CLK = '1';
end
  
b = set(b,'parameters',parameters);




%%%%%%%%%%%%%%%%%
% external ports
%%%%%%%%%%%%%%%%%
ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(2*1000/s.adc_clk_rate),' ns']);
ucf_constraints_term    = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(1e6*s.adc_clk_rate/2));


ext_ports.DRDY_I_p     = {1  'in' ['adcmkid',s.adc_brd,'_DRDY_I_p']     ['{',s.hw_sys,'.zdok',s.adc_brd,'_p{[20],:}}']                                'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.DRDY_I_n     = {1  'in' ['adcmkid',s.adc_brd,'_DRDY_I_n']     ['{',s.hw_sys,'.zdok',s.adc_brd,'_n{[20],:}}']                                'vector=false'  mhs_constraints ucf_constraints_clock};

ext_ports.DRDY_Q_p     = {1  'in' ['adcmkid',s.adc_brd,'_DRDY_Q_p']     ['{',s.hw_sys,'.zdok',s.adc_brd,'_p{[40],:}}']                                'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.DRDY_Q_n     = {1  'in' ['adcmkid',s.adc_brd,'_DRDY_Q_n']     ['{',s.hw_sys,'.zdok',s.adc_brd,'_n{[40],:}}']                                'vector=false'  mhs_constraints ucf_constraints_clock};

ext_ports.DI_p         = {12 'in' ['adcmkid',s.adc_brd,'_DI_p']         ['{',s.hw_sys,'.zdok',s.adc_brd,'_p{[17 37 7 27 26 36 25 35 16 15 6 5],:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.DI_n         = {12 'in' ['adcmkid',s.adc_brd,'_DI_n']         ['{',s.hw_sys,'.zdok',s.adc_brd,'_n{[17 37 7 27 26 36 25 35 16 15 6 5],:}}'] 'vector=true'   struct()        ucf_constraints_term};

ext_ports.DQ_p         = {12 'in' ['adcmkid',s.adc_brd,'_DQ_p']         ['{',s.hw_sys,'.zdok',s.adc_brd,'_p{[13 33 3 23 22 32 21 31 12 11 2 1],:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.DQ_n         = {12 'in' ['adcmkid',s.adc_brd,'_DQ_n']         ['{',s.hw_sys,'.zdok',s.adc_brd,'_n{[13 33 3 23 22 32 21 31 12 11 2 1],:}}'] 'vector=true'   struct()        ucf_constraints_term};

ext_ports.ADC_ext_in_p = {1  'in' ['adcmkid',s.adc_brd,'_ADC_ext_in_p'] ['{',s.hw_sys,'.zdok',s.adc_brd,'_p{[29],:}}']                                'vector=false'  struct()        ucf_constraints_term};
ext_ports.ADC_ext_in_n = {1  'in' ['adcmkid',s.adc_brd,'_ADC_ext_in_n'] ['{',s.hw_sys,'.zdok',s.adc_brd,'_n{[29],:}}']                                'vector=false'  struct()        ucf_constraints_term};


b = set(b,'ext_ports',ext_ports);

%%%%%%%%%%%%%
% misc ports
%%%%%%%%%%%%%
misc_ports.fpga_clk       = {1 'in'  get(xsg_obj,'clk_src')};

if  strfind(s.clk_sys,'adc')
  misc_ports.adc_clk_out    = {1 'out' [s.adc_str,'_clk']};
  misc_ports.adc_clk90_out    = {1 'out' [s.adc_str,'_clk90']};
  misc_ports.adc_clk180_out    = {1 'out' [s.adc_str,'_clk180']};
  misc_ports.adc_clk270_out    = {1 'out' [s.adc_str,'_clk270']};
end

misc_ports.adc_dcm_locked = {1 'out' [s.adc_str, '_dcm_locked']};

b = set(b,'misc_ports',misc_ports);
