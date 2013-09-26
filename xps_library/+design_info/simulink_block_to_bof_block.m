function newname = simulink_block_to_bof_block(blockname)
    newname = strrep(regexprep(blockname, '^[^/]*/', ''), '/', '_');
end