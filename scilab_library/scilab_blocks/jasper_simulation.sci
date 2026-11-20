/* 
jasper_simulation is used for running simulation.
*/
function [] = jasper_simulation(fn, gui, use_vivado)
    arguments
        /* default fn doesn't mean anything. */
        fn string = 'casper.zcos'
        gui string = 'pyplot'
        use_vivado string = 'True'
    end

    [path, name, ext] = fileparts(fn);
    
    /* generate bconfig files. */
    collect_block_info(fn);

    /* disp some info */
    disp('Starting simulation for model: '+ name);
    cmd = run_simulation(fn, gui, use_vivado);
    debug_info('Simulation command: ' + cmd);
    unix_w(cmd);
    disp('Simulation finished for model: '+ name);
    /* let the users know where to find the simulation data */
    if gui == 'raw'then
        filepath = path + '/' + name + '/simulation/' + 'casper_simulation.json.' 
        disp('****************************************');
        disp('The simulation data has been written into ' + filepath)
        disp('****************************************');
    end
endfunction