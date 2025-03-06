// This function checks if the block names in the given file are unique.
function [duplicated, duplicated_blocks] = check_block_names(fn)
    // load the diagram file
    scs_m = xcosDiagramToScilab(fn);
    // get the number of objs
    n_objs = length(scs_m.objs);
    blk_names = struct();
    duplicated = 0;
    for i = 1:n_objs
        obj = scs_m.objs(i);
        if typeof(obj) == 'Block' then
            tag = get_block_tag(obj);
            type = get_block_type(obj);
            name = get_block_name(obj);
            // if it's a split_f block, we don't need to get the info
            if tag == 'SPLIT_f' then
                continue;
            end
            if isKeyInStruct(blk_names, name) then
                duplicated = 1;
                blk_names(name) = blk_names(name) + 1;
            else
                blk_names(name) = 1;
            end
        end
    end
    if duplicated then
        duplicated_blocks = get_duplicated_block_names(blk_names);
    else
        duplicated_blocks = struct();
    end
endfunction

// This function checks if the given key exists in the given struct.
function [exists] = isKeyInStruct(s, key)
    exists = 0; 
    // get all of the keys
    keys = fieldnames(s);
    if size(keys)(1) == 0 then
        return;
    end
    // go through all of the keys
    for i = 1:size(keys)(1)
        if keys(i) == key
            exists = 1;
            break;
        end
    end
endfunction

// get the duplicated block names.
function [duplicated_blocks] = get_duplicated_block_names(s)
    duplicated_blocks = struct();
    keys = fieldnames(s);
    for i = 1:size(keys)(1)
        if s(keys(i)) > 1 then
            duplicated_blocks(keys(i)) = s(keys(i));
        end
    end
endfunction
