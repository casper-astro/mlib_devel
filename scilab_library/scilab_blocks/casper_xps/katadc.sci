// katadc: Xcos block definition, hand-written "anything else" port
// topology (per casper_xps_from_simulink/SKILL.md).
//
// Port list replicates the REAL xps_library/katadc_init.m algorithm,
// which delegates to the shared xps_library/adc_common.m helper (same
// one generic_adc/quadc/snap_adc use) with in/out/or_per_input fixed by
// the 'adc_interleave' checkbox (bits is always 8, or_support/
// sync_support/dv_support are always 'on', hardcoded -- not separate
// mask params for this block):
//   adc_interleave='off' (default): in=2, out=4, or_per_input=1.
//   adc_interleave='on':            in=1, out=8, or_per_input=2.
// Real OUTPORT names from adc_common.m are literally 'data{d}_{ds}' (the
// katadc-specific rename step afterward only renames an INTERNAL Xilinx
// Gateway In block to '..._user_data_i{n}'/'..._user_data_q{n}' for
// netlist readability -- that rename is invisible outside the subsystem
// and does NOT change the actual exposed outport name, confirmed by
// reading adc_common.m's reuse_block call for the outport directly:
// don't be misled by the i/q-looking gateway names into using them here).
// katadc adds 2 (interleaved) or 4 (non-interleaved) more real INPUTS on
// top of adc_common's own (en0/atten0, plus en1/atten1 when non-
// interleaved) -- no extra real outputs (its 'gain_value'/'gain_load'
// are internal Gateway Out bridges, never wired to a built-in/outport).
function [x, y, typ] = katadc(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = katadc_update_ports(x, bconfig);
    case 'define' then
        tag = 'katadc';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // matches katadc.json's own default adc_interleave=off (il=0):
        // IN(8): sim_data0,sim_data1,sim_sync,sim_data_valid,en0,atten0,en1,atten1
        // OUT(15): data0_0..data0_3,data1_0..data1_3,or0,or1,sync0..sync3,data_valid
        model.in = [1, 2, 3, 4, 5, 6, 7, 8];
        model.in2 = [8, 8, 1, 1, 1, 7, 1, 7];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
        model.out2 = [8, 8, 8, 8, 8, 8, 8, 8, 1, 1, 1, 1, 1, 1, 1];
        model.label = tag;
        x=standard_define([14.4 33.6],model,exprs,gr_i)
        x.graphics.in_label = ['sim_data0', 'sim_data1', 'sim_sync', 'sim_data_valid', 'en0', 'atten0', 'en1', 'atten1'];
        x.graphics.out_label = ['data0_0', 'data0_1', 'data0_2', 'data0_3', 'data1_0', 'data1_1', 'data1_2', 'data1_3', 'or0', 'or1', 'sync0', 'sync1', 'sync2', 'sync3', 'data_valid'];
        x = init_exprs(x);
        x.graphics.style = katadc_build_style(x.graphics.exprs(1));
        debug_info('katadc block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = katadc_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = katadc_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    bits = 8; // hardcoded in the real mask, not a katadc param
    if p('adc_interleave') == 'on' then
        il = 1; n_in = 1; n_out = 8; or_per_input = 2;
    else
        il = 0; n_in = 2; n_out = 4; or_per_input = 1;
    end

    in_label = []; in2 = [];
    out_label = []; out2 = [];

    for d = 0:n_in-1
        in_label = [in_label, sprintf('sim_data%d', d)];
        in2 = [in2, bits];
    end
    in_label = [in_label, 'sim_sync']; in2 = [in2, 1];
    in_label = [in_label, 'sim_data_valid']; in2 = [in2, 1];
    // katadc-specific inputs: en0/atten0 always; en1/atten1 only when
    // not interleaved (interleaved mode reuses en0/atten0 internally)
    in_label = [in_label, 'en0']; in2 = [in2, 1];
    in_label = [in_label, 'atten0']; in2 = [in2, 7];
    if il == 0 then
        in_label = [in_label, 'en1']; in2 = [in2, 1];
        in_label = [in_label, 'atten1']; in2 = [in2, 7];
    end

    for d = 0:n_in-1
        for ds = 0:n_out-1
            out_label = [out_label, sprintf('data%d_%d', d, ds)];
            out2 = [out2, bits];
        end
    end
    for d = 0:(n_in*or_per_input)-1
        out_label = [out_label, sprintf('or%d', d)];
        out2 = [out2, 1];
    end
    nsync = n_out / (2^il);
    for ds = 0:nsync-1
        out_label = [out_label, sprintf('sync%d', ds)];
        out2 = [out2, 1];
    end
    out_label = [out_label, 'data_valid']; out2 = [out2, 1];

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
    graphics.style = katadc_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
