/*
checks that don't depend on jasper.json existing yet -- these run
before collect_block_info(fn) is called:
1. the filename has to be a valid, absolute path to an existing file.
2. the design has to contain a platform block.
3. no two blocks in the design share the same name.
See post_validate_design.sci for checks that run after collect_block_info.
*/
function [validation] = pre_validate_design(fn)
    /* check the filename before touching the diagram at all -- an */
    /* invalid path (e.g. one using '~' or a relative path) can make */
    /* xcosDiagramToScilab and later file I/O fail confusingly, or */
    /* even silently write bconfig files to the wrong place. */
    filename_msg = check_valid_filename(fn);
    if filename_msg <> '' then
        validation = ascii(10) + '**************Validation Failed**************';
        validation = validation + ascii(10) + filename_msg;
        validation = validation + ascii(10) + '*********************************************';
        validation = validation + ascii(10);
        return;
    end
    /* load the diagram file */
    scs_m = xcosDiagramToScilab(fn);
    /* get the number of objs */
    n_objs = length(scs_m.objs);
    /* check if one platform block is in the design. */
    nxsg = 0;
    for i = 1:n_objs
        obj = scs_m.objs(i);
        /* if it's a block, get the block info */
        if typeof(obj) == 'Block' then
            tag = get_block_tag(obj);
            btype = get_block_type(obj);
            /* if it's a split_f block, we don't need to get the info */
            if tag == 'SPLIT_f' then
                continue;
            end
            tmp = obj.graphics.exprs(3);
            xsg = strsplit(tmp, ':')($);
            if xsg == 'xsg' then
                nxsg = nxsg + 1;
            end
        end
    end
    /* check if any two blocks in the design share the same name. */
    dup_msg = check_duplicate_names(fn);

    if nxsg == 1 & dup_msg == '' then
        validation = 'ok';
    else
        validation = ascii(10) + '**************Validation Failed**************';
        if nxsg <> 1 then
            validation = validation + ascii(10) + 'Please use a platform block in the design.';
            validation = validation + ascii(10) + '*********************************************';
        end
        if dup_msg <> '' then
            validation = validation + ascii(10) + dup_msg;
            validation = validation + ascii(10) + '*********************************************';
        end
        validation = validation + ascii(10);
    end
endfunction