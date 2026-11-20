// qdr_vacc: Xcos block definition, PyQt6-mask pattern.
// Port list confirmed against the real casper_library_accumulators.slx
// standalone model (SID 589, Ports=[6,7]): its own top-level Inport/
// Outport blocks (system_589.xml) are, in real port order,
// n_acum/sync/data_in/oob_data_in/we/re in and
// new_acc(ASYNC)/data_out/oob_data_out/valid/error/RB_done/fifo_afull out
// -- NOT the best-effort 3-in/3-out [new_acc,din,oob_data_in]->
// [valid,dout,oob_dataout] guess this file previously had (missing
// sync/we/re inputs and error/RB_done/fifo_afull outputs entirely, and
// wrongly treating a single "new_acc" as a plain input rather than an
// input trigger (n_acum) paired with a separate async output
// acknowledgement (new_acc (ASYNC))). The mask exposes only vector_len (a
// display-only value, not a port width), so widths are taken from the
// block's own description: data type is Fix_32_0 (32-bit) for
// data_in/data_out, and oob_data_in/oob_data_out are the description's
// "extra 4 bits"; every other port here is a 1-bit control/status line,
// matching every other trigger/strobe/flag port in this library.
function [x, y, typ] = qdr_vacc(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = qdr_vacc_update_ports(x, bconfig);
    case 'define' then
        tag = 'qdr_vacc';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3, 4, 5, 6];
        model.in2 = [1, 1, 32, 4, 1, 1];
        model.out = [1, 2, 3, 4, 5, 6, 7];
        model.out2 = [1, 32, 4, 1, 1, 1, 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([18 18],model,exprs,gr_i)
        x.graphics.in_label = ['n_acum', 'sync', 'data_in', 'oob_data_in', 'we', 're'];
        x.graphics.out_label = ['new_acc_async', 'data_out', 'oob_data_out', 'valid', 'error', 'RB_done', 'fifo_afull'];
        x = init_exprs(x);
        x.graphics.style = qdr_vacc_build_style(x.graphics.exprs(1));
        debug_info('qdr_vacc block loaded...')
    end
endfunction

function [x] = qdr_vacc_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2, 3, 4, 5, 6];
    model.in2 = [1, 1, 32, 4, 1, 1];
    model.out = [1, 2, 3, 4, 5, 6, 7];
    model.out2 = [1, 32, 4, 1, 1, 1, 1];
    graphics.in_label = ['n_acum', 'sync', 'data_in', 'oob_data_in', 'we', 're'];
    graphics.out_label = ['new_acc_async', 'data_out', 'oob_data_out', 'valid', 'error', 'RB_done', 'fifo_afull'];
    graphics.style = qdr_vacc_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the fill color (see displayedLabel). Strips ';'
   and '=' from the name since those are the mxGraph style string's own
   delimiter characters -- an unescaped one would corrupt every key after
   it in the style string, not just truncate the label. */
function [style] = qdr_vacc_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
