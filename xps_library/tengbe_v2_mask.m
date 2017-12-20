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

function tengbe_v2_mask(blk)

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

debug_ctr_width = get_param(cursys, 'debug_ctr_width');
% are any of the checkboxes actually checked?
if strcmp(get_param(blk, 'txctr'), 'on') || strcmp(get_param(blk, 'txerrctr'), 'on') || ...
        strcmp(get_param(blk, 'txofctr'), 'on') || strcmp(get_param(blk, 'txfullctr'), 'on') || ...
        strcmp(get_param(blk, 'txvldctr'), 'on') || strcmp(get_param(blk, 'rxctr'), 'on') || ...
        strcmp(get_param(blk, 'rxerrctr'), 'on') || strcmp(get_param(blk, 'rxofctr'), 'on') || ...
        strcmp(get_param(blk, 'rxbadctr'), 'on') || strcmp(get_param(blk, 'rxvldctr'), 'on') || ...
        strcmp(get_param(blk, 'rxeofctr'), 'on')
	% make sure the terminator and port are there
    reuse_block(cursys, 'debug_rst', 'built-in/inport', 'Port', '9', 'Position', [120   137   150   153]);
    reuse_block(cursys, 'debug_rst_goto', 'built-in/goto', 'GotoTag', 'debug_rst', 'Position', [200   135   280   150]);
    %reuse_block(cursys, 'term1', 'built-in/Terminator', 'Position', [200   135   220   155]);
    try add_line(cursys, 'debug_rst/1', 'debug_rst_goto/1'); catch e, end
else
    try delete_block_lines([blk, '/', 'debug_rst'], false); catch e, end
    try delete_block_lines([blk, '/', 'debug_rst_goto'], false); catch e, end
    %try delete_block_lines([blk, '/', 'term1'], false); catch e, end
end

