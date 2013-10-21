function infoblocks = sblock_to_info(block)
    clog('entering sblock_to_info','trace');
    tag = get_param(block, 'Tag');
    if numel(tag) == 0,
        error('sblock_to_info_nodes called on block without tag... not good.');
    end
    maskparms = get_param(block, 'MaskNames');
    for ctr = numel(maskparms) : -1 : 1,
        parm = maskparms{ctr};
        value = get_param(block, parm);
        if isnumeric(value),
            value = num2str(value);
        end
        infoblock = design_info.InfoBlock(lower(parm), value, block, tag);
        infoblocks(ctr) = infoblock;
    end
    clog('exiting sblock_to_info','trace');
end