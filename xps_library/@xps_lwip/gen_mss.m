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

function str = gen_mss(blk_obj)
str = '';

inst_name = clear_name(get(blk_obj,'simulink_name'));
emaclite_name = [clear_name(get(blk_obj, 'parent')), '_', 'ethlite'];

str = [str, 'BEGIN LIBRARY\n'];
str = [str, ' PARAMETER LIBRARY_NAME = lwip\n'];
str = [str, ' PARAMETER LIBRARY_VER = 2.00.a\n'];
str = [str, ' PARAMETER PROC_INSTANCE = ppc405_1\n'];
str = [str, ' PARAMETER MEM_SIZE = 1000100\n'];
str = [str, ' PARAMETER LWIP_DEBUG = false\n'];
str = [str, ' PARAMETER EMACLITE_INSTANCES = ((', emaclite_name, ',0x00,0x12,0x6d,0x1b,0x0b,0x05))\n'];
str = [str, 'end\n'];
