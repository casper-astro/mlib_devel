// get the block type.
// we have three types of blocks: xps, dsp, sim
// TODO: we may need to store the type in other fields
function [type] = get_block_tag(obj)
    type = obj.model.label;
endfunction