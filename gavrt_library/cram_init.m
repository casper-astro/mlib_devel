function cram_init(blk, varargin)
%num_slice

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end
check_mask_type(blk, 'cram');
munge_block(blk, varargin{:});

num_slice = get_var('num_slice', 'defaults', defaults, varargin{:});

delete_lines(blk);

reuse_block(blk, 'Out', 'built-in/outport', 'Position', [400 250 430 270]);
if num_slice == 1,
  j=1;
  reuse_block(blk, ['Reinterp', num2str(j)],'xbsIndex_r4/Reinterpret', ...
          'force_arith_type', 'on', 'arith_type', 'Unsigned', 'force_bin_pt', 'on', ...
          'bin_pt', num2str(0), ...
          'Position', [200 50+j*100 250 100+j*100]);
  add_line(blk, ['In', num2str(j), '/1'], ['Reinterp', num2str(j), '/1']);
  add_line(blk, ['Reinterp', num2str(j), '/1'], 'Out/1');
else,
  reuse_block(blk, 'Concat', 'xbsIndex_r4/Concat', 'num_inputs', num2str(num_slice), 'Position', [300 50 350 550]);
  add_line(blk, 'Concat/1', 'Out/1');
  
  for j = 1:num_slice,
      reuse_block(blk, ['In', num2str(j)], 'built-in/inport', ...
          'Position', [100 50+j*100 130 70+j*100]);
      reuse_block(blk, ['Reinterp', num2str(j)],'xbsIndex_r4/Reinterpret', ...
          'force_arith_type', 'on', 'arith_type', 'Unsigned', 'force_bin_pt', 'on', ...
          'bin_pt', num2str(0), ...
          'Position', [200 50+j*100 250 100+j*100]);
      add_line(blk, ['In', num2str(j), '/1'], ['Reinterp', num2str(j), '/1']);
      add_line(blk, ['Reinterp', num2str(j), '/1'], ['Concat/', num2str(j)]);
  end
end
clean_blocks(blk);

save_state(blk, 'defaults', defaults, varargin{:});