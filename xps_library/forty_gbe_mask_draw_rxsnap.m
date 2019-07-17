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

function forty_gbe_mask_draw_rxsnap(cursys, pipe_no_pipe)

    function add_line_s(sys, srcprt, dstprt)
        try
            add_line(sys, srcprt, dstprt);
        catch
            % pass
        end
    end

    function delete_block_s(blockname)
        try
            delete_block(blockname);
        catch
            % pass
        end
    end

    function delete_block_lines_s(blockname)
        try
            delete_block_lines(blockname);
        catch
            % pass
        end
    end

valid_source = 'rx_dv_or';

% rx snapshot
snaplen = get_param(cursys, 'rxsnaplen');
try rx_src_ip = get_param(cursys, 'rxsrcip'); catch, rx_src_ip='on'; end
try rx_dst_ip = get_param(cursys, 'rxdstip'); catch, rx_dst_ip='off'; end
if (strcmp(rx_src_ip, 'on') == 1) && (strcmp(rx_dst_ip, 'on') == 1)
    rx_snap_case = 3;
elseif (strcmp(rx_src_ip, 'on') == 1)
    rx_snap_case = 2;
elseif (strcmp(rx_dst_ip, 'on') == 1)
    rx_snap_case = 1;
else
    rx_snap_case = 0;
