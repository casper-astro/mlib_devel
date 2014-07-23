function [] = jasper(model)

if nargin > 0    
    load_system(model);
end

modelpath = get_param(gcs, 'filename');
[modeldir, modelname, modelext] = fileparts(modelpath);

disp(sprintf('Starting jasper for model: %s',modelname));

mkdir(modeldir, modelname);

builddir = [modeldir '/' modelname];


gen_block_file(builddir, [builddir '/jasper.per'])

disp('Generating peripherals file');
jasper_python = [getenv('MLIB_DEVEL_PATH') '/jasper_library/exec_flow.py'];

% run the jasper flow but skip
% 1) peripheral file generation (this script does this already)
% 2) frontend compile (this script starts system generator itself below)
% 3) backend compile (the user should launch this afterwards from outside
% matlab)

disp('Launching jasper flow middleware');
rv = system([jasper_python ' -m' modelpath ' -c' builddir ' --skipyb --skipfe --skipbe']);

if rv ~= 0
    disp(sprintf('ERROR: see %s/jasper.log for details', builddir));
    return;
end

disp('Launching System Generator compile')
update_model = 1;
start_sysgen_compile(modelpath, builddir, update_model);

disp('Complete');
disp(sprintf('Run ''exec_flow.py -m %s --skipyb --skipfe'' to finish flow', modelpath));