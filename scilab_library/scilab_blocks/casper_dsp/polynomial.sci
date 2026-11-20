// polynomial: Xcos block definition, PyQt6-mask pattern.
// Hand-written (not gen_sci_block.py) -- casper_library/polynomial_init.m
// has a genuinely two-level dynamic port topology (n_polys separate
// polynomials, each with its own degree+1 coefficient input ports and one
// result output), which gen_sci_block.py's single-scaling-factor "dynamic"
// mode can't express. Coefficient ports are named coef_<poly>_<k> here
// (0-based poly index, k = 0..degree) rather than the original MATLAB
// mask's a0/a1.../b0/b1... lettering, since that scheme runs out of
// letters past n_polys=26 and the numeric form scales to any n_polys.
function [x, y, typ] = polynomial(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = polynomial_update_ports(x, bconfig);
    case 'define' then
        tag = 'polynomial';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        [iports_index, iports_label] = polynomial_create_iports(1, 3, 8);
        model.in = iports_index;
        model.in2 = [1, 8, 8, 8, 8];
        [oports_index, oports_label] = polynomial_create_oports(1);
        model.out = oports_index;
        model.out2 = [1, 18];
        model.label = tag;
        x=standard_define([8.4 8.4],model,exprs,gr_i)
        x.graphics.in_label = iports_label;
        x.graphics.out_label = oports_label;
        x = init_exprs(x);
        x.graphics.style = polynomial_build_style(x.graphics.exprs(1));
        debug_info('polynomial block loaded...')
    end
endfunction

// fixed control ports (misc, x) followed by n_polys*(degree+1) coefficient
// ports coef_<poly>_<k>, 0-based poly then 0-based coefficient index k.
function [ports_index, ports_label] = polynomial_create_iports(n_polys, degree, bits_in)
    ports_label = ['misc', 'x'];
    ports_index = [1, 2];
    idx = 2;
    for poly = 0:(n_polys-1)
        for k = 0:degree
            idx = idx + 1;
            ports_label = [ports_label, 'coef_' + string(poly) + '_' + string(k)];
            ports_index = [ports_index, idx];
        end
    end
endfunction

// fixed control ports (misc_out, x_out) followed by n_polys result ports.
function [ports_index, ports_label] = polynomial_create_oports(n_polys)
    ports_label = ['misc_out', 'x_out'];
    ports_index = [1, 2];
    idx = 2;
    for poly = 0:(n_polys-1)
        idx = idx + 1;
        ports_label = [ports_label, 'result' + string(poly)];
        ports_index = [ports_index, idx];
    end
endfunction

function [x] = polynomial_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    n_polys = strtod(p('n_polys'));
    degree = strtod(p('degree'));
    bits_in = strtod(p('bits_in'));
    bits_out = strtod(p('bits_out'));

    [iports_index, iports_label] = polynomial_create_iports(n_polys, degree, bits_in);
    [oports_index, oports_label] = polynomial_create_oports(n_polys);
    evtin = [];
    evtout = [];
    io_in = [iports_index; iports_index];
    io_out = [oports_index; oports_index];
    io_in_type = ones(1, length(iports_index));
    io_out_type = ones(1, length(oports_index));
    [model, graphics, ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);

    // misc(1), x(bits_in), then (degree+1) coefficient ports per poly
    in2 = [1, bits_in];
    for poly = 0:(n_polys-1)
        for k = 0:degree
            in2 = [in2, bits_in];
        end
    end
    // misc_out(1), x_out(bits_in), then one result(bits_out) per poly
    out2 = [1, bits_in];
    for poly = 0:(n_polys-1)
        out2 = [out2, bits_out];
    end

    model.in = iports_index;
    model.in2 = in2;
    model.out = oports_index;
    model.out2 = out2;
    graphics.in_label = iports_label;
    graphics.out_label = oports_label;
    graphics.style = polynomial_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the fill color (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = polynomial_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