function draw_counter(sys, ypos, targetname, source_tag)
    fromdbg_name = [targetname, '_fromdbg'];
    fromsrc_name = [targetname, '_fromsrc'];
    ctr_name = [targetname, '_ctr'];
    delay_name1 = [targetname, '_del1'];
    delay_name2 = [targetname, '_del2'];
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, fromdbg_name, 'built-in/from', ...
            'GotoTag', 'debug_rst', ...
            'Position', [280 ypos 400 ypos+12]);
        reuse_block(sys, fromsrc_name, 'built-in/from', ...
            'GotoTag', source_tag, ...
            'Position', [280 ypos+30 400 ypos+42]);
        reuse_block(sys, delay_name1, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '2', ...
            'Position', [430 ypos 450 ypos+25]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [480 ypos 530 ypos+45]);
        reuse_block(sys, delay_name2, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '2', ...
            'Position', [550 ypos 570 ypos+20]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', 'io_delay', '1', ...
            'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [600 ypos 650 ypos+20]);
        try add_line(sys, [fromdbg_name, '/1'], [delay_name1, '/1']); catch e, end
        try add_line(sys, [delay_name1, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [fromsrc_name, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [delay_name2, '/1']); catch e, end
        try add_line(sys, [delay_name2, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block_lines([sys, '/', fromdbg_name], false); catch e, end
        try delete_block_lines([sys, '/', fromsrc_name], false); catch e, end
        try delete_block_lines([sys, '/', targetname], false); catch e, end
        try delete_block_lines([sys, '/', ctr_name], false); catch e, end
        try delete_block_lines([sys, '/', delay_name1], false); catch e, end
        try delete_block_lines([sys, '/', delay_name2], false); catch e, end
        try delete_block([sys, '/', fromdbg_name]); catch e, end
        try delete_block([sys, '/', fromsrc_name]); catch e, end
        try delete_block([sys, '/', delay_name1]); catch e, end
        try delete_block([sys, '/', delay_name2]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

function draw_errorcounter(sys, ypos, targetname, frame_len, eof_tag, source_tag)
    fromdbg_name = [targetname, '_fromdbg'];
    fromeof_name = [targetname, '_fromeof'];
    fromsrc_name = [targetname, '_fromsrc'];
    ctr_name = [targetname, '_ctr'];
    nobad_name = [targetname, '_nobad'];
    errchk_name = [targetname, '_errchk'];
    delay_name1 = [targetname, '_del1'];
    delay_name2 = [targetname, '_del2'];
    
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, fromdbg_name, 'built-in/from', ...
            'GotoTag', 'debug_rst', ...
            'Position', [180 ypos 300 ypos+12]);
        reuse_block(sys, fromeof_name, 'built-in/from', ...
            'GotoTag', eof_tag, ...
            'Position', [180 ypos+15 300 ypos+27]);
        reuse_block(sys, fromsrc_name, 'built-in/from', ...
            'GotoTag', source_tag, ...
            'Position', [180 ypos+30 300 ypos+42]);
        reuse_block(sys, nobad_name, 'xbsIndex_r4/Constant', ...
            'arith_type', 'Boolean', 'const', '0', 'explicit_period', 'on', 'period', '1', ...
            'Position', [180 ypos+30 200 ypos+45]);
        reuse_block(sys, errchk_name, 'casper_library_communications/frame_len_checker', ...
            'frame_len', frame_len, ...
            'Position', [330, ypos, 420, ypos+45]);
        reuse_block(sys, delay_name1, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '2', ...
            'Position', [430 ypos 450 ypos+25]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [480 ypos 530 ypos+45]);
        reuse_block(sys, delay_name2, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '2', ...
            'Position', [550 ypos 570 ypos+20]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', 'io_delay', '1', ...
            'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [600 ypos 650 ypos+20]);
        try add_line(sys, [fromsrc_name, '/1'], [errchk_name, '/1']); catch e, end
        try add_line(sys, [fromeof_name, '/1'], [errchk_name, '/2']); catch e, end
        try add_line(sys, [nobad_name, '/1'], [errchk_name, '/3']); catch e, end
        try add_line(sys, [fromdbg_name, '/1'], [delay_name1, '/1']); catch e, end
        try add_line(sys, [delay_name1, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [errchk_name, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [delay_name2, '/1']); catch e, end
        try add_line(sys, [delay_name2, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block_lines([sys, '/', fromdbg_name], false); catch e, end
        try delete_block_lines([sys, '/', fromeof_name], false); catch e, end
        try delete_block_lines([sys, '/', fromsrc_name], false); catch e, end
        try delete_block_lines([sys, '/', errchk_name], false); catch e, end
        try delete_block_lines([sys, '/', nobad_name], false); catch e, end
        try delete_block_lines([sys, '/', targetname], false); catch e, end
        try delete_block_lines([sys, '/', ctr_name], false); catch e, end
        try delete_block_lines([sys, '/', delay_name1], false); catch e, end
        try delete_block_lines([sys, '/', delay_name2], false); catch e, end
        try delete_block([sys, '/', fromdbg_name]); catch e, end
        try delete_block([sys, '/', fromeof_name]); catch e, end
        try delete_block([sys, '/', fromsrc_name]); catch e, end
        try delete_block([sys, '/', delay_name1]); catch e, end
        try delete_block([sys, '/', delay_name2]); catch e, end
        try delete_block([sys, '/', errchk_name]); catch e, end
        try delete_block([sys, '/', nobad_name]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

function draw_rxcounter(sys, ypos, targetname, eof_tag, source_tag)
    fromdbg_name = [targetname, '_fromdbg'];
    fromeof_name = [targetname, '_fromeof'];
    fromsrc_name = [targetname, '_fromsrc'];
    ctr_name = [targetname, '_ctr'];
    and_name = [targetname, '_and'];
    ed_name = [targetname, '_ed'];
    delay_name1 = [targetname, '_del1'];
    delay_name2 = [targetname, '_del2'];
    if strcmp(get_param(sys, targetname), 'on')
        reuse_block(sys, fromdbg_name, 'built-in/from', ...
            'GotoTag', 'debug_rst', ...
            'Position', [280 ypos 400 ypos+12]);
        reuse_block(sys, fromeof_name, 'built-in/from', ...
            'GotoTag', eof_tag, ...
            'Position', [280 ypos+15 400 ypos+27]);
        reuse_block(sys, fromsrc_name, 'built-in/from', ...
            'GotoTag', source_tag, ...
            'Position', [280 ypos+30 400 ypos+42]);
        reuse_block(sys, delay_name1, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '1', ...
            'Position', [430 ypos 450 ypos+25]);
        reuse_block(sys, and_name, 'xbsIndex_r4/Logical', ...
            'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
            'latency', '1', 'Position', [480 ypos 530 ypos+45]);
        reuse_block(sys, ed_name, 'casper_library_misc/edge_detect', ...
            'edge', 'Rising', 'polarity', 'Active High',...
            'Position', [580 ypos 630 ypos+20]);
        reuse_block(sys, ctr_name, 'xbsIndex_r4/Counter', ...
            'arith_type', 'Unsigned', 'n_bits', debug_ctr_width, 'explicit_period', 'on', ...
            'period', '1', 'use_behavioral_HDL', 'on', 'rst', 'on', 'en', 'on', ...
            'Position', [680 ypos 730 ypos+45]);
        reuse_block(sys, delay_name2, 'xbsIndex_r4/Delay', ...
            'reg_retiming', 'on', 'latency', '2', ...
            'Position', [750 ypos 770 ypos+20]);
        reuse_block(sys, targetname, 'xps_library/software_register', ...
            'io_dir', 'To Processor', 'arith_types', '0', 'io_delay', '1', ...
            'bitwidths', debug_ctr_width, ...
            'sim_port', 'no', 'Position', [820 ypos 870 ypos+20]);
        try add_line(sys, [fromeof_name, '/1'], [and_name, '/1']); catch e, end
        try add_line(sys, [fromsrc_name, '/1'], [and_name, '/2']); catch e, end
        try add_line(sys, [and_name, '/1'], [ed_name, '/1']); catch e, end
        try add_line(sys, [fromdbg_name, '/1'], [delay_name1, '/1']); catch e, end
        try add_line(sys, [delay_name1, '/1'], [ctr_name, '/1']); catch e, end
        try add_line(sys, [ed_name, '/1'], [ctr_name, '/2']); catch e, end
        try add_line(sys, [ctr_name, '/1'], [delay_name2, '/1']); catch e, end
        try add_line(sys, [delay_name2, '/1'], [targetname, '/1']); catch e, end
    else
        try delete_block_lines([sys, '/', fromdbg_name], false); catch e, end
        try delete_block_lines([sys, '/', fromeof_name], false); catch e, end
        try delete_block_lines([sys, '/', fromsrc_name], false); catch e, end
        try delete_block_lines([sys, '/', and_name], false); catch e, end
        try delete_block_lines([sys, '/', ed_name], false); catch e, end
        try delete_block_lines([sys, '/', targetname], false); catch e, end
        try delete_block_lines([sys, '/', ctr_name], false); catch e, end
        try delete_block_lines([sys, '/', delay_name1], false); catch e, end
        try delete_block([sys, '/', fromdbg_name]); catch e, end
        try delete_block([sys, '/', fromeof_name]); catch e, end
        try delete_block([sys, '/', fromsrc_name]); catch e, end
        try delete_block([sys, '/', delay_name1]); catch e, end
        try delete_block([sys, '/', and_name]); catch e, end
        try delete_block([sys, '/', ed_name]); catch e, end
        try delete_block([sys, '/', targetname]); catch e, end
        try delete_block([sys, '/', ctr_name]); catch e, end
    end
end

SPACING = 80;

% tx counter
starty = 850;
draw_rxcounter(cursys, starty, 'txctr', 'gtx_eof', 'gtx_valid');

% tx error counter
starty = starty + SPACING;
draw_errorcounter(cursys, starty, 'txerrctr', get_param(cursys, 'txerrctr_len'), 'gtx_eof', 'gtx_valid');

% tx overflow counter
starty = starty + SPACING;
draw_counter(cursys, starty, 'txofctr', 'gtx_overflow');

% tx full counter
starty = starty + SPACING;
draw_counter(cursys, starty, 'txfullctr', 'gtx_afull');

% tx valid counter
starty = starty + SPACING;
draw_counter(cursys, starty, 'txvldctr', 'gtx_valid')

% rx counter
starty = starty + SPACING;
draw_rxcounter(cursys, starty, 'rxctr', 'grx_eof', 'grx_valid')

% rx error counter
starty = starty + SPACING;
draw_errorcounter(cursys, starty, 'rxerrctr', get_param(cursys, 'rxerrctr_len'), 'grx_eof', 'grx_valid');

% rx overflow counter
starty = starty + SPACING;
draw_counter(cursys, starty, 'rxofctr', 'grx_overrun');

% rx bad frame counter
starty = starty + SPACING;
draw_counter(cursys, starty, 'rxbadctr', 'grx_badframe');

% rx valid counter
starty = starty + SPACING;
draw_counter(cursys, starty, 'rxvldctr', 'grx_valid');

% rx eof counter
starty = starty + SPACING;
draw_counter(cursys, starty, 'rxeofctr', 'grx_eof');

% rx snapshot
snaplen = get_param(cursys, 'rxsnaplen');
snapname = 'rxs';
if strcmp(snaplen, '0 - no snap') == 0
    ypos = 981;
    
    reuse_block(cursys, 'rxs_fr0',  'built-in/from', 'GotoTag', 'grx_led_up', 'Position',       [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_fr1',  'built-in/from', 'GotoTag', 'grx_led_rx', 'Position',       [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_fr2',  'built-in/from', 'GotoTag', 'grx_data', 'Position',         [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_fr3',  'built-in/from', 'GotoTag', 'grx_valid', 'Position',        [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_fr4',  'built-in/from', 'GotoTag', 'grx_src_ip', 'Position',       [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_fr5',  'built-in/from', 'GotoTag', 'grx_eof', 'Position',          [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_fr6',  'built-in/from', 'GotoTag', 'grx_badframe', 'Position',     [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_fr7',  'built-in/from', 'GotoTag', 'grx_overrun', 'Position',      [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_frwe',  'built-in/from', 'GotoTag', 'grx_valid', 'Position',       [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_frtrig1',  'built-in/from', 'GotoTag', 'grx_valid', 'Position',    [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'rxs_frtrig2', 'built-in/from', 'GotoTag', 'grx_eof', 'Position',       [900 ypos 1000 ypos+12]);
    reuse_block(cursys, snapname, 'casper_library_scopes/bitfield snapshot', ...
        'Position', [1155         981        1260        1234], ...
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
        'snap_delay', '5', ...
        'extra_names', '[notused]', ...
        'extra_widths', '[32]', ...
        'extra_bps', '[0]', ...
        'extra_types', '[0]');
    reuse_block(cursys, 'rxsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
        'Position', [1070        1194        1120        1241]);
    try add_line(cursys, 'rxs_fr0/1',	[snapname, '/1']); catch e, end
    try add_line(cursys, 'rxs_fr1/1',   [snapname, '/2']); catch e, end
    try add_line(cursys, 'rxs_fr2/1',   [snapname, '/3']); catch e, end
    try add_line(cursys, 'rxs_fr3/1',   [snapname, '/4']); catch e, end
    try add_line(cursys, 'rxs_fr4/1',   [snapname, '/5']); catch e, end
    try add_line(cursys, 'rxs_fr5/1',   [snapname, '/6']); catch e, end
    try add_line(cursys, 'rxs_fr6/1',   [snapname, '/7']); catch e, end
    try add_line(cursys, 'rxs_fr7/1',   [snapname, '/8']); catch e, end
    try add_line(cursys, 'rxs_frwe/1',  [snapname, '/9']); catch e, end
    try add_line(cursys, 'rxs_frtrig1/1', 'rxsnap_and/1'); catch e, end
    try add_line(cursys, 'rxs_frtrig2/1', 'rxsnap_and/2'); catch e, end
    try add_line(cursys, 'rxsnap_and/1',[snapname, '/10']); catch e, end
else
    try delete_block_lines([cursys, '/', snapname], false); catch e, end
    try delete_block_lines([cursys, '/rxsnap_and'], false); catch e, end
    try delete_block([cursys, '/', snapname]); catch e, end
    try delete_block([cursys, '/rxsnap_and']); catch e, end
end
% tx snapshot
snaplen = get_param(cursys, 'txsnaplen');
snapname = 'txs';
if strcmp(snaplen, '0 - no snap') == 0
    ypos = 1302;
    reuse_block(cursys, 'txs_fr0',  'built-in/from', 'GotoTag', 'grx_led_up', 'Position',      [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_fr1',  'built-in/from', 'GotoTag', 'grx_led_tx', 'Position',      [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_fr2',  'built-in/from', 'GotoTag', 'gtx_afull', 'Position',       [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_fr3',  'built-in/from', 'GotoTag', 'gtx_overflow', 'Position',    [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_fr4',  'built-in/from', 'GotoTag', 'gtx_valid', 'Position',       [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_fr5',  'built-in/from', 'GotoTag', 'gtx_eof', 'Position',         [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_fr6',  'built-in/from', 'GotoTag', 'gtx_data', 'Position',        [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_fr7',  'built-in/from', 'GotoTag', 'gtx_dest_ip', 'Position',     [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_frwe',  'built-in/from', 'GotoTag', 'gtx_valid', 'Position',      [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_frtrig1',  'built-in/from', 'GotoTag', 'gtx_valid', 'Position',   [900 ypos 1000 ypos+12]); ypos = ypos + 15;
    reuse_block(cursys, 'txs_frtrig2', 'built-in/from', 'GotoTag', 'gtx_eof', 'Position',      [900 ypos 1000 ypos+12]);
    reuse_block(cursys, snapname, 'casper_library_scopes/bitfield snapshot', ...
        'Position', [1155        1302        1260        1528], ...
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
        'snap_delay', '5', ...
        'extra_names', '[notused]', ...
        'extra_widths', '[32]', ...
        'extra_bps', '[0]', ...
        'extra_types', '[0]');
    reuse_block(cursys, 'txsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', 'inputs', '2', ...
        'Position', [1060        1479        1110        1526]);
    try add_line(cursys, 'txs_fr0/1',	[snapname, '/1']); catch e, end
    try add_line(cursys, 'txs_fr1/1',   [snapname, '/2']); catch e, end
    try add_line(cursys, 'txs_fr2/1',   [snapname, '/3']); catch e, end
    try add_line(cursys, 'txs_fr3/1',   [snapname, '/4']); catch e, end
    try add_line(cursys, 'txs_fr4/1',   [snapname, '/5']); catch e, end
    try add_line(cursys, 'txs_fr5/1',   [snapname, '/6']); catch e, end
    try add_line(cursys, 'txs_fr6/1',   [snapname, '/7']); catch e, end
    try add_line(cursys, 'txs_fr7/1',   [snapname, '/8']); catch e, end
    try add_line(cursys, 'txs_frwe/1',  [snapname, '/9']); catch e, end
    try add_line(cursys, 'txs_frtrig1/1', 'txsnap_and/1'); catch e, end
    try add_line(cursys, 'txs_frtrig2/1', 'txsnap_and/2'); catch e, end
    try add_line(cursys, 'txsnap_and/1',[snapname, '/10']); catch e, end
else
    try delete_block_lines([cursys, '/', snapname], false); catch e, end
    try delete_block_lines([cursys, '/txsnap_and'], false); catch e, end
    try delete_block([cursys, '/', snapname]); catch e, end
    try delete_block([cursys, '/txsnap_and']); catch e, end
end

% remove unconnected blocks
clean_blocks(cursys);

end
% end
