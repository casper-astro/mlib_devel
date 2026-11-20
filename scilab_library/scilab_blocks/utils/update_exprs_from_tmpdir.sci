/* update parameters from the bconfig in tmpdir */
function [obj] = update_exprs_from_tmpdir(obj)
    tmpdir = getenv('BCONFIG_TMPDIR', '/tmp/casper_bconfigs');
    uid = gen_uid(obj);
    tmpfn = sprintf("%s/%s.json", tmpdir, uid);
    debug_info('update exprs from: ' + tmpfn);
    obj = update_exprs(obj, tmpfn); 
endfunction