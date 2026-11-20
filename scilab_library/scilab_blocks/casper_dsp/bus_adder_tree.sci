// bus_adder_tree: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- dynamic port count (n_busses) plus computed
// bus width (sum of the n_bits vector), neither of which
// gen_sci_block.py's single-scaling-factor "dynamic" mode alone can
// express together. misci/misco (conditional on misc=='on' in
// casper_library) are always present here for simplicity.
function [x, y, typ] = bus_adder_tree(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = bus_adder_tree_update_ports(x, bconfig);
    case 'define' then
        tag = 'bus_adder_tree';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        [iports_index, iports_label] = bus_adder_tree_create_iports(3);
        model.in = iports_index;
        model.in2 = [8, 8, 8, 1];
        model.out = [1, 2];
        model.out2 = [8, 1];
        model.label = tag;
        x=standard_define([10.8 10.8],model,exprs,gr_i)
        x.graphics.in_label = iports_label;
        x.graphics.out_label = ['out', 'misco'];
        x = init_exprs(x);
        x.graphics.style = bus_adder_tree_build_style(x.graphics.exprs(1));
        debug_info('bus_adder_tree block loaded...')
    end
endfunction

// d0..d(n_busses-1), misci(1)
function [ports_index, ports_label] = bus_adder_tree_create_iports(n_busses)
    ports_label = [];
    ports_index = [];
    idx = 0;
    for i = 0:(n_busses-1)
        idx = idx + 1;
        ports_label = [ports_label, 'd' + string(i)];
        ports_index = [ports_index, idx];
    end
    idx = idx + 1;
    ports_label = [ports_label, 'misci'];
    ports_index = [ports_index, idx];
endfunction

function [x] = bus_adder_tree_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    n_busses = strtod(p('n_busses'));
    w = bus_vec_width(p('n_bits'));

    [iports_index, iports_label] = bus_adder_tree_create_iports(n_busses);
    evtin = [];
    evtout = [];
    io_in = [iports_index; iports_index];
    io_in_type = ones(1, length(iports_index));
    io_out = [[1,2]; [1,2]];
    io_out_type = ones(1, 2);
    [model, graphics, ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);

    in2 = [];
    for i = 1:n_busses
        in2 = [in2, w];
    end
    in2 = [in2, 1];

    model.in = iports_index;
    model.in2 = in2;
    model.out = [1, 2];
    model.out2 = [w, 1];
    graphics.in_label = iports_label;
    graphics.out_label = ['out', 'misco'];
    graphics.style = bus_adder_tree_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the fill color (see displayedLabel). Strips ';'
   and '=' from the name since those are the mxGraph style string's own
   delimiter characters -- an unescaped one would corrupt every key after
   it in the style string, not just truncate the label. */
function [style] = bus_adder_tree_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
