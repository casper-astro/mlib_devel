// xaui: Xcos block definition, PyQt6-mask pattern. Hand-written
// (not gen_sci_block.py) -- port list confirmed against the real
// xps_library/xps_models/IO/xaui.slx standalone model's own top-level
// Inport/Outport blocks (names + the block's own "Ports" attribute, which
// matches this count exactly), NOT a best-effort guess.
function [x, y, typ] = xaui(job, arg1, arg2)
    x=[];y=[];typ=[];
    select job
    case 'set' then
        x = arg1;
        export_exprs_to_tmpdir(x);
        bconfig = run_mask(x);
        x = update_exprs_from_tmpdir(x);
        x = xaui_update_ports(x, bconfig);
    case 'define' then
        tag = 'xaui';
        model = scicos_model();
        model.sim = list(tag, 4);
        model.blocktype = 'c';
        model.rpar = [];
        exprs = [];
        gr_i = [];
        model.in = [1, 2, 3, 4, 5];
        model.in2 = [1, 1, 8, 1, 1];
        model.out = [1, 2, 3, 4, 5, 6, 7];
        model.out2 = [8, 1, 1, 1, 1, 1, 1];
        model.label = tag;
        x=standard_define([16.8 20.4],model,exprs,gr_i)
        x.graphics.in_label = ['rx_get', 'rx_reset', 'tx_data', 'tx_outofband', 'tx_valid'];
        x.graphics.out_label = ['rx_data', 'rx_outofband', 'rx_empty', 'rx_valid', 'rx_linkdown', 'tx_full', 'rx_almost_full'];
        x = init_exprs(x);
        x.graphics.style = xaui_build_style(x.graphics.exprs(1));
        debug_info('xaui block loaded...')
    end
endfunction

/* build graphics.style for a given user-configurable block name, shown
   below the yellow fill. Strips ';' and '=' since those are mxGraph's
   own style-string delimiters -- an unescaped one would corrupt every
   key after it in the string, not just the label text. */
function [style] = xaui_build_style(name)
    name = strsubst(string(name), ';', '');
    name = strsubst(name, '=', '');
    style = 'shape=rectangle;fillColor=yellow;strokeColor=black;fontColor=black;fontSize=12;align=center;verticalAlign=top;verticalLabelPosition=bottom;noLabel=0;displayedLabel=' + name + ';whiteSpace=wrap;html=1;spacing=4;';
endfunction


function [x] = xaui_update_ports(obj, bconfigfn)
    x = obj;
    bconfig = fromJSON(bconfigfn, 'file');
    p = bconfig('parameters');
    graphics = x.graphics;
    model = x.model;
    model.in = [1, 2, 3, 4, 5];
    model.in2 = [1, 1, strtod(p('data_width')), 1, 1];
    model.out = [1, 2, 3, 4, 5, 6, 7];
    model.out2 = [strtod(p('data_width')), 1, 1, 1, 1, 1, 1];
    graphics.in_label = ['rx_get', 'rx_reset', 'tx_data', 'tx_outofband', 'tx_valid'];
    graphics.out_label = ['rx_data', 'rx_outofband', 'rx_empty', 'rx_valid', 'rx_linkdown', 'tx_full', 'rx_almost_full'];
    graphics.style = xaui_build_style(p('name'));
    x.graphics = graphics;
    x.model = model;
endfunction
