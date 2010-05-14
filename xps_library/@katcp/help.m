%HELP Displays HELP from KATCP server.
%
%    HELP(KATCP_OBJ) displays a list of KATCP commands available to the KATCP
%    server that the KATCP object is connected to. Some of the commands listed
%    may not be implemented or supported by KATCP member functions.
%
%    See also KATCP/LISTBOF, KATCP/LISTCMD, KATCP/LISTDEV, KATCP/STATUS
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

function help(obj)

    fprintf(obj.tcpip_obj, '?help');
    pause(0.1);

    msg = '';

    timeout = 2^10;

    while timeout > 0

        pause(0.01);

        while (get(obj.tcpip_obj, 'BytesAvailable') > 0)
            msg = [msg, fscanf(obj.tcpip_obj)];
        end

        % wait for BORPH server to return OK status message
        if ~isempty(strfind(msg, '!help ok'))
            break;
        else
            timeout = timeout-1;
        end % if ~isempty(strfind(out, '!listbof ok')

        if ~isempty(strfind(msg, '!help fail'))
            errmsg = msg(strfind(msg, '!listdev fail'):end);
            warning(['listdev failed to remote host ',  get(obj.tcpip_obj, 'RemoteHost'), ': ', errmsg]);
            return;
        end

    end % while timeout > 0

    msg = msg(1:strfind(msg, '!help ok')-1);

    toks = regexp(msg, '#help (\S+) (\S+)\n', 'tokens');

    helpmsg = '';

    % finds length of longest command string
    maxcmdlen = 0;
    for n=1:length(toks)
        maxcmdlen = max(maxcmdlen, length(toks{n}{1}));
    end

    for n=1:length(toks)

        % adds spaces to match length of longest command string
        padding = '  ';
        for m=1:(maxcmdlen-length(toks{n}{1}))
            padding = [padding, ' '];
        end

        cmd  = toks{n}{1};
        desc = regexprep(toks{n}{2}, '\\\_', ' ');

        disp([cmd, padding, desc]);

    end % for n=1:length(toks)
