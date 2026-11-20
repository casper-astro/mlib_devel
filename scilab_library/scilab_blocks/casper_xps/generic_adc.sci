// generic_adc: Xcos block definition, hand-written "anything else" port
// topology (per casper_xps_from_simulink/SKILL.md -- gen_sci_block.py's
// generator only supports a single scaling factor, not two independent
// ones plus several checkbox-gated extra port groups).
//
// Port list replicates the REAL xps_library algorithm: generic_adc_init.m
// delegates directly to the shared xps_library/adc_common.m helper (also
// used by katadc/quadc/snap_adc) with n_inputs/n_outputs/bits passed
// straight through from the mask. Real port shape, from adc_common.m:
//   - IN: sim_data{d} for d=0..n_inputs-1 (analog stimulus per input
//     channel), + sim_sync (1) if sync_support='on', +
//     sim_data_valid (1) if dv_support='on'.
//   - OUT: data{d}_{ds} for d=0..n_inputs-1, ds=0..n_outputs-1
//     (n_inputs*n_outputs total, width=bits each, 2's-complement
//     samples) -- real index name is reshuffled when interleaved='on'
//     (d_index = d*out+floor(ds/2)+(out/2)*mod(ds,2) instead of d*out+ds)
//     but the COUNT is unaffected by interleaving, only the naming; +
//     or{k} for k=0..n_inputs-1 (or_per_input=1, as adc_common is always
//     called with or_per_input=1 here) if or_support='on'; +
//     sync{ds} for ds=0..(n_outputs/2^il - 1) if sync_support='on'; +
//     data_valid (1) if dv_support='on'.
// NOTE: mask params 'in'/'out' collided with Python keywords in the GUI
// generator and were renamed to 'n_inputs'/'n_outputs' consistently in
// generic_adc.json/mask.py/this file.
function [x, y, typ] = generic_adc(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = generic_adc_update_ports(x, bconfig);
    case 'define' then
        tag = 'generic_adc';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // matches generic_adc.json's own defaults: n_inputs=1, n_outputs=4,
        // bits=8, interleaved=off, or_support=off, sync_support=on,
        // dv_support=off -- IN: sim_data0, sim_sync (2). OUT: data0_0..3
        // (4, width 8), sync0..3 (4, since il=0 -> out/1=4). No or/dv.
        model.in = [1, 2];
        model.in2 = [8, 1];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8];
        model.out2 = [8, 8, 8, 8, 1, 1, 1, 1];
        model.label = tag;
        x=standard_define([9.6 21.6],model,exprs,gr_i)
        x.graphics.in_label = ['sim_data0', 'sim_sync'];
        // real naming from generic_adc_update_ports's d_index formula
        // (d=0, ds=0..3, not interleaved -> d_index=ds), not "data0_0" etc.
        x.graphics.out_label = ['data0', 'data1', 'data2', 'data3', 'sync0', 'sync1', 'sync2', 'sync3'];
        x = init_exprs(x);
        x.graphics.style = generic_adc_build_style(x.graphics.exprs(1));
        debug_info('generic_adc block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = generic_adc_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = generic_adc_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    n_inputs = strtod(p('n_inputs'));
    n_outputs = strtod(p('n_outputs'));
    bits = strtod(p('bits'));
    interleaved = p('interleaved');
    or_support = p('or_support');
    sync_support = p('sync_support');
    dv_support = p('dv_support');
    if interleaved == 'on' then il = 1; else il = 0; end

    in_label = []; in2 = [];
    out_label = []; out2 = [];

    // sim_data{d}
    for d = 0:n_inputs-1
        in_label = [in_label, sprintf('sim_data%d', d)];
        in2 = [in2, bits];
    end
    if sync_support == 'on' then
        in_label = [in_label, 'sim_sync'];
        in2 = [in2, 1];
    end
    if dv_support == 'on' then
        in_label = [in_label, 'sim_data_valid'];
        in2 = [in2, 1];
    end

    // data{d}_{ds}
    for d = 0:n_inputs-1
        for ds = 0:n_outputs-1
            if il == 1 then
                d_index = d*n_outputs + floor(ds/2) + floor(n_outputs/2)*modulo(ds,2);
            else
                d_index = d*n_outputs + ds;
            end
            out_label = [out_label, sprintf('data%d', d_index)];
            out2 = [out2, bits];
        end
    end
    // or{k}, or_per_input = 1
    if or_support == 'on' then
        for d = 0:n_inputs-1
            out_label = [out_label, sprintf('or%d', d)];
            out2 = [out2, 1];
        end
    end
    // sync{ds}
    if sync_support == 'on' then
        nsync = n_outputs / (2^il);
        for ds = 0:nsync-1
            out_label = [out_label, sprintf('sync%d', ds)];
            out2 = [out2, 1];
        end
    end
    // data_valid
    if dv_support == 'on' then
        out_label = [out_label, 'data_valid'];
        out2 = [out2, 1];
    end

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
    graphics.style = generic_adc_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
