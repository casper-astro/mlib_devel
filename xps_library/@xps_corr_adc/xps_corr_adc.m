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

function b = xps_corr_adc(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_CORR_ADC class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_corr_adc')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end
blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.reg_clk_phase = get_param(blk_name,'reg_clk_phase');
[s.hw_sys,s.hw_adc] = xps_get_hw_info(get_param(blk_name,'adc_brd'));

switch s.hw_sys
    case 'CORR'
        switch s.hw_adc
            case 'adc_i'
                s.adc_str = 'adc_i';
            case 'adc_q'
                s.adc_str = 'adc_q';
            otherwise
                error(['Unsupported adc board: ',s.hw_adc]);
        end
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end
b = class(s,'xps_corr_adc',blk_obj);

% ip name
b = set(b,'ip_name','corr_adc_interface');

% parameters
parameters.CLK_PHASE = num2str(s.reg_clk_phase);
b = set(b,'parameters',parameters);

% misc ports
xsg_obj = get(blk_obj,'xsg_obj');
misc_ports.clk = {1 'in' get(xsg_obj,'clk_src')};
misc_ports.clk90 = {1 'in' get(xsg_obj,'clk90_src')};
b = set(b,'misc_ports',misc_ports);

% external ports
ext_ports.adc_din     = {12 'in'    [s.adc_str]    ['CORR.',s.adc_str]  'null'  'vector=true'};
b = set(b,'ext_ports',ext_ports);