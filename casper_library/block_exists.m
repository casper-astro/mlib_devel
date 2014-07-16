function result = block_exists(block)
try
    [parent_sys, block_name] = fileparts(block);

    % Consider block diagram root as an existing block.
    if isempty(parent_sys)
        result = strcmp(bdroot(block_name), block_name);
    else
        % Maybe someday we will want to verify that parent_sys exists,
        % but for now we don't bother doing recursive call.

        % Look for block by name in parent system
        found = find_system(parent_sys, ...
            'FollowLinks', 'on', ...
            'LookUnderMasks', 'all', ...
            'Name', block_name);

        % Return true if found is not empty
        result = ~isempty(found);
    end
catch ex
    dump_and_rethrow(ex);
end
end
