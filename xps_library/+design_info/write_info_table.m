function write_info_table(filename, sysname, blks)
    %
    % Given a list of tagged blocks and a filename, write a file
    % containing all the information about those blocks, populated from
    % their masks.
    %

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
    info_blocks = [info_blocks, design_info.InfoBlock('tags', tag_str(2:end), '77777', '77777')];
    
    % add some system info
    info_blocks = [info_blocks, design_info.InfoBlock('system', sysname, '77777', '77777')];
    info_blocks = [info_blocks, design_info.InfoBlock('builddate', datestr(now), '77777', '77777')];
    
    % write the file
    try
        fid = fopen(filename, 'w');
    catch e
        e.stack
        error(['Could not open ', filename, '.']);
    end
    for b = 1 : numel(info_blocks),
        blk = info_blocks(b);
        blkstr = blk.to_table_row();
        fprintf(fid, blkstr);
    end
    fprintf(fid, '');
    fclose(fid);
end
