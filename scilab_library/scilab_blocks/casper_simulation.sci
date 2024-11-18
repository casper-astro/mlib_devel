function [cmd] = casper_simulation(fn)
    [path, name, ext] = fileparts(fn);
    // set the model path
    modelpath = fn;
    // run collect_block_info to generate jasper.json
    collect_block_info(fn);
    // create the cmd for the IP core generation
    // we also need to create an IP core project for simulation.
    // If the project already exists, we will skip this step.
    python_path = 'python';
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/scilab_library/gen_dsp_ip.py'];
    cmd = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath;
    // TODO: we may need to build the dsp project every time, as users may upate their design.
    if isdir(path+name+'/dspproj') == %F then
        unix_s(cmd);
    end

    // run python script to start simulation
    jasper_python = [getenv('MLIB_DEVEL_PATH')+'/scilab_library/casper_simulation.py'];
    cmd = python_path + ' ' + jasper_python + ' '+ '-m ' + modelpath;
    debug_info('Simulation python script: ' + cmd);
endfunction