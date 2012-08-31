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

function [result,msg] = drc(blk_obj, xps_objs)
result = 0;
msg = '';

sysgen_blk = find_system(gcs, 'SearchDepth', 1,'FollowLinks','on','LookUnderMasks','all','Tag','genX');
if length(sysgen_blk) == 1
    xsg_blk = sysgen_blk{1};
else
    error('XPS block must be on the same level as the Xilinx SysGen block');
end

hw_sys=get(xps_objs{1},'hw_sys');

addr_width = blk_obj.addr_width;
data_width = blk_obj.data_width;

switch hw_sys
  case 'ROACH2'
    if addr_width < 2
      msg = 'Shared BRAM address width cannot be less than 2 on on ROACH boards';
	    result = 1;
    end
  case 'ROACH'
    if (addr_width + ceil(log2(data_width))) < 15,   
      msg = ['Shared BRAM address width cannot be less than ',num2str(15-ceil(log2(data_width))),' when using a data width of ',num2str(data_width),' on Virtex-5 boards'];
	    result = 1;
    end
  otherwise
    if addr_width < 11
      msg = 'Shared BRAM address width cannot be less than 11 on unknown platform';
	    result = 1;
    end
end
if addr_width > 16
    msg = 'Shared BRAM address width cannot be greater than 16';
	result = 1;
end

if isempty(find([8 16 32 64 128] == data_width))
    msg = 'Shared BRAM data width can only be 8,16,32,64 or 128';
	result = 1;
end

