// open the block config file from builddir/bconfig/xx.json, and get the parameters from the file.
function [config] = get_block_config(name, type, tag)
    disp('name:', name);
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    config_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
    // debug_info('config_path: ' + config_path);
    config = fromJSON(config_path, "file");
    keys = config('parameters')('keys');
    vals = config('parameters')('values');

    // update the vals from the user defined block config file.
    // make sure all of the values are strings.
    user_config_path = getenv('CONFIG_DIR') + '/' + name + '.json';
    user_config = fromJSON(user_config_path, "file");
    for i = 1:size(keys)(2)
        k = keys(i)
        v = user_config('parameters')(k);
        config('parameters')('values')(i) = string(v);
    end
    config('input_ports') = struct();
    config('input_ports') = user_config('input_ports');
    config('output_ports') = struct();
    config('output_ports') = user_config('output_ports');
endfunction