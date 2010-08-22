function dataratechanger_init(blk, varargin)

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'dataratechanger');
munge_block(blk, varargin{:});
disp('hi from dataratechanger_init')
L = get_var('input_length', 'defaults', defaults, varargin{:});
ninputs = get_var('ninputs', 'defaults', defaults, varargin{:});
out_rate = get_var('out_rate', 'defaults', defaults, varargin{:});
in_bit_width = get_var('in_bit_width', 'defaults', defaults, varargin{:});
in_bin_pt = get_var('in_bin_pt', 'defaults', defaults, varargin{:});
arith_type = get_var('arith_type', 'defaults', defaults, varargin{:});

fifo_rate_bits = out_rate+ninputs;
ninputs = 2^ninputs;
inlen = 2^L;
if inlen > 2^16,
    error('Input length must be < 2^16')
end
%       2^   0       1     2     3     4   5
fifolens = {'16', '16', '16', '16', '16', '32', '64', '128', '256', '512', '1K', '2K', '4K', '8K', '16K', '32K', '64K'};

set_param([blk, '/freeze_cntr'], 'CounterBits', num2str(L+fifo_rate_bits))
if ninputs == 1
    set_param([blk, '/sync_delay'], 'DelayLen', num2str(2^L+2));
    set_param([blk, '/Delay'], 'latency', '2');
else
    set_param([blk, '/sync_delay'], 'DelayLen', num2str(2^L+3));
    set_param([blk, '/Delay'], 'latency', '3');
end
set_param([blk, '/Slice1'], 'nbits', num2str(fifo_rate_bits))


delete_lines(blk);



add_line(blk,'syncIn/1','sync_delay/1');
add_line(blk,'sync_delay/1','syncOut/1');

add_line(blk,'enIn/1','Inverter/1');
add_line(blk,'Inverter/1','freeze_cntr/1');
add_line(blk,'enIn/1','freeze_cntr/2');
add_line(blk,'freeze_cntr/2','Delay/1');
add_line(blk,'Delay/1','enOut/1');
add_line(blk,'freeze_cntr/1','Slice1/1');


reuse_block(blk, 'Uncram', 'gavrt_library/uncram', ...
    'num_slice', num2str(ninputs), 'slice_width', num2str(in_bit_width), ...
    'bin_pt', num2str(in_bin_pt), 'arith_type', num2str(double(arith_type)));

add_line(blk,'din/1','Uncram/1')

if ninputs > 1,
    reuse_block(blk, 'Mux', 'xbsIndex_r4/Mux', ...
        'inputs',num2str(ninputs), ...
        'latency', '1', 'Position', [850 220 880 290]);
    reuse_block(blk, 'Slice2', 'xbsIndex_r4/Slice', ...
        'mode', 'Lower Bit Location + Width', ...
        'nbits', num2str(log2(ninputs)), 'bit0', num2str(out_rate), ...
        'Position', [600 140 635 160])
    reuse_block(blk, 'Add', 'xbsIndex_r4/AddSub', ...
        'precision', 'User Defined', ...
        'n_bits', num2str(log2(ninputs)), 'bin_pt', '0', ...
        'arith_type', 'Unsigned', 'Position', [650 140 685 170]);
    reuse_block(blk, 'ConsOne', 'xbsIndex_r4/Constant', ...
        'const', '1', 'n_bits', '1', ...
        'arith_type','Unsigned','bin_pt', '0','Position',[600 180 635 200]);
    add_line(blk,'Mux/1','dout/1');
    add_line(blk,'Slice2/1','Add/1');
    add_line(blk,'ConsOne/1','Add/2');
    add_line(blk,'Add/1','Mux/1');
    add_line(blk,'freeze_cntr/1','Slice2/1');
    for k = 1:ninputs,
        reuse_block(blk, ['FIFO',num2str(k)], 'xbsIndex_r4/FIFO', ...
            'depth', fifolens{L+1}, 'Position', [600, 100+k*100, 650,170+k*100]);
        reuse_block(blk, ['Compare',num2str(k)], 'xbsIndex_r4/Relational', ...
            'latency', '0', 'mode', 'a=b', 'Position', [550, 150+k*100, 580, 170+k*100]);
        reuse_block(blk, ['Const',num2str(k)], 'xbsIndex_r4/Constant', ...
            'const', num2str(((k-1)*2^out_rate)+1), 'n_bits',num2str(fifo_rate_bits), ...
            'arith_type','Unsigned','bin_pt', '0','Position', [510, 155+k*100, 530 , 170+k*100]);
        add_line(blk,'enIn/1',['FIFO',num2str(k),'/2'])
        add_line(blk,['Const',num2str(k),'/1'],['Compare',num2str(k),'/2'])
        add_line(blk,['Compare',num2str(k),'/1'],['FIFO',num2str(k),'/3'])
        add_line(blk,['Uncram/',num2str(k)],['FIFO',num2str(k),'/1'])
        add_line(blk,['FIFO',num2str(k),'/1'],['Mux/',num2str(k+1)])
        add_line(blk,'Slice1/1',['Compare',num2str(k),'/1']);
    end
else
    k = 1
    reuse_block(blk, ['FIFO',num2str(k)], 'xbsIndex_r4/FIFO', ...
        'depth', fifolens{L+1}, 'Position', [600, 100+k*100, 650,170+k*100]);
    reuse_block(blk, ['Compare',num2str(k)], 'xbsIndex_r4/Relational', ...
        'latency', '0', 'mode', 'a=b', 'Position', [550, 150+k*100, 580, 170+k*100]);
    reuse_block(blk, ['Const',num2str(k)], 'xbsIndex_r4/Constant', ...
        'const', num2str(((k-1)*2^out_rate)+1), 'n_bits',num2str(fifo_rate_bits), 'Position', [520, 160+k*100, 530 , 170+k*100]);
    add_line(blk,'enIn/1',['FIFO',num2str(k),'/2'])
    add_line(blk,['Const',num2str(k),'/1'],['Compare',num2str(k),'/2'])
    add_line(blk,['Compare',num2str(k),'/1'],['FIFO',num2str(k),'/3'])
    add_line(blk,['Uncram/',num2str(k)],['FIFO',num2str(k),'/1'])
    add_line(blk,['FIFO',num2str(k),'/1'],'dout/1')
    add_line(blk,'Slice1/1',['Compare',num2str(k),'/1']);
        
end

clean_blocks(blk);
fmtstr = sprintf('inputs=%d, bit_width=%d, input length=%d, output rate=2^-%d', ninputs, in_bit_width, (2^L),out_rate);
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});