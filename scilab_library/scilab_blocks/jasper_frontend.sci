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
    // collect the block info, and generate the json file
    collect_block_info(fn);
    // BUG: this looks like a bug in scilab
    // not sure why we have to clear the variables
    // if we don't do it, the python script will not work...
    // execute a python script to read the json file and generate jasper.per
    python_path = 'python';
    disp('****************************************');
    disp('*  Frontend python script is running...*');
    scilab_library_path = getenv('MLIB_DEVEL_PATH')+'/scilab_library';
    //unix_s(scilab_library_path+'/jasper_frontend.py' + ' ' + '-m ' + modelpath);
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