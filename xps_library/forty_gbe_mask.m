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
gateway_ins = find_system(cursys, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway In Block');
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
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', get_param(gw, 'Name')]);
    end
end
gateway_outs = find_system(cursys, 'searchdepth', 1, 'FollowLinks', 'on', 'lookundermasks', 'all', 'masktype', 'Xilinx Gateway Out Block');
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
        errordlg(['Unknown gateway: ', get_param(gw, 'Parent'), '/', get_param(gw, 'Name')]);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% do debug counters and supporting logic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% make sure the terminator and port are there
reuse_block(cursys, 'debug_rst', 'built-in/inport', 'Port', '9', 'Position', [120   137   150   153]);
reuse_block(cursys, 'term1', 'built-in/Terminator', 'Position', [200   135   220   155]);
try add_line(cursys, 'debug_rst/1', 'term1/1'); catch e, end

function draw_counter(sys, ypos, targetname, sourcename)
    ctr_name = [targetname, '_ctr'];
    delay_name = [targetname, '_del'];
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [400 ypos 420 ypos+25]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', 'io_delay', '1', ...
            'sim_port', 'no', 'Position', [550 ypos 600 ypos+20]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', '32', 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [450 ypos 500 ypos+45]);
        try add_line(sys, 'debug_rst/1', [delay_name, '/1']); catch e, end
        try add_line(sys, [delay_name, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [sourcename, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block_lines([sys, '/', targetname]); catch e, end
        try delete_block_lines([sys, '/', ctr_name]); catch e, end
        try delete_block_lines([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

function draw_errorcounter(sys, ypos, targetname, frame_len, sourceoef, sourcevalid)
    ctr_name = [targetname, '_ctr'];
    nobad_name = [targetname, '_nobad'];
    errchk_name = [targetname, '_errchk'];
    delay_name = [targetname, '_del'];
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [400 ypos 420 ypos+25]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', 'io_delay', '1', ...
            'sim_port', 'no', 'Position', [550 ypos 600 ypos+20]);
        reuse_block(sys, errchk_name, 'casper_library_communications/frame_len_checker', ...
            'frame_len', frame_len, ...
            'Position', [300, ypos, 400, ypos+45]);
        reuse_block(sys, nobad_name, 'xbsIndex_r4/Constant', ...
            'arith_type', 'Boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
            'Position', [250 ypos+30 270 ypos+45]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', '32', 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [450 ypos 500 ypos+45]);
        try add_line(sys, [sourcevalid, '/1'], [errchk_name, '/1']); catch e, end
        try add_line(sys, [sourceoef, '/1'], [errchk_name, '/2']); catch e, end
        try add_line(sys, [nobad_name, '/1'], [errchk_name, '/3']); catch e, end
        try add_line(sys, 'debug_rst/1', [delay_name, '/1']); catch e, end
        try add_line(sys, [delay_name, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [errchk_name, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block_lines([sys, '/', errchk_name]); catch e, end
        try delete_block_lines([sys, '/', nobad_name]); catch e, end
        try delete_block_lines([sys, '/', targetname]); catch e, end
        try delete_block_lines([sys, '/', ctr_name]); catch e, end
        try delete_block_lines([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', delay_name]); catch e, end
        try delete_block([sys, '/', errchk_name]); catch e, end
        try delete_block([sys, '/', nobad_name]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

function draw_rxcounter(sys, ypos, targetname, sourceoef, sourcevalid)
    ctr_name = [targetname, '_ctr'];
    and_name = [targetname, '_and'];
    ed_name = [targetname, '_ed'];
    delay_name = [targetname, '_del'];
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, delay_name, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [400 ypos 420 ypos+25]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', 'io_delay', '1', ...
            'sim_port', 'no', 'Position', [750 ypos 800 ypos+20]);
        reuse_block(sys, and_name, 'xbsIndex_r4/Logical', ...
            'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
            'latency', '1', 'Position', [450 ypos 500 ypos+45]);
        reuse_block(sys, ed_name, 'casper_library_misc/edge_detect', ...
            'edge', 'Rising', 'polarity', 'Active High', ...
            'Position', [550 ypos 600 ypos+20]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', '32', 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [650 ypos 700 ypos+45]);
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
draw_rxcounter(cursys, starty, 'txctr', 'tx_end_of_frame', 'tx_valid');

% tx error counter
starty = starty + 50;
draw_errorcounter(cursys, starty, 'txerrctr', get_param(cursys, 'txerrctr_len'), 'tx_end_of_frame', 'tx_valid');

% tx overflow counter
starty = starty + 50;
draw_counter(cursys, starty, 'txofctr', clear_name([cursys, '_tx_overflow']));

% tx full counter
starty = starty + 50;
draw_counter(cursys, starty, 'txfullctr', clear_name([cursys, '_tx_afull']));

% tx valid counter
starty = starty + 50;
draw_counter(cursys, starty, 'txvldctr', 'tx_valid')

% rx counter
starty = starty + 50;
draw_rxcounter(cursys, starty, 'rxctr', clear_name([cursys, '_rx_end_of_frame']), clear_name([cursys, '_rx_valid']))

% rx error counter
starty = starty + 50;
draw_errorcounter(cursys, starty, 'rxerrctr', get_param(cursys, 'rxerrctr_len'), clear_name([cursys, '_rx_end_of_frame']), clear_name([cursys, '_rx_valid']));

% rx overflow counter
starty = starty + 50;
draw_counter(cursys, starty, 'rxofctr', clear_name([cursys, '_rx_overrun']));

% rx bad frame counter
starty = starty + 50;
draw_counter(cursys, starty, 'rxbadctr', clear_name([cursys, '_rx_bad_frame']));

% rx valid counter
starty = starty + 50;
draw_counter(cursys, starty, 'rxvldctr', clear_name([cursys, '_rx_valid']));

% rx eof counter
starty = starty + 50;
draw_counter(cursys, starty, 'rxeofctr', clear_name([cursys, '_rx_end_of_frame']));

% rx snapshot
snaplen = get_param(cursys, 'rxsnaplen');
snapname = 'rxs';
if strcmp(snaplen, '0 - no snap') == 0
    reuse_block(cursys, snapname, 'casper_library_scopes/bitfield snapshot', ...
        'Position', [1055         981        1160        1234], ...
        'io_names', '[led_up led_rx data_in valid_in ip_in eof_in bad_frame overrun]', ...
        'io_widths', '[1 1 64 1 32 1 1 1]', ...
        'io_bps', '[0 0 0 0 0 0 0 0]', ...
        'io_types', '[2 2 0 2 0 2 2 2]', ...
        'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', ...
        'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', ...
        'snap_offset', 'off', ...
        'snap_circap', 'off', ...
        'snap_value', 'off', ...
        'snap_use_dsp48', 'on', ...
        'snap_delay', '2', ...
        'extra_names', '[notused]', ...
        'extra_widths', '[32]', ...
        'extra_bps', '[0]', ...
        'extra_types', '[0]');
    reuse_block(cursys, 'rxsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
        'Position', [970        1194        1020        1241]);
    try add_line(cursys, [clear_name([cursys, '_led_up']), '/1'],           [snapname, '/1']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_led_rx']), '/1'],           [snapname, '/2']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_data']), '/1'],          [snapname, '/3']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_valid']), '/1'],         [snapname, '/4']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_source_ip']), '/1'],     [snapname, '/5']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_end_of_frame']), '/1'],  [snapname, '/6']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_bad_frame']), '/1'],     [snapname, '/7']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_overrun']), '/1'],       [snapname, '/8']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_valid']), '/1'],         [snapname, '/9']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_valid']), '/1'],         'rxsnap_and/1'); catch e, end
    try add_line(cursys, [clear_name([cursys, '_rx_end_of_frame']), '/1'],  'rxsnap_and/2'); catch e, end
    try add_line(cursys, 'rxsnap_and/1',                                    [snapname, '/10']); catch e, end
else
    try delete_block_lines([cursys, '/', snapname]); catch e, end
    try delete_block_lines([cursys, '/rxsnap_and']); catch e, end
    try delete_block([cursys, '/', snapname]); catch e, end
    try delete_block([cursys, '/rxsnap_and']); catch e, end
end
% tx snapshot
snaplen = get_param(cursys, 'txsnaplen');
snapname = 'txs';
if strcmp(snaplen, '0 - no snap') == 0
    reuse_block(cursys, snapname, 'casper_library_scopes/bitfield snapshot', ...
        'Position', [1055        1302        1160        1528], ...
        'io_names', '[link_up led_tx tx_full tx_over valid eof data ip]', ...
        'io_widths', '[1 1 1 1 1 1 64 32]', ...
        'io_bps', '[0 0 0 0 0 0 0 0]', ...
        'io_types', '[2 2 2 2 2 2 0 0]', ...
        'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', ...
        'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', ...
        'snap_offset', 'off', ...
        'snap_circap', 'off', ...
        'snap_value', 'off', ...
        'snap_use_dsp48', 'on', ...
        'snap_delay', '2', ...
        'extra_names', '[notused]', ...
        'extra_widths', '[32]', ...
        'extra_bps', '[0]', ...
        'extra_types', '[0]');
    reuse_block(cursys, 'txsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
        'Position', [960        1479        1010        1526]);
    try add_line(cursys, [clear_name([cursys, '_led_up']), '/1'],           [snapname, '/1']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_led_tx']), '/1'],           [snapname, '/2']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_tx_afull']), '/1'],         [snapname, '/3']); catch e, end
    try add_line(cursys, [clear_name([cursys, '_tx_overflow']), '/1'],      [snapname, '/4']); catch e, end
    try add_line(cursys, 'tx_valid/1',                                      [snapname, '/5']); catch e, end
    try add_line(cursys, 'tx_end_of_frame/1',                               [snapname, '/6']); catch e, end
    try add_line(cursys, 'tx_data/1',                                       [snapname, '/7']); catch e, end
    try add_line(cursys, 'tx_dest_ip/1',                                    [snapname, '/8']); catch e, end
    try add_line(cursys, 'tx_valid/1',                                      [snapname, '/9']); catch e, end
    try add_line(cursys, 'tx_valid/1',         'txsnap_and/1'); catch e, end
    try add_line(cursys, 'tx_end_of_frame/1',  'txsnap_and/2'); catch e, end
    try add_line(cursys, 'txsnap_and/1',                                    [snapname, '/10']); catch e, end
else
    try delete_block_lines([cursys, '/', snapname]); catch e, end
    try delete_block_lines([cursys, '/txsnap_and']); catch e, end
    try delete_block([cursys, '/', snapname]); catch e, end
    try delete_block([cursys, '/txsnap_and']); catch e, end
end

% remove unconnected blocks
clean_blocks(cursys);

end
% end
