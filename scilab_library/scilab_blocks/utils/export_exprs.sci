/* export the block parameters to tmpdir/uid.json */
function [] = export_exprs(obj, targetfn)
    mlib_devel_path = getenv("MLIB_DEVEL_PATH");
    btype = get_block_type(obj);
    tag = get_block_tag(obj);
    defbconfigfn = sprintf("%s/scilab_library/scilab_blocks/casper_%s/%s.json", ...
                        mlib_devel_path, btype, tag);
    debug_info('Default bconfig: ' + defbconfigfn);
    st = struct();
    st('parameters') = struct();
    /* get keys from the default bconfig file */
    defbconfig = fromJSON(defbconfigfn, 'file');
    keys = defbconfig('parameters')('keys');
    defvals = defbconfig('parameters')('values');
    vals = obj.graphics.exprs;
    if typeof(vals) == 'list' then
        nvals = size(vals);
    else
        nvals = size(vals, '*');
    end
    for i = 1:size(keys)(2)
        k = keys(i);
        if i <= nvals then
            v = vals(i);
        else
            // a parameter added to the template after this block was
            // saved: use its default value
            v = defvals(i);
        end
        st('parameters')(k) = v;
    end
    /* check if the target dir exists. */
    /* if not, create it */
    [fpath, name, ext] = fileparts(targetfn);
    if ~isdir(fpath) then
        mkdir(fpath);
    end
    toJSON(st, targetfn, 4);
endfunction