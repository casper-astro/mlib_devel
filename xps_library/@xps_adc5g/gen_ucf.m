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
str = [str, 'NET "', adc_str, 'clk_p" TNM_NET = "', adc_str, '_clk";\n'];
str = [str, 'TIMESPEC "TS_', adc_str, '_clk" = PERIOD "', ...
    adc_str, '_clk" ', num2str(adc_per), ' ps HIGH 50%%;\n'];
str = [str, 'OFFSET = IN 400 ps VALID ', num2str(adc_per/2), ...
    ' ps BEFORE "', adc_str, '_clk" RISING;\n'];
str = [str, 'OFFSET = IN 400 ps VALID ', num2str(adc_per/2), ...
    ' ps BEFORE "', adc_str, '_clk" FALLING;\n'];

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
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D1A_0"     AREA_GROUP     = ISD_1 ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D1B_0"     AREA_GROUP     = ISD_1 ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D1C_0"     AREA_GROUP     = ISD_1 ;\n'];
                    str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                        '/data_buf[1].D1D_0"     AREA_GROUP     = ISD_1 ;\n'];
                    str = [str, 'AREA_GROUP "ISD_1"     RANGE    = ', ...
                        'SLICE_X0Y300:SLICE_X27Y320 ;\n'];
                otherwise
                    % pass
            end
        end
    otherwise 
        % pass
end