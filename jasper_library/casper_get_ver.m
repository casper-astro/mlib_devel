function casper_get_ver()

mlib_path = getenv('MLIB_DEVEL_PATH');
if isempty(mlib_path)
    disp('MLIB_DEVEL_PATH not found. Did you correctly start MATLAB using the startsg scripts?')
end

disp(['Is Linux?: ', num2str(isunix)]);
disp(['mlib_devel path: ', mlib_path]);

jasper_backend = getenv('JASPER_BACKEND');
disp(['JASPER Backend: ', jasper_backend]);

if ~strcmp(jasper_backend, 'vivado')
    sysgen_ver = xilinx.environment.getversion('sysgen');
    vivado_ver = xilinx.environment.getversion('vivado');
    disp(['System Generator Version: ', sysgen_ver]);
    disp(['Xilinx Vivado Version: ', vivado_ver]);
end

matlab_ver = ver;
disp('MATLAB Package Versions:');
for i = [1:length(ver)]
    x = matlab_ver(i);
    disp(['  ', x.Name, ': version: ', x.Version, ', release: ', x.Release, ', date: ', x.Date]);
end

currentFolder = pwd;
cd(mlib_path);
[git_err, git_describe] = system('git describe --always --dirty --tags');
if ~git_err
    disp(['mlib_devel version: ', git_describe]);
end
% cd back where we started
cd(currentFolder);

[os_ver_err, os_ver] = system('cat /etc/os-release');
if ~os_ver_err
    disp('OS version:')
    disp(os_ver);
end

end