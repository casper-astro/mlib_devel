function write_info_table(filename, sysname, blks)
    % the virtual info blocks we're populating
    info_blocks = {};

    % process the blocks
    tags = {};
    for b = 1 : numel(blks),
        tag = get_param(blks{b}, 'tag');
        tags = [tags, tag];
        infoblks = design_info.sblock_to_info(blks{b});
        info_blocks = [info_blocks, infoblks];
    end
    tags = unique(tags);
    tag_str = '';
    for t = 1 : numel(tags),
        tag_str = [tag_str, ',', tags{t}];
    end
    info_blocks = [info_blocks, design_info.InfoBlock('tags', tag_str(2:end), '', '')];
    
    % add some system info
    info_blocks = [info_blocks, design_info.InfoBlock('system', sysname, '', '')];
    info_blocks = [info_blocks, design_info.InfoBlock('builddate', datestr(now), '', '')];
    
    % write the file
    try
        fid = fopen(filename, 'w');
        for b = 1 : numel(info_blocks),
            blk = info_blocks(b);
            fprintf(fid, blk.to_table_row());
        end
        fprintf(fid, '');
    catch e
        e.stack
        error(['Could not open ', filename, '.']);
    end
    fclose(fid);
end