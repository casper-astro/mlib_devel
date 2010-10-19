%STATUS Displays the status of the KATCP server.
%
%    STATUS(KATCP_OBJ) prints the status of the KATCP server to the Matlab
%    command window.
%
%    MESSAGE = STATUS(KATCP_OBJ) returns the status message as a character
%    string.
%
%    See also KATCP/HELP, KATCP/LISTBOF, KATCP/LISTCMD, KATCP/LISTDEV
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%                                                                             %
%   Parallel Data Architectures Group, UCLA Electrical Engineering            %
%   http://icslwebs.ee.ucla.edu/dejan/researchwiki/index.php/Main_Page        %
%                                                                             %
%   Copyright (C) 2010 University of California                               %
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

function varargout = status(obj)

    fprintf(obj.tcpip_obj, ' ?status');
    pause(0.1);

    msg = '';

    while (get(obj.tcpip_obj, 'BytesAvailable') > 0)
        msg = [msg, fscanf(obj.tcpip_obj)];
    end

    switch nargout

        case 0
            disp(msg);

        case 1
            varargout(1) = {msg};

        otherwise
            disp(msg);

    end % switch nargout
