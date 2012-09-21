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

function [str,opb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj,opb_addr_start,opb_name)

hw_adc = get(blk_obj, 'hw_adc');

%% HACK HACK HACK HACK HACK HACK HACK HACK HACK HACK HACK HACK 
%% Remove gain control ports from adc_interface intstantiation
%gain_load_port = '';
%gain_value_port = '';
%clk_src  = get(blk_obj,'clk_src'); 
%en_gain  = get(blk_obj,'en_gain'); 

%foo = get(blk_obj,'ports');
%portname = fieldnames(foo);
%for n = 1:length(portname)
%  if (~isempty(regexp(portname{n},'gain_value')))
%    gain_value_port = portname{n};
%    foo = rmfield(foo, portname{n});
%  end
%  if (~isempty(regexp(portname{n},'gain_load')))
%    gain_load_port = portname{n};
%    foo = rmfield(foo, portname{n});
%  end
%  %port_names{n}
%end

%blk_obj = set(blk_obj,'ports',foo);

% Add the MHS entry for the ADC Interface
[str,opb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj.xps_block, opb_addr_start, opb_name);
str = [str, '\n'];

if (strcmp(hw_adc, 'adc1'))
  base_addr = '0x00048000';
  high_addr = '0x000487ff';
else
  base_addr = '0x00040000';
  high_addr = '0x000407ff';
end

% Add IIC controller
str = [str, 'BEGIN kat_adc_iic_controller',                               '\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a',                                 '\n'];
str = [str, ' PARAMETER INSTANCE = iic_', hw_adc,                         '\n'];
str = [str, ' PARAMETER C_BASEADDR = ', base_addr,                        '\n'];
str = [str, ' PARAMETER C_HIGHADDR = ', high_addr,                        '\n'];

%if (strcmp(en_gain,'on'))
%  str = [str, ' PARAMETER EN_GAIN = 1',                                   '\n'];
%end

str = [str, ' PARAMETER CORE_FREQ = 66666',                               '\n'];
str = [str, ' PARAMETER IIC_FREQ = 100',                                  '\n'];
str = [str, ' BUS_INTERFACE SOPB = opb0',                                 '\n'];
str = [str, ' PORT OPB_Clk = epb_clk',                                    '\n'];
str = [str, '',                                                           '\n'];
str = [str, ' PORT sda_i = iic_', hw_adc, '_sda_i',                       '\n'];
str = [str, ' PORT sda_o = iic_', hw_adc, '_sda_o',                       '\n'];
str = [str, ' PORT sda_t = iic_', hw_adc, '_sda_t',                       '\n'];
str = [str, ' PORT scl_i = iic_', hw_adc, '_scl_i',                       '\n'];
str = [str, ' PORT scl_o = iic_', hw_adc, '_scl_o',                       '\n'];
str = [str, ' PORT scl_t = iic_', hw_adc, '_scl_t',                       '\n'];
%str = [str, ' PORT gain_value = ', gain_value_port,                       '\n'];
%str = [str, ' PORT gain_load  = ', gain_load_port,                        '\n'];
str = [str, ' PORT app_clk    = epb_clk',                                 '\n'];
str = [str, 'END',                                                        '\n'];
str = [str, '',                                                           '\n'];
str = [str, 'PORT ', hw_adc, '_iic_sda = ', hw_adc, '_iic_sda, DIR = IO', '\n'];
str = [str, 'PORT ', hw_adc, '_iic_scl = ', hw_adc, '_iic_scl, DIR = IO', '\n'];
str = [str, '',                                                           '\n'];
str = [str, 'BEGIN iic_infrastructure',                                   '\n'];
str = [str, ' PARAMETER HW_VER = 1.00.a',                                 '\n'];
str = [str, ' PARAMETER INSTANCE = iic_infrastructure_', hw_adc,          '\n'];
str = [str, ' PORT Sda_I = iic_', hw_adc, '_sda_i',                       '\n'];
str = [str, ' PORT Sda_O = iic_', hw_adc, '_sda_o',                       '\n'];
str = [str, ' PORT Sda_T = iic_', hw_adc, '_sda_t',                       '\n'];
str = [str, ' PORT Scl_I = iic_', hw_adc, '_scl_i',                       '\n'];
str = [str, ' PORT Scl_O = iic_', hw_adc, '_scl_o',                       '\n'];
str = [str, ' PORT Scl_T = iic_', hw_adc, '_scl_t',                       '\n'];
str = [str, ' PORT Sda   = ', hw_adc, '_iic_sda',                         '\n'];
str = [str, ' PORT Scl   = ', hw_adc, '_iic_scl',                         '\n'];
str = [str, 'END',                                                        '\n'];

