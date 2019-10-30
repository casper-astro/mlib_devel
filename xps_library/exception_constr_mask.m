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

cursys = gcb;

delay_blks = find_system(cursys, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Delay Block');

for i = 1:length(delay_blks)
    delay_blk = delay_blks{i};
    if regexp(get_param(delay_blk, 'Name'), '(delay)$')
        toks = regexp(get_param(delay_blk, 'Name'), '(delay)$', 'tokens');
        set_param(delay_blk, 'Name', clear_name([cursys, '_', toks{1}{1}]));
    else
        error(['Unknown gateway name: ', delay_blk]);
    end
end
