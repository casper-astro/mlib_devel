/*
 get the block name, which is in bconfigs/block_list.json.
 Note: make sure `gen_block_name` has been called for this obj.
 */
function [name] = get_block_name(bconfigdir, obj)
    blistfn = sprintf("%s/block_list.json", bconfigdir);
    blist = fromJSON(blistfn, 'file');
    uid = gen_uid(obj);
    tag = get_block_tag(obj);
    name = blist(tag)(uid);
end 