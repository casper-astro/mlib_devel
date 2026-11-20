/* generate the block name automatically */
/* store the name in a json file under builddir */
function [name] = gen_block_name(bconfigdir, obj)
    blistfn = sprintf("%s/block_list.json", bconfigdir);
    // check if block list exists
    if isfile(blistfn) then
        blist = fromJSON(blistfn, 'file');
    else
        blist = struct();
    end
    // check if the key exists
    tag = get_block_tag(obj);
    if isfield(blist, tag) then
        nobjs = blist(tag)('nobjs');
    else
        blist(tag) = struct();
        nobjs = 0;
    end
    // let's create the block name!
    uid = gen_uid(obj);
    if ~isfield(blist(tag), uid) then
        /* 
        if the block uid is not in the block list,
        add the name for the block.
        the name is from the block itself, and it's set by the users.
        */
        name = obj.graphics.exprs(1);
        nobjs = nobjs + 1;
        // write the info back to the blist
        blist(tag)('nobjs') = nobjs;
        blist(tag)(uid) = name;
        toJSON(blist, blistfn, 4);
    else
        /* 
        if the uid exists in the block list,
        get the name directly.
        */
        name = blist(tag)(uid);
    end
    debug_info('New Block Collected: ' + name);
endfunction