// get the val index in the config['parameter'] field from the block.
// TODO: we may store the vals in other fields.
function [val_index] = get_block_vindex(obj)
    val_index = obj.model.rpar;
endfunction