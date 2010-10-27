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

function b = xps_x64_adc(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_x64_adc')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name  = get(blk_obj,'simulink_name');
inst_name = clear_name(blk_name);
xsg_obj   = get(blk_obj,'xsg_obj');

s.hw_sys       = get(xsg_obj,'hw_sys');
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
s.use_spi      = eval_param(blk_name,'spi');
s.ctrl_gpio    = get_param(blk_name,'ctrl_gpio');

if strcmp(s.ctrl_gpio, 'GPIO_A')
    s.ctrl_gpio = 'gpioa';
elseif strcmp(s.ctrl_gpio, 'GPIO_B')
    s.ctrl_gpio = 'gpiob';
else
    error('X64_ADC block ctrl interface is neither GPIO_A or GPIO_B');
end

switch s.hw_sys
    case 'ROACH'
        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/(s.adc_clk_rate*6)),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end

b = class(s,'xps_x64_adc',blk_obj);

% ip name and version
b = set(b, 'ip_name', 'x64_adc_interface');
b = set(b, 'ip_version', '1.00.a');

supp_ip_names    = {'', 'opb_x64_adc', 'spi_controller'};
supp_ip_versions = {'', '1.00.a', '1.00.a'};

b = set(b, 'supp_ip_names', supp_ip_names);
b = set(b, 'supp_ip_versions', supp_ip_versions);

% misc ports
%misc_ports.ctrl_reset      = {1 'in'  [s.adc_str,'_ddrb']};
%misc_ports.ctrl_clk_in     = {1 'in'  get(xsg_obj,'clk_src')};
%misc_ports.ctrl_clk_out    = {1 'out' [s.adc_str,'_clk']};
%misc_ports.ctrl_clk90_out  = {1 'out' [s.adc_str,'_clk90']};
%misc_ports.ctrl_dcm_locked = {1 'out' [s.adc_str,'_dcm_locked']};
%
%end
%misc_ports.dcm_psclk       = {1 'in'  [s.adc_str,'_psclk']};
%misc_ports.dcm_psen        = {1 'in'  [s.adc_str,'_psen']};
%misc_ports.dcm_psincdec    = {1 'in'  [s.adc_str,'_psincdec']};
%
%b = set(b,'misc_ports',misc_ports);


% external ports
mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.adc_clk_rate*1e6));
ctrl_iobname = [s.hw_sys, '.', s.ctrl_gpio];
ctrl_out_en_iobname = [s.hw_sys, '.', s.ctrl_gpio, '_oe_n'];
gpio_oe_n_constraints = struct('IOSTANDARD', 'LVCMOS33');
if strcmp(s.ctrl_gpio, 'gpioa')
    gpio_constraints = struct('IOSTANDARD', 'LVCMOS25');
else
    gpio_constraints = struct('IOSTANDARD', 'LVCMOS15');
end
    

s.adc_str = 'adc0';
adcport0 = [s.hw_sys, '.', 'zdok', s.adc_str(length(s.adc_str))];
s.adc_str = 'adc1';
adcport1 = [s.hw_sys, '.', 'zdok', s.adc_str(length(s.adc_str))];

