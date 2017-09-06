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

function forty_gbe_mask(blk)

cursys = blk;

set_param(cursys, 'LinkStatus', 'inactive');

% rename gateways
gateway_ins = find_system(cursys, 'searchdepth', 1, 'FollowLinks', ...
    'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
for i = 1 : length(gateway_ins)
    gw = gateway_ins{i};
    if regexp(get_param(gw, 'Name'), '_tx_afull$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_afull']));
    elseif regexp(get_param(gw, 'Name'), '_tx_overflow$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_overflow']));
    elseif regexp(get_param(gw, 'Name'), '_rx_valid$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_valid']));
    elseif regexp(get_param(gw, 'Name'), '_rx_data$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_data']));
    elseif regexp(get_param(gw, 'Name'), '_rx_source_ip$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_source_ip']));
    elseif regexp(get_param(gw, 'Name'), '_rx_source_port$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_source_port']));
    elseif regexp(get_param(gw, 'Name'), '_rx_dest_ip$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_dest_ip']));
    elseif regexp(get_param(gw, 'Name'), '_rx_dest_port$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_dest_port']));
    elseif regexp(get_param(gw, 'Name'), '_rx_end_of_frame$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_end_of_frame']));
    elseif regexp(get_param(gw, 'Name'), '_rx_bad_frame$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_bad_frame']));
    elseif regexp(get_param(gw, 'Name'), '_rx_overrun$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_overrun']));
    elseif regexp(get_param(gw, 'Name'), '_led_up$')
        set_param(gw, 'Name', clear_name([cursys, '_led_up']));
    elseif regexp(get_param(gw, 'Name'), '_led_rx$')
        set_param(gw, 'Name', clear_name([cursys, '_led_rx']));
    elseif regexp(get_param(gw, 'Name'), '_led_tx$')
        set_param(gw, 'Name', clear_name([cursys, '_led_tx']));
    elseif regexp(get_param(gw, 'Name'), '_rx_size$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_size']));
    else
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', ...
            get_param(gw, 'Name')]);
    end
end
gateway_outs = find_system(cursys, 'searchdepth', 1, ...
    'FollowLinks', 'on', 'lookundermasks', 'all', ...
    'masktype', 'Xilinx Gateway Out Block');
for i = 1 : length(gateway_outs)
    gw = gateway_outs{i};
    if regexp(get_param(gw, 'Name'), '_rst$')
        set_param(gw, 'Name', clear_name([cursys, '_rst']));
    elseif regexp(get_param(gw, 'Name'), '_tx_valid$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_valid']));
    elseif regexp(get_param(gw, 'Name'), '_tx_end_of_frame$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_end_of_frame']));
    elseif regexp(get_param(gw, 'Name'), '_tx_discard$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_discard']));
    elseif regexp(get_param(gw, 'Name'), '_tx_data$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_data']));
    elseif regexp(get_param(gw, 'Name'), '_tx_dest_ip$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_dest_ip']));
    elseif regexp(get_param(gw, 'Name'), '_tx_dest_port$')
        set_param(gw, 'Name', clear_name([cursys, '_tx_dest_port']));
    elseif regexp(get_param(gw, 'Name'), '_rx_ack$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_ack']));
    elseif regexp(get_param(gw, 'Name'), '_rx_overrun_ack$')
        set_param(gw, 'Name', clear_name([cursys, '_rx_overrun_ack']));
    else
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', ...
            get_param(gw, 'Name')]);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% do debug counters and supporting logic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make sure the terminator and port are there
reuse_block(cursys, 'debug_rst', 'built-in/inport', 'Port', '9', ...
    'Position', [120   137   150   153]);
reuse_block(cursys, 'term1', 'built-in/Terminator', ...
    'Position', [200   135   220   155]);
try add_line(cursys, 'debug_rst/1', 'term1/1'); catch e, end

try
    debug_ctr_width = get_param(cursys, 'debug_ctr_width');
catch e
    debug_ctr_width = '16';
end

% cater for the 4-bit valid, if needed
try
    fbv = get_param(cursys, 'four_bit_valid');
