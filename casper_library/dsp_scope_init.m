function adc_sim_init(cur_block_name, varargin)

defaults = {};
if same_state(cur_block_name, 'defaults', defaults, varargin{:}), return, end

check_mask_type(cur_block_name, 'dsp_scope');
munge_block(cur_block_name, varargin{:});

n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
slice_width = get_var('slice_width', 'defaults', defaults, varargin{:});
bin_pt = get_var('bin_pt', 'defaults', defaults, varargin{:});
arith_type = get_var('arith_type', 'defaults', defaults, varargin{:});
delete_lines(cur_block_name);

set_param([cur_block_name, '/sel'], 'NumBits', num2str(ceil( log2(n_inputs))) );
set_param([cur_block_name, '/sel'], 'tsamp', num2str(1/n_inputs) );
set_param([cur_block_name, '/switch'], 'Inputs', num2str(n_inputs));
set_param([cur_block_name, '/bus_expand'], 'outputNum', num2str(n_inputs));
set_param([cur_block_name, '/bus_expand'], 'outputWidth', num2str(slice_width));
set_param([cur_block_name, '/bus_expand'], 'outputBinaryPt', num2str(bin_pt));
set_param([cur_block_name, '/bus_expand'], 'outputArithmeticType', num2str(arith_type));
add_line(cur_block_name, 'in/1', 'bus_expand/1');
add_line(cur_block_name, 'switch/1', 'out/1');
add_line(cur_block_name, 'sel/1', 'switch/1');
for k=1:n_inputs,
    add_line(cur_block_name, ['bus_expand/', num2str(k)], ['switch/', num2str(k+1)]);
end
    
% clean_blocks(cur_block_name);
save_state(cur_block_name, 'defaults', defaults, varargin{:});
   
end
