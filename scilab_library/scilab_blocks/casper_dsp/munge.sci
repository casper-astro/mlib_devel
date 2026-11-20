// munge: Xcos block definition, PyQt6-mask pattern (casper_library munge on
// casper_dsp/rtl/FlowControl/munge.sv, see dsp_blocks/munge.py).
function [x, y, typ] = munge(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = munge_update_ports(x, bconfig);
    case 'define' then
        tag = 'munge';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // the template defaults (4 divisions of [32 0 16 16] bits, order
        // [3 0 1 2]) give a 64-bit din and a 64-bit dout, see munge_widths
        model.in = [1];
        model.in2 = [64];
        model.out = [1];
        model.out2 = [64];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        // icon size [4 4] scaled directly from munge's own
        // casper_library icon (40x36 px) -- see SKILL.md Step 3b
        x=standard_define([4.8 4.8],model,exprs,gr_i)
        x.graphics.in_label = ['din'];
        x.graphics.out_label = ['dout'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = munge_build_style(x.graphics.exprs(1));
        debug_info('munge block loaded...')
    end
endfunction

function [style] = munge_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// MATLAB vector expression of a mask parameter ('[8 0 9 1]', '16*ones(1,16)',
// '0:15', '{3,2,1,0}') as a row vector; the dialog accepts only these forms
// (utils/matlab_vec.py), which Scilab evaluates the same way
function [v] = munge_vector(text)
    text = strsubst(strsubst(string(text), '{', '['), '}', ']');
    v = evstr(text);
    v = v(:)';
endfunction

// din / dout widths, as dsp_blocks/munge.py's munge_widths(): din is the sum
// of the division sizes (one size = every division that size), dout the sum
// of the sizes of the divisions order names (dout = din with one division)
function [din_width, dout_width] = munge_widths(p)
    divisions = strtod(p('divisions'));
    sizes = munge_vector(p('div_size'));
    if size(sizes, '*') == 1 then
        sizes = sizes * ones(1, divisions);
    end
    din_width = sum(sizes);
    if divisions == 1 then
        dout_width = din_width;
    else
        order = munge_vector(p('order'));
        dout_width = sum(sizes(order + 1));
    end
endfunction

function [x] = munge_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1];
    [din_width, dout_width] = munge_widths(p);
    model.in2 = [din_width];
    model.out = [1];
    model.out2 = [dout_width];
    graphics.in_label = ['din'];
    graphics.out_label = ['dout'];
    graphics.style = munge_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
