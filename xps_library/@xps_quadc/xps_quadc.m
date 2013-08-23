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

[hw_sys, hw_subsys] = xps_get_hw_plat(get(xsg_obj, 'hw_sys'));

s.hw_sys = hw_sys;
s.adc_brd = get_param(blk_name, 'adc_brd');
s.adc_str = ['adc', s.adc_brd];
s.adc_clk_rate = eval_param(blk_name,'adc_clk_rate');

switch s.hw_sys
    case 'iBOB'
        if isempty(find(strcmp(s.adc_brd, {'0', '1'})))
            error(['Unsupported adc board: ',s.adc_brd]);
        end % if isempty(find(strcmp(s.hw_adc, {'0', '1'})))

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25_DT', 'PERIOD', [num2str(1000/s.adc_clk_rate),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25_DT');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');

        parameters = '';
    % end case 'iBOB'
    case 'ROACH'
        if isempty(find(strcmp(s.adc_brd, {'0', '1'})))
            error(['Unsupported adc board: ',s.adc_brd]);
        end % if ~isempty(find(strcmp(s.hw_adc, {'0', '1'})))

        ucf_constraints_clock  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(1000/s.adc_clk_rate),' ns']);
        ucf_constraints_term   = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
        ucf_constraints_noterm = struct('IOSTANDARD', 'LVDS_25');

        parameters.CLK_FREQ    = num2str(s.adc_clk_rate);
    % end case 'ROACH'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_quadc',blk_obj);

% ip name & version
b = set(b,'ip_name','quadc_interface');
b = set(b,'ip_version','1.00.a');

% parameters

b = set(b,'parameters',parameters);


% misc ports
misc_ports.user_clk  =  {1 'in' get(xsg_obj,'clk_src')};
misc_ports.dcm_reset =  {1 'in' 'net_gnd'};
misc_ports.reset     =  {1 'in' 'net_gnd'};
misc_ports.adc0_clk  =  {1 'out' [s.adc_str, '_clk']};
misc_ports.adc1_clk  =  {1 'out' ['quadc0_', s.adc_brd, '_adc1_clk']};
misc_ports.adc2_clk  =  {1 'out' ['quadc0_', s.adc_brd, '_adc2_clk']};
misc_ports.adc3_clk  =  {1 'out' ['quadc0_', s.adc_brd, '_adc3_clk']};
misc_ports.adc0_clk90 = {1 'out' [s.adc_str, '_clk90']};
misc_ports.adc0_clk180 = {1 'out' [s.adc_str, '_clk180']};
misc_ports.adc0_clk270 = {1 'out' [s.adc_str, '_clk270']};

b = set(b,'misc_ports',misc_ports);

% external ports

mhs_constraints = struct('SIGIS','CLK', 'CLK_FREQ',num2str(s.adc_clk_rate*1e6));

% port indices are 0-indexed, +1 to convert to Matlab 1-indexing
ext_ports.adc0_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc0_clk_in_p']     ['{',hw_sys,'.zdok',s.adc_brd,'_p{[19]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc1_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc1_clk_in_p']     ['{',hw_sys,'.zdok',s.adc_brd,'_p{[39]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc2_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc2_clk_in_p']     ['{',hw_sys,'.zdok',s.adc_brd,'_p{[32]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc3_clk_in_p  = {1 'in' ['quadc',s.adc_brd,'_adc3_clk_in_p']     ['{',hw_sys,'.zdok',s.adc_brd,'_p{[30]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc0_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc0_data_in_p']    ['{',hw_sys,'.zdok',s.adc_brd,'_p{[29 9 18 28  8  7 17 27]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.adc1_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc1_data_in_p']    ['{',hw_sys,'.zdok',s.adc_brd,'_p{[37 6 16 26 36  5 15 25]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.adc2_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc2_data_in_p']    ['{',hw_sys,'.zdok',s.adc_brd,'_p{[35 4 14 24 34  3 13 23]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.adc3_data_in_p = {8 'in' ['quadc',s.adc_brd,'_adc3_data_in_p']    ['{',hw_sys,'.zdok',s.adc_brd,'_p{[33 2 12 22 20 10 11 21]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};

ext_ports.adc0_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc0_clk_in_n']     ['{',hw_sys,'.zdok',s.adc_brd,'_n{[19]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc1_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc1_clk_in_n']     ['{',hw_sys,'.zdok',s.adc_brd,'_n{[39]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc2_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc2_clk_in_n']     ['{',hw_sys,'.zdok',s.adc_brd,'_n{[32]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc3_clk_in_n  = {1 'in' ['quadc',s.adc_brd,'_adc3_clk_in_n']     ['{',hw_sys,'.zdok',s.adc_brd,'_n{[30]+1,:}}']                      'vector=false'  mhs_constraints ucf_constraints_clock};
ext_ports.adc0_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc0_data_in_n']    ['{',hw_sys,'.zdok',s.adc_brd,'_n{[29 9 18 28  8  7 17 27]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.adc1_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc1_data_in_n']    ['{',hw_sys,'.zdok',s.adc_brd,'_n{[37 6 16 26 36  5 15 25]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.adc2_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc2_data_in_n']    ['{',hw_sys,'.zdok',s.adc_brd,'_n{[35 4 14 24 34  3 13 23]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};
ext_ports.adc3_data_in_n = {8 'in' ['quadc',s.adc_brd,'_adc3_data_in_n']    ['{',hw_sys,'.zdok',s.adc_brd,'_n{[33 2 12 22 20 10 11 21]+1 ,:}}'] 'vector=true'   struct()        ucf_constraints_term};

ext_ports.sync_in_p      = {1 'in' ['quadc',s.adc_brd,'_sync_in_p']         ['{',hw_sys,'.zdok',s.adc_brd,'_p{[38]+1,:}}']                      'vector=false'  struct()        ucf_constraints_term};
ext_ports.sync_in_n      = {1 'in' ['quadc',s.adc_brd,'_sync_in_n']         ['{',hw_sys,'.zdok',s.adc_brd,'_n{[38]+1,:}}']                      'vector=false'  struct()        ucf_constraints_term};

b = set(b,'ext_ports',ext_ports);
