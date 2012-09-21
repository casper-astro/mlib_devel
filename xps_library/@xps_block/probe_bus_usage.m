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

function [opbs, opb_addr_end, opb0_devices] = probe_bus_usage(blk_obj, opb_addr_start)

%the number of interfaces hard-coded to reside on opb0
opb0_devices = 0;
try
  opb0_devices = blk_obj.opb0_devices;
end;

opbs = 0;
range_opb = 0;
try
  range_opb = blk_obj.opb_address_offset;
end
opbs = sum(range_opb ~= 0);

align_opb = 0;
try
  align_opb = blk_obj.opb_address_align;
end

if length(align_opb) ~= length(range_opb),
  error(['opb_address_align and opb_address_offset lengths are different for ',blk_obj.simulink_name]); 
end

opb_addr_end = opb_addr_start;
for opb = 1:length(range_opb),
  if range_opb(opb) ~= 0, 
    if align_opb(opb) ~= 0,
      opb_addr_start = ceil(opb_addr_start/align_opb(opb)) * align_opb(opb);
    end
    opb_addr_end = opb_addr_start + range_opb(opb); 
  end
end
clog([get(blk_obj,'simulink_name'),': align (0x',dec2hex(align_opb,8),') range (0x',dec2hex(range_opb,8),') (0x',dec2hex(opb_addr_start,8),'-0x',dec2hex(opb_addr_end-1,8),')'],{'probe_bus_usage_debug'});
