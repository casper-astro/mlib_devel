// logical: Xcos block definition, PyQt6-mask pattern.
// Backend dsp_blocks/logical.py -> casper_dsp rtl/BasicModules/logical.sv
// (Xilinx Logical: bitwise AND/NAND/OR/NOR/XOR/XNOR of 'inputs' operands).
function [x, y, typ] = logical(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = logical_update_ports(x, bconfig);
    case 'define' then
        tag = 'logical';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // the template defaults (2 inputs of 8 bits, no enable port) give
        // inputs d0, d1 and output dout, see logical_in_ports
        model.in = [1, 2];
        model.in2 = [8, 8];
        model.out = [1];
        model.out2 = [8];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([6 6],model,exprs,gr_i)
        x.graphics.in_label = ['d0', 'd1'];
        x.graphics.out_label = ['dout'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = logical_build_style(x.graphics.exprs(1));
        debug_info('logical block loaded...')
    end
endfunction

function [style] = logical_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#BDCBE4;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// input ports in the Simulink order (logical.sv's [ports] note): d0..d{N-1}
// (n_bits_in wide, N = 'Number of inputs'), then en (1 bit) only with
// 'Provide enable port'. Same list and order as dsp_blocks/logical.py's
// in_ports(); the labels are the per-instance wrapper's port names.
function [labels, widths] = logical_in_ports(p)
    n_bits = strtod(p('n_bits_in'));
    ninputs = strtod(p('inputs'));
    labels = [];
    widths = [];
    for i = 0:ninputs-1
        labels = [labels, 'd' + string(i)];
        widths = [widths, n_bits];
    end
    if p('en') == 'on' then
        labels = [labels, 'en'];
        widths = [widths, 1];
    end
endfunction

function [x] = logical_update_ports(obj, bconfigfn)
    // the number of input ports follows 'inputs' and 'en', so set_io() is
    // needed (same approach as counter_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    [in_labels, in_widths] = logical_in_ports(p);
    iports_index = 1:size(in_labels, '*');
    oports_index = [1];
    io_in = [iports_index; iports_index];
    io_out = [oports_index; oports_index];
    [model, graphics, ok] = set_io(model, graphics, list(io_in', ones(iports_index)), ..
                                   list(io_out', ones(oports_index)), [], []);
    model.in = iports_index;
    model.in2 = in_widths;
    model.out = oports_index;
    model.out2 = [strtod(p('n_bits_in'))];
    graphics.in_label = in_labels;
    graphics.out_label = ['dout'];
    graphics.style = logical_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
