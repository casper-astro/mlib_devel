// bus_mux: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- dynamic port count (n_inputs) plus computed
// bus widths (sum of the n_bits vector), neither of which
// gen_sci_block.py's single-scaling-factor "dynamic" mode alone can
// express together. misci/misco (conditional on misc=='on' in
// casper_library) are always present here for simplicity.
function [x, y, typ] = bus_mux(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = bus_mux_update_ports(x, bconfig);
    case 'define' then
        tag = 'bus_mux';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        [iports_index, iports_label] = bus_mux_create_iports(2);
        model.in = iports_index;
        model.in2 = [4, 8, 8, 1];
        model.out = [1, 2];
        model.out2 = [8, 1];
        model.label = tag;
        x=standard_define([10.8 10.8],model,exprs,gr_i)
        x.graphics.in_label = iports_label;
        x.graphics.out_label = ['out', 'misco'];
        x = init_exprs(x);
        x.graphics.style = bus_mux_build_style(x.graphics.exprs(1));
        debug_info('bus_mux block loaded...')
    end
endfunction

// sel(1), d0..d(n_inputs-1), misci(1)
function [ports_index, ports_label] = bus_mux_create_iports(n_inputs)
    ports_label = ['sel'];
    ports_index = [1];
    idx = 1;
    for i = 0:(n_inputs-1)
        idx = idx + 1;
        ports_label = [ports_label, 'd' + string(i)];
        ports_index = [ports_index, idx];
    end
    idx = idx + 1;
    ports_label = [ports_label, 'misci'];
    ports_index = [ports_index, idx];
endfunction

function [x] = bus_mux_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    n_inputs = strtod(p('n_inputs'));
    w = bus_vec_width(p('n_bits'));
    sel_width = max(1, ceil(log2(max(n_inputs, 2))));

    [iports_index, iports_label] = bus_mux_create_iports(n_inputs);
    evtin = [];
    evtout = [];
    io_in = [iports_index; iports_index];
    io_in_type = ones(1, length(iports_index));
    io_out = [[1,2]; [1,2]];
    io_out_type = ones(1, 2);
    [model, graphics, ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);

    in2 = [sel_width];
    for i = 1:n_inputs
        in2 = [in2, w];
    end
    in2 = [in2, 1];

    model.in = iports_index;
    model.in2 = in2;
    model.out = [1, 2];
    model.out2 = [w, 1];
    graphics.in_label = iports_label;
    graphics.out_label = ['out', 'misco'];
    graphics.style = bus_mux_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the fill color (see displayedLabel). Strips ';'
   and '=' from the name since those are the mxGraph style string's own
   delimiter characters -- an unescaped one would corrupt every key after
   it in the style string, not just truncate the label. */
function [style] = bus_mux_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
