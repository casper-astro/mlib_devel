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

function b = xps_dac_mkid_4x(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_DAC_MKID class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_dac_mkid_4x')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end


blk_name = get(blk_obj,'simulink_name');
xsg_obj = get(blk_obj,'xsg_obj');

    % s.hw_dac = 'dac0' or 'dac1' as specified by the user in the yellow
    % block.
s.hw_sys = get(xsg_obj,'hw_sys');
s.dac_brd = get_param(blk_name, 'dac_brd');
s.dac_str = ['dac', s.dac_brd];

    % The clock coming from the zdok to the fpga is reduced by a physical
    % circuit on the DAC_MKID board to half of the rate of the external 
    % clock provided by the user.  The external clock rate is provided by
    % the user (in MHz) on the dac_mkid yellow block.  The clock period 
    % will be used in units of 1/GHz.
s.dac_clk_rate = eval_param(blk_name,'dac_clk_rate')/2;
dac_clk_period = 1000/s.dac_clk_rate;

% get name fpga clock source
s.clk_sys = get(xsg_obj,'clk_src');




b = class(s,'xps_dac_mkid_4x',blk_obj);
b = set(b,'ip_name','dac_mkid_4x_interface');
b = set(b, 'ip_version', '1.01.a');

parameters.OUTPUT_CLK = '0';
if strfind(s.clk_sys,'dac')
  parameters.OUTPUT_CLK = '1';
end
b = set(b,'parameters',parameters);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% external ports
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Collection of parameters used to define ports.
ucf_constraints_clk  = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE', 'PERIOD', [num2str(dac_clk_period),' ns']);
ucf_constraints = struct('IOSTANDARD', 'LVDS_25', 'DIFF_TERM', 'TRUE');
mhs_constraints_clk = struct('SIGIS','CLK', 'CLK_FREQ',num2str(1e6*s.dac_clk_rate));


    % The system clock for the FPGA fabric is generated from the CLK_to_FPGA 
    % pins on the zdok from the MKID DAC.  Reminder: s.dac_str = dac0 or
    % dac1.
    
ext_ports.dac_clk_p   = {1  'in'   [s.dac_str,'_clk_p']    ['{',s.hw_sys,'.zdok',s.dac_brd,'_p{[40],:}}']      'vector=false'  mhs_constraints_clk ucf_constraints_clk};
ext_ports.dac_clk_n   = {1  'in'   [s.dac_str,'_clk_n']    ['{',s.hw_sys,'.zdok',s.dac_brd,'_n{[40],:}}']      'vector=false'  mhs_constraints_clk ucf_constraints_clk};

    % DCLK is used to clock out data to the DAC.
ext_ports.dac_smpl_clk_i_p   = {1  'out'   [s.dac_str,'_smpl_clk_i_p']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_p{[30],:}}']    'vector=false'   struct()  ucf_constraints};
ext_ports.dac_smpl_clk_i_n   = {1  'out'   [s.dac_str,'_smpl_clk_i_n']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_n{[30],:}}']    'vector=false'   struct()  ucf_constraints};
ext_ports.dac_smpl_clk_q_p   = {1  'out'   [s.dac_str,'_smpl_clk_q_p']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_p{[29],:}}']    'vector=false'   struct()  ucf_constraints};
ext_ports.dac_smpl_clk_q_n   = {1  'out'   [s.dac_str,'_smpl_clk_q_n']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_n{[29],:}}']    'vector=false'   struct()  ucf_constraints};

    % I and Q output.
ext_ports.dac_data_i_p   = {16 'out'    [s.dac_str,'_data_i_p']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_p{[26 15 35 5 25 16 36 6 37 17 27 7 18 38 8 28],:}}']    'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_i_n   = {16 'out'    [s.dac_str,'_data_i_n']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_n{[26 15 35 5 25 16 36 6 37 17 27 7 18 38 8 28],:}}']    'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_q_p   = {16 'out'    [s.dac_str,'_data_q_p']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_p{[22 11 31 1 21 12 32 2 33 13 23 3 14 34 4 24],:}}']    'vector=true'  struct() ucf_constraints};
ext_ports.dac_data_q_n   = {16 'out'    [s.dac_str,'_data_q_n']   ['{',s.hw_sys,'.zdok',s.dac_brd,'_n{[22 11 31 1 21 12 32 2 33 13 23 3 14 34 4 24],:}}']    'vector=true'  struct() ucf_constraints};

    % When dac_sync is high, dac output is enabled.
ext_ports.dac_sync_i_p   = {1 'out' [s.dac_str,'_sync_i_p']  ['{',s.hw_sys,'.zdok',s.dac_brd,'_p{[39],:}}']   'vector=false'  struct() ucf_constraints};
ext_ports.dac_sync_i_n   = {1 'out' [s.dac_str,'_sync_i_n']  ['{',s.hw_sys,'.zdok',s.dac_brd,'_n{[39],:}}']   'vector=false'  struct() ucf_constraints};
ext_ports.dac_sync_q_p   = {1 'out' [s.dac_str,'_sync_q_p']  ['{',s.hw_sys,'.zdok',s.dac_brd,'_p{[20],:}}']   'vector=false'  struct() ucf_constraints};
ext_ports.dac_sync_q_n   = {1 'out' [s.dac_str,'_sync_q_n']  ['{',s.hw_sys,'.zdok',s.dac_brd,'_n{[20],:}}']   'vector=false'  struct() ucf_constraints};
    
  
% Serial data enabled on low, which is why it's controlled by a not
    % sdenb.
ext_ports.dac_not_sdenb_i = {1 'out'   [s.dac_str,'_not_sdenb_i']   ['{',s.hw_sys,'.zdok',s.dac_brd,'{[18],:}}']   'vector=false'  struct()    struct()};
ext_ports.dac_not_sdenb_q = {1 'out'   [s.dac_str,'_not_sdenb_q']   ['{',s.hw_sys,'.zdok',s.dac_brd,'{[19],:}}']   'vector=false'  struct()    struct()};

    % SCLK is the clock used to write data to the DAC for configuration.
ext_ports.dac_sclk = {1 'out'   [s.dac_str,'_sclk']   ['{',s.hw_sys,'.zdok',s.dac_brd,'{[17],:}}']   'vector=false'  struct()    struct()};

    % Each dac chip is wired for 4-wire interface, with only the input
    % available on the zdok.
ext_ports.dac_sdi = {1 'out'   [s.dac_str,'_sdi']    ['{',s.hw_sys,'.zdok',s.dac_brd,'{[37],:}}']    'vector=false'  struct()    struct()};

    % Resets the dac when low.
ext_ports.dac_not_reset = {1 'out'   [s.dac_str,'_not_reset']  ['{',s.hw_sys,'.zdok',s.dac_brd,'{[38],:}}']    'vector=false'  struct()    struct()};

    % This is mapped to a circuit on the board, and not on the chips
    % themselves.  If dac_phase is low, both dac chips are in phase.
%ext_ports.dac_phase = {1 'in'   [s.dac_str,'_pase']  '{ROACH.zdok0{[20],:}}' 'vector=false'  struct()    struct()};



b = set(b, 'ext_ports', ext_ports);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% misc ports
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
misc_ports.dac_dcm_locked = {1 'out' [s.dac_str, '_dcm_locked']};
 
if  strfind(s.clk_sys,'dac')
  misc_ports.dac_clk_out    = {1 'out' [s.dac_str,'_clk']};
  misc_ports.dac_clk90_out    = {1 'out' [s.dac_str,'_clk90']};
  misc_ports.dac_clk180_out    = {1 'out' [s.dac_str,'_clk180']};
  misc_ports.dac_clk270_out    = {1 'out' [s.dac_str,'_clk270']};
else
 misc_ports.fpga_clk = {1  'in'  get(xsg_obj,'clk_src')};
end

b = set(b,'misc_ports',misc_ports);





