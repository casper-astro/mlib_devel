// cconv: Xcos block definition, PyQt6-mask pattern.
// Named cconv (not conv) to avoid shadowing Scilab's built-in
// conv() (polynomial/vector convolution) -- redefining it produces a
// "Warning: redefining function: conv" at every Scilab startup and
// shadows the real conv() for the rest of the session.
function [x, y, typ] = cconv(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = cconv_update_ports(x, bconfig);
    case 'define' then
        tag = 'cconv';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1];
        model.in2 = [8];
        model.out = [1];
        model.out2 = [8];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([8.4 4.8],model,exprs,gr_i)
        x.graphics.in_label = ['a'];
        x.graphics.out_label = ['b'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = cconv_build_style(x.graphics.exprs(1));
        debug_info('cconv block loaded...')
    end
endfunction

function [style] = cconv_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = cconv_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1];
    model.in2 = [8];
    model.out = [1];
    model.out2 = [8];
    graphics.in_label = ['a'];
    graphics.out_label = ['b'];
    graphics.style = cconv_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
