function git_write_info(fid, sysname)
    [result, gitstruct] = git_info(sysname);
    
    if result >= 0,
        fprintf(fid, '%s', gitstruct.sys_info);
        fprintf(fid, '%s', gitstruct.mlib_info);
    else
        fprintf(fid, '?meta 77777_git rcs %s\n', gitstruct.error_str);
    end
end
