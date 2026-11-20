function [] = collect_block_info(fn)
    [path, projname, ext] = fileparts(fn);
    builddir = path + '/' + projname;
    if ~isdir(builddir) then
        mkdir(builddir);
    end

    /* remove the bconfig dir, as we will re-create it in this function */
    bconfigdir = sprintf("%s/bconfigs", builddir);
    if isdir(bconfigdir) then
        rmdir(bconfigdir, 's');
        mkdir(bconfigdir);
    end

    /* load the diagram file */
    scs_m = xcosDiagramToScilab(fn);
    /* get the number of objs */
    n_objs = length(scs_m.objs);

    /* query the block information */
    st = struct();
    st('project') = struct('tag', 'proj', 'filename', fn);
    st('xps_blocks') = list();
    st('dsp_blocks') = list();
    st('sim_blocks') = list();
    xps_blocks_id = 1;
    dsp_blocks_id = 1;
    sim_blocks_id = 1;
    for i = 1:n_objs
        obj = scs_m.objs(i);
        /* if it's a block, get the block info */
        if typeof(obj) == 'Block' then
            tag = get_block_tag(obj);
            btype = get_block_type(obj);
            /* if it's a split_f block, we don't need to get the info */
            if tag == 'SPLIT_f' then
                continue;
            end
            /* get block info */
            block_config = gen_block_config(builddir, obj);
            /* write the block info to the struct */
            if btype == 'xps' then
                st('xps_blocks')(xps_blocks_id) = block_config;
                xps_blocks_id = xps_blocks_id + 1;
            elseif btype == 'dsp' then
                st('dsp_blocks')(dsp_blocks_id) = block_config;
                dsp_blocks_id = dsp_blocks_id + 1;
            elseif btype == 'sim' then
                st('sim_blocks')(sim_blocks_id) = block_config;
                sim_blocks_id = sim_blocks_id + 1;
            end
        end
        // For the link info, we deal with it in another for loop.
        if typeof(obj) == 'Link' then
            continue;
        end
    end

    // go through all of the link objs, 
    // and generate the port names for each blk_obj based on the link objs.
    st('link_info') = list();
    link_info = struct();
    link_info_id = 1;
    for i = 1:n_objs
        obj = scs_m.objs(i);
        // check the obj type
        // if it's a link obj, we used generate port name based on this obj
        if typeof(obj) == 'Link' then
            debug_info('link obj: ' + string(i));
            link = get_link_info_by_link_obj(scs_m.objs, obj);
            if link == 'skip' then
                debug_info('    skip this case.');
                continue;
            end
            // collect the src block info
            src_blk = link('src_obj');
            src_blk_name = get_block_name(bconfigdir, link('src_obj'));
            debug_info('    src_blk_name: ' + src_blk_name);
            src_blk_tag = get_block_tag(link('src_obj'));
            debug_info('    src_blk_tag: ' + src_blk_tag);
            src_blk_type = get_block_type(link('src_obj'));
            debug_info('    src_blk_type: ' + src_blk_type); 
            port_name = get_port_name(link('src_obj'), link('src_port_id'), 'out');
            src_port_name = projname + '_' + src_blk_name + '_' + port_name;
            debug_info('    src_port_name: ' + src_port_name);
            src_port_id = link('src_port_id');
            debug_info('    src_port_id: ' + string(src_port_id));
            // get port width
            src_port_width = get_port_width(src_blk, src_port_id, 'out');
            debug_info('    src_port_width: ' + string(src_port_width));
            // collect the dst block info
            dst_blk = link('dst_obj');
            dst_blk_name = get_block_name(bconfigdir, link('dst_obj'));
            debug_info('    dst_blk_name: ' + dst_blk_name);
            dst_blk_tag = get_block_tag(link('dst_obj'));
            debug_info('    dst_blk_tag: ' + dst_blk_tag);
            dst_blk_type = get_block_type(link('dst_obj'));
            debug_info('    dst_blk_type: ' + dst_blk_type);
            port_name = get_port_name(link('dst_obj'), link('dst_port_id'), 'in');
            dst_port_name = projname + '_' + dst_blk_name + '_' + port_name;
            debug_info('    dst_port_name: ' + dst_port_name);
            dst_port_id = link('dst_port_id');
            debug_info('    dst_port_id: ' + string(dst_port_id));
            // get port width
            dst_port_width = get_port_width(dst_blk, dst_port_id, 'in');
            debug_info('    dst_port_width: ' + string(dst_port_width));
            // write the link info to the struct
            link_info('src_blk_name') = src_blk_name;
            link_info('src_port_name') = src_port_name;
            //link_info('src_port_width') = strtod(src_port_width);
            link_info('src_port_width') = src_port_width;
            link_info('src_port_id') = link('src_port_id');
            link_info('dst_blk_name') = dst_blk_name;
            link_info('dst_port_name') = dst_port_name;
            //link_info('dst_port_width') = strtod(dst_port_width);
            link_info('dst_port_width') = dst_port_width;
            link_info('dst_port_id') = link('dst_port_id');
            link_info('link_type') = src_blk_type + '_' + dst_blk_type;
            st('link_info')(link_info_id) = link_info;
            link_info_id = link_info_id + 1;
        end
    end
    clear link_info;
    clear block_info;
    // create a big struct
    debug_info('Writing struct to ' + path + projname + '/jasper.json');
    toJSON(st, path + projname + '/jasper.json', 4);
endfunction