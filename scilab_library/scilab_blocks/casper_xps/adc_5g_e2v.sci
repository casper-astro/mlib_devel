// adc_5g_e2v: Xcos block definition, PyQt6-mask pattern. Hand-written (not
// gen_sci_block.py) -- adc_5g_e2v_init.m scales port count by TWO
// independent mask params at once (chips_num: 1/2, and adc_mode:
// 1/2/4-Channel), with letter-indexed group names, none of which the
// generic single-factor dynamic generator can express.
//
// Port list confirmed against xps_library/adc_5g_e2v_init.m directly:
//   - 'inputs' (group letters) depends on adc_mode: 1-Channel -> {a},
//     2-Channel -> {a,c}, 4-Channel -> {a,b,c,d}.
//   - 'samples' = 16 / length(inputs), so every chip always contributes
//     exactly 16 real data channels total, however many groups/samples
//     that splits into (this is a real invariant in the source file:
//     samples = length(port_names)/length(inputs), where port_names is a
//     fixed 16-entry list).
//   - For chip n = 0..chips_num-1, group letter L, sample j = 0..samples-1:
//     input 'ch{n}_sim_{L}' (one per group, NOT per sample -- the same sim
//     input feeds all samples of its group through a shared gain/bias/
//     downsample chain) and output 'ch{n}_{L}{j}' (one per sample).
//     Data width is 10-bit (adc_bit_width=10, confirmed literally in the
//     init file).
//   - Plus 2 more fixed inputs (sim_sync, sim_ad_clk) and 2 more fixed
//     outputs (sync_out, ad_clk_out), all 1-bit.
function [x, y, typ] = adc_5g_e2v(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = adc_5g_e2v_update_ports(x, bconfig);
    case 'define' then
        tag = 'adc_5g_e2v';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // default: adc_mode='4-Channel' (letters a,b,c,d; samples=4),
        // chips_num=2
        [in_label, in2v, out_label, out2v] = adc_5g_e2v_build('4-Channel', 2);
        model.in = 1:size(in_label, '*');
        model.in2 = in2v;
        model.out = 1:size(out_label, '*');
        model.out2 = out2v;
        model.label = tag;
        x=standard_define([16.8 73.2],model,exprs,gr_i)
        x.graphics.in_label = in_label;
        x.graphics.out_label = out_label;
        x = init_exprs(x);
        x.graphics.style = adc_5g_e2v_build_style(x.graphics.exprs(1));
        debug_info('adc_5g_e2v block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = adc_5g_e2v_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

// Real group-letter list per adc_mode, from adc_5g_e2v_init.m.
function [letters] = adc_5g_e2v_letters(adc_mode)
    if adc_mode == '1-Channel' then
        letters = ['a'];
    elseif adc_mode == '2-Channel' then
        letters = ['a', 'c'];
    elseif adc_mode == '4-Channel' then
        letters = ['a', 'b', 'c', 'd'];
    else
        letters = ['a', 'b', 'c', 'd'];
    end
endfunction

// Build the full in/out label+width lists for a given (adc_mode, chips_num).
function [in_label, in2v, out_label, out2v] = adc_5g_e2v_build(adc_mode, chips_num)
    letters = adc_5g_e2v_letters(adc_mode);
    nletters = size(letters, '*');
    samples = 16 / nletters;

    in_label = []; in2v = [];
    out_label = []; out2v = [];
    for n = 0:(chips_num-1)
        for li = 1:nletters
            in_label = [in_label, 'ch' + string(n) + '_sim_' + letters(li)];
            in2v = [in2v, 10];
            for j = 0:(samples-1)
                out_label = [out_label, 'ch' + string(n) + '_' + letters(li) + string(j)];
                out2v = [out2v, 10];
            end
        end
    end
    in_label = [in_label, 'sim_sync', 'sim_ad_clk'];
    in2v = [in2v, 1, 1];
    out_label = [out_label, 'sync_out', 'ad_clk_out'];
    out2v = [out2v, 1, 1];
endfunction

function [x] = adc_5g_e2v_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    adc_mode = p('adc_mode');
    chips_num = strtod(p('chips_num'));

    [in_label, in2v, out_label, out2v] = adc_5g_e2v_build(adc_mode, chips_num);
    in = 1:size(in_label, '*');
    out = 1:size(out_label, '*');

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
    model.in = in; model.in2 = in2v;
    model.out = out; model.out2 = out2v;
    graphics.in_label = in_label;
    graphics.out_label = out_label;
    graphics.style = adc_5g_e2v_build_style(p('name'));
    graphics.exprs = exprs;
    x.graphics = graphics;
    x.model = model;
endfunction
