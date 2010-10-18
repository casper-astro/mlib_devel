%READ Read data stream from a device via KATCP.
%
%    DATA = READ(KATCP_OBJ, IOREG) reads and returns the first word of data
%    from IOREG on a KATCP connection returns it as a HEX string.
%
%    DATA = READ(KATCP_OBJ, IOREG, OFFSET) reads and returns a word of data
%    with an integer byte offset OFFSET.
%
%    DATA = READ(KATCP_OBJ, IOREG, OFFSET, SIZE) reads and returns SIZE bytes
%    of data with an integer byte offset OFFSET. SIZE must be an integer
%    multiple of 4. The maximum supported read size is 262144 (2^18) bytes.
%
%    DATA = READ(KATCP_OBJ, IOREG, OFFSET, SIZE, FORMAT) reads and returns SIZE
%    bytes of data with an integer byte offset OFFSET. SIZE must be an integer
%    multiple of 4 using a return output format specified by FORMAT:
%
%        FORMAT         RETURN TYPE
%       --------       -------------
%        'ub'           Unsigned Bytes (uint8)
%        'uw'           Unsigned Words (uint32)
%        'hw'           Hex Words (string)
%
%    Example:
%       roach=katcp('myroach.domain.edu');
%       readback = read(roach, my_bram, 8, 256, 'ub');
%           would return a 256-element vector "readback" of uint8s that are
%           words 3-67 of "my_bram."
%
%    See also KATCP/WRITE, KATCP/WORDREAD, KATCP/WORDWRITE
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

function data = read(obj, varargin)

%tic;

    num_optargs = size(varargin, 2);

    MAX_READSIZE = 256*1024;


    %%% Process input arguments

    switch num_optargs

        case 1
            reg_name    = varargin{1};
            read_offset = 0;
            read_size   = 4;
            read_format = 'hw';
        % end case 1

        case 2
            reg_name    = varargin{1};
            read_offset = varargin{2};
            read_size   = 4;
            read_format = 'hw';
        % end case 2

        case 3
            reg_name    = varargin{1};
            read_offset = varargin{2};
            read_size   = varargin{3};
            read_format = 'hw';
        % end case 3

        case 4
            reg_name    = varargin{1};
            read_offset = varargin{2};
            read_size   = varargin{3};
            read_format = varargin{4};

        otherwise
            error('Read must have <device name> [read offset (bytes)] [read size (bytes)] [output format]');
        % end otherwise

    end % switch num_optargs

    if ( read_offset < 0 )
        disp('Read offset must be a positive integer.');
        data = [];
        return;
    end

    if ( mod(read_size, 4) ~= 0 || read_size < 1)
        disp('Read size must be a positive integer multiple of 4.');
        data = [];
        return;
    end

    if read_size > MAX_READSIZE
        disp(['Maximum supported read size is ', num2str(MAX_READSIZE), ' bytes.'])
        data = [];
        return;
    end

%toc
%disp('process arguments');

%tic;

    %%% Send read command to KATCP

    cmd_string = ['?read ', reg_name, ' ', num2str(read_offset), ' ', num2str(read_size)];
%    disp(cmd_string);

    fwrite(obj.tcpip_obj, uint8(cmd_string));
    fprintf(obj.tcpip_obj, '');

%toc
%disp('send command')
%
%tic;

    while 1
        bytes_available = get(obj.tcpip_obj, 'BytesAvailable');

        pause(0.05);

        if ( bytes_available ~= get(obj.tcpip_obj, 'BytesAvailable') || bytes_available < 1 )
            continue;
        else
            break;
        end
    end

%toc
%disp('wait for bytes')
%
%tic;

    readback = '';

    readback = transpose(fread(obj.tcpip_obj, get(obj.tcpip_obj, 'BytesAvailable')));

    if ~strcmp( char(readback(1:9)), '!read ok ')

        %error(char(readback));
        toks = regexp(char(readback), '(.*)!read(\s+)(.*)', 'tokens');

        if ~isempty(toks)
            error(toks{1}{3});
        end

    end % if ~strcmp( char(readback(1:9)), '!read ok ')

    readback = readback(10:end-1);

%toc
%disp('read from buffer')

%tic;

    %%% De-escape data stream.
    % CAN THIS BE MADE MORE EFFICIENT??
    % Pre-allocating result vector gives major speedup. Others?

    data = zeros(1,read_size);
    m = 1;

    for n=1:length(readback)

        switch readback(n)

            case -1 % should only be artificially inserted by de-escaper
                continue;

            case 92 % escape character '\'

                switch readback(n+1)

                    case 48 % 0x30; '0'
                        readback(n+1) = uint8(0);

                    case 92 % 0x5C; '\'
                        %data = [data, uint8(92)];
                        data(m) = uint8(92);
                        m = m+1;
                        readback(n+1) = -1;

                    case 95 % 0x5F; '_'
                        readback(n+1) = uint8(32);

                    case 101 % 0x65; 'e'
                        readback(n+1) = uint8(27);

                    case 110 % 0x6E; 'n'
                        readback(n+1) = uint8(10);

                    case 114 % 0x72; 'r'
                        readback(n+1) = uint8(13);

                    case 116 %0x74; 't'
                        readback(n+1) = uint8(9);

                end % switch char(readback(n+1))

                continue;

            % end case 92

            otherwise
                %data = [data, readback(n)];
                data(m) = readback(n);
                m = m+1;

        end % switch char(readback(n))

    end % for n=1:length(readback)

    readback = data;

%toc
%disp('de-escape')


%tic

    %%% Get into output radix/format

    switch read_format

        case 'ub'
            data = readback;
        % end case 'ub'

        case 'uw'

            data = zeros(1,read_size/4);
            m = 1;

            for n=1:4:length(readback)
                data(m) =  (uint32(readback(n))   * 2^24 + ...
                            uint32(readback(n+1)) * 2^16 + ...
                            uint32(readback(n+2)) * 2^8  + ...
                            uint32(readback(n+3)) * 2^0);

                m = m+1;
            end
        % end case 'uw'

        case 'hw'

            data = cell(1,read_size/4);
            m = 1;

            for n=1:4:length(readback)
                data(m) = {dec2hex(( ...
                            uint32(readback(n))   * 2^24 + ...
                            uint32(readback(n+1)) * 2^16 + ...
                            uint32(readback(n+2)) * 2^8  + ...
                            uint32(readback(n+3)) * 2^0),  ...
                            8)};

                m = m+1;
            end
        % end case 'hw'

        otherwise
            disp(['Unsupported format: ', read_format]);
            data = readback;

    end % switch read_format

%toc
%disp('output formatting')
