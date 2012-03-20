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
str = '';

str = [str, 'NET "sram0_address<0>" LOC = "AC32";\n'];
str = [str, 'NET "sram0_address<1>" LOC = "AC31";\n'];
str = [str, 'NET "sram0_address<2>" LOC = "AB27";\n'];
str = [str, 'NET "sram0_address<3>" LOC = "AB28";\n'];
str = [str, 'NET "sram0_address<4>" LOC = "AE34";\n'];
str = [str, 'NET "sram0_address<5>" LOC = "AD34";\n'];
str = [str, 'NET "sram0_address<6>" LOC = "AB29";\n'];
str = [str, 'NET "sram0_address<7>" LOC = "AB30";\n'];
str = [str, 'NET "sram0_address<8>" LOC = "AA27";\n'];
str = [str, 'NET "sram0_address<9>" LOC = "AA28";\n'];
str = [str, 'NET "sram0_address<10>" LOC = "AB31";\n'];
str = [str, 'NET "sram0_address<11>" LOC = "AB32";\n'];
str = [str, 'NET "sram0_address<12>" LOC = "AA29";\n'];
str = [str, 'NET "sram0_address<13>" LOC = "W24";\n'];
str = [str, 'NET "sram0_address<14>" LOC = "V24";\n'];
str = [str, 'NET "sram0_address<15>" LOC = "AA34";\n'];
str = [str, 'NET "sram0_address<16>" LOC = "Y34";\n'];
str = [str, 'NET "sram0_address<17>" LOC = "V31";\n'];
str = [str, 'NET "sram0_address<18>" LOC = "V32";\n'];
str = [str, 'NET "sram0_bw_b<0>" LOC = "W33";\n'];
str = [str, 'NET "sram0_bw_b<1>" LOC = "V29";\n'];
str = [str, 'NET "sram0_bw_b<2>" LOC = "V30";\n'];
str = [str, 'NET "sram0_bw_b<3>" LOC = "V27";\n'];
str = [str, 'NET "sram0_we_b" LOC = "V26";\n'];
str = [str, 'NET "sram0_adv_ld_b" LOC = "W31";\n'];
str = [str, 'NET "sram0_clk" LOC = "Y33";\n'];
str = [str, 'NET "sram0_ce" LOC = "V28";\n'];
str = [str, 'NET "sram0_oe_b" LOC = "W32";\n'];
str = [str, 'NET "sram0_cen_b" LOC = "V25";\n'];
str = [str, 'NET "sram0_dq<0>" LOC = "Y25";\n'];
str = [str, 'NET "sram0_dq<1>" LOC = "Y26";\n'];
str = [str, 'NET "sram0_dq<2>" LOC = "AC34";\n'];
str = [str, 'NET "sram0_dq<3>" LOC = "AB34";\n'];
str = [str, 'NET "sram0_dq<4>" LOC = "AA31";\n'];
str = [str, 'NET "sram0_dq<5>" LOC = "AA32";\n'];
str = [str, 'NET "sram0_dq<6>" LOC = "W25";\n'];
str = [str, 'NET "sram0_dq<7>" LOC = "W26";\n'];
str = [str, 'NET "sram0_dq<8>" LOC = "AA30";\n'];
str = [str, 'NET "sram0_dq<9>" LOC = "AA33";\n'];
str = [str, 'NET "sram0_dq<10>" LOC = "Y28";\n'];
str = [str, 'NET "sram0_dq<11>" LOC = "Y29";\n'];
str = [str, 'NET "sram0_dq<12>" LOC = "W27";\n'];
str = [str, 'NET "sram0_dq<13>" LOC = "W28";\n'];
str = [str, 'NET "sram0_dq<14>" LOC = "Y31";\n'];
str = [str, 'NET "sram0_dq<15>" LOC = "Y32";\n'];
str = [str, 'NET "sram0_dq<16>" LOC = "W29";\n'];
str = [str, 'NET "sram0_dq<17>" LOC = "W30";\n'];
str = [str, 'NET "sram0_dq<18>" LOC = "AC25";\n'];
str = [str, 'NET "sram0_dq<19>" LOC = "AC26";\n'];
str = [str, 'NET "sram0_dq<20>" LOC = "AG33";\n'];
str = [str, 'NET "sram0_dq<21>" LOC = "AG34";\n'];
str = [str, 'NET "sram0_dq<22>" LOC = "AE30";\n'];
str = [str, 'NET "sram0_dq<23>" LOC = "AE31";\n'];
str = [str, 'NET "sram0_dq<24>" LOC = "AD27";\n'];
str = [str, 'NET "sram0_dq<25>" LOC = "AD28";\n'];
str = [str, 'NET "sram0_dq<26>" LOC = "AF32";\n'];
str = [str, 'NET "sram0_dq<27>" LOC = "AF33";\n'];
str = [str, 'NET "sram0_dq<28>" LOC = "AE33";\n'];
str = [str, 'NET "sram0_dq<29>" LOC = "AD29";\n'];
str = [str, 'NET "sram0_dq<30>" LOC = "AD30";\n'];
str = [str, 'NET "sram0_dq<31>" LOC = "AB25";\n'];
str = [str, 'NET "sram0_dq<32>" LOC = "AB26";\n'];
str = [str, 'NET "sram0_dq<33>" LOC = "AD31";\n'];
str = [str, 'NET "sram0_dq<34>" LOC = "AD32";\n'];
str = [str, 'NET "sram0_dq<35>" LOC = "AC28";\n'];
str = [str, 'NET "sram0_mode" LOC = "AC29";\n'];
str = [str, 'NET "sram0_zz" LOC = "AB33";\n'];
