// vacc_tvg: Xcos block definition, PyQt6-mask pattern.
// Port list confirmed against the real casper_library_accumulators.slx
// standalone model (SID 1020, Ports=[4,3]): its own top-level Inport/
// Outport blocks (system_1020.xml) are tvg_sel/sync_in/data_in/valid_in
// in and sync_out/data_out/valid_out out -- NOT the best-effort 0-in
// guess this file previously had (real block has 4 inputs, not 0; the
// old 2 outputs new_acc/dout don't match either -- real outputs are
// sync_out/data_out/valid_out). WIDTH CAVEAT: the real mask exposes only
// "len" (Number of Vectors, not a data width) -- there is no mask
// parameter for data width at all. The existing n_bits JSON parameter
// (used below for data_in/data_out) is this port's own addition, not
// present in the real mask; it's kept as a reasonable user-facing default
// since the real block has no user control over this width otherwise.
// tvg_sel/sync_in/valid_in/sync_out/valid_out are 1-bit control lines,
// matching every other control/flag port in this library -- also
// unconfirmed against real signal widths, since Simulink port width here
// is only resolved at compile/propagation time, not stored statically in
// the mask XML.
function [x, y, typ] = vacc_tvg(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = vacc_tvg_update_ports(x, bconfig);
    case 'define' then
        tag = 'vacc_tvg';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3, 4];
        model.in2 = [1, 1, 32, 1];
        model.out = [1, 2, 3];
        model.out2 = [1, 32, 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([12 8.4],model,exprs,gr_i)
        x.graphics.in_label = ['tvg_sel', 'sync_in', 'data_in', 'valid_in'];
        x.graphics.out_label = ['sync_out', 'data_out', 'valid_out'];
        x = init_exprs(x);
        x.graphics.style = vacc_tvg_build_style(x.graphics.exprs(1));
        debug_info('vacc_tvg block loaded...')
    end
endfunction

function [x] = vacc_tvg_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2, 3, 4];
    model.in2 = [1, 1, strtod(p('n_bits')), 1];
    model.out = [1, 2, 3];
    model.out2 = [1, strtod(p('n_bits')), 1];
    graphics.in_label = ['tvg_sel', 'sync_in', 'data_in', 'valid_in'];
    graphics.out_label = ['sync_out', 'data_out', 'valid_out'];
    graphics.style = vacc_tvg_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

function [style] = vacc_tvg_build_style(name)
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
