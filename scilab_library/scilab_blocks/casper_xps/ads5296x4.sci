// ads5296x4: Xcos block definition, PyQt6-mask pattern. Hand-written (not
// gen_sci_block.py) -- ads5296x4_init.m scales port count by a
// letter-indexed chip scheme ('a'..'p', 4 channels each) driven by the
// 'board_count' mask param (1-4), PLUS 4 fixed control ports that aren't
// simple pre/post-repeat pairs (sync/rst/snapshot_trig are inputs with no
// matching output at all -- terminated internally in the real design;
// sim_sync_out/sync_out is one more in/out pair after the repeated group).
// None of this fits gen_sci_block.py's fixed-inputs-then-repeated dynamic
// template, so this is hand-written directly from xps_library/
// ads5296x4_init.m's real reuse_block calls.
//
// Port list: for board_count=N, chips a..(4*N-th letter) x channels 1-4
// (16*N channels), each contributing input '<chip><channel>_sim'
// (n_bits=10, confirmed in the init file) and output '<chip><channel>'
// (n_bits=10). Plus fixed inputs 'sync'(1)/'rst'(1)/'snapshot_trig'(1)
// (no matching outputs -- real mask terminates them internally) and one
// more input/output pair 'sim_sync_out'(1, boolean)/'sync_out'(1).
function [x, y, typ] = ads5296x4(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = ads5296x4_update_ports(x, bconfig);
    case 'define' then
        tag = 'ads5296x4';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // default: board_count=2 -> chips a-h x channels 1-4 (32 channels)
        // + sync/rst/snapshot_trig (in only) + sim_sync_out/sync_out
        chips = ['a','b','c','d','e','f','g','h'];
        in_label = []; out_label = []; in = []; in2 = []; out = []; out2 = [];
        nport = 0;
        for c = 1:8
            for ch = 1:4
                nport = nport + 1;
                lbl = chips(c) + string(ch);
                in_label = [in_label, lbl + '_sim'];
                out_label = [out_label, lbl];
                in = [in, nport]; in2 = [in2, 10];
                out = [out, nport]; out2 = [out2, 10];
            end
        end
        nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'sync'];
        nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'rst'];
        nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'snapshot_trig'];
        nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'sim_sync_out'];
        out = [out, length(out)+1]; out2 = [out2, 1]; out_label = [out_label, 'sync_out'];
        model.in = in; model.in2 = in2;
        model.out = out; model.out2 = out2;
        model.label = tag;
        x=standard_define([30 93.6],model,exprs,gr_i)
        x.graphics.in_label = in_label;
        x.graphics.out_label = out_label;
        x = init_exprs(x);
        x.graphics.style = ads5296x4_build_style(x.graphics.exprs(1));
        debug_info('ads5296x4 block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = ads5296x4_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = ads5296x4_update_ports(obj, bconfigfn)
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    board_count = strtod(p('board_count'));

    all_chips = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p'];
    nchips = 4 * board_count;

    in_label = []; out_label = []; in = []; in2 = []; out = []; out2 = [];
    nport = 0;
    for c = 1:nchips
        for ch = 1:4
            nport = nport + 1;
            lbl = all_chips(c) + string(ch);
            in_label = [in_label, lbl + '_sim'];
            out_label = [out_label, lbl];
            in = [in, nport]; in2 = [in2, 10];
            out = [out, nport]; out2 = [out2, 10];
        end
    end
    nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'sync'];
    nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'rst'];
    nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'snapshot_trig'];
    nport = nport + 1; in = [in, nport]; in2 = [in2, 1]; in_label = [in_label, 'sim_sync_out'];
    out = [out, length(out)+1]; out2 = [out2, 1]; out_label = [out_label, 'sync_out'];

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
    graphics.style = ads5296x4_build_style(p('name'));
    graphics.exprs = exprs;
    x.graphics = graphics;
    x.model = model;
endfunction
