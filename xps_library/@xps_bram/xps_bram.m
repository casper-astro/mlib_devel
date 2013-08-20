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

function b = xps_bram(blk_obj)
if ~isa(blk_obj,'xps_block')
    error('XPS_GPIO class requires a xps_block class object');
end
if ~strcmp(get(blk_obj,'type'),'xps_bram')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
s.hw_sys = 'any';
s.addr_width      = eval_param(blk_name,'addr_width');
s.data_width      = str2num(get_param(blk_name,'data_width'));

% Set s.optimation to default value, then try to set it
% from block parameters.  Old blocks may not have this parameter.
s.optimization = 'Minimum_Area';
try
  s.optimization    = get_param(blk_name,'optimization');
catch
  % Issue warning that use might want to update links
  warning('Shared BRAM block "%s" is out of date (needs its link restored)', blk_name);
end

% Old blocks may not have this parameter, start with default value.
s.reg_core_output = 'false';
try
  if strcmpi(get_param(blk_name,'reg_core_output'), 'on')
     s.reg_core_output = 'true';
  end
end

% Old blocks may not have this parameter, start with default value.
s.reg_prim_output = 'false';
try
  if strcmpi(get_param(blk_name,'reg_prim_output'), 'on')
     s.reg_prim_output = 'true';
  end
end

b = class(s,'xps_bram',blk_obj);

% ip name
b = set(b,'ip_name','bram_if');

% software driver
b = set(b,'soft_driver',{'bram' '1.00.a'});

% address offset
b = set(b,'opb_address_offset',s.data_width/8*(2^s.addr_width));

% address alignment 
b = set(b,'opb_address_align',(32/8) * 2^(s.addr_width+log2(s.data_width/32)));

% software parameters
b = set(b,'c_params',num2str((2^s.addr_width)*s.data_width/32));

% borf parameters
borph_info.size = (2^s.addr_width)*s.data_width/8;
borph_info.mode = 3;
b = set(b,'borph_info',borph_info);
