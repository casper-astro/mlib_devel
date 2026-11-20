// inverter: Xcos block definition, PyQt6-mask pattern (reference design:
// counter.sci). Bitwise NOT after the Xilinx Inverter block, backed by
// hdl_sources/casper_dsp/rtl/BasicModules/inverter.sv (dsp_blocks/inverter.py).
function [x, y, typ] = inverter(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = inverter_update_ports(x, bconfig);
    case 'define' then
        tag = 'inverter';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // the template defaults (n_bits = 8, latency = 1, no enable port)
        // give a single din input, see inverter_in_ports
        model.in = [1];
        model.in2 = [8];
        model.out = [1];
        model.out2 = [8];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([6 6],model,exprs,gr_i)
        x.graphics.in_label = ['din'];
        x.graphics.out_label = ['dout'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = inverter_build_style(x.graphics.exprs(1));
        debug_info('inverter block loaded...')
    end
endfunction

function [style] = inverter_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#BDCBE4;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// input ports in the Simulink order (ip, en; inverter.sv's [ports] note):
// din (n_bits wide) always, en with 'Provide enable port' -- as in
// Simulink also with latency 0, where en has no effect (xlInverter.sgm).
// Same list and order as dsp_blocks/inverter.py's in_ports().
function [labels, widths] = inverter_in_ports(p)
    n_bits = strtod(p('n_bits'));
    labels = ['din'];
    widths = [n_bits];
    if p('en') == 'on' then
        labels = [labels, 'en'];
        widths = [widths, 1];
    end
endfunction

function [x] = inverter_update_ports(obj, bconfigfn)
    // the number of input ports follows the en option, so set_io() is
    // needed (same approach as counter_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    [in_labels, in_widths] = inverter_in_ports(p);
    iports_index = 1:size(in_labels, '*');
    oports_index = [1];
    io_in = [iports_index; iports_index];
    io_out = [oports_index; oports_index];
    [model, graphics, ok] = set_io(model, graphics, list(io_in', ones(iports_index)), ..
                                   list(io_out', ones(oports_index)), [], []);
    model.in = iports_index;
    model.in2 = in_widths;
    model.out = oports_index;
    model.out2 = [strtod(p('n_bits'))];
    graphics.in_label = in_labels;
    graphics.out_label = ['dout'];
    graphics.style = inverter_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