end
if strcmp(snaplen, '0 - no snap') == 0
    if rx_snap_case == 2
        ionames = '[led_up led_rx valid_in src_ip eof_in bad_frame overrun]';
        iowidths = '[1 1 1 32 1 1 1]';
        iobps = '[0 0 0 0 0 0 0]';
        iotypes = '[2 2 2 0 2 2 2]';
        snap_data_width = '64';
        num_delays = 8;
    elseif rx_snap_case == 1
        ionames = '[led_up led_rx valid_in dest_ip eof_in bad_frame overrun]';
        iowidths = '[1 1 1 32 1 1 1]';
        iobps = '[0 0 0 0 0 0 0]';
        iotypes = '[2 2 2 0 2 2 2]';
        snap_data_width = '64';
        num_delays = 8;
    else
        ionames = '[led_up led_rx valid_in eof_in bad_frame overrun]';
        iowidths = '1';
        iobps = '0';
        iotypes = '2';
        snap_data_width = '8';
        num_delays = 7;
    end
    reuse_block(cursys, 'rxs0', 'casper_library_scopes/bitfield_snapshot', ...
        'Position', [1620        1304        1725        1526], ...
        'io_names', ionames, ...
        'io_widths', iowidths, 'io_bps', iobps, ...
        'io_types', iotypes, 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', snap_data_width, 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    try set_param([cursys, '/rxs0'], 'snap_ext_arm', 'off'); catch, end
    try set_param([cursys, '/rxs0'], 'snap_ext_circ', 'off'); catch, end
    reuse_block(cursys, 'rxs_exp_del',  ...
            'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
            'Position', [1480 1610 1500 1630]);
    reuse_block(cursys, 'rxs_exp', ...
        'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', ...
        'outputNum', '2', 'outputWidth', '128', 'outputBinaryPt', '0', ...
        'outputArithmeticType', '0', 'show_format', 'off', ...
        'outputToWorkspace', 'off', 'outputToModelAsWell', 'off', ...
        'Position', [1510        1617        1560        1693]);
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
    try set_param([cursys, '/rxs1'], 'snap_ext_arm', 'on'); catch, end
    try set_param([cursys, '/rxs1'], 'snap_ext_circ', 'off'); catch, end
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
    try set_param([cursys, '/rxs2'], 'snap_ext_arm', 'on'); catch, end
    try set_param([cursys, '/rxs2'], 'snap_ext_circ', 'off'); catch, end
    if rx_snap_case == 3
        reuse_block(cursys, 'rxs3', 'casper_library_scopes/bitfield_snapshot', ...
            'Position', [1620        2158        1725        2387], ...
            'io_names', '[src_ip dst_ip]', ...
            'io_widths', '32', 'io_bps', '0', ...
            'io_types', '0', 'snap_storage', 'bram', ...
            'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
            'snap_nsamples', num2str(log2(str2double(snaplen))), ...
            'snap_data_width', '64', 'snap_offset', 'off', ...
            'snap_circap', 'off', 'snap_value', 'off', ...
            'snap_use_dsp48', 'on', 'snap_delay', '2', ...
            'extra_names', '[notused]', 'extra_widths', '[32]', ...
            'extra_bps', '[0]', 'extra_types', '[0]');
        try set_param([cursys, '/rxs3'], 'snap_ext_arm', 'on'); catch, end
        try set_param([cursys, '/rxs3'], 'snap_ext_circ', 'off'); catch, end
    else
        delete_block_lines_s([cursys, 'rxs3']);
        delete_block_s([cursys, '/rxs3']);
    end
    ypos = 1310;
    delete_block_lines_s([cursys, 'rxs0']);
    for ctr = 1 : 8
        delete_block_lines_s([cursys, '/rxs_', num2str(ctr), '_del']);
    end
    for ctr = 1 : num_delays
        delay_name = ['rxs_', num2str(ctr),'_del'];
        reuse_block(cursys, delay_name,  ...
            'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
            'Position', [1570 ypos 1590 ypos+20]);
        ypos = ypos + 20;
        add_line_s(cursys, [delay_name, '/1'], ['rxs0/', num2str(ctr)]);
    end
    if rx_snap_case == 3
        reuse_block(cursys, 'rxs3_del0',  ...
            'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
            'Position', [1570        2190        1590        2210]);
        reuse_block(cursys, 'rxs3_del1',  ...
            'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
            'Position', [1570        2235        1590        2255]);
        add_line_s(cursys, 'rxs3_del0/1', 'rxs3/1');
        add_line_s(cursys, 'rxs3_del1/1', 'rxs3/2');
    else
        delete_block_lines_s([cursys, 'rxs3_del0']);
        delete_block_lines_s([cursys, 'rxs3_del1']);
        delete_block_s([cursys, '/rxs3_del0']);
        delete_block_s([cursys, '/rxs3_del1']);
    end
    reuse_block(cursys, 'rxsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', ...
        'inputs', '2', 'latency', '1', 'Position', [1500 1500 1550 1550]);
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_data']), '/1'], ...
            'rxs_exp_del/1');
    add_line_s(cursys, 'rxs_exp_del/1', 'rxs_exp/1');
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_led_up']), '/1'],           'rxs_1_del/1');
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_led_rx']), '/1'],           'rxs_2_del/1');
    add_line_s(cursys, [valid_source, '/1'],                                    'rxs_3_del/1');
    add_line_s(cursys, [valid_source, '/1'],                                    'rxsnap_and/1');
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_end_of_frame']), '/1'],  'rxsnap_and/2');
    if (rx_snap_case == 2) || (rx_snap_case == 1)
        if rx_snap_case == 2
            add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_source_ip']), '/1'],     'rxs_4_del/1');
        else
            add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_dest_ip']), '/1'],     'rxs_4_del/1');
        end
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_end_of_frame']), '/1'],  'rxs_5_del/1');
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_bad_frame']), '/1'],     'rxs_6_del/1');
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_overrun']), '/1'],       'rxs_7_del/1');
        add_line_s(cursys, [valid_source, '/1'],                                    'rxs_8_del/1');
        add_line_s(cursys, 'rxsnap_and/1', 'rxs0/9');
    else
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_end_of_frame']), '/1'],  'rxs_4_del/1');
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_bad_frame']), '/1'],     'rxs_5_del/1');
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_overrun']), '/1'],       'rxs_6_del/1');
        add_line_s(cursys, [valid_source, '/1'],                                    'rxs_7_del/1');
        add_line_s(cursys, 'rxsnap_and/1', 'rxs0/8');
    end
    
    if (rx_snap_case == 2) || (rx_snap_case == 1)
        we_del = 'rxs_8_del/1';
    else
        we_del = 'rxs_7_del/1';
    end
    
    add_line_s(cursys, 'rxs_exp/1',     'rxs1/1');
    add_line_s(cursys, we_del,          'rxs1/2');
    add_line_s(cursys, 'rxsnap_and/1',  'rxs1/3');
    add_line_s(cursys, 'rxs0/1',        'rxs1/4');
    
    add_line_s(cursys, 'rxs_exp/2',     'rxs2/1');
    add_line_s(cursys, we_del,          'rxs2/2');
    add_line_s(cursys, 'rxsnap_and/1',  'rxs2/3');
    add_line_s(cursys, 'rxs0/1',        'rxs2/4');
    
    if rx_snap_case == 3
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_source_ip']), '/1'], 'rxs3_del0/1');
        add_line_s(cursys, [clear_name([pipe_no_pipe, '_rx_dest_ip']), '/1'], 'rxs3_del1/1');
        add_line_s(cursys, we_del,          'rxs3/3');
        add_line_s(cursys, 'rxsnap_and/1',  'rxs3/4');
        add_line_s(cursys, 'rxs0/1',        'rxs3/5');
    end
else
    for ctr = 1 : 8
        delete_block_lines_s([cursys, '/rxs_', num2str(ctr), '_del']);
    end
    delete_block_lines_s([cursys, '/rxs3_del0']);
    delete_block_lines_s([cursys, '/rxs3_del1']);
    delete_block_lines_s([cursys, '/rxs_exp_del']);
    delete_block_lines_s([cursys, '/rxs0']);
    delete_block_lines_s([cursys, '/rxs1']);
    delete_block_lines_s([cursys, '/rxs2']);
    delete_block_lines_s([cursys, '/rxs3']);
    delete_block_lines_s([cursys, '/rxs_exp']);
    delete_block_lines_s([cursys, '/rxsnap_and']);
    delete_block_s([cursys, '/rxs0']);
    delete_block_s([cursys, '/rxs1']);
    delete_block_s([cursys, '/rxs2']);
    delete_block_s([cursys, '/rxs3']);
    delete_block_s([cursys, '/rxs_exp']);
    delete_block_s([cursys, '/rxsnap_and']);
end

end
% end
