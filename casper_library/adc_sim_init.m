function adc_sim_init(cur_block_name, varargin)

defaults = {};
if same_state(cur_block_name, 'defaults', defaults, varargin{:}), return, end

check_mask_type(cur_block_name, 'adc_sim');
munge_block(cur_block_name, varargin{:});

nStreams = get_var('nStreams', 'defaults', defaults, varargin{:});
delete_lines(cur_block_name);

% Draw Simulation input gain and bias to match 8-bit ADC
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

ds_phase = 1;
for k=1:nStreams,
    downsample_pos = [640 43+50*k 675 77+50*k];
    output_pos = [700   53+50*k   730   67+50*k];
    reuse_block(cur_block_name, ['sample', num2str(k-1), '_ds'], 'dspsigops/Downsample', ...
        'N', num2str(nStreams), ...
        'phase', num2str(mod(ds_phase,nStreams)), ...
        'Position', downsample_pos);
    add_line(cur_block_name, 'adc_bias/1', ['sample', num2str(k-1), '_ds/1']);
    ds_phase = ds_phase + 1;
    
    reuse_block(cur_block_name, ['s', num2str(k-1)], 'simulink/Sinks/Out1', ...
        'Position', output_pos);
    add_line(cur_block_name, ['sample', num2str(k-1), '_ds/1'], ['s', num2str(k-1),'/1']);
end

clean_blocks(cur_block_name);
   
end