// open the block config file
function [config] = get_block_config(name, type, tag)
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    config_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
    // debug_info('config_path: ' + config_path);
    config = fromJSON(config_path, "file");
    keys = config('parameters')('keys');
    //vals = config('parameters')('values');

    // update the vals from the user defined block config file.
    // make sure all of the values are strings.
    user_config_path = getenv('CONFIG_DIR') + '/' + name + '.json';
    user_config = fromJSON(user_config_path, "file");
    for i = 1:size(keys)(2)
        k = keys(i)
        v = user_config('parameters')(k);
        config('parameters')('values')(i) = string(v);
    end
endfunction