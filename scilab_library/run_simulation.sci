// This function is just a wrapper around casper_simulation.
// The reason is we can't run unix_s in casper_simulation.sci directly.
// Not sure why.
function [] = run_simulation(fn)
    [path, name, ext] = fileparts(fn);
    // disp some info
    disp('Starting simulation for model: '+ name);
    cmd = casper_simulation(fn);
    unix_w(cmd);
    disp('Simulation finished for model: '+ name);
endfunction