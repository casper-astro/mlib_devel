% forty_gbe_init
%
% mask callback function

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Meerkat radio telescope project                                           %
%   www.kat.ac.za                                                             %
%   Copyright (C) Andrew Martens 2011                                         %
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

function forty_gbe_init()

clog('entering forty_gbe_init', 'trace');

currPort = eval(get_param(gcb, 'port'));

forty_gbe_xsg_blks = find_system(bdroot, 'SearchDepth', 1, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'xps:forty_gbe');

if length(forty_gbe_xsg_blks) > 1
        
    for blks =  1:length(forty_gbe_xsg_blks)
        if ~strcmp(gcb , forty_gbe_xsg_blks{blks})
            temp = forty_gbe_xsg_blks{blks};
            selPort = eval(get_param(temp, 'port')); 
            if selPort == currPort
                error(strcat('forty_gbe port: ',num2str(currPort), ' is already used. Please choose an available port.'));
                return;
            end
        end
    end

    %if currPort  >= length(forty_gbe_xsg_blks)
    %  error(strcat('forty gbe ports needs to be contiguous starting with 0. Please select a port less than ,',num2str(length(forty_gbe_xsg_blks)),' for Block:',gcb));  
    %  return;
   %end
end

clog('exiting forty_gbe_init', 'trace');

% end

