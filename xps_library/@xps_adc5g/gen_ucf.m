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
disp('adc_iserdes gen_ucf')

hw_sys = blk_obj.hw_sys;
disp('adc_iserdes trying generic ucf generation')
str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));
disp('adc_iserdes trying specific ucf generation')
switch hw_sys

    case 'ROACH'
	    disp('read gen_ucf.m for iserdes KSG');
       % 		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_buf"    PERIOD             = ',num2str(1000/blk_obj.adc_clk_rate),'ns;\n'];
        %		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_buf"    MAXDELAY           = 452ps;\n'];
        %		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk_dcm"    MAXDELAY           = 853ps;\n'];
        %		str = [str, 'NET  "',simulink_name,'/',simulink_name,'/adc_clk90_dcm"  MAXDELAY           = 853ps;\n'];
    otherwise 
	      disp('error in gen_ucf.... not roach ');
end % switch hw_sys
