function newname = strip_system_from_name(blockname)
    newname = regexprep(blockname, '^[^/]*/', '');
end