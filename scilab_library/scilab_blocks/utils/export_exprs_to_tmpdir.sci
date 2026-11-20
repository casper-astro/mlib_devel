/* export parameters to tmpdir */
function [] = export_exprs_to_tmpdir(obj)
    tmpdir = getenv('BCONFIG_TMPDIR', '/tmp/casper_bconfigs');
    uid = gen_uid(obj);
    tmpfn = sprintf("%s/%s.json", tmpdir, uid);
    debug_info('export exprs to: ' + tmpfn);
    export_exprs(obj, tmpfn);
endfunction