%TAPSTART Program a 10GbE device and start the TAP driver.
%
%    TAPSTART(KATCP_OBJ, DEVICE, MAC, IP, PORT) requests that the KATCP
%    configures a 10GbE device with the following parameters:
%
%       DEVICE: name of the device (string)
%       MAC:    MAC address to set (string of 6 colon-delimited hex bytes)
%       IP:     IP address to set  (string of 4 period-delimited integer bytes)
%       PORT:   Fabric port number (integer up to 16 bits)
%
%    Example:
%       roach = katcp('myroach.domain.edu');
%       tapstart(roach, 'gbe0', '00:1A:2B:3C:4D:5E', '10.0.0.21', 12345);
%
%    See also KATCP/HELP
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

function varargout = tapstart(obj, dev_name, mac_addr, ip_addr, port_num)

    if isempty(regexp(mac_addr, '00:[0-9a-f_A-F]{2,2}:[0-9a-f_A-F]{2,2}:[0-9a-f_A-F]{2,2}:[0-9a-f_A-F]{2,2}:[0-9a-f_A-F]{2,2}'))

        if ~strcmp(mac_addr(1:2), '00')
            disp('First octet of MAC address must be 00');
            return;
        end

        disp('Invalid MAC address format.');
        return;

    end

    if isempty(regexp(ip_addr, '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'))

        disp('Invalid IP address format.');
        return;

    end

    if (port_num < 0) || (port_num > 65535)

        disp('Invalid port number.');
        return;

    end

    fprintf(obj.tcpip_obj,['?tap-start ', dev_name, ' ', mac_addr, ' ', ip_addr, ' ', num2str(port_num)]);

    while 1

        bytes_available = get(obj.tcpip_obj, 'BytesAvailable');

        pause(0.001);

        if ( bytes_available ~= get(obj.tcpip_obj, 'BytesAvailable') || bytes_available < 1 )
            continue;
        else
            msg = [msg, transpose(fread(obj.tcpip_obj, get(obj.tcpip_obj, 'BytesAvailable')))];
            if isempty(strfind(char(msg), '!tap-start'))
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

    disp(msg);

