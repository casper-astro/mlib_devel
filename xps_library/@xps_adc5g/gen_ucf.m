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

function str = gen_ucf(blk_obj)

hw_sys = blk_obj.hw_sys;
blk_name = get(blk_obj,'simulink_name');

% Get some parameters we're intereset in
simulink_name = clear_name(get(blk_obj,'simulink_name'));
str = gen_ucf(blk_obj.xps_block);
demux = blk_obj.demux;

switch hw_sys

    case 'ROACH'
        % pass
    case 'ROACH2'
        if strcmp(demux, '1:2')
            % Create an area group to place the FD close to the IOPAD
            % which for some reason was traced to the other side of the 
            % chip on ROACH2
            str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                '/iddrx[1].iddr1a_fd"     AREA_GROUP     = IDDR_1 ;\n'];
            str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                '/iddrx[1].iddr1b_fd"     AREA_GROUP     = IDDR_1 ;\n'];
            str = [str, 'AREA_GROUP "IDDR_1"     RANGE    = ', ...
                'SLICE_X0Y317:SLICE_X5Y321 ;\n'];
        end
    otherwise 
        % pass
end