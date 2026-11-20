// x64_adc: Xcos block definition, PyQt6-mask pattern.
// Base port list (16 sim{n}/dout{n} channel pairs + sim_sync/adc_rst in +
// chan_sync out = 18 in/17 out) confirmed against the real standalone
// xps_library/xps_models/ADCs/x64_adc.slx's own Inport/Outport blocks and
// "Ports" attribute ([18, 17], spi='off' state). x64_adc_mask.m then
// conditionally ADDS two more inputs (sdata, spi_strb) when the 'spi'
// checkbox is 'on' -- hand-patched into <module>_update_ports below (via
// set_io(), not gen_sci_block.py's fixed-port shortcut, since port count
// now genuinely varies) since the generator can't express a
// checkbox-gated port count. sim{n}/dout{n} widths are a best-effort 8
// bits per the mask description ("digitized to 8 bit... numbers"); count
// and names are confirmed real, widths are not independently verified
// against hardware docs.
function [x, y, typ] = x64_adc(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = x64_adc_update_ports(x, bconfig);
    case 'define' then
        tag = 'x64_adc';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
        model.in2 = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1];
        model.out = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17];
        model.out2 = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1];
        // model.label doubles as the on-diagram display text (Scicos
        // aliases it with graphics.id); category is derived separately by
        // get_block_type.sci via file-probe, so this is free to be the name.
        model.label = tag;
        x=standard_define([15.6 46.8],model,exprs,gr_i)
        x.graphics.in_label = ['sim0', 'sim1', 'sim2', 'sim3', 'sim4', 'sim5', 'sim6', 'sim7', 'sim8', 'sim9', 'sim10', 'sim11', 'sim12', 'sim13', 'sim14', 'sim15', 'sim_sync', 'adc_rst'];
        x.graphics.out_label = ['dout0', 'dout1', 'dout2', 'dout3', 'dout4', 'dout5', 'dout6', 'dout7', 'dout8', 'dout9', 'dout10', 'dout11', 'dout12', 'dout13', 'dout14', 'dout15', 'chan_sync'];
        /* init exprs */
        x = init_exprs(x);
        x.graphics.style = x64_adc_build_style(x.graphics.exprs(1));
        debug_info('x64_adc block loaded...')
    end
endfunction

/* build the graphics.style string for a given user-configurable block
   name, showing it below the yellow fill (see displayedLabel). Strips
   ';' and '=' from the name since those are the mxGraph style string's
   own delimiter characters -- an unescaped one would corrupt every key
   after it in the style string, not just truncate the label. */
function [style] = x64_adc_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction

function [x] = x64_adc_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;

    in_label = ['sim0', 'sim1', 'sim2', 'sim3', 'sim4', 'sim5', 'sim6', 'sim7', 'sim8', 'sim9', 'sim10', 'sim11', 'sim12', 'sim13', 'sim14', 'sim15', 'sim_sync', 'adc_rst'];
    in2 = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1, 1];
    out_label = ['dout0', 'dout1', 'dout2', 'dout3', 'dout4', 'dout5', 'dout6', 'dout7', 'dout8', 'dout9', 'dout10', 'dout11', 'dout12', 'dout13', 'dout14', 'dout15', 'chan_sync'];
    out2 = [8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 1];

    // spi='on' adds two more inputs (sdata, spi_strb), per x64_adc_mask.m
    if p('spi') == 'on' then
        in_label = [in_label, 'sdata', 'spi_strb'];
        in2 = [in2, 8, 1];
    end

    in = 1:size(in_label, '*');
    out = 1:size(out_label, '*');
    evtin = [];
    evtout = [];
    io_in = [in;in];
    io_out = [out;out];
    io_in_type = ones(1, length(in));
    io_out_type = ones(1, length(out));
    [model,graphics,ok] = set_io(model, graphics, list(io_in', io_in_type), list(io_out', io_out_type), evtin, evtout);
    model.in = in;
    model.in2 = in2;
    model.out = out;
    model.out2 = out2;
    graphics.in_label = in_label;
    graphics.out_label = out_label;
    graphics.style = x64_adc_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
