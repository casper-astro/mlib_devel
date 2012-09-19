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
        %str = [str,'\n'];
        %str = [str,'#Cut paths to and from AYNC FIFO for clock domain crossing\n'];
        %str = [str,'NET "*adc_clk180" TNM_NET="adc_clk_in";\n'];
        %str = [str,'NET "*adc0_clk" TNM_NET="gateware_clk_in";\n'];
        %str = [str,'TIMEGRP "adc_clk_grp" = "adc_clk_in";\n'];
        %str = [str,'TIMEGRP "gateware_clk_in_grp" = "gateware_clk_in";\n'];
        %str = [str,'TIMESPEC "TSpci_async1"=FROM "adc_clk_grp" TO "gateware_clk_in_grp" TIG;\n'];
        %str = [str,'TIMESPEC "TSpci_async2"=FROM "gateware_clk_in_grp" TO "adc_clk_grp" TIG;\n'];


        %% First the trouble-some bunch...
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[1].D1?_1"    AREA_GROUP     = ZDOK_0_1_1 ;\n'];
        %str = [str, 'AREA_GROUP "ZDOK_0_1_1"     RANGE    = ', ...
        %    'SLICE_X0Y300:SLICE_X27Y320 ;\n'];
        %% And then the rest...
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[0].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[1].D0?_1"    AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[1].D2?_1"    AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[1].D3?_1"    AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[2].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[3].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[4].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[5].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[6].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'INST "', simulink_name, '/', simulink_name, ...
        %    '/adc5g_inst/data_buf[7].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
        %str = [str, 'AREA_GROUP "ZDOK_0_REST"     RANGE    = ', ...
        %       'SLICE_X76Y220:SLICE_X87Y259 ;\n'];

        

        switch adc_str
            case 'adc0'
                % MeerKAT ADC ZDOK 0 Data A (Even)
                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[?].D*_1"     AREA_GROUP     = ZDOK_0_REST ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_0_REST"     RANGE    = ', ...
                     'SLICE_X88Y200:SLICE_X89Y276 ;\n'];

                %str = [str,'\n '];
                %str = [str,'#MeerKAT ADC ZDOK 0 Data A (Even)\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D0A_1"   LOC = SLICE_X88Y200;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D0B_1"   LOC = SLICE_X88Y200;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D0C_1"   LOC = SLICE_X88Y200;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D0D_1"   LOC = SLICE_X88Y200;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D0A_1"   LOC = SLICE_X88Y276;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D0B_1"   LOC = SLICE_X88Y276;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D0C_1"   LOC = SLICE_X88Y276;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D0D_1"   LOC = SLICE_X88Y276;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D0A_1"   LOC = SLICE_X88Y266;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D0B_1"   LOC = SLICE_X88Y266;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D0C_1"   LOC = SLICE_X88Y266;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D0D_1"   LOC = SLICE_X88Y266;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D0A_1"   LOC = SLICE_X88Y262;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D0B_1"   LOC = SLICE_X88Y262;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D0C_1"   LOC = SLICE_X88Y262;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D0D_1"   LOC = SLICE_X88Y262;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D0A_1"   LOC = SLICE_X88Y264;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D0B_1"   LOC = SLICE_X88Y264;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D0C_1"   LOC = SLICE_X88Y264;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D0D_1"   LOC = SLICE_X88Y264;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[5].D0A_1"   LOC = SLICE_X88Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[5].D0B_1"   LOC = SLICE_X88Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[5].D0C_1"   LOC = SLICE_X88Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[5].D0D_1"   LOC = SLICE_X88Y258;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D0A_1"   LOC = SLICE_X88Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D0B_1"   LOC = SLICE_X88Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D0C_1"   LOC = SLICE_X88Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D0D_1"   LOC = SLICE_X88Y258;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D0A_1"   LOC = SLICE_X88Y252;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D0B_1"   LOC = SLICE_X88Y252;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D0C_1"   LOC = SLICE_X88Y252;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D0D_1"   LOC = SLICE_X88Y252;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D0A_1"   LOC = SLICE_X88Y248;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D0B_1"   LOC = SLICE_X88Y248;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D0C_1"   LOC = SLICE_X88Y248;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D0D_1"   LOC = SLICE_X88Y248;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D0A_1"   LOC = SLICE_X88Y246;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D0B_1"   LOC = SLICE_X88Y246;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D0C_1"   LOC = SLICE_X88Y246;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D0D_1"   LOC = SLICE_X88Y246;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D0A_1"   LOC = SLICE_X88Y270;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D0B_1"   LOC = SLICE_X88Y270;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D0C_1"   LOC = SLICE_X88Y270;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D0D_1"   LOC = SLICE_X88Y270;\n'];

                str = [str,'\n'];

                %% MeerKAT ADC Data B (Odd)



                %str = [str,'\n'];
                %str = [str,'#MeerKAT ADC ZDOK 0 Data A (Even)\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D2A_1"   LOC = SLICE_X88Y244;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D2B_1"   LOC = SLICE_X88Y244;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D2C_1"   LOC = SLICE_X88Y244;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[0].D2D_1"   LOC = SLICE_X88Y244;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D2A_1"   LOC = SLICE_X88Y254;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D2B_1"   LOC = SLICE_X88Y254;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D2C_1"   LOC = SLICE_X88Y254;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[1].D2D_1"   LOC = SLICE_X88Y254;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D2A_1"   LOC = SLICE_X88Y226;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D2B_1"   LOC = SLICE_X88Y226;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D2C_1"   LOC = SLICE_X88Y226;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[2].D2D_1"   LOC = SLICE_X88Y226;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D2A_1"   LOC = SLICE_X88Y260;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D2B_1"   LOC = SLICE_X88Y260;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D2C_1"   LOC = SLICE_X88Y260;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[3].D2D_1"   LOC = SLICE_X88Y260;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D2A_1"   LOC = SLICE_X88Y274;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D2B_1"   LOC = SLICE_X88Y274;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D2C_1"   LOC = SLICE_X88Y274;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[4].D2D_1"   LOC = SLICE_X88Y274;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D2A_1"   LOC = SLICE_X88Y216;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D2B_1"   LOC = SLICE_X88Y216;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D2C_1"   LOC = SLICE_X88Y216;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[6].D2D_1"   LOC = SLICE_X88Y216;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D2A_1"   LOC = SLICE_X88Y234;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D2B_1"   LOC = SLICE_X88Y234;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D2C_1"   LOC = SLICE_X88Y234;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[7].D2D_1"   LOC = SLICE_X88Y234;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D2A_1"   LOC = SLICE_X88Y206;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D2B_1"   LOC = SLICE_X88Y206;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D2C_1"   LOC = SLICE_X88Y206;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[8].D2D_1"   LOC = SLICE_X88Y206;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D2A_1"   LOC = SLICE_X88Y228;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D2B_1"   LOC = SLICE_X88Y228;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D2C_1"   LOC = SLICE_X88Y228;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[9].D2D_1"   LOC = SLICE_X88Y228;\n'];
