/*
The block parameters are recoreded in obj.graphics.exprs.
*/
function [config] = gen_block_config(builddir, obj)
    bconfigdir = sprintf("%s/bconfigs", builddir);
    name = gen_block_name(bconfigdir, obj);
    bconfigfn = sprintf("%s/%s.json", bconfigdir, name);
    export_exprs(obj, bconfigfn);
    bconfig = fromJSON(bconfigfn, 'file');
    bconfig('parameters')('name') = name;
    projname = strsplit(builddir, '/')($);
    bconfig('parameters')('fullpath') = sprintf("%s/%s", projname, name);
    if get_block_type(obj) == 'xps' then
        bconfig('parameters') = xps_eval_params(bconfig('parameters'), get_block_tag(obj));
    end
    toJSON(bconfig, bconfigfn, 4);
    config = bconfig('parameters');
endfunction

/*
Write the xps block parameters the way MATLAB's gen_block_file.m does:
every 'edit' field of the Simulink mask is evaluated (eval_param.m) and
written with num2str, e.g. hex2dec('FF') -> 255, [1 2] -> "1  2",
'gpio' -> gpio. The keys to evaluate are listed in the "evaluate" array
of the block's template (casper_xps/<tag>.json); keys listed in
"frontend_only" are only used by the Scilab block itself and are not
passed to the toolflow.
A value that can't be evaluated is kept as typed.
*/
function [params] = xps_eval_params(params, tag)
    fn = sprintf("%s/scilab_library/scilab_blocks/casper_xps/%s.json", getenv("MLIB_DEVEL_PATH"), tag);
    tpl = fromJSON(fn, 'file');
    if isfield(tpl, 'evaluate') then
        keys = tpl('evaluate');
        for i = 1:size(keys, '*')
            k = keys(i);
            if isfield(params, k) then
                params(k) = xps_eval_value(string(params(k)));
            end
        end
    end
    if isfield(tpl, 'frontend_only') then
        keys = tpl('frontend_only');
        rest = struct();
        fields = fieldnames(params);
        for i = 1:size(fields, '*')
            if ~or(fields(i) == keys) then
                rest(fields(i)) = params(fields(i));
            end
        end
        params = rest;
    end
endfunction

/* evaluate one parameter string, see xps_eval_params */
function [s] = xps_eval_value(xps_eval_str__)
    s = xps_eval_str__;
    t = stripblanks(xps_eval_str__);
    /* a bare name (e.g. reg, gpio) is a string in this toolflow, not a
       variable reference */
    if t == '' | grep(t, '/^[A-Za-z_][A-Za-z0-9_]*$/', 'r') <> [] then
        return;
    end
    if execstr('xps_eval_val__ = ' + t + ';', 'errcatch', 'n') <> 0 then
        return;
    end
    v = xps_eval_val__;
    select typeof(v)
    case 'string' then
        /* only a quoted literal gives a string, as in MATLAB */
        if size(v, '*') == 1 & (strindex(t, ascii(39)) <> [] | strindex(t, ascii(34)) <> []) then
            s = v;
        end
    case 'boolean' then
        s = xps_num2str(bool2s(v));
    case 'constant' then
        if isreal(v) then
            s = xps_num2str(v);
        end
    end
endfunction

/* MATLAB num2str for a real scalar or vector */
function [s] = xps_num2str(x)
    if size(x, '*') == 0 then
        s = '';
        return;
    end
    if size(x, 1) > 1 & size(x, 2) > 1 then
        /* a matrix has no single-line form in jasper.per; keep the
           elements in MATLAB's (column) order */
        x = x(:);
    end
    x = matrix(x, 1, -1);
    neg = bool2s(or(x < 0));
    finite = x(~isinf(x) & ~isnan(x));
    if finite == [] then
        xmax = 0;
    else
        xmax = max(abs(finite));
    end
    if and(finite == round(finite)) then
        if xmax == 0 then
            d = 1;
        else
            d = floor(log10(xmax)) + 1;
        end
        if size(x, '*') == 1 then
            s = msprintf('%.0f', x);
        else
            s = msprintf('%' + string(d + 2 + neg) + '.0f', x');
        end
    else
        if xmax == 0 then
            nd = 0;
        else
            nd = floor(log10(xmax));
        end
        nd = min(max(nd + 5, 5), 16);
        if size(x, '*') == 1 then
            s = msprintf('%.' + string(nd) + 'g', x);
        else
            s = msprintf('%' + string(nd + 7 + neg) + '.' + string(nd) + 'g', x');
        end
    end
    s = stripblanks(strsubst(s, 'Nan', 'NaN'));
endfunction
