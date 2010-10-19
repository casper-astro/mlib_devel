
function reg_readout_ctrl_init(blk, varargin)
% Configure the register readout control block.
%
% reg_readout_ctrl_init(blk, varargin)
%
% blk = The block to configure.
% varargin = {'varname', 'value', ...} pairs
% 
% Valid varnames for this block are:
% mux_latency = latency through mux block
% n_registers = number of registers (max size = 32)


% Declare any default values for arguments you might like.
defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
munge_block(blk, varargin{:});

mux_latency = get_var('mux_latency', 'defaults', defaults, varargin{:});
n_registers = get_var('n_registers', 'defaults', defaults, varargin{:});

 
if( n_registers > 32 ),
    error('reg_readout_ctrl.m: Too many register inputs! Maximum is 32');
    return
end

delete_lines(blk);

% Add Ports
reuse_block(blk, 'reg_sel', 'built-in/inport', 'Position', [30 32 60 48], 'Port', '1');
reuse_block(blk, 'reg_out', 'built-in/outport', 'Position', [725 35 755 50], 'Port', '1');
for i=0:n_registers-1,
    reuse_block(blk, ['reg_in',num2str(i)], 'built-in/inport', ...
        'Position', [30 45*i+125 60 45*i+140], 'Port', num2str(i+2));
end;

% Add multiplexer and slice for multiplexer select line
reuse_block(blk, 'reg_sel_slice', 'xbsIndex_r4/Slice', ...
    'Position', [150 32 200 57], 'nbits', num2str(ceil(log2(n_registers))), ...
    'mode', 'Lower Bit Location + Width', 'bit0', '0', 'base0', 'LSB of Input')
add_line(blk, 'reg_sel/1', 'reg_sel_slice/1');
reuse_block(blk, 'reg_mux', 'xbsIndex_r4/Mux', ...
    'Position', [300 32 380 32+(n_registers*20)], ...
    'inputs', num2str(n_registers), 'latency', num2str(mux_latency))
add_line(blk, 'reg_sel_slice/1', 'reg_mux/1');
add_line(blk, 'reg_mux/1', 'reg_out/1');
% add reinterperate blocks to force all inputs to unsigned binary

for i=0:n_registers-1,
    reuse_block(blk, ['force_u', num2str(i)], 'xbsIndex_r4/Reinterpret', ...
        'Position', [150 45*i+125, 200, 45*i+150], ...
        'force_arith_type', 1, 'arith_type', 'Unsigned', ...
        'force_bin_pt', 1, 'bin_pt', '0');
    add_line(blk, ['reg_in',num2str(i),'/1'], ['force_u', num2str(i), '/1']);
    add_line(blk, ['force_u', num2str(i), '/1'], ['reg_mux/', num2str(i+2)]);
end
    


clean_blocks(blk);

fmtstr = sprintf('n_inputs=%d\nlatency=%d', n_registers, mux_latency);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
