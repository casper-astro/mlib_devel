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

function b = xps_quadc(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('xps_quadc class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_quadc')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');
s.hw_sys = 'iBOB';
s.adc_brd = get_param(blk_name, 'adc_brd');
s.adc_str = ['adc', s.adc_brd];
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
b = class(s,'xps_quadc',blk_obj);

% ip name & version
b = set(b,'ip_name','quadc_interface');
b = set(b,'ip_version','1.00.a');

% parameters

% misc ports
misc_ports.user_clk  =  {1 'in' get(xsg_obj,'clk_src')};
misc_ports.dcm_reset =  {1 'in' 'net_gnd'};
misc_ports.reset     =  {1 'in' 'net_gnd'};
misc_ports.adc0_clk  =  {1 'out' [s.adc_str, '_clk']};
misc_ports.adc1_clk  =  {1 'out' ['quadc0_', s.adc_brd, '_adc1_clk']};
misc_ports.adc2_clk  =  {1 'out' ['quadc0_', s.adc_brd, '_adc2_clk']};
misc_ports.adc3_clk  =  {1 'out' ['quadc0_', s.adc_brd, '_adc3_clk']};
misc_ports.adc0_clk90 = {1 'out' [s.adc_str, '_clk90']};

b = set(b,'misc_ports',misc_ports);

% external ports

% port indices are 0-indexed, +1 to convert to Matlab 1-indexing
ext_ports.adc0_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc0_clk_in_p']     ['{iBOB.zdok',s.adc_brd,'_p{[19]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc1_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc1_clk_in_p']     ['{iBOB.zdok',s.adc_brd,'_p{[39]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc2_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc2_clk_in_p']     ['{iBOB.zdok',s.adc_brd,'_p{[32]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc3_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc3_clk_in_p']     ['{iBOB.zdok',s.adc_brd,'_p{[30]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc0_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc0_data_in_p']    ['{iBOB.zdok',s.adc_brd,'_p{[29 9 18 28  8  7 17 27]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};
ext_ports.adc1_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc1_data_in_p']    ['{iBOB.zdok',s.adc_brd,'_p{[37 6 16 26 36  5 15 25]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};
ext_ports.adc2_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc2_data_in_p']    ['{iBOB.zdok',s.adc_brd,'_p{[35 4 14 24 34  3 13 23]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};
ext_ports.adc3_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc3_data_in_p']    ['{iBOB.zdok',s.adc_brd,'_p{[33 2 12 22 20 10 11 21]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};

ext_ports.adc0_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc0_clk_in_n']     ['{iBOB.zdok',s.adc_brd,'_n{[19]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc1_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc1_clk_in_n']     ['{iBOB.zdok',s.adc_brd,'_n{[39]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc2_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc2_clk_in_n']     ['{iBOB.zdok',s.adc_brd,'_n{[32]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc3_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc3_clk_in_n']     ['{iBOB.zdok',s.adc_brd,'_n{[30]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.adc0_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc0_data_in_n']    ['{iBOB.zdok',s.adc_brd,'_n{[29 9 18 28  8  7 17 27]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};
ext_ports.adc1_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc1_data_in_n']    ['{iBOB.zdok',s.adc_brd,'_n{[37 6 16 26 36  5 15 25]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};
ext_ports.adc2_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc2_data_in_n']    ['{iBOB.zdok',s.adc_brd,'_n{[35 4 14 24 34  3 13 23]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};
ext_ports.adc3_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc3_data_in_n']    ['{iBOB.zdok',s.adc_brd,'_n{[33 2 12 22 20 10 11 21]+1 ,:}}']   'LVDS_25_DT'    'vector=true'};

ext_ports.sync_in_p      = {1 'in' ['quadc',s.adc_brd,'_sync_in_p']         ['{iBOB.zdok',s.adc_brd,'_p{[38]+1,:}}']                        'LVDS_25_DT'    'vector=false'};
ext_ports.sync_in_n      = {1 'in' ['quadc',s.adc_brd,'_sync_in_n']         ['{iBOB.zdok',s.adc_brd,'_n{[38]+1,:}}']                        'LVDS_25_DT'    'vector=false'};

b = set(b,'ext_ports',ext_ports);
