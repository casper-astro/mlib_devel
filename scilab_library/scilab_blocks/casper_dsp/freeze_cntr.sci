// freeze_cntr: Xcos block definition, PyQt6-mask pattern.
// Port list confirmed against the real casper_library_misc.slx standalone
// model (SID 57, Ports=[2,3]): its own top-level Inport/Outport blocks
// (system_57.xml) are en/rst in, addr/we/done out (in that port order) --
// NOT the best-effort [en,rst]->[count] guess this file previously had.
// The mask exposes only "CounterBits" (json key counter_bits, an address
// bit-width, not a data width) which sizes addr; we/done are 1-bit
// strobes with no mask control, same as every other control/flag port in
// this library.
function [x, y, typ] = freeze_cntr(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = freeze_cntr_update_ports(x, bconfig);
    case 'define' then
        tag = 'freeze_cntr';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2];
        model.in2 = [1, 1];
        model.out = [1, 2, 3];
        model.out2 = [5, 1, 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([8.4 8.4],model,exprs,gr_i)
        x.graphics.in_label = ['en', 'rst'];
        x.graphics.out_label = ['addr', 'we', 'done'];
        // block name (shown below the fill color) comes from the
        // "name" JSON key -- init_exprs populates exprs from the
        // template first, so exprs(1) is its default value here
        x = init_exprs(x);
        x.graphics.style = freeze_cntr_build_style(x.graphics.exprs(1));
        debug_info('freeze_cntr block loaded...')
    end
endfunction

function [style] = freeze_cntr_build_style(name)
    // strip mxGraph's own style-string delimiters so a user-typed
    // name can never corrupt the rest of the style string
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = freeze_cntr_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2];
    model.in2 = [1, 1];
    model.out = [1, 2, 3];
    model.out2 = [strtod(p('counter_bits')), 1, 1];
    graphics.in_label = ['en', 'rst'];
    graphics.out_label = ['addr', 'we', 'done'];
    graphics.style = freeze_cntr_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
