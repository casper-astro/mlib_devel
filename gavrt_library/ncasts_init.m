function ncasts_init(blk, varargin)

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'ncasts');
munge_block(blk, varargin{:});

ncasts = get_var('ncasts', 'defaults', defaults, varargin{:});
arith_type = get_var('arith_type', 'defaults', defaults, varargin{:});
nbits = get_var('nbits', 'defaults', defaults, varargin{:});
bin_pt = get_var('bin_pt', 'defaults', defaults, varargin{:});

delete_lines(blk);

atypes = {'Unsigned', 'Signed  (2''s comp)', 'Boolean'};
if isempty(find(arith_type == [0,1,2])),
    errordlg('Ncasts: Arithmetic Type must be 0,1, or 2')
end

for j = 1:ncasts,
    reuse_block(blk, ['In', num2str(j)], 'built-in/inport', ...
        'Position', [100 50+j*100 130 70+j*100]);
    reuse_block(blk, ['Cast', num2str(j)], 'xbsIndex_r4/Convert', ...
        'arith_type', char(atypes(arith_type+1)), 'n_bits', num2str(nbits), 'bin_pt', num2str(bin_pt), ...
        'Position', [150 50+j*100 200 70+j*100]);
    reuse_block(blk, ['Out', num2str(j)], 'built-in/outport', ...
        'Position', [250 50+j*100 280 70+j*100]);
    add_line(blk, ['In', num2str(j), '/1'], ['Cast', num2str(j), '/1']);
    add_line(blk, ['Cast', num2str(j), '/1'], ['Out', num2str(j), '/1']);
end

clean_blocks(blk);
save_state(blk, 'defaults', defaults, varargin{:});
    
      

