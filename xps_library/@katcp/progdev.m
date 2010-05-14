%PROGDEV Execute BOF on KATCP server.
%
%    PROGDEV(KATCP_OBJ, 'BOFFILE') requests that the KATCP server try to
%    program its FPGA device with the BORPH executable 'BOFFILE'.
%
%    Example:
%       roach=katcp('myroach.domain.edu');
%       progdev(roach, 'my_borph_file.bof');
%
%    The specified .BOF file must be available to the TCPBORPHSERVER as
%    viewable through KATCP/LISTBOF.
%
%    PROGDEV will print an abbreviated status response to the Matlab command
%    window:
%
%       '!progdev ok' or '!progdev fail'
%
%    This output can be suppressed by calling PROGDEV with the 'quiet' option:
%    PROGDEV(KATCP_OBJ, 'BOFFILE', 'quiet')
%
%    STATUS = PROGDEV(KATCP_OBJ, 'BOFFILE') returns 0 if device programming
%    was successful, and -1 if an error occurred.
%
%    [STATUS, MESSAGE] = PROGDEV(KATCP_OBJ, 'BOFFILE') returns the full KATCP
%    response message to the command request.
%
%    See also KATCP/HELP, KATCP/LISTBOF, KATCP/LISTDEV
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

function varargout = progdev(obj, boffile, varargin)

    status = 0;
    msg = '';

    fprintf(obj.tcpip_obj, ['?progdev ', boffile]);

    while 1

        bytes_available = get(obj.tcpip_obj, 'BytesAvailable');

        pause(0.001);

        if ( bytes_available ~= get(obj.tcpip_obj, 'BytesAvailable') || bytes_available < 1 )
            continue;
        else
            msg = [msg, transpose(fread(obj.tcpip_obj, get(obj.tcpip_obj, 'BytesAvailable')))];
            if isempty(strfind(char(msg), '!progdev'))
                continue;
            else
                break;
            end
        end % if ( bytes_available ~= get(obj.tcpip_obj, 'BytesAvailable') || bytes_available < 1 )

    end % while 1

    if (get(obj.tcpip_obj, 'BytesAvailable') > 0)
        msg = [msg, fread(obj.tcpip_obj, get(obj.tcpip_obj, 'BytesAvailable'))];
    end

    msg = char(msg);
    msg = regexprep(msg, '\\\_', ' ');

    quiet = ((nargin==3) && (strcmpi(varargin(1), 'quiet')));

    if ~isempty(strfind(msg, '!progdev fail'))
        status = -1;

        if ~quiet
            disp('!progdev fail');
        end
    else
        status = 0;

        if ~quiet
            disp('!progdev ok');
        end
    end

    results = [{status}, {msg}];

    for n=1:nargout
        varargout(n) = results(n);
    end
