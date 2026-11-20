// dcp: Xcos block definition, PyQt6-mask pattern. Hand-written zero-port
// .sci (per casper_xps_from_simulink/SKILL.md's "zero ports" case) --
// xps_library's Utilities-group "dcp" block has no _mask.m/_init.m at all
// and its masked SubSystem has an empty Ports=[] property with no nested
// System Ref, confirming it is a pure design-wide metadata marker (lets
// the toolflow backend splice in a pre-built .dcp checkpoint file) with
// no signal path whatsoever, same shape as every Platforms-group block.
function [x, y, typ] = dcp(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = dcp_refresh(x, bconfig);
    case 'define' then
        tag = 'dcp';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.label = tag;
        model.rpar = [];
        gr_i = [];
        exprs = [];
        x=standard_define([4.8 4.8],model,exprs,gr_i)
        x = init_exprs(x);
        x.graphics.style = dcp_build_style(x.graphics.exprs(1));
        debug_info('dcp block loaded...')
    end
endfunction

/* build graphics.style for a given user-configurable block name, shown
   below the yellow fill. Strips ';' and '=' since those are mxGraph's
   own style-string delimiters -- an unescaped one would corrupt every
   key after it in the string, not just the label text. */
function [style] = dcp_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = dcp_refresh(obj, bconfigfn)
    // zero-port block -- nothing to resize/rewire, just keep the fill
    // style consistent (mirrors every other casper_xps block's 'set' path).
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    graphics.style = dcp_build_style(p('name'));
    x.graphics = graphics;
endfunction
