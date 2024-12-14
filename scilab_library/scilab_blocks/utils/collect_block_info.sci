function [] = collect_block_info(fn)
    [path, projname, ext] = fileparts(fn);
    builddir = path + '/' + projname;
    if ~isdir(builddir) then
        mkdir(builddir);
    end
    glue_dir = builddir + '/glues';
    if ~isdir(glue_dir) then
        mkdir(glue_dir);
    end
    // load the diagram file
    scs_m = xcosDiagramToScilab(fn);
    // get the number of objs
    n_objs = length(scs_m.objs);

    // query the block information
    st = struct();
    st('project') = struct('tag', 'proj', 'filename', fn);
    st('xps_blocks') = list();
    st('dsp_blocks') = list();
    st('sim_blocks') = list();
    xps_blocks_id = 1;
    dsp_blocks_id = 1;
    sim_blocks_id = 1;
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    for i = 1:n_objs
        obj = scs_m.objs(i);
        // if it's a block, get the block info
        if typeof(obj) == 'Block' then
            tag = get_block_tag(obj);
            type = get_block_type(obj);
            name = get_block_name(obj);
            // if it's a split_f block, we don't need to get the info
            if tag == 'SPLIT_f' then
                continue;
            end
            // get the block type and block tag
            // the type should be on of "xps", "dsp", "sim"
            // the tag is the "swreg", "gpio", etc.
            // each block has a config, which contains the paramters info and input/output ports info
            block_config = get_block_config(name, type, tag);
            // create a new struct for the block info
            keys = block_config('parameters')('keys');
            vals = block_config('parameters')('values');
            block_info = struct();
            // set the default value from the block_config
            debug_info('block_config: ' + tag);
            for j = 1:size(keys)(2)
                block_info(keys(j)) = vals(j);
                debug_info('    key: ' + string(keys(j)) + ' val: ' + string(vals(j)));
            end
            // get the values from the scilab block
            blk_val = obj.graphics.exprs;
            blk_vindex = obj.model.rpar;
            debug_info('blk_name: ' + blk_val(1))
            for j = 1:length(blk_vindex)
                id = blk_vindex(j) + 1;
                debug_info('    id: ' + string(id) + ' val: ' + string(blk_val(j)));
                block_info(keys(id)) = blk_val(j);
            end
            // set "fullpath", which should be the project name + block name
            block_info('fullpath') = projname + '/' + block_info('name');
            // write the block info to the struct
            if type == 'xps' then
                st('xps_blocks')(xps_blocks_id) = block_info;
                xps_blocks_id = xps_blocks_id + 1;
            elseif type == 'dsp' then
                st('dsp_blocks')(dsp_blocks_id) = block_info;
                dsp_blocks_id = dsp_blocks_id + 1;
            elseif type == 'sim' then
                st('sim_blocks')(sim_blocks_id) = block_info;
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
            src_blk_name = get_block_name(link('src_obj'));
            debug_info('    src_blk_name: ' + src_blk_name);
            src_blk_tag = get_block_tag(link('src_obj'));
            debug_info('    src_blk_tag: ' + src_blk_tag);
            src_blk_type = get_block_type(link('src_obj'));
            debug_info('    src_blk_type: ' + src_blk_type); 
            src_config = get_block_config(src_blk_name, src_blk_type, src_blk_tag);
            src_port_name = projname + '_' + src_blk_name + '_' + src_config('output_ports')("name")(link('src_port_id'));
            debug_info('    src_port_name: ' + src_port_name);
            debug_info('    src_port_id: ' + string(link('src_port_id')));
            src_port_width_id = src_config('output_ports')("width_id")(link('src_port_id'));
            src_port_width_default = src_config('output_ports')("width_default")(link('src_port_id'));
            debug_info('    src_port_width_id: ' + string(src_port_width_id));
            // we have collected the block info in st, so we can get the port width from st
            src_port_width = get_port_width(st, src_blk, src_port_width_id, src_port_width_default);
            debug_info('    src_port_width: ' + string(src_port_width));
            // collect the dst block info
            dst_blk = link('dst_obj');
            dst_blk_name = get_block_name(link('dst_obj'));
            debug_info('    dst_blk_name: ' + dst_blk_name);
            dst_blk_tag = get_block_tag(link('dst_obj'));
            debug_info('    dst_blk_tag: ' + dst_blk_tag);
            dst_blk_type = get_block_type(link('dst_obj'));
            debug_info('    dst_blk_type: ' + dst_blk_type);
            dst_config = get_block_config(dst_blk_name, dst_blk_type, dst_blk_tag);
            dst_port_name = projname + '_' + dst_blk_name + '_' +dst_config('input_ports')("name")(link('dst_port_id'));
            debug_info('    dst_port_name: ' + dst_port_name);
            debug_info('    dst_port_id: ' + string(link('dst_port_id')));
            dst_port_width_id = dst_config('input_ports')("width_id")(link('dst_port_id'));
            dst_port_width_default = dst_config('input_ports')("width_default")(link('dst_port_id'));
            debug_info('    dst_port_width_id: ' + string(dst_port_width_id));
            // we have collected the block info in st, so we can get the port width from st
            dst_port_width = get_port_width(st, dst_blk, dst_port_width_id, dst_port_width_default);
            debug_info('    dst_port_width: ' + string(dst_port_width));
            // write the link info to the struct
            link_info('src_blk_name') = src_blk_name;
            link_info('src_port_name') = src_port_name;
            link_info('src_port_width') = strtod(src_port_width);
            link_info('src_port_id') = link('src_port_id');
            link_info('dst_blk_name') = dst_blk_name;
            link_info('dst_port_name') = dst_port_name;
            link_info('dst_port_width') = strtod(dst_port_width);
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