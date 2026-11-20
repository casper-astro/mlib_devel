// addr_bram_vacc: Xcos block definition, PyQt6-mask pattern.
// Port list confirmed against the real casper_library_accumulators.slx
// standalone model (SID 1, Ports=[2,3]): its own top-level Inport/Outport
// blocks (system_1.xml) are new_acc/din in, addr/dout/we out -- NOT the
// best-effort [new_acc,din]->[valid,dout] guess this file previously had
// (which was copy-pasted from the sibling simple_bram_vacc block; the two
// share the same mask/init script -- simple_bram_vacc_init -- but
// addr_bram_vacc exposes an extra bram address/write-enable pair that
// simple_bram_vacc does not). addr/we widths aren't mask parameters (the
// mask only exposes vec_len/arith_type/n_bits/bin_pt, same as
// simple_bram_vacc) so they're derived here: addr = ceil(log2(vec_len))
// (bram address bus for vec_len entries, same max(1, ceil(log2(...)))
// convention bus_mux.sci uses), we = 1 bit (write-enable strobe).
function [x, y, typ] = addr_bram_vacc(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = addr_bram_vacc_update_ports(x, bconfig);
    case 'define' then
        tag = 'addr_bram_vacc';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2];
        model.in2 = [1, 32];
        model.out = [1, 2, 3];
        model.out2 = [4, 32, 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([8.4 6],model,exprs,gr_i)
        x.graphics.in_label = ['new_acc', 'din'];
        x.graphics.out_label = ['addr', 'dout', 'we'];
        x = init_exprs(x);
        x.graphics.style = addr_bram_vacc_build_style(x.graphics.exprs(1));
        debug_info('addr_bram_vacc block loaded...')
    end
endfunction

function [x] = addr_bram_vacc_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    addr_width = max(1, ceil(log2(strtod(p('vec_len')))));
    model.in = [1, 2];
    model.in2 = [1, strtod(p('n_bits'))];
    model.out = [1, 2, 3];
    model.out2 = [addr_width, strtod(p('n_bits')), 1];
    graphics.in_label = ['new_acc', 'din'];
    graphics.out_label = ['addr', 'dout', 'we'];
    graphics.style = addr_bram_vacc_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the fill color (see displayedLabel). Strips ';'
   and '=' from the name since those are the mxGraph style string's own
   delimiter characters -- an unescaped one would corrupt every key after
   it in the style string, not just truncate the label. */
function [style] = addr_bram_vacc_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction
