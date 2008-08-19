function npower_init(blk, varargin)

defaults = {};
disp('hi from npower')
check_mask_type(blk, 'npower');
%if same_state(blk, 'defaults', defaults, varargin{:}), return, end
munge_block(blk, varargin{:});
n_inputs = get_var('n_inputs', 'defaults', defaults, varargin{:});
in_width = get_var('in_width', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
mult_latency = get_var('mult_latency', 'defaults', defaults, varargin{:});

delete_lines(blk)

set_param([blk,'/sync_delay'], 'latency', num2str(add_latency+mult_latency))
add_line(blk, 'sync_in/1', 'sync_delay/1')
add_line(blk, 'sync_delay/1', 'sync_out/1')

for k = 1:n_inputs,
    reuse_block(blk, ['din', num2str(k)], 'built-in/inport', 'Position', [100 100+k*50 120 110+k*50], 'Port', num2str(k+1))
    reuse_block(blk, ['dout', num2str(k)], 'built-in/outport', 'Position', [400 100+k*50 420 110+k*50], 'Port', num2str(k+1))
    reuse_block(blk, ['power', num2str(k)], 'gavrt_library/power', ...
        'add_latency', num2str(add_latency), 'mult_latency', num2str(mult_latency)', ...
        'BitWidth', num2str(in_width), 'Position', [200 100+k*50 240 120+k*50])
    add_line(blk, ['din', num2str(k), '/1'], ['power', num2str(k), '/1'])
    add_line(blk, ['power', num2str(k), '/1'], ['dout', num2str(k), '/1'])
end
clean_blocks(blk);
fmtstr = sprintf('latency=%d', add_latency+mult_latency);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});        
