// get port width
// TODO: we may need to store the port width in other fields
function [width] = get_port_width(st, obj, width_id, width_default)
    // if the width_id is -1, it means we will use the defalut width.
    if width_id == -1 then
        width = string(width_default);
        return;
    end
    // get the block name, type and tag
    type = get_block_type(obj);
    tag = get_block_tag(obj);
    name = get_block_name(obj);
    // open the template, and get the key for the bit width
    template = get_block_template(type, tag);
    key = template('parameters')('keys')(width_id + 1);
    // get the width from st
    blks_st = st(type+'_blocks');
    for i = 1:length(blks_st)
        if blks_st(i)('name') == name then
            width = blks_st(i)(key);
            break;
        end
    end
endfunction