%
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D2A_1"   LOC = SLICE_X88Y224;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D2B_1"   LOC = SLICE_X88Y224;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D2C_1"   LOC = SLICE_X88Y224;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc5g_inst/data_buf[10].D2D_1"   LOC = SLICE_X88Y224;\n'];
%
                %str = [str,'\n'];

                %str = [str,'NET "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R*" MAXDELAY = 1.65ns;\n'];

                %% MeerKAT ADC Over Range constraints
                %str = [str,'#MeerKAT ADC Over Range constraints\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_a_0"    LOC = SLICE_X80Y240;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_a_1"    LOC = SLICE_X80Y240;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_b_0"    LOC = SLICE_X10Y318;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_b_1"    LOC = SLICE_X10Y318;\n'];
                %str = [str,'\n'];

                %% MeerKAT ADC Sync constraints
                %str = [str,'#MeerKAT ADC Sync constraints\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_demuxed_x4R_0"    LOC = SLICE_X88Y230;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_demuxed_x4R_1"    LOC = SLICE_X88Y230;\n'];
                %str = [str,'\n'];

                % MeerKAT ADC Setup & Hold Constraints for FPGA
                %str = [str,'#ZDOK0 MeerKAT ADC Setup & Hold Constraints for FPGA\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.5),' ns BEFORE "adc0_adc_clk_p" RISING;\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.5),' ns BEFORE "adc0_adc_clk_p" FALLING;\n'];             
                %str = [str,'\n'];
            % end case 'adc0'

            case 'adc1'


                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[0].D0?_1"     AREA_GROUP     = ZDOK_1_r0_REST ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_1_r0_REST"     RANGE    = ', ...
                     'SLICE_X88Y198:SLICE_X89Y199 ;\n'];

                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[3].D0?_1"     AREA_GROUP     = ZDOK_1_r3_REST ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_1_r3_REST"     RANGE    = ', ...
                     'SLICE_X88Y204:SLICE_X89Y205 ;\n'];

                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[?].D*_1"     AREA_GROUP     = ZDOK_1_REST ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_1_REST"     RANGE    = ', ...
                     'SLICE_X0Y246:SLICE_X1Y308 ;\n'];
                %str = [str,'\n'];
                %str = [str,'#MeerKAT ADC Data B (Odd)\n'];


                %% MeerKAT ADC ZDOK 1 Data A (Even)
                %str = [str,'\n'];
                %str = [str,'#MeerKAT ADC ZDOK 1 Data A (Even)\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_10"   LOC = SLICE_X88Y198;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_30"   LOC = SLICE_X88Y198;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_11"   LOC = SLICE_X0Y296;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_31"   LOC = SLICE_X0Y296;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_12"   LOC = SLICE_X0Y308;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_32"   LOC = SLICE_X0Y308;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_13"   LOC = SLICE_X88Y204;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_33"   LOC = SLICE_X88Y204;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_14"   LOC = SLICE_X0Y314;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_34"   LOC = SLICE_X0Y314;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_15"   LOC = SLICE_X0Y306;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_35"   LOC = SLICE_X0Y306;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_16"   LOC = SLICE_X0Y302;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_36"   LOC = SLICE_X0Y302;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_17"   LOC = SLICE_X0Y292;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_37"   LOC = SLICE_X0Y292;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_18"   LOC = SLICE_X0Y284;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_38"   LOC = SLICE_X0Y284;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_19"   LOC = SLICE_X0Y288;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_39"   LOC = SLICE_X0Y288;\n'];
                %str = [str,'\n'];

                %% MeerKAT ADC Data B (Odd)
                %str = [str,'\n'];
                %str = [str,'#MeerKAT ADC Data B (Odd)\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_0"    LOC = SLICE_X0Y282;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_20"   LOC = SLICE_X0Y282;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_1"    LOC = SLICE_X0Y298;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_21"   LOC = SLICE_X0Y298;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_2"    LOC = SLICE_X0Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_22"   LOC = SLICE_X0Y258;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_3"    LOC = SLICE_X0Y276;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_23"   LOC = SLICE_X0Y276;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_4"    LOC = SLICE_X0Y272;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_24"   LOC = SLICE_X0Y272;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_5"    LOC = SLICE_X0Y256;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_25"   LOC = SLICE_X0Y256;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_6"    LOC = SLICE_X0Y246;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_26"   LOC = SLICE_X0Y246;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_7"    LOC = SLICE_X0Y252;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_27"   LOC = SLICE_X0Y252;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_8"    LOC = SLICE_X0Y274;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_28"   LOC = SLICE_X0Y274;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_9"    LOC = SLICE_X0Y266;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R_29"   LOC = SLICE_X0Y266;\n'];
                %str = [str,'\n'];

                %str = [str,'NET "',simulink_name,'/',simulink_name,'/adc_data_demuxed_x4R*" MAXDELAY = 1.65ns;\n'];

                %% MeerKAT ADC Over Range constraints
                %str = [str,'#MeerKAT ADC Over Range constraints\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_0"    LOC = SLICE_X0Y280;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_2"    LOC = SLICE_X0Y280;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_1"    LOC = SLICE_X0Y260;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_or_demuxed_x4R_3"    LOC = SLICE_X0Y260;\n'];
                %str = [str,'\n'];

                %% MeerKAT ADC Sync constraints
                %str = [str,'#MeerKAT ADC Sync constraints\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_demuxed_x4R_0"    LOC = SLICE_X0Y248;\n'];
                %str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_demuxed_x4R_1"    LOC = SLICE_X0Y248;\n'];
                %str = [str,'\n'];

                % MeerKAT ADC Setup & Hold Constraints for FPGA
                %str = [str,'#ZDOK0 MeerKAT ADC Setup & Hold Constraints for FPGA\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.5),' ns BEFORE "adc1_adc_clk_p" RISING;\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.5),' ns BEFORE "adc1_adc_clk_p" FALLING;\n'];             
                %str = [str,'\n'];

            % end case 'adc1'
        end % switch adc_str
    % end case 'ROACH2'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % switch hw_sys