catch e
    fbv = 'on';
end
if strcmp(fbv, 'on')
    rx_valid_blk = clear_name([cursys, '_rx_valid']);
    try delete_block_lines(rx_valid_blk); catch e, end
    reuse_block(cursys, 'rx_dv_or_exp', ...
        'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', ...
        'outputNum', '4', 'outputWidth', '1', 'outputBinaryPt', '0', ...
        'outputArithmeticType', '2', 'show_format', 'off', ...
        'outputToWorkspace', 'off', 'outputToModelAsWell', 'off', ...
        'Position', [970 367 1020 443]);
    reuse_block(cursys, 'rx_dv_or', 'xbsIndex_r4/Logical', ...
            'logical_function', 'OR', ...
            'latency', '1', ...
            'inputs', '4', ...
            'arith_type', 'Boolean', ...
            'Position', [1065 367 1120 443]);
    try
        add_line(cursys, [rx_valid_blk, '/1'], 'rx_dv_or_exp/1');
    catch e
    end
    for ctr = 1:4
        try
            add_line(cursys, ['rx_dv_or_exp/', num2str(ctr)], ...
                ['rx_dv_or/', num2str(ctr)]);
        catch e
        end
    end
    valid_source = 'rx_dv_or';
else
    valid_source = clear_name([cursys, '_rx_valid']);
    try delete_block_lines([cursys, '/rx_dv_or_exp']); catch e, end
    try delete_block_lines([cursys, '/rx_dv_or']); catch e, end
end

