%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2012 University of California, Berkeley                     %
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
function [str,opb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj,opb_addr_start,opb_name)

% Generate MHS stanzas for ADC16's built-in snapshot BRAMs.
%
% The adc16_interface pcore has no OPB interfaces itself, but it does provide
% outputs to drive embedded (i.e. not in the Simulink model) shared BRAMs.  The
% shared BRAMs are "attached" to the OPB bus by the MHS stanzas returned by
% this function.  The ADC16 yellow block also has an embedded
% "opb_adc16_controller" instance that drives the 3-wire interface to the ADCs
% and the IODELAY tap settings to the adc16_interface instance.  The ADC16
% yellow block appears in the OPB address space as a 20 KB block ram.  The
% first 4KB of address space holds the control registers.  The remaining 16 KB
% of address space holds the shared BRAMs for the 4 ADC chips (4 KB per ADC).
%
% Note that ADCs are special yellow blocks in that they have a fixed starting
% address within the OPB address space, namely 0x0020_0000.
%
% Here is the adc16_controller memory map:
%
% 0x0002_0000 - 0x0002_0FFF : Control registers
% 0x0002_1000 - 0x0002_1FFF : Snapshot buffer for ADC A
% 0x0002_2000 - 0x0002_2FFF : Snapshot buffer for ADC B
% 0x0002_3000 - 0x0002_3FFF : Snapshot buffer for ADC C
% 0x0002_4000 - 0x0002_4FFF : Snapshot buffer for ADC D
%
% Note that a single Shared BRAM consists of a trio of separate pcores:
%
%   * bram_if - This is the "fabric" (i.e. Simulink) side of the Shared BRAM.
%   * bram_block - This is the actual dual-port BRAM primitive.
%   * opb_bram_if_cntlr - This is the OPB side of the Shared BRAM.

% Call gen_mhs_ip for superclass xps_block to create adc16_interface instance
[str,opb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj.xps_block,opb_addr_start,opb_name);

% Then generate embedded Shared BRAM blocks to follow opb_adc16_controller in
% OPB address space.

blk_name = get(blk_obj,'simulink_name');
inst_name = clear_name(blk_name);
xsg_obj = get(blk_obj,'xsg_obj');

% Start address for embedded opb_adc16_controller instance
adc_addr_start = hex2dec('00020000');

snap_chan = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'};

str = [str, '\n'];

for k = 1:blk_obj.num_units
  snap_name = ['adc16_snap_', snap_chan{k}];

  str = [str, '# ', blk_name, ' - Embedded Shared BRAM for ADC ', upper(snap_chan{k}), '\n'];
  str = [str, 'BEGIN bram_if\n'];
  str = [str, ' PARAMETER INSTANCE = ',snap_name,'_ramif\n'];
  str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
  str = [str, ' PARAMETER ADDR_SIZE = 10\n'];
  str = [str, ' BUS_INTERFACE PORTA = ',snap_name,'_ramblk_porta\n'];
  str = [str, ' PORT clk_in   = ',get(xsg_obj,'clk_src'),'\n'];
  str = [str, ' PORT addr     = adc16_snap_addr\n'];
  str = [str, ' PORT data_in  = ',inst_name,'_',snap_chan{k}, '1 & ', ...
                                  inst_name,'_',snap_chan{k}, '2 & ', ...
                                  inst_name,'_',snap_chan{k}, '3 & ', ...
                                  inst_name,'_',snap_chan{k}, '4\n'];
  %str = [str, ' PORT data_out = \n'];
  str = [str, ' PORT we       = adc16_snap_we\n'];
  str = [str, 'END\n\n'];

  str = [str, 'BEGIN bram_block\n'];
  str = [str, ' PARAMETER INSTANCE = ',snap_name,'_ramblk\n'];
  str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
  str = [str, ' BUS_INTERFACE PORTA = ',snap_name,'_ramblk_porta\n'];
  str = [str, ' BUS_INTERFACE PORTB = ',snap_name,'_ramblk_portb\n'];
  str = [str, 'END\n\n'];

  str = [str, 'BEGIN opb_bram_if_cntlr\n'];
  str = [str, ' PARAMETER INSTANCE = ',snap_name,'\n'];
  str = [str, ' PARAMETER HW_VER = 1.00.a\n'];
  str = [str, ' PARAMETER C_OPB_CLK_PERIOD_PS = 10000\n'];
  str = [str, ' PARAMETER C_BASEADDR = 0x',dec2hex(adc_addr_start+k*4096),'\n'];
  str = [str, ' PARAMETER C_HIGHADDR = 0x',dec2hex(adc_addr_start+k*4096+4095),'\n'];
  str = [str, ' BUS_INTERFACE SOPB = ',opb_name,'\n'];
  str = [str, ' BUS_INTERFACE PORTA = ',snap_name,'_ramblk_portb\n'];
  str = [str, 'END\n\n'];
end
