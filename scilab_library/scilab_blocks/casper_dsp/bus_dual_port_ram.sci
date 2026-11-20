// bus_dual_port_ram: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- casper_library's "Bus" family blocks pack
// several sub-signals into one physical port, with widths given as
// MATLAB vector-expression mask params (e.g. n_bits = "[8]"), so port
// widths here are computed as sum(vector) via bus_vec_width(), not a
// plain scalar parameter lookup. misci/misco ports that casper_library
// only includes conditionally (misc=='on') are always present here for
// simplicity -- leave unconnected in Xcos if unused.
function [x, y, typ] = bus_dual_port_ram(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = bus_dual_port_ram_update_ports(x, bconfig);
    case 'define' then
        tag = 'bus_dual_port_ram';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3, 4, 5, 6, 7, 8, 9];
        model.in2 = [10, 8, 1, 1, 10, 8, 1, 1, 1];
        model.out = [1, 2, 3, 4, 5];
        model.out2 = [8, 8, 1, 1, 1];
        model.label = tag;
        x=standard_define([14.4 14.4],model,exprs,gr_i)
        x.graphics.in_label = ['addra', 'dina', 'wea', 'ena', 'addrb', 'dinb', 'web', 'enb', 'misci'];
        x.graphics.out_label = ['A', 'B', 'dvalida', 'dvalidb', 'misco'];
        x = init_exprs(x);
        x.graphics.style = bus_dual_port_ram_build_style(x.graphics.exprs(1));
        debug_info('bus_dual_port_ram block loaded...')
    end
endfunction

function [x] = bus_dual_port_ram_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    model.in2 = [strtod(p('addra_width')), bus_vec_width(p('n_bits')), 1, 1, strtod(p('addrb_width')), bus_vec_width(p('n_bits')), 1, 1, 1];
    model.out = [1, 2, 3, 4, 5];
    model.out2 = [bus_vec_width(p('n_bits')), bus_vec_width(p('n_bits')), 1, 1, 1];
    graphics.in_label = ['addra', 'dina', 'wea', 'ena', 'addrb', 'dinb', 'web', 'enb', 'misci'];
    graphics.out_label = ['A', 'B', 'dvalida', 'dvalidb', 'misco'];
    graphics.style = bus_dual_port_ram_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the fill color (see displayedLabel). Strips ';'
   and '=' from the name since those are the mxGraph style string's own
   delimiter characters -- an unescaped one would corrupt every key after
   it in the style string, not just truncate the label. */
function [style] = bus_dual_port_ram_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
