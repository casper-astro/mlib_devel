function [build_cmd] = jasper_frontend(fn)
    // check the block names
    [duplicated, duplicated_blocks] = check_block_names(fn);
    if duplicated then
        disp('****************************************')
        disp('*  The following blocks are duplicated *')
        disp('****************************************')
        keys = fieldnames(duplicated_blocks);
        for i = 1:size(keys)(1)
            disp(keys(i) + ' : ' + string(duplicated_blocks(keys(i))));
        end
        build_cmd = struct();
        return;
    end
    // create a dir for the project
    [path, name, ext] = fileparts(fn);
    // disp some info
    disp('Starting jasper for model: '+ name);

    // set the modelpath
    modelpath = fn;

    // generate the block config files first
    gen_all_blocks_config(fn);
    
    // collect the block info, and generate the jasper.json file
    collect_block_info(fn);
    
    // execute a python script to read the json file and generate jasper.per and jasper.dsp
    python_path = 'python';
    disp('****************************************');
    disp('*  Frontend python script is running...*');
    scilab_library_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library';
    cmd = scilab_library_path+'/jasper_frontend.py' + ' ' + '-m ' + modelpath
    debug_info('Frontend python script: ' + cmd);
    // unix_s(cmd);
    unix_w(cmd);
    disp('*  Frontend python script complete!    *');
    disp('****************************************');
    build_cmd = struct();
    // create a build_cmd for the dsp project
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/scilab_library/gen_dsp_ip.py'];
    build_cmd('dsp') = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath;
    // create a build_cmd for the full project
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/jasper_library/exec_flow.py'];
    build_cmd('full') = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath + ' --middleware --backend --software --vitis';

endfunction