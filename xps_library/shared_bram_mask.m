%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
%                                                                             %
%   Meerkat Telescope Project                                                 %
%   http://www.kat.ac.za                                                      %
%   Copyright (C) 2011                                                        %
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

c_sys = gcb;

arith_type  = get_param(c_sys, 'arith_type');
data_width  = str2num(get_param(c_sys, 'data_width'));
data_bin_pt = eval_param(c_sys, 'data_bin_pt');
addr_width  = eval_param(c_sys, 'addr_width');

%check parameters

fpga_arch = 'virtex5';
try
  % This is in a try/end block in case we are inside a library or other model
  % without a system generator block.
  xsg_blk = [strtok(gcs, '/') '/ System Generator'];
  fpga_arch = xlgetparam(xsg_blk, 'xilinxfamily');
end

switch fpga_arch
  case {'virtex6', 'Virtex6', 'virtex5', 'Virtex5'}
    %if addressing less than 32k bytes
    if (addr_width + ceil(log2(data_width))) < 15,   
      errordlg(['Shared BRAM address width cannot be less than ',num2str(15-ceil(log2(data_width))),' when using a data width of ',num2str(data_width),' on Virtex-5 boards']);
    end
  case 'virtex2p'
    if addr_width < 11 
      errordlg('Shared BRAM address width cannot be less than 11 on Virtex-II Pro boards');
    end
  otherwise
    if addr_width < 11 
      errordlg('Shared BRAM address width cannot be less than 11 on unknown board');
    end
end

if addr_width > 16,
  errordlg('Shared BRAM address width cannot be greater than 16');
end

%set up address manipulation blocks

try
  set_param([c_sys, '/calc_add'], 'data_width', num2str(data_width), 'addr_width', num2str(addr_width));
  set_param([c_sys, '/mem/calc_add'], 'data_width', num2str(data_width), 'addr_width', num2str(addr_width));
catch
  warning('Shared BRAM block "%s" is out of date (needs its link restored)', c_sys);
end

%set up cast blocks

set_param([c_sys, '/convert_din1'], 'n_bits', num2str(data_width), 'bin_pt', num2str(data_bin_pt));

%set up gateways

gateway_ins = find_system(c_sys, 'searchdepth', 1, 'FollowLinks', 'on', ...
  'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
set_param(gateway_ins{1}, 'n_bits', num2str(data_width), ...
  'arith_type', 'Unsigned', 'bin_pt', num2str(data_bin_pt), 'Name', clear_name([c_sys,'_data_out']));
gateway_outs =find_system(c_sys, 'searchdepth', 1, 'FollowLinks', 'on', ...
  'lookundermasks', 'all', 'masktype', 'Xilinx Gateway Out Block');
for i =1:length(gateway_outs)
  gw = gateway_outs{i};
  if regexp(get_param(gw, 'Name'), '_addr$')
    set_param(gw, 'Name', clear_name([c_sys, '_addr']));
  elseif regexp(get_param(gw, 'Name'), '_data_in$')
    set_param(gw, 'Name', clear_name([c_sys, '_data_in']));
  elseif regexp(get_param(gw, 'Name'), '_we$')
    set_param(gw, 'Name', clear_name([c_sys, '_we']));
  else
    errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', get_param(gw, 'Name')]);
  end
end

set_param([c_sys, '/mem/sim_data_in'], ...
  'arith_type', 'Unsigned', 'bin_pt', num2str(data_bin_pt), 'n_bits', num2str(data_width));

%set up simulation memory

latency = 1;
if strcmp(get_param(c_sys, 'reg_prim_output'), 'on')
  latency = latency + 1;
end
if strcmp(get_param(c_sys, 'reg_core_output'), 'on')
  latency = latency + 1;
end
set_param([c_sys, '/mem/ram'], 'latency', num2str(latency));

%set up various munge blocks (which may have to redraw, so disable library link first)

set_param(c_sys,'LinkStatus','inactive');

divisions = ceil(data_width/32);
for name = {'munge_in', 'mem/sim_munge_out'},
  try
    set_param([c_sys, '/', name{1}], ... 
      'divisions', num2str(divisions), ...
      'div_size', mat2str(repmat(min(32, data_width),1,divisions)), ...
      'order', ['[',num2str([divisions-1:-1:0]),']'], ...
      'arith_type_out', 'Unsigned', ...
      'bin_pt_out', num2str(data_bin_pt));
  catch
    warning('Shared BRAM block "%s" is out of date (needs its link restored)', c_sys);
  end
end %for

for name = {'mem/sim_munge_in', 'munge_out'},
  try
  set_param([c_sys, '/', name{1}], ... 
    'divisions', num2str(divisions), ...
    'div_size', mat2str(repmat(min(32, data_width),1,divisions)), ...
    'order', ['[',num2str([divisions-1:-1:0]),']'], ...
    'arith_type_out', arith_type, ...
    'bin_pt_out', num2str(data_bin_pt));
  catch
    warning('Shared BRAM block "%s" is out of date (needs its link restored)', c_sys);
  end
end
