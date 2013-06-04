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

function b = xps_qdr(blk_obj)

if ~isa(blk_obj,'xps_block')
    error('XPS_ADC class requires a xps_block class object');
end

if ~strcmp(get(blk_obj,'type'),'xps_qdr')
    error(['Wrong XPS block type: ',get(blk_obj,'type')]);
end

blk_name = get(blk_obj,'simulink_name');
xsg_obj  = get(blk_obj,'xsg_obj');

s.hw_sys   = get(xsg_obj,'hw_sys');
s.clk_src  = get(xsg_obj,'clk_src');
s.clk_rate = get(xsg_obj,'clk_rate');

s.hw_qdr      = get_param(blk_name,'which_qdr');
s.use_sniffer = num2str(strcmp(get_param(blk_name, 'use_sniffer'), 'on')); 

switch s.hw_sys
    case 'ROACH'
        s.addr_width = '22';
        s.data_width = '18';
        s.bw_width = '2';
        s.qdr_latency = '10';
    % end case 'ROACH'
    case 'ROACH2'
        s.addr_width = '21';
        s.data_width = '36';
        s.bw_width = '4';
        %s.qdr_latency = '14';
        s.qdr_latency = '10';
    % end case 'ROACH2'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % end switch s.hw_sys

b = class(s,'xps_qdr',blk_obj);

b = set(b, 'opb0_devices', 2); %sniffer and controller
