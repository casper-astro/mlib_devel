%WORDREAD Read a single word from a device via KATCP.
%
%    [WORD, STATUS] = WORDREAD(OBJ, IOREG) peforms a single-word read from
%    IOREG on a KATCP connection.
%
%    See also KATCP/HELP, KATCP/WORDWRITE, KATCP/READ, KATCP/WRITE
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

function [word, status] = wordread(obj, varargin)

%    num_optargs = size(varargin, 2);

    try
        reg_name = varargin{1};
    catch
        error('Read must have <device name>.');
    end

    try
        read_offset = num2str(varargin{2});
    catch
        read_offset = '0';
    end

    cmd_string = ['?wordread ', reg_name, ' ', read_offset];
%    disp(cmd_string);

    fprintf(obj.tcpip_obj, cmd_string);
    pause(0.1);

    rb = '';
    status = '';
    word = 0;

    while (get(obj.tcpip_obj, 'BytesAvailable') > 0)
        rb = [rb, fscanf(obj.tcpip_obj)];
    end

    status = rb(1:13);
%    disp(status);

    if ~strcmp('!wordread ok ', status)
        status = rb;
        return;
    end

    word = dec2hex(hex2dec(rb(16:end-1)),8);
