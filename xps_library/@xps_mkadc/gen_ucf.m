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
                str = [str,'#ZDOK0 MeerKAT ADC Setup & Hold Constraints for FPGA\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns VALID 1.1 ns BEFORE "adc0_adc_clk_p" RISING;\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns VALID 1.1 ns BEFORE "adc0_adc_clk_p" FALLING;\n'];             
                str = [str,'\n'];
                str = [str,'# meerKAT ADC0 Pins\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK A\n'];
                str = [str,'NET "adc0_adc_data_b_p<9>"      LOC = L35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB9+      ZDOK A5,  P<2>\n'];
                str = [str,'NET "adc0_adc_data_b_n<9>"      LOC = L36   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB9-      ZDOK A6,  N<2>\n'];
                str = [str,'NET "adc0_adc_data_b_p<6>"      LOC = K35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB6+      ZDOK A7,  P<3>\n'];
                str = [str,'NET "adc0_adc_data_b_n<6>"      LOC = K34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB6-      ZDOK A8,  N<3>\n'];
                str = [str,'NET "adc0_adc_data_b_p<4>"      LOC = J35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB4+      ZDOK A9   P<4>\n'];
                str = [str,'NET "adc0_adc_data_b_n<4>"      LOC = H35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB4-      ZDOK A10, N<4>\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK D\n'];
                str = [str,'NET "adc0_adc_reset"            LOC = N28   | IOSTANDARD = LVCMOS25;                    # ASYNC_RST ZDOK D1,  P<10>\n'];
                str = [str,'#NET "adc0_adc_i2c_sda"          LOC = P28   | IOSTANDARD = LVCMOS25;                    # i2c_sda   ZDOK D2,  N<10>\n'];
                str = [str,'NET "adc0_adc_data_b_p<7>"      LOC = K39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB7+      ZDOK D7,  P<13>\n'];
                str = [str,'NET "adc0_adc_data_b_n<7>"      LOC = K40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB7-      ZDOK D8,  N<13>\n'];
                str = [str,'NET "adc0_adc_or_a_p"           LOC = E42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # AOR+      ZDOK D13, P<16>\n'];
                str = [str,'NET "adc0_adc_or_a_n"           LOC = F42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # AOR-      ZDOK D14, N<16>\n'];
                str = [str,'NET "adc0_adc_data_a_p<6>"      LOC = C40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA6+      ZDOK D15, P<17>\n'];
                str = [str,'NET "adc0_adc_data_a_n<6>"      LOC = C41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA6-      ZDOK D16, N<17>\n'];
                str = [str,'NET "adc0_adc_data_a_p<3>"      LOC = E39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA3+      ZDOK D17, P<18>\n'];
                str = [str,'NET "adc0_adc_data_a_n<3>"      LOC = E38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA3-      ZDOK D18, N<18>\n'];
                str = [str,'NET "adc0_adc_data_a_p<1>"      LOC = B37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA1+      ZDOK D19, P<19>\n'];
                str = [str,'NET "adc0_adc_data_a_n<1>"      LOC = A37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA1-      ZDOK D20, N<19>\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK C\n'];
                str = [str,'NET "adc0_adc_or_b_p"           LOC = M33   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # BOR+      ZDOK C3,  P<21>\n'];
                str = [str,'NET "adc0_adc_or_b_n"           LOC = M32   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # BOR-      ZDOK C4,  N<21>\n'];
                str = [str,'NET "adc0_adc_data_b_p<8>"      LOC = N29   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB8+      ZDOK C5,  P<22>\n'];
                str = [str,'NET "adc0_adc_data_b_n<8>"      LOC = N30   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB8-      ZDOK C6,  N<22>\n'];
                str = [str,'NET "adc0_adc_data_b_p<5>"      LOC = L34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB5+      ZDOK C7,  P<23>\n'];
                str = [str,'NET "adc0_adc_data_b_n<5>"      LOC = M34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB5-      ZDOK C8,  N<23>\n'];
                str = [str,'NET "adc0_adc_data_b_p<3>"      LOC = G34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB3+      ZDOK C9,  P<24>\n'];
                str = [str,'NET "adc0_adc_data_b_n<3>"      LOC = H34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB3-      ZDOK C10, N<24>\n'];
                str = [str,'NET "adc0_adc_data_b_p<1>"      LOC = F39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB1+      ZDOK C11, P<25>\n'];
                str = [str,'NET "adc0_adc_data_b_n<1>"      LOC = G39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB1-      ZDOK C12, N<25>\n'];
                str = [str,'NET "adc0_adc_data_a_p<9>"      LOC = F37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA9+      ZDOK C13, P<26>\n'];
                str = [str,'NET "adc0_adc_data_a_n<9>"      LOC = E37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA9-      ZDOK C14, N<26>\n'];
                str = [str,'NET "adc0_adc_data_a_p<7>"      LOC = D42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA7+      ZDOK C15, P<27>\n'];
                str = [str,'NET "adc0_adc_data_a_n<7>"      LOC = D41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA7-      ZDOK C16, N<27>\n'];
                str = [str,'NET "adc0_adc_data_a_p<4>"      LOC = A40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA4+      ZDOK C17, P<28>\n'];
                str = [str,'NET "adc0_adc_data_a_n<4>"      LOC = A41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA4-      ZDOK C18, N<28>\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK F\n'];
                str = [str,'NET "adc0_adc_demux_bist"       LOC = L31   | IOSTANDARD = LVCMOS25;                    # DMUX_BIST ZDOK F1,  P<29>\n'];
                str = [str,'#NET "adc0_adc_i2c_scl"         LOC = L32   | IOSTANDARD = LVCMOS25;                    # I2C_SCL   ZDOK F2,  N<29>\n'];
                str = [str,'NET "adc0_adc_sync_p"           LOC = J37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # SYNC+     ZDOK F3   P<30>\n'];
                str = [str,'NET "adc0_adc_sync_n"           LOC = J36   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # SYNC-     ZDOK F4   N<30>\n'];
                str = [str,'NET "adc0_adc_data_b_p<2>"      LOC = H39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB2+      ZDOK F9   P<33>\n'];
                str = [str,'NET "adc0_adc_data_b_n<2>"      LOC = H38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB2-      ZDOK F10  N<33>\n'];
                str = [str,'NET "adc0_adc_data_b_p<0>"      LOC = D40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB0+      ZDOK F11  P<34>\n'];
                str = [str,'NET "adc0_adc_data_b_n<0>"      LOC = E40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB0-      ZDOK F12  N<34>\n'];
                str = [str,'NET "adc0_adc_data_a_p<8>"      LOC = F40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA8+      ZDOK F13  P<35>\n'];
                str = [str,'NET "adc0_adc_data_a_n<8>"      LOC = F41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA8-      ZDOK F14  N<35>\n'];
                str = [str,'NET "adc0_adc_data_a_p<5>"      LOC = F35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA5+      ZDOK F15, P<36>\n'];
                str = [str,'NET "adc0_adc_data_a_n<5>"      LOC = F36   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA5-      ZDOK F16, N<36>\n'];
                str = [str,'NET "adc0_adc_data_a_p<2>"      LOC = D38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA2+      ZDOK F17, P<37>\n'];
                str = [str,'NET "adc0_adc_data_a_n<2>"      LOC = C38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA2-      ZDOK F18, N<37>\n'];
                str = [str,'NET "adc0_adc_data_a_p<0>"      LOC = P30   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA0+      ZDOK F19, adc0_clk_p<1>\n'];
                str = [str,'NET "adc0_adc_data_a_n<0>"      LOC = P31   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA0-      ZDOK F20, adc0_clk_n<1>\n'];
                str = [str,'\n'];
                str = [str,'NET "adc0_iic_sda"              LOC = P28   | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'NET "adc0_iic_scl"              LOC = L32   | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'\n'];                
                str = [str,'NET "adc0_ser_clk"              LOC = P27   | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'NET "adc0_ser_dat"              LOC = M31   | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'NET "adc0_ser_cs"               LOC = R27   | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'\n'];
            % end case 'adc0'

            case 'adc1'

                % MeerKAT ADC ZDOK 1
                str = [str,'\n'];
                str = [str,'#MeerKAT ADC ZDOK 1 Constraints\n'];
                str = [str,'\n'];
                

                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[?].D*_1"     AREA_GROUP     = ZDOK_1 ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_1"     RANGE    = ', ...
                     'SLICE_X0Y246:SLICE_X1Y308 ;\n'];

                str = [str, 'INST "', simulink_name, '/', simulink_name, ...
                     '/adc5g_inst/data_buf[0].D0?_1"     AREA_GROUP     = ZDOK_1_0 ;\n'];
                str = [str, 'AREA_GROUP "ZDOK_1_r0"     RANGE    = ', ...
                     'SLICE_X86Y197:SLICE_X87Y198 ;\n'];

                % MeerKAT ADC Setup & Hold Constraints for FPGA
                str = [str,'#ZDOK1 MeerKAT ADC Setup & Hold Constraints for FPGA\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns BEFORE "adc1_adc_clk_p" RISING;\n'];
                %str = [str, 'OFFSET=IN ',sprintf('%1.3f',(2000.0/adc_clk_rate)-0.4),' ns BEFORE "adc1_adc_clk_p" FALLING;\n'];             
                str = [str,'\n'];
                str = [str,'# meerKAT ADC1 Pins\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK A\n'];
                str = [str,'NET "adc1_adc_data_b_p<9>"      LOC = W35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB9+      ZDOK A5,  P<2>\n'];
                str = [str,'NET "adc1_adc_data_b_n<9>"      LOC = V35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB9-      ZDOK A6,  N<2>\n'];
                str = [str,'NET "adc1_adc_data_b_p<6>"      LOC = U32   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB6+      ZDOK A7,  P<3>\n'];
                str = [str,'NET "adc1_adc_data_b_n<6>"      LOC = U33   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB6-      ZDOK A8,  N<3>\n'];
                str = [str,'NET "adc1_adc_data_b_p<4>"      LOC = U42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB4+      ZDOK A9   P<4>\n'];
                str = [str,'NET "adc1_adc_data_b_n<4>"      LOC = U41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB4-      ZDOK A10, N<4>\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK D\n'];
                str = [str,'NET "adc1_adc_reset"            LOC = AA32  | IOSTANDARD = LVCMOS25;                    # ASYNC_RST ZDOK D1,  P<10>\n'];
                str = [str,'#NET "adc1_adc_i2c_sda"          LOC = Y32   | IOSTANDARD = LVCMOS25;                    # i2c_sda   ZDOK D2,  N<10>\n'];
                str = [str,'NET "adc1_adc_data_b_p<7>"      LOC = V41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB7+      ZDOK D7,  P<13>\n'];
                str = [str,'NET "adc1_adc_data_b_n<7>"      LOC = W41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB7-      ZDOK D8,  N<13>\n'];
                str = [str,'NET "adc1_adc_or_a_p"           LOC = T41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # AOR+      ZDOK D13, P<16>\n'];
                str = [str,'NET "adc1_adc_or_a_n"           LOC = T42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # AOR-      ZDOK D14, N<16>\n'];
                str = [str,'NET "adc1_adc_data_a_p<6>"      LOC = R39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA6+      ZDOK D15, P<17>\n'];
                str = [str,'NET "adc1_adc_data_a_n<6>"      LOC = P38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA6-      ZDOK D16, N<17>\n'];
                str = [str,'NET "adc1_adc_data_a_p<3>"      LOC = N36   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA3+      ZDOK D17, P<18>\n'];
                str = [str,'NET "adc1_adc_data_a_n<3>"      LOC = P37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA3-      ZDOK D18, N<18>\n'];
                str = [str,'NET "adc1_adc_data_a_p<1>"      LOC = N40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA1+      ZDOK D19, P<19>\n'];
                str = [str,'NET "adc1_adc_data_a_n<1>"      LOC = N41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA1-      ZDOK D20, N<19>\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK C\n'];
                str = [str,'NET "adc1_adc_or_b_p"           LOC = W32   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # BOR+      ZDOK C3,  P<21>\n'];
                str = [str,'NET "adc1_adc_or_b_n"           LOC = Y33   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # BOR-      ZDOK C4,  N<21>\n'];
                str = [str,'NET "adc1_adc_data_b_p<8>"      LOC = W36   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB8+      ZDOK C5,  P<22>\n'];
                str = [str,'NET "adc1_adc_data_b_n<8>"      LOC = V36   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB8-      ZDOK C6,  N<22>\n'];
                str = [str,'NET "adc1_adc_data_b_p<5>"      LOC = V40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB5+      ZDOK C7,  P<23>\n'];
                str = [str,'NET "adc1_adc_data_b_n<5>"      LOC = W40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB5-      ZDOK C8,  N<23>\n'];
                str = [str,'NET "adc1_adc_data_b_p<3>"      LOC = U37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB3+      ZDOK C9,  P<24>\n'];
                str = [str,'NET "adc1_adc_data_b_n<3>"      LOC = U38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB3-      ZDOK C10, N<24>\n'];
                str = [str,'NET "adc1_adc_data_b_p<1>"      LOC = T39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB1+      ZDOK C11, P<25>\n'];
                str = [str,'NET "adc1_adc_data_b_n<1>"      LOC = R38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB1-      ZDOK C12, N<25>\n'];
                str = [str,'NET "adc1_adc_data_a_p<9>"      LOC = P42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA9+      ZDOK C13, P<26>\n'];
                str = [str,'NET "adc1_adc_data_a_n<9>"      LOC = R42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA9-      ZDOK C14, N<26>\n'];
                str = [str,'NET "adc1_adc_data_a_p<7>"      LOC = P40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA7+      ZDOK C15, P<27>\n'];
                str = [str,'NET "adc1_adc_data_a_n<7>"      LOC = P41   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA7-      ZDOK C16, N<27>\n'];
                str = [str,'NET "adc1_adc_data_a_p<4>"      LOC = M38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA4+      ZDOK C17, P<28>\n'];
                str = [str,'NET "adc1_adc_data_a_n<4>"      LOC = M39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA4-      ZDOK C18, N<28>\n'];
                str = [str,'\n'];
                str = [str,'# ZDOK F\n'];
                str = [str,'NET "adc1_adc_demux_bist"       LOC = AA36  | IOSTANDARD = LVCMOS25;                    # DMUX_BIST ZDOK F1,  P<29>\n'];
                str = [str,'#NET "adc1_adc_i2c_scl"         LOC = AA37  | IOSTANDARD = LVCMOS25;                    # I2C_SCL   ZDOK F2,  N<29>\n'];
                str = [str,'NET "adc1_adc_sync_p"           LOC = W42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # SYNC+     ZDOK F3   P<30>\n'];
                str = [str,'NET "adc1_adc_sync_n"           LOC = Y42   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # SYNC-     ZDOK F4   N<30>\n'];
                str = [str,'NET "adc1_adc_data_b_p<2>"      LOC = V34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB2+      ZDOK F9   P<33>\n'];
                str = [str,'NET "adc1_adc_data_b_n<2>"      LOC = U34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB2-      ZDOK F10  N<33>\n'];
                str = [str,'NET "adc1_adc_data_b_p<0>"      LOC = T34   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB0+      ZDOK F11  P<34>\n'];
                str = [str,'NET "adc1_adc_data_b_n<0>"      LOC = T35   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DB0-      ZDOK F12  N<34>\n'];
                str = [str,'NET "adc1_adc_data_a_p<8>"      LOC = R40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA8+      ZDOK F13  P<35>\n'];
                str = [str,'NET "adc1_adc_data_a_n<8>"      LOC = T40   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA8-      ZDOK F14  N<35>\n'];
                str = [str,'NET "adc1_adc_data_a_p<5>"      LOC = M36   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA5+      ZDOK F15, P<36>\n'];
                str = [str,'NET "adc1_adc_data_a_n<5>"      LOC = M37   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA5-      ZDOK F16, N<36>\n'];
                str = [str,'NET "adc1_adc_data_a_p<2>"      LOC = N38   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA2+      ZDOK F17, P<37>\n'];
                str = [str,'NET "adc1_adc_data_a_n<2>"      LOC = N39   | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA2-      ZDOK F18, N<37>\n'];
                str = [str,'NET "adc1_adc_data_a_p<0>"      LOC = AE30  | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA0+      ZDOK F19, adc1_clk_p<1>\n'];
                str = [str,'NET "adc1_adc_data_a_n<0>"      LOC = AF30  | IOSTANDARD = LVDS_25 | DIFF_TERM = TRUE;  # DA0-      ZDOK F20, adc1_clk_n<1>\n'];
                str = [str,'\n'];
                str = [str,'NET "adc1_iic_sda" LOC = Y32    | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'NET "adc1_iic_scl" LOC = AA37   | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'\n'];                
                str = [str,'NET "adc1_ser_clk" LOC = AA34   | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'NET "adc1_ser_dat" LOC = Y34    | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'NET "adc1_ser_cs"  LOC = Y37    | IOSTANDARD = LVCMOS25 | SLEW = SLOW;\n'];
                str = [str,'\n'];
            % end case 'adc1'
        end % switch adc_str
    % end case 'ROACH2'
    otherwise
        error(['Unsupported hardware system: ',s.hw_sys]);
end % switch hw_sys