ext_ports.in_0_n      = {8 'in'  'in_0_n'    ['{',adcport1,'_n{[30 31 32 33 34 35 36 37]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_1_n      = {8 'in'  'in_1_n'    ['{',adcport1,'_n{[20 21 22 23 24 25 26 27]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_2_n      = {8 'in'  'in_2_n'    ['{',adcport1,'_n{[0 1 2 3 4 5 6 7        ]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_3_n      = {8 'in'  'in_3_n'    ['{',adcport1,'_n{[10 11 12 13 14 15 16 17]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_4_n      = {8 'in'  'in_4_n'    ['{',adcport0,'_n{[30 31 32 33 34 35 36 37]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_5_n      = {8 'in'  'in_5_n'    ['{',adcport0,'_n{[20 21 22 23 24 25 26 27]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_6_n      = {8 'in'  'in_6_n'    ['{',adcport0,'_n{[0 1 2 3 4 5 6 7        ]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_7_n      = {8 'in'  'in_7_n'    ['{',adcport0,'_n{[10 11 12 13 14 15 16 17]+1,:}}'] 'vector=true' struct() ucf_constraints_term };

ext_ports.in_0_p      = {8 'in'  'in_0_p'    ['{',adcport1,'_p{[30 31 32 33 34 35 36 37]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_1_p      = {8 'in'  'in_1_p'    ['{',adcport1,'_p{[20 21 22 23 24 25 26 27]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_2_p      = {8 'in'  'in_2_p'    ['{',adcport1,'_p{[0 1 2 3 4 5 6 7        ]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_3_p      = {8 'in'  'in_3_p'    ['{',adcport1,'_p{[10 11 12 13 14 15 16 17]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_4_p      = {8 'in'  'in_4_p'    ['{',adcport0,'_p{[30 31 32 33 34 35 36 37]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_5_p      = {8 'in'  'in_5_p'    ['{',adcport0,'_p{[20 21 22 23 24 25 26 27]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_6_p      = {8 'in'  'in_6_p'    ['{',adcport0,'_p{[0 1 2 3 4 5 6 7        ]+1,:}}'] 'vector=true' struct() ucf_constraints_term };
ext_ports.in_7_p      = {8 'in'  'in_7_p'    ['{',adcport0,'_p{[10 11 12 13 14 15 16 17]+1,:}}'] 'vector=true' struct() ucf_constraints_term };

ext_ports.fc_0_n      = {1 'in'  'fc_0_n'    ['{',adcport1,'_n{[18]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_1_n      = {1 'in'  'fc_1_n'    ['{',adcport1,'_n{[38]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_2_n      = {1 'in'  'fc_2_n'    ['{',adcport1,'_n{[8 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_3_n      = {1 'in'  'fc_3_n'    ['{',adcport1,'_n{[9 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_4_n      = {1 'in'  'fc_4_n'    ['{',adcport0,'_n{[18]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_5_n      = {1 'in'  'fc_5_n'    ['{',adcport0,'_n{[38]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_6_n      = {1 'in'  'fc_6_n'    ['{',adcport0,'_n{[8 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_7_n      = {1 'in'  'fc_7_n'    ['{',adcport0,'_n{[9 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_0_p      = {1 'in'  'fc_0_p'    ['{',adcport1,'_p{[18]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_1_p      = {1 'in'  'fc_1_p'    ['{',adcport1,'_p{[38]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_2_p      = {1 'in'  'fc_2_p'    ['{',adcport1,'_p{[8 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_3_p      = {1 'in'  'fc_3_p'    ['{',adcport1,'_p{[9 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_4_p      = {1 'in'  'fc_4_p'    ['{',adcport0,'_p{[18]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_5_p      = {1 'in'  'fc_5_p'    ['{',adcport0,'_p{[38]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_6_p      = {1 'in'  'fc_6_p'    ['{',adcport0,'_p{[8 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };
ext_ports.fc_7_p      = {1 'in'  'fc_7_p'    ['{',adcport0,'_p{[9 ]+1,:}}'] 'vector=false' struct() ucf_constraints_term };

ext_ports.adc_clk_p   = {1 'in'  'adc_clk_p' ['{',adcport0,'_p{[39]+1,:}}'] 'vector=false' struct() ucf_constraints_clock};
ext_ports.adc_clk_n   = {1 'in'  'adc_clk_n' ['{',adcport0,'_n{[39]+1,:}}'] 'vector=false' struct() ucf_constraints_clock};

ext_ports.adc_rst     = {1 'out' [inst_name, '_rst_gpio_ext'] [ctrl_iobname, '  ([','0',']+1)'] 'vector=true' struct() gpio_constraints };
ext_ports.ctrl_out_en = {1 'out' [inst_name, '_ctrl_out_en' ] [ctrl_out_en_iobname, '  ([','0',']+1)'] 'vector=true' struct() gpio_oe_n_constraints };
if strcmp(s.use_spi,'on')
    ext_ports.spi_data = {1 'out' [inst_name, '_spi_data_gpio_ext'] [ctrl_iobname, '  ([','1',']+1)'] 'vector=true' struct() gpio_constraints};
    ext_ports.spi_sclk = {1 'out' [inst_name, '_spi_sclk_gpio_ext'] [ctrl_iobname, '  ([','2',']+1)'] 'vector=true' struct() gpio_constraints };
    ext_ports.spi_cs_n = {1 'out' [inst_name, '_spi_cs_gpio_ext'  ] [ctrl_iobname, '  ([','3',']+1)'] 'vector=true' struct() gpio_constraints };
end

b = set(b,'ext_ports',ext_ports);

