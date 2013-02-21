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

function dram_sim (this_block)

    xps_library_path = getenv('XPS_LIBRARY_PATH');
    if isempty(xps_library_path)
        % try to fall back on MLIB_ROOT.
        mlib_root = getenv('MLIB_DEVEL_PATH');
        if isempty(mlib_root)
            error('MLIB_DEVEL_PATH environment variable must be set to point to xps_library directory.');
        else
            warning('MLIB_ROOT environment variable is deprecated.')
            xps_library_path = [mlib_root, '\xps_library'];
        end
    end

    simwrapper = get_param(this_block.blockName, 'parent');
    xpswrapper = get_param(simwrapper, 'parent');

    half_burst = get_param(xpswrapper, 'half_burst');
    wide_data  = get_param(xpswrapper, 'wide_data');

    ip_clock = str2num(get_param(xpswrapper, 'ip_clock'));
    sysclk_per = round(ip_clock/200 * 500);


    this_block.setTopLevelLanguage('VHDL');
    this_block.setEntityName('dram_sim');
    this_block.tagAsCombinational;


    this_block.addGeneric('C_WIDE_DATA', 'Integer', num2str(strcmp(wide_data, 'on')));
    this_block.addGeneric('C_HALF_BURST', 'Integer', num2str(strcmp(half_burst, 'on')));
    this_block.addGeneric('SYSCLK_PER', 'Time', [num2str(sysclk_per),' ms']);
    this_block.addGeneric('IP_CLOCK', 'Integer', num2str(ip_clock));


    this_block.addSimulinkInport('rst');
    this_block.addSimulinkInport('address');
    this_block.addSimulinkInport('data_in');
    this_block.addSimulinkInport('wr_be');
    this_block.addSimulinkInport('RWn');
    this_block.addSimulinkInport('cmd_tag');
    this_block.addSimulinkInport('cmd_valid');
    this_block.addSimulinkInport('rd_ack');

    this_block.addSimulinkOutport('cmd_ack');
    this_block.addSimulinkOutport('data_out');
    this_block.addSimulinkOutport('rd_tag');
    this_block.addSimulinkOutport('rd_valid');

    this_block.addSimulinkOutport('ddr_clock');
    this_block.addSimulinkOutport('ddr_clock90');
    this_block.port('ddr_clock').setType('Bool');
    this_block.port('ddr_clock').setRate(1);
    this_block.port('ddr_clock90').setType('Bool');
    this_block.port('ddr_clock90').setRate(1);


    this_block.addClkCEPair('clk', 'ce', 1);


    this_block.port('rst').setType('UFix_1_0');
    this_block.port('address').setType('UFix_32_0');

    if strcmp(wide_data, 'on')
        this_block.port('data_in').setType('UFix_288_0');
        this_block.port('wr_be').setType('UFix_36_0');
    else
        this_block.port('data_in').setType('UFix_144_0');
        this_block.port('wr_be').setType('UFix_18_0');
    end

    this_block.port('RWn').setType('UFix_1_0');
    this_block.port('cmd_tag').setType('UFix_32_0');
    this_block.port('cmd_valid').setType('UFix_1_0');
    this_block.port('rd_ack').setType('UFix_1_0');

    this_block.port('cmd_ack').setType('Bool');

    if strcmp(wide_data, 'on')
        this_block.port('data_out').setType('UFix_288_0');
    else
        this_block.port('data_out').setType('UFix_144_0');
    end

    this_block.port('rd_tag').setType('UFix_32_0');
    this_block.port('rd_valid').setType('Bool');

    this_block.port('cmd_ack').setRate(1);
    this_block.port('data_out').setRate(1);
    this_block.port('rd_tag').setRate(1);
    this_block.port('rd_valid').setRate(1);


    this_block.addFile([xps_library_path, '\hdlsimfiles\dram_sim\xilinx_sim_src.vhd']);
    this_block.addFile([xps_library_path, '\hdlsimfiles\dram_sim\ddr2_parameters.vh']);
    this_block.addFile([xps_library_path, '\hdlsimfiles\dram_sim\ddr2_sim.v']);
    this_block.addFile([xps_library_path, '\hdlsimfiles\dram_sim\ddr2_controller.vhd']);
    this_block.addFile([xps_library_path, '\hdlsimfiles\dram_sim\async_ddr2.v']);
    this_block.addFile([xps_library_path, '\hdlsimfiles\dram_sim\dram_sim.vhd']);

return;
