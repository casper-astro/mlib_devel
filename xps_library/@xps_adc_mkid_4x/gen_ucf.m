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

str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));

%str = '';
%simulink_name = clear_name(get(blk_obj,'simulink_name'));

%I_clk_p_str = ['adcmkid', blk_obj.adc_brd,'_DRDY_I_p'];
%I_clk_n_str = ['adcmkid', blk_obj.adc_brd,'_DRDY_I_n'];

%Q_clk_p_str = ['adcmkid', blk_obj.adc_brd,'_DRDY_Q_p'];
%Q_clk_n_str = ['adcmkid', blk_obj.adc_brd,'_DRDY_Q_n'];

%str = [str, 'NET ', I_clk_p_str, '       TNM_NET = ', I_clk_p_str, ';\n'];
%str = [str, 'TIMESPEC TS_', I_clk_p_str, ' = PERIOD ', I_clk_p_str, ' ', num2str(2*1000/blk_obj.adc_clk_rate, '%3.3f'), ' ns;\n'];
%str = [str, 'NET ', I_clk_n_str, '       TNM_NET = ', I_clk_n_str, ';\n'];
%str = [str, 'TIMESPEC TS_', I_clk_n_str, ' = PERIOD ', I_clk_n_str, ' ', num2str(2*1000/blk_obj.adc_clk_rate, '%3.3f'), ' ns;\n'];

%str = [str, '\n'];

%str = [str, 'NET ', Q_clk_p_str, '       TNM_NET = ', Q_clk_p_str, ';\n'];
%str = [str, 'TIMESPEC TS_', Q_clk_p_str, ' = PERIOD ', Q_clk_p_str, ' ', num2str(2*1000/blk_obj.adc_clk_rate, '%3.3f'), ' ns;\n'];
%str = [str, 'NET ', Q_clk_n_str, '       TNM_NET = ', Q_clk_n_str, ';\n'];
%str = [str, 'TIMESPEC TS_', Q_clk_n_str, ' = PERIOD ', Q_clk_n_str, ' ', num2str(2*1000/blk_obj.adc_clk_rate, '%3.3f'), ' ns;\n'];

%str = [str, '\n'];

%str = [str, gen_ucf(blk_obj.xps_block)];


end
