// This function search for where the split block is connected from
function [src_blk_obj, src_port_num] = search_for_real_src_blk(blk_objs, split_blk_id)
    // Note: the blk_objs contains all of the objs, including link objs.
    n_objs = length(scs_m.objs);
    for i = 1:n_objs
        obj = blk_objs(i);
        // check the obj type
        // we only need to take a look at the link objs
        if typeof(obj) == 'Link'
            // check the to field
            if obj.to(1) == split_blk_id then
                // get the src blk
                src_blk_id = obj.from(1);
                src_blk_obj = blk_objs(src_blk_id);
                src_port_num = obj.from(2);
                // TODO: use a struct to return the info
                // if we find another SPLIT_f obj, we need to a deeper search
                tag = get_block_tag(src_blk_obj);
                if tag == 'SPLIT_f'
                    [src_blk_obj, src_port_num] = search_for_real_src_blk(blk_objs, src_blk_id);
                end
                return;
            end
        end
    end
endfunction