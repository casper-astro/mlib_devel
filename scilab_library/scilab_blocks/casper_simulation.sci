function [cmd] = casper_simulation(fn)
    // run jasper_fontend first, to get the IP core info.
    build_cmd = jasper_frontend(fn);
    // create a dir for the project
    [path, name, ext] = fileparts(fn);
    // chdir(path);
    mkdir(path+name);
    // we also need to create an IP core project for simulation.
    // If the project already exists, we will skip this step.
    // TODO: we may need to build the dsp project every time, as users may upate their design.
    if isdir(path+name+'/dspproj') == %F then
        unix_s(build_cmd('dsp'));
    end

    // get the model path
    modelpath = fn;

    // load the diagram file
    scs_m = xcosDiagramToScilab(fn);
    // get the number of objs
    n_objs = length(scs_m.objs);
    // create port info struct
    port_info = list();
    // create a struct for each blk_obj
    // some of the blk_objs are link objs, we don't need to generate port names for them
    for i = 1:n_objs
        port_info(i) = struct();
        port_info(i)('in') = list();
        port_info(i)('out') = list();
    end
    // create a struct for each sim block
    st = struct();
    link_info = list();
    st('project') = struct('tag', 'proj', 'filename', fn);
    blkid = 1;
    linkid = 1;
    ind = 1;
    // go through all of the objs, and collect the info for sim blocks
    for i = 1:n_objs
        obj = scs_m.objs(i);
        // check the obj type
        // if it's a sim block, we will collect the info
        if typeof(obj) == 'Block' then
            // check the obj type
            type = obj.model.label;
            // if it's a sim block, we will collect the info
            if type == 'sim' then
                // this contains the values
                val = obj.graphics.exprs;
                // this contains the paramter id in the template json file
                id = obj.model.rpar;
                st('blk.'+string(blkid))= struct('type', type, 'tag', obj.gui, 'blkid', i, 'id', id, 'val', val);
                blkid = blkid + 1;
            end
        end
        // check a link obj
        if typeof(obj) == 'Link' then
            // check if the link is connected to a sim block
            [src_tag, dst_tag] = check_block_type(scs_m.objs, obj);
            if src_tag == 'sim' | dst_tag == 'sim' then
                [blk_port_info] = gen_port_info(name, scs_m.objs, obj);
                src_blk_id = blk_port_info('src_blk_id');
                src_port_name = blk_port_info('src_port_name');
                src_port_id = blk_port_info('src_port_id');
                if src_blk_id ~= -1 then
                        port_info(src_blk_id)('out')(src_port_id) = src_port_name;
                end
                dst_blk_id = blk_port_info('dst_blk_id');
                dst_port_name = blk_port_info('dst_port_name');
                dst_port_id = blk_port_info('dst_port_id');
                // if the dst_blk_id is -1, it means the dst_blk is a SPLIT_f block
                if dst_port_id ~= -1 then
                    port_info(dst_blk_id)('in')(dst_port_id) = dst_port_name;
                end
                // if the dst_blk is not a SPLIT_f block, we will save the struct to link_info
                if dst_blk_id ~= -1 then
                    link_info(ind) = blk_port_info;
                    ind = ind + 1;
                end
            end
        end
    end
    st('link_info') = link_info;
    toJSON(st, 'jasper.sim', 4);
    // run python script to start simulation
    python_path = 'python';
    // create a build_cmd for the dsp project
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/scilab_library/casper_simulation.py'];
    cmd = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath;
endfunction