// gpio_bidir: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- port list confirmed against the real
// xps_library/xps_models/IO/gpio_bidir.slx standalone model's own top-level
// Inport/Outport blocks (names + the block's own "Ports" attribute, which
// matches this count exactly), NOT a best-effort guess.
function [x, y, typ] = gpio_bidir(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = gpio_bidir_update_ports(x, bconfig);
    case 'define' then
        tag = 'gpio_bidir';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2];
        model.in2 = [4, 1];
        model.out = [1];
        model.out2 = [4];
        model.label = tag;
        x=standard_define([9.6 6],model,exprs,gr_i)
        x.graphics.in_label = ['din', 'in_not_out'];
        x.graphics.out_label = ['dout'];
        x = init_exprs(x);
        x.graphics.style = gpio_bidir_build_style(x.graphics.exprs(1));
        debug_info('gpio_bidir block loaded...')
    end
endfunction

function [style] = gpio_bidir_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = gpio_bidir_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2];
    model.in2 = [strtod(p('bitwidth')), 1];
    model.out = [1];
    model.out2 = [strtod(p('bitwidth'))];
    graphics.in_label = ['din', 'in_not_out'];
    graphics.out_label = ['dout'];
    graphics.style = gpio_bidir_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