function draw_counter(sys, xpos, ypos, targetname, sourcename)
    ctr_name = [targetname, '_ctr'];
    delay_name = [targetname, '_del'];
    try delete_block_lines([sys, '/', targetname]); catch e, end
    try delete_block_lines([sys, '/', ctr_name]); catch e, end
    try delete_block_lines([sys, '/', delay_name]); catch e, end
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [xpos ypos xpos+20 ypos+25]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', ...
            'io_delay', '1', 'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [xpos+150 ypos xpos+200 ypos+20]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, ...
            'explicit_period', 'on', 'period', '1', ...
            'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [xpos+50 ypos xpos+100 ypos+45]);
        try add_line(sys, 'debug_rst/1', [delay_name, '/1']); catch e, end
        try add_line(sys, [delay_name, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [sourcename, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

function draw_errorcounter(sys, xpos, ypos, targetname, frame_len, sourceoef, sourcevalid)
    ctr_name = [targetname, '_ctr'];
    nobad_name = [targetname, '_nobad'];
    errchk_name = [targetname, '_errchk'];
    delay_name = [targetname, '_del'];
    try delete_block_lines([sys, '/', errchk_name]); catch e, end
    try delete_block_lines([sys, '/', nobad_name]); catch e, end
    try delete_block_lines([sys, '/', targetname]); catch e, end
    try delete_block_lines([sys, '/', ctr_name]); catch e, end
    try delete_block_lines([sys, '/', delay_name]); catch e, end
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [xpos ypos xpos+20 ypos+25]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', ...
            'io_delay', '1', 'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [xpos+150 ypos xpos+200 ypos+20]);
        reuse_block(sys, errchk_name, 'casper_library_communications/frame_len_checker', ...
            'frame_len', frame_len, ...
            'Position', [xpos-100, ypos, xpos, ypos+45]);
        reuse_block(sys, nobad_name, 'xbsIndex_r4/Constant', ...
            'arith_type', 'Boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
            'Position', [xpos-150 ypos+30 xpos-130 ypos+45]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [xpos+50 ypos xpos+100 ypos+45]);
        try add_line(sys, [sourcevalid, '/1'], [errchk_name, '/1']); catch e, end
        try add_line(sys, [sourceoef, '/1'], [errchk_name, '/2']); catch e, end
        try add_line(sys, [nobad_name, '/1'], [errchk_name, '/3']); catch e, end
        try add_line(sys, 'debug_rst/1', [delay_name, '/1']); catch e, end
        try add_line(sys, [delay_name, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [errchk_name, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', errchk_name]); catch e, end
        try delete_block([sys, '/', nobad_name]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

function draw_rxcounter(sys, xpos, ypos, targetname, sourceoef, sourcevalid)
    ctr_name = [targetname, '_ctr'];
    and_name = [targetname, '_and'];
    ed_name = [targetname, '_ed'];
    delay_name = [targetname, '_del'];
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [xpos ypos xpos+20 ypos+25]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', ...
            'io_delay', '1', 'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [xpos+350 ypos xpos+400 ypos+20]);
        reuse_block(sys, and_name, 'xbsIndex_r4/Logical', ...
            'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
            'latency', '1', 'Position', [xpos+50 ypos xpos+100 ypos+45]);
        reuse_block(sys, ed_name, 'casper_library_misc/edge_detect', ...
            'edge', 'Rising', 'polarity', 'Active High', ...
            'Position', [xpos+150 ypos xpos+200 ypos+20]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [xpos+250 ypos xpos+300 ypos+45]);
        try add_line(sys, [sourceoef, '/1'], [and_name, '/1']); catch e, end
        try add_line(sys, [sourcevalid, '/1'], [and_name, '/2']); catch e, end
        try add_line(sys, [and_name, '/1'], [ed_name, '/1']); catch e, end
        try add_line(sys, 'debug_rst/1', [delay_name, '/1']); catch e, end
        try add_line(sys, [delay_name, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [ed_name, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block_lines([sys, '/', and_name]); catch e, end
        try delete_block_lines([sys, '/', ed_name]); catch e, end
        try delete_block_lines([sys, '/', targetname]); catch e, end
        try delete_block_lines([sys, '/', ctr_name]); catch e, end
        try delete_block_lines([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', and_name]); catch e, end
        try delete_block([sys, '/', ed_name]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

% tx counter
starty = 850;
draw_rxcounter(cursys, 400, starty, 'txctr', 'tx_end_of_frame', 'tx_valid');

% tx error counter
starty = starty + 50;
draw_errorcounter(cursys, 400, starty, 'txerrctr', get_param(cursys, 'txerrctr_len'), 'tx_end_of_frame', 'tx_valid');

% tx overflow counter
starty = starty + 50;
draw_counter(cursys, 400, starty, 'txofctr', clear_name([cursys, '_tx_overflow']));

% tx full counter
starty = starty + 50;
draw_counter(cursys, 400, starty, 'txfullctr', clear_name([cursys, '_tx_afull']));

% tx valid counter
starty = starty + 50;
draw_counter(cursys, 400, starty, 'txvldctr', 'tx_valid')

% draw all the tx registers

% rx counter
starty = 130;
draw_rxcounter(cursys, 1400, starty, 'rxctr', clear_name([cursys, '_rx_end_of_frame']), valid_source)

% rx error counter
starty = starty + 50;
draw_errorcounter(cursys, 1400, starty, 'rxerrctr', get_param(cursys, 'rxerrctr_len'), clear_name([cursys, '_rx_end_of_frame']), valid_source);

% rx overflow counter
starty = starty + 50;
draw_counter(cursys, 1400, starty, 'rxofctr', clear_name([cursys, '_rx_overrun']));

% rx bad frame counter
starty = starty + 50;
draw_counter(cursys, 1400, starty, 'rxbadctr', clear_name([cursys, '_rx_bad_frame']));

% rx valid counter
starty = starty + 50;
draw_counter(cursys, 1400, starty, 'rxvldctr', valid_source);

% rx eof counter
starty = starty + 50;
draw_counter(cursys, 1400, starty, 'rxeofctr', clear_name([cursys, '_rx_end_of_frame']));

% draw all the rx registers

% rx snapshot
snaplen = get_param(cursys, 'rxsnaplen');
if strcmp(snaplen, '0 - no snap') == 0
    reuse_block(cursys, 'rxs0', 'casper_library_scopes/bitfield_snapshot', ...
        'Position', [1620        1304        1725        1526], ...
        'io_names', '[led_up led_rx valid_in ip_in eof_in bad_frame overrun]', ...
        'io_widths', '[1 1 1 32 1 1 1]', 'io_bps', '[0 0 0 0 0 0 0]', ...
        'io_types', '[2 2 2 0 2 2 2]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '64', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    reuse_block(cursys, 'rxs_exp', ...
        'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', ...
        'outputNum', '2', 'outputWidth', '128', 'outputBinaryPt', '0', ...
        'outputArithmeticType', '0', 'show_format', 'off', ...
        'outputToWorkspace', 'off', 'outputToModelAsWell', 'off', ...
        'Position', [1510        1617        1560        1693]);
    try add_line(cursys, [clear_name([cursys, '_rx_data']), '/1'], ...
            'rxs_exp/1'); catch e, end
    reuse_block(cursys, 'rxs1', 'casper_library_scopes/bitfield_snapshot', ...
        'Position', [1620        1581        1725        1809], ...
        'io_names', '[data_msw]', ...
        'io_widths', '[128]', 'io_bps', '[0]', ...
        'io_types', '[0]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    reuse_block(cursys, 'rxs2', 'casper_library_scopes/bitfield_snapshot', ...
        'Position', [1620        1866        1725        2094], ...
        'io_names', '[data_lsw]', ...
        'io_widths', '[128]', 'io_bps', '[0]', ...
        'io_types', '[0]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    try set_param([cursys, '/rxs0'], 'snap_ext_arm', 'off'); catch e, end;
    try set_param([cursys, '/rxs1'], 'snap_ext_arm', 'off'); catch e, end;
    try set_param([cursys, '/rxs2'], 'snap_ext_arm', 'off'); catch e, end;
    reuse_block(cursys, 'rxsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', ...
        'inputs', '2', ...
        'Position', [1510 1504 1560  1551]);
    try add_line(cursys, [clear_name([cursys, '_led_up']), '/1'],           'rxs0/1'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_led_rx']), '/1'],           'rxs0/2'); catch e, end
    try add_line(cursys, [valid_source, '/1'],                              'rxs0/3'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_source_ip']), '/1'],     'rxs0/4'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_end_of_frame']), '/1'],  'rxs0/5'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_bad_frame']), '/1'],     'rxs0/6'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_overrun']), '/1'],       'rxs0/7'); catch e, end
    try add_line(cursys, [valid_source, '/1'],                              'rxs0/8'); catch e, end
    try add_line(cursys, [valid_source, '/1'],                              'rxsnap_and/1'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_end_of_frame']), '/1'],  'rxsnap_and/2'); catch e, end
    try add_line(cursys, 'rxsnap_and/1',                                    'rxs0/9'); catch e, end
    
    try add_line(cursys, 'rxs_exp/1', 'rxs1/1'); catch e, end
    try add_line(cursys, [valid_source, '/1'], 'rxs1/2'); catch e, end
    try add_line(cursys, 'rxsnap_and/1', 'rxs1/3'); catch e, end
    
    try add_line(cursys, 'rxs_exp/2', 'rxs2/1'); catch e, end
    try add_line(cursys, [valid_source, '/1'], 'rxs2/2'); catch e, end
    try add_line(cursys, 'rxsnap_and/1', 'rxs2/3'); catch e, end
    
else
    try delete_block_lines([cursys, '/rxs0']); catch e, end
    try delete_block_lines([cursys, '/rxs1']); catch e, end
    try delete_block_lines([cursys, '/rxs2']); catch e, end
    try delete_block_lines([cursys, '/rxs_exp']); catch e, end
    try delete_block_lines([cursys, '/rxsnap_and']); catch e, end
    try delete_block([cursys, '/rxs0']); catch e, end
    try delete_block([cursys, '/rxs1']); catch e, end
    try delete_block([cursys, '/rxs2']); catch e, end
    try delete_block([cursys, '/rxs_exp']); catch e, end
    try delete_block([cursys, '/rxsnap_and']); catch e, end
end
% tx snapshot
snaplen = get_param(cursys, 'txsnaplen');
if strcmp(snaplen, '0 - no snap') == 0
    reuse_block(cursys, 'txs0', ...
        'casper_library_scopes/bitfield_snapshot', ...
        'Position', [400 1302 500 1528], ...
        'io_names', '[link_up led_tx tx_full tx_over valid eof ip]', ...
        'io_widths', '[1 1 1 1 1 1 32]', 'io_bps', '[0 0 0 0 0 0 0]', ...
        'io_types', '[2 2 2 2 2 2 0]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '64', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    reuse_block(cursys, 'txs_exp', ...
        'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', ...
        'outputNum', '2', 'outputWidth', '128', 'outputBinaryPt', '0', ...
        'outputArithmeticType', '0', 'show_format', 'off', ...
        'outputToWorkspace', 'off', 'outputToModelAsWell', 'off', ...
        'Position', [330 1597 380 1673]);
    try add_line(cursys, 'tx_data/1', 'txs_exp/1'); catch e, end
    reuse_block(cursys, 'txs1', ...
        'casper_library_scopes/bitfield_snapshot', ...
        'Position', [400 1582 500 1808], ...
        'io_names', '[data_msw]', 'io_widths', '[128]', ...
        'io_bps', '[0]', 'io_types', '[0]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    reuse_block(cursys, 'txs2', ...
        'casper_library_scopes/bitfield_snapshot', ...
        'Position', [400 1867 500 2093], ...
        'io_names', '[data_lsw]', 'io_widths', '[128]', ...
        'io_bps', '[0]', 'io_types', '[0]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    try set_param([cursys, '/txs0'], 'snap_ext_arm', 'off'); catch e, end;
    try set_param([cursys, '/txs1'], 'snap_ext_arm', 'off'); catch e, end;
    try set_param([cursys, '/txs2'], 'snap_ext_arm', 'off'); catch e, end;
    reuse_block(cursys, 'txsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
        'Position', [330 1479 380 1526]);
    try add_line(cursys, [clear_name([cursys, '_led_up']), '/1'],           'txs0/1'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_led_tx']), '/1'],           'txs0/2'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_tx_afull']), '/1'],         'txs0/3'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_tx_overflow']), '/1'],      'txs0/4'); catch e, end
    try add_line(cursys, 'tx_valid/1',                                      'txs0/5'); catch e, end
    try add_line(cursys, 'tx_end_of_frame/1',                               'txs0/6'); catch e, end
    try add_line(cursys, 'tx_dest_ip/1',                                    'txs0/7'); catch e, end
    try add_line(cursys, 'tx_valid/1',                                      'txs0/8'); catch e, end
    try add_line(cursys, 'tx_valid/1',         'txsnap_and/1'); catch e, end
    try add_line(cursys, 'tx_end_of_frame/1',  'txsnap_and/2'); catch e, end
    try add_line(cursys, 'txsnap_and/1',                                    'txs0/9'); catch e, end
    
    try add_line(cursys, 'txs_exp/1', 'txs1/1'); catch e, end
    try add_line(cursys, 'tx_valid/1', 'txs1/2'); catch e, end
    try add_line(cursys, 'txsnap_and/1', 'txs1/3'); catch e, end
    
    try add_line(cursys, 'txs_exp/2', 'txs2/1'); catch e, end
    try add_line(cursys, 'tx_valid/1', 'txs2/2'); catch e, end
    try add_line(cursys, 'txsnap_and/1', 'txs2/3'); catch e, end
else
    try delete_block_lines([cursys, '/txs0']); catch e, end
    try delete_block_lines([cursys, '/txs1']); catch e, end
    try delete_block_lines([cursys, '/txs2']); catch e, end
    try delete_block_lines([cursys, '/txs_exp']); catch e, end
    try delete_block_lines([cursys, '/txsnap_and']); catch e, end
    try delete_block([cursys, '/txs0']); catch e, end
    try delete_block([cursys, '/txs1']); catch e, end
    try delete_block([cursys, '/txs2']); catch e, end
    try delete_block([cursys, '/txs_exp']); catch e, end
    try delete_block([cursys, '/txsnap_and']); catch e, end
end

% remove unconnected blocks
clean_blocks(cursys);

end
% end
