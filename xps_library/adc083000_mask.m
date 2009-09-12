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

lib_block_name = 'adc083000';
fprintf('Running mask script for %s\n', lib_block_name);
cur_block_name = gcb;
disp(cur_block_name)
demux_adc0 = strcmp( get_param(cur_block_name, 'demux_adc0'), 'on');
use_adc0 = strcmp( get_param(cur_block_name, 'use_adc0'), 'on');
use_adc1 = strcmp( get_param(cur_block_name, 'use_adc1'), 'on');
clock_sync = strcmp( get_param(cur_block_name, 'clock_sync'), 'on');
verbose = strcmp( get_param(cur_block_name, 'verbose'), 'on');

if verbose,
    fprintf('Mask Script inputs:\n')
    fprintf('Using adc0..................%d\n', use_adc0)
    fprintf('Using adc1..................%d\n', use_adc1)
    fprintf('Demuxing ADC outputs.......%d\n', demux_adc0)
    fprintf('Synchronizing ZDOK clocks...%d\n', clock_sync)
end

% Error checking for valid parameterization
if (demux_adc0 && ~use_adc0) || (demux_adc0 && ~use_adc1)
    errordlg('You must specify that you are using an ADC before trying to demux the output');
end
if (clock_sync && ~(use_adc0 && use_adc1))
    errordlg('Clock synchronization only works if both ADCs are selected');
end
if ~(use_adc0 || use_adc1)
    errordlg('You must use at least one ADC...')
end

portnames = {};
portwidths = [];

%clean_blocks(cur_block_name);
delete_lines(cur_block_name);

