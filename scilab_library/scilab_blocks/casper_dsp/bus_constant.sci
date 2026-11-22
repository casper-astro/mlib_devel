// bus_constant: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- casper_library's "Bus" family blocks pack
// several sub-signals into one physical port, with widths given as
// MATLAB vector-expression mask params (e.g. n_bits_a = "[8]"), so port
// widths here are computed as sum(vector) via bus_vec_width(), not a
// plain scalar parameter lookup. misci/misco/en/dvalid ports that
// casper_library only includes conditionally (misc=='on'/async=='on')
// are always present here for simplicity -- leave unconnected in Xcos
// if unused.
function [x, y, typ] = bus_constant(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = bus_constant_update_ports(x, bconfig);
    case 'define' then
        tag = 'bus_constant';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [];
        model.in2 = [];
        model.out = [1];
        model.out2 = [8];
        model.label = tag;
        x=standard_define([10.8 7.2],model,exprs,gr_i)
        x.graphics.in_label = [];
        x.graphics.out_label = ['dout'];
        x = init_exprs(x);
        x.graphics.style = bus_constant_build_style(x.graphics.exprs(1));
        debug_info('bus_constant block loaded...')
    end
endfunction

function [x] = bus_constant_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [];
    model.in2 = [];
    model.out = [1];
    model.out2 = [bus_vec_width(p('n_bits'))];
    graphics.in_label = [];
    graphics.out_label = ['dout'];
    graphics.style = bus_constant_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

function [style] = bus_constant_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction
