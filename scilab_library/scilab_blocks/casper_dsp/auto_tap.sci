// auto_tap: Xcos block definition, PyQt6-mask pattern.
// Scaffolded by gen_sci_block.py (fixed topology), then hand-edited: port
// widths are computed from the mask parameters exactly as
// casper_dsp/rtl/Correlator/auto_tap.sv derives them, and the block style
// shows the user-editable name below the fill color (as pfb_fir_real.sci).
//
// Port names/order are the casper_library auto_tap block's own
// (casper_library_correlator.slx, system_1.xml Inport/Outport blocks):
//   in:  a_del a_ndel a_loop acc_in valid_in sync_in
//   out: a_del_out a_ndel_out a_end_out acc_out valid_out rst_out sync_out
// Widths:
//   a_*                     4*n_bits   (dual-pol complex [X.re X.im Y.re Y.im])
//   acc_in / acc_out        8*n_bits_out, n_bits_out = 2*n_bits+1+ceil(log2(acc_len))
//   all others              1
//
// HDL backend: casper_dsp/rtl/Correlator/auto_tap.sv, instantiated directly
// (no wrapper) by dsp_blocks/auto_tap.py.
function [x, y, typ] = auto_tap(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = auto_tap_update_ports(x, bconfig);
    case 'define' then
        tag = 'auto_tap';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // initial on-canvas widths, before the user ever opens the mask --
        // matches the JSON template's defaults (n_bits=4, acc_len=64)
        [in_w, out_w] = auto_tap_port_widths(4, 64);
        model.in = 1:size(in_w, '*');
        model.in2 = in_w;
        model.out = 1:size(out_w, '*');
        model.out2 = out_w;
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([10.8 13.2],model,exprs,gr_i)
        x.graphics.in_label = ['a_del', 'a_ndel', 'a_loop', 'acc_in', 'valid_in', 'sync_in'];
        x.graphics.out_label = ['a_del_out', 'a_ndel_out', 'a_end_out', 'acc_out', 'valid_out', 'rst_out', 'sync_out'];
        /* init exprs */
        x = init_exprs(x);
        x.graphics.style = auto_tap_build_style(x.graphics.exprs(1));
        debug_info('auto_tap block loaded...')
    end
endfunction

// ceil(log2(n)) for a positive integer n, in integer arithmetic (avoids
// floating-point log2 rounding; matches SystemVerilog $clog2)
function [b] = auto_tap_clog2(n)
    b = 0;
    while 2^b < n
        b = b + 1;
    end
endfunction

// port widths, in port order -- see the header comment
function [in_w, out_w] = auto_tap_port_widths(n_bits, acc_len)
    w_a = 4*n_bits;
    n_bits_out = 2*n_bits + 1 + auto_tap_clog2(acc_len);
    w_acc = 8*n_bits_out;
    in_w = [w_a, w_a, w_a, w_acc, 1, 1];
    out_w = [w_a, w_a, w_a, w_acc, 1, 1, 1];
endfunction

function [x] = auto_tap_update_ports(obj, bconfigfn)
    // fixed port count: only widths change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    n_bits = strtod(p('n_bits'));
    acc_len = strtod(p('acc_len'));
    [in_w, out_w] = auto_tap_port_widths(n_bits, acc_len);
    model.in = 1:size(in_w, '*');
    model.in2 = in_w;
    model.out = 1:size(out_w, '*');
    model.out2 = out_w;
    graphics.in_label = ['a_del', 'a_ndel', 'a_loop', 'acc_in', 'valid_in', 'sync_in'];
    graphics.out_label = ['a_del_out', 'a_ndel_out', 'a_end_out', 'acc_out', 'valid_out', 'rst_out', 'sync_out'];
    graphics.style = auto_tap_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, shown below the fill color (see displayedLabel). Strips ';' and
   '=' from the name since those are the mxGraph style string's own
   delimiter characters. */
function [style] = auto_tap_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
