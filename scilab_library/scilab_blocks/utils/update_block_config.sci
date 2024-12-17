// this function write the config info to the user define config file.
function [] = update_block_config(block_info, name)
    // get the user defined config file path
    user_config_path = getenv('CONFIG_DIR') + '/' + name + '.json';
    // write the config to the user defined config file
    user_config = fromJSON(user_config_path, "file");
    user_config('parameters') = block_info;
    toJSON(user_config, user_config_path, 4);
endfunction