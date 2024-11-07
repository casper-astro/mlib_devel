// This function is just a wrapper around casper_simulation.
// The reason is we can't run unix_s in casper_simulation.sci directly.
// Not sure why.
function [] = run_simulation(fn)
    cmd = casper_simulation(fn);
    disp(cmd);
    unix_w(cmd);
endfunction