function node = sblock_to_xml(xml_dom, block)
    clog('entering sblock_to_xml','trace');
    tag = get_param(block, 'Tag');
    if numel(tag) == 0,
        error('sblock_to_xml called on block without tag... not good.');
    end
    blockname =  design_info.simulink_block_to_bof_block(block);
    node = xml_dom.createElement(blockname);
    maskparms = get_param(block, 'MaskNames');
    for ctr = 1 : numel(maskparms),
        parm = maskparms{ctr};
        value = get_param(block, parm);
        if isnumeric(value),
            value = num2str(value);
        end
        node.setAttribute(lower(maskparms(ctr)), value);
    end
    clog('exiting sblock_to_xml','trace');
end