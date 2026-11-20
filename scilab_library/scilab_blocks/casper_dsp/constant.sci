// constant: Xcos block definition, PyQt6-mask pattern (Xilinx Constant,
// fixed-point part of the mask, on casper_dsp's constant.sv -- see
// dsp_blocks/constant.py for the quantization of 'const').
function [x, y, typ] = constant(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = constant_update_ports(x, bconfig);
    case 'define' then
        tag = 'constant';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // no inputs; one output 'out', n_bits wide (template default 16)
        model.in = [];
        model.in2 = [];
        model.out = [1];
        model.out2 = [16];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([6 6],model,exprs,gr_i)
        x.graphics.in_label = [];
        x.graphics.out_label = ['out'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = constant_build_style(x.graphics.exprs(1));
        debug_info('constant block loaded...')
    end
endfunction

function [style] = constant_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#BDCBE4;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = constant_update_ports(obj, bconfigfn)
    // the port topology never changes (no inputs, one output 'out' =
    // constant.sv's port); only the output width follows n_bits, as in
    // dsp_blocks/constant.py
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [];
    model.in2 = [];
    model.out = [1];
    model.out2 = [strtod(p('n_bits'))];
    graphics.in_label = [];
    graphics.out_label = ['out'];
    graphics.style = constant_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
