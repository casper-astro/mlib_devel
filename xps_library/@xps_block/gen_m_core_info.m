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

function str = gen_m_core_info(blk_obj, mhs_str)
str = '';

inst_name = clear_name(blk_obj.simulink_name);

baseaddr = regexp(mhs_str, 'C_BASEADDR\s*=\s*0x(\w*)\s*', 'tokens');
highaddr = regexp(mhs_str, 'C_HIGHADDR\s*=\s*0x(\w*)\s*', 'tokens');

str = [str, sprintf('%s_type         = ''%s'';\n', inst_name, blk_obj.type)];
str = [str, sprintf('%s_param        = ''%s'';\n', inst_name, blk_obj.c_params)];

try
    str = [str, sprintf('%s_ip_name      = ''%s'';\n', inst_name, blk_obj.ip_name)];
catch
    str = [str, ''];
end

try
    str = [str, sprintf('%s_addr_start   = hex2dec(''%s'');\n', inst_name, baseaddr{1}{1})];
    str = [str, sprintf('%s_addr_end     = hex2dec(''%s'');\n', inst_name, highaddr{1}{1})];
catch
    str = [str, ''];
end

end