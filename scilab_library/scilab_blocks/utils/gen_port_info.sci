// this function generates a unique port name for a given block
function [port_info] = gen_port_info(proj_name, blk_objs, link_obj)
    // get the dst block info and src block info from the link obj
    dst_obj_id = link_obj.to(1);
    dst_port_id = link_obj.to(2);
    dst_obj = blk_objs(dst_obj_id);
    src_obj_id = link_obj.from(1);
    src_port_id = link_obj.from(2);
    src_obj = blk_objs(src_obj_id);
    // check the block type
    // the type is stored in the 'gui' field
    // TODO: we may need to store the type filed in other field
    src_obj_type = get_obj_type(src_obj);
    dst_obj_type = get_obj_type(dst_obj);
    // 
endfunction