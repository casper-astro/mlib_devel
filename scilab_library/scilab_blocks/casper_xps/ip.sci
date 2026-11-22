// ip: Xcos block definition, PyQt6-mask pattern. Hand-written zero-port
// .sci (per casper_xps_from_simulink/SKILL.md's "zero ports" case) --
// xps_library's Utilities-group "ip" block has no _mask.m/_init.m at all
// and its masked SubSystem has an empty Ports=[] property with no nested
// System Ref, confirming it is a pure design-wide metadata marker (lets
// the toolflow backend splice in a user-supplied prebuilt IP core) with
// no signal path whatsoever, same shape as every Platforms-group block.
function [x, y, typ] = ip(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = ip_refresh(x, bconfig);
    case 'define' then
        tag = 'ip';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.label = tag;
        model.rpar = [];
        gr_i = [];
        exprs = [];
        x=standard_define([4.8 4.8],model,exprs,gr_i)
        x = init_exprs(x);
        x.graphics.style = ip_build_style(x.graphics.exprs(1));
        debug_info('ip block loaded...')
    end
endfunction

function [style] = ip_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = ip_refresh(obj, bconfigfn)
    // zero-port block -- nothing to resize/rewire, just keep the fill
    // style consistent (mirrors every other casper_xps block's 'set' path).
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    graphics.style = ip_build_style(p('name'));
    x.graphics = graphics;
endfunction
