// adc16x250_8: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- adc16_init.m scales port count by a
// non-numeric-index letter scheme (chips 'a'..'h', 4 channels each) driven
// by the 'board_count' mask param (options "1"/"2"), which the generic
// dynamic-port generator can't express (it only knows plain numeric {i}
// substitution).
//
// Port list confirmed against xps_library/adc16_init.m directly: for
// board_count=1, chips a/b/c/d x channels 1-4 (16 channels); for
// board_count=2, chips a-h x channels 1-4 (32 channels). Each channel
// contributes one input '<chip><channel>_sim' (n_bits=8, confirmed in the
// init file's Gateway In block) and one output '<chip><channel>' (n_bits=8).
function [x, y, typ] = adc16x250_8(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = adc16x250_8_update_ports(x, bconfig);
    case 'define' then
        tag = 'adc16x250_8';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // default: board_count=1 -> chips a,b,c,d x channels 1-4 (16 channels)
        chips = ['a','b','c','d'];
        in_label = []; out_label = []; in = []; in2 = []; out = []; out2 = [];
        nport = 0;
        for c = 1:4
            for ch = 1:4
                nport = nport + 1;
                lbl = chips(c) + string(ch);
                in_label = [in_label, lbl + '_sim'];
                out_label = [out_label, lbl];
                in = [in, nport]; in2 = [in2, 8];
                out = [out, nport]; out2 = [out2, 8];
            end
        end
        model.in = in; model.in2 = in2;
        model.out = out; model.out2 = out2;
        model.label = tag;
        x=standard_define([6 27.6],model,exprs,gr_i)
        x.graphics.in_label = in_label;
        x.graphics.out_label = out_label;
        x = init_exprs(x);
        x.graphics.style = adc16x250_8_build_style(x.graphics.exprs(1));
        debug_info('adc16x250_8 block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = adc16x250_8_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = adc16x250_8_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    board_count = strtod(p('board_count'));

    all_chips = ['a','b','c','d','e','f','g','h'];
    nchips = 4 * board_count;

    in_label = []; out_label = []; in = []; in2 = []; out = []; out2 = [];
    nport = 0;
    for c = 1:nchips
        for ch = 1:4
            nport = nport + 1;
            lbl = all_chips(c) + string(ch);
            in_label = [in_label, lbl + '_sim'];
            out_label = [out_label, lbl];
            in = [in, nport]; in2 = [in2, 8];
            out = [out, nport]; out2 = [out2, 8];
        end
    end

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
    model.in = in; model.in2 = in2;
    model.out = out; model.out2 = out2;
    graphics.in_label = in_label;
    graphics.out_label = out_label;
    graphics.style = adc16x250_8_build_style(p('name'));
    graphics.exprs = exprs;
    x.graphics = graphics;
    x.model = model;
endfunction
