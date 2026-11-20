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

/* build graphics.style for a given user-configurable block name, shown
   below the yellow fill. Strips ';' and '=' since those are mxGraph's
   own style-string delimiters -- an unescaped one would corrupt every
   key after it in the string, not just the label text. */
function [style] = vla_dts_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
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
