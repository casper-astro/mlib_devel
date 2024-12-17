// generate the block config file in `configdir`, which is `buildir/bconfigs`.

// Actually, we just copy the block config file from 
// scilab_library/scilab_blocks/casper_*/ to `configdir`.

function [] = gen_block_config(configdir, obj)
    // get the block typy, tag and name
    tag = get_block_tag(obj);
    type  = get_block_type(obj);
    name = get_block_name(obj);
    iport_width_id = get_port_width_id(obj, 'in');
    oport_width_id = get_port_width_id(obj, 'out');
    // get the config file path
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    config_src_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
    config_dst_path = configdir + '/' + name + '.json';
    // check if the config exists or not.
    // if not exist, let's copy the config file to configdir
    // TODO: do we need to check if the file exists or not?
    //       or just overwrite it?
    if isfile(config_dst_path) == %F then
        debug_info('generated config file: ' + name + '.json');
        // copyfile(config_src_path, config_dst_path);

        // it seems impossible to get the keys and vals by index in scilab, 
        // so I put keys/vals into different fields in the default config file.
        // because of the above reason, it's not convenient for the user to modify the config file. 
        // we need to merge the keys and vals into a single field, which is more convenient for the user.
        // TODO: how to get key/val by index in scilab?? 
        config_src = fromJSON(config_src_path, "file");
        keys = config_src('parameters')('keys');
        vals = config_src('parameters')('values');
        parameters = struct()
        for i = 1:size(keys)(2)
            parameters(keys(i)) = string(vals(i));
        end
        config_dst = struct()
        config_dst('parameters') = parameters;
        config_dst('input_ports') = struct();
        config_dst('input_ports')('width_id') = iport_width_id;
        config_dst('output_ports') = struct();
        config_dst('output_ports')('width_id') = oport_width_id;
        toJSON(config_dst, config_dst_path, 4);
    end
endfunction