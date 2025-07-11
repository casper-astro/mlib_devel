// This function is just a wrapper around casper_simulation.
// The reason is we can't run unix_s in casper_simulation.sci directly.
// Not sure why.
function [] = jasper_simulation(fn, gui, use_vivado)
    arguments
        // default fn doesn't mean anything.
        fn string = 'casper.zcos'
        gui string = 'pyplot'
        use_vivado string = 'True'
    end
    [path, name, ext] = fileparts(fn);
    // generate config files
    gen_all_blocks_config(fn);
    // disp some info
    disp('Starting simulation for model: '+ name);
    cmd = run_simulation(fn, gui, use_vivado);
    debug_info('Simulation command: ' + cmd);
    unix_w(cmd);
    disp('Simulation finished for model: '+ name);
    // let the users know where to find the simulation data
    if gui == 'raw'then
        filepath = path + '/' + name + '/simulation/' + 'casper_simulation.json.' 
        disp('****************************************');
        disp('The simulation data has been written into ' + filepath)
        disp('****************************************');
    end
endfunction