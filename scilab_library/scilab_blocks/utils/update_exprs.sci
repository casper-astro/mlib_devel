/* update the parameters */
function [obj] = update_exprs(obj, bconfigfn)
    mlib_devel_path = getenv("MLIB_DEVEL_PATH");
    btype = get_block_type(obj);
    tag = get_block_tag(obj);
    defbconfigfn = sprintf("%s/scilab_library/scilab_blocks/casper_%s/%s.json", ...
                        mlib_devel_path, btype, tag);
    /* get keys from the default bconfig file */
    defbconfig = fromJSON(defbconfigfn, 'file');
    keys = defbconfig('parameters')('keys');
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    exprs = [];
    for i = 1:size(keys)(2)
        k = keys(i);
        debug_info('updating key: ' + k + ' ' + 'val: ' + string(p(k)));
        exprs = [exprs, string(p(k))];
    end
    obj.graphics.exprs = exprs';
endfunction