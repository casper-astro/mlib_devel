/* copy default bconfig files */
function [] = copy_default_bconfig(obj, dstdir)
    mlib_devel_path = getenv("MLIB_DEVEL_PATH");
    btype = get_block_type(obj);
    tag = get_block_tag(obj);
    default_bconfig = sprintf();
endfunction