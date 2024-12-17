// get the port width id from the block's model.in2/out2 field
// we will use this id to get the real width from the config file.
// TODO: we may need to store the id in other fileds.
function [width_id] = get_port_width_id(obj, port_type)
    if port_type == 'in' then
        width_id = obj.model.in2';
    else
        width_id = obj.model.out2';
    end
endfunction