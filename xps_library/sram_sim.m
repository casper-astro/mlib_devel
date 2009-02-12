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

function sram_sim (this_block)

    if isempty(getenv('MLIB_ROOT'))
        error('MLIB_ROOT environment variable must be set to point to mlib directory.');
    else
        mlib_root = getenv('MLIB_ROOT');
    end

    this_block.setTopLevelLanguage('VHDL');
    this_block.setEntityName('sram_sim');

    this_block.addSimulinkInport('we');
    this_block.addSimulinkInport('be');
    this_block.addSimulinkInport('address');
    this_block.addSimulinkInport('data_in');

    this_block.addSimulinkOutport('data_out');
    this_block.addSimulinkOutport('data_valid');

    this_block.addClkCEPair('clk','ce',1);

    this_block.port('we').setType('Bool');
    this_block.port('be').setType('UFix_4_0');
    this_block.port('address').setType('UFix_19_0');
    this_block.port('data_in').setType('UFix_36_0');

    this_block.port('data_out').setRate(1);
    this_block.port('data_out').setType('UFix_36_0');

    this_block.port('data_valid').setRate(1);
    this_block.port('data_valid').setType('UFix_1_0');

    this_block.addFile([mlib_root,'\xps_library\hdlsimfiles\sram_sim\package_utility.vhd']);
    this_block.addFile([mlib_root,'\xps_library\hdlsimfiles\sram_sim\CY7C1370DV25.vhd']);
    this_block.addFile([mlib_root,'\xps_library\hdlsimfiles\sram_sim\sram_interface.vhd']);
    this_block.addFile([mlib_root,'\xps_library\hdlsimfiles\sram_sim\sram_sim.vhd']);

return;
