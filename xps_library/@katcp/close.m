%CLOSE Closes connection to KATCP server.
%
%    STATUS = CLOSE(OBJ) closes the TCP/IP connection to the KATCP server
%    associated with KATCP object OBJ.
%
%    See also KATCP/HELP, KATCP/LISTBOF KATCP/LISTCMD, KATCP/LISTDEV,
%    KATCP/STATUS
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


function status = close(obj)

    status = 0;

    disp(['Trying to close KATCP connection to ', obj.hostname, '...']);

    try
        fclose(obj.tcpip_obj);
        delete(obj.tcpip_obj);
    catch
        status = -1;
        error(['Error trying to close KATCP connection to ', obj.hostname, '.']);
    end

    disp(['Connection to ', obj.hostname, ' closed.']);
