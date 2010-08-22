%LISTBOF List BOF files available on KATCP BORPH process.
%
%    LISTBOF(KATCP_OBJ) queries the remote host associated with the KATCP_OBJ
%    KATCP object for a list of available BOF files. The list is printed to
%    the Matlab command window.
%
%    BOFFILES = LISTBOF(KATCP_OBJ) returns a cell array BOFFILES in which each
%    cell in the array contains a character string with the filename of a BOF
%    file.
%
%    BOFFILES = LISTBOF(KATCP_OBJ, 'verbose') Can be used to print the list to
%    the Matlab command window along with the returned cell array.
%
%    See also KATCP/HELP, KATCP/LISTCMD, KATCP/LISTDEV
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

function varargout = listbof(obj, varargin)

    fprintf(obj.tcpip_obj, '?listbof');
    pause(0.1);

    msg = '';

    timeout = 2^10;

    while timeout > 0

        pause(0.01);

        while (get(obj.tcpip_obj, 'BytesAvailable') > 0)
            msg = [msg, fscanf(obj.tcpip_obj)];
        end

        % wait for BORPH server to return OK status message
        if ~isempty(strfind(msg, '!listbof ok'))
            break;
        else
            timeout = timeout-1;
        end % if ~isempty(strfind(out, '!listbof ok')

        if ~isempty(strfind(msg, '!listbof fail'))
            errmsg = msg(strfind(msg, '!listbof fail'):end);
            warning(['listbof failed to remote host ',  get(obj.tcpip_obj, 'RemoteHost'), ': ', errmsg]);
            return;
        end

    end % while timeout > 0

    if (timeout == 0)
        error(['KATCP connection to host ', get(obj.tcpip_obj, 'RemoteHost') , ' timed out.'])
    end

    msg = msg(1:strfind(msg, '!listbof ok')-1);

    switch nargout

        case 0 % just print out the list
            disp(msg);

        case 1 % return a cell array of strings
            bofs = {};

            toks = regexp(msg, '#listbof (\w+.bof)', 'tokens');

            for n=1:length(toks)
                bofs = [bofs, toks{n}{1}];
            end

            varargout(1) = {bofs};

            % if verbose, print out the list as well
            if ( (nargin == 2) && (strcmpi(varargin(1), 'verbose')) )
                disp(msg);
            end

        otherwise
            disp(msg);

    end % switch nargout

