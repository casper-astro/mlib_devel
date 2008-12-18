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

function [str,loc] = gen_borf_info(loc, blk_obj, real_address)
str = '';

short_name = regexp(blk_obj.simulink_name,'^\w*\/(.*)','tokens');
try
        short_name = short_name{1}{1};
catch
        short_name = blk_obj.simulink_name;
end

inst_name = clear_name(short_name);

try 
  borph_info = blk_obj.borph_info;
catch
  borph_info = {};
end

if isempty(borph_info)
  str = '';
else
  if ~isempty(real_address)
    str = [str, sprintf('%s %d %s %s\n', inst_name, borph_info.mode, dec2hex(real_address), dec2hex(borph_info.size))];
  else
    str = [str, sprintf('%s %d %s %s\n', inst_name, borph_info.mode, dec2hex(loc), dec2hex(borph_info.size))];
  end
end

loc = loc + 1;
