/* get the init paramters from the default bconfig file */
function [obj] = init_exprs(obj)
    mlib_devel_path = getenv("MLIB_DEVEL_PATH");
    btype = get_block_type(obj);
    tag = get_block_tag(obj);
    bconfigfn = sprintf("%s/scilab_library/scilab_blocks/casper_%s/%s.json", ...
                        mlib_devel_path, btype, tag);
    bconfig = fromJSON(bconfigfn, 'file');
    exprs = bconfig('parameters')('values')
    obj.graphics.exprs = exprs;
endfunction