function vacc_init(blk, varargin)
%2008.02.25 - Added Mux Latency
%veclen
%ninputs
%arith_type
%in_bit_width
%in_bin_pt

defaults = {};

if same_state(blk, 'defaults', defaults, varargin{:}), return, end
disp('hi from vacc_init2')
check_mask_type(blk, 'vacc');
munge_block(blk, varargin{:});
veclen = get_var('veclen', 'defaults', defaults, varargin{:});
ninputs = get_var('ninputs', 'defaults', defaults, varargin{:});
max_accum = get_var('max_accum', 'defaults', defaults, varargin{:});
arith_type = get_var('arith_type', 'defaults', defaults, varargin{:});
in_bit_width = get_var('in_bit_width', 'defaults', defaults, varargin{:});
in_bin_pt = get_var('in_bin_pt', 'defaults', defaults, varargin{:});
out_bit_width = get_var('out_bit_width', 'defaults', defaults, varargin{:});
out_bin_pt = get_var('out_bin_pt', 'defaults', defaults, varargin{:});
register_din = get_var('register_din', 'defaults', defaults, varargin{:});
add_latency = get_var('add_latency', 'defaults', defaults, varargin{:});
bram_latency = get_var('bram_latency', 'defaults', defaults, varargin{:});
mux_latency = get_var('mux_latency', 'defaults', defaults, varargin{:});
disp('updating vacc')

if veclen < 3,
    errordlg('Vector Accumulator: Vector Length must be >= 2^3')
end
in_int_bits = in_bit_width - in_bin_pt;
out_int_bits = out_bit_width - out_bin_pt;

actual_veclen = 2^veclen;

delete_lines(blk);

% Update Static Blocks
counter = [blk, '/Counter'];
set_param(counter, 'n_bits', num2str(max_accum + veclen));

set_param([blk, '/DinDelay'], 'latency', num2str(mux_latency+1));
if register_din,
    set_param([blk, '/DinDelay'], 'reg_retiming', 'on');
else,
    set_param([blk, '/DinDelay'], 'reg_retiming', 'off');
end
set_param([blk, '/SyncDelay'], 'latency', num2str(0));  % Not used afterall

set_param([blk, '/Slice'], 'nbits', num2str(max_accum));
set_param([blk, '/SliceLow'], 'nbits', num2str(veclen));
set_param([blk, '/SyncConst'], 'n_bits', num2str(veclen), 'const', num2str(actual_veclen-2));
set_param([blk, '/ValidDelay'], 'latency', num2str(add_latency+mux_latency));

% Static Lines
add_line(blk, 'sync/1', 'SyncDelay/1');
add_line(blk, 'SyncDelay/1', 'OR/1');
add_line(blk, 'FromValid/1', 'AND/1');
add_line(blk, 'AND/1', 'OR/2');
add_line(blk, 'OR/1', 'Counter/1');
add_line(blk, 'Counter/1', 'GotoCount/1');
add_line(blk, 'FromCount/1', 'SliceLow/1');
add_line(blk, 'SliceLow/1', 'SyncCompare/1');
add_line(blk, 'SyncConst/1', 'SyncCompare/2');
add_line(blk, 'SyncCompare/1', 'AND/2');
add_line(blk, 'ValidCompare/1', 'GotoValid/1');
add_line(blk, 'Counter/1', 'Slice/1');
add_line(blk, 'acc_len/1', 'ValidCompare/1');
add_line(blk, 'Slice/1', 'ValidCompare/2');
add_line(blk, 'Slice/1', 'AccEnCompare/1');
add_line(blk, 'Zero/1', 'AccEnCompare/2');
add_line(blk, 'ValidCompare/1', 'ValidDelay/1');
add_line(blk, 'ValidDelay/1', 'valid/1');
add_line(blk, 'din/1', 'DinDelay/1');

%num2str(arith_type)
reuse_block(blk, 'Uncram', 'gavrt_library/uncram', ...
    'num_slice', num2str(ninputs), 'slice_width', num2str(in_bit_width), ...
    'bin_pt', num2str(in_bin_pt), 'arith_type', num2str(double(arith_type)), ...
    'Position', [350 300 400 500]);
reuse_block(blk, 'Cram', 'gavrt_library/cram', ...
    'num_slice', num2str(ninputs), 'Position', [850 300 900 500]);

add_line(blk, 'DinDelay/1', 'Uncram/1');
add_line(blk, 'Cram/1', 'dout/1');

for j = 1:ninputs,
    reuse_block(blk, ['vacc_core', num2str(j)], 'gavrt_library/vacc_core', ...
        'veclen', num2str(actual_veclen), ...
        'out_bit_width', num2str(out_bit_width), 'out_bin_pt', num2str(out_bin_pt), ...
        'add_latency', num2str(add_latency), 'bram_latency', num2str(bram_latency), ...
        'mux_latency', num2str(mux_latency), 'arith_type', num2str(arith_type), ...
        'Position', [500 200*j+150 600 200*j+250]);
    add_line(blk, ['Uncram/', num2str(j)], ['vacc_core', num2str(j), '/1']);
    add_line(blk, 'AccEnCompare/1', ['vacc_core', num2str(j), '/2']);
    add_line(blk, ['vacc_core', num2str(j), '/1'], ['Cram/', num2str(j)]);
end

clean_blocks(blk);
fmtstr = sprintf('vector length=%d, inputs=%d\nmax accumulations=2^%d', (2^veclen), ninputs, max_accum);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});
