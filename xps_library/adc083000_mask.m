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
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lib_block_name = 'adc083000';
fprintf('Running mask script for %s\n', lib_block_name);
load_system('xbsBasic_r4');
cur_block_name = gcb;
disp(cur_block_name)
demux_adc0 = strcmp( get_param(cur_block_name, 'demux_adc0'), 'on');
use_adc0 = strcmp( get_param(cur_block_name, 'use_adc0'), 'on');
use_adc1 = strcmp( get_param(cur_block_name, 'use_adc1'), 'on');
clock_sync = strcmp( get_param(cur_block_name, 'clock_sync'), 'on');
verbose = strcmp( get_param(cur_block_name, 'verbose'), 'on');
sample_bit_width = str2num( get_param(cur_block_name, 'bit_width') );

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
    portnames = [portnames, 'adc0_s0', 'adc1_s0', 'adc0_s1', 'adc1_s1', 'adc0_s2', 'adc1_s2', 'adc0_s3', 'adc1_s3', ...
        'adc0_s4', 'adc1_s4', 'adc0_s5', 'adc1_s5', 'adc0_s6', 'adc1_s6', 'adc0_s7', 'adc1_s7', ...
        'adc0_s8', 'adc1_s8', 'adc0_s9', 'adc1_s9', 'adc0_s10', 'adc1_s10', 'adc0_s11', 'adc1_s11', ...
        'adc0_s12', 'adc1_s12', 'adc0_s13', 'adc1_s13', 'adc0_s14', 'adc1_s14', 'adc0_s15', 'adc1_s15', ...
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid', ...
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid' ];
    portwidths = [sample_bit_width*ones(1,8), ...
        sample_bit_width*ones(1,8), ...
        sample_bit_width*ones(1,8), ...
        sample_bit_width*ones(1,8), ...
        8, 8, 2, 8, 8, 2];
elseif clock_sync
    portnames = [portnames, 'adc0_s0', 'adc1_s0', 'adc0_s1', 'adc1_s1', 'adc0_s2', 'adc1_s2', 'adc0_s3', 'adc1_s3', ...
        'adc0_s4', 'adc1_s4', 'adc0_s5', 'adc1_s5', 'adc0_s6', 'adc1_s6', 'adc0_s7', 'adc1_s7', ...
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid', ...
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid' ];
    portwidths = [sample_bit_width*ones(1,8), ...
        sample_bit_width*ones(1,8), ...
        4, 4, 1, 4, 4, 1];    
end

if (use_adc0 && demux_adc0 && ~clock_sync)
    portnames = [portnames, 'adc0_s0','adc0_s1', 'adc0_s2', 'adc0_s3', 'adc0_s4', 'adc0_s5', 'adc0_s6', 'adc0_s7', ...
        'adc0_s8','adc0_s9', 'adc0_s10', 'adc0_s11', 'adc0_s12', 'adc0_s13', 'adc0_s14', 'adc0_s15', ...
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid'];
    portwidths = [sample_bit_width*ones(1,8), ...
        sample_bit_width*ones(1,8), ...
        8, 8, 2];
elseif (use_adc0 && ~clock_sync)
    portnames = [portnames, 'adc0_s0', 'adc0_s1', 'adc0_s2', 'adc0_s3', 'adc0_s4', 'adc0_s5', 'adc0_s6', 'adc0_s7', ...      
        'adc0_sync', 'adc0_outofrange', 'adc0_data_valid'];
    portwidths = [sample_bit_width*ones(1,8), ...
        4, 4, 1];
end

if (use_adc1 && demux_adc0 && ~clock_sync)
    portnames = [portnames, 'adc1_s0', 'adc1_s1', 'adc1_s2', 'adc1_s3', 'adc1_s4', 'adc1_s5', 'adc1_s6', 'adc1_s7', ...
        'adc1_s8', 'adc1_s9', 'adc1_s10', 'adc1_s11', 'adc1_s12', 'adc1_s13', 'adc1_s14', 'adc1_s15', ...
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid'];
    portwidths = [portwidths, sample_bit_width*ones(1,8), ...
        sample_bit_width*ones(1,8), ...
        8, 8, 2];
elseif (use_adc1 && ~clock_sync)
    portnames = [portnames, 'adc1_s0','adc1_s1', 'adc1_s2', 'adc1_s3', 'adc1_s5', 'adc1_s4', 'adc1_s6', 'adc1_s7', ...      
        'adc1_sync', 'adc1_outofrange', 'adc1_data_valid'];
    portwidths = [portwidths, sample_bit_width*ones(1,8), ...
        4, 4, 1];
end

% Simulation Data drawing
if clock_sync, 
    num_demux_data_phases = 16 + 16*demux_adc0;
else
    num_demux_data_phases = 8 + 8*demux_adc0;
end
    
if clock_sync,
    reuse_block(cur_block_name, 'sim_adc_data_in', 'simulink/Sources/In1', ...
        'Position', [310   208   340   222])
    reuse_block(cur_block_name, 'adc_sim', 'xps_library/ADCs/adc_sim', ...   % if the location of 'adc_sim' changes...
        'Position', [425   100   520   330], ...
        'nStreams', num2str(16 + 16*demux_adc0), ...
        'bit_width', num2str(sample_bit_width));
    reuse_line(cur_block_name, 'sim_adc_data_in/1', 'adc_sim/1');
else
    if use_adc0,
        reuse_block(cur_block_name, 'sim_adc0_data_in', 'simulink/Sources/In1', ...
            'Position', [310   208   340   222])
        reuse_block(cur_block_name, 'adc0_sim', 'xps_library/ADCs/adc_sim', ...   % if the location of 'adc_sim' changes...
            'Position', [425   100   520   330], ...
            'nStreams', num2str(8 + 8*demux_adc0), ...
            'bit_width', num2str(sample_bit_width));
        reuse_line(cur_block_name, 'sim_adc0_data_in/1', 'adc0_sim/1');
    end
    
    
    if use_adc1,
        reuse_block(cur_block_name, 'sim_adc1_data_in', 'simulink/Sources/In1', ...
            'Position', [305   683   335   697])
        reuse_block(cur_block_name, 'adc1_sim', 'xps_library/ADCs/adc_sim', ...   % if the location of 'adc_sim' changes...
            'Position', [420   575   515   805], ...
            'nStreams', num2str(8 + 8*demux_adc0), 'bit_width', num2str(sample_bit_width));
        reuse_line(cur_block_name, 'sim_adc1_data_in/1', 'adc1_sim/1');
    end
end
    
port_mod_factor = 8;
if clock_sync
    port_mod_factor = port_mod_factor * 2;
end
if demux_adc0
    port_mod_factor = port_mod_factor * 2;
end 

% draw the gateway in following blocks
ds_phase = 1;
ds_factor = 16;
sim_port = 0;
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
    elseif regexp( port, '(adc\d+)_(\w+)')
        toks = regexp( port, '(adc\d+)_(\w+)$', 'tokens');
        gateway_in_name = [gateway_in_name, toks{1}{1}, '_user_', toks{1}{2}];
    end
    
    reuse_block(cur_block_name, gateway_in_name, 'xbsBasic_r4/Gateway In', ...
        'n_bits', num2str( portwidths(k) ), ...
        'Position', gateway_in_pos, ...
        'bin_pt', num2str( 0 ), ...
        'arith_type', 'Unsigned');
    
    reuse_block(cur_block_name, port, 'simulink/Sinks/Out1', ...
        'Position', output_port_pos, 'Port', num2str(k));
    
    if regexp( port, '(adc\d+)_(s\d+)')
        toks = regexp( port, '(adc\d+)_(\w+)$', 'tokens');
        if clock_sync,
            adc_sim_block = 'adc_sim';
        else
            adc_sim_block = [toks{1}{1}, '_sim'];
            ds_factor = 8;
        end

        % add signal convert block
        reuse_block(cur_block_name, [gateway_in_name, '_conv'], 'xps_library/ADCs/conv', ...
            'Position', convert_pos, 'bit_width', num2str(sample_bit_width));

        reuse_line( cur_block_name, [adc_sim_block, '/', num2str( mod(sim_port,port_mod_factor)+1 )], [gateway_in_name, '/1'] );
        sim_port = sim_port +1;
        reuse_line( cur_block_name, [gateway_in_name,'/1'], [gateway_in_name, '_conv/1']);
        reuse_line( cur_block_name, [gateway_in_name, '_conv/1'], [port, '/1']);
    elseif regexp( port, '(adc\d+)_outofrange' ),
        toks = regexp( port, '(adc\d+)_(\w+)$', 'tokens');
        if clock_sync,
            adc_sim_block = 'adc_sim';
        else
            adc_sim_block = [toks{1}{1}, '_sim'];
            ds_factor = 8;
        end
        reuse_line(cur_block_name, [adc_sim_block, '/', num2str(num_demux_data_phases+1)], [gateway_in_name,'/1']);
        reuse_block(cur_block_name, [port, '_sim'], 'simulink/Sources/In1', ...
            'Position', [310, 53+50*k, 340, 67+50*k]);
        reuse_line( cur_block_name, [gateway_in_name,'/1'], [port, '/1']);
    else
        reuse_block(cur_block_name, [port, '_sim'], 'simulink/Sources/In1', ...
            'Position', [310, 53+50*k, 340, 67+50*k]);
        reuse_line( cur_block_name, [port, '_sim/1'], [gateway_in_name,'/1']);
        reuse_line( cur_block_name, [gateway_in_name,'/1'], [port, '/1']);
    end
    
end


clean_blocks(cur_block_name);
