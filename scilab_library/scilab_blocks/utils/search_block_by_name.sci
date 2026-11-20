// This function search for the block in a xcos design by name
function [index] = search_block_by_name(fn, blkname)
    // if the block is not found, return the index = -1.
    index = -1;
    // get the blocks from the design file
    scs_m = xcosDiagramToScilab(fn);
    // go through all of the blocks, and search for block by name
    n_objs = length(scs_m.objs);
    for i = 1:n_objs
        obj = scs_m.objs(i);
        if typeof(obj) == 'Block' then
            if obj.graphics.exprs(1) == blkname then
                index = i;
                break;
            end
        end
    end
endfunction