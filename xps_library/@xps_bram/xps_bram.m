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
s.addr_width = eval_param(blk_name,'addr_width');
s.data_width = eval_param(blk_name,'data_width');

b = class(s,'xps_bram',blk_obj);

% ip name
b = set(b,'ip_name','bram_if');

% software driver
b = set(b,'soft_driver',{'bram' '1.00.a'});

% address offset
b = set(b,'opb_address_offset',eval_param(blk_name,'data_width')/8*(2^s.addr_width));

% software parameters
b = set(b,'c_params',num2str((2^s.addr_width)*eval_param(blk_name,'data_width')/32));

% borf parameters
borph_info.size = (2^s.addr_width)*eval_param(blk_name,'data_width')/8;

borph_info.mode = 3;
b = set(b,'borph_info',borph_info);
