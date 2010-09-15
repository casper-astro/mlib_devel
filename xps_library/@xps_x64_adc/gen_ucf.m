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
disp('x64_adc gen_ucf');
disp('x64_adc trying generic ucf generation');
str       = gen_ucf(blk_obj.xps_block);
blk_name  = get(blk_obj, 'simulink_name');
inst_name = clear_name(blk_name);

disp('x64_adc trying specific ucf generation');

clk_rate   = get(blk_obj,'adc_clk_rate'); 
clk_period = 1000/(6*clk_rate);
use_spi    = get(blk_obj,'use_spi'); 

%str = [str, 'NET "adc_clk_p"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | PERIOD = ', num2str(clk_period), ' ns | LOC = H19;',  '\n'];
%str = [str, 'NET "adc_clk_n"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | PERIOD = ', num2str(clk_period), ' ns | LOC = H20;',  '\n'];
%str = [str, 'NET "fc_0_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = C34;',     '\n'];
%str = [str, 'NET "fc_0_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = D34;',     '\n'];
%str = [str, 'NET "fc_1_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = B33;',     '\n'];
%str = [str, 'NET "fc_1_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = C33;',     '\n'];
%str = [str, 'NET "fc_2_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = E28;',     '\n'];
%str = [str, 'NET "fc_2_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F28;',     '\n'];
%str = [str, 'NET "fc_3_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = C32;',     '\n'];
%str = [str, 'NET "fc_3_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = D32;',     '\n'];
%str = [str, 'NET "fc_4_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AB27;',    '\n'];
%str = [str, 'NET "fc_4_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AC27;',    '\n'];
%str = [str, 'NET "fc_5_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD31;',    '\n'];
%str = [str, 'NET "fc_5_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE31;',    '\n'];
%str = [str, 'NET "fc_6_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD32;',    '\n'];
%str = [str, 'NET "fc_6_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE32;',    '\n'];
%str = [str, 'NET "fc_7_p"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AC34;',    '\n'];
%str = [str, 'NET "fc_7_n"     IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD34;',    '\n'];
%str = [str, 'NET "in_0_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L30;',     '\n'];
%str = [str, 'NET "in_0_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = M30;',     '\n'];
%str = [str, 'NET "in_0_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K31;',     '\n'];
%str = [str, 'NET "in_0_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L31;',     '\n'];
%str = [str, 'NET "in_0_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H34;',     '\n'];
%str = [str, 'NET "in_0_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J34;',     '\n'];
%str = [str, 'NET "in_0_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J27;',     '\n'];
%str = [str, 'NET "in_0_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J26;',     '\n'];
%str = [str, 'NET "in_0_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G32;',     '\n'];
%str = [str, 'NET "in_0_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H32;',     '\n'];
%str = [str, 'NET "in_0_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F33;',     '\n'];
%str = [str, 'NET "in_0_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = E34;',     '\n'];
%str = [str, 'NET "in_0_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = E32;',     '\n'];
%str = [str, 'NET "in_0_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = E33;',     '\n'];
%str = [str, 'NET "in_0_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F25;',     '\n'];
%str = [str, 'NET "in_0_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F26;',     '\n'];
%str = [str, 'NET "in_1_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L34;',     '\n'];
%str = [str, 'NET "in_1_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K34;',     '\n'];
%str = [str, 'NET "in_1_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K33;',     '\n'];
%str = [str, 'NET "in_1_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K32;',     '\n'];
%str = [str, 'NET "in_1_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J32;',     '\n'];
%str = [str, 'NET "in_1_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H33;',     '\n'];
%str = [str, 'NET "in_1_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K27;',     '\n'];
%str = [str, 'NET "in_1_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K26;',     '\n'];
%str = [str, 'NET "in_1_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H30;',     '\n'];
%str = [str, 'NET "in_1_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G31;',     '\n'];
%str = [str, 'NET "in_1_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J24;',     '\n'];
%str = [str, 'NET "in_1_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J25;',     '\n'];
%str = [str, 'NET "in_1_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G27;',     '\n'];
%str = [str, 'NET "in_1_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H27;',     '\n'];
%str = [str, 'NET "in_1_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G25;',     '\n'];
%str = [str, 'NET "in_1_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G26;',     '\n'];
%str = [str, 'NET "in_2_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = M31;',     '\n'];
%str = [str, 'NET "in_2_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = N30;',     '\n'];
%str = [str, 'NET "in_2_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = M28;',     '\n'];
%str = [str, 'NET "in_2_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = N28;',     '\n'];
%str = [str, 'NET "in_2_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = M25;',     '\n'];
%str = [str, 'NET "in_2_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = M26;',     '\n'];
%str = [str, 'NET "in_2_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K28;',     '\n'];
%str = [str, 'NET "in_2_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L28;',     '\n'];
%str = [str, 'NET "in_2_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K24;',     '\n'];
%str = [str, 'NET "in_2_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L24;',     '\n'];
%str = [str, 'NET "in_2_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H29;',     '\n'];
%str = [str, 'NET "in_2_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J29;',     '\n'];
%str = [str, 'NET "in_2_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H28;',     '\n'];
%str = [str, 'NET "in_2_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G28;',     '\n'];
%str = [str, 'NET "in_2_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F31;',     '\n'];
%str = [str, 'NET "in_2_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = E31;',     '\n'];
%str = [str, 'NET "in_3_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = N27;',     '\n'];
%str = [str, 'NET "in_3_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = M27;',     '\n'];
%str = [str, 'NET "in_3_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L29;',     '\n'];
%str = [str, 'NET "in_3_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = K29;',     '\n'];
%str = [str, 'NET "in_3_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L25;',     '\n'];
%str = [str, 'NET "in_3_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = L26;',     '\n'];
%str = [str, 'NET "in_3_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J30;',     '\n'];
%str = [str, 'NET "in_3_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = J31;',     '\n'];
%str = [str, 'NET "in_3_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G33;',     '\n'];
%str = [str, 'NET "in_3_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F34;',     '\n'];
%str = [str, 'NET "in_3_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = G30;',     '\n'];
%str = [str, 'NET "in_3_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F30;',     '\n'];
%str = [str, 'NET "in_3_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H25;',     '\n'];
%str = [str, 'NET "in_3_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = H24;',     '\n'];
%str = [str, 'NET "in_3_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = E29;',     '\n'];
%str = [str, 'NET "in_4_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = F29;',     '\n'];
%str = [str, 'NET "in_4_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK26;',    '\n'];
%str = [str, 'NET "in_4_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ27;',    '\n'];
%str = [str, 'NET "in_4_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK28;',    '\n'];
%str = [str, 'NET "in_4_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK27;',    '\n'];
%str = [str, 'NET "in_4_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ30;',    '\n'];
%str = [str, 'NET "in_4_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH30;',    '\n'];
%str = [str, 'NET "in_4_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF24;',    '\n'];
%str = [str, 'NET "in_4_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG25;',    '\n'];
%str = [str, 'NET "in_4_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG28;',    '\n'];
%str = [str, 'NET "in_4_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH28;',    '\n'];
%str = [str, 'NET "in_4_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG32;',    '\n'];
%str = [str, 'NET "in_4_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH32;',    '\n'];
%str = [str, 'NET "in_4_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF31;',    '\n'];
%str = [str, 'NET "in_4_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG31;',    '\n'];
%str = [str, 'NET "in_4_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF33;',    '\n'];
%str = [str, 'NET "in_4_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE33;',    '\n'];
%str = [str, 'NET "in_5_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AN32;',    '\n'];
%str = [str, 'NET "in_5_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AP32;',    '\n'];
%str = [str, 'NET "in_5_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AM33;',    '\n'];
%str = [str, 'NET "in_5_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AM32;',    '\n'];
%str = [str, 'NET "in_5_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH27;',    '\n'];
%str = [str, 'NET "in_5_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ26;',    '\n'];
%str = [str, 'NET "in_5_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH29;',    '\n'];
%str = [str, 'NET "in_5_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG30;',    '\n'];
%str = [str, 'NET "in_5_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF25;',    '\n'];
%str = [str, 'NET "in_5_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF26;',    '\n'];
%str = [str, 'NET "in_5_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD24;',    '\n'];
%str = [str, 'NET "in_5_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE24;',    '\n'];
%str = [str, 'NET "in_5_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE28;',    '\n'];
%str = [str, 'NET "in_5_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF28;',    '\n'];
%str = [str, 'NET "in_5_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AC25;',    '\n'];
%str = [str, 'NET "in_5_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AC24;',    '\n'];
%str = [str, 'NET "in_6_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AN34;',    '\n'];
%str = [str, 'NET "in_6_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AN33;',    '\n'];
%str = [str, 'NET "in_6_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK29;',    '\n'];
%str = [str, 'NET "in_6_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ29;',    '\n'];
%str = [str, 'NET "in_6_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ31;',    '\n'];
%str = [str, 'NET "in_6_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK31;',    '\n'];
%str = [str, 'NET "in_6_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ32;',    '\n'];
%str = [str, 'NET "in_6_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK32;',    '\n'];
%str = [str, 'NET "in_6_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH34;',    '\n'];
%str = [str, 'NET "in_6_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ34;',    '\n'];
%str = [str, 'NET "in_6_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE27;',    '\n'];
%str = [str, 'NET "in_6_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE26;',    '\n'];
%str = [str, 'NET "in_6_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD26;',    '\n'];
%str = [str, 'NET "in_6_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD25;',    '\n'];
%str = [str, 'NET "in_6_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF34;',    '\n'];
%str = [str, 'NET "in_6_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE34;',    '\n'];
%str = [str, 'NET "in_7_p<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AJ25;',    '\n'];
%str = [str, 'NET "in_7_n<0>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH25;',    '\n'];
%str = [str, 'NET "in_7_p<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AL34;',    '\n'];
%str = [str, 'NET "in_7_n<1>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AL33;',    '\n'];
%str = [str, 'NET "in_7_p<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK34;',    '\n'];
%str = [str, 'NET "in_7_n<2>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AK33;',    '\n'];
%str = [str, 'NET "in_7_p<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG27;',    '\n'];
%str = [str, 'NET "in_7_n<3>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG26;',    '\n'];
%str = [str, 'NET "in_7_p<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF29;',    '\n'];
%str = [str, 'NET "in_7_n<4>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AF30;',    '\n'];
%str = [str, 'NET "in_7_p<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AG33;',    '\n'];
%str = [str, 'NET "in_7_n<5>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AH33;',    '\n'];
%str = [str, 'NET "in_7_p<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AE29;',    '\n'];
%str = [str, 'NET "in_7_n<6>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD29;',    '\n'];
%str = [str, 'NET "in_7_p<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AD30;',    '\n'];
%str = [str, 'NET "in_7_n<7>"  IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE | LOC = AC29;',    '\n'];

