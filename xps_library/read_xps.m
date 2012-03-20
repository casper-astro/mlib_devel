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

function out = read_xps(core_name, serial_port)
try
    % open serial port
    s = serial(serial_port);
    set(s,'BaudRate',115200);
    set(s,'InputBufferSize' ,127);
    set(s,'OutputBufferSize',127);
    set(s,'Timeout',3);
    set(s,'ByteOrder','bigEndian');
    fopen(s);

    % send a request information to the iBOB
    % special opcode
    fwrite(s,uint8(129));
    % block name
    fwrite(s,uint8(core_name));
    % zero string termination
    fwrite(s,uint8(0));
    % get the result code
    request_result = fread(s, 1, 'uint8');
    % get the result string
    request_string = '';
    c = fread(s,1,'uint8');
    while c ~= 0
        request_string = [request_string,char(c)];
        c = fread(s,1,'uint8');
    end
    if request_result ~= 0
        disp(['Error: ',request_string]);
        fclose(s);
        delete(s);
        clear s;
        return;
    end
    toks = regexp(request_string,'(\w+)', 'tokens');
    type = toks{1};
    type = type{1};
    param = toks{5};
    param = param{1};
    address = toks{3};
    address = address{1};
    address = hex2dec(address(3:end));

    if strcmp(type,'xps_bram')
        size = str2num(param);
        out = [];

        while size > 0
            if size > 31
                block_size = 31;
            else
                block_size = size;
            end

            header(1) = uint8(128);
            header(2) = uint8(0 + block_size);
            header(3) = uint8(mod(floor(address/(2^24)),2^8));
            header(4) = uint8(mod(floor(address/(2^16)),2^8));
            header(5) = uint8(mod(floor(address/(2^8 )),2^8));
            header(6) = uint8(mod(floor(address/(2^0 )),2^8));

            fwrite(s, header);
            fprintf('.');

            out = [out; fread(s, block_size, 'uint32')];
            size = size - block_size;
            address = address + (block_size * 4);
        end
        fprintf('\n');

    elseif strcmp(type,'xps_sw_reg')

        header(1) = uint8(128);
        header(2) = uint8(0 + 1);
        header(3) = uint8(mod(floor(address/(2^24)),2^8));
        header(4) = uint8(mod(floor(address/(2^16)),2^8));
        header(5) = uint8(mod(floor(address/(2^8 )),2^8));
        header(6) = uint8(mod(floor(address/(2^0 )),2^8));

        fwrite(s, header);

        out = fread(s, 1, 'uint32');
    end

    fclose(s);
    delete(s);
    clear s;

    out = cast(out, 'uint32');
catch
    fclose(s);
    delete(s);
    clear s;
    disp(lasterr);
    out = 0;
end
