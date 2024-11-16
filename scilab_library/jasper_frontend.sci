function [build_cmd] = jasper_frontend(fn)
    // create a dir for the project
    [path, name, ext] = fileparts(fn);
    dir = path + '/' + name;
    if ~isdir(dir) then
        mkdir(dir);
    end
    // disp some info
    disp('Starting jasper for model: '+ name);

    // generate a fake modelpath for exec_flow.py
    modelpath = fn;

    // load the diagram file
    scs_m = xcosDiagramToScilab(fn);
    // get the number of objs
    n_objs = length(scs_m.objs);
 
    // query the block information
    st = struct();
    st('project') = struct('tag', 'proj', 'filename', fn);
    // st('xps_blocks') = struct();
    // st('dsp_blocks') = struct();
    // st('sim_blocks') = struct();
    // st('link_info') = struct();
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
            // if it's a split_f block, we don't need to get the info
            if obj.gui == 'SPLIT_f' then
                continue;
            end
            // get the block type and block tag
            // the type should be on of "xps", "dsp", "sim"
            // the tag is the "swreg", "gpio", etc.
            type = obj.model.label;
            tag = obj.gui;
            // each block has a template, which contains the paramters info and input/output ports info
            template_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
            template = fromJSON(template_path, "file");
            // create a new struct for the block info
            keys = template('parameters')('keys');
            vals = template('parameters')('values');
            block_info = struct();
            // set the default value from the template
            debug_info('block_template: ' + tag);
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
            // write the block info to the struct
            // use the block name as the key
            // blkname = blk_val(1);
            // // we need to check if the key exists or not
            // // if it exists, it means two blocks have the same name
            // if isfield(st(type+'_blocks'), blkname) then
            //     disp("error: two blocks have the same name: " + blkname);
            //     return -1;
            // end
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
    // the port info is stored in a struct.
    port_info = list();
    // create a struct for each blk_obj
    // some of the blk_objs are link objs, we don't need to generate port names for them
    for i = 1:n_objs
        port_info(i) = struct();
        port_info(i)('in') = list();
        port_info(i)('out') = list();
    end
    st('link_info') = list();
    // ind = 1;
    // // go through all of the objs, and get the link info
    // for i = 1:n_objs
    //     obj = scs_m.objs(i);
    //     // check the obj type
    //     // if it's a link obj, we used generate port name based on this obj
    //     if typeof(obj) == 'Link' then
    //         // check if the link is connected to a sim block
    //         [src_tag, dst_tag] = check_block_type(scs_m.objs, obj);
    //         if src_tag == 'sim' | dst_tag == 'sim' then
    //             continue;
    //         end
    //         [blk_port_info] = gen_port_info(name, scs_m.objs, obj);
    //         src_blk_id = blk_port_info('src_blk_id');
    //         src_port_name = blk_port_info('src_port_name');
    //         src_port_id = blk_port_info('src_port_id');
    //         if src_blk_id ~= -1 then
    //                 port_info(src_blk_id)('out')(src_port_id) = src_port_name;
    //         end
    //         dst_blk_id = blk_port_info('dst_blk_id');
    //         dst_port_name = blk_port_info('dst_port_name');
    //         dst_port_id = blk_port_info('dst_port_id');
    //         // if the dst_blk_id is -1, it means the dst_blk is a SPLIT_f block
    //         if dst_port_id ~= -1 then
    //             port_info(dst_blk_id)('in')(dst_port_id) = dst_port_name;
    //         end
    //         // if the dst_blk is not a SPLIT_f block, we will save the struct to link_info
    //         if dst_blk_id ~= -1 then
    //             link_info(ind) = blk_port_info;
    //             ind = ind + 1;
    //         end
    //     end
    // end

    // create a big struct
    toJSON(st, path + name + '/jasper.json', 4);
    // BUG: this looks like a bug in scilab
    // not sure why we have to clear the variables
    // if we don't do it, the python script will not work...
    clear st;
    clear port_info;
    clear link_info;
    clear id;
    clear val;
    clear type;
    clear blkid;
    // execute a python script to read the json file and generate jasper.per
    disp('****************************************');
    disp('*  Frontend python script is running...*');
    scilab_library_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library';
    //unix_s(scilab_library_path+'/jasper_frontend.py');
    disp('*  Frontend python script complete!    *');
    disp('****************************************');
    build_cmd = struct();
    python_path = 'python';
    // create a build_cmd for the dsp project
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/scilab_library/gen_dsp_ip.py'];
    build_cmd('dsp') = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath;
    // create a build_cmd for the full project
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/jasper_library/exec_flow.py'];
    build_cmd('full') = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath + ' --middleware --backend --software --vitis';

endfunction