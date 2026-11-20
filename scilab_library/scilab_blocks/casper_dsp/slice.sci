// slice: Xcos block definition, PyQt6-mask pattern (Xilinx Slice on
// casper_dsp/rtl/BasicModules/slice.v: din -> dout).
function [x, y, typ] = slice(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = slice_update_ports(x, bconfig);
    case 'define' then
        tag = 'slice';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // the template defaults: an 8-bit input, 'Upper Bit Location +
        // Width' with nbits = 1, bit1 = 0 relative to 'MSB of Input' (the MSB)
        model.in = [1];
        model.in2 = [8];
        model.out = [1];
        model.out2 = [1];
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
        x.graphics.style = slice_build_style(x.graphics.exprs(1));
        debug_info('slice block loaded...')
    end
endfunction

function [style] = slice_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#BDCBE4;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// absolute bit index (0 = LSB) of an offset relative to 'MSB of Input'
// (offset 0 = the MSB) or 'LSB of Input' (offset 0 = bit 0)
function [idx] = slice_bit_index(offset, base, n_bits_in)
    if convstr(base) == 'msb of input' then
        idx = n_bits_in - 1 + offset;
    else
        idx = offset;
    end
endfunction

// output width of the slice: nbits, except in 'Two Bit Locations' mode
// where it is top - bottom + 1. Same formulas as dsp_blocks/slice.py's
// bit_range() (the dialog rejects ranges outside the input).
function [w] = slice_out_width(p)
    if p('mode') == 'Two Bit Locations' then
        n_bits_in = strtod(p('n_bits_in'));
        top = slice_bit_index(strtod(p('bit1')), p('base1'), n_bits_in);
        bot = slice_bit_index(strtod(p('bit0')), p('base0'), n_bits_in);
        w = top - bot + 1;
    else
        w = strtod(p('nbits'));
    end
endfunction

function [x] = slice_update_ports(obj, bconfigfn)
    // always one input (din, n_bits_in wide) and one output (dout); only
    // the widths follow the parameters
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1];
    model.in2 = [strtod(p('n_bits_in'))];
    model.out = [1];
    model.out2 = [slice_out_width(p)];
    graphics.in_label = ['din'];
    graphics.out_label = ['dout'];
    graphics.style = slice_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
