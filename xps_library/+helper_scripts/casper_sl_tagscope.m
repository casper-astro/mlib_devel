function casper_sl_tagscope(userargs)
DEBUG = false;
try
    scopetouse = userargs.userdata;
catch
    scopetouse = userargs;
end

block_names = find_system(gcs, 'LookUnderMasks', 'all', 'SearchDepth', 1, 'Regexp', 'on', 'BlockType', 'Goto|From', 'Selected', 'on');
if isempty(block_names),
    error('No suitable selected goto/from blocks.');
end

for ctr = 1 : length(block_names),
    blkname = block_names{ctr};
    set_param(blkname, 'TagVisibility', scopetouse)
    if DEBUG,
        debug_str = [blkname, ': ', scopetouse];
        fprintf('%s\n', debug_str);
    end
end

end
% end
