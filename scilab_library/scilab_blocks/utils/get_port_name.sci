// we get the port name from the block's graphics.in_label or graphics.out_label
function [port_name] = get_port_name(obj, port_id, port_type)
    if port_type == 'in' then
        label_list = obj.graphics.in_label;
        // if we don't specify the label, we use 'in' as the default label
        // size(label_list) returns '1 1', even though the list is empty,
        // so we just check length here.
        if length(label_list) > 0 then
            port_name = label_list(port_id);
        else
            port_name = 'in';
        end
    else
        label_list = obj.graphics.out_label;
        // if we don't specify the label, we use 'in' as the default label
        if length(label_list) > 0 then
            port_name = obj.graphics.out_label(port_id);
        else
            port_name = 'out';
        end
    end
endfunction