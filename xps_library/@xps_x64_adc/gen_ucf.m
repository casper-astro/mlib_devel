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

str = [str, '', '\n'];
str = [str, 'INST "*async_data_fifo_inst/BU2/U0/grf.rf/mem/gdm.dm/Mram*" TNM= RAMSOURCE;',                        '\n'];
str = [str, 'INST "*async_data_fifo_inst/BU2/U0/grf.rf/mem/gdm.dm/dout*" TNM= FFDEST;',                           '\n'];
str = [str, 'TIMESPEC TS_RAM_FF= FROM "RAMSOURCE" TO "FFDEST" ', num2str(clk_period*(6/4)), ' ns DATAPATHONLY;',  '\n'];
str = [str, 'NET "*BU2/U0/grf.rf/gcx.clkx/wr_pntr_gc*" TIG;', '\n'];
str = [str, 'NET "*BU2/U0/grf.rf/gcx.clkx/rd_pntr_gc*" TIG;', '\n'];