if clock_sync && demux_adc0
    disp('stuff')
    portnames = [portnames, 'adc0_i0', 'adc1_i0', 'adc0_q0', 'adc1_q0', 'adc0_i1', 'adc1_i1', 'adc0_q1', 'adc1_q1', ...
        'adc0_i2', 'adc1_i2', 'adc0_q2', 'adc1_q2', 'adc0_i3', 'adc1_i3', 'adc0_q3', 'adc1_q3', ...
        'adc0_i4', 'adc1_i4', 'adc0_q4', 'adc1_q4', 'adc0_i5', 'adc1_i5', 'adc0_q5', 'adc1_q5', ...
        'adc0_i6', 'adc1_i6', 'adc0_q6', 'adc0_q6', 'adc0_i7', 'adc1_i7', 'adc0_q7', 'adc1_q7', ...
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid', ...
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid' ];
    portwidths = [8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 2, 8, 8, 2];
elseif clock_sync
    portnames = [portnames, 'adc0_i0', 'adc1_i0', 'adc0_q0', 'adc1_q0', 'adc0_i1', 'adc1_i1', 'adc0_q1', 'adc1_q1', ...
        'adc0_i2', 'adc1_i2', 'adc0_q2', 'adc1_q2', 'adc0_i3', 'adc1_i3', 'adc0_q3', 'adc1_q3', ...
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid', ...
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid' ];
    portwidths = [8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 8, 8, 8, 8, 8, 8, ...
        4, 4, 1, 4, 4, 1];    
end

if (use_adc0 && demux_adc0 && ~clock_sync)
    portnames = [portnames, 'adc0_i0','adc0_q0', 'adc0_i1', 'adc0_q1', 'adc0_i2', 'adc0_q2', 'adc0_i3', 'adc0_q3', ...
        'adc0_i4','adc0_q4', 'adc0_i5', 'adc0_q5', 'adc0_i6', 'adc0_q6', 'adc0_i7', 'adc0_q7', ...
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid'];
    portwidths = [8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 2];
elseif (use_adc0 && ~clock_sync)
    portnames = [portnames, 'adc0_i0', 'adc0_q0', 'adc0_i1', 'adc0_q1', 'adc0_i2', 'adc0_q2', 'adc0_i3', 'adc0_q3', ...      
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid'];
    portwidths = [8, 8, 8, 8, 8, 8, 8, 8, ...
        4, 4, 1];
end

if (use_adc1 && demux_adc0 && ~clock_sync)
    portnames = [portnames, 'adc1_i0', 'adc1_q0', 'adc1_i1', 'adc1_q1', 'adc1_i2', 'adc1_q2', 'adc1_i3', 'adc1_q3', ...
        'adc1_i4', 'adc1_q4', 'adc1_i5', 'adc1_q5', 'adc1_i6', 'adc1_q6', 'adc1_i7', 'adc1_q7', ...
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid'];
    portwidths = [portwidths, 8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 8, 8, 8, 8, 8, 8, ...
        8, 8, 2];
elseif (use_adc1 && ~clock_sync)
    portnames = [portnames, 'adc1_i0','adc1_q0', 'adc1_i1', 'adc1_q1', 'adc1_q2', 'adc1_i2', 'adc1_i3', 'adc1_q3', ...      
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid'];
    portwidths = [portwidths, 8, 8, 8, 8, 8, 8, 8, 8, ...
        4, 4, 1];
end

% Simulation Data drawing
if (clock_sync), % if interleaving 2 ADCs, draw only 1 source
    reuse_block(cur_block_name, 'sim_adc_data_in', 'simulink/Sources/In1', ...
        'Position', [310   103   340   117])
    reuse_block(cur_block_name, 'adc_gain', 'simulink/Math Operations/Gain', ...
        'Gain', num2str(127.5), ...
        'Position', [390   100   420   120]);
    reuse_block(cur_block_name, 'adc_bias', 'simulink/Math Operations/Bias', ...
        'Bias', num2str(127.5), ...
        'SaturateOnIntegerOverflow', 'on', ...
        'Position', [445   100   475   120]);   
    add_line(cur_block_name, 'sim_adc_data_in/1', 'adc_gain/1');
    add_line(cur_block_name, 'adc_gain/1', 'adc_bias/1');    
else
    reuse_block(cur_block_name, 'sim_adc0_data_in', 'simulink/Sources/In1', ...
        'Position', [310   103   340   117]);
    reuse_block(cur_block_name, 'adc0_gain', 'simulink/Math Operations/Gain', ...
        'Gain', num2str(127.5), ...
        'Position', [390   100   420   120]);
    reuse_block(cur_block_name, 'adc0_bias', 'simulink/Math Operations/Bias', ...
        'Bias', num2str(127.5), ...
        'SaturateOnIntegerOverflow', 'on', ...
        'Position', [445   100   475   120]);   
    add_line(cur_block_name, 'sim_adc0_data_in/1', 'adc0_gain/1');
    add_line(cur_block_name, 'adc0_gain/1', 'adc0_bias/1');
    
    reuse_block(cur_block_name, 'sim_adc1_data_in', 'simulink/Sources/In1', ...
        'Position', [310   653   340   667]);
    reuse_block(cur_block_name, 'adc1_gain', 'simulink/Math Operations/Gain', ...
        'Gain', num2str(127.5), ...
        'Position', [390   650   420   670]);
    reuse_block(cur_block_name, 'adc1_bias', 'simulink/Math Operations/Bias', ...
        'Bias', num2str(127.5), ...
        'SaturateOnIntegerOverflow', 'on', ...
        'Position', [445   650   475   670]);    
    add_line(cur_block_name, 'sim_adc1_data_in/1', 'adc1_gain/1');
    add_line(cur_block_name, 'adc1_gain/1', 'adc1_bias/1');        
end
    


% draw the gateway in following blocks
ds_phase = 1;
ds_factor = 16;
for k=1:length(portnames),
    port = char(portnames(k));
    gateway_in_name = [clear_name([cur_block_name,'_']), '_', ];
    
    gateway_in_pos = [840  48+50*k  895  72+50*k];
    convert_pos = [1050  45+50*k  1130  75+50*k];
    output_port_pos = [1220 53+50*k 1250 67+50*k];
    downsample_pos = [640 43+50*k 675 77+50*k];
    delay_pos = [725 47+50*k 755 73+50*k];

    if regexp( port, '(adc\d+)_([iq]\d+)')
        toks = regexp( port, '(adc\d+)_([iq]\d+)$', 'tokens');
        gateway_in_name = [gateway_in_name, toks{1}{1}, '_user_data', toks{1}{2}];
        bin_pt = 7;
    elseif regexp( port, '(adc\d+)_(\w+)')
        toks = regexp( port, '(adc\d+)_(\w+)$', 'tokens');
        gateway_in_name = [gateway_in_name, toks{1}{1}, '_user_', toks{1}{2}];
        bin_pt = 0;
    end
    
    reuse_block(cur_block_name, gateway_in_name, 'xbsBasic_r4/Gateway In', ...
        'n_bits', num2str( portwidths(k) ), ...
        'Position', gateway_in_pos, ...
        'bin_pt', num2str( bin_pt ));
    
    reuse_block(cur_block_name, port, 'simulink/Sinks/Out1', ...
        'Position', output_port_pos);
    
    if regexp( port, '(adc\d+)_([iq]\d+)')
        toks = regexp( port, '(adc\d+)_(\w+)$', 'tokens');
        if clock_sync,
            bias_block = 'adc_bias';
        else
            bias_block = [toks{1}{1}, '_bias'];
            ds_factor = 8;
        end

        % add downsample block
        reuse_block(cur_block_name, [port, '_ds'], 'dspsigops/Downsample', ...
            'N', num2str(ds_factor), ...
            'phase', num2str(mod(ds_phase,ds_factor)), ...
            'Position', downsample_pos);
        ds_phase = ds_phase + 1;

        % add sim signal input delay block
        reuse_block(cur_block_name, [port, '_delay'], 'simulink/Discrete/Integer Delay', ...
            'NumDelays', num2str(1), ...
            'Position', delay_pos);    
        
        % add signal convert block
        reuse_block(cur_block_name, [gateway_in_name, '_conv'], 'casper_library/Misc/conv', ...
            'Position', convert_pos);
        add_line( cur_block_name, [bias_block, '/1'], [port, '_ds/1']);
        add_line( cur_block_name, [port, '_ds/1'], [port, '_delay/1'] );
        add_line( cur_block_name, [port, '_delay/1'], [gateway_in_name, '/1'] );
        add_line( cur_block_name, [gateway_in_name,'/1'], [gateway_in_name, '_conv/1']);
        add_line( cur_block_name, [gateway_in_name, '_conv/1'], [port, '/1']);
    else
        reuse_block(cur_block_name, [port, '_sim'], 'simulink/Sources/In1', ...
            'Position', [310, 53+50*k, 340, 67+50*k]);
        add_line( cur_block_name, [port, '_sim/1'], [gateway_in_name,'/1']);
        add_line( cur_block_name, [gateway_in_name,'/1'], [port, '/1']);
    end
end

% draw simulation input

clean_blocks(cur_block_name);