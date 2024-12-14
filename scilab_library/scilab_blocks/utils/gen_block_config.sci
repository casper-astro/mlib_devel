// generate the block config file in `configdir`, which is `buildir/bconfigs`.

// Actually, we just copy the block config file from 
// scilab_library/scilab_blocks/casper_*/ to `configdir`.

function [] = gen_block_config(configdir, obj)
    // get the block typy, tag and name
    tag = get_block_tag(obj);
    type  = get_block_type(obj);
    name = get_block_name(obj);
    // get the config file path
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    config_src = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
    config_dst = configdir + '/' + name + '.json';
    // check if the config exists or not.
    // if not exist, let's copy the config file to configdir
    // TODO: do we need to check if the file exists or not?
    //       or just overwrite it?
    if isfile(config_dst) == %F then
        debug_info('generated config file: ' + name + '.json');
        copyfile(config_src, config_dst);
    end
endfunction