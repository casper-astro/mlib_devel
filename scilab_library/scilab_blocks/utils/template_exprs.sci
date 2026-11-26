/* return the block's graphics.exprs as a column of strings, in the order
   of the keys of its parameter template casper_<type>/<tag>.json (name,
   fullpath, tag, then the block's own parameters), which is the order
   export_exprs uses to write them out.
   init_exprs stores the template values as a list; an exprs saved before
   the template layout has no fullpath and tag, so those two are filled in
   from the template, and parameters missing at the end (added to the
   template later) get their template default. */
function [exprs] = template_exprs(obj)
    e = obj.graphics.exprs;
    exprs = [];
    if typeof(e) == 'list' then
        for i = 1:size(e)
            exprs(i, 1) = string(e(i));
        end
    else
        exprs = matrix(string(e), -1, 1);
    end
    fn = sprintf("%s/scilab_library/scilab_blocks/casper_%s/%s.json", ...
                 getenv("MLIB_DEVEL_PATH"), get_block_type(obj), get_block_tag(obj));
    tpl = fromJSON(fn, 'file');
    vals = tpl('parameters')('values');
    if typeof(vals) == 'list' then
        nvals = size(vals);
    else
        nvals = size(vals, '*');
    end
    if size(exprs, '*') == nvals - 2 then
        debug_info('adding fullpath and tag to the exprs of ' + get_block_tag(obj));
        exprs = [exprs(1); string(vals(2)); string(vals(3)); exprs(2:$)];
    end
    // parameters added to the template later are appended at its end:
    // give them their default value
    for i = size(exprs, '*') + 1:nvals
        exprs(i, 1) = string(vals(i));
    end
endfunction
