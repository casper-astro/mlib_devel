function [] = jasper(model)

if nargin > 0    
    load_system(model);
end

sys = gcs;

modelpath = get_param(sys, 'filename');

[modeldir, modelname, modelext] = fileparts(modelpath);
builddir = [modeldir '/' modelname];

disp(sprintf('Starting jasper for model: %s',modelname));
disp(sprintf('Build directory: %s',builddir));

mkdir(modeldir, modelname);

disp('Updating diagram'); 
set_param(sys,'SimulationCommand','update');
disp('Generating peripherals file');
gen_block_file(builddir, [builddir '/jasper.per'])

jasper_python = [getenv('MLIB_DEVEL_PATH') '/jasper_library/exec_flow.py'];

% run the jasper flow but skip
% 1) peripheral file generation (this script does this already)
% 2) frontend compile (this script starts system generator itself below)
% 3) backend compile (the user should launch this afterwards from outside
% matlab)

disp('Launching jasper flow middleware');
% rv = system([jasper_python ' -m' modelpath ' -c' builddir ' --skipyb --skipfe --skipbe']);
rv = system([jasper_python ' -m' modelpath ' -c' builddir '']);

if rv ~= 0
    disp(sprintf('ERROR: see %s/jasper.log for details', builddir));
    return;
end

disp('Launching System Generator compile')
update_model = 0;
start_sysgen_compile(modelpath, builddir, update_model);

disp('Complete');
%if vivado is to be used
if getenv('USE_VIVADO_RUNTIME_FOR_MATLAB') == '1'
    disp(sprintf('Run ''exec_flow.py -m %s --middleware --backend --software'' to finish flow', modelpath));
else
   disp(sprintf('Run ''exec_flow.py -m %s --middleware --backend --software --be ise'' to finish flow', modelpath)); 
end    