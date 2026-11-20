function [build_cmd] = jasper_frontend(fn)
    /* validate the design */
    validation = pre_validate_design(fn);
    if validation ~= 'ok' then
        disp(validation);
        build_cmd = struct();
        return;
    end
    /* get path, name and ext */
    [path, name, ext] = fileparts(fn);
    
    /* disp some info */
    disp('Starting jasper for model: '+ name);

    /* set the modelpath */
    modelpath = fn;
    
    /* bconfig tmp dir needs to be removed. */
    /* in case more and more tmp files are created. */
    remove_tmpdir();
    
    /* collect the block info, and generate the jasper.json file */
    collect_block_info(fn);

    /* validate the collected design (checks that need jasper.json) */
    validation = post_validate_design(fn);
    if validation ~= 'ok' then
        disp(validation);
        build_cmd = struct();
        return;
    end

    /* execute a python script to read the json file and generate jasper.per and jasper.dsp */
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
    /* create a build_cmd for the dsp project */
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/scilab_library/gen_dsp_ip.py'];
    build_cmd('dsp') = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath;
    /* create a build_cmd for the full project */
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/jasper_library/exec_flow.py'];
    build_cmd('full') = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath + ' --middleware --backend --software --vitis';

endfunction