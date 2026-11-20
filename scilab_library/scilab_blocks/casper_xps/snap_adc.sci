// snap_adc: Xcos block definition, PyQt6-mask pattern.
// Port list (12 in / 12 out, 3 ADC chips x 4 channels) confirmed against
// the real xps_library adc_snap_init.m: it always builds exactly this
// shape regardless of the mask's own 'snap_inputs' parameter (3/6/12) --
// that parameter is read by the mask but never actually used to gate port
// count in the real init function, which is surprising but confirmed by
// direct inspection, not a port omission here. Port WIDTH is genuinely
// computed from 'adc_resolution': the real init does
// `if adc_resolution <= 8, outputwidth=8; else outputwidth=16; end` --
// patched in by hand below (gen_sci_block.py can't express a threshold
// check, only a literal width_key passthrough).
function [x, y, typ] = snap_adc(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = snap_adc_update_ports(x, bconfig);
    case 'define' then
        tag = 'snap_adc';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        model.in2 = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
        model.out2 = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([15.6 46.8],model,exprs,gr_i)
        x.graphics.in_label = ['a1_sim', 'a2_sim', 'a3_sim', 'a4_sim', 'b1_sim', 'b2_sim', 'b3_sim', 'b4_sim', 'c1_sim', 'c2_sim', 'c3_sim', 'c4_sim'];
        x.graphics.out_label = ['a1', 'a2', 'a3', 'a4', 'b1', 'b2', 'b3', 'b4', 'c1', 'c2', 'c3', 'c4'];
        /* init exprs */
        x = init_exprs(x);
        x.graphics.style = snap_adc_build_style(x.graphics.exprs(1));
        debug_info('snap_adc block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = snap_adc_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = snap_adc_update_ports(obj, bconfigfn)
    // fixed port count: only widths/labels change, no set_io() needed
    // (same approach as swreg_update_ports)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    adc_resolution = strtod(p('adc_resolution'));
    if adc_resolution <= 8 then
        width = 8;
    else
        width = 16;
    end
    model.in = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    model.in2 = width * ones(1, 12);
    model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    model.out2 = width * ones(1, 12);
    graphics.in_label = ['a1_sim', 'a2_sim', 'a3_sim', 'a4_sim', 'b1_sim', 'b2_sim', 'b3_sim', 'b4_sim', 'c1_sim', 'c2_sim', 'c3_sim', 'c4_sim'];
    graphics.out_label = ['a1', 'a2', 'a3', 'a4', 'b1', 'b2', 'b3', 'b4', 'c1', 'c2', 'c3', 'c4'];
    graphics.style = snap_adc_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
