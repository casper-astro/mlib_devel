function casper_sl_set_block_size(~)

try
    block_size_x = evalin('base', 'block_size_x');
    block_size_y = evalin('base', 'block_size_y');
catch
    error('block_size_x and block_size_y must exist before you call this function! Did you get_block_size?')
end
block_names = find_system(gcs, 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Type', 'Block', 'Selected', 'on');
for ctr = 1 : length(block_names)
    blkname = block_names{ctr};
    if strcmp(blkname, gcs) == 0
        blkpos = get_param(blkname, 'Position');
        new_pos = sprintf('[%i %i %i %i]', blkpos(1), blkpos(2), blkpos(1) + block_size_x, blkpos(2) + block_size_y);
        set_param(blkname, 'Position', new_pos);
    end
end

end
% end