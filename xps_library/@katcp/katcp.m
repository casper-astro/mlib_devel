%KATCP Construct a KATCP-class object.
%
%    KATCP_OBJ = KATCP('RHOST') constructs a KATCP object KATCP_OBJ, that
%    opens and represents the connection to a remote host RHOST running a
%    KATCP server on port 7147.
%
%    See also KATCP/HELP, KATCP/LISTBOF KATCP/LISTCMD, KATCP/LISTDEV,
%    KATCP/STATUS, KATCP/CLOSE
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

function katcp_obj = katcp(rhost, varargin)

    tcpip_obj = tcpip(rhost, 7147);

    set(tcpip_obj, 'OutputBufferSize', 524288); % Increase TCP/IP output buffer size to 512KB (from 512B default)
    set(tcpip_obj, 'InputBufferSize',  524288); % Increase TCP/IP input buffer size to 512KB (from 512B default)

    try
        fopen(tcpip_obj);
    catch
        error('Unable to open connection to remote host ', rhost, ' on port 7147.');
    end % try

    fprintf(tcpip_obj, '\n');

    out = '';

    while (get(tcpip_obj, 'BytesAvailable') > 0)
        out = [out, fscanf(tcpip_obj)];
    end

    disp(out);

    s.tcpip_obj = tcpip_obj;
    s.hostname  = rhost;

    katcp_obj = class(s, 'katcp');
