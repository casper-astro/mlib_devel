%WRITE Write data stream to device via KATCP.
%
%    WRITE(KATCP_OBJ, IOREG, DATA) writes a vector DATA of unsigned bytes
%    (uint8) to IOREG starting at the first byte in its memory space. DATA
%    must have a length that is an integer multiple of 4.
%
%    WRITE(KATCP_OBJ, IOREG, OFFSET, DATA) writes a vector DATA of unsigned
%    bytes (uint8) to IOREG with an integer byte offset of OFFSET. DATA must
%    have a length that is an integer multiple of 4.
%
%    WRITE(KATCP_OBJ, IOREG, FORMAT, OFFSET, DATA) writes a vector DATA to
%    IOREG with an integer byte offset of OFFSET. DATA must have a length that
%    is an integer multiple of 4. The data type of DATA is specified by FORMAT:
%
%        FORMAT         DATA TYPE
%       --------       -----------
%        'ub'           Unsigned Bytes (uint8)
%        'uw'           Unsigned Words (uint32)
%        'hw'           Hex Words (string)
%
%    Example:
%       roach=katcp('myroach.domain.edu');
%       write(roach, my_bram, 'ub', 8, uint8([0:255]));
%           would write a 256-element vector of uint8s to words 3-67 of
%           "my_bram."

%    See also KATCP/READ, KATCP/WORDREAD, KATCP/WORDWRITE
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

function varargout = write(obj, reg_name, varargin)

    num_optargs = size(varargin, 2);

    MAX_WRITESIZE = 256*1024;

    status = 0;
    message = '';


    %%% Process input arguments

%tic;
    switch num_optargs

        case 1
            write_offset = 0;
            write_data   = varargin{1};
            write_format = 'ub';
        % end case 1

        case 2
            write_offset = varargin{1};
            write_data   = varargin{2};
            write_format = 'ub';
        % end case 2

        case 3
            write_offset = varargin{1};
            write_data   = varargin{2};
            write_format = varargin{3};

        otherwise
            error('Write must have <device name> [data format] [write offset (bytes)] <data vector>');
        % end otherwise

    end % switch num_optargs

    if ( write_offset < 0 )
        disp('Write offset must be a positive integer.');
        status = -1;
        message = 'Invalid write offset.'
        return;
    end

    switch write_format
        case 'ub'
            INPUT_MOD = 4;
        case 'uw'
            INPUT_MOD = 1;
        case 'hw'
            INPUT_MOD = 1;
        otherwise
            INPUT_MOD = 4;
    end % switch write_format

    data_size = length(write_data);

    if mod(data_size, INPUT_MOD) ~= 0
        disp(['Data vector must be a multiple of 4 bytes']);
        status = -1;
        message = 'Invalid data vector length';
        return;
    end

    if ( (data_size*4/INPUT_MOD > MAX_WRITESIZE) || (data_size < 1) )
        disp(['Maximum data vector size is ', num2str(MAX_WRITESIZE), ' bytes.'])
        status = -1;
        message = 'Invalid data vector length.';
        return;
    end
%toc;
%disp('process input arguments');


    %%% Get into input radix/format

%tic;
    switch write_format

        case 'ub'
            data = uint8(write_data);
        % end case 'ub'

        case 'uw'

            data = zeros(1, data_size*4);
            m = 1;

            for n=1:data_size

                word = write_data(n);

                data(m:m+3) =  [uint8(mod(floor(word/2^24), 2^8)), ...
                                uint8(mod(floor(word/2^16), 2^8)), ...
                                uint8(mod(floor(word/2^8 ), 2^8)), ...
                                uint8(mod(floor(word/2^0 ), 2^8))];

                m = m + 4;

            end % for n=1:length(write_data);

        % end case 'uw'

        case 'hw'

            data = zeros(1, data_size*4);
            m = 1;

            for n=1:data_size

                word = write_data{n};

                data(m:m+3) =  [uint8(hex2dec(word(1:2))), ...
                                uint8(hex2dec(word(3:4))), ...
                                uint8(hex2dec(word(5:6))), ...
                                uint8(hex2dec(word(7:8)))];

                m = m + 4;

            end % for n=1:length(write_data)

        % end case 'hw'

        otherwise
            disp(['Unsupported format: ', write_format]);
            return;

    end % switch read_format
%toc;
%disp('reformat input vector');

    %%% Escape data stream
    % CAN THIS BE MADE MORE EFFICIENT?

%tic;
    vector_size = 0;

    for n=1:data_size

        switch data(n)

            case 9  % corresponds to TAB (^I) -> escape as \t
                vector_size = vector_size + 2;

            case 10 % corresponds to LF (^J) -> escape as \n
                vector_size = vector_size + 2;

            case 13 % corresponds to CR (^M) -> escape as \r
                vector_size = vector_size + 2;

            case 32 % corresonds to SPACE ( ) -> escape as \_
                vector_size = vector_size + 2;

            case 92 % corresponds to \ -> escape as \\
                vector_size = vector_size + 2;

            otherwise
                vector_size = vector_size + 1;

        end % switch data(n)

    end % for n=1:data_size

    write_vector = zeros(1, vector_size);
    m = 1;

    for n=1:data_size

        switch data(n)

            case 9  % corresponds to TAB (^I) -> escape as \t
                write_vector(m:m+1) = [uint8(92), uint8(9)];
                m = m + 2;

            case 10 % corresponds to LF (^J) -> escape as \n
                write_vector(m:m+1) = [uint8(92), uint8(110)];
                m = m + 2;

            case 13 % corresponds to CR (^M) -> escape as \r
                write_vector(m:m+1) = [uint8(92), uint8(114)];
                m = m + 2;

            case 32 % corresonds to SPACE ( ) -> escape as \_
                write_vector(m:m+1) = [uint8(92), uint8(95)];
                m = m + 2;

            case 92 % corresponds to \ -> escape as \\
                write_vector(m:m+1) = [uint8(92), uint8(92)];
                m = m + 2;

            otherwise
                write_vector(m) = data(n);
                m = m + 1;

        end % switch data(n)

    end % for n=1:data_size
%toc;
%disp('escape characters in vector');

    %%% Send read command to KATCP

    cmd_string = ['?write ', reg_name, ' ', num2str(write_offset), ' ', write_vector];
%    disp(cmd_string);

%tic;
%    fwrite(obj.tcpip_obj, uint8(cmd_string));
%    fprintf(obj.tcpip_obj, '');
%toc;
%disp('send command/data');
%
%tic;
    while 1
        pause(0.001);

        bytes_available = get(obj.tcpip_obj, 'BytesAvailable');

        if ( bytes_available ~= get(obj.tcpip_obj, 'BytesAvailable') || bytes_available < 1 )
            continue;
        else
            break;
        end
    end
%toc;
%disp('wait for response');

    readback = '';

    readback = transpose(fread(obj.tcpip_obj, get(obj.tcpip_obj, 'BytesAvailable')));
%    disp(char(readback));

    if ~strcmp( char(readback(1:10)), '!write ok ')

        %error(char(readback));
        toks = regexp(char(readback), '(.*)!read(\s+)(.*)', 'tokens');

        if ~isempty(toks)
            error(toks{1}{3});
        end

    end % if ~strcmp( char(readback(1:9)), '!write ok ')
