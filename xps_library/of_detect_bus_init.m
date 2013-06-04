function of_detect_bus_init(cur_block_name, varargin)

defaults = {};
if same_state(cur_block_name, 'defaults', defaults, varargin{:}), return, end

check_mask_type(cur_block_name, 'of_detect_bus');
munge_block(cur_block_name, varargin{:});

nStreams = get_var('nStreams', 'defaults', defaults, varargin{:});
bit_width = get_var('bit_width', 'defaults', defaults, varargin{:});
delete_lines(cur_block_name);

num_ddr_streams = nStreams/2;
adder_inputs = [];
for k=1:num_ddr_streams,
    adder_inputs = [adder_inputs, '+'];
end
set_param([cur_block_name, '/Add'], 'Inputs', adder_inputs);
for k=0:num_ddr_streams-1,
    of_pos = [105, 25+85*k, 145, 80+85*k];
    in0_pos = [45, 33+85*k, 75, 47+85*k];
    in1_pos = [45, 58+85*k, 75, 72+85*k];
    
    reuse_block(cur_block_name, ['of', num2str(k)], 'xps_library/ADCs/of1', ...
        'Position', of_pos);
    reuse_block(cur_block_name, ['s', num2str(k)], 'built-in/Inport', ...
        'Position', in0_pos, 'Port', num2str(k+1));
    reuse_block(cur_block_name, ['s', num2str(k+num_ddr_streams)], 'built-in/Inport', ...
        'Position', in1_pos, 'Port', num2str(k+num_ddr_streams+1));
    add_line(cur_block_name, ['s', num2str(k), '/1'], ['of', num2str(k), '/1']);
    add_line(cur_block_name, ['s', num2str(k+num_ddr_streams), '/1'], ['of', num2str(k), '/2']);
    
    % Set the bus bit position
    
    % Connect to the adder block
    add_line(cur_block_name, ['of', num2str(k), '/1'], ['Add/', num2str(k+1)]);
    
%     reuse_block(cur_block_name, ['sample', num2str(k-1), '_ds'], 'dspsigops/Downsample', ...
%         'N', num2str(nStreams), ...
%         'phase', num2str(mod(ds_phase,nStreams)), ...
%         'Position', downsample_pos);
%     add_line(cur_block_name, 'adc_bias/1', ['sample', num2str(k-1), '_ds/1']);
%     ds_phase = ds_phase + 1;
%     
%     reuse_block(cur_block_name, ['s', num2str(k-1)], 'built-in/Outport', ...
%         'Position', output_pos);
%     add_line(cur_block_name, ['sample', num2str(k-1), '_ds/1'], ['s', num2str(k-1),'/1']);
end

add_line(cur_block_name, 'Add/1', 'overflow/1');

clean_blocks(cur_block_name);
save_state(cur_block_name, 'defaults', defaults, varargin{:});
   
end
