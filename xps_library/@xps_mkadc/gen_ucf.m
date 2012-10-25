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
disp('meerKAT ADC gen_ucf')

hw_sys = blk_obj.hw_sys;
adc_str = blk_obj.adc_str;
disp('meerKAT ADC trying generic ucf generation')
str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));
blk_name = get(blk_obj,'simulink_name');
adc_clk_rate = eval_param(blk_name,'adc_clk_rate');
disp('meerKAT ADC trying specific ucf generation')
switch hw_sys
    case 'ROACH2'

        switch adc_str
            case 'adc0'
                % MeerKAT ADC ZDOK 0
                str = [str,'#MeerKAT ADC ZDOK 0 Constraints\n'];
                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[?].D*_1"     AREA_GROUP     = ZDOK_0 ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_0"     RANGE    = ', ...
                     'SLICE_X88Y200:SLICE_X89Y276 ;\n'];
                str = [str,'\n'];
                % MeerKAT ADC Setup & Hold Constraints for FPGA
                %str = [str,'#ZDOK0 MeerKAT ADC Setup & Hold Constraints for FPGA\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns VALID 1.1 ns BEFORE "adc0_adc_clk_p" RISING;\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns VALID 1.1 ns BEFORE "adc0_adc_clk_p" FALLING;\n'];             
                %str = [str,'\n'];
            % end case 'adc0'

            case 'adc1'

                % MeerKAT ADC ZDOK 1
                str = [str,'\n'];
                str = [str,'#MeerKAT ADC ZDOK 1 Constraints\n'];
                str = [str,'\n'];
                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[0].D0?_1"     AREA_GROUP     = ZDOK_1_r0 ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_1_r0"     RANGE    = ', ...
                     'SLICE_X86Y198:SLICE_X87Y199 ;\n'];
                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[?].D*_1"     AREA_GROUP     = ZDOK_1 ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_1"     RANGE    = ', ...
                     'SLICE_X0Y246:SLICE_X1Y308 ;\n'];

                % MeerKAT ADC Setup & Hold Constraints for FPGA
                %str = [str,'#ZDOK1 MeerKAT ADC Setup & Hold Constraints for FPGA\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns VALID 1.1 ns BEFORE "adc1_adc_clk_p" RISING;\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns VALID 1.1 ns BEFORE "adc1_adc_clk_p" FALLING;\n'];             
                %str = [str,'\n'];

            % end case 'adc1'
        end % switch adc_str
    % end case 'ROACH2'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % switch hw_sys
