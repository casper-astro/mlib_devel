/* go through the xcos file, and check the uids */
function [] = get_blocks_by_uids(fn)
    [path, projname, ext] = fileparts(fn);
    builddir = sprintf("%s/%s/bconfigs", path, projname);
    if ~isdir(builddir) then
        mkdir(builddir);
    else 
        // delete the builddir with old bconfigs
        rmdir(builddir, 's');
        mkdir(builddir);
    end
    tmpdir = getenv('BCONFIG_TMPDIR', '/tmp/casper_bconfigs');
    scs_m = xcosDiagramToScilab(fn);
    n_objs = length(scs_m.objs);
    for i = 1:n_objs
        obj = scs_m.objs(i);
        uid = gen_uid(obj);
        tag = get_block_tag(obj);
        if typeof(obj) == 'Block' then
            if tag == 'SPLIT_f' then
                continue;
            end
            blkname = gen_block_name(builddir, obj);
            uid = gen_uid(obj);
            /* copy the specific bconfig from tmpdir to builddir */
            srcfn = sprintf("%s/%s.json", tmpdir, uid);
            dstfn = sprintf("%s/%s.json", builddir, blkname);
            /* if the srcfn exists, it means the configuraion GUI was called. */
            if isfile(blistfn) then
                /* force copy */
                copyfile(srcfn, dstfn); 
            else
                /* use the default config file */
                
            end
            /* update name and fullpath */
            update_bconfig(dstfn, 'name', blkname);
            update_bconfig(dstfn, 'fullpath', projname + '/' + blkname);
        end
    end
endfunction