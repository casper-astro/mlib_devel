// asiaa_adc5g: Xcos block definition, hand-written "anything else" port
// topology (per casper_xps_from_simulink/SKILL.md).
//
// Port list replicates the REAL xps_library/adc5g_init.m algorithm:
// 'input_mode' selects which of a fixed 16-sample name list
// ('user_data_i0'..'i7','q0'..'q7', renamed to the real outport
// names below) get built, not a simple integer scale:
//   'One-channel -- A'    -> inputs={'a'},     16 samples on 'a'
//   'One-channel -- C'    -> inputs={'c'},     16 samples on 'c'
//   'Two-channel -- A&C'  -> inputs={'a','c'}, 8 samples each
// (samples = 16 / length(inputs)). For each channel ch in inputs: one
// 'sim_{ch}' input (pre-gain/bias analog stimulus) and 'samples' real
// outports named '{ch}0'..'{ch}{samples-1}', width=adc_bit_width (the
// real Gateway In arith_type is Unsigned with n_bits=adc_bit_width).
// Plus one shared 'sim_sync' input and 'sync_out' output regardless of
// input_mode. NOTE: the mask's 'demux' parameter is read by the real
// init function but never actually used to affect port count/names --
// confirmed by direct inspection, not an omission here.
function [x, y, typ] = asiaa_adc5g(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = asiaa_adc5g_update_ports(x, bconfig);
    case 'define' then
        tag = 'asiaa_adc5g';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // matches asiaa_adc5g.json's own default input_mode='One-channel -- A'
        // (16 samples all on channel 'a'), adc_bit_width=4:
        // IN(2): sim_a, sim_sync. OUT(17): a0..a15, sync_out.
        model.in = [1, 2];
        model.in2 = [4, 1];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
        model.out2 = [4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1];
        model.label = tag;
        x=standard_define([18 38.4],model,exprs,gr_i)
        x.graphics.in_label = ['sim_a', 'sim_sync'];
        x.graphics.out_label = ['a0', 'a1', 'a2', 'a3', 'a4', 'a5', 'a6', 'a7', 'a8', 'a9', 'a10', 'a11', 'a12', 'a13', 'a14', 'a15', 'sync_out'];
        x = init_exprs(x);
        x.graphics.style = asiaa_adc5g_build_style(x.graphics.exprs(1));
        debug_info('asiaa_adc5g block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = asiaa_adc5g_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = asiaa_adc5g_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    adc_bit_width = strtod(p('adc_bit_width'));
    input_mode = p('input_mode');
    if input_mode == 'One-channel -- A' then
        inputs = ['a'];
    elseif input_mode == 'One-channel -- C' then
        inputs = ['c'];
    else
        inputs = ['a', 'c'];
    end
    samples = 16 / size(inputs, '*');

    in_label = []; in2 = [];
    out_label = []; out2 = [];
    for i = 1:size(inputs, '*')
        in_label = [in_label, 'sim_' + inputs(i)];
        in2 = [in2, adc_bit_width];
    end
    in_label = [in_label, 'sim_sync'];
    in2 = [in2, 1];

    for i = 1:size(inputs, '*')
        for j = 0:samples-1
            out_label = [out_label, inputs(i) + string(j)];
            out2 = [out2, adc_bit_width];
        end
    end
    out_label = [out_label, 'sync_out'];
    out2 = [out2, 1];

    x = obj;
    graphics = x.graphics;
    model = x.model;
    in = 1:size(in_label, '*');
    out = 1:size(out_label, '*');
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
    graphics.style = asiaa_adc5g_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
