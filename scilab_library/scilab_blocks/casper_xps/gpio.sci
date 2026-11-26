// gpio: Xcos block definition, PyQt6-mask pattern. Hand-written (not
// gen_sci_block.py) -- xps_library/gpio_mask.m always builds exactly one
// input port and one output port (a real hardware-facing port plus a
// simulation-only stimulus/observation port), but WHICH port is the input
// and which is the output, and what each is named, depends on io_dir:
//   io_dir=='in':  in='sim_in'  (simulation stimulus), out='gpio_in'  (real pin value)
//   io_dir=='out': in='gpio_out' (value to drive),      out='sim_out' (simulation readback)
// gen_sci_block.py's "fixed" mode only emits static labels, so this can't
// be generated -- see gen_sci_block.py's docstring, "computed widths"/
// "anything else" escape hatch.
function [x, y, typ] = gpio(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = gpio_update_ports(x, bconfig);
    case 'define' then
        tag = 'gpio';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // default: io_dir=='out' (the mask's own default)
        model.in = [1];
        model.in2 = [1];
        model.out = [1];
        model.out2 = [1];
        model.label = tag;
        x=standard_define([10.8 3.6],model,exprs,gr_i)
        x.graphics.in_label = ['gpio_out'];
        x.graphics.out_label = ['sim_out'];
        x = init_exprs(x);
        x.graphics.style = gpio_build_style(x.graphics.exprs(1));
        debug_info('gpio block loaded...')
    end
endfunction

function [style] = gpio_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    // rounded / gradientColor / strokeWidth are set explicitly: Scilab
    // 2025.1 merges this style onto Xcos-style.xml's 'block' style, which
    // has rounded=1, gradientColor=white and strokeWidth=0.5.
    style = 'shape=rectangle;rounded=0;gradientColor=none;strokeWidth=1;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = gpio_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    bitwidth = strtod(p('bitwidth'));
    model.in = [1];
    model.in2 = [bitwidth];
    model.out = [1];
    model.out2 = [bitwidth];
    if p('io_dir') == 'in' then
        graphics.in_label = ['sim_in'];
        graphics.out_label = ['gpio_in'];
    else
        graphics.in_label = ['gpio_out'];
        graphics.out_label = ['sim_out'];
    end
    graphics.style = gpio_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
