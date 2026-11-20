/* call the mask function to change the block parameters */
function [target] = run_mask(obj)
    mlib_devel_path = getenv('MLIB_DEVEL_PATH');
    uid = gen_uid(obj);
    btype = get_block_type(obj);
    mask = sprintf("%s/scilab_library/block_guis/casper_%s/%s/mask.py", mlib_devel_path, btype, obj.gui);
    debug_info('mask: ' + mask);
    template = sprintf("%s/scilab_library/scilab_blocks/casper_%s/%s.json", mlib_devel_path, btype, obj.gui);
    debug_info('template: ' + template);
    tmpdir = getenv('BCONFIG_TMPDIR', '/tmp/casper_bconfigs');
    target = sprintf("%s/%s.json", tmpdir, uid);
    python = getenv('PYTHON_GUI', 'python');
    cmd = sprintf("%s %s --template %s --target %s --log %s", python, mask, template, target, tmpdir);
    debug_info('cmd: ' + cmd);
    unix_w(cmd);
endfunction