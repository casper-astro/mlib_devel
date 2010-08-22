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
disp('adc086000 gen_ucf')

hw_sys = blk_obj.hw_sys;
adc_str = blk_obj.adc_str;
disp('adc086000 trying generic ucf generation')
str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));
disp('adc08600 trying specific ucf generation')
switch hw_sys
    case 'ROACH'
        switch adc_str
            case 'adc0'
        %		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_sync"       MAXDELAY           = 1ns;\n'];
            % end case 'adc0'
            case 'adc1'
        %		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_sync"       MAXDELAY           = 1ns;\n'];
            % end case 'adc1'
        end % switch adc_str

    case 'iBOB'
        switch adc_str
            case 'adc0'
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_buf"    PERIOD             = ',num2str(1000/blk_obj.adc_clk_rate*4),'ns;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_buf"    MAXDELAY           = 452ps;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_dcm"    MAXDELAY           = 853ps;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk90_dcm"  MAXDELAY           = 853ps;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLK_CLKBUF"     LOC                = BUFGMUX1P;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLK90_CLKBUF"   LOC                = BUFGMUX3P;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLKSHIFT_DCM"   LOC                = DCM_X2Y1;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLKSHIFT_DCM"   CLKOUT_PHASE_SHIFT = VARIABLE;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_sync"       MAXDELAY           = 323ps;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_sync"       ROUTE              = "{3;1;2vp50ff1152;46c47c12!-1;156520;5632;S!0;-159;0!1;-1884;-1248!1;-1884;744!2;-1548;992!2;-1548;304!3;-1548;-656!3;-1548;-1344!4;327;0;L!5;167;0;L!6;327;0;L!7;167;0;L!}";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_3" LOC                = SLICE_X139Y91;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_2" LOC                = SLICE_X138Y91;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_1" LOC                = SLICE_X139Y90;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_0" LOC                = SLICE_X138Y90;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_0" LOC         = "SLICE_X138Y128" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_1" LOC         = "SLICE_X138Y126" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_2" LOC         = "SLICE_X139Y122" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_3" LOC         = "SLICE_X138Y120" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_4" LOC         = "SLICE_X138Y102" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_5" LOC         = "SLICE_X139Y98" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_6" LOC         = "SLICE_X138Y96" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_7" LOC         = "SLICE_X138Y94" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_8" LOC         = "SLICE_X139Y126" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_9" LOC         = "SLICE_X138Y124" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_10" LOC        = "SLICE_X138Y122" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_11" LOC        = "SLICE_X139Y118" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_12" LOC        = "SLICE_X138Y100" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_13" LOC        = "SLICE_X138Y98" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_14" LOC        = "SLICE_X139Y94" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_15" LOC        = "SLICE_X138Y92" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_16" LOC        = "SLICE_X138Y128" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_17" LOC        = "SLICE_X138Y126" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_18" LOC        = "SLICE_X139Y122" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_19" LOC        = "SLICE_X138Y120" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_20" LOC        = "SLICE_X138Y102" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_21" LOC        = "SLICE_X139Y98" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_22" LOC        = "SLICE_X138Y96" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_23" LOC        = "SLICE_X138Y94" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_24" LOC        = "SLICE_X139Y126" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_25" LOC        = "SLICE_X138Y124" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_26" LOC        = "SLICE_X138Y122" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_27" LOC        = "SLICE_X139Y118" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_28" LOC        = "SLICE_X138Y100" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_29" LOC        = "SLICE_X138Y98" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_30" LOC        = "SLICE_X139Y94" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_31" LOC        = "SLICE_X138Y92" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_0" LOC         = "SLICE_X138Y132" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_1" LOC         = "SLICE_X139Y134" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_2" LOC         = "SLICE_X138Y170" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_3" LOC         = "SLICE_X138Y172" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_4" LOC         = "SLICE_X139Y106" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_5" LOC         = "SLICE_X138Y110" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_6" LOC         = "SLICE_X138Y112" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_7" LOC         = "SLICE_X139Y114" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_8" LOC         = "SLICE_X138Y134" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_9" LOC         = "SLICE_X138Y168" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_10" LOC        = "SLICE_X139Y170" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_11" LOC        = "SLICE_X138Y174" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_12" LOC        = "SLICE_X138Y108" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_13" LOC        = "SLICE_X139Y110" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_14" LOC        = "SLICE_X138Y114" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_15" LOC        = "SLICE_X138Y116" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_16" LOC        = "SLICE_X138Y132" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_17" LOC        = "SLICE_X139Y134" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_18" LOC        = "SLICE_X138Y170" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_19" LOC        = "SLICE_X138Y172" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_20" LOC        = "SLICE_X139Y106" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_21" LOC        = "SLICE_X138Y110" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_22" LOC        = "SLICE_X138Y112" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_23" LOC        = "SLICE_X139Y114" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_24" LOC        = "SLICE_X138Y134" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_25" LOC        = "SLICE_X138Y168" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_26" LOC        = "SLICE_X139Y170" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_27" LOC        = "SLICE_X138Y174" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_28" LOC        = "SLICE_X138Y108" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_29" LOC        = "SLICE_X139Y110" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_30" LOC        = "SLICE_X138Y114" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_31" LOC        = "SLICE_X138Y116" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangei_recapture_0" LOC   = "SLICE_X138Y118" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangei_recapture_1" LOC   = "SLICE_X138Y118" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangeq_recapture_0" LOC   = "SLICE_X138Y104" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangeq_recapture_1" LOC   = "SLICE_X138Y104" | BEL = "FFY";\n'];
            % end case 'adc0'

            case 'adc1'
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_buf"    PERIOD             = ',num2str(1000/blk_obj.adc_clk_rate*4),'ns;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_buf"    MAXDELAY           = 452ps;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_dcm"    MAXDELAY           = 854ps;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk90_dcm"  MAXDELAY           = 854ps;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLK_CLKBUF"     LOC                = BUFGMUX0P;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLK90_CLKBUF"   LOC                = BUFGMUX2P;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLKSHIFT_DCM"   LOC                = DCM_X2Y0;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/CLKSHIFT_DCM"   CLKOUT_PHASE_SHIFT = VARIABLE;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_sync"       MAXDELAY           = 323ps;\n'];
        		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_sync"       ROUTE              = "{3;1;2vp50ff1152;6b4b9e45!-1;156520;-144648;S!0;-159;0!1;-1884;-1248!1;-1884;744!2;-1548;992!2;-1548;304!3;-1548;-656!3;-1548;-1344!4;327;0;L!5;167;0;L!6;327;0;L!7;167;0;L!}";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_3" LOC                = SLICE_X139Y3;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_2" LOC                = SLICE_X138Y3;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_1" LOC                = SLICE_X139Y2;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_sync_ddr_0" LOC                = SLICE_X138Y2;\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_0" LOC         = "SLICE_X139Y70" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_1" LOC         = "SLICE_X138Y68" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_2" LOC         = "SLICE_X139Y64" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_3" LOC         = "SLICE_X139Y62" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_4" LOC         = "SLICE_X139Y44" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_5" LOC         = "SLICE_X139Y42" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_6" LOC         = "SLICE_X138Y40" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_7" LOC         = "SLICE_X139Y4" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_8" LOC         = "SLICE_X139Y68" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_9" LOC         = "SLICE_X139Y66" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_10" LOC        = "SLICE_X138Y64" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_11" LOC        = "SLICE_X139Y60" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_12" LOC        = "SLICE_X138Y44" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_13" LOC        = "SLICE_X139Y40" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_14" LOC        = "SLICE_X139Y6" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_15" LOC        = "SLICE_X138Y4" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_16" LOC        = "SLICE_X139Y70" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_17" LOC        = "SLICE_X138Y68" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_18" LOC        = "SLICE_X139Y64" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_19" LOC        = "SLICE_X139Y62" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_20" LOC        = "SLICE_X139Y44" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_21" LOC        = "SLICE_X139Y42" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_22" LOC        = "SLICE_X138Y40" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_23" LOC        = "SLICE_X139Y4" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_24" LOC        = "SLICE_X139Y68" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_25" LOC        = "SLICE_X139Y66" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_26" LOC        = "SLICE_X138Y64" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_27" LOC        = "SLICE_X139Y60" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_28" LOC        = "SLICE_X138Y44" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_29" LOC        = "SLICE_X139Y40" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_30" LOC        = "SLICE_X139Y6" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_datai_recapture_31" LOC        = "SLICE_X138Y4" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_0" LOC         = "SLICE_X139Y74" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_1" LOC         = "SLICE_X139Y78" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_2" LOC         = "SLICE_X139Y80" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_3" LOC         = "SLICE_X138Y84" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_4" LOC         = "SLICE_X139Y48" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_5" LOC         = "SLICE_X138Y52" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_6" LOC         = "SLICE_X139Y54" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_7" LOC         = "SLICE_X139Y56" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_8" LOC         = "SLICE_X138Y76" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_9" LOC         = "SLICE_X138Y80" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_10" LOC        = "SLICE_X139Y82" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_11" LOC        = "SLICE_X139Y84" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_12" LOC        = "SLICE_X139Y50" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_13" LOC        = "SLICE_X139Y52" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_14" LOC        = "SLICE_X138Y56" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_15" LOC        = "SLICE_X139Y58" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_16" LOC        = "SLICE_X139Y74" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_17" LOC        = "SLICE_X139Y78" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_18" LOC        = "SLICE_X139Y80" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_19" LOC        = "SLICE_X138Y84" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_20" LOC        = "SLICE_X139Y48" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_21" LOC        = "SLICE_X138Y52" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_22" LOC        = "SLICE_X139Y54" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_23" LOC        = "SLICE_X139Y56" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_24" LOC        = "SLICE_X138Y76" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_25" LOC        = "SLICE_X138Y80" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_26" LOC        = "SLICE_X139Y82" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_27" LOC        = "SLICE_X139Y84" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_28" LOC        = "SLICE_X139Y50" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_29" LOC        = "SLICE_X139Y52" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_30" LOC        = "SLICE_X138Y56" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_dataq_recapture_31" LOC        = "SLICE_X139Y58" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangei_recapture_0" LOC   = "SLICE_X138Y60" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangei_recapture_1" LOC   = "SLICE_X138Y60" | BEL = "FFY";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangeq_recapture_0" LOC   = "SLICE_X138Y48" | BEL = "FFX";\n'];
        		str = [str, 'INST "',simulink_name,'/',simulink_name,'/adc_outofrangeq_recapture_1" LOC   = "SLICE_X138Y48" | BEL = "FFY";\n'];
            % end case 'adc1'
        end % switch adc_str
    % end case 'iBOB'
end % switch hw_sys
