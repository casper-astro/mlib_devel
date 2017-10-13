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
    
    % workspace variables
    base_vars = evalin('base', 'whos');
    num_bvars = length(base_vars);
    for ctr = 1 : num_bvars,
        tmp.name = base_vars(ctr).name;
        tmp.value = evalin('base', base_vars(ctr).name);
        if isnumeric(tmp.value),
            tmp.value = num2str(tmp.value);
        end
        if ischar(tmp.value),
            tmp.value = strtrim(tmp.value);
            if strcmp(tmp.value, '\n') == 1,
                tmp.value = '';
            end
            if strcmp(tmp.value, '\t') == 1,
                tmp.value = '';
            end
            if isempty(tmp.value) == 0,
                info_blocks = [info_blocks, design_info.InfoBlock(tmp.name, tmp.value, '77777', '77777')];
            end
        end
    end

    % write the file
    try
        fid = fopen(filename, 'w');
    catch e
        e.stack
        error(['Could not open ', filename, '.']);
    end
    for b = 1 : numel(info_blocks),
        blk = info_blocks(b);
        try
            blkstr = blk.to_table_row();
        catch
            fprintf('\nERROR: Could not get table row for block(%s), parent(%s) info(%s)\n', blk.block, blk.parent_block, blk.info)
            error('');
        end
        fprintf(fid, blkstr);
    end
    fprintf(fid, '');
    fclose(fid);
end