str = [str, '', '\n'];
str = [str, 'INST "*async_data_fifo_inst/BU2/U0/grf.rf/mem/gdm.dm/Mram*" TNM= RAMSOURCE;',                        '\n'];
str = [str, 'INST "*async_data_fifo_inst/BU2/U0/grf.rf/mem/gdm.dm/dout*" TNM= FFDEST;',                           '\n'];
str = [str, 'TIMESPEC TS_RAM_FF= FROM "RAMSOURCE" TO "FFDEST" ', num2str(clk_period*(6/4)), ' ns DATAPATHONLY;',  '\n'];
str = [str, 'NET "*BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc*" TIG;', '\n'];
str = [str, 'NET "*BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc*" TIG;', '\n'];
%str = [str, '', '\n'];
%str = [str, '', '\n'];

%str = [str, 'NET "', inst_name, '_rst_gpio_ext<0>"       LOC = R33 | IOSTANDARD = LVCMOS25;',       '\n'];

%str = [str, '', '\n'];

%if strcmp(use_spi,'on')
%    str = [str, 'NET "', inst_name, '_spi_data_gpio_ext<0>"  LOC = P34 | IOSTANDARD = LVCMOS25;',   '\n'];
%    str = [str, 'NET "', inst_name, '_spi_clk_gpio_ext<0>"   LOC = N34 | IOSTANDARD = LVCMOS25;',   '\n'];
%    str = [str, 'NET "', inst_name, '_spi_cs_gpio_ext<0>"    LOC = N33 | IOSTANDARD = LVCMOS25;',   '\n'];
%    str = [str, '', '\n'];
%    str = [str, '', '\n'];
%end
