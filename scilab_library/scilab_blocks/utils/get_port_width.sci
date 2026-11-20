// in scilab-v.0.0.5 or later, we put the port width in model.in2/out2 directly.

function [width] = get_port_width(obj, port_id, port_type)
    // get the block name, type and tag
    type = get_block_type(obj);
    tag = get_block_tag(obj);
    // get the port width from the block's model.in2/out2 field
    if port_type == 'in' then
        all_port_width = obj.model.in2';
    else
        all_port_width = obj.model.out2';
    end
    width = all_port_width(port_id);
endfunction