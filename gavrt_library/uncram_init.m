function uncram_init(blk, varargin)
% 2008.02.25 - Removed boolean option (didn't work, use SuperSlice)
%num_slice
%slice_width
%bin_pt
%arith_type

defaults = {};
%disp('hi from uncram')
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'uncram');
munge_block(blk, varargin{:});

num_slice = get_var('num_slice', 'defaults', defaults, varargin{:});
slice_width = get_var('slice_width', 'defaults', defaults, varargin{:});
bin_pt = get_var('bin_pt', 'defaults', defaults, varargin{:});
arith_type = get_var('arith_type', 'defaults', defaults, varargin{:});

atypes = {'Unsigned', 'Signed  (2''s comp)'};
if isempty(find(arith_type == [0,1])),
    errordlg('Uncram: Arithmetic Type must be 0 or 1')
end

delete_lines(blk);

reuse_block(blk, 'In', 'built-in/inport', 'Position', [100 50 130 70]);


for j = 1:num_slice,
    reuse_block(blk, ['Slice', num2str(j)], 'xbsIndex_r4/Slice', ...
        'mode', 'Upper Bit Location + Width', 'nbits', num2str(slice_width), 'bit1', num2str(-(j-1)*slice_width), ...
        'Position', [200 50+j*100 250 100+j*100]);
    reuse_block(blk, ['Reinterp', num2str(j)],'xbsIndex_r4/Reinterpret', ...
        'force_arith_type', 'on', 'force_bin_pt', 'on', ...
        'bin_pt', num2str(bin_pt), 'arith_type', char(atypes(arith_type+1)),...
        'Position', [300 50+j*100 350 100+j*100]);
    reuse_block(blk, ['Out', num2str(j)], 'built-in/outport', ...
        'Position', [400 50+j*100 430 70+j*100]);
    add_line(blk, 'In/1', ['Slice', num2str(j), '/1']);
    add_line(blk, ['Slice', num2str(j), '/1'],['Reinterp', num2str(j), '/1']);
    add_line(blk, ['Reinterp', num2str(j), '/1'], ['Out', num2str(j), '/1']);
end

clean_blocks(blk);
if arith_type,
    fmtstr = sprintf('Fix_%d_%d', slice_width, bin_pt);
else,
    fmtstr = sprintf('UFix_%d_%d', slice_width, bin_pt);
end
set_param(blk, 'AttributesFormatString', fmtstr);
save_state(blk, 'defaults', defaults, varargin{:});