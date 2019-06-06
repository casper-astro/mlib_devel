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

function forty_gbe_mask_draw_txsnap(cursys, pipe_no_pipe)

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

% tx snapshot
snaplen = get_param(cursys, 'txsnaplen');
if strcmp(snaplen, '0 - no snap') == 0
    reuse_block(cursys, 'txs0', ...
        'casper_library_scopes/bitfield_snapshot', ...
        'Position', [500 1300 600 1525], ...
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
    try set_param([cursys, '/txs0'], 'snap_ext_arm', 'off'); catch, end
    try set_param([cursys, '/txs0'], 'snap_ext_circ', 'off'); catch, end
    reuse_block(cursys, 'txs_exp_del',  ...
            'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
            'Position', [300 1600 320 1620]);
    reuse_block(cursys, 'txs_exp', ...
        'casper_library_flow_control/bus_expand', ...
        'mode', 'divisions of equal size', ...
        'outputNum', '2', 'outputWidth', '128', 'outputBinaryPt', '0', ...
        'outputArithmeticType', '0', 'show_format', 'off', ...
        'outputToWorkspace', 'off', 'outputToModelAsWell', 'off', ...
        'Position', [330 1600 380 1675]);
    reuse_block(cursys, 'txs1', ...
        'casper_library_scopes/bitfield_snapshot', ...
        'Position', [500 1582 600 1808], ...
        'io_names', '[data_msw]', 'io_widths', '[128]', ...
        'io_bps', '[0]', 'io_types', '[0]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    try set_param([cursys, '/txs1'], 'snap_ext_arm', 'on'); catch, end
    try set_param([cursys, '/txs1'], 'snap_ext_circ', 'off'); catch, end
    reuse_block(cursys, 'txs2', ...
        'casper_library_scopes/bitfield_snapshot', ...
        'Position', [500 1867 600 2093], ...
        'io_names', '[data_lsw]', 'io_widths', '[128]', ...
        'io_bps', '[0]', 'io_types', '[0]', 'snap_storage', 'bram', ...
        'snap_dram_dimm', '2', 'snap_dram_clock', '250', ...
        'snap_nsamples', num2str(log2(str2double(snaplen))), ...
        'snap_data_width', '128', 'snap_offset', 'off', ...
        'snap_circap', 'off', 'snap_value', 'off', ...
        'snap_use_dsp48', 'on', 'snap_delay', '2', ...
        'extra_names', '[notused]', 'extra_widths', '[32]', ...
        'extra_bps', '[0]', 'extra_types', '[0]');
    try set_param([cursys, '/txs2'], 'snap_ext_arm', 'on'); catch, end
    try set_param([cursys, '/txs2'], 'snap_ext_circ', 'off'); catch, end
    ypos = 1300;
    for ctr = 1 : 8
        delay_name = ['txs_', num2str(ctr),'_del'];
        reuse_block(cursys, delay_name,  ...
            'xbsIndex_r4/Delay', 'reg_retiming', 'on', 'latency', '1', ...
            'Position', [400 ypos 420 ypos+20]);
        ypos = ypos + 20;
        add_line_s(cursys, [delay_name, '/1'], ['txs0/', num2str(ctr)]);
    end
    reuse_block(cursys, 'txsnap_and', 'xbsIndex_r4/Logical', ...
        'arith_type', 'Unsigned', 'logical_function', 'AND', ...
        'inputs', '2', 'latency', '1', ...
        'Position', [330 1479 380 1526]);
    
    add_line_s(cursys, 'tx_data/1', 'txs_exp_del/1');
    add_line_s(cursys, 'txs_exp_del/1', 'txs_exp/1');
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_led_up']), '/1'],           'txs_1_del/1');
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_led_tx']), '/1'],           'txs_2_del/1');
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_tx_afull']), '/1'],         'txs_3_del/1');
    add_line_s(cursys, [clear_name([pipe_no_pipe, '_tx_overflow']), '/1'],      'txs_4_del/1');
    add_line_s(cursys, 'tx_valid/1',                                            'txs_5_del/1');
    add_line_s(cursys, 'tx_end_of_frame/1',                                     'txs_6_del/1');
    add_line_s(cursys, 'tx_dest_ip/1',                                          'txs_7_del/1');
    add_line_s(cursys, 'tx_valid/1',                                            'txs_8_del/1');
    add_line_s(cursys, 'tx_valid/1',         'txsnap_and/1');
    add_line_s(cursys, 'tx_end_of_frame/1',  'txsnap_and/2');
    add_line_s(cursys, 'txsnap_and/1',                                          'txs0/9');
        
    add_line_s(cursys, 'txs_exp/1',             'txs1/1');
    add_line_s(cursys, 'txs_8_del/1',           'txs1/2');
    add_line_s(cursys, 'txsnap_and/1',          'txs1/3');
    add_line_s(cursys, 'txs0/1',                'txs1/4');
    
    add_line_s(cursys, 'txs_exp/2',             'txs2/1');
    add_line_s(cursys, 'txs_8_del/1',           'txs2/2');
    add_line_s(cursys, 'txsnap_and/1',          'txs2/3');
    add_line_s(cursys, 'txs0/1',                'txs2/4');
    
else
    for ctr = 1 : 9
        delete_block_lines_s([cursys, '/txs_', num2str(ctr), '_del']);
    end
    delete_block_lines_s([cursys, '/txs_exp_del']);
    delete_block_lines_s([cursys, '/txs0']);
    delete_block_lines_s([cursys, '/txs1']);
    delete_block_lines_s([cursys, '/txs2']);
    delete_block_lines_s([cursys, '/txs_exp']);
    delete_block_lines_s([cursys, '/txsnap_and']);
    delete_block_s([cursys, '/txs0']);
    delete_block_s([cursys, '/txs1']);
    delete_block_s([cursys, '/txs2']);
    delete_block_s([cursys, '/txs_exp']);
    delete_block_s([cursys, '/txsnap_and']);
end

end
% end
