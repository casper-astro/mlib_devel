// get the block name.
// TODO: we may need to store the name in other fields
function [name] = get_block_name(obj)
    name = obj.graphics.exprs(1);
end 