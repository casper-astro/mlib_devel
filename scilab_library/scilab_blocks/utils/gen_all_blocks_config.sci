// each block has a config(json) file that describes the block info.
// we need to copy the config file to the build directory, and rename it to "block_name".json,
// so that each block in the design has its own config file.

// advanced users can modify the config file manually to change the block behavior.

function [] = gen_all_blocks_config(fn)
    // get the 
    [path, projname, ext] = fileparts(fn);
    configdir = path + '/' + projname + '/bconfigs';
    if ~isdir(configdir) then
        mkdir(configdir);
    end
    // set the configdir to environment variable,
    // so that we can use it in the get_block_config function.
    setenv('CONFIG_DIR', configdir);
    // go through the diagram file, and generate the block config file
    scs_m = xcosDiagramToScilab(fn);
    n_objs = length(scs_m.objs);
    for i = 1:n_objs
        obj = scs_m.objs(i);
        if typeof(obj) == 'Block' then
            if get_block_tag(obj) == 'SPLIT_f' then
                // ignore the SPLIT_f block
                continue;
            end
            gen_block_config(configdir, obj);
        end
    end
endfunction