function build_cmd = jasper_frontend(model)

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

disp('Checking HMC block sites');
hmc_blks = find_system(gcs, 'SearchDepth', 10, 'LookUnderMasks', 'all', 'Tag', 'xps:hmc');
mez_sites = get_param(hmc_blks, 'mez');
if length(mez_sites) ~= length(unique(mez_sites))
    sitestr = '';
    for ctr = 1 : length(mez_sites)
        sitestr = sprintf('%s\n\t%s - %s', sitestr, hmc_blks{ctr}, mez_sites{ctr});
    end
    error('ERROR: HMC blocks set to use same sites:\n%s', sitestr);
end

disp('Updating diagram');
set_param(sys, 'SimulationCommand', 'update');

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
rv = system(['python ' jasper_python ' -m' modelpath ' -c' builddir '']);

if rv ~= 0
    fprintf('ERROR: see %s/jasper.log for details\n', builddir);
    return;
end

disp('Launching System Generator compile');
update_model = 0;
start_sysgen_compile(modelpath, builddir, update_model);
disp('Completed sysgen okay.');

% if vivado is to be used
build_cmd = '';
if strcmp(getenv('JASPER_BACKEND'), 'vivado')
    build_cmd = ['python ' jasper_python ' -m ' modelpath ' --middleware --backend --software'];
elseif strcmp(getenv('JASPER_BACKEND'), 'ise')
    build_cmd = ['python ' jasper_python ' -m ' modelpath ' --middleware --backend --software --be ise'];
end

% end
