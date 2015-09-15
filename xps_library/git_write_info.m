function git_write_info(fid, git_struct)
    if isstruct(git_struct),
        fprintf(fid, '?meta 77777_git rcs git_info_found 1\n');
        fprintf(fid, '?meta 77777_git rcs commit_hash %s\n', git_struct.commit_hash);
        git_struct.status = strrep(git_struct.status, ' ', '\_');
        fprintf(fid, '?meta 77777_git rcs status %s\n', git_struct.status);
        for git_cfg_ctr = 1 : numel(git_struct.config),
            git_cfg_string = git_struct.config{git_cfg_ctr};
            gcs_split = textscan(git_cfg_string, '%s%s', 'Delimiter', '=');
            param_str = char(gcs_split{1});
            value_str = char(gcs_split{2});
            param_str = strrep(param_str, ' ', '\_');
            value_str = strrep(value_str, ' ', '\_');
            fprintf(fid, '?meta 77777_git rcs %s %s\n', param_str, value_str);
        end
    else
        fprintf(fid, '?meta 77777_git rcs git_info_found 0\n');
    end
end
