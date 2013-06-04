function adc_sim_init(cur_block_name, varargin)

defaults = {};
if same_state(cur_block_name, 'defaults', defaults, varargin{:}), return, end

check_mask_type(cur_block_name, 'adc_sim');
munge_block(cur_block_name, varargin{:});

nStreams = get_var('nStreams', 'defaults', defaults, varargin{:});
bit_width = get_var('bit_width', 'defaults', defaults, varargin{:});
delete_lines(cur_block_name);

% Draw Simulation input gain and bias to match n-bit ADC
bias = 2^(bit_width-1);
reuse_block(cur_block_name, 'sim_adc_data_in', 'built-in/Inport', ...  
    'Position', [310   103   340   117])
reuse_block(cur_block_name, 'adc_gain', 'built-in/Gain', ...
    'Gain', num2str(bias), ...
    'Position', [390   100   420   120]);
reuse_block(cur_block_name, 'adc_bias', 'built-in/Bias', ...
    'Bias', num2str(bias), ...
    'SaturateOnIntegerOverflow', 'on', ...
    'Position', [445   100   475   120]);   
add_line(cur_block_name, 'sim_adc_data_in/1', 'adc_gain/1');
add_line(cur_block_name, 'adc_gain/1', 'adc_bias/1');    


% set parameters for overflow detector
reuse_block(cur_block_name, 'overflow_detector', 'xps_library/ADCs/of_detect_bus', ...
    'Position', [740, 507+60*(nStreams-8), 850, 698+60*(nStreams-8)], ...
    'nStreams', num2str(nStreams), ...
    'bit_width', num2str(bit_width));
add_line(cur_block_name, 'overflow_detector/1', 'of/1');
set_param([cur_block_name, '/of'], 'Port', num2str(nStreams+1));

ds_phase = 1;
for k=1:nStreams,
    downsample_pos = [640 43+50*k 675 77+50*k];
    output_pos = [735   53+50*k   765   67+50*k];
    reuse_block(cur_block_name, ['sample', num2str(k-1), '_ds'], 'dspsigops/Downsample', ...
        'N', num2str(nStreams), ...
        'phase', num2str(mod(ds_phase,nStreams)), ...
        'smode', 'Force single rate', ...
        'Position', downsample_pos);
    add_line(cur_block_name, 'adc_bias/1', ['sample', num2str(k-1), '_ds/1']);
    ds_phase = ds_phase + 1;
    
    reuse_block(cur_block_name, ['s', num2str(k-1)], 'built-in/Outport', ...
        'Position', output_pos);
    add_line(cur_block_name, ['sample', num2str(k-1), '_ds/1'], ['overflow_detector/', num2str(k)]);
    add_line(cur_block_name, ['sample', num2str(k-1), '_ds/1'], ['s', num2str(k-1),'/1']);
end




clean_blocks(cur_block_name);
save_state(cur_block_name, 'defaults', defaults, varargin{:});
   
end
