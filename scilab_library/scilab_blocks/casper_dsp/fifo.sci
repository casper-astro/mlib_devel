// fifo: Xcos block definition, PyQt6-mask pattern (Xilinx FIFO block on
// casper_dsp/rtl/BasicModules/fifo.sv, see dsp_blocks/fifo.py).
function [x, y, typ] = fifo(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = fifo_update_ports(x, bconfig);
    case 'define' then
        tag = 'fifo';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // the template defaults (n_bits = 8, percent_nbits = 1, only the
        // percent full port on) give din, we, re -> dout, empty,
        // percent_full, full, see fifo_in_ports / fifo_out_ports
        model.in = [1; 2; 3];
        model.in2 = [8; 1; 1];
        model.out = [1; 2; 3; 4];
        model.out2 = [8; 1; 1; 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([6 8],model,exprs,gr_i)
        x.graphics.in_label = ['din', 'we', 're'];
        x.graphics.out_label = ['dout', 'empty', 'percent_full', 'full'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = fifo_build_style(x.graphics.exprs(1));
        debug_info('fifo block loaded...')
    end
endfunction

function [style] = fifo_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#BDCBE4;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// number of words of a depth listbox value ('16' .. '512', '1K' .. '4M')
function [words] = fifo_depth_words(depth)
    depth = stripblanks(string(depth));
    suffix = part(depth, length(depth));
    if suffix == 'K' then
        words = strtod(part(depth, 1:length(depth)-1)) * 1024;
    elseif suffix == 'M' then
        words = strtod(part(depth, 1:length(depth)-1)) * 1048576;
    else
        words = strtod(depth);
    end
endfunction

// input ports: din (n_bits wide), we, re, then rst with 'Provide reset
// port' and en with 'Provide enable port', in the Simulink order (fifo.sv's
// [ports] note). Same list and order as dsp_blocks/fifo.py's in_ports().
function [labels, widths] = fifo_in_ports(p)
    labels = ['din', 'we', 're'];
    widths = [strtod(p('n_bits')), 1, 1];
    if p('rst') == 'on' then
        labels = [labels, 'rst'];
        widths = [widths, 1];
    end
    if p('en') == 'on' then
        labels = [labels, 'en'];
        widths = [widths, 1];
    end
endfunction

// output ports: dout, empty, [percent_full], full, [dcount], [ae], [af],
// [rd_rst_busy], [wr_rst_busy] -- the optional ones only when their option
// is on, in the Simulink order (percent_full is Simulink's %full, an
// unsigned fraction carried as its raw percent_nbits bits; dcount has
// log2(depth) bits, one more in First Word Fall Through mode). Same list
// and order as dsp_blocks/fifo.py's out_ports().
function [labels, widths] = fifo_out_ports(p)
    labels = ['dout', 'empty'];
    widths = [strtod(p('n_bits')), 1];
    if p('use_percent_full_port') == 'on' then
        labels = [labels, 'percent_full'];
        widths = [widths, strtod(p('percent_nbits'))];
    end
    labels = [labels, 'full'];
    widths = [widths, 1];
    if p('use_dcount') == 'on' then
        dcount_width = round(log2(fifo_depth_words(p('depth'))));
        if p('performance_options') == 'First_Word_Fall_Through' then
            dcount_width = dcount_width + 1;
        end
        labels = [labels, 'dcount'];
        widths = [widths, dcount_width];
    end
    flags = ['use_almost_empty', 'use_almost_full', 'use_rd_rst_busy', 'use_wr_rst_busy'];
    names = ['ae', 'af', 'rd_rst_busy', 'wr_rst_busy'];
    for i = 1:size(flags, '*')
        if p(flags(i)) == 'on' then
            labels = [labels, names(i)];
            widths = [widths, 1];
        end
    end
endfunction

function [x] = fifo_update_ports(obj, bconfigfn)
    // the number of ports follows the options, so set_io() is needed
    // (same approach as counter_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    [in_labels, in_widths] = fifo_in_ports(p);
    [out_labels, out_widths] = fifo_out_ports(p);
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
    graphics.style = fifo_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
