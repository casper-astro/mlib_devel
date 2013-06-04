function snap_32n_init(blk, varargin)

defaults = {};
if same_state(blk, 'defaults', defaults, varargin{:}), return, end

check_mask_type(blk, 'snap_32n');
munge_block(blk, varargin{:});

width = get_var('width', 'defaults', defaults, varargin{:});
delete_lines(blk);

add_line(blk, 'Constant/1', 'read_freeze/1');

for k=1:width,
    snap_core_pos = [135    4+95*k   160   46+95*k];
    reuse_block(blk, ['sc', num2str(k-1)], 'casper_library_scopes/sc', ...
        'offset', num2str(32*(k-1)), ...
        'Position', snap_core_pos);
    add_line(blk, 'trig/1', ['sc', num2str(k-1), '/2']);
    add_line(blk, 'din/1', ['sc', num2str(k-1), '/1']);
    add_line(blk, 'read_freeze/1', ['sc', num2str(k-1), '/3']);
end

clean_blocks(blk);    
save_state(blk, 'defaults', defaults, varargin{:});
end
