function git_info_struct = git_info(sysname)

git_info_struct = -1;

% do linux check
[status, ~] = system('uname');
if status ~= 0,
    warning('git_info only supported in Linux.');
    return;
end

% do git check
[status, ~] = system('git');
if status ~= 1,
    warning('git not found.');
    return;
end

% get the full path of the current system
path_and_filename = get_param(sysname, 'filename');
slashindexes = strfind(path_and_filename, '/');
fpath = path_and_filename(1:slashindexes(end)-1);
fname = path_and_filename(slashindexes(end)+1:end);
original_path = pwd;
cd(fpath);

% last commit hash
[status, result] = system(sprintf('git log -n 1 -- %s | more', fname));
if isempty(result) || (status ~= 0),
    cd(original_path);
    warning('Could not execute git log command - problems.');
    return;
end
git_commit_hash = result(strfind(result, 'commit') + 7 : strfind(result, 'Author') - 2);
if length(git_commit_hash) ~= 40,
    cd(original_path);
    warning('Git commit hash is an odd length. Expected 40, got %i.', length(git_commit_hash));
    return;
end

% status
[status, result] = system(sprintf('git status --porcelain -- %s | more', fname));
if status ~= 0,
    cd(original_path);
    warning('Could not execute git status command - problems.');
    return;
end
git_status = result(1:end-1);
if isempty(git_status),
    git_status = 'unmodified';
end

% config
[status, result] = system('git config -l');
if status ~= 0,
    cd(original_path);
    warning('Could not execute git config command - problems.');
    return;
end
toks = textscan(result, '%s', 'Delimiter', '\n');

% make the return structure
git_info_struct.commit_hash = git_commit_hash;
git_info_struct.status = git_status;
git_info_struct.config = toks{1};

cd(original_path);

end
% end
