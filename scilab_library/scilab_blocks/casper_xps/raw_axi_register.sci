// raw_axi_register: Xcos block definition, PyQt6-mask pattern,
// hand-written (not gen_sci_block.py). xps_library/raxi_init.m is
// structurally identical to swreg_init.m (same param list: io_dir/
// io_delay/init_val/sample_period/names/bitwidths/bin_pts/arith_types/
// sim_port/show_format; confirmed via direct diff -- only cosmetic/
// naming differences and one extra INIT_VAL codegen branch that doesn't
// affect port topology), and its internal subsystem has the same single
// "out_reg" Inport / "sim_out_reg" Outport shape as software_register's.
// So this mirrors swreg.sci's port-building logic exactly: a fixed 1 in/
// 1 out shape whose WIDTH is the total bitfield width (computed from
// names/bitwidths, not a single mask parameter -- gen_sci_block.py's
// "fixed" mode can't express a computed width like this), with in/out
// labels swapped depending on io_dir.
function [x, y, typ] = raw_axi_register(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = raw_axi_register_update_ports(x, bconfig);
    case 'define' then
        tag = 'raw_axi_register';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.label = tag;
        model.rpar = [];
        model.in = [1];
        model.in2 = [1];
        model.out = [1];
        model.out2 = [1];
        exprs = [];
        gr_i = [];
        x=standard_define([19.8 6.96],model,exprs,gr_i)
        x.graphics.in_label = ['sim_in'];
        x.graphics.out_label = ['user_data_out'];
        x = init_exprs(x);
        x.graphics.style = raw_axi_register_build_style(x.graphics.exprs(1));
        debug_info('raw_axi_register block loaded...')
    end
endfunction

/* build graphics.style for a given user-configurable block name, shown
   below the yellow fill. Strips ';' and '=' since those are mxGraph's
   own style-string delimiters -- an unescaped one would corrupt every
   key after it in the string, not just the label text. */
function [style] = raw_axi_register_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction


/* convert a list string, e.g. "[a, b]" or "8 24", to a column of strings --
   mirrors swreg_str_to_list exactly (defined as a separate function here
   since raw_axi_register.sci is loaded independently of swreg.sci). */
function [items] = raw_axi_register_str_to_list(s)
    s = string(s);
    seps = ['[', ']', ',', ';', ascii(39), ascii(34)];
    for i = 1:size(seps, '*')
        s = strsubst(s, seps(i), ' ');
    end
    items = tokens(s, ' ');
endfunction

/* total width of the bitfields -- same rule as bitfield_maskcheck.m in
   casper_library / swreg_total_width in swreg.sci: bitwidths can be one
   value shared by every field, or one value per field. */
function [width] = raw_axi_register_total_width(names, bitwidths)
    nfields = max(size(raw_axi_register_str_to_list(names), '*'), 1);
    widths = strtod(raw_axi_register_str_to_list(bitwidths));
    if size(widths, '*') == 0 then
        width = 1;
    elseif size(widths, '*') == 1 then
        width = widths * nfields;
    else
        width = sum(widths);
    end
endfunction

function [x] = raw_axi_register_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    io_dir = string(p('io_dir'));
    width = raw_axi_register_total_width(p('names'), p('bitwidths'));
    debug_info('raw_axi_register port width: ' + string(width));
    graphics = x.graphics;
    model = x.model;
    model.in = [1];
    model.in2 = [width];
    model.out = [1];
    model.out2 = [width];
    if io_dir == 'To Processor' then
        graphics.out_label = ['sim_out'];
        graphics.in_label = ['user_data_in'];
    else
        graphics.out_label = ['user_data_out'];
        graphics.in_label = ['sim_in'];
    end
    graphics.style = raw_axi_register_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
