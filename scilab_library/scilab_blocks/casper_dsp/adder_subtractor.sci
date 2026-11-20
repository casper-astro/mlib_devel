// adder_subtractor: Xcos block definition, PyQt6-mask pattern.
// One lane of casper_library's bus_addsub, on
// casper_dsp/rtl/Bus/adder_subtractor.sv (backend dsp_blocks/adder_subtractor.py).
function [x, y, typ] = adder_subtractor(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = adder_subtractor_update_ports(x, bconfig);
    case 'define' then
        tag = 'adder_subtractor';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // the template defaults (a 8 bits, b 4 bits, misc off, async off,
        // 8-bit output) give a, b -> dout, see adder_subtractor_in_ports /
        // adder_subtractor_out_ports
        model.in = [1; 2];
        model.in2 = [8; 4];
        model.out = [1];
        model.out2 = [8];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([6 6],model,exprs,gr_i)
        x.graphics.in_label = ['a', 'b'];
        x.graphics.out_label = ['dout'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = adder_subtractor_build_style(x.graphics.exprs(1));
        debug_info('adder_subtractor block loaded...')
    end
endfunction

function [style] = adder_subtractor_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#BDCBE4;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// input ports: a (n_bits_a), b (n_bits_b), then only those whose option is
// on, in the Simulink order (adder_subtractor.sv's [ports] note): misci
// (misc_width bits) with 'misc support', en (1 bit) with 'asynchronous
// operation'. Same list and order as dsp_blocks/adder_subtractor.py's in_ports().
function [labels, widths] = adder_subtractor_in_ports(p)
    labels = ['a', 'b'];
    widths = [strtod(p('n_bits_a')), strtod(p('n_bits_b'))];
    if p('misc') == 'on' then
        labels = [labels, 'misci'];
        widths = [widths, strtod(p('misc_width'))];
    end
    if p('async_op') == 'on' then
        labels = [labels, 'en'];
        widths = [widths, 1];
    end
endfunction

// output ports: dout (n_bits_out), then misco (misc_width bits) with misc
// and dvalid (1 bit) with async. Same list and order as
// dsp_blocks/adder_subtractor.py's out_ports().
function [labels, widths] = adder_subtractor_out_ports(p)
    labels = ['dout'];
    widths = [strtod(p('n_bits_out'))];
    if p('misc') == 'on' then
        labels = [labels, 'misco'];
        widths = [widths, strtod(p('misc_width'))];
    end
    if p('async_op') == 'on' then
        labels = [labels, 'dvalid'];
        widths = [widths, 1];
    end
endfunction

function [x] = adder_subtractor_update_ports(obj, bconfigfn)
    // the number of ports follows the misc / async options, so set_io() is
    // needed (same approach as counter_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    [in_labels, in_widths] = adder_subtractor_in_ports(p);
    [out_labels, out_widths] = adder_subtractor_out_ports(p);
    iports_index = 1:size(in_labels, '*');
    oports_index = 1:size(out_labels, '*');
    io_in = [iports_index; iports_index];
    io_out = [oports_index; oports_index];
    [model, graphics, ok] = set_io(model, graphics, list(io_in', ones(iports_index)), ..
                                   list(io_out', ones(oports_index)), [], []);
    model.in = iports_index;
    model.in2 = in_widths;
    model.out = oports_index;
    model.out2 = out_widths;
    graphics.in_label = in_labels;
    graphics.out_label = out_labels;
    graphics.style = adder_subtractor_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
