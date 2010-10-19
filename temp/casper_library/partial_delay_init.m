function partial_delay_init(blk, varargin)
% Initialize and configure the reorder block.
%
% partial_delay_init(blk, varargin)
%
% blk = The baseline_tap block
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% n_inputs = The number of parallel inputs.
% mux_latency = The latency of each mux block.

% Declare any default values for arguments you might like.
if same_state(blk, varargin{:}), return, end
check_mask_type(blk, 'partial_delay');
munge_block(blk, varargin{:});
n_inputs = get_var('n_inputs', varargin{:});
mux_latency = get_var('mux_latency', varargin{:});

if n_inputs < 2,
    error('For partial_delay, number of inputs cannot be less than 2.');
end

delete_lines(blk);
reuse_block(blk, 'delay', 'built-in/inport', 'Position', [25 25 55 39], 'Port', '1');

for i=1:n_inputs,
    reuse_block(blk, ['In', num2str(i)], 'built-in/inport', ...
        'Position', [25 25+(i*75) 55 39+(i*75)], 'Port', num2str(1+i));
    reuse_block(blk, ['Delay', num2str(i)], 'xbsIndex_r4/Delay', ...
        'Position', [100 20+(i*75) 130 50+(i*75)], 'latency', '1');
    reuse_block(blk, ['Mux', num2str(i)], 'xbsIndex_r4/Mux', ...
        'Position', [175 20+(i*75) 200 86+(i*75)], 'inputs', num2str(n_inputs), 'latency', num2str(mux_latency));
    reuse_block(blk, ['Out', num2str(i)], 'built-in/outport', ...
        'Position', [250 25+(i*75) 280 39+(i*75)], 'Port', num2str(i));

    add_line(blk, ['In', num2str(i), '/1'], ['Delay', num2str(i), '/1']);
    add_line(blk, ['Mux', num2str(i), '/1'], ['Out', num2str(i), '/1']);
    add_line(blk, 'delay/1', ['Mux', num2str(i), '/1']);
    add_line(blk, ['Delay', num2str(i), '/1'], ['Mux', num2str(i), '/2']),
end

for j=1:n_inputs,
    for k=2:n_inputs,
        if j+k <= n_inputs+1,
            add_line(blk, ['Delay', num2str(j+k-1), '/1'], ['Mux', num2str(j), '/', num2str(k+1)]);
        else
            add_line(blk, ['In', num2str(j+k-n_inputs-1), '/1'], ['Mux', num2str(j), '/', num2str(k+1)]);
        end
    end
end

clean_blocks(blk);

save_state(blk, varargin{:});
