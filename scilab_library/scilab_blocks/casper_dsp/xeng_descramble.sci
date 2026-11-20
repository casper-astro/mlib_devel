// xeng_descramble: Xcos block definition, PyQt6-mask pattern.
// Scaffolded by gen_sci_block.py (fixed topology), then hand-edited: the
// acc / acc_out widths are computed from the mask parameters exactly as
// casper_dsp/rtl/Correlator/xeng_descramble.sv derives them:
//   W  = 2*n_bits + floor(log2(acc_len)) + 1   (= 2*N_BITS + $clog2(ACC_LEN+1))
//   P  = 2^ceil(log2(W))
//   acc     : 8*W bits
//   acc_out : OW = 8*P/demux_factor bits
// Port names/order are the casper_library subsystem's own (system_411):
//   in : acc, valid, sync, win_valid      out: acc_out, valid_out, sync_out
function [x, y, typ] = xeng_descramble(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = xeng_descramble_update_ports(x, bconfig);
    case 'define' then
        tag = 'xeng_descramble';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // initial widths from the JSON template's own defaults
        // (n_bits=4, acc_len=128, demux_factor=8)
        [acc_w, acc_out_w] = xeng_descramble_widths(4, 128, 8);
        model.in = [1, 2, 3, 4];
        model.in2 = [acc_w, 1, 1, 1];
        model.out = [1, 2, 3];
        model.out2 = [acc_out_w, 1, 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([10.8 6],model,exprs,gr_i)
        x.graphics.in_label = ['acc', 'valid', 'sync', 'win_valid'];
        x.graphics.out_label = ['acc_out', 'valid_out', 'sync_out'];
        /* init exprs */
        x = init_exprs(x);
        x.graphics.style = xeng_descramble_build_style(x.graphics.exprs(1));
        debug_info('xeng_descramble block loaded...')
    end
endfunction

// acc (8*W) and acc_out (8*P/demux_factor) widths, integer-exact
// (no floating log2): W = 2*n_bits + (number of bits of acc_len),
// P = smallest power of two >= W.
function [acc_w, acc_out_w] = xeng_descramble_widths(n_bits, acc_len, demux_factor)
    acc_len_bits = 0;
    v = acc_len;
    while v >= 1
        acc_len_bits = acc_len_bits + 1;
        v = floor(v / 2);
    end
    w = 2*n_bits + acc_len_bits;
    p = 1;
    while p < w
        p = 2*p;
    end
    acc_w = 8*w;
    acc_out_w = 8*p/demux_factor;
endfunction

function [x] = xeng_descramble_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    [acc_w, acc_out_w] = xeng_descramble_widths(strtod(p('n_bits')), strtod(p('acc_len')), strtod(p('demux_factor')));
    model.in = [1, 2, 3, 4];
    model.in2 = [acc_w, 1, 1, 1];
    model.out = [1, 2, 3];
    model.out2 = [acc_out_w, 1, 1];
    graphics.in_label = ['acc', 'valid', 'sync', 'win_valid'];
    graphics.out_label = ['acc_out', 'valid_out', 'sync_out'];
    graphics.style = xeng_descramble_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, shown below the fill color (see displayedLabel). Strips ';' and
   '=' from the name since those are the mxGraph style string's own
   delimiter characters. */
function [style] = xeng_descramble_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
