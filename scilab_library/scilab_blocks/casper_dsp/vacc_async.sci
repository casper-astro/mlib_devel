// vacc_async: Xcos block definition, PyQt6-mask pattern.
// Port list confirmed against the real casper_library_accumulators.slx
// standalone model (SID 1212, Ports=[3,3]): its own top-level Inport/
// Outport blocks (system_1212.xml) are, in real port order,
// din/valid_in/new_acc in and dout/valid_out/sync_out out -- the
// previous best-effort [new_acc,valid_in,din]->[valid,dout] guess had the
// right port COUNT-ish shape but wrong input order/naming (valid was
// named plain "valid" instead of "valid_out") and was missing sync_out
// entirely. Same mask as simple_bram_vacc (reuses simple_bram_vacc_init
// verbatim: vec_len/arith_type/n_bits/bin_pt), so din/dout keep the
// existing n_bits-driven width; valid_in/valid_out/sync_out are 1-bit
// control lines.
function [x, y, typ] = vacc_async(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = vacc_async_update_ports(x, bconfig);
    case 'define' then
        tag = 'vacc_async';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3];
        model.in2 = [64, 1, 1];
        model.out = [1, 2, 3];
        model.out2 = [64, 1, 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([12 9.6],model,exprs,gr_i)
        x.graphics.in_label = ['din', 'valid_in', 'new_acc'];
        x.graphics.out_label = ['dout', 'valid_out', 'sync_out'];
        x = init_exprs(x);
        x.graphics.style = vacc_async_build_style(x.graphics.exprs(1));
        debug_info('vacc_async block loaded...')
    end
endfunction

function [x] = vacc_async_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2, 3];
    model.in2 = [strtod(p('n_bits')), 1, 1];
    model.out = [1, 2, 3];
    model.out2 = [strtod(p('n_bits')), 1, 1];
    graphics.in_label = ['din', 'valid_in', 'new_acc'];
    graphics.out_label = ['dout', 'valid_out', 'sync_out'];
    graphics.style = vacc_async_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

function [style] = vacc_async_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    // rounded / gradientColor / strokeWidth are set explicitly: Scilab
    // 2025.1 merges this style onto Xcos-style.xml's 'block' style, which
    // has rounded=1, gradientColor=white and strokeWidth=0.5.
    style = 'shape=rectangle;rounded=0;gradientColor=none;strokeWidth=1;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction
