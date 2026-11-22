// snapshot: Xcos block definition, PyQt6-mask pattern
// (casper_library_scopes snapshot on casper_dsp/rtl/Scopes/snapshot.sv, see
// dsp_blocks/snapshot.py). Ports as in Simulink: din (in_width bits, which
// Simulink inherits from the signal), we, trig -> arm_out. The ctrl /
// status registers and shared BRAM are not drawn: the frontend adds them
// (utils/embedded_yellow.py).
function [x, y, typ] = snapshot(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = snapshot_update_ports(x, bconfig);
    case 'define' then
        tag = 'snapshot';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        // the template default in_width = 32
        model.in = [1; 2; 3];
        model.in2 = [32; 1; 1];
        model.out = [1];
        model.out2 = [1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([9.6 18],model,exprs,gr_i)
        x.graphics.in_label = ['din', 'we', 'trig'];
        x.graphics.out_label = ['arm_out'];
        x = init_exprs(x);
        x.graphics.style = snapshot_build_style(x.graphics.exprs(1));
        debug_info('snapshot block loaded...')
    end
endfunction

function [x] = snapshot_update_ports(obj, bconfigfn)
    // fixed port count: only the din width changes, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1; 2; 3];
    model.in2 = [strtod(p('in_width')); 1; 1];
    model.out = [1];
    model.out2 = [1];
    graphics.in_label = ['din', 'we', 'trig'];
    graphics.out_label = ['arm_out'];
    graphics.style = snapshot_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction

function [style] = snapshot_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    style = 'shape=rectangle;fillColor=#90EE90;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction
