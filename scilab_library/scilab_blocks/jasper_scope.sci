/*
jasper_scope opens the data of the last simulation of a design in the scope
GUI (sim_guis/sim_scope.py), without running the simulation again:
    jasper_scope('/path/to/design.zcos')
reads <design dir>/<design>/simulation/casper_simulation.json, which
jasper_simulation writes.
*/
function [] = jasper_scope(fn)
    [path, name, ext] = fileparts(fn);
    simdir = path + '/' + name + '/simulation';
    datafn = simdir + '/casper_simulation.json';
    if ~isdir(simdir) | ~isfile(datafn) then
        disp('****************************************');
        disp('No simulation data found: ' + datafn);
        disp('Please run jasper_simulation(''' + fn + ''') first.');
        disp('****************************************');
        return
    end
    python = getenv('PYTHON_GUI', 'python');
    script = getenv('MLIB_DEVEL_PATH') + '/scilab_library/sim_guis/sim_scope.py';
    // run it in the background, so Scilab stays usable while the GUI is open
    cmd = python + ' ""' + script + '"" -f ""' + datafn + '"" &';
    debug_info('Scope command: ' + cmd);
    unix_s(cmd);
    disp('Opening the simulation data of ' + name + ' in the scope GUI: ' + datafn);
endfunction
