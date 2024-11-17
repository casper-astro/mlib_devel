// this function gets the src and dst block info from the link obj.
// we start from the src obj, and see if it's a SPLIT_f obj.
// if so, we will skip this obj, and connect the dst obj to the real src obj.
function [link] = get_link_info_by_link_obj(blk_objs, link_obj)
    // get the dst block info and src block info from the link obj
    dst_obj_id = link_obj.to(1);
    dst_port_id = link_obj.to(2);
    dst_obj = blk_objs(dst_obj_id);
    src_obj_id = link_obj.from(1);
    src_port_id = link_obj.from(2);
    src_obj = blk_objs(src_obj_id);
    // check the block tag
    src_obj_tag = get_block_tag(src_obj);
    dst_obj_tag = get_block_tag(dst_obj);
    // it's impossible that both of the src and dst are SPLIT_f obj,
    // so we only need to check one of them.
    // Here, we check the src obj.
    if src_obj_tag == 'SPLIT_f' then
        // update the src obj with the real src obj
        [src_obj, src_port_id] = search_for_real_src_blk(blk_objs, src_obj_id);
    end
    if dst_obj_tag == 'SPLIT_f' then
        // if dst obj is a SPLIT_f obj, we don't care about it.
        // this case will be handled, when the src obj is a SPLIT_f obj.
        link = 'skip';
        return;
    end
    // get the src and dst block names
    link = struct();
    link('src_obj') = src_obj;
    link('src_port_id') = src_port_id;
    link('dst_obj') = dst_obj;
    link('dst_port_id') = dst_port_id;
endfunction