// adc_sim: Xcos block definition, PyQt6-mask pattern. Hand-written (not
// gen_sci_block.py) -- adc_sim_init.m genuinely scales port count with a
// mask parameter (nStreams), and also puts the one fixed output ('of',
// the overflow flag from an internal of_detect_bus instance) AFTER the
// dynamic block instead of before it, which gen_sci_block.py's
// fixed-outputs-first dynamic template can't express.
//
// Port list confirmed against xps_library/adc_sim_init.m directly: 1
// fixed input 'sim_adc_data_in' (width=bit_width), nStreams dynamic
// outputs 's0'..'s{nStreams-1}' (width=bit_width each), then 1 fixed
// output 'of' (1-bit overflow flag, port number nStreams+1 in the real
// mask). Default nStreams=8/bit_width=8 matches this file's own
// 'define'-time default (1 in / 9 out).
function [x, y, typ] = adc_sim(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = adc_sim_update_ports(x, bconfig);
    case 'define' then
        tag = 'adc_sim';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1];
        model.in2 = [8];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9];
        model.out2 = [8, 8, 8, 8, 8, 8, 8, 8, 1];
        model.label = tag;
        x=standard_define([10.8 16.8],model,exprs,gr_i)
        x.graphics.in_label = ['sim_adc_data_in'];
        x.graphics.out_label = ['s0','s1','s2','s3','s4','s5','s6','s7','of'];
        x = init_exprs(x);
        x.graphics.style = adc_sim_build_style(x.graphics.exprs(1));
        debug_info('adc_sim block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = adc_sim_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = adc_sim_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    nStreams = strtod(p('nStreams'));
    bit_width = strtod(p('bit_width'));

    out_label = [];
    out = [];
    out2 = [];
    for k = 0:(nStreams-1)
        out = [out, k+1];
        out2 = [out2, bit_width];
        out_label = [out_label, sprintf('s%d', k)];
    end
    out = [out, nStreams+1];
    out2 = [out2, 1];
    out_label = [out_label, 'of'];

    in = [1];
    in2 = [bit_width];
    in_label = ['sim_adc_data_in'];

    x=obj;
    graphics = obj.graphics;
    exprs = graphics.exprs;
    model = obj.model;
    evtin = [];
    evtout = [];
    io_in = [in;in];
    io_out = [out;out];
    io_in_type = ones(1, length(in));
    io_out_type = ones(1, length(out));
    [model,graphics,ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);
    model.in = in;
    model.in2 = in2;
    model.out = out;
    model.out2 = out2;
    graphics.in_label = in_label;
    graphics.out_label = out_label;
    graphics.style = adc_sim_build_style(p('name'));
    graphics.exprs = exprs;
    x.graphics = graphics;
    x.model = model;
endfunction
