// this function returns the port witdh of the block
function [src_tag, dst_tag] = check_block_type(blk_objs, link_obj)
    // the obj tag is set in the id field.
    obj_from_id = link_obj.from(1);
    obj_from = blk_objs(obj_from_id);
    obj_to_id = link_obj.to(1);
    obj_to = blk_objs(obj_to_id);
    src_tag = obj_from.graphics.id;
    dst_tag = obj_to.graphics.id;
    
endfunction