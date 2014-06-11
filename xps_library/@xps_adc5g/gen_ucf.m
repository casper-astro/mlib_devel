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

function str = gen_ucf(blk_obj)

hw_sys = blk_obj.hw_sys;
blk_name = get(blk_obj,'simulink_name');

% Get some parameters we're intereset in
simulink_name = clear_name(get(blk_obj,'simulink_name'));
adc_per = 1e6/(blk_obj.adc_clk_rate);
str = gen_ucf(blk_obj.xps_block);
adc_str = blk_obj.adc_str;
demux = blk_obj.demux;

% Set the ADC clock setup/hold constraints
%str = [str, 'NET "', adc_str, 'clk_p" TNM_NET = "', adc_str, '_clk";\n'];
%str = [str, 'TIMESPEC "TS_', adc_str, '_clk" = PERIOD "', ...
%    adc_str, '_clk" ', num2str(adc_per), ' ps HIGH 50%%;\n'];
%str = [str, 'OFFSET = IN 400 ps VALID ', num2str(adc_per/2), ...
%   ' ps BEFORE "', adc_str, 'clk_p" RISING;\n'];
%str = [str, 'OFFSET = IN 400 ps VALID ', num2str(adc_per/2), ...
%   ' ps BEFORE "', adc_str, 'clk_p" FALLING;\n'];

switch hw_sys
    case 'ROACH'
        % pass
    case 'ROACH2'
        if blk_obj.use_adc0
	    switch demux
	        % Create an area group to place the FD close to the IOPAD
		% which for some reason was traced to the other side of the
	        % chip on ROACH2
                case '1:2'
		    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                       '/fifo_din_33"     AREA_GROUP     = IDDR_1 ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                       '/fifo_din_41"     AREA_GROUP     = IDDR_1 ;\n'];
                    str = [str, 'AREA_GROUP "IDDR_1"     RANGE    = ', ...
                       'SLICE_X0Y279:SLICE_X23Y321 ;\n'];
                case '1:1'
		    % First the trouble-some bunch...
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D1?_1"    AREA_GROUP     = ZDOK_0_1_1 ;\n'];
                    str = [str, 'AREA_GROUP "ZDOK_0_1_1"     RANGE    = ', ...
                        'SLICE_X0Y300:SLICE_X27Y320 ;\n'];
		    % And then the rest...
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[0].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D0?_1"    AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D2?_1"    AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D3?_1"    AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[2].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[3].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[4].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[5].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[6].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[7].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                    str = [str, 'AREA_GROUP "ZDOK_0_REST"     RANGE    = ', ...
			   'SLICE_X76Y220:SLICE_X87Y259 ;\n'];
                otherwise
                    % pass
            end
	elseif blk_obj.use_adc1
	     % This is for ZDOK1, we need to place the first buffers
	     % close to the I/O pads to help timing
	     str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                 '/data_buf[?].D??_1"     AREA_GROUP     = ZDOK_1_ALL ;\n'];
	     str = [str, 'AREA_GROUP "ZDOK_1_ALL"     RANGE    = ', ...
                 'SLICE_X0Y270:SLICE_X11Y309 ;\n'];	
        end
    otherwise 
        % pass
end