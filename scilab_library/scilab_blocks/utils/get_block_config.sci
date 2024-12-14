// open the block config file
function [config] = get_block_config(type, tag)
    scilab_block_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library/scilab_blocks/';
    config_path = scilab_block_path + 'casper_' + type + '/' + tag + '.json';
    debug_info('config_path: ' + config_path);
    config = fromJSON(config_path, "file");
    // convert all of the values to strings
    keys = config('parameters')('keys');
    vals = config('parameters')('values');
    // make sure all of the values are strings
    for i = 1:size(keys)(2)
        config('parameters')('values')(i) = string(vals(i));
    end
endfunction