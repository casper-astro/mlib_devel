// vla_dts: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- port list confirmed against the real
// xps_library/xps_models/IO/vla_dts.slx standalone model's own top-level
// Inport/Outport blocks (names + the block's own "Ports" attribute, which
// matches this count exactly), NOT a best-effort guess.
function [x, y, typ] = vla_dts(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = vla_dts_update_ports(x, bconfig);
    case 'define' then
        tag = 'vla_dts';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1];
        model.in2 = [1];
        model.out = [1, 2, 3, 4, 5, 6];
        model.out2 = [64, 8, 1, 1, 1, 1];
        model.label = tag;
        x=standard_define([18 37.2],model,exprs,gr_i)
        x.graphics.in_label = ['rst'];
        x.graphics.out_label = ['frame_out', 'index', 'one_sec', 'ten_sec', 'locked', 'sync'];
        x = init_exprs(x);
        x.graphics.style = vla_dts_build_style(x.graphics.exprs(1));
        debug_info('vla_dts block loaded...')
    end
endfunction

function [style] = vla_dts_build_style(name)
    // displayedLabel=%s: Xcos formats it with the block's exprs, and
    // exprs(1) is the block name, so the label follows the name whenever
    // exprs change -- Scilab 2025.1 does not seem to re-apply a style returned
    // by 'set', so a literal name in the style would stay stale there.
    // name is unused now; kept so the callers stay unchanged.
    // rounded / gradientColor / strokeWidth are set explicitly: Scilab
    // 2025.1 merges this style onto Xcos-style.xml's 'block' style, which
    // has rounded=1, gradientColor=white and strokeWidth=0.5.
    style = 'shape=rectangle;rounded=0;gradientColor=none;strokeWidth=1;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=%s;whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = vla_dts_update_ports(obj, bconfigfn)
    // port NAMES/COUNT are confirmed real (from vla_dts.slx); port WIDTHS are still a best-effort guess (frame_out uses the added data_width param, index/others default to 1/8 bits) -- verify against real VLA/DTS hardware docs.
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1];
    model.in2 = [1];
    model.out = [1, 2, 3, 4, 5, 6];
    model.out2 = [strtod(p('data_width')), 8, 1, 1, 1, 1];
    graphics.in_label = ['rst'];
    graphics.out_label = ['frame_out', 'index', 'one_sec', 'ten_sec', 'locked', 'sync'];
    graphics.style = vla_dts_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
