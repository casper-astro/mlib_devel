// get the block type from the block object
// TODO: we may need to store the tag in other fields
function [type] = get_block_tag(obj)
    type = obj.gui;
endfunction