%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
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

function clean_blocks(cursys)
% Remove any blocks from a subsystem which are not connected
% to the rest of the system.
%
% clean_blocks(cursys)

try

blocks = get_param(cursys, 'Blocks');
for i=1:length(blocks),
    blk = [cursys,'/',blocks{i}];
    ports = get_param(blk, 'PortConnectivity');
    if ~isempty(ports),
        flag = 0;
        for j=1:length(ports),
            if ports(j).SrcBlock == -1,
                clog(['block ' cursys '/' get_param(blk,'Name') ...
                     ' input port ' num2str(j) ...
                     ' undriven (block will be deleted)'], ...
                     'clean_blocks_debug');
                flag = 0;
                break
            elseif ~flag && (length(ports(j).SrcBlock) ~= 0 || length(ports(j).DstBlock) ~= 0),
                flag = 1;
            end
        end
        if flag == 0,
            clog(['deleting block ' cursys '/' get_param(blk,'Name')], ...
                  'clean_blocks_debug');
            delete_block(blk);
        end
    end
end
catch ex
  dump_and_rethrow(ex);
end % try/catch
