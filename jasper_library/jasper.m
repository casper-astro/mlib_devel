function [] = jasper(model)

if nargin > 0    
    load_system(model);
end

sys = gcs;

modelpath = get_param(sys, 'filename');

[modeldir, modelname, ~] = fileparts(modelpath);
builddir = [modeldir '/' modelname];

fprintf('Starting jasper for model: %s\n', modelname);
fprintf('Build directory: %s\n', builddir);

if exist(builddir, 'dir') ~= 7
    mkdir(modeldir, modelname);
end

disp('Updating diagram'); 
set_param(sys, 'SimulationCommand', 'update');

% look for clashing HMC mezzanine settings
disp('Checking HMC block clashes');
hmcs = find_system(gcs, 'SearchDepth', 10, 'FollowLinks', 'on', 'LookUnderMasks', 'all', 'Tag', 'xps:hmc');
if length(hmcs) > 1
    mezs = ones(1, length(hmcs)) * -1;
    mezs(1) = str2double(get_param(hmcs{1}, 'mez'));
    for ctr = 2 : length(hmcs)
        new_mez = str2double(get_param(hmcs{ctr}, 'mez'));
        if ~isempty(find(mezs == new_mez, 1))
            for ctr2 = 1 : length(hmcs)
                mez = str2double(get_param(hmcs{ctr2}, 'mez'));
                fprintf('%s: slot %i\n', hmcs{ctr2}, mez);
            end
            error('Two or more HMC blocks are set to use the same mezzanine slot.');
        end
        mezs(ctr) = new_mez;
    end
end

disp('Generating peripherals file');
gen_block_file(builddir, [builddir '/jasper.per'])

% Generate the design_info.tab file, which is used to populate the fpg 
% header file
mssge.xps_path = builddir;
gen_xps_add_design_info(sys, mssge, '/');

% read the git repo info and write this information to "git_info.tab" for
% the fpg file header
gitinfo_id=fopen([builddir '/git_info.tab'], 'w');
git_write_info(gitinfo_id, sys);
fclose(gitinfo_id);

jasper_python = [getenv('MLIB_DEVEL_PATH') '/jasper_library/exec_flow.py'];

% run the jasper flow but skip
% 1) peripheral file generation (this script does this already)
% 2) design_info.tab file generation (this script does this already)
% 3) git_info.tab file generation (this script does this already)
% 4) frontend compile (this script starts system generator itself below)
% 5) backend compile (the user should launch this afterwards from outside
% matlab)

disp('Launching jasper flow middleware');
% rv = system([jasper_python ' -m' modelpath ' -c' builddir ' --skipyb --skipfe --skipbe']);
rv = system([jasper_python ' -m' modelpath ' -c' builddir '']);

if rv ~= 0
    fprintf('ERROR: see %s/jasper.log for details\n', builddir);
    return;
end

disp('Launching System Generator compile')
update_model = 0;
start_sysgen_compile(modelpath, builddir, update_model);

disp('Complete');
% if vivado is to be used
if getenv('USE_VIVADO_RUNTIME_FOR_MATLAB') == '1'
    fprintf('Run ''exec_flow.py -m %s --middleware --backend --software'' to finish flow\n', modelpath);
else
    fprintf('Run ''exec_flow.py -m %s --middleware --backend --software --be ise'' to finish flow\n', modelpath); 
end

% end
