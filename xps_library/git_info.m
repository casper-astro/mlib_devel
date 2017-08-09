function [git_result, git_info_struct] = git_info(sysname)

git_info_struct = struct();

% do linux check
[status, ~] = system('uname');
if status ~= 0
    warning('git_info only supported in Linux.');
    git_info_struct.error_str = 'git_info\_only\_supported\_in\_Linux.';
    git_result = -1;
    return;
end

% do git check
[status, ~] = system('which git');
if status ~= 0
    warning('git not found.');
    git_info_struct.error_str = 'git\_not\_found';
    git_result = -2;
    return;
end

% do python check
[status, ~] = system('which python2');
if status ~= 0
    warning('python2 not found.');
    git_info_struct.error_str = 'python2\_not\_found';
    git_result = -3;
    return;
end

python_script = [getenv('MLIB_DEVEL_PATH'), '/xps_library/get_git_info.py'];
if exist(python_script, 'file') ~= 2
    warning('python get_git_info.py script not found.');
    git_info_struct.error_str = 'python\_script\_get_git_info.py\_not\_found';
    git_result = -4;
    return;
end

% get the full path of the current system
path_and_filename = get_param(sysname, 'filename');

% get the git info for the system slx file
[status, result] = system(['python ', python_script,' --fpgstring --katversion ', path_and_filename]);
if status ~= 0
    [status, result] = system(['python ', python_script,' --fpgstring ', path_and_filename]);
    if status ~= 0
        warning(['Could not get GIT info for system: ', path_and_filename]);
        result = ['#giterror: could not get GIT info for system "', sysname,'": ', path_and_filename, '\n'];
    end
end
git_info_struct.sys_info = result;

% get the git info for the casper library
[status, result] = system(['python ', python_script,' --fpgstring --katversion ', getenv('MLIB_DEVEL_PATH')]);
if status ~= 0
    [status, result] = system(['python ', python_script,' --fpgstring ', getenv('MLIB_DEVEL_PATH')]);
    if status ~= 0
        warning(['Could not get GIT info for mlib_devel: ', getenv('MLIB_DEVEL_PATH')]);
        result = ['#giterror: Could not get GIT info for mlib_devel: ', getenv('MLIB_DEVEL_PATH'), '\n'];
    end
end
git_info_struct.mlib_info = result;

git_result = 0;

end
% end
