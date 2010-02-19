%WORDWRITE Write a single word to a device via KATCP.
%
%    STATUS = WORDWRITE(OBJ, IOREG, WORD) writes a single word WORD to
%    IOREG on a KATCP connection.
%
%    See also KATCP/HELP, KATCP/WORDREAD, KATCP/READ, KATCP/WRITE
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

function status = wordwrite(obj, varargin)

    try
        reg_name = varargin{1};
    catch
        error('Write must have <device name>.');
    end

    try
        write_word = num2str(varargin{3});
        write_offset = num2str(varargin{2});
    catch
        try
            write_word = num2str(varargin{2});
            write_offset = '0';
        catch
            error('Missing value to write.');
        end
    end

    cmd_string = ['?wordwrite ', reg_name, ' ', write_offset, ' ', write_word];
%    disp(cmd_string);

    fprintf(obj.tcpip_obj, cmd_string);
    pause(0.1);

    rb = '';
    status = '';

    while (get(obj.tcpip_obj, 'BytesAvailable') > 0)
        rb = [rb, fscanf(obj.tcpip_obj)];
    end

    status = rb(1:14);

%    disp(status);
    if ~strcmp('!wordwrite ok ', status)
        status = rb;
        return;
    end
